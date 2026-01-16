/// This file contains helper methods to add transaction history navigation
/// to various service screens throughout the app.
///
/// Import this file in service screens to easily add "View History" functionality.
library;

import 'package:flutter/material.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

/// Helper class to add transaction history navigation to service screens
class TransactionHistoryScreenIntegration {
  TransactionHistoryScreenIntegration._();

  /// Add history button to AppBar actions
  static List<Widget> withHistoryButton({
    required List<Widget> existingActions,
    required AppServiceName serviceName,
  }) {
    return [
      ...existingActions,
      ViewTransactionHistoryIconButton(serviceName: serviceName),
    ];
  }

  /// Add history section to a service screen
  ///
  /// Usage:
  /// ```dart
  /// @override
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     body: Column(
  ///       children: [
  ///         // Your existing content
  ///         ...buildServiceContent(),
  ///
  ///         // Add history section at the bottom
  ///         ...TransactionHistoryScreenIntegration.buildHistorySection(
  ///           serviceName: AppServiceName.airtime,
  ///         ),
  ///       ],
  ///     ),
  ///   );
  /// }
  /// ```
  static List<Widget> buildHistorySection({
    required AppServiceName serviceName,
    String? customTitle,
    bool showDivider = true,
  }) {
    return [
      if (showDivider)
        const Divider(height: 32, thickness: 1),
      SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                customTitle ?? 'Transaction History',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            ViewTransactionHistoryTextButton(serviceName: serviceName),
          ],
        ),
      ),
      SizedBox(height: 16),
      ViewTransactionHistoryButton(
        serviceName: serviceName,
        isFullWidth: true,
      ),
      SizedBox(height: 24),
    ];
  }

  /// Build a card widget with history button for dashboard-like layouts
  static Widget buildHistoryCard({
    required AppServiceName serviceName,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(Icons.history),
        title: Text('${serviceName.displayName} History'),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap ??
            () => _navigateToServiceHistory(serviceName),
      ),
    );
  }

  static void _navigateToServiceHistory(AppServiceName serviceName) {
    // TODO: Implement service-specific history navigation
    // final serviceType = serviceName.toTransactionServiceType();
    // if (serviceType != null) {
    //   // Navigate to service-specific history
    //   // This will be handled by the navigation helper
    // }
  }
}

/// Extension to easily add history navigation to any service screen
extension TransactionHistoryIntegration on Widget {
  /// Wrap a widget with a "View History" button at the bottom
  Widget withHistoryButton({
    required AppServiceName serviceName,
    String? customLabel,
    bool isFullWidth = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        this,
        SizedBox(height: 16),
        ViewTransactionHistoryButton(
          serviceName: serviceName,
          customLabel: customLabel,
          isFullWidth: isFullWidth,
        ),
      ],
    );
  }
}
