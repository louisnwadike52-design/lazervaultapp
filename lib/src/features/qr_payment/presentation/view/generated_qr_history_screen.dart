import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
                child: BlocConsumer<QRPaymentCubit, QRPaymentState>(
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
                        child: CircularProgressIndicator(
                            color: Color(0xFF3B82F6)),
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
                                  .getMyGeneratedQRCodes(),
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
              'Generated QR Codes',
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
      onRefresh: () => context.read<QRPaymentCubit>().getMyGeneratedQRCodes(),
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
                    Icons.qr_code_rounded,
                    color: const Color(0xFF4B5563),
                    size: 36.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No QR codes generated yet',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Generate a QR code to receive payments',
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

  Widget _buildList(List<QRPaymentEntity> qrCodes) {
    return RefreshIndicator(
      onRefresh: () => context.read<QRPaymentCubit>().getMyGeneratedQRCodes(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F35),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: _statusColor(qr.status).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.qr_code_rounded,
                    color: _statusColor(qr.status),
                    size: 22.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (qr.amount > 0)
                        Text(
                          '${qr.currency} ${qr.amount.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      else
                        Text(
                          'Static QR',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      SizedBox(height: 2.h),
                      Text(
                        qr.qrType.displayName,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(qr.status),
              ],
            ),
            if (qr.description.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text(
                qr.description,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(qr.createdAt),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4B5563),
                    fontSize: 12.sp,
                  ),
                ),
                if (qr.isPending)
                  GestureDetector(
                    onTap: () =>
                        context.read<QRPaymentCubit>().cancelQR(qrId: qr.id),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
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
    final color = _statusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _statusColor(QRPaymentStatus status) {
    switch (status) {
      case QRPaymentStatus.pending:
        return const Color(0xFFFB923C);
      case QRPaymentStatus.paid:
        return const Color(0xFF10B981);
      case QRPaymentStatus.cancelled:
        return const Color(0xFFEF4444);
      case QRPaymentStatus.expired:
        return const Color(0xFF6B7280);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
