import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';
part 'chat_receipt_card_widgets.dart';


/// Structured receipt data from a successful transfer.
class TransferReceiptData {
  final String receiptId;
  final String type;
  final String transferType;
  final String status;
  final int amount;
  final String amountDisplay;
  final String currency;
  final String reference;
  final String recipientName;
  final String recipientBank;
  final String recipientAccount;
  final String senderAccountId;
  final int newBalance;
  final String newBalanceDisplay;
  final int fee;
  final String feeDisplay;
  final DateTime timestamp;
  final String? receiptUrl; // Backend-generated PDF URL
  final String description; // Human-readable description (e.g. "Bill Payment", "Stock Trade")
  final Map<String, dynamic> details; // Operation-specific extra fields

  const TransferReceiptData({
    required this.receiptId,
    required this.type,
    required this.transferType,
    required this.status,
    required this.amount,
    required this.amountDisplay,
    required this.currency,
    required this.reference,
    required this.recipientName,
    this.recipientBank = '',
    this.recipientAccount = '',
    this.senderAccountId = '',
    this.newBalance = 0,
    this.newBalanceDisplay = '',
    this.fee = 0,
    this.feeDisplay = '0.00',
    required this.timestamp,
    this.receiptUrl,
    this.description = '',
    this.details = const {},
  });

  /// Map to the shared [UnifiedTransaction] so the chat/voice receipt reuses the
  /// canonical send-funds receipt (`UnifiedTransactionReceipt` — Lazervault logo
  /// top-right, barcode/QR, working share + download at the bottom) instead of a
  /// bespoke full-screen view with duplicated top-right actions.
  UnifiedTransaction toUnifiedTransaction() {
    // Prefer the authoritative preformatted display string for the figure so a
    // minor/major-unit mismatch can never mis-render the amount. Fall back to
    // the integer (assumed minor units) only if the display is unparseable.
    final major =
        double.tryParse(amountDisplay.replaceAll(RegExp(r'[^0-9.]'), '')) ??
            (amount / 100.0);
    return UnifiedTransaction(
      id: reference.isNotEmpty ? reference : receiptId,
      serviceType: TransactionServiceType.fromString(_unifiedServiceSlug()),
      title: recipientName.isNotEmpty ? recipientName : transferTypeDisplay,
      description: description.isNotEmpty ? description : null,
      amount: major,
      amountDisplayOverride:
          amountDisplay.isNotEmpty ? '$currencySymbol$amountDisplay' : null,
      currency: currency,
      createdAt: timestamp,
      status: UnifiedTransactionStatus.fromString(_normalizedStatus()),
      flow: _unifiedFlow(),
      transactionReference: reference.isNotEmpty ? reference : null,
      counterpartyName: recipientName.isNotEmpty ? recipientName : null,
      counterpartyAccount:
          recipientAccount.isNotEmpty ? recipientAccount : null,
      metadata: <String, dynamic>{
        if (feeDisplay.isNotEmpty && feeDisplay != '0.00')
          'fee': '$currencySymbol$feeDisplay',
        if (recipientBank.isNotEmpty) 'bank': recipientBank,
        'status': status,
        ...details,
      },
    );
  }

  /// Map the receipt `type` to a [TransactionServiceType] enum name. Unknown
  /// values pass through and degrade gracefully to `unknown` via fromString.
  String _unifiedServiceSlug() {
    switch (type) {
      case 'transfer':
      case 'internal_transfer':
      case 'external_transfer':
      case 'transfer_intl':
        return 'transfer';
      case 'batch_transfer':
        return 'batchTransfer';
      case 'tagpay':
      case 'tag_pay':
        return 'tagPay';
      case 'qr_payment':
        return 'qrPayment';
      case 'id_pay':
        return 'idPay';
      case 'invoice_payment':
        return 'invoice';
      case 'split_bill_pay':
        return 'splitBill';
      case 'stock_trade':
        return 'stocks';
      case 'crypto_trade':
      case 'crypto_buy':
      case 'crypto_sell':
      case 'crypto_swap':
      case 'crypto_send':
        return 'crypto';
      case 'currency_exchange':
      case 'exchange_convert':
        return 'exchange';
      case 'insurance_purchase':
      case 'insurance_buy':
        return 'insurance';
      case 'payroll_disbursement':
        return 'payroll';
      case 'group_contribution':
        return 'groupFunds';
      case 'giftcard_buy':
      case 'giftcard_sell':
        return 'giftCard';
      case 'bill_payment':
        // Prefer the specific bill type when the backend included it.
        final bt = details['bill_type']?.toString() ?? '';
        return bt.isNotEmpty ? bt : 'unknown';
      default:
        return type;
    }
  }

  /// Normalise backend status strings to a [UnifiedTransactionStatus] enum
  /// name. The chat/voice receipt commonly uses 'success'/'successful' for a
  /// completed money move, which fromString has no case for and would otherwise
  /// fall back to 'pending' — making a SUCCESSFUL transfer read as "Pending".
  String _normalizedStatus() {
    switch (status.toLowerCase().trim()) {
      case 'success':
      case 'successful':
      case 'complete':
      case 'completed':
      case 'settled':
      case 'delivered':
      case 'paid':
      case 'approved':
        return 'completed';
      case 'processing':
      case 'in_progress':
      case 'in-progress':
      case 'pending_settlement':
      case 'submitted':
        return 'processing';
      case 'failed':
      case 'failure':
      case 'declined':
      case 'rejected':
      case 'error':
        return 'failed';
      case 'cancelled':
      case 'canceled':
        return 'cancelled';
      case 'refunded':
      case 'reversed':
      case 'reversal':
        return 'refunded';
      case 'expired':
        return 'expired';
      case 'scheduled':
        return 'scheduled';
      default:
        // Known enum names (pending, etc.) pass through; unknowns fall back to
        // 'pending' via fromString.
        return status;
    }
  }

  /// Money the user RECEIVES reads as incoming; everything else is outgoing.
  TransactionFlow _unifiedFlow() {
    switch (type) {
      case 'deposit':
      case 'refund':
      case 'crypto_sell':
      case 'currency_exchange':
      case 'exchange_convert':
        return TransactionFlow.incoming;
      default:
        return TransactionFlow.outgoing;
    }
  }

  /// Parse an int from a value that may be num, String, or null.
  static int _parseIntSafe(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  factory TransferReceiptData.fromJson(Map<String, dynamic> json) {
    return TransferReceiptData(
      receiptId: json['receipt_id']?.toString() ?? '',
      type: json['type']?.toString() ?? 'transfer',
      transferType: json['transfer_type']?.toString() ?? 'internal',
      status: json['status']?.toString() ?? 'unknown',
      amount: _parseIntSafe(json['amount']),
      amountDisplay: json['amount_display']?.toString() ?? '0.00',
      currency: json['currency']?.toString() ?? 'NGN',
      reference: json['reference']?.toString() ?? '',
      recipientName: json['recipient_name']?.toString() ?? '',
      recipientBank: json['recipient_bank']?.toString() ?? '',
      recipientAccount: json['recipient_account']?.toString() ?? '',
      senderAccountId: json['sender_account_id']?.toString() ?? '',
      newBalance: _parseIntSafe(json['new_balance']),
      newBalanceDisplay: json['new_balance_display']?.toString() ?? '',
      fee: _parseIntSafe(json['fee']),
      feeDisplay: json['fee_display']?.toString() ?? '0.00',
      timestamp: _parseTimestamp(json['timestamp']),
      receiptUrl: _rewriteUrlForEmulator(json['receipt_url']?.toString()),
      description: json['description']?.toString() ?? '',
      details: json['details'] is Map ? Map<String, dynamic>.from(json['details'] as Map) : const {},
    );
  }

  static DateTime _parseTimestamp(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is String) return DateTime.tryParse(value) ?? DateTime.now();
    return DateTime.now();
  }

  /// Rewrite localhost URLs to 10.0.2.2 for Android emulator access.
  static String? _rewriteUrlForEmulator(String? url) {
    if (url == null) return null;
    if (Platform.isAndroid && url.contains('://localhost')) {
      return url.replaceFirst('://localhost', '://10.0.2.2');
    }
    return url;
  }

  String get currencySymbol {
    switch (currency) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return currency;
    }
  }

  String get transferTypeDisplay {
    // Handle non-transfer receipt types
    switch (type) {
      case 'bill_payment':
        return 'Bill Payment';
      case 'tagpay':
        return 'TagPay';
      case 'invoice_payment':
        return 'Invoice Payment';
      case 'qr_payment':
        return 'QR Payment';
      case 'stock_trade':
        return 'Stock Trade';
      case 'crypto_trade':
        return 'Crypto Trade';
      case 'currency_exchange':
        return 'Currency Exchange';
      case 'deposit':
        return 'Deposit';
      case 'withdrawal':
        return 'Withdrawal';
      case 'insurance_purchase':
        return 'Insurance';
      case 'payroll_disbursement':
        return 'Payroll';
      case 'group_contribution':
        return 'Group Contribution';
      case 'spray_send':
        return 'Lazerspray';
      case 'wallet_fund':
        return 'Wallet Funding';
      case 'transfer':
        // Sub-type from transferType field
        switch (transferType) {
          case 'internal':
            return 'Lazervault Transfer';
          case 'domestic':
            return 'Bank Transfer';
          case 'international':
            return 'International Transfer';
          case 'phone':
            return 'Phone Transfer';
          default:
            return 'Transfer';
        }
      default:
        // Fallback: try transferType for legacy data
        switch (transferType) {
          case 'internal':
            return 'Lazervault Transfer';
          case 'domestic':
            return 'Bank Transfer';
          case 'international':
            return 'International Transfer';
          default:
            return 'Transaction';
        }
    }
  }

  bool get isSuccess =>
      status.toLowerCase() == 'completed' || status.toLowerCase() == 'success';

  /// Create a copy with updated receiptUrl
  TransferReceiptData copyWith({String? receiptUrl}) {
    return TransferReceiptData(
      receiptId: receiptId,
      type: type,
      transferType: transferType,
      status: status,
      amount: amount,
      amountDisplay: amountDisplay,
      currency: currency,
      reference: reference,
      recipientName: recipientName,
      recipientBank: recipientBank,
      recipientAccount: recipientAccount,
      senderAccountId: senderAccountId,
      newBalance: newBalance,
      newBalanceDisplay: newBalanceDisplay,
      fee: fee,
      feeDisplay: feeDisplay,
      timestamp: timestamp,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      description: description,
      details: details,
    );
  }
}
