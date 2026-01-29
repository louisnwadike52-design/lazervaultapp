import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';

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
  }) async {
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
        await Get.toNamed(AppRoutes.transactionPinSetup);
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
          _showCancellationMessage(context);
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
            // PIN valid → transition to processing phase
            _pinModalKey.currentState?.setProcessing();

            // Execute the payment callback
            try {
              await onPinValidated(result.verificationToken!);
              return true;
            } catch (e) {
              _pinModalKey.currentState?.setFailed('Transfer failed: ${e.toString()}');
              await Future.delayed(const Duration(seconds: 2));
              if (mounted) {
                try { Navigator.of(context).pop(); } catch (_) {}
              }
              return false;
            }
          } else if (result.isLocked) {
            if (mounted) {
              try { Navigator.of(context).pop(); } catch (_) {}
            }
            _showPinLockedMessage(context, result.lockedUntil!);
            return false;
          } else {
            // Wrong PIN — reset to PIN entry inline
            currentAttempt++;
            errorMessage = result.message ?? 'Incorrect PIN';

            if (currentAttempt > maxAttempts) {
              if (mounted) {
                try { Navigator.of(context).pop(); } catch (_) {}
              }
              _showAttemptsExhaustedMessage(context);
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
            if (mounted) {
              try { Navigator.of(context).pop(); } catch (_) {}
            }
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
        _showErrorMessage(context, e.toString());
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

  /// Show payment execution error
  void _showPaymentError(BuildContext context, String error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Payment failed: $error'),
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
        );

        if (pin == null) {
          return null;
        }

        // Show loading inline
        final pinModalKey = GlobalKey<TransactionPinModalState>();
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
                    CircularProgressIndicator(),
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
