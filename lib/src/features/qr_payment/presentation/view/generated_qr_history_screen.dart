import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_payment_entity.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_cubit.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_state.dart';
import 'package:lazervault/src/features/qr_payment/presentation/widgets/qr_code_details_bottom_sheet.dart';

class GeneratedQRHistoryScreen extends StatefulWidget {
  const GeneratedQRHistoryScreen({super.key});

  @override
  State<GeneratedQRHistoryScreen> createState() =>
      _GeneratedQRHistoryScreenState();
}

class _GeneratedQRHistoryScreenState extends State<GeneratedQRHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QRPaymentCubit>().getMyGeneratedQRCodes();
  }

  @override
  Widget build(BuildContext context) {
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
          'Generated QR Codes',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<QRPaymentCubit, QRPaymentState>(
        listener: (context, state) {
          if (state is QRCancelled) {
            Get.snackbar(
              'Success',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
          if (state is QRPaymentLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          if (state is GeneratedQRCodesLoaded) {
            if (state.qrCodes.isEmpty) {
              return _buildEmptyState();
            }
            return _buildList(state.qrCodes);
          }

          if (state is QRPaymentError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Color(0xFFEF4444)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () =>
                        context.read<QRPaymentCubit>().getMyGeneratedQRCodes(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () => context.read<QRPaymentCubit>().getMyGeneratedQRCodes(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          const Center(
            child: Column(
              children: [
                Icon(Icons.qr_code, color: Color(0xFF4B5563), size: 48),
                SizedBox(height: 16),
                Text(
                  'No QR codes generated yet',
                  style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<QRPaymentEntity> qrCodes) {
    return RefreshIndicator(
      onRefresh: () => context.read<QRPaymentCubit>().getMyGeneratedQRCodes(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: qrCodes.length,
        itemBuilder: (context, index) => _buildQRCodeTile(qrCodes[index]),
      ),
    );
  }

  Widget _buildQRCodeTile(QRPaymentEntity qr) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) => QRCodeDetailsBottomSheet(qrCode: qr),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (qr.amount > 0)
                Text(
                  '${qr.currency} ${qr.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              else
                const Text(
                  'Static QR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              _buildStatusBadge(qr.status),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            qr.qrCode,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
          ),
          if (qr.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              qr.description,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(qr.createdAt),
                style:
                    const TextStyle(color: Color(0xFF4B5563), fontSize: 12),
              ),
              if (qr.isPending)
                GestureDetector(
                  onTap: () =>
                      context.read<QRPaymentCubit>().cancelQR(qrId: qr.id),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFFEF4444),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildStatusBadge(QRPaymentStatus status) {
    Color color;
    switch (status) {
      case QRPaymentStatus.pending:
        color = const Color(0xFFFB923C);
      case QRPaymentStatus.paid:
        color = const Color(0xFF10B981);
      case QRPaymentStatus.cancelled:
        color = const Color(0xFFEF4444);
      case QRPaymentStatus.expired:
        color = const Color(0xFF6B7280);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
            color: color, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
