import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/points_balance_entity.dart';
import '../../domain/entities/point_transaction_entity.dart';
import '../../domain/entities/points_config_entity.dart';
import '../cubit/referral_cubit.dart';
import '../cubit/referral_state.dart';

class LazerPointsScreen extends StatefulWidget {
  const LazerPointsScreen({super.key});

  @override
  State<LazerPointsScreen> createState() => _LazerPointsScreenState();
}

class _LazerPointsScreenState extends State<LazerPointsScreen> {
  PointsBalanceEntity? _balance;
  List<PointsConfigEntity> _configs = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final cubit = context.read<ReferralCubit>();
    // Load balance first, then history
    await cubit.loadPointsBalance();
  }

  Future<void> _onRefresh() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'LazerPoints',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<ReferralCubit, ReferralState>(
        listener: (context, state) {
          if (state is PointsBalanceLoaded) {
            _balance = state.balance;
            // After balance loads, load history
            context.read<ReferralCubit>().loadPointsHistory();
          }
          if (state is PointsHistoryLoaded && _configs.isEmpty) {
            // After history loads, load config
            context.read<ReferralCubit>().loadPointsConfig();
          }
          if (state is PointsConfigLoaded) {
            _configs = state.configs;
          }
        },
        builder: (context, state) {
          if (state is ReferralLoading && _balance == null) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          if (state is ReferralError && _balance == null) {
            return _buildErrorState(state.message);
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  if (_balance != null) _buildBalanceCard(_balance!),
                  SizedBox(height: 20.h),
                  if (_configs.isNotEmpty) ...[
                    _buildHowToEarnSection(),
                    SizedBox(height: 20.h),
                  ],
                  _buildHistorySection(state),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 48.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 12.h),
            Text(message,
                style:
                    TextStyle(fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
                textAlign: TextAlign.center),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _onRefresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(PointsBalanceEntity balance) {
    final tierInfo = _getTierInfo(balance.tier);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tierInfo.gradientStart, tierInfo.gradientEnd],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: tierInfo.gradientStart.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tier badge
          Row(
            children: [
              Icon(tierInfo.icon, color: Colors.white, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                '${tierInfo.label} Tier',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Balance
          Text(
            '${NumberFormat('#,###').format(balance.currentBalance)} LP',
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Current Balance',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 16.h),
          // Tier progress bar
          _buildTierProgress(balance.currentBalance, balance.tier),
          SizedBox(height: 16.h),
          // Stats row
          Row(
            children: [
              Expanded(
                child: _buildStatChip(
                  label: 'Earned',
                  value: NumberFormat('#,###').format(balance.totalEarned),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildStatChip(
                  label: 'Redeemed',
                  value: NumberFormat('#,###').format(balance.totalRedeemed),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTierProgress(int currentBalance, String currentTier) {
    final nextTier = _getNextTier(currentTier);
    if (nextTier == null) {
      return Text(
        'Maximum tier reached!',
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white.withValues(alpha: 0.8),
        ),
      );
    }

    final currentThreshold = _getTierThreshold(currentTier);
    final nextThreshold = _getTierThreshold(nextTier);
    final progress = (currentBalance - currentThreshold) /
        (nextThreshold - currentThreshold);
    final remaining = nextThreshold - currentBalance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 6.h,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          '${NumberFormat('#,###').format(remaining)} LP to ${_getTierInfo(nextTier).label}',
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip({required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowToEarnSection() {
    final activeConfigs = _configs.where((c) => c.isActive).toList();
    if (activeConfigs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How to Earn',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        ...activeConfigs.map((config) => _buildEarnRuleItem(config)),
      ],
    );
  }

  Widget _buildEarnRuleItem(PointsConfigEntity config) {
    final icon = switch (config.source) {
      'referral' => Icons.people_rounded,
      'signup_bonus' => Icons.card_giftcard_rounded,
      'first_transaction' => Icons.payment_rounded,
      'monthly_active' => Icons.calendar_month_rounded,
      'achievement' => Icons.emoji_events_rounded,
      'redemption' => Icons.redeem_rounded,
      _ => Icons.star_rounded,
    };

    final color = switch (config.source) {
      'referral' => const Color(0xFF3B82F6),
      'signup_bonus' => const Color(0xFF10B981),
      'first_transaction' => const Color(0xFFF59E0B),
      'monthly_active' => const Color(0xFF8B5CF6),
      'achievement' => const Color(0xFFF97316),
      'redemption' => const Color(0xFFEF4444),
      _ => const Color(0xFF6B7280),
    };

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  config.description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '+${config.pointsAmount} LP',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection(ReferralState state) {
    List<PointTransactionEntity> transactions = [];
    bool hasMore = false;

    if (state is PointsHistoryLoaded) {
      transactions = state.transactions;
      hasMore = state.hasMore;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Points History',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        if (transactions.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              children: [
                Icon(Icons.history_rounded,
                    size: 40.sp, color: const Color(0xFF2D2D2D)),
                SizedBox(height: 8.h),
                Text(
                  'No points activity yet',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          )
        else ...[
          ...transactions.map((tx) => _buildHistoryItem(tx)),
          if (hasMore)
            Center(
              child: TextButton(
                onPressed: () =>
                    context.read<ReferralCubit>().loadMorePointsHistory(),
                child: Text(
                  'Load More',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }

  Widget _buildHistoryItem(PointTransactionEntity tx) {
    final isEarning = tx.isEarning;
    final color = isEarning ? const Color(0xFF10B981) : const Color(0xFFEF4444);

    final icon = switch (tx.source) {
      PointSource.referral => Icons.people_rounded,
      PointSource.signupBonus => Icons.card_giftcard_rounded,
      PointSource.firstTransaction => Icons.payment_rounded,
      PointSource.monthlyActive => Icons.calendar_month_rounded,
      PointSource.achievement => Icons.emoji_events_rounded,
      PointSource.redemption => Icons.redeem_rounded,
    };

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.description,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _formatTxDate(tx.createdAt),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${isEarning ? '+' : ''}${tx.points} LP',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTxDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 7) return DateFormat('MMM d').format(date);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    return 'Just now';
  }

  _TierInfo _getTierInfo(String tier) {
    return switch (tier.toLowerCase()) {
      'silver' => _TierInfo(
          label: 'Silver',
          icon: Icons.shield_rounded,
          gradientStart: const Color(0xFF6B7280),
          gradientEnd: const Color(0xFF374151),
        ),
      'gold' => _TierInfo(
          label: 'Gold',
          icon: Icons.shield_rounded,
          gradientStart: const Color(0xFFF59E0B),
          gradientEnd: const Color(0xFFD97706),
        ),
      'platinum' => _TierInfo(
          label: 'Platinum',
          icon: Icons.diamond_rounded,
          gradientStart: const Color(0xFF8B5CF6),
          gradientEnd: const Color(0xFF6D28D9),
        ),
      _ => _TierInfo(
          label: 'Bronze',
          icon: Icons.shield_rounded,
          gradientStart: const Color(0xFFD97706),
          gradientEnd: const Color(0xFF92400E),
        ),
    };
  }

  String? _getNextTier(String tier) {
    return switch (tier.toLowerCase()) {
      'bronze' => 'silver',
      'silver' => 'gold',
      'gold' => 'platinum',
      _ => null,
    };
  }

  int _getTierThreshold(String tier) {
    return switch (tier.toLowerCase()) {
      'silver' => 1000,
      'gold' => 5000,
      'platinum' => 20000,
      _ => 0,
    };
  }
}

class _TierInfo {
  final String label;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;

  const _TierInfo({
    required this.label,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
  });
}
