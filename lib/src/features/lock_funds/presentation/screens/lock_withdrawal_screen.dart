import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../cubit/lock_funds_cubit.dart';
import '../cubit/lock_funds_state.dart';
import 'lock_withdrawal_success_screen.dart';

class LockWithdrawalScreen extends StatefulWidget {
  final LockFund lockFund;
  final bool isEarlyWithdrawal;

  const LockWithdrawalScreen({
    super.key,
    required this.lockFund,
    required this.isEarlyWithdrawal,
  });

  @override
  State<LockWithdrawalScreen> createState() => _LockWithdrawalScreenState();
}

class _LockWithdrawalScreenState extends State<LockWithdrawalScreen> {
  bool _isProcessing = false;
  bool _hasConfirmed = false;

  double get _withdrawalAmount {
    if (widget.isEarlyWithdrawal) {
      return widget.lockFund.earlyWithdrawalAmount;
    }
    return widget.lockFund.totalValue;
  }

  double get _penaltyAmount {
    if (widget.isEarlyWithdrawal) {
      return widget.lockFund.earlyWithdrawalPenalty;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LockFundsCubit, LockFundsState>(
      listener: (context, state) {
        if (state is LockFundUnlocked) {
          setState(() => _isProcessing = false);
          Get.off(() => LockWithdrawalSuccessScreen(
                lockFund: widget.lockFund,
                amountReturned: state.amountReturned,
                penaltyAmount: state.penaltyAmount,
                interestEarned: state.interestEarned,
              ));
        } else if (state is LockFundsError) {
          setState(() => _isProcessing = false);
          Get.snackbar(
            'Withdrawal Failed',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A1A3E),
                Color(0xFF0A0E27),
                Color(0xFF0F0F23),
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
                        _buildWarningBanner(),
                        SizedBox(height: 24.h),
                        _buildSummaryCard(),
                        SizedBox(height: 24.h),
                        _buildBreakdownCard(),
                        SizedBox(height: 24.h),
                        _buildConfirmationCheckbox(),
                        SizedBox(height: 32.h),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
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
                  widget.isEarlyWithdrawal ? 'Break Lock' : 'Withdraw Funds',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.lockFund.displayName,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningBanner() {
    if (!widget.isEarlyWithdrawal) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: const Color(0xFF10B981),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lock Matured!',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Congratulations! Your lock has matured. Withdraw your funds with full interest.',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFB923C).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: const Color(0xFFFB923C),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Early Withdrawal Warning',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFB923C),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Breaking your lock early will incur a ${widget.lockFund.earlyUnlockPenaltyPercent}% penalty on your principal.',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    final lock = widget.lockFund;
    final color = widget.isEarlyWithdrawal
        ? const Color(0xFFFB923C)
        : const Color(0xFF10B981);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Text(
            'You will receive',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${lock.currency} ${_withdrawalAmount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          if (widget.isEarlyWithdrawal && _penaltyAmount > 0) ...[
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Penalty: -${lock.currency} ${_penaltyAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: const Color(0xFFEF4444),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBreakdownCard() {
    final lock = widget.lockFund;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F2E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breakdown',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildBreakdownRow('Principal Amount', lock.formattedAmount, Colors.white),
          _buildBreakdownRow(
            'Interest Earned',
            '+${lock.currency} ${lock.accruedInterest.toStringAsFixed(2)}',
            const Color(0xFF10B981),
          ),
          if (widget.isEarlyWithdrawal && _penaltyAmount > 0)
            _buildBreakdownRow(
              'Early Withdrawal Penalty',
              '-${lock.currency} ${_penaltyAmount.toStringAsFixed(2)}',
              const Color(0xFFEF4444),
            ),
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total to Receive',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                '${lock.currency} ${_withdrawalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow(String label, String value, Color valueColor) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
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
              fontWeight: FontWeight.w500,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationCheckbox() {
    return GestureDetector(
      onTap: () => setState(() => _hasConfirmed = !_hasConfirmed),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: _hasConfirmed
              ? const Color(0xFF6366F1).withValues(alpha: 0.1)
              : const Color(0xFF1F1F2E),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: _hasConfirmed
                    ? const Color(0xFF6366F1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: _hasConfirmed
                      ? const Color(0xFF6366F1)
                      : const Color(0xFF6B7280),
                  width: 2,
                ),
              ),
              child: _hasConfirmed
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                widget.isEarlyWithdrawal
                    ? 'I understand that breaking this lock early will result in a penalty and I want to proceed.'
                    : 'I confirm that I want to withdraw my funds.',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        GestureDetector(
          onTap: _hasConfirmed && !_isProcessing ? _processWithdrawal : null,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              gradient: _hasConfirmed
                  ? LinearGradient(
                      colors: widget.isEarlyWithdrawal
                          ? [const Color(0xFFFB923C), const Color(0xFFF97316)]
                          : [const Color(0xFF10B981), const Color(0xFF059669)],
                    )
                  : null,
              color: _hasConfirmed ? null : const Color(0xFF3D3D3D),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: _isProcessing
                  ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      widget.isEarlyWithdrawal ? 'Break Lock & Withdraw' : 'Withdraw Funds',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _processWithdrawal() {
    HapticFeedback.mediumImpact();
    setState(() => _isProcessing = true);

    context.read<LockFundsCubit>().unlockFund(
          lockFundId: widget.lockFund.id,
          forceEarlyUnlock: widget.isEarlyWithdrawal,
        );
  }
}
