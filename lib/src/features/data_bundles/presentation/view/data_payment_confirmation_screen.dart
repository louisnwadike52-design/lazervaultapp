import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

class DataPaymentConfirmationScreen extends StatefulWidget {
  const DataPaymentConfirmationScreen({super.key});

  @override
  State<DataPaymentConfirmationScreen> createState() =>
      _DataPaymentConfirmationScreenState();
}

class _DataPaymentConfirmationScreenState
    extends State<DataPaymentConfirmationScreen>
    with TransactionPinMixin {
  final _currencyFormat = NumberFormat('#,##0', 'en_NG');
  bool _isProcessing = false;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  void _onPay() async {
    if (_isProcessing) return;

    final args = Get.arguments as Map<String, dynamic>;
    final plan = args['plan'] as DataPlanEntity;
    final network = args['network'] as String;
    final networkName = args['networkName'] as String;
    final networkColorValue = args['networkColor'] as int;
    final phoneNumber = args['phoneNumber'] as String;

    setState(() {
      _isProcessing = true;
    });

    final transactionId = const Uuid().v4();
    final idempotencyKey = const Uuid().v4();

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'data_purchase',
      amount: plan.price,
      currency: 'NGN',
      title: 'Confirm Data Purchase',
      message:
          'Confirm purchase of ${plan.name} for \u20A6${_currencyFormat.format(plan.price)}?',
      onPinValidated: (verificationToken) async {
        Get.toNamed(
          AppRoutes.dataBundlesPaymentProcessing,
          arguments: {
            'plan': plan,
            'network': network,
            'networkName': networkName,
            'networkColor': networkColorValue,
            'phoneNumber': phoneNumber,
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
    final plan = args['plan'] as DataPlanEntity;
    final networkName = args['networkName'] as String;
    final networkColorValue = args['networkColor'] as int;
    final networkColor = Color(networkColorValue);
    final phoneNumber = args['phoneNumber'] as String;

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
                    _buildDetailCard('Network', networkName, Icons.cell_tower,
                        iconColor: networkColor),
                    SizedBox(height: 12.h),
                    _buildDetailCard(
                      'Phone Number',
                      phoneNumber,
                      Icons.phone,
                    ),
                    SizedBox(height: 12.h),
                    _buildDetailCard(
                      'Data Plan',
                      plan.name,
                      Icons.wifi,
                    ),
                    SizedBox(height: 12.h),
                    if (plan.availability.isNotEmpty) ...[
                      _buildDetailCard(
                        'Validity',
                        plan.availability,
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
                          color:
                              const Color(0xFF3B82F6).withValues(alpha: 0.4),
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
                            '\u20A6${_currencyFormat.format(plan.price)}',
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
                          'Pay \u20A6${_currencyFormat.format(plan.price)}',
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

  Widget _buildDetailCard(
    String label,
    String value,
    IconData icon, {
    Color? iconColor,
  }) {
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
            color: iconColor ?? const Color(0xFF3B82F6),
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
