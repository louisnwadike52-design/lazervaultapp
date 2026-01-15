import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/water_provider_entity.dart';
import '../../domain/entities/customer_validation_result.dart';
import '../cubit/water_bill_cubit.dart';
import '../cubit/water_bill_state.dart';

class WaterBillPaymentConfirmationScreen extends StatefulWidget {
  const WaterBillPaymentConfirmationScreen({super.key});

  @override
  State<WaterBillPaymentConfirmationScreen> createState() => _WaterBillPaymentConfirmationScreenState();
}

class _WaterBillPaymentConfirmationScreenState extends State<WaterBillPaymentConfirmationScreen> {
  final _amountController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _initiatePayment(
    WaterProviderEntity provider,
    CustomerValidationResult validationResult,
  ) {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount',
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (amount < 1000) {
      Get.snackbar(
        'Minimum Amount',
        'Minimum payment amount is ₦1,000',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // TODO: Get account ID from user state/auth
    const accountId = 'demo-account-id';

    context.read<WaterBillCubit>().initiatePayment(
          providerCode: provider.providerCode,
          customerNumber: validationResult.customerNumber,
          amount: amount,
          currency: 'NGN',
          accountId: accountId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as WaterProviderEntity;
    final validationResult = args['validationResult'] as CustomerValidationResult;

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
          child: BlocListener<WaterBillCubit, WaterBillState>(
            listener: (context, state) {
              if (state is PaymentInitiated) {
                setState(() {
                  _isProcessing = false;
                });

                Get.toNamed(
                  '/water-bill/payment-processing',
                  arguments: {
                    'provider': provider,
                    'validationResult': validationResult,
                    'payment': state.payment,
                  },
                );
              } else if (state is WaterBillError) {
                setState(() {
                  _isProcessing = false;
                });

                Get.snackbar(
                  'Payment Failed',
                  state.message,
                  backgroundColor: Colors.red.withValues(alpha: 0.9),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 5),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Confirm Payment',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Provider Card
                          _buildDetailCard(
                            'Provider',
                            provider.providerName,
                            Icons.water_drop,
                          ),
                          SizedBox(height: 12.h),

                          // Customer Card
                          _buildDetailCard(
                            'Customer Name',
                            validationResult.customerName,
                            Icons.person,
                          ),
                          SizedBox(height: 12.h),

                          // Customer Number Card
                          _buildDetailCard(
                            'Customer Number',
                            validationResult.customerNumber,
                            Icons.numbers,
                          ),
                          SizedBox(height: 12.h),

                          // Address Card (if available)
                          if (validationResult.address != null) ...[
                            _buildDetailCard(
                              'Address',
                              validationResult.address!,
                              Icons.location_on,
                            ),
                            SizedBox(height: 12.h),
                          ],

                          // Outstanding Balance (if available)
                          if (validationResult.outstandingBalance != null) ...[
                            _buildDetailCard(
                              'Outstanding Balance',
                              validationResult.outstandingBalance!,
                              Icons.account_balance_wallet,
                            ),
                            SizedBox(height: 24.h),
                          ],

                          // Amount Input
                          Text(
                            'Enter Amount',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(0xFF3B82F6).withValues(alpha: 0.5),
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: Text(
                                    '₦',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _amountController,
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '0.00',
                                      hintStyle: GoogleFonts.inter(
                                        color: Colors.white.withValues(alpha: 0.3),
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                        horizontal: 8.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Minimum amount: ₦1,000.00',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.4),
                              fontSize: 12.sp,
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Fee breakdown
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Service Fee',
                                      style: GoogleFonts.inter(
                                        color: Colors.white.withValues(alpha: 0.6),
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      '₦0.00',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Pay Button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: _isProcessing
                          ? null
                          : () => _initiatePayment(provider, validationResult),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        disabledBackgroundColor: Colors.white.withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: _isProcessing
                          ? SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Pay Water Bill',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF3B82F6),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
