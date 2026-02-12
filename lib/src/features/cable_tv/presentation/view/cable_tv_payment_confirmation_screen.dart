import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../../domain/entities/smart_card_validation_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

class CableTVPaymentConfirmationScreen extends StatefulWidget {
  const CableTVPaymentConfirmationScreen({super.key});

  @override
  State<CableTVPaymentConfirmationScreen> createState() =>
      _CableTVPaymentConfirmationScreenState();
}

class _CableTVPaymentConfirmationScreenState
    extends State<CableTVPaymentConfirmationScreen>
    with TransactionPinMixin {
  final _currencyFormat = NumberFormat('#,##0', 'en_NG');
  bool _isProcessing = false;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  void _onPay() async {
    if (_isProcessing) return;

    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as CableTVProviderEntity;
    final package = args['package'] as TVPackageEntity;
    final smartCardNumber = args['smartCardNumber'] as String;

    setState(() {
      _isProcessing = true;
    });

    final transactionId = const Uuid().v4();
    final idempotencyKey = const Uuid().v4();

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'cable_subscription',
      amount: package.amount,
      currency: 'NGN',
      title: 'Confirm Cable TV Payment',
      message:
          'Confirm payment of \u20A6${_currencyFormat.format(package.amount)} for ${provider.name}?',
      onPinValidated: (verificationToken) async {
        // Navigate to processing screen with all payment params.
        // The processing screen triggers the cubit call on its own cubit instance.
        Get.toNamed(
          AppRoutes.cableTVPaymentProcessing,
          arguments: {
            'provider': provider,
            'package': package,
            'validation': args['validation'],
            'smartCardNumber': smartCardNumber,
            'transactionId': transactionId,
            'verificationToken': verificationToken,
            'idempotencyKey': idempotencyKey,
          },
        );
      },
    );

    if (!success) {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final provider = args['provider'] as CableTVProviderEntity;
    final package = args['package'] as TVPackageEntity;
    final validation = args['validation'] as SmartCardValidationEntity;
    final smartCardNumber = args['smartCardNumber'] as String;

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
        child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),

                      // Detail cards
                      _buildDetailCard('Provider', provider.name, Icons.live_tv),
                      SizedBox(height: 12.h),
                      _buildDetailCard(
                        'Smart Card Number',
                        smartCardNumber,
                        Icons.credit_card,
                      ),
                      SizedBox(height: 12.h),
                      _buildDetailCard(
                        'Customer Name',
                        validation.customerName,
                        Icons.person,
                      ),
                      SizedBox(height: 12.h),
                      _buildDetailCard(
                        'Selected Package',
                        package.name,
                        Icons.subscriptions,
                      ),
                      SizedBox(height: 12.h),
                      if (validation.currentPackage.isNotEmpty) ...[
                        _buildDetailCard(
                          'Current Package',
                          validation.currentPackage,
                          Icons.playlist_add_check,
                        ),
                        SizedBox(height: 12.h),
                      ],
                      if (package.validity.isNotEmpty) ...[
                        _buildDetailCard(
                          'Validity',
                          package.validity,
                          Icons.schedule,
                        ),
                        SizedBox(height: 12.h),
                      ],

                      SizedBox(height: 8.h),

                      // Amount display
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Total Amount',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              '\u20A6${_currencyFormat.format(package.amount)}',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF10B981),
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Fee breakdown
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Service Fee',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              '\u20A60.00',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Pay button
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 16.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _isProcessing ? null : _onPay,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      disabledBackgroundColor:
                          const Color(0xFF3B82F6).withValues(alpha: 0.4),
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
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Pay \u20A6${_currencyFormat.format(package.amount)}',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
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
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
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
