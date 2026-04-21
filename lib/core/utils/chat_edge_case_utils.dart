/// Comprehensive edge case handling utilities for Flutter chat UI.
///
/// Provides utilities for:
/// - Empty/null response handling
/// - Loading state management
/// - Error state display
/// - Text formatting and sanitization
/// - Network error handling
/// - Display safety checks

library;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// ========================================================================
/// EMPTY/NULL VALUE HANDLING
/// ========================================================================

/// Safely get value from map with nested key support
String safeGet(Map<String, dynamic>? data, String key, {String defaultValue = ""}) {
  if (data == null || data.isEmpty) return defaultValue;

  final keys = key.split('.');
  dynamic current = data;

  for (final k in keys) {
    if (current is Map && current.containsKey(k)) {
      current = current[k];
    } else {
      return defaultValue;
    }
  }

  if (current == null) return defaultValue;
  if (current is String && current.trim().isEmpty) return defaultValue;

  return current.toString();
}

/// Safely get item from list with bounds checking
T? safeListGet<T>(List<T>? data, int index, {T? defaultValue}) {
  if (data == null || data.isEmpty) return defaultValue;

  if (index >= 0 && index < data.length) {
    return data[index];
  }

  return defaultValue;
}

/// Convert value to string safely
String safeStr(dynamic value, {String defaultValue = ""}) {
  if (value == null) return defaultValue;
  try {
    return value.toString();
  } catch (e) {
    return defaultValue;
  }
}

/// Convert value to int safely
int safeInt(dynamic value, {int defaultValue = 0}) {
  if (value == null) return defaultValue;
  try {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.parse(value);
    return defaultValue;
  } catch (e) {
    return defaultValue;
  }
}

/// Convert value to double safely
double safeDouble(dynamic value, {double defaultValue = 0.0}) {
  if (value == null) return defaultValue;
  try {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.parse(value);
    return defaultValue;
  } catch (e) {
    return defaultValue;
  }
}

/// ========================================================================
/// TEXT FORMATTING
/// ========================================================================

/// Truncate text to maximum length with optional ellipsis
String truncateText(
  String text, {
  int maxLength = 100,
  String ellipsis = "...",
  bool preserveWords = true,
}) {
  if (text.isEmpty) return text;

  if (text.length <= maxLength) return text;

  if (!preserveWords) {
    return text.substring(0, maxLength - ellipsis.length) + ellipsis;
  }

  // Preserve word boundaries
  final truncated = text.substring(0, maxLength - ellipsis.length);
  final lastSpace = truncated.lastIndexOf(' ');

  if (lastSpace > 0) {
    return truncated.substring(0, lastSpace) + ellipsis;
  }

  return truncated + ellipsis;
}

/// Sanitize text for safe display
String sanitizeTextForDisplay(
  String text, {
  bool removeHtml = true,
  int? maxLength,
}) {
  if (text.isEmpty) return text;

  String sanitized = text;

  // Remove HTML tags
  if (removeHtml) {
    sanitized = sanitized.replaceAll(RegExp(r'<[^>]+>'), '');
  }

  // Remove excessive whitespace
  sanitized = sanitized.replaceAll(RegExp(r'\s+'), ' ').trim();

  // Truncate if needed
  if (maxLength != null && sanitized.length > maxLength) {
    sanitized = truncateText(sanitized, maxLength: maxLength);
  }

  return sanitized;
}

/// Format multiline text for display
String formatMultilineText(String text, {int maxLineLength = 80}) {
  if (text.isEmpty) return text;

  final words = text.split(' ');
  final lines = <String>[];
  String currentLine = '';

  for (final word in words) {
    if ((currentLine.isEmpty ? word.length : currentLine.length + 1 + word.length) <= maxLineLength) {
      currentLine += (currentLine.isEmpty ? '' : ' ') + word;
    } else {
      if (currentLine.isNotEmpty) {
        lines.add(currentLine);
      }
      currentLine = word;
    }
  }

  if (currentLine.isNotEmpty) {
    lines.add(currentLine);
  }

  return lines.join('\n');
}

/// ========================================================================
/// ERROR MESSAGE FORMATTING
/// ========================================================================

/// Format error message for display
String formatErrorMessage(
  dynamic error, {
  String? context,
  bool userFriendly = true,
}) {
  // Extract error message
  String errorMessage;
  if (error is Exception) {
    errorMessage = error.toString();
  } else if (error is Map) {
    errorMessage = error['message'] ?? error['error'] ?? 'An error occurred';
  } else {
    errorMessage = safeStr(error);
    if (errorMessage.isEmpty) errorMessage = 'An error occurred';
  }

  // User-friendly messages
  if (userFriendly) {
    final userMessages = <String, String>{
      'timeout': 'Taking longer than expected. Please wait a moment.',
      'network_error': 'Connection issue. Please check your internet and try again.',
      'service_unavailable': 'Service temporarily unavailable. Please try again later.',
      'unauthorized': 'Please log in to continue.',
      'rate_limit': 'Too many requests. Please wait a moment.',
      'not_found': 'We couldn\'t find what you\'re looking for.',
      'validation_error': 'Please check your input and try again.',
      'server_error': 'Something went wrong on our end. Please try again.',
    };

    // Try to match error type
    final errorLower = errorMessage.toLowerCase();
    for (final entry in userMessages.entries) {
      if (errorLower.contains(entry.key)) {
        errorMessage = entry.value;
        break;
      }
    }

    // Add context if provided
    if (context != null && context.isNotEmpty) {
      errorMessage = '$errorMessage ($context)';
    }
  }

  return errorMessage;
}

/// Format retry message
String formatRetryMessage(String operation, int retryCount, int maxRetries) {
  return 'Retrying $operation... (Attempt $retryCount of $maxRetries)';
}

/// ========================================================================
/// RESPONSE VALIDATION
/// ========================================================================

/// Check if response is valid and not empty
bool isValidResponse(dynamic response) {
  if (response == null) return false;

  if (response is Map) {
    // Check if has meaningful content
    final text = response['text'] ?? response['message'] ?? response['response'];
    if (text is String && text.trim().isNotEmpty) return true;

    // Check if has other meaningful data
    for (final entry in (response as Map).entries) {
      final key = entry.key as String;
      if (key != 'text' && key != 'message' && key != 'response') {
        final value = entry.value;
        if (value != null && value != '' && value != false) return true;
      }
    }
    return false;
  }

  if (response is String) return response.trim().isNotEmpty;
  if (response is List) return response.isNotEmpty;

  return false;
}

/// Remove empty/None fields from map
Map<String, dynamic> cleanEmptyFields(Map<String, dynamic> data) {
  final cleaned = <String, dynamic>{};

  for (final entry in data.entries) {
    final value = entry.value;
    if (value != null && value != '' && value != false) {
      if (value is List && value.isEmpty) continue;
      if (value is Map && value.isEmpty) continue;
      cleaned[entry.key] = value;
    }
  }

  return cleaned;
}

/// Ensure response has minimal required fields
Map<String, dynamic> ensureMinimalResponse(
  Map<String, dynamic> response,
  List<String> requiredFields, {
  Map<String, dynamic>? defaultValues,
}) {
  final result = Map<String, dynamic>.from(response);
  final defaults = defaultValues ?? <String, dynamic>{};

  for (final field in requiredFields) {
    if (!result.containsKey(field) ||
        result[field] == null ||
        result[field] == '') {
      result[field] = defaults[field] ?? _getDefaultForField(field);
    }
  }

  return result;
}

dynamic _getDefaultForField(String field) {
  switch (field) {
    case 'timestamp':
      return DateTime.now().toIso8601String();
    case 'text':
      return '...';
    case 'isUser':
      return false;
    default:
      return null;
  }
}

/// ========================================================================
/// DISPLAY HELPERS
/// ========================================================================

/// Get safe display text from response
String getSafeDisplayText(
  Map<String, dynamic>? response, {
  String fallback = 'I\'m having trouble understanding. Could you try rephrasing?',
}) {
  if (!isValidResponse(response)) return fallback;

  // Try multiple fields
  for (final field in ['text', 'message', 'response', 'content', 'output']) {
    final value = safeGet(response ?? {}, field);
    if (value.isNotEmpty) return value;
  }

  return fallback;
}

/// Format timestamp for display
String formatTimestampForDisplay(
  dynamic timestamp, {
  String format = 'yyyy-MM-dd HH:mm',
}) {
  if (timestamp == null) return 'Just now';

  DateTime? dateTime;

  // Parse if string
  if (timestamp is String) {
    try {
      dateTime = DateTime.parse(timestamp);
    } catch (e) {
      return 'Just now';
    }
  } else if (timestamp is DateTime) {
    dateTime = timestamp;
  } else {
    return 'Just now';
  }

  // Format
  try {
    return DateFormat(format).format(dateTime!);
  } catch (e) {
    return 'Just now';
  }
}

/// Format amount for display
String formatAmountForDisplay(
  dynamic amount, {
  String currency = 'NGN',
  int decimals = 2,
}) {
  // Convert to double
  double amountDouble;
  try {
    amountDouble = (amount ?? 0).toDouble();
  } catch (e) {
    amountDouble = 0.0;
  }

  // Format with commas
  final amountStr = amountDouble.toStringAsFixed(decimals);
  final formatter = NumberFormat.decimalPattern();
  final formatted = formatter.format(double.parse(amountStr));

  // Add currency symbol
  final currencySymbols = <String, String>{
    'NGN': '₦',
    'USD': '\$',
    'GBP': '£',
    'EUR': '€',
    'CAD': 'C\$',
    'JPY': '¥',
    'ZAR': 'R',
    'AUD': 'A\$',
    'INR': '₹',
  };

  final symbol = currencySymbols[currency] ?? '$currency ';
  return '$symbol$formatted';
}

/// Mask sensitive value for display
String maskSensitiveValue(
  String value, {
  String maskChar = '*',
  int visibleChars = 4,
  int? maskLength,
}) {
  if (value.isEmpty || value.length <= visibleChars) return value;

  if (value.contains('@')) {
    // Email - show domain
    final parts = value.split('@');
    final username = parts[0];
    final domain = parts.length > 1 ? parts[1] : '';
    final maskedUsername = maskChar *
        (username.length > visibleChars ? username.length - visibleChars : 1);
    final visibleUsername = visibleChars > 0
        ? username.substring(username.length - visibleChars)
        : '';
    return '$maskedUsername$visibleUsername@$domain';
  } else {
    // Phone, card, etc. - show last digits
    final actualMaskLength = maskLength ?? (value.length - visibleChars);
    if (actualMaskLength <= 0) return value;

    return maskChar * actualMaskLength + value.substring(value.length - visibleChars);
  }
}

/// ========================================================================
/// LOADING STATES
/// ========================================================================

/// Format loading message
String formatLoadingMessage(String operation) {
  return '$operation...';
}

/// Format success message
String formatSuccessMessage(String operation, {String? result}) {
  if (result != null && result.isNotEmpty) {
    return '✅ $operation successful! $result';
  }
  return '✅ $operation successful!';
}

/// ========================================================================
/// NETWORK ERROR HANDLING
/// ========================================================================

/// Handle network error with retry
Future<T> handleNetworkError<T>(
  Future<T> Function() operation, {
  int maxRetries = 3,
  Duration retryDelay = const Duration(seconds: 1),
  void Function(int retryCount)? onRetry,
}) async {
  int retryCount = 0;

  while (retryCount <= maxRetries) {
    try {
      return await operation();
    } catch (e) {
      retryCount++;

      if (retryCount <= maxRetries) {
        onRetry?.call(retryCount);
        await Future.delayed(retryDelay);
      } else {
        rethrow;
      }
    }
  }

  throw StateError('Should not reach here');
}

/// Debounce function calls. Returns a wrapper that, when invoked, schedules
/// `innerFunc` to run once the debounce window has elapsed without a new
/// invocation. The return value of the most recent invocation is cached and
/// handed back on the next call.
T Function(T Function() innerFunc) debounce<T>(T Function() _, Duration delay) {
  Timer? timer;
  T? lastResult;

  return (T Function() innerFunc) {
    timer?.cancel();
    timer = Timer(delay, () {
      lastResult = innerFunc();
    });
    return lastResult as T;
  };
}

/// Throttle function calls. Returns a wrapper that only invokes the inner
/// function once per `duration`; subsequent calls inside that window return
/// the cached last result.
T Function(T Function() innerFunc) throttle<T>(T Function() _, Duration duration) {
  bool ready = true;
  T? lastResult;

  return (T Function() innerFunc) {
    if (!ready) return lastResult as T;
    ready = false;
    lastResult = innerFunc();
    Timer(duration, () {
      ready = true;
    });
    return lastResult as T;
  };
}

/// ========================================================================
/// UI STATE HELPERS
/// ========================================================================

/// Get widget for loading state
Widget getLoadingWidget({String message = 'Loading...'}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(message, style: const TextStyle(fontSize: 14)),
      ],
    ),
  );
}

/// Get widget for error state
Widget getErrorWidget(String message, {VoidCallback? onRetry}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 48, color: Colors.red),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ],
    ),
  );
}

/// Get widget for empty state
Widget getEmptyWidget({String message = 'No data available'}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.inbox_outlined, size: 48, color: Colors.grey),
        const SizedBox(height: 16),
        Text(
          message,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    ),
  );
}

/// ========================================================================
/// CHAT-SPECIFIC HELPERS
/// ========================================================================

/// Check if message is empty or only whitespace
bool isMessageEmpty(String? text) {
  if (text == null) return true;
  return text.trim().isEmpty;
}

/// Check if message contains sensitive data (PIN)
bool containsSensitiveData(String? text) {
  if (text == null) return false;
  final pinPattern = RegExp(r'^\d{4,6}$');
  return pinPattern.hasMatch(text.trim());
}

/// Get display text for message (mask sensitive data)
String getDisplayText(String text) {
  if (containsSensitiveData(text)) {
    return 'Sensitive data ****';
  }
  return text;
}

/// Format chat message for display
String formatChatMessage(
  String text, {
  int maxLength = 500,
  bool preserveWords = true,
}) {
  if (text.length <= maxLength) return text;

  if (preserveWords) {
    return truncateText(text, maxLength: maxLength, preserveWords: true);
  }

  return text.substring(0, maxLength - 3) + '...';
}

/// Check if response should show loading indicator
bool shouldShowLoadingIndicator(Map<String, dynamic>? response) {
  if (response == null) return false;
  return response['isTyping'] == true ||
      response['isLoading'] == true ||
      response['isProcessing'] == true;
}

/// Check if response is error state
bool isErrorState(Map<String, dynamic>? response) {
  if (response == null) return false;
  return response['error'] != null ||
      response['errorMessage'] != null ||
      response['isError'] == true;
}

/// Get error message from response
String getErrorMessage(Map<String, dynamic>? response) {
  if (response == null) return 'An error occurred';

  return safeGet(response, 'errorMessage') ??
      safeGet(response, 'error') ??
      safeGet(response, 'message') ??
      'An error occurred';
}

/// ========================================================================
/// SCROLL HELPERS
/// ========================================================================

/// Scroll to bottom of chat
void scrollToBottom(ScrollController controller, {Duration duration = const Duration(milliseconds: 300)}) {
  if (controller.hasClients) {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: duration,
      curve: Curves.easeOut,
    );
  }
}

/// Scroll to specific position
void scrollToPosition(
  ScrollController controller,
  double position, {
  Duration duration = const Duration(milliseconds: 300),
}) {
  if (controller.hasClients) {
    controller.animateTo(
      position,
      duration: duration,
      curve: Curves.easeOut,
    );
  }
}

/// ========================================================================
/// THEME HELPERS
/// ========================================================================

/// Get text color based on message type
Color getMessageTextColor(bool isUser) {
  return isUser ? Colors.white : Colors.black87;
}

/// Get background color based on message type
Color getMessageBackgroundColor(bool isUser, ColorScheme colorScheme) {
  return isUser
      ? colorScheme.primary
      : colorScheme.surface;
}

/// Get border radius based on message type
BorderRadius getMessageBorderRadius(bool isUser) {
  return BorderRadius.only(
    topLeft: const Radius.circular(16),
    topRight: const Radius.circular(16),
    bottomLeft: Radius.circular(isUser ? 16 : 4),
    bottomRight: Radius.circular(isUser ? 4 : 16),
  );
}

/// ========================================================================
/// VALIDATION HELPERS
/// ========================================================================

/// Validate email format
bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

/// Validate phone number format
bool isValidPhone(String phone) {
  final phoneRegex = RegExp(r'^\+?[\d\s-]{10,15}$');
  return phoneRegex.hasMatch(phone);
}

/// Validate amount format
bool isValidAmount(String amount) {
  final amountRegex = RegExp(r'^[\d,]+\.?\d{0,2}$');
  return amountRegex.hasMatch(amount);
}
