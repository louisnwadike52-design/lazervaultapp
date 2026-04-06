import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

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
        return 'SprayMe';
      case 'wallet_fund':
        return 'Wallet Funding';
      case 'transfer':
        // Sub-type from transferType field
        switch (transferType) {
          case 'internal':
            return 'LazerVault Transfer';
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
            return 'LazerVault Transfer';
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
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                    ),
                  ),
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenReceiptView(receipt: _loadedReceipt ?? widget.receipt),
      ),
    );
  }
}

/// Full-screen receipt view with download functionality.
class FullScreenReceiptView extends StatefulWidget {
  final TransferReceiptData receipt;

  const FullScreenReceiptView({super.key, required this.receipt});

  @override
  State<FullScreenReceiptView> createState() => _FullScreenReceiptViewState();
}

class _FullScreenReceiptViewState extends State<FullScreenReceiptView> {
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.receipt;
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        title: const Text(
          'Receipt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _isDownloading ? null : _downloadReceipt,
            icon: _isDownloading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.download, color: Colors.white),
            tooltip: 'Download PDF',
          ),
          IconButton(
            onPressed: _isSharing ? null : _shareReceipt,
            icon: _isSharing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.share, color: Colors.white),
            tooltip: 'Share',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Main receipt card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Status header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: r.isSuccess
                              ? [
                                  const Color(0xFF10B981).withValues(alpha: 0.15),
                                  const Color(0xFF059669).withValues(alpha: 0.05),
                                ]
                              : [
                                  const Color(0xFFEF4444).withValues(alpha: 0.15),
                                  const Color(0xFFDC2626).withValues(alpha: 0.05),
                                ],
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: r.isSuccess
                                  ? const Color(0xFF10B981).withValues(alpha: 0.2)
                                  : const Color(0xFFEF4444).withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              r.isSuccess ? Icons.check_rounded : Icons.close_rounded,
                              color: r.isSuccess
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            r.isSuccess ? 'Transfer Successful' : 'Transfer ${r.status}',
                            style: TextStyle(
                              color: r.isSuccess
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            r.transferTypeDisplay,
                            style: const TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Amount section
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          Text(
                            '${r.currencySymbol} ${r.amountDisplay}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -1,
                            ),
                          ),
                          if (r.fee > 0) ...[
                            const SizedBox(height: 4),
                            Text(
                              'Fee: ${r.currencySymbol} ${r.feeDisplay}',
                              style: const TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 13,
                              ),
                            ),
                          ] else ...[
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                                ),
                              ),
                              child: const Text(
                                'FREE',
                                style: TextStyle(
                                  color: Color(0xFF10B981),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(color: Color(0xFF2D2D2D), height: 1),
                    ),

                    // Details section
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          if (r.description.isNotEmpty)
                            _buildDetailRow('Description', r.description),
                          if (r.recipientName.isNotEmpty)
                            _buildDetailRow('To', r.recipientName),
                          if (r.recipientBank.isNotEmpty)
                            _buildDetailRow('Bank', r.recipientBank),
                          if (r.recipientAccount.isNotEmpty)
                            _buildDetailRow('Account', _maskAccount(r.recipientAccount)),
                          _buildDetailRow('Reference', r.reference),
                          _buildDetailRow('Date', dateFormat.format(r.timestamp.toLocal())),
                          _buildDetailRow('Time', timeFormat.format(r.timestamp.toLocal())),
                          _buildDetailRow('Status', r.status.toUpperCase(),
                              valueColor: r.isSuccess
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444)),
                          if (r.newBalance > 0)
                            _buildDetailRow(
                              'New Balance',
                              '${r.currencySymbol} ${r.newBalanceDisplay}',
                            ),
                          // Render operation-specific details (bill PINs, trade info, etc.)
                          ..._buildDetailsEntries(r.details),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Bottom actions
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.download,
                      label: 'Download',
                      onTap: _isDownloading ? null : _downloadReceipt,
                      isLoading: _isDownloading,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.share,
                      label: 'Share',
                      onTap: _isSharing ? null : _shareReceipt,
                      isLoading: _isSharing,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  /// Renders entries from the `details` map as detail rows.
  /// Handles special keys like "pins" (list of token/PIN strings for bill payments).
  List<Widget> _buildDetailsEntries(Map<String, dynamic> details) {
    if (details.isEmpty) return [];
    final widgets = <Widget>[];

    // Show divider before extra details
    widgets.add(
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Divider(color: Color(0xFF2D2D2D), height: 1),
      ),
    );

    for (final entry in details.entries) {
      final key = entry.key;
      final value = entry.value;

      // Skip internal/private keys
      if (key.startsWith('_')) continue;

      // Humanize key: "bill_type" -> "Bill Type"
      final label = key
          .replaceAll('_', ' ')
          .split(' ')
          .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
          .join(' ');

      if (key == 'pins' && value is List) {
        // Bill payment PINs / tokens
        for (var i = 0; i < value.length; i++) {
          widgets.add(_buildDetailRow(
            value.length == 1 ? 'Token/PIN' : 'Token ${i + 1}',
            value[i].toString(),
          ));
        }
      } else if (value is Map) {
        // Nested map — show each sub-entry
        for (final sub in (value as Map<String, dynamic>).entries) {
          if (sub.value != null && sub.value.toString().isNotEmpty) {
            final subLabel = sub.key
                .replaceAll('_', ' ')
                .split(' ')
                .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
                .join(' ');
            widgets.add(_buildDetailRow(subLabel, sub.value.toString()));
          }
        }
      } else if (value is List) {
        widgets.add(_buildDetailRow(label, value.join(', ')));
      } else if (value != null && value.toString().isNotEmpty) {
        widgets.add(_buildDetailRow(label, value.toString()));
      }
    }

    return widgets;
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF3B82F6),
                ),
              )
            else
              Icon(icon, color: const Color(0xFF3B82F6), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _maskAccount(String account) {
    if (account.length <= 4) return account;
    return '****${account.substring(account.length - 4)}';
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final directory = await getTemporaryDirectory();
      final fileName =
          'transfer_receipt_${widget.receipt.reference.replaceAll(RegExp(r'[^a-zA-Z0-9-]'), '_')}.pdf';
      final file = File('${directory.path}/$fileName');

      // Try to download from backend URL first
      if (widget.receipt.receiptUrl != null && widget.receipt.receiptUrl!.isNotEmpty) {
        try {
          final response = await http.get(Uri.parse(widget.receipt.receiptUrl!));
          if (response.statusCode == 200) {
            await file.writeAsBytes(response.bodyBytes);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Receipt saved: $fileName'),
                  backgroundColor: const Color(0xFF10B981),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
            return;
          }
        } catch (e) {
          // Fall back to client-side generation if download fails
          debugPrint('Failed to download receipt from URL: $e');
        }
      }

      // Fallback: Generate PDF client-side
      final pdfBytes = await _generateReceiptPdf();
      await file.writeAsBytes(pdfBytes);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Receipt saved: $fileName'),
            backgroundColor: const Color(0xFF10B981),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not download receipt. Please try again.'),
            backgroundColor: Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      final directory = await getTemporaryDirectory();
      final fileName = 'LazerVault_Receipt_${widget.receipt.reference.replaceAll(RegExp(r'[^a-zA-Z0-9-]'), '_')}.pdf';
      final file = File('${directory.path}/$fileName');

      // Try to download from backend URL first
      if (widget.receipt.receiptUrl != null && widget.receipt.receiptUrl!.isNotEmpty) {
        try {
          final response = await http.get(Uri.parse(widget.receipt.receiptUrl!));
          if (response.statusCode == 200) {
            await file.writeAsBytes(response.bodyBytes);
            // ignore: deprecated_member_use
            await Share.shareXFiles(
              [XFile(file.path)],
              subject: 'LazerVault Transfer Receipt - ${widget.receipt.reference}',
            );
            return;
          }
        } catch (e) {
          debugPrint('Failed to download receipt from URL: $e');
        }
      }

      // Fallback: Generate PDF client-side
      final pdfBytes = await _generateReceiptPdf();
      await file.writeAsBytes(pdfBytes);
      // ignore: deprecated_member_use
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'LazerVault Transfer Receipt - ${widget.receipt.reference}',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not share receipt. Please try again.'),
            backgroundColor: Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  // ---- PDF Generation ----

  static pw.Font? _regularFont;
  static pw.Font? _boldFont;

  static Future<void> _loadFonts() async {
    if (_regularFont != null && _boldFont != null) return;
    try {
      final regularResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiA.ttf'));
      final boldResponse = await http.get(Uri.parse(
          'https://fonts.gstatic.com/s/inter/v18/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuGKYAZ9hiA.ttf'));
      if (regularResponse.statusCode == 200 && boldResponse.statusCode == 200) {
        _regularFont = pw.Font.ttf(regularResponse.bodyBytes.buffer.asByteData());
        _boldFont = pw.Font.ttf(boldResponse.bodyBytes.buffer.asByteData());
      }
    } catch (_) {}
  }

  static pw.TextStyle _ts({
    double fontSize = 12,
    bool isBold = false,
    PdfColor? color,
  }) {
    return pw.TextStyle(
      font: isBold ? _boldFont : _regularFont,
      fontBold: _boldFont,
      fontSize: fontSize,
      fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      color: color,
    );
  }

  Future<List<int>> _generateReceiptPdf() async {
    await _loadFonts();
    final r = widget.receipt;
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');
    final statusColor = r.isSuccess ? PdfColors.green600 : PdfColors.red600;

    pw.MemoryImage? logo;
    try {
      final data = await rootBundle.load('assets/images/logo.png');
      logo = pw.MemoryImage(data.buffer.asUint8List());
    } catch (_) {}

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (logo != null)
                    pw.Image(logo, width: 120)
                  else
                    pw.Text('LazerVault',
                        style: _ts(fontSize: 28, isBold: true)
                            .copyWith(color: PdfColors.blue800)),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Transfer Receipt',
                          style: _ts(fontSize: 18, isBold: true)
                              .copyWith(color: PdfColors.grey800)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Generated ${dateFormat.format(DateTime.now())}',
                        style: _ts(fontSize: 10, color: PdfColors.grey600),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 24),

              // Status + Amount
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(r.transferTypeDisplay,
                            style: _ts(fontSize: 20, isBold: true)
                                .copyWith(color: PdfColors.grey800)),
                        pw.SizedBox(height: 4),
                        pw.Text(r.isSuccess ? 'Completed' : r.status,
                            style: _ts(fontSize: 14, isBold: true, color: statusColor)),
                        if (r.fee == 0) ...[
                          pw.SizedBox(height: 8),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.green50,
                              borderRadius: pw.BorderRadius.circular(10),
                              border: pw.Border.all(color: PdfColors.green200),
                            ),
                            child: pw.Text('FREE TRANSFER',
                                style: _ts(
                                    fontSize: 9,
                                    isBold: true,
                                    color: PdfColors.green700)),
                          ),
                        ],
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('${r.currency} ${r.amountDisplay}',
                            style: _ts(fontSize: 28, isBold: true)),
                        if (r.newBalance > 0) ...[
                          pw.SizedBox(height: 4),
                          pw.Text(
                              'New Balance: ${r.currency} ${r.newBalanceDisplay}',
                              style: _ts(fontSize: 11, color: PdfColors.grey600)),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 32),

              // Details
              pw.Text('Transaction Details',
                  style: _ts(fontSize: 16, isBold: true)),
              pw.SizedBox(height: 12),
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey50,
                  borderRadius: pw.BorderRadius.circular(8),
                  border: pw.Border.all(color: PdfColors.grey200),
                ),
                child: pw.Column(
                  children: [
                    _pdfRow('Recipient', r.recipientName),
                    if (r.recipientBank.isNotEmpty)
                      _pdfRow('Bank', r.recipientBank),
                    if (r.recipientAccount.isNotEmpty)
                      _pdfRow('Account', r.recipientAccount),
                    _pdfRow('Amount', '${r.currency} ${r.amountDisplay}'),
                    _pdfRow('Fee', r.fee > 0
                        ? '${r.currency} ${r.feeDisplay}'
                        : '${r.currency} 0.00'),
                    pw.Divider(color: PdfColors.grey300),
                    _pdfRow('Total', '${r.currency} ${r.amountDisplay}',
                        isBold: true),
                    pw.SizedBox(height: 8),
                    _pdfRow('Reference', r.reference),
                    _pdfRow('Date', dateFormat.format(r.timestamp.toLocal())),
                    _pdfRow('Status', r.isSuccess ? 'Completed' : r.status),
                  ],
                ),
              ),

              pw.Spacer(),

              // Footer
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 12),
              pw.Center(
                child: pw.Text('Generated by LazerVault',
                    style: _ts(fontSize: 10, color: PdfColors.grey600)),
              ),
              pw.SizedBox(height: 4),
              pw.Center(
                child: pw.Text(
                    'This is an automatically generated receipt.',
                    style: _ts(fontSize: 9, color: PdfColors.grey500)),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _pdfRow(String label, String value, {bool isBold = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: _ts(fontSize: 11, color: PdfColors.grey700)),
          pw.Text(value, style: _ts(fontSize: 11, isBold: isBold)),
        ],
      ),
    );
  }
}
