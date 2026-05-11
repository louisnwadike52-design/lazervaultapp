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
import 'lock_withdrawal_screen.dart';
import 'lock_fund_topup_screen.dart';
import 'lock_fund_autosave_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

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
                          if (!widget.lockFund.isTerminal) _buildActionButtons(),
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
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildStatusBadge(widget.lockFund.status),
          SizedBox(width: 8.w),
          _buildOverflowMenu(),
        ],
      ),
    );
  }

  /// PopupMenu surfaced in the AppBar with secondary actions:
  /// share / view receipt / open in admin (deep link) / cancel.
  /// Cancel is the destructive option, separated visually + tinted
  /// red so users can't trigger it by mistake. Items hide based on
  /// lock status (no cancel on terminal locks).
  Widget _buildOverflowMenu() {
    final lock = widget.lockFund;
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.white, size: 22.sp),
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      onSelected: (value) {
        switch (value) {
          case 'receipt':
            _openReceipt();
            break;
          case 'auto_save':
            _showAutoSaveScreen();
            break;
          case 'top_up':
            _showTopUpScreen();
            break;
          case 'cancel':
            _showCancelLockDialog();
            break;
          case 'renew':
            _showRenewDialog();
            break;
        }
      },
      itemBuilder: (ctx) => [
        PopupMenuItem(
          value: 'receipt',
          child: Row(children: [
            Icon(Icons.receipt_long_outlined, color: Colors.white, size: 18.sp),
            SizedBox(width: 10.w),
            Text('View receipt', style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
          ]),
        ),
        if (lock.status == LockStatus.active && lock.lockType.defaultSupportsRenewal)
          PopupMenuItem(
            value: 'renew',
            child: Row(children: [
              Icon(Icons.refresh_rounded, color: const Color(0xFF6366F1), size: 18.sp),
              SizedBox(width: 10.w),
              Text('Renew lock', style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
            ]),
          ),
        if (lock.status == LockStatus.active && lock.lockType.defaultSupportsTopUp)
          PopupMenuItem(
            value: 'top_up',
            child: Row(children: [
              Icon(Icons.add_circle_outline, color: const Color(0xFF6366F1), size: 18.sp),
              SizedBox(width: 10.w),
              Text('Top up', style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
            ]),
          ),
        if (lock.status == LockStatus.active && lock.lockType.defaultSupportsAutoSave)
          PopupMenuItem(
            value: 'auto_save',
            child: Row(children: [
              Icon(Icons.autorenew, color: const Color(0xFF3B82F6), size: 18.sp),
              SizedBox(width: 10.w),
              Text('Auto-save', style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
            ]),
          ),
        if (lock.status == LockStatus.active && lock.earlyUnlockPenaltyPercent > 0)
          PopupMenuItem(
            value: 'cancel',
            child: Row(children: [
              Icon(Icons.cancel_outlined, color: const Color(0xFFEF4444), size: 18.sp),
              SizedBox(width: 10.w),
              Text('Cancel lock', style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 13.sp)),
            ]),
          ),
      ],
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
                      color: const Color(0xFF9CA3AF),
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
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    DateFormat('MMM dd, yyyy').format(lock.unlockAt),
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
              color: const Color(0xFF9CA3AF),
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
                    color: const Color(0xFF9CA3AF),
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
          if (lock.earlyUnlockPenaltyPercent < 100 && lock.isActive) ...[
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
              color: const Color(0xFF9CA3AF),
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
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
              ] else if (txs.isEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  child: Center(
                    child: Text('No activity yet', style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
                  ),
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
                    color: const Color(0xFF9CA3AF), fontSize: 11.sp),
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

  Widget _buildActionButtons() {
    final lock = widget.lockFund;

    return Column(
      children: [
        if (lock.isMatured || lock.status == LockStatus.matured) ...[
          // Matured - show withdraw and renew buttons
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Withdraw',
                  Icons.account_balance_wallet_outlined,
                  const Color(0xFF10B981),
                  () => _showWithdrawDialog(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionButton(
                  'Renew Lock',
                  Icons.refresh,
                  const Color(0xFF6366F1),
                  () => _showRenewDialog(),
                ),
              ),
            ],
          ),
        ] else if (lock.isActive) ...[
          // Active — show available follow-up actions. Top-up +
          // auto-save visibility tracks the admin dashboard's
          // PiggyVaultConfig (supports_top_up / supports_auto_save)
          // via LockType.defaultSupportsTopUp / Auto-save. The
          // backend is the authoritative gate; this UI check just
          // avoids rendering buttons the backend would reject.
          if (lock.lockType.defaultSupportsTopUp || lock.lockType.defaultSupportsAutoSave)
            Row(
              children: [
                if (lock.lockType.defaultSupportsTopUp)
                  Expanded(
                    child: _buildActionButton(
                      'Top Up',
                      Icons.add_circle_outline,
                      const Color(0xFF6366F1),
                      () => _showTopUpScreen(),
                    ),
                  ),
                if (lock.lockType.defaultSupportsTopUp && lock.lockType.defaultSupportsAutoSave)
                  SizedBox(width: 12.w),
                if (lock.lockType.defaultSupportsAutoSave)
                  Expanded(
                    child: _buildActionButton(
                      'Auto-Save',
                      Icons.autorenew,
                      const Color(0xFF3B82F6),
                      () => _showAutoSaveScreen(),
                    ),
                  ),
              ],
            ),
          SizedBox(height: 12.h),
          // Withdraw vs Break Lock: drive the label + colour by the
          // penalty applied at issue time. Zero penalty = penalty-
          // free withdrawal; non-zero = an early-break that costs
          // the user.
          if (lock.lockType == LockType.savings ||
              lock.earlyUnlockPenaltyPercent == 0)
            _buildActionButton(
              'Withdraw',
              Icons.account_balance_wallet_outlined,
              const Color(0xFF10B981),
              () => _showBreakLockDialog(),
              fullWidth: true,
            )
          else
            _buildActionButton(
              'Break Lock',
              Icons.lock_open_outlined,
              const Color(0xFFFB923C),
              () => _showBreakLockDialog(),
              fullWidth: true,
            ),
          // Cancel — distinct from "break lock" / early withdraw
          // semantically: cancel flips status to 'cancelled' and
          // captures a typed reason, useful for ops audit (lost
          // interest in plan, changed mind, etc). Money movement
          // is identical to break-lock (principal minus penalty
          // returns to source). Hidden for Flex / zero-penalty
          // plans where "Withdraw" already covers the same intent.
          if (lock.lockType != LockType.savings && lock.earlyUnlockPenaltyPercent > 0) ...[
            SizedBox(height: 8.h),
            _buildActionButton(
              'Cancel lock',
              Icons.cancel_outlined,
              const Color(0xFFEF4444),
              () => _showCancelLockDialog(),
              fullWidth: true,
            ),
          ],
        ],
      ],
    );
  }

  /// Cancel-lock confirmation modal. Two-step: reason picker
  /// first (close enough to "I changed my mind" / "found a better
  /// rate" / "need the cash" — short enum so the analytics layer
  /// can group them), then a destructive confirm with penalty
  /// preview. Mirrors the production-pattern from the
  /// transfer-cancel + exchange-cancel flows.
  void _showCancelLockDialog() {
    HapticFeedback.mediumImpact();
    final lock = widget.lockFund;
    final cubit = context.read<LockFundsCubit>();
    String selectedReason = 'changed_mind';
    final reasons = <_CancelReason>[
      _CancelReason('changed_mind', 'Changed my mind'),
      _CancelReason('need_funds', 'Need the funds'),
      _CancelReason('found_better_rate', 'Found a better rate'),
      _CancelReason('other', 'Other'),
    ];
    final estPenalty = lock.amount * (lock.earlyUnlockPenaltyPercent / 100);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) => StatefulBuilder(
        builder: (ctx, setLocal) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w, height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D3D3D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text('Cancel this lock', style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                SizedBox(height: 6.h),
                Text(
                  'You\'ll get back ${(lock.amount - estPenalty).toStringAsFixed(2)} ${lock.currency}. Penalty: ${estPenalty.toStringAsFixed(2)} ${lock.currency} (${lock.earlyUnlockPenaltyPercent.toStringAsFixed(1)}%).',
                  style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                ),
                SizedBox(height: 18.h),
                Text('Why are you cancelling?', style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 8.h),
                ...reasons.map((r) {
                  final selected = r.code == selectedReason;
                  return GestureDetector(
                    onTap: () => setLocal(() => selectedReason = r.code),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 6.h),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: selected
                            ? const Color(0xFFEF4444).withValues(alpha: 0.18)
                            : const Color(0xFF0A0A0A),
                        border: Border.all(
                          color: selected
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF2D2D2D),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            selected ? Icons.radio_button_checked : Icons.radio_button_off,
                            color: selected ? const Color(0xFFEF4444) : const Color(0xFF6B7280),
                            size: 18.sp,
                          ),
                          SizedBox(width: 10.w),
                          Text(r.label, style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 13.sp,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.w500)),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.of(ctx).pop(),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(child: Text('Keep lock', style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600))),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Navigator.of(ctx).pop();
                          await _executeCancel(cubit, lock.id, selectedReason);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(child: Text('Cancel lock',
                            style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _executeCancel(LockFundsCubit cubit, String lockFundId, String reason) async {
    try {
      final result = await cubit.cancelLockFund(
        lockFundId: lockFundId,
        reason: reason,
      );
      if (!mounted) return;
      Get.snackbar(
        'Lock cancelled',
        'Refunded ${result.refundAmount.toStringAsFixed(2)} to your wallet.',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      Get.snackbar(
        'Cancel failed',
        e.toString().replaceAll('Exception:', '').trim(),
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
      );
    }
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap, {
    bool fullWidth = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showWithdrawDialog() {
    HapticFeedback.mediumImpact();
    final lockFundsCubit = context.read<LockFundsCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: lockFundsCubit,
          child: LockWithdrawalScreen(lockFund: widget.lockFund, isEarlyWithdrawal: false),
        ),
      ),
    );
  }

  void _showBreakLockDialog() {
    HapticFeedback.mediumImpact();
    final lockFundsCubit = context.read<LockFundsCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: lockFundsCubit,
          child: LockWithdrawalScreen(lockFund: widget.lockFund, isEarlyWithdrawal: true),
        ),
      ),
    );
  }

  /// Opens a bottom sheet collecting the new term length, then
  /// calls RenewLockFund on accept. Re-uses the active lock's
  /// original duration as the suggested chip + extends from now()
  /// (server-side semantics — see RenewLockFunds service method).
  /// Realtime WS lifecycle event refreshes the list automatically;
  /// this screen reloads details on success.
  void _showRenewDialog() {
    HapticFeedback.mediumImpact();
    final lock = widget.lockFund;
    final cubit = context.read<LockFundsCubit>();
    final defaultDays = lock.lockDurationDays > 0 ? lock.lockDurationDays : 90;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) {
        int selectedDays = defaultDays;
        return StatefulBuilder(
          builder: (ctx, setState) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w, height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3D3D3D),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Renew this lock', style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 6.h),
                  Text(
                    'Extend ${lock.displayName} for another term. Upfront interest (if your plan supports it) is paid into your wallet immediately.',
                    style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  ),
                  SizedBox(height: 18.h),
                  Text('New term', style: GoogleFonts.inter(
                    color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w, runSpacing: 8.h,
                    children: [30, 90, 180, 365].map((d) {
                      final selected = d == selectedDays;
                      return GestureDetector(
                        onTap: () => setState(() => selectedDays = d),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF4E03D0)
                                : const Color(0xFF0A0A0A),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFF8B5CF6)
                                  : const Color(0xFF2D2D2D),
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text('$d days', style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 12.sp,
                            fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.of(ctx).pop(),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(child: Text('Cancel', style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600))),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.of(ctx).pop();
                            await _executeRenew(cubit, lock.id, selectedDays);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(child: Text('Renew $selectedDays days',
                              style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Calls the cubit's renewLockFund and surfaces success / failure
  /// as a snackbar. The cubit emits LockFundCreated on success +
  /// reloads the list; we pop back to it so the user sees the
  /// updated state instead of stale details. Errors bubble up
  /// from the gRPC layer with the typed message
  /// (revenue_underfunded, plan_deactivated, frozen, etc).
  Future<void> _executeRenew(LockFundsCubit cubit, String lockFundId, int days) async {
    try {
      final renewed = await cubit.renewLockFund(
        lockFundId: lockFundId,
        newDurationDays: days,
      );
      if (!mounted) return;
      Get.snackbar(
        'Lock renewed',
        'New maturity: ${DateFormat.yMMMd().format(renewed.unlockAt)}',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      // Pop back to the list so the user sees the fresh unlock
      // date + the cubit's auto-reload covers other surfaces.
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      Get.snackbar(
        'Renewal failed',
        e.toString().replaceAll('Exception:', '').trim(),
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
      );
    }
  }

  void _showTopUpScreen() {
    HapticFeedback.mediumImpact();
    final lockFundsCubit = context.read<LockFundsCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: lockFundsCubit,
          child: LockFundTopUpScreen(lockFund: widget.lockFund),
        ),
      ),
    ).then((result) {
      if (result == true) {
        // Refresh the details
        lockFundsCubit.loadLockFundDetails(widget.lockFund.id);
      }
    });
  }

  void _showAutoSaveScreen() {
    HapticFeedback.mediumImpact();
    final lockFundsCubit = context.read<LockFundsCubit>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: lockFundsCubit,
          child: LockFundAutoSaveScreen(lockFund: widget.lockFund),
        ),
      ),
    ).then((result) {
      if (result == true) {
        lockFundsCubit.loadLockFundDetails(widget.lockFund.id);
      }
    });
  }
}

/// Cancel-reason enum entry: short code shipped to the backend
/// (so analytics groups by category) + human-readable label for
/// the radio chip on the cancel modal.
class _CancelReason {
  final String code;
  final String label;
  const _CancelReason(this.code, this.label);
}
