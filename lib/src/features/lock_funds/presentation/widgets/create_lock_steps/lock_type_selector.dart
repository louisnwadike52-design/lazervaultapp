import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart'
    as currency_formatter;
import '../../../domain/entities/lock_fund_entity.dart';
import '../../cubit/create_lock_cubit.dart';

/// Lock type selection — top half of wizard step 1 (Plan & Amount).
///
/// Displays rates dynamically from backend PiggyVault configs.
/// Falls back to hardcoded enum values when backend is unavailable.
class LockTypeSelector extends StatelessWidget {
  const LockTypeSelector({super.key});

  // Cosmetic icon + premium-tag per plan slug. Plans are identified
  // by their config id; this map only drives decoration and safely
  // defaults for admin-defined slugs the app doesn't recognise.
  static (IconData, bool) _decorFor(String lockType) {
    switch (lockType.trim().toLowerCase()) {
      case 'savings':
        return (Icons.savings_rounded, false);
      case 'investment':
        return (Icons.trending_up_rounded, true);
      case 'goal_based':
        return (Icons.flag_rounded, true);
      default:
        return (Icons.lock_rounded, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLockCubit, CreateLockState>(
      builder: (context, state) {
        final cubit = context.read<CreateLockCubit>();
        // Render one card per active backend plan, identified by its
        // config id — so whatever plans ops publish (including new or
        // renamed ones) appear here without a client change. When the
        // config list hasn't loaded yet (cold start / offline) fall
        // back to the three canonical enum plans so the wizard still
        // renders something.
        final plans = cubit.activePlans;

        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Lock Type',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Select a Piggyvault that suits your financial goals',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 24.h),
              if (plans.isNotEmpty)
                for (final config in plans) ...[
                  Builder(builder: (_) {
                    final decor = _decorFor(config.lockType);
                    return _buildLockTypeCard(
                      context: context,
                      icon: decor.$1,
                      title: config.displayName,
                      description: config.description,
                      baseRate: config.baseRatePercent,
                      maxRate: config.maxRatePercent,
                      isPremium: decor.$2,
                      isSelected: cubit.selectedConfigId == config.id,
                      onTap: () => cubit.selectConfig(config),
                      // Info icon → full plan details, so users can compare
                      // before choosing. Only the config-driven path has the
                      // full data; the offline enum fallback below omits it.
                      onInfo: () => _showPlanDetails(context, config),
                    );
                  }),
                  SizedBox(height: 16.h),
                ]
              else
                // Offline / pre-load fallback: canonical enum plans.
                for (final entry in [
                  (LockType.savings, Icons.savings_rounded, false),
                  (LockType.investment, Icons.trending_up_rounded, true),
                  (LockType.goalBased, Icons.flag_rounded, true),
                ]) ...[
                  _buildLockTypeCard(
                    context: context,
                    icon: entry.$2,
                    title: cubit.getDisplayName(entry.$1),
                    description: cubit.getDescription(entry.$1),
                    baseRate: cubit.getBaseRate(entry.$1),
                    maxRate: cubit.getMaxRate(entry.$1),
                    isPremium: entry.$3,
                    isSelected: cubit.lockType == entry.$1,
                    onTap: () => cubit.updateLockType(entry.$1),
                  ),
                  SizedBox(height: 16.h),
                ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildLockTypeCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required double baseRate,
    double? maxRate,
    bool isPremium = false,
    required bool isSelected,
    required VoidCallback onTap,
    VoidCallback? onInfo,
  }) {
    final rateText = maxRate != null && maxRate != baseRate
        ? '${baseRate.toStringAsFixed(0)}-${maxRate.toStringAsFixed(0)}%'
        : '${baseRate.toStringAsFixed(0)}%';
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [const Color(0xFF6366F1), const Color.fromARGB(255, 78, 3, 208)]
                : [const Color(0xFF2A2A3E), const Color(0xFF1F1F35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? const Color(0xFF6366F1).withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.2),
              blurRadius: isSelected ? 20 : 16,
              offset: Offset(0, isSelected ? 10 : 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: isSelected ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                size: 32.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: isPremium
                                ? const Color(0xFFF59E0B).withValues(alpha: isSelected ? 0.3 : 0.2)
                                : const Color(0xFF10B981).withValues(alpha: isSelected ? 0.3 : 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '$rateText p.a.',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              color: isPremium
                                  ? const Color(0xFFF59E0B)
                                  : const Color(0xFF10B981),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.9)
                          : const Color(0xFF9CA3AF),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Info button — opens the full plan details modal. Its own tap
            // target sits inside the card's GestureDetector; the inner tap wins
            // so tapping "i" shows details without also selecting the plan.
            if (onInfo != null)
              GestureDetector(
                onTap: onInfo,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.9)
                        : const Color(0xFF9CA3AF),
                    size: 22.sp,
                  ),
                ),
              ),
            SizedBox(width: 6.w),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  /// Bottom-sheet with the full details of a plan, so a user can understand
  /// exactly what they're choosing before they commit: rate, duration and
  /// amount ranges, how interest pays out (upfront vs at maturity), the
  /// early-withdrawal policy + penalty, supported features, and the admin's
  /// own "before you confirm" notes.
  void _showPlanDetails(BuildContext context, PiggyVaultConfig config) {
    String money(double amt) =>
        currency_formatter.CurrencySymbols.formatAmountWithCurrency(
            amt, config.currency);

    String durationText() {
      String fmt(int days) {
        if (days <= 0) return 'flexible';
        if (days < 30) return '$days days';
        if (days < 365) return '${(days / 30).floor()} months';
        return '${(days / 365).floor()} year(s)';
      }

      if (config.minDurationDays <= 0 && config.maxDurationDays <= 0) {
        return 'Flexible — withdraw anytime';
      }
      if (config.maxDurationDays <= 0 ||
          config.minDurationDays == config.maxDurationDays) {
        return fmt(config.minDurationDays);
      }
      return '${fmt(config.minDurationDays)} – ${fmt(config.maxDurationDays)}';
    }

    String amountText() {
      if (config.isFixedAmount && config.fixedAmount > 0) {
        return 'Fixed at ${money(config.fixedAmount)}';
      }
      final min = 'From ${money(config.minAmount)}';
      if (config.maxAmount > 0) {
        return '$min to ${money(config.maxAmount)}';
      }
      return min;
    }

    final rows = <(IconData, String, String)>[
      (Icons.percent_rounded, 'Interest rate', config.interestRangeText),
      (Icons.schedule_rounded, 'Duration', durationText()),
      (Icons.account_balance_wallet_rounded, 'Amount', amountText()),
      (
        Icons.savings_rounded,
        'Interest payout',
        config.supportsUpfrontInterest
            ? 'Paid upfront when you lock'
            : 'Accrues and pays at maturity',
      ),
      (
        config.allowsEarlyWithdrawal ? Icons.lock_open_rounded : Icons.lock_rounded,
        'Early withdrawal',
        config.allowsEarlyWithdrawal
            ? (config.penaltyPercent > 0
                ? 'Allowed — ${config.penaltyPercent.toStringAsFixed(0)}% penalty on the amount'
                : 'Allowed, no penalty')
            : 'Not allowed — funds unlock at maturity',
      ),
    ];

    final features = <String>[
      if (config.supportsTopUp) 'Top up anytime',
      if (config.supportsAutoRenew) 'Auto-renew at maturity',
      if (config.supportsAutoSave) 'Automatic savings',
    ];

    final notes = config.confirmationNotes
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F35),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (ctx) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  config.displayName,
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                if (config.description.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    config.description,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFFCBD5E1),
                      height: 1.4,
                    ),
                  ),
                ],
                SizedBox(height: 20.h),
                for (final r in rows) ...[
                  _detailRow(r.$1, r.$2, r.$3),
                  SizedBox(height: 14.h),
                ],
                if (features.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Text(
                    'Features',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      for (final f in features)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            f,
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF10B981),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
                if (notes.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good to know',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        for (final n in notes) ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('•  ',
                                  style: GoogleFonts.inter(
                                      fontSize: 13.sp,
                                      color: const Color(0xFF9CA3AF))),
                              Expanded(
                                child: Text(
                                  n,
                                  style: GoogleFonts.inter(
                                    fontSize: 13.sp,
                                    color: const Color(0xFFCBD5E1),
                                    height: 1.35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6.h),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text(
                      'Got it',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
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

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, size: 18.sp, color: const Color(0xFF9CA3AF)),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
