import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../domain/entities/smartcard_validation_result.dart';
import '../cubit/tv_subscription_cubit.dart';
import '../cubit/tv_subscription_state.dart';

class TVPaymentConfirmationScreen extends StatefulWidget {
  const TVPaymentConfirmationScreen({super.key});

  @override
  State<TVPaymentConfirmationScreen> createState() => _TVPaymentConfirmationScreenState();
}

class _TVPaymentConfirmationScreenState extends State<TVPaymentConfirmationScreen> {
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
  }

  void _initiatePayment(
    TVProviderEntity provider,
    TVPackageEntity package,
    SmartcardValidationResult validationResult,
  ) {
    setState(() {
      _isProcessing = true;
    });

    // TODO: Get account ID from user state/auth
    const accountId = 'demo-account-id';

    context.read<TVSubscriptionCubit>().initiatePayment(
          providerCode: provider.providerCode,
          packageCode: package.packageCode,
          smartcardNumber: validationResult.smartcardNumber,
          amount: package.price,
          currency: package.currency,
          accountId: accountId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as TVProviderEntity;
    final package = args['package'] as TVPackageEntity;
    final validationResult = args['validationResult'] as SmartcardValidationResult;

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
          child: BlocListener<TVSubscriptionCubit, TVSubscriptionState>(
            listener: (context, state) {
              if (state is PaymentInitiated) {
                setState(() {
                  _isProcessing = false;
                });

                Get.toNamed(
                  '/tv-subscription/payment-processing',
                  arguments: {
                    'provider': provider,
                    'package': package,
                    'validationResult': validationResult,
                    'payment': state.payment,
                  },
                );
              } else if (state is TVSubscriptionError) {
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
                            Icons.tv,
                          ),
                          SizedBox(height: 12.h),

                          // Package Card
                          _buildDetailCard(
                            'Package',
                            package.packageName,
                            Icons.subscriptions,
                          ),
                          SizedBox(height: 12.h),

                          // Customer Name Card
                          _buildDetailCard(
                            'Customer Name',
                            validationResult.customerName,
                            Icons.person,
                          ),
                          SizedBox(height: 12.h),

                          // Smartcard Number Card
                          _buildDetailCard(
                            'Smartcard Number',
                            validationResult.smartcardNumber,
                            Icons.credit_card,
                          ),
                          SizedBox(height: 12.h),

                          // Current Package (if available)
                          if (validationResult.currentPackage != null) ...[
                            _buildDetailCard(
                              'Current Package',
                              validationResult.currentPackage!,
                              Icons.playlist_add_check,
                            ),
                            SizedBox(height: 12.h),
                          ],

                          // Renewal Date (if available)
                          if (validationResult.renewalDate != null) ...[
                            _buildDetailCard(
                              'Current Renewal Date',
                              validationResult.renewalDate!,
                              Icons.event,
                            ),
                            SizedBox(height: 24.h),
                          ],

                          // Amount Display
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF2A2A3E).withValues(alpha: 0.8),
                                  const Color(0xFF1F1F35).withValues(alpha: 0.9),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: const Color(0xFF8B5CF6).withValues(alpha: 0.5),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Total Amount',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  package.formattedPrice,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF10B981),
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    package.formattedDuration,
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF8B5CF6),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),

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
                          : () => _initiatePayment(provider, package, validationResult),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
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
                              'Pay ${package.formattedPrice}',
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
            color: const Color(0xFF8B5CF6),
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
