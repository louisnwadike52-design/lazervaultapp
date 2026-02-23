import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../services/exchange_pdf_service.dart';

class ExchangeReceiptScreen extends StatelessWidget {
  const ExchangeReceiptScreen({super.key});

  CurrencyTransaction get _transaction => Get.arguments as CurrencyTransaction;

  @override
  Widget build(BuildContext context) {
    final tx = _transaction;
    final isConversion = tx.type == TransactionType.exchange;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        title: const Text(
          'Exchange Receipt',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Success icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: tx.isCompleted
                            ? const Color(0xFF10B981).withValues(alpha: 0.15)
                            : tx.isFailed
                                ? const Color(0xFFEF4444).withValues(alpha: 0.15)
                                : const Color(0xFFFB923C).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        tx.isCompleted ? Icons.check : tx.isFailed ? Icons.close : Icons.schedule,
                        color: tx.isCompleted
                            ? const Color(0xFF10B981)
                            : tx.isFailed
                                ? const Color(0xFFEF4444)
                                : const Color(0xFFFB923C),
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      tx.isCompleted
                          ? (isConversion ? 'Conversion Successful' : 'Transfer Initiated')
                          : tx.isFailed
                              ? 'Transaction Failed'
                              : 'Processing',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${tx.formattedFromAmount} → ${tx.formattedToAmount}',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 16,
                      ),
                    ),

                    if (tx.isFailed && tx.failureReason != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tx.failureReason!,
                          style: const TextStyle(color: Color(0xFFEF4444), fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Details card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF2D2D2D)),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow('Type', isConversion ? 'Conversion' : 'International Transfer'),
                          _buildDetailRow('From', tx.formattedFromAmount),
                          _buildDetailRow('To', tx.formattedToAmount),
                          _buildDetailRow('Exchange Rate', '1 ${tx.fromCurrency} = ${tx.exchangeRate.toStringAsFixed(4)} ${tx.toCurrency}'),
                          if (tx.fees > 0)
                            _buildDetailRow('Fee', tx.formattedFees),
                          _buildDetailRow('Total Cost', tx.formattedTotalCost),
                          if (!isConversion && tx.recipientName.isNotEmpty)
                            _buildDetailRow('Recipient', tx.recipientName),
                          _buildDetailRow('Status', tx.statusString),
                          if (tx.referenceNumber != null)
                            _buildDetailRow('Reference', tx.referenceNumber!),
                          _buildDetailRow('Date', DateFormat('MMM d, yyyy HH:mm').format(tx.createdAt)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (tx.isCompleted) ...[
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _downloadReceipt(context, tx),
                            icon: const Icon(Icons.download, size: 18),
                            label: const Text('Download'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFF2D2D2D)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _shareReceipt(context, tx),
                            icon: const Icon(Icons.share, size: 18),
                            label: const Text('Share'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFF2D2D2D)),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadReceipt(BuildContext context, CurrencyTransaction tx) async {
    try {
      final path = await ExchangePdfService.downloadReceipt(transaction: tx);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Receipt saved to $path'),
            backgroundColor: const Color(0xFF10B981),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save receipt: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  Future<void> _shareReceipt(BuildContext context, CurrencyTransaction tx) async {
    try {
      await ExchangePdfService.shareReceipt(transaction: tx);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share receipt: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }
}
