import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/transaction_pin/widgets/transaction_pin_modal.dart';

/// Mixin to easily add transaction PIN validation to any payment flow
///
/// Usage:
/// ```dart
/// class _MyPaymentScreenState extends State<MyPaymentScreen>
///     with TransactionPinMixin {
///   @override
///   Widget build(BuildContext context) {
///     // Your UI
///   }
///
///   Future<void> _processPayment() async {
///     final success = await validateTransactionPin(
///       context: context,
///       transactionId: 'txn_123',
///       transactionType: 'transfer',
///       amount: 100.0,
///       currency: 'USD',
///       onPinValidated: (token) async {
///         // Execute the actual payment with the token
///         await executePayment(token);
///       },
///     );
///
///     if (!success) {
///       // PIN validation failed or was cancelled
///     }
///   }
/// }
/// ```
mixin TransactionPinMixin<T extends StatefulWidget> on State<T> {
  /// Get the transaction PIN service (must be provided by the mixed-in class)
  ITransactionPinService get transactionPinService;

  /// Validate transaction PIN before executing a payment
  ///
  /// Returns true if PIN validation succeeded and callback was executed,
  /// false if validation failed, was cancelled, or PIN is locked.
  ///
  /// Handles all edge cases:
  /// - PIN not set up (prompts to create PIN)
  /// - Incorrect PIN with retry logic
  /// - PIN locked (shows lockout message)
  /// - Network errors
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
        // Prompt user to create PIN
        final shouldCreate = await _showCreatePinPrompt(context);
        if (!shouldCreate) return false;

        // Navigate to create PIN screen
        await Get.toNamed(AppRoutes.transactionPinSetup);

        // Check again if user created PIN
        final hasPinNow = await transactionPinService.checkUserHasPin();
        if (!hasPinNow) return false;

        // If PIN was created, continue with the validation flow
      }

      // Start PIN validation loop
      int currentAttempt = 1;
      String? errorMessage;

      while (currentAttempt <= maxAttempts) {
        // Show PIN modal
        final pin = await showTransactionPinModal(
          context,
          title: title,
          message: message,
          amount: amount,
          currency: currency,
          currencySymbol: currencySymbol,
          maxAttempts: maxAttempts,
          currentAttempt: currentAttempt,
          errorMessage: errorMessage,
          onForgotPin: () => Get.toNamed(AppRoutes.forgotPin),
        );

        // Check if user cancelled
        if (pin == null) {
          _showCancellationMessage(context);
          return false;
        }

        // Verify PIN
        final result = await _verifyPinWithLoading(
          context,
          pin: pin,
          transactionId: transactionId,
          transactionType: transactionType,
          amount: amount,
          currency: currency,
        );

        // Handle verification result
        if (result.success) {
          // PIN is valid, execute the payment callback
          try {
            await onPinValidated(result.verificationToken!);
            return true;
          } catch (e) {
            // Payment execution failed
            _showPaymentError(context, e.toString());
            return false;
          }
        } else if (result.isLocked) {
          // PIN is locked
          _showPinLockedMessage(context, result.lockedUntil!);
          return false;
        } else {
          // Incorrect PIN
          currentAttempt++;
          errorMessage = result.message ?? 'Incorrect PIN';

          // Check if attempts exhausted
          if (currentAttempt > maxAttempts) {
            _showAttemptsExhaustedMessage(context);
            return false;
          }
        }
      }

      return false;
    } catch (e) {
      // Unexpected error
      print('[TransactionPinMixin] Unexpected error: $e');
      if (mounted) {
        _showErrorMessage(context, e.toString());
      }
      return false;
    }
  }

  /// Verify PIN with loading indicator
  Future<TransactionPinVerificationResult> _verifyPinWithLoading(
    BuildContext context, {
    required String pin,
    required String transactionId,
    required String transactionType,
    required double amount,
    required String currency,
  }) async {
    // Show loading dialog
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

      // Close loading dialog
      if (!mounted) return TransactionPinVerificationResult(success: false, message: 'Widget disposed');
      Navigator.of(context).pop();

      return result;
    } catch (e) {
      // Close loading dialog
      if (mounted) Navigator.of(context).pop();
      rethrow;
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
  ///
  /// Use this when you just need to validate the PIN without executing a payment
  Future<TransactionPinVerificationResult?> validatePinOnly({
    required BuildContext context,
    required String transactionId,
    required String transactionType,
    required double amount,
    required String currency,
    int maxAttempts = 3,
  }) async {
    try {
      // Check if user has PIN set up
      final hasPin = await transactionPinService.checkUserHasPin();
      if (!hasPin) {
        _showErrorMessage(context, 'Please create a transaction PIN first');
        return null;
      }

      // Start PIN validation loop
      int currentAttempt = 1;
      String? errorMessage;

      while (currentAttempt <= maxAttempts) {
        // Show PIN modal
        final pin = await showTransactionPinModal(
          context,
          maxAttempts: maxAttempts,
          currentAttempt: currentAttempt,
          errorMessage: errorMessage,
        );

        // Check if user cancelled
        if (pin == null) {
          return null;
        }

        // Verify PIN
        final result = await _verifyPinWithLoading(
          context,
          pin: pin,
          transactionId: transactionId,
          transactionType: transactionType,
          amount: amount,
          currency: currency,
        );

        // Handle verification result
        if (result.success) {
          return result;
        } else if (result.isLocked) {
          _showPinLockedMessage(context, result.lockedUntil!);
          return result;
        } else {
          // Incorrect PIN
          currentAttempt++;
          errorMessage = result.message ?? 'Incorrect PIN';

          if (currentAttempt > maxAttempts) {
            _showAttemptsExhaustedMessage(context);
            return result;
          }
        }
      }

      return null;
    } catch (e) {
      _showErrorMessage(context, e.toString());
      return null;
    }
  }
}
