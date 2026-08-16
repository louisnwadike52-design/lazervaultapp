import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Mixin to easily add transaction PIN validation to any payment flow.
///
/// All loading states (verifying PIN, processing transfer, success) are shown
/// inline within the PIN bottom sheet — no separate dialogs or overlay loaders.
mixin TransactionPinMixin<T extends StatefulWidget> on State<T> {
  /// Get the transaction PIN service (must be provided by the mixed-in class)
  ITransactionPinService get transactionPinService;

  /// GlobalKey to control the PIN modal state phases
  final GlobalKey<TransactionPinModalState> _pinModalKey =
      GlobalKey<TransactionPinModalState>();

  /// Expose the pin modal key so callers can drive processing/success phases
  GlobalKey<TransactionPinModalState> get pinModalKey => _pinModalKey;

  /// When the host that launched the PIN flow is ITSELF a modal popup route
  /// (e.g. the voice-agent bottom sheet), popping "every PopupRoute down to the
  /// page" would also tear down that host. Callers that must survive a cancel
  /// pass `preserveHostSheet: true` to [validateTransactionPin], which records
  /// their route here so [_dismissPaymentSheets] stops AT it — closing only the
  /// PIN sheet (+ any sub-sheets above the host), not the host itself.
  ModalRoute<dynamic>? _pinHostBoundaryRoute;

  /// Close the PIN sheet AND any payment sheets stacked beneath it (amount /
  /// confirmation / account-verified, etc.), returning the user cleanly to the
  /// underlying page. Pops every modal popup route (bottom sheets + dialogs)
  /// but stops at the first full-screen page route — OR at [_pinHostBoundaryRoute]
  /// when set, so a host bottom sheet (voice agent) is preserved.
  ///
  /// Used on every TERMINAL, NON-SUCCESS PIN outcome (cancel, wrong-PIN
  /// exhausted, locked, network failure, transfer failure) so a cancelled or
  /// failed transaction never leaves stranded sheets behind it. The success
  /// path is left to the caller, which navigates to the receipt via
  /// Get.offAllNamed (clearing the stack anyway).
  void _dismissPaymentSheets(BuildContext context) {
    if (!mounted) return;
    try {
      final boundary = _pinHostBoundaryRoute;
      Navigator.of(context).popUntil(
        (route) => (boundary != null && route == boundary) || route is! PopupRoute,
      );
    } catch (_) {}
  }

  /// Voice-flow PIN outcome hints, set on the LAST [validateTransactionPin] FAILURE so
  /// the voice agent can be told WHY it failed (locked / exhausted / cancelled) instead of
  /// a generic "cancelled" — which would make it offer a retry the server will reject on a
  /// locked/exhausted account. Chat callers simply ignore these fields. Reset at the start
  /// of each [validateTransactionPin] call. `lastPinFailureReason`:
  /// 'locked' | 'exhausted' | null (user cancelled / closed the sheet).
  String? lastPinFailureReason;
  int? lastPinRemainingAttempts;

  /// Validate transaction PIN and execute the payment callback.
  ///
  /// The PIN bottom sheet remains open throughout the entire flow:
  /// PIN entry → Verifying → onPinValidated callback → sheet stays open.
  /// The caller is responsible for calling [pinModalKey.currentState?.setProcessing()]
  /// and [pinModalKey.currentState?.setSuccess()] to advance phases,
  /// and then popping the sheet when ready to navigate.
  Future<bool> validateTransactionPin({
    required BuildContext context,
    required String transactionId,
    required String transactionType,
    required double amount,
    required String currency,
    required Future<void> Function(String verificationToken) onPinValidated,
    String? title,
    String? message,
    String? currencySymbol,
    double? fee,
    double? totalAmount,
    int maxAttempts = 3,
    bool showProcessingPhase = true,
    // Message shown on the processing sheet's success beat. Flows whose final
    // outcome is only known LATER (e.g. an external bank transfer that returns
    // `pending` and resolves on the receipt) should pass a non-committal
    // message like 'Transfer Initiated' so the sheet never claims success
    // before it's confirmed.
    String? successMessage,
    Widget? headerAction,
    // Optional recipient identity shown as an avatar + name header on the PIN
    // pad (chat-driven money moves pass these so the user sees WHO they're
    // paying while entering the PIN — reviewing them IS the confirmation).
    // Other callers omit them and the modal renders its default header.
    String? recipientImageUrl,
    String? recipientName,
    // Per-phase subtitle overrides so a non-transfer flow (e.g. a balance
    // refresh) doesn't read as "Your transfer is being processed".
    String? processingSubtitle,
    String? successSubtitle,
    // When the post-PIN action ([onPinValidated]) throws, the sheet shows a
    // FAILED state. By default the thrown error is run through [friendlyError]
    // with a transfer-shaped context. A non-transfer flow (e.g. a balance
    // refresh) can pass a builder to map its own error categories to friendly,
    // flow-specific copy ("Couldn’t refresh — please re-link your bank account.")
    // instead of a generic "We couldn’t complete your transfer" line.
    String Function(Object error)? failureMessageBuilder,
    // When the caller's own UI is a modal popup route that must OUTLIVE a
    // cancelled/failed PIN (e.g. the voice-agent bottom sheet), pass true. On a
    // terminal non-success outcome we then pop only down to the caller's route
    // instead of clearing every popup down to the page. Default false preserves
    // the existing "return to the page" behaviour for full-screen callers.
    bool preserveHostSheet = false,
  }) async {
    // Reset the voice-flow outcome hints for this attempt.
    lastPinFailureReason = null;
    lastPinRemainingAttempts = null;
    // Record the caller's route as the pop boundary (only when asked) so a
    // cancel closes the PIN sheet but not the host sheet. Captured BEFORE the
    // PIN sheet is pushed, so it resolves to the caller's route, not the sheet.
    _pinHostBoundaryRoute = preserveHostSheet ? ModalRoute.of(context) : null;
    try {
      // Check if user has PIN set up
      print('[TransactionPinMixin] Checking if user has PIN...');
      bool hasPin = false;
      try {
        hasPin = await transactionPinService.checkUserHasPin();
        print('[TransactionPinMixin] checkUserHasPin result: $hasPin');
      } catch (e) {
        print('[TransactionPinMixin] checkUserHasPin error: $e');
        if (!mounted) return false;
        _showErrorMessage(context, 'Failed to check PIN status. Please try again.');
        return false;
      }

      if (!hasPin) {
        final shouldCreate = await _showCreatePinPrompt(context);
        if (!shouldCreate) return false;
        // returnOnComplete → the setup screen POPS back here (instead of routing
        // forward to KYC/dashboard) so we can re-check the PIN and resume the
        // payment. Without this the transaction would be stranded on the stack.
        await Get.toNamed(AppRoutes.transactionPinSetup,
            arguments: {'returnOnComplete': true});
        final hasPinNow = await transactionPinService.checkUserHasPin();
        if (!hasPinNow) return false;
      }

      // Start PIN validation loop using a mutable completer reference
      // so the callback always resolves the current completer even after retries
      int currentAttempt = 1;
      String? errorMessage;
      final completerRef = _MutableRef<Completer<String?>>(Completer<String?>());

      // Show PIN modal once — stays open for all phases including retries
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (sheetContext) => TransactionPinModal(
          key: _pinModalKey,
          title: title,
          message: message,
          amount: amount,
          fee: fee,
          totalAmount: totalAmount,
          currency: currency,
          currencySymbol: currencySymbol,
          maxAttempts: maxAttempts,
          currentAttempt: currentAttempt,
          errorMessage: errorMessage,
          headerAction: headerAction,
          recipientImageUrl: recipientImageUrl,
          recipientName: recipientName,
          processingSubtitle: processingSubtitle,
          successSubtitle: successSubtitle,
          transactionType: transactionType,
          onPinSubmitted: (pin) {
            if (!completerRef.value.isCompleted) {
              completerRef.value.complete(pin);
            }
          },
          onForgotPin: () {
            if (!completerRef.value.isCompleted) {
              completerRef.value.complete(null);
            }
            Get.toNamed(AppRoutes.forgotPin);
          },
          onCancel: () {
            if (!completerRef.value.isCompleted) {
              completerRef.value.complete(null);
            }
          },
        ),
      );

      while (currentAttempt <= maxAttempts) {
        // Wait for PIN input
        final pin = await completerRef.value.future;

        if (pin == null) {
          // User cancelled (or chose Forgot PIN). The modal self-pops on the
          // cancel button; also unwind any sheets stacked beneath it so we
          // return cleanly to the page rather than stranding a confirmation /
          // amount sheet.
          _dismissPaymentSheets(context);
          _showCancellationMessage(context);
          AnalyticsService.instance.trackPinOutcome('cancelled');
          return false;
        }

        // Transition to verifying phase (inline in sheet)
        _pinModalKey.currentState?.setVerifying();

        // Verify PIN
        try {
          final result = await transactionPinService.verifyPin(
            pin: pin,
            transactionId: transactionId,
            transactionType: transactionType,
            amount: amount,
            currency: currency,
          );

          if (result.success) {
            // PIN valid → optionally show processing phase in modal
            if (showProcessingPhase) {
              _pinModalKey.currentState?.setProcessing();
            }

            // Execute the payment callback
            try {
              await onPinValidated(result.verificationToken!);

              // Only dismiss modal if it's still showing (callback may have navigated away)
              if (_pinModalKey.currentState != null) {
                _pinModalKey.currentState?.setSuccess(
                  message: showProcessingPhase
                      ? (successMessage ?? 'Transaction Successful!')
                      : 'PIN Verified',
                );
                // One short animation beat for the success check, then hand
                // off to the caller (usually a receipt screen) immediately.
                await Future.delayed(const Duration(milliseconds: 350));
                if (mounted) {
                  try { Navigator.of(context).pop(); } catch (_) {}
                }
              }
              AnalyticsService.instance.trackPinOutcome('success');
              return true;
            } catch (e) {
              // NEVER show raw e.toString() — a GrpcError stringifies to its
              // status code + cloudflare trailers. A flow-specific
              // [failureMessageBuilder] (e.g. balance refresh) maps the error to
              // its own friendly copy; otherwise friendlyError maps it to a
              // clean, user-facing line (passing through a clean backend
              // failed-precondition message when present).
              final failMsg = failureMessageBuilder != null
                  ? failureMessageBuilder(e)
                  : friendlyError(e, context: 'complete your transfer');
              if (_pinModalKey.currentState != null) {
                _pinModalKey.currentState?.setFailed(failMsg);
                await Future.delayed(const Duration(seconds: 2));
                // Transfer failed — close the PIN sheet and everything beneath
                // it so the user lands back on the page, not a stale sheet.
                _dismissPaymentSheets(context);
              } else {
                // The modal already detached (e.g. the callback navigated or
                // the sheet rebuilt) so we can't render the failure inline.
                // NEVER swallow the error — unwind any stranded sheets and
                // surface it as a SnackBar so the user always sees why the
                // transfer didn't go through, rather than a silent close.
                _dismissPaymentSheets(context);
                _showErrorMessage(context, failMsg);
              }
              AnalyticsService.instance.trackPinOutcome('failed');
              return false;
            }
          } else if (result.noPinSet) {
            // The PIN was cleared server-side (e.g. a super-admin reset it) while
            // the user was mid-session. This is NOT a wrong-PIN attempt — do not
            // burn an attempt or claim the PIN is locked. Close the sheet, send the
            // user to set up a fresh PIN, then ask them to re-confirm the payment.
            _dismissPaymentSheets(context);
            AnalyticsService.instance.trackPinOutcome('no_pin_set');
            if (!mounted) return false;
            final shouldCreate = await _showCreatePinPrompt(context);
            if (shouldCreate && mounted) {
              await Get.toNamed(AppRoutes.transactionPinSetup,
                  arguments: {'returnOnComplete': true, 'forceSetup': true});
              // Authoritative re-check (bypass the session cache).
              final hasPinNow =
                  await transactionPinService.checkUserHasPin(forceRefresh: true);
              if (hasPinNow && mounted) {
                _showErrorMessage(context,
                    'Your transaction PIN is set. Please confirm your payment again.');
              }
            }
            return false;
          } else if (result.isLocked) {
            _dismissPaymentSheets(context);
            _showPinLockedMessage(context, result.lockedUntil!);
            AnalyticsService.instance.trackPinOutcome('locked');
            // Tell the voice flow this was a LOCKOUT (not a plain cancel) so the agent
            // doesn't offer a retry the server will reject.
            lastPinFailureReason = 'locked';
            lastPinRemainingAttempts = 0;
            return false;
          } else {
            // Wrong PIN — reset to PIN entry inline
            currentAttempt++;
            errorMessage = result.message ?? 'Incorrect PIN';
            AnalyticsService.instance.trackPinOutcome('wrong_pin');

            if (currentAttempt > maxAttempts) {
              _dismissPaymentSheets(context);
              _showAttemptsExhaustedMessage(context);
              AnalyticsService.instance.trackPinOutcome('exhausted');
              lastPinFailureReason = 'exhausted';
              lastPinRemainingAttempts = 0;
              return false;
            }

            // Create a fresh completer for the next attempt
            completerRef.value = Completer<String?>();
            _pinModalKey.currentState?.resetToEntry(
              errorMessage: errorMessage,
              currentAttempt: currentAttempt,
            );
          }
        } catch (e) {
          // Network error — allow retry
          currentAttempt++;
          errorMessage = 'Verification failed. Please try again.';

          if (currentAttempt > maxAttempts) {
            _dismissPaymentSheets(context);
            _showAttemptsExhaustedMessage(context);
            return false;
          }

          completerRef.value = Completer<String?>();
          _pinModalKey.currentState?.resetToEntry(
            errorMessage: errorMessage,
            currentAttempt: currentAttempt,
          );
        }
      }

      return false;
    } catch (e) {
      print('[TransactionPinMixin] Unexpected error: $e');
      if (mounted) {
        _showErrorMessage(context, friendlyError(e));
      }
      return false;
    }
  }

  /// Show prompt to create PIN
  Future<bool> _showCreatePinPrompt(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transaction PIN Required'),
        content: const Text(
          'You need to create a transaction PIN before you can perform this action. '
          'Would you like to create one now?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Create PIN'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// Show message when user cancels PIN entry
  void _showCancellationMessage(BuildContext context) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaction cancelled'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Show message when PIN is locked
  void _showPinLockedMessage(BuildContext context, DateTime lockedUntil) {
    if (!mounted) return;
    final remainingTime = lockedUntil.difference(DateTime.now());
    final minutes = remainingTime.inMinutes;
    final seconds = remainingTime.inSeconds % 60;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.lock,
          color: Theme.of(context).colorScheme.error,
          size: 48,
        ),
        title: const Text('PIN Locked'),
        content: Text(
          'Your transaction PIN has been locked due to too many failed attempts. '
          'Please try again in $minutes minute${minutes == 1 ? "" : "s"} '
          'and $seconds second${seconds == 1 ? "" : "s"}.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.toNamed(AppRoutes.forgotPin);
            },
            child: const Text('Forgot PIN?'),
          ),
        ],
      ),
    );
  }

  /// Show message when attempts are exhausted
  void _showAttemptsExhaustedMessage(BuildContext context) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.error_outline,
          color: Theme.of(context).colorScheme.error,
          size: 48,
        ),
        title: const Text('Too Many Attempts'),
        content: const Text(
          'You have exceeded the maximum number of PIN attempts. '
          'For your security, your PIN has been locked. '
          'Please contact support or use the forgot PIN option.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.toNamed(AppRoutes.forgotPin);
            },
            child: const Text('Forgot PIN?'),
          ),
        ],
      ),
    );
  }

  /// Show error message
  void _showErrorMessage(BuildContext context, String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Validate PIN (simplified version without payment execution)
  Future<TransactionPinVerificationResult?> validatePinOnly({
    required BuildContext context,
    required String transactionId,
    required String transactionType,
    required double amount,
    required String currency,
    int maxAttempts = 3,
  }) async {
    try {
      final hasPin = await transactionPinService.checkUserHasPin();
      if (!hasPin) {
        _showErrorMessage(context, 'Please create a transaction PIN first');
        return null;
      }

      int currentAttempt = 1;
      String? errorMessage;

      while (currentAttempt <= maxAttempts) {
        final pin = await showTransactionPinModal(
          context,
          maxAttempts: maxAttempts,
          currentAttempt: currentAttempt,
          errorMessage: errorMessage,
          onForgotPin: () => Get.toNamed(AppRoutes.forgotPin),
        );

        if (pin == null) {
          return null;
        }

        // For validatePinOnly, use the simple loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LazerVaultLoader.small(),
                    SizedBox(height: 16),
                    Text('Verifying PIN...'),
                  ],
                ),
              ),
            ),
          ),
        );

        try {
          final result = await transactionPinService.verifyPin(
            pin: pin,
            transactionId: transactionId,
            transactionType: transactionType,
            amount: amount,
            currency: currency,
          );

          if (mounted) Navigator.of(context).pop();

          if (result.success) {
            return result;
          } else if (result.isLocked) {
            _showPinLockedMessage(context, result.lockedUntil!);
            return result;
          } else {
            currentAttempt++;
            errorMessage = result.message ?? 'Incorrect PIN';
            if (currentAttempt > maxAttempts) {
              _showAttemptsExhaustedMessage(context);
              return result;
            }
          }
        } catch (e) {
          if (mounted) Navigator.of(context).pop();
          rethrow;
        }
      }

      return null;
    } catch (e) {
      _showErrorMessage(context, e.toString());
      return null;
    }
  }
}

/// Simple mutable reference wrapper so closures can share a changing value
class _MutableRef<T> {
  T value;
  _MutableRef(this.value);
}
