import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/water_provider_entity.dart';
import '../../../../../core/types/app_routes.dart';

/// Water Bill Payment Confirmation Screen
/// Shows payment details before PIN entry and processing
class WaterBillPaymentConfirmationScreenNew extends StatelessWidget {
  const WaterBillPaymentConfirmationScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as WaterProviderEntity;
    final customerNumber = args['customerNumber'] as String;
    final customerName = args['customerName'] as String?;
    final amount = args['amount'] as double;
    final outstandingBalance = args['outstandingBalance'] as String?;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Confirm Payment',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Success Icon
              Center(
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                  ),
                  child: Icon(
                    Icons.receipt_long,
                    color: const Color(0xFF4E03D0),
                    size: 40.sp,
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Title
              Center(
                child: Text(
                  'Payment Summary',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              // Provider Card
              _buildDetailCard(
                icon: Icons.water_drop,
                title: 'Provider',
                value: provider.providerName,
                color: const Color(0xFF4E03D0),
              ),

              SizedBox(height: 16.h),

              // Customer Number Card
              _buildDetailCard(
                icon: Icons.person_outline,
                title: 'Customer Number',
                value: customerNumber,
                color: const Color(0xFF10B981),
              ),

              // Customer Name (if available)
              if (customerName != null) ...[
                SizedBox(height: 16.h),
                _buildDetailCard(
                  icon: Icons.badge_outlined,
                  title: 'Customer Name',
                  value: customerName!,
                  color: const Color(0xFF6B21E0),
                ),
              ],

              SizedBox(height: 16.h),

              // Amount Card
              _buildDetailCard(
                icon: Icons.payments_outlined,
                title: 'Amount',
                value: '₦${amount.toInt()}',
                color: const Color(0xFFFBBF24),
              ),

              // Outstanding Amount (if available)
              if (outstandingBalance != null && outstandingBalance!.isNotEmpty) ...[
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: const Color(0xFFFEE2E2).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: const Color(0xFFFEE2E2),
                        size: 20.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Outstanding Bill',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              outstandingBalance!,
                              style: GoogleFonts.inter(
                                color: const Color(0xFFFEE2E2),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 32.h),

              // Fee Breakdown
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildFeeRow('Subtotal', '₦${amount.toInt()}'),
                    SizedBox(height: 12.h),
                    _buildFeeRow('Service Fee', '₦0'),
                    SizedBox(height: 12.h),
                    const Divider(color: Color(0xFF2D2D2D)),
                    SizedBox(height: 12.h),
                    _buildFeeRow(
                      'Total',
                      '₦${amount.toInt()}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Terms Checkbox
              _buildTermsCheckbox(),

              SizedBox(height: 24.h),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToPINEntry(context, args);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Confirm & Pay',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
            fontSize: isTotal ? 14.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: isTotal ? const Color(0xFF4E03D0) : Colors.white,
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
          height: 20.w,
          child: Checkbox(
            value: true,
            onChanged: null,
            fillColor: WidgetStateProperty.all(const Color(0xFF4E03D0)),
            checkColor: Colors.white,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            'I confirm this payment is authorized and I agree to the terms and conditions',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToPINEntry(BuildContext context, Map<String, dynamic> args) {
    Get.toNamed(
      AppRoutes.inputPin,
      arguments: {
        'onPinVerified': (String verificationToken) {
          // Navigate to processing screen with PIN token
          Get.toNamed(
            AppRoutes.waterBillPaymentProcessing,
            arguments: {
              ...args,
              'verificationToken': verificationToken,
            },
          );
        },
        'amount': args['amount'],
        'transactionType': 'water_bill_payment',
      },
    );
  }
}
