import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/bill_history_actions_sheet.dart';

import '../../domain/entities/transaction_entity.dart';
import '../theme/exchange_theme.dart';
import 'report_issue_dialog.dart';

/// Bottom sheet of actions available on a past exchange transaction
/// (Convert or Send Abroad). Modelled on `WaterHistoryActionsSheet`:
///
///   * View Receipt     — always available (share lives on that screen).
///   * Repeat Exchange  — prefills the home flow with the same pair/amount.
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
            final isConversion = tx.type.isConversionLike;
            if (isConversion) {
              // Convert: home screen handles wallet↔wallet. The
              // repeatPrefill flag tells it to auto-advance past the
              // amount-entry step and open the confirmation modal with
              // the prior amount/rate baked in.
              Get.toNamed(
                AppRoutes.exchangeHome,
                arguments: {
                  'fromCurrency': tx.fromCurrency,
                  'toCurrency': tx.toCurrency,
                  'amount': tx.fromAmount,
                  'mode': 'convert',
                  'repeatPrefill': true,
                },
              );
            } else {
              // Send Abroad: jump straight to the recipient form with all
              // receiver fields pre-filled so the user lands on the
              // confirm button. They can still edit anything.
              Get.toNamed(
                AppRoutes.exchangeRecipient,
                arguments: {
                  'fromCurrency': tx.fromCurrency,
                  'toCurrency': tx.toCurrency,
                  'amount': tx.fromAmount,
                  'mode': 'sendAbroad',
                  'repeatPrefill': true,
                  'recipientName': tx.recipient.name,
                  'recipientAccountNumber': tx.recipient.accountNumber,
                  'recipientBankName': tx.recipient.bankName,
                  'recipientSwiftCode': tx.recipient.swiftCode ?? '',
                  'recipientIban': tx.recipient.iban ?? '',
                  'recipientCountry': tx.recipient.countryCode,
                  'recipientRoutingNumber':
                      tx.recipient.routingNumber ?? '',
                  'recipientAddress': tx.recipient.address ?? '',
                },
              );
            }
          },
        ),
        // Share Receipt intentionally omitted here — the receipt/detail screen
        // (opened via "View Receipt") already has its own share action, so a
        // duplicate here is redundant.
        // Report Issue surfaces only on terminal sad-path states — failed
        // or cancelled (refunded). Happy-path and in-flight transactions
        // don't need a complaint channel; there's nothing to complain
        // about yet.
        if (tx.status == TransactionStatus.failed ||
            tx.status == TransactionStatus.cancelled)
          BillHistoryAction(
            icon: Icons.support_agent,
            color: ExchangeTheme.warning,
            label: 'Report Issue',
            onTap: () {
              Get.back();
              ReportIssueDialog.show(context, tx);
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
