import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Pay Premium'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
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
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              widget.insurance.provider,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
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
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 16.h),

            ...PaymentMethod.values.map((method) => _buildPaymentMethodTile(method)),

            SizedBox(height: 32.h),

            // Pay button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Pay \$${widget.insurance.premiumAmount.toStringAsFixed(2)}',
                  style: TextStyle(
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
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile(PaymentMethod method) {
    final isSelected = selectedPaymentMethod == method;
    
    return GestureDetector(
      onTap: () => setState(() => selectedPaymentMethod = method),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected 
                ? const Color.fromARGB(255, 78, 3, 208)
                : Colors.grey[300]!,
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
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color.fromARGB(255, 78, 3, 208),
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }

  void _processPayment() async {
    // Create payment
    final payment = await context.read<InsuranceCubit>().createPayment(
      insuranceId: widget.insurance.id,
      policyNumber: widget.insurance.policyNumber,
      amount: widget.insurance.premiumAmount,
      paymentMethod: selectedPaymentMethod,
    );

    // Navigate to processing screen using route with provider
    Get.toNamed(
      AppRoutes.insurancePaymentProcessing,
      arguments: payment,
    );
  }
} 