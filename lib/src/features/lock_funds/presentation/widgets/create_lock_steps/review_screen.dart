import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

import '../../../domain/entities/lock_fund_entity.dart';
import '../../cubit/create_lock_cubit.dart';
import '../../cubit/lock_funds_cubit.dart';
import '../../cubit/lock_funds_state.dart';

/// Review slide — step 4 of 5.
///
/// Slimmed down from the previous version: the heavy "Lock Details"
/// card has been folded into a compact hero strip and the per-row
/// repetition (lock amount + interest breakdown duplicating
/// principal + duration) collapsed into a single combined card.
/// The Auto-Renew toggle and Important-Notes panel were both moved
/// to the next slide (PaymentMethodSelector) so they sit next to
/// the user's payment confirmation rather than competing with it.
class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLockCubit, CreateLockState>(
      builder: (context, _) {
        final cubit = context.read<CreateLockCubit>();
        final lockType = cubit.lockType;
        final amount = cubit.amount ?? 0;
        final currency = cubit.currency;
        final durationDays = cubit.lockDurationDays ?? 0;
        final goalName = cubit.goalName;
        final goalDescription = cubit.goalDescription;
        final maturity = DateTime.now().add(Duration(days: durationDays));

        return SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Review your lock',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Confirm the details below before proceeding to payment',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 22.h),
              // Single hero card — plan + headline amount + duration +
              // maturity all on one surface so the eye doesn't have
              // to ladder through three separate boxes for the same
              // logical "what am I locking" snapshot.
              _buildHero(
                lockType: lockType,
                amount: amount,
                currency: currency,
                durationDays: durationDays,
                maturity: maturity,
                goalName: goalName,
                goalDescription: goalDescription,
              ),
              SizedBox(height: 16.h),
              // Interest breakdown — only the rows that aren't already
              // in the hero. Principal + duration removed (visible
              // above); we keep rate, interest earned, and total at
              // maturity so the user sees the bottom-line clearly.
              BlocBuilder<LockFundsCubit, LockFundsState>(
                builder: (context, lockState) {
                  if (lockState is! InterestCalculated) {
                    return const SizedBox.shrink();
                  }
                  final calc = lockState.calculation;
                  return _buildInterestCard(
                    rate: calc.interestRate,
                    interest: calc.interestAmount,
                    total: calc.totalAmount,
                    currency: currency,
                  );
                },
              ),
              if (cubit.qualifiesForUpfrontInterest) ...[
                SizedBox(height: 14.h),
                _buildUpfrontPill(),
              ],
            ],
          ),
        );
      },
    );
  }

  // Hero ───────────────────────────────────────────────────────────────

  Widget _buildHero({
    required LockType? lockType,
    required double amount,
    required String currency,
    required int durationDays,
    required DateTime maturity,
    String? goalName,
    String? goalDescription,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E03D0), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.32),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  _iconFor(lockType),
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  lockType?.displayName ?? 'Lock',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.92),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            'You are locking',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${CurrencySymbols.getSymbol(currency)}${NumberFormat('#,##0.00').format(amount)}',
            style: GoogleFonts.inter(
              fontSize: 30.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 14.h),
          // Two-up KPI strip — duration + maturity. Avoids the
          // separate "Lock Duration" / "Maturity Date" rows the old
          // review card had (each was its own line; now the visual
          // weight matches their actual importance).
          Row(
            children: [
              Expanded(
                child: _kpi(
                  label: 'Duration',
                  value: _formatDuration(durationDays),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _kpi(
                  label: 'Matures',
                  value: DateFormat('MMM d, yyyy').format(maturity),
                ),
              ),
            ],
          ),
          if (goalName != null && goalName.isNotEmpty) ...[
            SizedBox(height: 14.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goalName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (goalDescription != null &&
                      goalDescription.trim().isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      goalDescription,
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _kpi({required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // Interest breakdown card ────────────────────────────────────────────

  Widget _buildInterestCard({
    required double rate,
    required double interest,
    required double total,
    required String currency,
  }) {
    final symbol = CurrencySymbols.getSymbol(currency);
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up_rounded,
                  color: const Color(0xFF10B981), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'What you earn',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          _row('Interest rate', '${(rate * 100).toStringAsFixed(1)}% p.a.'),
          SizedBox(height: 8.h),
          _row(
            'Interest earned',
            '$symbol${NumberFormat('#,##0.00').format(interest)}',
            valueColor: const Color(0xFF10B981),
          ),
          SizedBox(height: 12.h),
          Container(height: 1, color: const Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total at maturity',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '$symbol${NumberFormat('#,##0.00').format(total)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: valueColor ?? Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildUpfrontPill() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4E03D0).withValues(alpha: 0.15),
            const Color(0xFF8B5CF6).withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.bolt_rounded, color: const Color(0xFF8B5CF6), size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Interest is paid upfront to your destination account when the lock is created.',
              style: GoogleFonts.inter(
                color: const Color(0xFFE9D5FF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconFor(LockType? type) {
    switch (type) {
      case null:
        return Icons.lock_rounded;
      case LockType.savings:
        return Icons.savings_rounded;
      case LockType.investment:
        return Icons.trending_up_rounded;
      case LockType.goalBased:
        return Icons.flag_rounded;
    }
  }

  String _formatDuration(int days) {
    if (days <= 0) return 'Flexible';
    if (days < 30) return '$days day${days == 1 ? '' : 's'}';
    if (days < 365) {
      final months = (days / 30).round();
      return '$months month${months == 1 ? '' : 's'}';
    }
    final years = days ~/ 365;
    final remDays = days % 365;
    if (remDays == 0) {
      return '$years year${years == 1 ? '' : 's'}';
    }
    final months = (remDays / 30).round();
    return '${years}y ${months}m';
  }
}
