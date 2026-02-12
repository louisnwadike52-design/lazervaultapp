import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../cubit/insurance_cubit.dart';

class InsurancePaymentScreen extends StatefulWidget {
  final Insurance insurance;

  const InsurancePaymentScreen({
    super.key,
    required this.insurance,
  });

  @override
  State<InsurancePaymentScreen> createState() => _InsurancePaymentScreenState();
}

class _InsurancePaymentScreenState extends State<InsurancePaymentScreen> {
  PaymentMethod selectedPaymentMethod = PaymentMethod.card;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text(
          'Pay Premium',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Insurance details card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.insurance.type.icon,
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.insurance.type.displayName,
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              widget.insurance.provider,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildInfoRow('Policy Number', widget.insurance.policyNumber),
                  SizedBox(height: 12.h),
                  _buildInfoRow('Premium Amount', '\$${widget.insurance.premiumAmount.toStringAsFixed(2)}'),
                  SizedBox(height: 12.h),
                  _buildInfoRow('Coverage', '\$${widget.insurance.coverageAmount.toStringAsFixed(0)}'),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Payment method selection
            Text(
              'Select Payment Method',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 16.h),

            ...PaymentMethod.values.map((method) => _buildPaymentMethodTile(method)),

            SizedBox(height: 32.h),

            // Pay button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  disabledBackgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.5),
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _isProcessing
                    ? SizedBox(
                        width: 24.sp,
                        height: 24.sp,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Pay \$${widget.insurance.premiumAmount.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile(PaymentMethod method) {
    final isSelected = selectedPaymentMethod == method;

    return GestureDetector(
      onTap: _isProcessing ? null : () => setState(() => selectedPaymentMethod = method),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6366F1)
                : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              method.icon,
              style: TextStyle(fontSize: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                method.displayName,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF6366F1),
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _processPayment() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final payment = await context.read<InsuranceCubit>().createPayment(
        insuranceId: widget.insurance.id,
        policyNumber: widget.insurance.policyNumber,
        amount: widget.insurance.premiumAmount,
        paymentMethod: selectedPaymentMethod,
      );

      if (!mounted) return;
      Get.toNamed(
        AppRoutes.insurancePaymentProcessing,
        arguments: payment,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to create payment: $e',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }
}
