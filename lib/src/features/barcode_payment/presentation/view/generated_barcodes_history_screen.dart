import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/barcode_payment_entity.dart';
import '../cubit/barcode_payment_cubit.dart';
import '../cubit/barcode_payment_state.dart';

class GeneratedBarcodesHistoryScreen extends StatefulWidget {
  const GeneratedBarcodesHistoryScreen({super.key});

  @override
  State<GeneratedBarcodesHistoryScreen> createState() =>
      _GeneratedBarcodesHistoryScreenState();
}

class _GeneratedBarcodesHistoryScreenState
    extends State<GeneratedBarcodesHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BarcodePaymentCubit>().getMyGeneratedBarcodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: BlocBuilder<BarcodePaymentCubit, BarcodePaymentState>(
                  builder: (context, state) {
                    if (state is BarcodePaymentLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            const Color(0xFF4E03D0),
                          ),
                        ),
                      );
                    }

                    if (state is BarcodePaymentError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: const Color(0xFFEF4444),
                              size: 60.sp,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is GeneratedBarcodesLoaded) {
                      if (state.barcodes.isEmpty) {
                        return _buildEmptyState();
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<BarcodePaymentCubit>()
                              .getMyGeneratedBarcodes();
                        },
                        color: const Color(0xFF4E03D0),
                        child: ListView.builder(
                          padding: EdgeInsets.all(20.w),
                          itemCount: state.barcodes.length,
                          itemBuilder: (context, index) {
                            return _buildBarcodeCard(state.barcodes[index]);
                          },
                        ),
                      );
                    }

                    return const SizedBox();
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
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Generated Barcodes',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Your payment barcodes',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcodeCard(BarcodePaymentEntity barcode) {
    final isExpired = barcode.isExpired && barcode.status == BarcodePaymentStatus.pending;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${barcode.currency} ${barcode.amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              _buildStatusBadge(barcode.status, isExpired),
            ],
          ),
          SizedBox(height: 12.h),
          if (barcode.description.isNotEmpty) ...[
            Text(
              barcode.description,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12.h),
          ],
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Colors.white.withValues(alpha: 0.6),
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                DateFormat('MMM dd, yyyy - hh:mm a').format(barcode.createdAt),
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          if (barcode.status == BarcodePaymentStatus.pending && !isExpired)
            ...[
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: const Color(0xFFFB923C),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Expires at ${DateFormat('hh:mm a').format(barcode.expiresAt)}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          if (barcode.paidAt != null) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF10B981),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Paid at ${DateFormat('hh:mm a').format(barcode.paidAt!)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BarcodePaymentStatus status, bool isExpired) {
    Color color;
    String text;

    if (isExpired) {
      color = const Color(0xFFEF4444);
      text = 'Expired';
    } else {
      switch (status) {
        case BarcodePaymentStatus.pending:
          color = const Color(0xFFFB923C);
          text = 'Pending';
          break;
        case BarcodePaymentStatus.paid:
          color = const Color(0xFF10B981);
          text = 'Paid';
          break;
        case BarcodePaymentStatus.cancelled:
          color = const Color(0xFF6B7280);
          text = 'Cancelled';
          break;
        case BarcodePaymentStatus.expired:
          color = const Color(0xFFEF4444);
          text = 'Expired';
          break;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: color,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.qr_code_2,
            color: Colors.white.withValues(alpha: 0.3),
            size: 80.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Generated Barcodes',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create a barcode to receive payments',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
