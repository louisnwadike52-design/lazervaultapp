import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../../../../core/types/app_routes.dart';

class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payment = Get.arguments['payment'] as BillPaymentEntity;

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
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    children: [
                      _buildSuccessAnimation(),
                      SizedBox(height: 24.h),
                      Text(
                        'Payment Successful!',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        payment.isPrepaid
                            ? 'Your electricity token is ready'
                            : 'Your payment has been processed',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),
                      if (payment.hasToken) _buildTokenCard(payment),
                      if (payment.hasToken) SizedBox(height: 24.h),
                      _buildReceiptCard(payment),
                      SizedBox(height: 24.h),
                      _buildActionButtons(),
                    ],
                  ),
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
            onTap: () {
              Get.until((route) => route.settings.name == AppRoutes.electricityBillHome);
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Receipt',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 44.w),
        ],
      ),
    );
  }

  Widget _buildSuccessAnimation() {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4E03D0),
            const Color(0xFF6B21E0),
          ],
        ),
      ),
      child: Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 64.sp,
      ),
    );
  }

  Widget _buildTokenCard(BillPaymentEntity payment) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4E03D0),
            const Color(0xFF6B21E0),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bolt,
                color: Colors.white,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Electricity Token',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SelectableText(
              payment.token ?? '',
              style: GoogleFonts.robotoMono(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              if (payment.token != null) {
                Clipboard.setData(ClipboardData(text: payment.token!));
                Get.snackbar(
                  'Copied',
                  'Token copied to clipboard',
                  backgroundColor: Colors.green.withOpacity(0.9),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.copy,
                  color: Colors.white.withOpacity(0.9),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Copy Token',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (payment.units != null) ...[
            SizedBox(height: 16.h),
            Text(
              '${payment.units!.toStringAsFixed(2)} kWh',
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReceiptCard(BillPaymentEntity payment) {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),
          _buildReceiptRow('Provider', payment.providerName),
          _buildReceiptRow('Customer', payment.customerName),
          _buildReceiptRow('Meter Number', payment.meterNumber),
          _buildReceiptRow('Meter Type', payment.meterType.displayName),
          Divider(color: Colors.white.withOpacity(0.1), height: 32.h),
          _buildReceiptRow('Amount', '₦${payment.amount.toStringAsFixed(2)}'),
          _buildReceiptRow('Service Fee', '₦${payment.serviceFee.toStringAsFixed(2)}'),
          _buildReceiptRow(
            'Total',
            '₦${payment.totalAmount.toStringAsFixed(2)}',
            isHighlighted: true,
          ),
          Divider(color: Colors.white.withOpacity(0.1), height: 32.h),
          _buildReceiptRow('Reference', payment.referenceNumber),
          _buildReceiptRow('Payment Gateway', payment.paymentGateway.toUpperCase()),
          _buildReceiptRow('Date', dateFormat.format(payment.completedAt ?? payment.createdAt)),
          _buildReceiptRow(
            'Status',
            payment.status.displayName,
            valueColor: const Color(0xFF4CAF50),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value, {
    bool isHighlighted = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.6),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: valueColor ?? (isHighlighted ? Colors.white : Colors.white.withOpacity(0.9)),
                fontSize: isHighlighted ? 18.sp : 14.sp,
                fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.electricityBillHome);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4E03D0),
                  const Color(0xFF6B21E0),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              'Make Another Payment',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.electricityBillHistory);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Text(
              'View Payment History',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
