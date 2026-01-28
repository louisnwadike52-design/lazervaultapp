import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/barcode_transaction_entity.dart';
import '../cubit/barcode_payment_cubit.dart';
import '../cubit/barcode_payment_state.dart';

class ScannedBarcodesHistoryScreen extends StatefulWidget {
  const ScannedBarcodesHistoryScreen({super.key});

  @override
  State<ScannedBarcodesHistoryScreen> createState() =>
      _ScannedBarcodesHistoryScreenState();
}

class _ScannedBarcodesHistoryScreenState
    extends State<ScannedBarcodesHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BarcodePaymentCubit>().getMyScannedBarcodes();
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

                    if (state is ScannedBarcodesLoaded) {
                      if (state.transactions.isEmpty) {
                        return _buildEmptyState();
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<BarcodePaymentCubit>()
                              .getMyScannedBarcodes();
                        },
                        color: const Color(0xFF4E03D0),
                        child: ListView.builder(
                          padding: EdgeInsets.all(20.w),
                          itemCount: state.transactions.length,
                          itemBuilder: (context, index) {
                            return _buildTransactionCard(
                                state.transactions[index]);
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
                  'Scanned Barcodes',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Your payment history',
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

  Widget _buildTransactionCard(BarcodeTransactionEntity transaction) {
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
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Icons.person,
                      color: const Color(0xFF4E03D0),
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.recipientName,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '@${transaction.recipientUsername}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF4E03D0),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '-${transaction.currency} ${transaction.amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (transaction.description.isNotEmpty) ...[
            Text(
              transaction.description,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.white.withValues(alpha: 0.6),
                    size: 16.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    DateFormat('MMM dd, yyyy - hh:mm a')
                        .format(transaction.createdAt),
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              _buildStatusBadge(transaction.status),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.tag,
                color: Colors.white.withValues(alpha: 0.6),
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                transaction.referenceNumber,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BarcodeTransactionStatus status) {
    final color = status == BarcodeTransactionStatus.completed
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
    final text = status.displayName;

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
            Icons.qr_code_scanner,
            color: Colors.white.withValues(alpha: 0.3),
            size: 80.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No Scanned Barcodes',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Scan a barcode to make a payment',
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
