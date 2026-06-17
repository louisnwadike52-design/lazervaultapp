/// Edge case handling utilities for account actions and financial operations.
///
/// Provides validation functions and error handling patterns to ensure
/// consistent user experience and prevent runtime errors.
library;

import 'package:flutter/material.dart';

/// Validation result class
class ValidationResult {
  final bool isValid;
  final String? errorMessage;

  const ValidationResult({
    required this.isValid,
    this.errorMessage,
  });

  /// Creates a successful validation result
  const ValidationResult.success() : isValid = true, errorMessage = null;

  /// Creates a failed validation result
  const ValidationResult.failure(String message)
      : isValid = false,
        errorMessage = message;

  /// Returns a success result if condition is true, otherwise failure
  static ValidationResult fromCondition(
    bool condition,
    String errorMessage,
  ) {
    return condition ? const ValidationResult.success() : ValidationResult.failure(errorMessage);
  }
}

/// Account ID validation
class AccountIdValidator {
  /// Validates an account ID
  ///
  /// Returns ValidationResult with error details if invalid
  static ValidationResult validate(String? accountId) {
    if (accountId == null || accountId.trim().isEmpty) {
      return const ValidationResult.failure('Account ID is required');
    }

    final trimmed = accountId.trim();

    // Check if it's a valid UUID or numeric ID
    final isNumeric = RegExp(r'^[0-9]+$').hasMatch(trimmed);
    final isUUID = RegExp(r'^[0-9a-fA-F-]{36}$').hasMatch(trimmed);

    if (!isNumeric && !isUUID) {
      return const ValidationResult.failure(
        'Invalid account ID format. Please provide a valid account.',
      );
    }

    if (isNumeric && trimmed.length > 20) {
      return const ValidationResult.failure(
        'Account ID is too long. Please contact support if this issue persists.',
      );
    }

    return const ValidationResult.success();
  }

  /// Extracts account ID from accountArgs map safely
  static String? extractFromArgs(Map<String, dynamic>? args) {
    if (args == null) return null;

    final id = args['id']?.toString() ??
              args['uuid']?.toString() ??
              args['accountId']?.toString();

    if (id != null && id.isNotEmpty) {
      return id;
    }

    return null;
  }
}

/// Transaction PIN validation
class PinValidator {
  static const int pinLength = 4;

  /// Validates a transaction PIN
  ///
  /// Returns ValidationResult with error details if invalid
  static ValidationResult validate(String? pin) {
    if (pin == null || pin.trim().isEmpty) {
      return const ValidationResult.failure(
        'Please enter your 4-digit transaction PIN',
      );
    }

    final trimmed = pin.trim();

    if (trimmed.length != pinLength) {
      return ValidationResult.failure(
        'PIN must be exactly 4 digits. You provided ${trimmed.length} digit(s).',
      );
    }

    if (!RegExp(r'^\d{$pinLength}$').hasMatch(trimmed)) {
      return const ValidationResult.failure(
        'PIN must contain only digits (0-9).',
      );
    }

    // Check for common weak PINs
    final weakPins = ['0000', '1111', '2222', '3333', '4444', '5555', '6666', '7777', '8888', '9999', '1234'];
    if (weakPins.contains(trimmed)) {
      return const ValidationResult.failure(
        'For your security, please choose a stronger PIN that is not a repeated digit.',
      );
    }

    return const ValidationResult.success();
  }

  /// Checks if PIN format is valid (without checking for weak PINs)
  static ValidationResult validateFormat(String? pin) {
    if (pin == null || pin.trim().isEmpty) {
      return const ValidationResult.failure(
        'Please enter your 4-digit transaction PIN',
      );
    }

    final trimmed = pin.trim();

    if (trimmed.length != pinLength) {
      return ValidationResult.failure(
        'PIN must be exactly 4 digits. You provided ${trimmed.length} digit(s).',
      );
    }

    if (!RegExp(r'^\d+$').hasMatch(trimmed)) {
      return const ValidationResult.failure(
        'PIN must contain only digits (0-9).',
      );
    }

    return const ValidationResult.success();
  }
}

/// Amount validation for financial operations
class AmountValidator {
  static const double minAmount = 100.0; // Minimum amount in major units
  static const double maxAmount = 10000000.0; // Maximum amount
  static const double maxDailyLimit = 500000.0;
  static const double maxMonthlyLimit = 5000000.0;

  /// Validates an amount for a transaction or limit
  ///
  /// Returns ValidationResult with error details if invalid,
  /// and the parsed amount if valid
  static (ValidationResult, double?) validate(
    String? input, {
    String fieldName = 'Amount',
    double? minAmount,
    double? maxAmount,
    bool allowZero = false,
  }) {
    if (input == null || input.trim().isEmpty) {
      return (
        ValidationResult.failure('$fieldName is required'),
        null,
      );
    }

    final trimmed = input.trim();

    // Handle common input formats (commas, currency symbols, etc.)
    final cleanValue = trimmed
        .replaceAll(',', '')
        .replaceAll(RegExp(r'[₦$€£¥]'), '')
        .trim();

    final parsed = double.tryParse(cleanValue);

    if (parsed == null) {
      return (
        ValidationResult.failure(
          'Invalid $fieldName. Please enter a valid number.',
        ),
        null,
      );
    }

    final value = parsed;

    // Check for negative amounts
    if (value < 0) {
      return (
        ValidationResult.failure(
          '$fieldName cannot be negative.',
        ),
        null,
      );
    }

    // Check for zero if not allowed
    if (!allowZero && value == 0) {
      return (
        ValidationResult.failure(
          '$fieldName must be greater than zero.',
        ),
        null,
      );
    }

    // Check minimum
    final min = minAmount ?? AmountValidator.minAmount;
    if (value < min) {
      return (
        ValidationResult.failure(
          '$fieldName must be at least ${_formatAmount(min)}.',
        ),
        null,
      );
    }

    // Check maximum
    final max = maxAmount ?? AmountValidator.maxAmount;
    if (value > max) {
      return (
        ValidationResult.failure(
          '$fieldName cannot exceed ${_formatAmount(max)}.',
        ),
        null,
      );
    }

    return (ValidationResult.success(), value);
  }

  /// Validates a spending limit specifically
  static (ValidationResult, double?) validateSpendingLimit(
    String? input, {
    required String limitType,
  }) {
    double? maxLimit;
    String fieldName;

    switch (limitType.toLowerCase()) {
      case 'daily':
        maxLimit = maxDailyLimit;
        fieldName = 'Daily limit';
        break;
      case 'monthly':
        maxLimit = maxMonthlyLimit;
        fieldName = 'Monthly limit';
        break;
      case 'single':
        maxLimit = maxDailyLimit; // Single transaction limited to daily max
        fieldName = 'Single transaction limit';
        break;
      default:
        maxLimit = maxAmount;
        fieldName = 'Limit';
    }

    // Allow zero to remove limit
    return validate(
      input,
      fieldName: fieldName,
      minAmount: 0,
      maxAmount: maxLimit,
      allowZero: true,
    );
  }

  /// Formats an amount for display
  static String _formatAmount(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    }
    return amount.toStringAsFixed(2);
  }
}

/// Security settings validation
class SecuritySettingsValidator {
  /// Validates that at least one security setting is enabled
  static ValidationResult validateSettings({
    required bool enable3DSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
    required bool enableATMWithdrawals,
    }) {
    // If all are disabled, warn the user
    if (!enable3DSecure &&
        !enableContactless &&
        !enableOnlinePayments &&
        !enableATMWithdrawals) {
      return const ValidationResult.failure(
        'At least one payment method must be enabled for your card to function.',
      );
    }

    return const ValidationResult.success();
  }
}

/// Card status validation
class CardStatusValidator {
  /// Checks if an action can be performed based on card status
  static ValidationResult canPerformAction(
    String? status, {
    required String action,
  }) {
    if (status == null || status.trim().isEmpty) {
      return const ValidationResult.failure(
        'Unable to determine card status. Please try again.',
      );
    }

    final normalizedStatus = status.trim().toLowerCase();

    // Frozen/blocked cards have restrictions
    if (normalizedStatus == 'frozen' ||
        normalizedStatus == 'blocked' ||
        normalizedStatus.contains('block') ||
        normalizedStatus == 'temporarily blocked' ||
        normalizedStatus == 'permanently blocked') {
      if (action == 'freeze' || action == 'block') {
        return ValidationResult.failure(
          'Card is already ${status.trim()}.',
        );
      }
    }

    // Active cards cannot be unfrozen
    if (normalizedStatus == 'active') {
      if (action == 'unfreeze' || action == 'unblock') {
        return const ValidationResult.failure(
          'Card is already active.',
        );
      }
    }

    return const ValidationResult.success();
  }

  /// Gets user-friendly status message
  static String getStatusMessage(String? status) {
    if (status == null || status.trim().isEmpty) {
      return 'Unknown status';
    }

    switch (status.trim().toLowerCase()) {
      case 'active':
        return 'Your card is active and ready to use.';
      case 'frozen':
        return 'Your card is temporarily frozen. Unfreeze it to make transactions.';
      case 'blocked':
      case 'permanently blocked':
        return 'Your card is permanently blocked. Contact support for assistance.';
      case 'temporarily blocked':
        return 'Your card is temporarily blocked. You can unblock it anytime.';
      case 'expired':
        return 'Your card has expired. A new card will be sent to you.';
      default:
        return 'Card status: ${status.trim()}';
    }
  }
}

/// Currency validation
class CurrencyValidator {
  static const supportedCurrencies = {
    'NGN',
    'USD',
    'GBP',
    'EUR',
    'CAD',
    'JPY',
    'ZAR',
    'AUD',
    'INR',
  };

  /// Validates a currency code
  static ValidationResult validate(String? currency) {
    if (currency == null || currency.trim().isEmpty) {
      return const ValidationResult.failure('Currency is required');
    }

    final curr = currency.trim().toUpperCase();
    if (curr.length != 3) {
      return const ValidationResult.failure(
        'Invalid currency code. Use 3-letter codes like NGN, USD, EUR.',
      );
    }

    if (!supportedCurrencies.contains(curr)) {
      return ValidationResult.failure(
        'Currency "$curr" is not supported. Supported: ${supportedCurrencies.join(', ')}.',
      );
    }

    return const ValidationResult.success();
  }

  /// Gets currency symbol
  static String getSymbol(String? currency) {
    if (currency == null || currency.trim().isEmpty) {
      return '₦'; // Default
    }

    switch (currency.trim().toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'GBP':
        return '£';
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'CAD':
        return 'C\$';
      case 'JPY':
        return '¥';
      case 'ZAR':
        return 'R';
      case 'INR':
        return '₹';
      default:
        return '₦';
    }
  }
}

/// Date range validation for statements
class DateRangeValidator {
  /// Validates a date range for statement generation
  static ValidationResult validateRange(
    DateTime start,
    DateTime end, {
    int maxDaysBack = 365, // Maximum days back for statements
    int maxDaysAhead = 0, // No future dates allowed
  }) {
    if (start.isAfter(end)) {
      return const ValidationResult.failure(
        'Start date must be before end date.',
      );
    }

    final now = DateTime.now();
    final earliestAllowed = now.subtract(Duration(days: maxDaysBack));

    if (start.isBefore(earliestAllowed)) {
      return ValidationResult.failure(
        'Statements are only available for the past $maxDaysBack days. '
        'Please select a more recent start date.',
      );
    }

    if (end.isAfter(now.add(Duration(days: maxDaysAhead)))) {
      return const ValidationResult.failure(
        'End date cannot be in the future.',
      );
    }

    // Check if range is too large (more than 1 year)
    if (end.difference(start).inDays > 365) {
      return const ValidationResult.failure(
        'Date range cannot exceed 1 year. Please select a smaller range.',
      );
    }

    return const ValidationResult.success();
  }

  /// Returns user-friendly date range description
  static String getRangeDescription(DateTime start, DateTime end) {
    final days = end.difference(start).inDays;

    if (days <= 7) {
      return 'Past $days day${days == 1 ? '' : 's'}';
    } else if (days <= 30) {
      final weeks = (days / 7).round();
      return 'Past $weeks week${weeks == 1 ? '' : 's'}';
    } else if (days <= 365) {
      final months = (days / 30).round();
      return 'Past $months month${months == 1 ? '' : 's'}';
    } else {
      final years = (days / 365).round();
      return 'Past $years year${years == 1 ? '' : 's'}';
    }
  }
}

/// Network error handling utilities
class NetworkErrorHandler {
  /// Returns user-friendly error message based on error code
  static String getUserMessage(dynamic error, {String? operation}) {
    final op = operation ?? 'operation';

    if (error.toString().contains('UNAVAILABLE') ||
        error.toString().contains('DEADLINE_EXCEEDED')) {
      return 'Network error. Please check your connection and try again.';
    }

    if (error.toString().contains('UNAUTHENTICATED')) {
      return 'Your session has expired. Please log in again.';
    }

    if (error.toString().contains('PERMISSION_DENIED')) {
      return 'You don\'t have permission to perform this action.';
    }

    if (error.toString().contains('NOT_FOUND')) {
      return 'Account not found. Please refresh and try again.';
    }

    if (error.toString().contains('INVALID_ARGUMENT')) {
      return 'Invalid input. Please check your details and try again.';
    }

    if (error.toString().contains('ALREADY_EXISTS')) {
      return 'This action has already been completed.';
    }

    if (error.toString().contains('FAILED_PRECONDITION')) {
      return 'Unable to complete this action. The account may not be eligible.';
    }

    // Default error message
    return 'Failed to $op. Please try again later.';
  }

  /// Checks if error is retryable
  static bool isRetryable(dynamic error) {
    final errorStr = error.toString();

    return errorStr.contains('UNAVAILABLE') ||
        errorStr.contains('DEADLINE_EXCEEDED') ||
        errorStr.contains('INTERNAL') ||
        errorStr.contains('UNKNOWN');
  }
}

/// Dialog utilities for showing validation errors
class ValidationDialog {
  /// Shows a validation error dialog
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    String? details,
    VoidCallback? onRetry,
  }) {
    final actions = <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('OK'),
      ),
    ];

    if (onRetry != null) {
      actions.insert(
        0,
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onRetry();
          },
          child: const Text('Retry'),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 14,
              ),
            ),
            if (details != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.red.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  details!,
                  style: TextStyle(
                    color: Colors.red.withValues(alpha: 0.9),
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
        actions: actions,
      ),
    );
  }

  /// Shows confirmation dialog with validation
  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              cancelText,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmText,
              style: TextStyle(
                color: isDestructive
                    ? Colors.red
                    : Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
