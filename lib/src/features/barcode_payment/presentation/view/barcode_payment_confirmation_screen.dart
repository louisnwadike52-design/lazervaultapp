import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/barcode_payment_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../../authentication/domain/entities/account.dart';
import '../cubit/barcode_payment_cubit.dart';
import '../cubit/barcode_payment_state.dart';

class BarcodePaymentConfirmationScreen extends StatefulWidget {
  const BarcodePaymentConfirmationScreen({super.key});

  @override
  State<BarcodePaymentConfirmationScreen> createState() =>
      _BarcodePaymentConfirmationScreenState();
}

class _BarcodePaymentConfirmationScreenState
    extends State<BarcodePaymentConfirmationScreen> {
  // Use a default account for now - can be enhanced later with account selection
  final String _defaultAccountId = 'default';

  void _processPayment() {
    final barcode = Get.arguments['barcode'] as BarcodePaymentEntity;

    // Navigate to processing screen first
    Get.toNamed(
      AppRoutes.barcodePaymentProcessing,
      arguments: {
        'barcode': barcode,
        'sourceAccountId': _defaultAccountId,
      },
    );

    // Then trigger the payment
    Future.delayed(const Duration(milliseconds: 500), () {
      context.read<BarcodePaymentCubit>().processBarcodePayment(
            barcodeCode: barcode.barcodeCode,
            sourceAccountId: _defaultAccountId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final barcode = Get.arguments['barcode'] as BarcodePaymentEntity;

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      _buildAmountCard(barcode),
                      SizedBox(height: 24.h),
                      _buildRecipientCard(barcode),
                      SizedBox(height: 24.h),
                      _buildAccountSelector(),
                      SizedBox(height: 24.h),
                      if (barcode.description.isNotEmpty)
                        _buildDescriptionCard(barcode),
                      SizedBox(height: 32.h),
                      _buildConfirmButton(),
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
            onTap: () => Get.back(),
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
                  'Confirm Payment',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Review details before paying',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.6),
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

  Widget _buildAmountCard(BarcodePaymentEntity barcode) {
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
              Text(
                'Amount to Pay',
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.lock_outline,
                color: Colors.white.withOpacity(0.7),
                size: 14.sp,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '${barcode.currency} ${barcode.amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 36.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientCard(BarcodePaymentEntity barcode) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Recipient',
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.lock_outline,
                color: Colors.white.withOpacity(0.4),
                size: 14.sp,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Icon(
                  Icons.person,
                  color: const Color(0xFF4E03D0),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      barcode.fullName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '@${barcode.username}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF4E03D0),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSelector() {
    // Simplified account display - not selectable for now
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF4E03D0).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4E03D0),
                  Color(0xFF6B21E0),
                ],
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Main Wallet',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Default Account',
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: const Color(0xFF10B981),
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOption(Account account) {
    return const SizedBox(); // Placeholder - not used for now
  }

  Widget _buildDescriptionCard(BarcodePaymentEntity barcode) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Description',
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.lock_outline,
                color: Colors.white.withOpacity(0.4),
                size: 14.sp,
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            barcode.description,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return BlocBuilder<BarcodePaymentCubit, BarcodePaymentState>(
      builder: (context, state) {
        final isLoading = state is BarcodePaymentProcessing;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _processPayment,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              disabledBackgroundColor: const Color(0xFF10B981).withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Confirm Payment',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }
}
