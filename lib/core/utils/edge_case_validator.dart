/// Edge case handling utilities for account actions and financial operations.
///
/// Provides validation functions and error handling patterns to ensure
/// consistent user experience and prevent runtime errors.
library;

import 'package:flutter/material.dart';
part 'edge_case_validator_widgets.dart';


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
