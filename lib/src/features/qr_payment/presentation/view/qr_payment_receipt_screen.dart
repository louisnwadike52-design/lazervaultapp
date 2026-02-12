import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_transaction_entity.dart';
import 'package:lazervault/src/features/qr_payment/services/qr_pay_pdf_service.dart';

class QRPaymentReceiptScreen extends StatelessWidget {
  const QRPaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final transaction = args?['transaction'] as QRTransactionEntity?;
    final newBalance = args?['newBalance'] as double?;

    if (transaction == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: Center(
          child: Text(
            'No transaction data',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Payment Receipt',
          style: TextStyle(color: Colors.white, fontSize: 20),
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
                  children: [
                    _buildSuccessIcon(),
                    const SizedBox(height: 24),
                    _buildAmountCard(transaction),
                    if (newBalance != null) ...[
                      const SizedBox(height: 12),
                      _buildNewBalanceCard(transaction.currency, newBalance),
                    ],
                    const SizedBox(height: 20),
                    _buildDetailsCard(transaction),
                  ],
                ),
              ),
            ),
            _buildActions(context, transaction),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check_circle,
        color: Color(0xFF10B981),
        size: 56,
      ),
    );
  }

  Widget _buildAmountCard(QRTransactionEntity txn) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Payment Successful',
            style: TextStyle(
              color: Color(0xFF10B981),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${txn.currency} ${txn.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sent to ${txn.recipientName}',
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildNewBalanceCard(String currency, double balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'New Balance: ',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
          Text(
            '$currency ${balance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(QRTransactionEntity txn) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow('Recipient', '@${txn.recipientUsername}'),
          _buildDivider(),
          _buildDetailRow('Reference', txn.referenceNumber),
          _buildDivider(),
          _buildDetailRow('Status', txn.status.displayName),
          if (txn.description.isNotEmpty) ...[
            _buildDivider(),
            _buildDetailRow('Description', txn.description),
          ],
          _buildDivider(),
          _buildDetailRow('Date', _formatDate(txn.createdAt)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: Color(0xFF2D2D2D), height: 1);
  }

  Widget _buildActions(BuildContext context, QRTransactionEntity txn) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _downloadReceipt(txn),
              icon: const Icon(Icons.download, size: 18),
              label: const Text('Download'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF2D2D2D)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _shareReceipt(txn),
              icon: const Icon(Icons.share, size: 18),
              label: const Text('Share'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadReceipt(QRTransactionEntity txn) async {
    try {
      final path = await QRPayPdfService.downloadReceipt(transaction: txn);
      Get.snackbar(
        'Downloaded',
        'Receipt saved to $path',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to download receipt',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
    }
  }

  Future<void> _shareReceipt(QRTransactionEntity txn) async {
    try {
      await QRPayPdfService.shareReceipt(transaction: txn);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to share receipt',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
