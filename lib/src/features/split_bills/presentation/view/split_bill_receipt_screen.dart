import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../services/split_bill_pdf_service.dart';

class SplitBillReceiptScreen extends StatefulWidget {
  const SplitBillReceiptScreen({super.key});

  @override
  State<SplitBillReceiptScreen> createState() => _SplitBillReceiptScreenState();
}

class _SplitBillReceiptScreenState extends State<SplitBillReceiptScreen> {
  late final String transactionReference;
  late final double amount;
  late final String currency;
  late final String creatorName;
  late final String description;
  late final int paidCount;
  late final int totalParticipants;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    transactionReference = args['transactionReference'] as String? ?? '';
    amount = (args['amount'] as num?)?.toDouble() ?? 0.0;
    currency = args['currency'] as String? ?? 'NGN';
    creatorName = args['creatorName'] as String? ?? 'Unknown';
    description = args['description'] as String? ?? '';
    paidCount = args['paidCount'] as int? ?? 0;
    totalParticipants = args['totalParticipants'] as int? ?? 0;
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await SplitBillPdfService.downloadReceipt(
        transactionReference: transactionReference,
        amount: amount,
        currency: currency,
        creatorName: creatorName,
        description: description,
        paidCount: paidCount,
        totalParticipants: totalParticipants,
      );
      Get.snackbar(
        'Download Complete',
        'Receipt saved to: ${path.split('/').last}',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Could not download receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await SplitBillPdfService.shareReceipt(
        transactionReference: transactionReference,
        amount: amount,
        currency: currency,
        creatorName: creatorName,
        description: description,
        paidCount: paidCount,
        totalParticipants: totalParticipants,
      );
    } catch (e) {
      Get.snackbar(
        'Share Failed',
        'Could not share receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isSharing = false);
    }
  }

  String get _formattedAmount {
    return '${_currencySymbol(currency)}${amount.toStringAsFixed(2)}';
  }

  String _currencySymbol(String code) {
    switch (code) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'GHS':
        return 'GH\u20B5';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return '$code ';
    }
  }

  String _formatDate(DateTime dt) {
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year;
    return '$day/$month/$year';
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.splitBills),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Payment Receipt',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    _buildSuccessIcon(),
                    const SizedBox(height: 24),
                    const Text(
                      'Payment Successful!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your share has been paid',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildAmountCard(),
                    const SizedBox(height: 24),
                    _buildTransactionDetails(now),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildSplitBillInfo(),
                    ],
                  ],
                ),
              ),
            ),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check_circle,
        color: Color(0xFF10B981),
        size: 60,
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Amount Paid',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formattedAmount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetails(DateTime now) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transaction Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailRow('Paid to', creatorName),
          const SizedBox(height: 12),
          _buildDetailRow('Reference', transactionReference),
          const SizedBox(height: 12),
          _buildDetailRow('Status', 'Paid'),
          const SizedBox(height: 12),
          _buildDetailRow('Date', _formatDate(now)),
          const SizedBox(height: 12),
          _buildDetailRow('Time', _formatTime(now)),
        ],
      ),
    );
  }

  Widget _buildSplitBillInfo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.receipt_long,
              color: Color(0xFF3B82F6),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Part of: $description',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '$paidCount/$totalParticipants paid',
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: GestureDetector(
            onLongPress: label == 'Reference'
                ? () {
                    Clipboard.setData(ClipboardData(text: value));
                    Get.snackbar(
                      'Copied',
                      'Reference copied to clipboard',
                      backgroundColor: const Color(0xFF10B981),
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                    );
                  }
                : null,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isSharing ? null : _shareReceipt,
                    icon: _isSharing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.share, size: 18),
                    label: Text(
                      _isSharing ? 'Sharing...' : 'Share',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isDownloading ? null : _downloadReceipt,
                    icon: _isDownloading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.download, size: 18),
                    label: Text(
                      _isDownloading ? 'Saving...' : 'Download',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed(AppRoutes.splitBills),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
