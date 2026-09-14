import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/lock_fund_entity.dart';
import '../cubit/lock_funds_cubit.dart';
import '../cubit/lock_funds_state.dart';
import '../widgets/lock_funds_empty_state.dart';
import 'lock_withdrawal_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'lock_fund_details_screen_widgets.dart';


class LockFundDetailsScreen extends StatefulWidget {
  final LockFund lockFund;

  const LockFundDetailsScreen({
    super.key,
    required this.lockFund,
  });

  @override
  State<LockFundDetailsScreen> createState() => _LockFundDetailsScreenState();
}

class _LockFundDetailsScreenState extends State<LockFundDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    context.read<LockFundsCubit>().loadLockFundDetails(widget.lockFund.id);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LockFundsCubit, LockFundsState>(
      listener: (context, state) {
        if (state is LockFundUnlocked) {
          Get.back();
          Get.snackbar(
            'Withdrawal Successful',
            'Your funds have been withdrawn to your account',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        } else if (state is LockFundsError) {
          Get.snackbar(
            'Error',
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
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          _buildAmountCard(),
                          SizedBox(height: 20.h),
                          _buildProgressSection(),
                          SizedBox(height: 20.h),
                          _buildDetailsCard(),
                          SizedBox(height: 20.h),
                          _buildInterestCard(),
                          SizedBox(height: 20.h),
                          _buildActivitySection(),
                          SizedBox(height: 20.h),
                          _buildFooterActions(),
                          SizedBox(height: 40.h),
                        ],
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
                  widget.lockFund.displayName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      widget.lockFund.lockType.icon,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      widget.lockFund.lockType.displayName,
                      style: GoogleFonts.inter(
                        color: const Color(0xFFB7ABDA),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildStatusBadge(widget.lockFund.status),
        ],
      ),
    );
  }

  /// Always-visible "View receipt" CTA on the page (receipt applies to every
  /// lock, active or terminal). Styled as a subtle outlined secondary action so
  /// it reads below the primary withdraw/renew buttons without competing.
  /// The ONLY actions on the details page: View receipt + Withdraw, side by
  /// side. Every plan is independent — there is no top-up, auto-save, renew,
  /// break-lock or auto-fund here; funding or renewing means CREATING A NEW
  /// PLAN. Withdraw is enabled only when the lock has matured (flex/no-term
  /// plans have no maturity, so they're always withdrawable); it stays disabled
  /// with a maturity hint until then. Terminal locks (already unlocked/
  /// cancelled) show only the receipt.
  Widget _buildFooterActions() {
    final lock = widget.lockFund;
    // Flex / no-term: no unlock date (epoch sentinel) or zero term. Use BOTH
    // signals so a stale lock_duration_days can't misclassify a dated lock.
    final isFlex = lock.unlockAt.year <= 1971 || lock.lockDurationDays <= 0;
    final matured = lock.status == LockStatus.matured ||
        (!isFlex && !lock.unlockAt.isAfter(DateTime.now()));
    // A breakable term lock BEFORE maturity can be withdrawn EARLY (with a
    // penalty). canUnlockEarly already ANDs the plan's allows_early_withdrawal,
    // so non-breakable plans (Year Lock, Treasury) stay maturity-gated.
    final canEarly = !isFlex && !matured && lock.canUnlockEarly;
    final canWithdraw = !lock.isTerminal && (matured || isFlex || canEarly);

    final receipt = _footerButton(
      'View receipt',
      Icons.receipt_long_outlined,
      const Color(0xFF8B5CF6),
      _openReceipt,
      filled: false,
      enabled: true,
    );

    // Terminal locks: nothing to withdraw — just the receipt, full width.
    if (lock.isTerminal) return receipt;

    // Early withdrawal is visually distinct from a normal/matured withdrawal:
    // amber "Withdraw Early" (penalty applies) vs green "Withdraw".
    final earlyPenalty = lock.earlyWithdrawalPenalty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: receipt),
            SizedBox(width: 12.w),
            Expanded(
              child: _footerButton(
                canEarly ? 'Withdraw Early' : 'Withdraw',
                canEarly
                    ? Icons.lock_open_outlined
                    : Icons.account_balance_wallet_outlined,
                canEarly ? const Color(0xFFFB923C) : const Color(0xFF10B981),
                canWithdraw ? () => _showWithdrawDialog(early: canEarly) : null,
                filled: true,
                enabled: canWithdraw,
              ),
            ),
          ],
        ),
        // Early: state the penalty. Locked (non-breakable, pre-maturity):
        // explain when it unlocks. Matured/flex: no note needed.
        if (canEarly && earlyPenalty > 0) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.warning_amber_rounded,
                  size: 13.sp, color: const Color(0xFFFB923C)),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Early withdrawal penalty: ${lock.earlyUnlockPenaltyPercent.toStringAsFixed(0)}% '
                  '(${CurrencySymbols.getSymbol(lock.currency)}${earlyPenalty.toStringAsFixed(2)}).',
                  style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C), fontSize: 11.sp),
                ),
              ),
            ],
          ),
        ] else if (!canWithdraw) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.lock_clock_outlined,
                  size: 13.sp, color: const Color(0xFFB7ABDA)),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Withdrawal unlocks at maturity${lock.unlockAt.year > 1971 ? ' on ${DateFormat('MMM dd, yyyy').format(lock.unlockAt)}' : ''}.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFB7ABDA),
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// One footer button. [filled] gives it a solid accent fill (Withdraw);
  /// otherwise it's an outlined neutral button (Receipt). When [enabled] is
  /// false it renders greyed and ignores taps.
  Widget _footerButton(
    String label,
    IconData icon,
    Color accent,
    VoidCallback? onTap, {
    required bool filled,
    required bool enabled,
  }) {
    final fg = !enabled
        ? const Color(0xFF6B7280)
        : (filled ? Colors.white : Colors.white);
    final bg = filled
        ? (enabled ? accent : accent.withValues(alpha: 0.15))
        : Colors.white.withValues(alpha: 0.04);
    final border = filled
        ? Colors.transparent
        : const Color(0xFF2D2D2D);
    return GestureDetector(
      onTap: enabled
          ? () {
              HapticFeedback.selectionClick();
              onTap?.call();
            }
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: enabled ? (filled ? Colors.white : accent) : fg,
                size: 18.sp),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: fg,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Navigates to the receipt screen for this lock. Reuses the
  /// same route the create-flow ships to so the rendered surface
  /// is identical — no second receipt implementation.
  void _openReceipt() {
    Get.toNamed(AppRoutes.lockFundReceipt, arguments: {
      'lockFund': widget.lockFund,
      // The post-create wizard's interestCalculation isn't
      // available from this surface (it lives on CreateLockCubit
      // for one wizard run only). The receipt screen tolerates a
      // null calc and just hides the upfront block.
      'interestCalculation': null,
    });
  }

  Widget _buildStatusBadge(LockStatus status) {
    Color color;
    switch (status) {
      case LockStatus.active:
        color = const Color(0xFF6366F1);
        break;
      case LockStatus.matured:
        color = const Color(0xFF10B981);
        break;
      case LockStatus.unlocked:
        color = const Color(0xFF6B7280);
        break;
      case LockStatus.cancelled:
        color = const Color(0xFFEF4444);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6366F1),
            const Color.fromARGB(255, 78, 3, 208),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Total Value',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.lockFund.formattedTotalValue,
            style: GoogleFonts.inter(
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.trending_up,
                  color: Colors.white,
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  widget.lockFund.formattedInterest,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'interest earned',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Human maturity label. Flex / no-fixed-term locks have no unlock date
  /// (the backend stores epoch), so "Jan 01, 1970" must never render — show
  /// "No fixed date" instead.
  String _maturesLabel(LockFund lock) {
    if (lock.lockDurationDays <= 0 || lock.unlockAt.year <= 1971) {
      return 'No fixed date';
    }
    return DateFormat('MMM dd, yyyy').format(lock.unlockAt);
  }

  Widget _buildProgressSection() {
    final lock = widget.lockFund;
    final progressColor = lock.status == LockStatus.active
        ? const Color(0xFF6366F1)
        : lock.status == LockStatus.matured
            ? const Color(0xFF10B981)
            : const Color(0xFF6B7280);

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F2E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lock Progress',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                '${lock.progressPercent.toStringAsFixed(0)}%',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: progressColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Stack(
            children: [
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: lock.progressPercent / 100,
                child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [progressColor, progressColor.withValues(alpha: 0.7)],
                    ),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Started',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFFB7ABDA),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    DateFormat('MMM dd, yyyy').format(lock.lockedAt),
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Matures',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFFB7ABDA),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _maturesLabel(lock),
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (lock.isActive && lock.daysRemaining > 0) ...[
            SizedBox(height: 16.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: progressColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule,
                    color: progressColor,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    lock.daysRemainingText,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: progressColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
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
            'Lock Details',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Principal Amount', lock.formattedAmount),
          _buildDetailRow('Interest Rate', lock.formattedInterestRate),
          _buildDetailRow('Lock Duration', lock.durationText),
          _buildDetailRow('Auto-Renew', lock.autoRenew ? 'Enabled' : 'Disabled'),
          if (lock.transactionId != null)
            _buildDetailRow('Transaction ID', lock.transactionId!),
          if (lock.goalDescription?.isNotEmpty == true)
            _buildDetailRow('Goal Description', lock.goalDescription!),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFFB7ABDA),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestCard() {
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
            'Interest Summary',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildInterestStat(
                  'Principal',
                  lock.formattedAmount,
                  const Color(0xFF6366F1),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInterestStat(
                  'Interest',
                  lock.formattedInterest,
                  const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF10B981).withValues(alpha: 0.15),
                  const Color(0xFF10B981).withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total at Maturity',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFFB7ABDA),
                  ),
                ),
                Text(
                  lock.formattedTotalValue,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
          // Early-withdrawal information panel — shown for any lock
          // whose snapshotted penalty is < 100% (i.e. the user CAN
          // exit early, possibly with a penalty). Driven by the lock
          // row, not the enum, so it stays correct even if the
          // admin-side config changes after issue.
          // Gated on canUnlockEarly too: the panel says the user CAN exit
          // early, and for Treasury/Year Lock the server now says they
          // cannot. Advertising an exit that will be refused is worse than
          // not mentioning one.
          if (lock.canUnlockEarly &&
              lock.earlyUnlockPenaltyPercent < 100 &&
              lock.isActive) ...[
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: const Color(0xFFFB923C),
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Early withdrawal penalty: ${lock.earlyUnlockPenaltyPercent}% (${CurrencySymbols.getSymbol(lock.currency)}${lock.earlyWithdrawalPenalty.toStringAsFixed(2)})',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFFFB923C),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInterestStat(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color(0xFFB7ABDA),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// Renders the lock-fund's transaction history (top-ups, interest
  /// accruals, the original lock debit) below the interest card.
  /// Uses BlocBuilder to bind to LockFundDetailsLoaded which the
  /// screen's initState already requests via
  /// loadLockFundDetails — so this surface fills in once the
  /// cubit emits, with a labelled spinner during the load and a
  /// graceful empty state if there's no activity yet.
  Widget _buildActivitySection() {
    return BlocBuilder<LockFundsCubit, LockFundsState>(
      buildWhen: (prev, next) =>
          next is LockFundDetailsLoaded ||
          next is LockFundsLoading,
      builder: (context, state) {
        List<LockTransaction>? txs;
        if (state is LockFundDetailsLoaded) {
          txs = state.transactions;
        }
        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.history_rounded, color: const Color(0xFF8B5CF6), size: 18.sp),
                  SizedBox(width: 8.w),
                  Text('Activity', style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                ],
              ),
              SizedBox(height: 14.h),
              if (txs == null) ...[
                // First-load spinner. The cubit's
                // loadLockFundDetails kicks off in initState.
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  child: const Center(child: LazerVaultLoader.tiny()),
                ),
              ] else if (txs.isEmpty) ...[
                const LockFundsEmptyState(
                  compact: true,
                  title: 'No activity yet',
                  subtitle:
                      'Top-ups, interest accruals and unlocks will show up here.',
                ),
              ] else ...[
                for (final tx in txs) _buildActivityRow(tx),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivityRow(LockTransaction tx) {
    final isCredit = tx.transactionType.toLowerCase().contains('credit') ||
        tx.transactionType.toLowerCase().contains('interest') ||
        tx.transactionType.toLowerCase().contains('payout');
    final amountColor =
        isCredit ? const Color(0xFF10B981) : const Color(0xFFFB923C);
    final sign = isCredit ? '+' : '-';
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w, height: 32.w,
            decoration: BoxDecoration(
              color: amountColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Icon(
              isCredit ? Icons.south_west_rounded : Icons.north_east_rounded,
              color: amountColor, size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _humanizeTxType(tx.transactionType),
                  style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2.h),
                Text(
                  DateFormat.yMMMd().add_jm().format(tx.transactionDate),
                  style: GoogleFonts.inter(
                    color: const Color(0xFFB7ABDA), fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Text(
            '$sign${CurrencySymbols.getSymbol(widget.lockFund.currency)}${tx.amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: amountColor, fontSize: 13.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  /// Maps backend tx type slugs into user-readable labels. Falls
  /// back to a sentence-cased version of the slug for any type
  /// that isn't in the map.
  String _humanizeTxType(String slug) {
    switch (slug.toLowerCase()) {
      case 'lock_funds':
      case 'lock':
        return 'Funds locked';
      case 'upfront_interest':
        return 'Upfront interest';
      case 'interest':
      case 'interest_payout':
        return 'Interest payout';
      case 'topup':
      case 'top_up':
        return 'Top-up';
      case 'unlock':
      case 'unlocked':
        return 'Unlocked';
      case 'cancelled':
      case 'cancel':
        return 'Cancelled';
      case 'penalty':
        return 'Early-withdrawal penalty';
      default:
        return slug.replaceAll('_', ' ').toUpperCase();
    }
  }

  void _showWithdrawDialog({bool early = false}) {
    HapticFeedback.mediumImpact();
    final lockFundsCubit = context.read<LockFundsCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: lockFundsCubit,
          // The withdraw screen also self-derives early-vs-matured from the
          // lock, so this is an explicit hint (breakable term, pre-maturity),
          // not the sole source of truth.
          child: LockWithdrawalScreen(
              lockFund: widget.lockFund, isEarlyWithdrawal: early),
        ),
      ),
    );
  }

}
