import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Transition;
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import 'payment_receipt_screen.dart';
import 'dart:async';

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _pollingTimer;
  String? _currentPaymentId;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pollingTimer?.cancel();
    super.dispose();
  }

  void _startPolling(String paymentId) {
    if (_currentPaymentId == paymentId) return;
    _currentPaymentId = paymentId;

    // Poll every 3 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      context.read<ElectricityBillCubit>().verifyPayment(paymentId: paymentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as ElectricityProviderEntity;
    final validationResult = args['validationResult'] as MeterValidationResult;
    final amount = args['amount'] as double;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
            child: BlocConsumer<ElectricityBillCubit, ElectricityBillState>(
              listener: (context, state) {
                if (state is PaymentInitiated || state is PaymentProcessing) {
                  final payment = state is PaymentInitiated
                      ? (state as PaymentInitiated).payment
                      : (state as PaymentProcessing).payment;

                  _startPolling(payment.id);
                }

                if (state is PaymentSuccess) {
                  _pollingTimer?.cancel();

                  Get.off(
                    () => const PaymentReceiptScreen(),
                    arguments: {'payment': state.payment},
                  );
                }

                if (state is PaymentFailed) {
                  _pollingTimer?.cancel();

                  Get.snackbar(
                    'Payment Failed',
                    state.errorMessage,
                    backgroundColor: Colors.red.withOpacity(0.9),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 5),
                  );

                  Future.delayed(const Duration(seconds: 3), () {
                    if (mounted) {
                      Get.back();
                      Get.back();
                    }
                  });
                }

                if (state is ElectricityBillError) {
                  _pollingTimer?.cancel();

                  Get.snackbar(
                    'Error',
                    state.message,
                    backgroundColor: Colors.red.withOpacity(0.9),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 5),
                  );
                }
              },
              builder: (context, state) {
                String statusMessage = 'Initiating payment...';
                if (state is PaymentProcessing) {
                  statusMessage = state.message;
                } else if (state is PaymentVerifying) {
                  statusMessage = 'Verifying payment...';
                }

                return Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _animationController.value * 2 * 3.14159,
                            child: Container(
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
                              child: Center(
                                child: Icon(
                                  Icons.bolt,
                                  color: Colors.white,
                                  size: 56.sp,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 48.h),
                      Text(
                        'Processing Payment',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        statusMessage,
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 48.h),
                      _buildDetailCard(
                        'Provider',
                        provider.providerName,
                        Icons.bolt,
                      ),
                      SizedBox(height: 12.h),
                      _buildDetailCard(
                        'Customer',
                        validationResult.customerName,
                        Icons.person,
                      ),
                      SizedBox(height: 12.h),
                      _buildDetailCard(
                        'Meter Number',
                        validationResult.meterNumber,
                        Icons.numbers,
                      ),
                      SizedBox(height: 12.h),
                      _buildDetailCard(
                        'Amount',
                        '₦${amount.toStringAsFixed(2)}',
                        Icons.account_balance_wallet,
                      ),
                      SizedBox(height: 48.h),
                      Text(
                        'Please wait while we process your payment\nThis may take a few moments',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF4E03D0),
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
                    color: Colors.white.withOpacity(0.6),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Import for receipt screen
class PaymentReceiptScreen extends StatelessWidget {
  const PaymentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder - will be created next
    return const Scaffold();
  }
}
