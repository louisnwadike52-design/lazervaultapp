import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/qr_payment/domain/entities/qr_transaction_entity.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_cubit.dart';
import 'package:lazervault/src/features/qr_payment/presentation/cubit/qr_payment_state.dart';
import 'package:lazervault/src/features/qr_payment/presentation/widgets/qr_transaction_details_bottom_sheet.dart';

class QRPaymentsHistoryScreen extends StatefulWidget {
  const QRPaymentsHistoryScreen({super.key});

  @override
  State<QRPaymentsHistoryScreen> createState() =>
      _QRPaymentsHistoryScreenState();
}

class _QRPaymentsHistoryScreenState extends State<QRPaymentsHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<QRPaymentCubit>().getMyQRPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: BlocBuilder<QRPaymentCubit, QRPaymentState>(
                  builder: (context, state) {
                    if (state is QRPaymentLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: Color(0xFF3B82F6)),
                      );
                    }

                    if (state is QRPaymentsLoaded) {
                      if (state.transactions.isEmpty) {
                        return _buildEmptyState();
                      }
                      return _buildList(state.transactions);
                    }

                    if (state is QRPaymentError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              style: GoogleFonts.inter(
                                color: const Color(0xFFEF4444),
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            GestureDetector(
                              onTap: () => context
                                  .read<QRPaymentCubit>()
                                  .getMyQRPayments(),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3B82F6)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: const Color(0xFF3B82F6)
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Text(
                                  'Retry',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF3B82F6),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'QR Payments',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () => context.read<QRPaymentCubit>().getMyQRPayments(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F35),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          Center(
            child: Column(
              children: [
                Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.payment_rounded,
                    color: const Color(0xFF4B5563),
                    size: 36.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No QR payments yet',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Scan a QR code to make a payment',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4B5563),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<QRTransactionEntity> transactions) {
    return RefreshIndicator(
      onRefresh: () => context.read<QRPaymentCubit>().getMyQRPayments(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F35),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: transactions.length,
        itemBuilder: (context, index) =>
            _buildTransactionTile(transactions[index]),
      ),
    );
  }

  Widget _buildTransactionTile(QRTransactionEntity txn) {
    final color = _statusColor(txn.status);
    final icon = _statusIcon(txn.status);

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) =>
              QRTransactionDetailsBottomSheet(transaction: txn),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2A2A3E).withValues(alpha: 0.8),
              const Color(0xFF1F1F35).withValues(alpha: 0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To ${txn.recipientName}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formatDate(txn.createdAt),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '- ${txn.currency} ${txn.amount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                _buildStatusBadge(txn.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(QRTransactionStatus status) {
    final color = _statusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _statusColor(QRTransactionStatus status) {
    switch (status) {
      case QRTransactionStatus.completed:
        return const Color(0xFF10B981);
      case QRTransactionStatus.failed:
        return const Color(0xFFEF4444);
    }
  }

  IconData _statusIcon(QRTransactionStatus status) {
    switch (status) {
      case QRTransactionStatus.completed:
        return Icons.check_circle_rounded;
      case QRTransactionStatus.failed:
        return Icons.cancel_rounded;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
