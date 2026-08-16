import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';

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

/// Loading skeleton shown while receipt data is being fetched or loaded.
class ChatReceiptLoadingCard extends StatelessWidget {
  const ChatReceiptLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header skeleton
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: LazerVaultLoader.tiny(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 60,
                      height: 11,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D3D),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Amount skeleton
          Container(
            width: 120,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D3D),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),
          // Info text
          Row(
            children: [
              const Icon(
                Icons.receipt_long,
                color: Color(0xFF9CA3AF),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Loading receipt...',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Compact receipt card shown inline in the chat bubble (Revolut-style).
/// Shows a loading skeleton initially, then lazily loads the receipt data.
class ChatReceiptCard extends StatefulWidget {
  final TransferReceiptData receipt;

  const ChatReceiptCard({super.key, required this.receipt});

  @override
  State<ChatReceiptCard> createState() => _ChatReceiptCardState();
}

class _ChatReceiptCardState extends State<ChatReceiptCard> {
  bool _isLoading = true;
  TransferReceiptData? _loadedReceipt;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Show loading skeleton first, then load receipt data
    _loadReceiptData();
  }

  Future<void> _loadReceiptData() async {
    // Simulate a brief delay to show the loading skeleton
    // In production, this would fetch the receipt URL or validate it
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    // If receiptUrl is provided, validate it by checking if it's accessible
    if (widget.receipt.receiptUrl != null && widget.receipt.receiptUrl!.isNotEmpty) {
      try {
        final response = await http.head(
          Uri.parse(widget.receipt.receiptUrl!),
        ).timeout(
          const Duration(seconds: 5),
          onTimeout: () => http.Response('Timeout', 408),
        );

        if (mounted) {
          if (response.statusCode == 200) {
            // Receipt URL is valid
            setState(() {
              _isLoading = false;
              _loadedReceipt = widget.receipt;
            });
          } else {
            // URL not accessible, still show receipt but without PDF preview
            setState(() {
              _isLoading = false;
              _loadedReceipt = widget.receipt;
              _errorMessage = 'PDF unavailable';
            });
          }
        }
      } catch (e) {
        // Network error, still show the receipt
        if (mounted) {
          setState(() {
            _isLoading = false;
            _loadedReceipt = widget.receipt;
            _errorMessage = 'Connection error';
          });
        }
      }
    } else {
      // No receipt URL provided, just show the receipt data
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadedReceipt = widget.receipt;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading skeleton while data is being fetched
    if (_isLoading) {
      return const ChatReceiptLoadingCard();
    }

    // Show error state if loading failed
    if (_errorMessage != null) {
      return _buildReceiptCard(_loadedReceipt!, showError: true);
    }

    // Show the actual receipt card
    return _buildReceiptCard(_loadedReceipt!);
  }

  Widget _buildReceiptCard(TransferReceiptData r, {bool showError = false}) {
    return GestureDetector(
      onTap: () => _openFullScreenReceipt(context),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: r.isSuccess
                ? const Color(0xFF10B981).withValues(alpha: 0.3)
                : const Color(0xFFEF4444).withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: r.isSuccess
                    ? const Color(0xFF10B981).withValues(alpha: 0.1)
                    : const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: r.isSuccess
                          ? const Color(0xFF10B981).withValues(alpha: 0.2)
                          : const Color(0xFFEF4444).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      r.isSuccess ? Icons.check : Icons.close,
                      color: r.isSuccess
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          r.isSuccess
                              ? '${r.transferTypeDisplay} Successful'
                              : '${r.transferTypeDisplay} ${r.status}',
                          style: TextStyle(
                            color: r.isSuccess
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          r.transferTypeDisplay,
                          style: const TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.receipt_long,
                    color: Color(0xFF9CA3AF),
                    size: 20,
                  ),
                ],
              ),
            ),

            // Amount
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '${r.currencySymbol} ${r.amountDisplay}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            // Recipient
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: Row(
                children: [
                  const Icon(Icons.arrow_forward, color: Color(0xFF9CA3AF), size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      r.recipientName,
                      style: const TextStyle(
                        color: Color(0xFFD1D5DB),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Reference + timestamp
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      r.reference,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('HH:mm').format(r.timestamp.toLocal()),
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            // Tap to view / Loading indicator
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF2D2D3D)),
                ),
              ),
              child: showError
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: Color(0xFFF59E0B),
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Tap to view receipt',
                          style: TextStyle(
                            color: Color(0xFFF59E0B),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        'Tap to view receipt',
                        style: TextStyle(
                          color: Color(0xFF3B82F6),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _openFullScreenReceipt(BuildContext context) {
    // Reuse the ONE canonical receipt every service already uses
    // (UnifiedTransactionReceipt — Lazervault logo top-right, barcode/QR, working
    // Share + Download at the BOTTOM only), built from this card's payload —
    // instead of the bespoke FullScreenReceiptView (which duplicated Share/
    // Download in the app bar and whose URL-based share/download often failed).
    // fromHistory:true makes its close button pop back to the chat/voice sheet.
    final r = _loadedReceipt ?? widget.receipt;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => UnifiedTransactionReceipt(
          transaction: r.toUnifiedTransaction(),
          fromHistory: true,
        ),
      ),
    );
  }
}
