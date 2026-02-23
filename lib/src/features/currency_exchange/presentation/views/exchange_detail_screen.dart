import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/exchange_cubit.dart';
import '../cubit/exchange_state.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../services/exchange_pdf_service.dart';

class ExchangeDetailScreen extends StatelessWidget {
  const ExchangeDetailScreen({super.key});

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
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Transaction Details',
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
                    // Status header
                    _buildStatusHeader(tx),
                    const SizedBox(height: 24),

                    // Amount card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF2D2D2D)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const Text('Sent', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                                  const SizedBox(height: 4),
                                  Text(
                                    tx.formattedFromAmount,
                                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.arrow_forward, color: Color(0xFF3B82F6), size: 24),
                              ),
                              Column(
                                children: [
                                  Text(
                                    isConversion ? 'Received' : 'Converted',
                                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    tx.formattedToAmount,
                                    style: const TextStyle(color: Color(0xFF10B981), fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Transaction Details',
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 16),
                          _buildRow('Type', isConversion ? 'Wallet Conversion' : 'International Transfer'),
                          _buildRow('Exchange Rate', '1 ${tx.fromCurrency} = ${tx.exchangeRate.toStringAsFixed(4)} ${tx.toCurrency}'),
                          if (tx.fees > 0) _buildRow('Fee', tx.formattedFees),
                          _buildRow('Total Cost', tx.formattedTotalCost),
                          if (tx.referenceNumber != null) _buildRow('Reference', tx.referenceNumber!),
                          _buildRow('Date', DateFormat('MMM d, yyyy HH:mm:ss').format(tx.createdAt)),
                          if (tx.completedAt != null)
                            _buildRow('Completed', DateFormat('MMM d, yyyy HH:mm:ss').format(tx.completedAt!)),
                          _buildRow('Status', tx.statusString),
                        ],
                      ),
                    ),

                    // Recipient details (international)
                    if (!isConversion && tx.recipientName.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF2D2D2D)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Recipient',
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            _buildRow('Name', tx.recipient.name),
                            if (tx.recipient.accountNumber.isNotEmpty)
                              _buildRow('Account', tx.recipient.accountNumber),
                            if (tx.recipient.bankName.isNotEmpty)
                              _buildRow('Bank', tx.recipient.bankName),
                            if (tx.recipient.swiftCode != null && tx.recipient.swiftCode!.isNotEmpty)
                              _buildRow('SWIFT/BIC', tx.recipient.swiftCode!),
                          ],
                        ),
                      ),
                    ],

                    // Status timeline
                    const SizedBox(height: 16),
                    _buildStatusTimeline(tx),

                    // Failure reason
                    if (tx.isFailed && tx.failureReason != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Failure Reason', style: TextStyle(color: Color(0xFFEF4444), fontSize: 12, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 4),
                            Text(tx.failureReason!, style: const TextStyle(color: Color(0xFFEF4444), fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (tx.isCompleted)
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _repeatTransaction(context, tx),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        'Repeat Transaction',
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

  Widget _buildStatusHeader(CurrencyTransaction tx) {
    Color color;
    IconData icon;
    String label;

    switch (tx.status) {
      case TransactionStatus.completed:
        color = const Color(0xFF10B981);
        icon = Icons.check_circle;
        label = 'Completed';
      case TransactionStatus.pending:
      case TransactionStatus.processing:
        color = const Color(0xFFFB923C);
        icon = Icons.schedule;
        label = 'Processing';
      case TransactionStatus.failed:
        color = const Color(0xFFEF4444);
        icon = Icons.cancel;
        label = 'Failed';
      case TransactionStatus.cancelled:
        color = const Color(0xFF6B7280);
        icon = Icons.block;
        label = 'Cancelled';
    }

    return Column(
      children: [
        Icon(icon, color: color, size: 48),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildStatusTimeline(CurrencyTransaction tx) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status Timeline',
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          _buildTimelineItem('Created', tx.createdAt, true),
          _buildTimelineItem(
            'Processing',
            tx.isProcessing || tx.isCompleted ? tx.createdAt : null,
            tx.isProcessing || tx.isCompleted,
          ),
          _buildTimelineItem(
            tx.isFailed ? 'Failed' : 'Completed',
            tx.completedAt,
            tx.isCompleted || tx.isFailed,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String label, DateTime? time, bool isActive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Container(
              width: 2,
              height: 24,
              color: isActive ? const Color(0xFF3B82F6).withValues(alpha: 0.3) : const Color(0xFF2D2D2D),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF6B7280),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (time != null)
              Text(
                DateFormat('MMM d, HH:mm').format(time),
                style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _repeatTransaction(BuildContext context, CurrencyTransaction tx) {
    final cubit = context.read<ExchangeCubit>();
    cubit.setCurrencyPair(tx.fromCurrency, tx.toCurrency);
    cubit.setMode(
      tx.recipient.name.isEmpty ? ExchangeMode.convert : ExchangeMode.sendAbroad,
    );
    Get.toNamed(AppRoutes.exchangeHome);
  }

  Future<void> _downloadReceipt(BuildContext context, CurrencyTransaction tx) async {
    try {
      final path = await ExchangePdfService.downloadReceipt(transaction: tx);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Receipt saved to $path'), backgroundColor: const Color(0xFF10B981)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e'), backgroundColor: const Color(0xFFEF4444)),
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
          SnackBar(content: Text('Failed: $e'), backgroundColor: const Color(0xFFEF4444)),
        );
      }
    }
  }
}
