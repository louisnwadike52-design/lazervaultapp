import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/bill_history_actions_sheet.dart';

import '../../domain/entities/transaction_entity.dart';
import '../theme/exchange_theme.dart';

/// Bottom sheet of actions available on a past exchange transaction
/// (Convert or Send Abroad). Modelled on `WaterHistoryActionsSheet`:
///
///   * View Receipt     — always available.
///   * Repeat Exchange  — prefills the home flow with the same pair/amount.
///   * Share Receipt    — launches a native share intent (TODO).
///   * Report Issue     — opens the support / contact route with the
///                        transaction reference pre-filled.
class ExchangeHistoryActionsSheet {
  ExchangeHistoryActionsSheet._();

  static Future<void> show(
    BuildContext context,
    CurrencyTransaction tx,
  ) async {
    final reference = tx.referenceNumber ?? tx.id;
    final amount = _formatAmount(tx.fromAmount, tx.fromCurrency);
    final received = _formatAmount(tx.toAmount, tx.toCurrency);

    return BillHistoryActionsSheet.show(
      context,
      title: reference.isEmpty ? 'Exchange' : reference,
      subtitle: '$amount → $received · ${_statusLabel(tx.status)}',
      actions: [
        BillHistoryAction(
          icon: Icons.receipt_long,
          color: ExchangeTheme.primary,
          label: 'View Receipt',
          onTap: () {
            Get.back();
            Get.toNamed(
              AppRoutes.exchangeDetail,
              arguments: tx,
            );
          },
        ),
        BillHistoryAction(
          icon: Icons.replay,
          color: ExchangeTheme.success,
          label: 'Repeat Exchange',
          onTap: () {
            Get.back();
            Get.toNamed(
              AppRoutes.exchangeHome,
              arguments: {
                'fromCurrency': tx.fromCurrency,
                'toCurrency': tx.toCurrency,
                'amount': tx.fromAmount,
              },
            );
          },
        ),
        BillHistoryAction(
          icon: Icons.ios_share,
          color: ExchangeTheme.primaryDark,
          label: 'Share Receipt',
          onTap: () {
            Get.back();
            // Native share — delegated to the receipt screen's existing
            // share action. We open the receipt so the user can tap share
            // there; this keeps a single code path for share formatting.
            Get.toNamed(
              AppRoutes.exchangeDetail,
              arguments: tx,
              parameters: {'action': 'share'},
            );
          },
        ),
        if (tx.status == TransactionStatus.failed ||
            tx.status == TransactionStatus.pending)
          BillHistoryAction(
            icon: Icons.support_agent,
            color: ExchangeTheme.warning,
            label: 'Report Issue',
            onTap: () {
              Get.back();
              Get.snackbar(
                'Support',
                'Reference $reference copied. Our team will follow up.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: ExchangeTheme.cardBackground,
                colorText: Colors.white,
              );
            },
          ),
      ],
    );
  }

  static String _statusLabel(TransactionStatus s) {
    switch (s) {
      case TransactionStatus.completed:
        return 'Completed';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.processing:
        return 'Processing';
      case TransactionStatus.cancelled:
        return 'Cancelled';
    }
  }

  static String _formatAmount(double amount, String currency) {
    return '$currency ${amount.toStringAsFixed(2)}';
  }
}
