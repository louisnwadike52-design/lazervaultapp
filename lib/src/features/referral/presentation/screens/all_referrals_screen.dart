import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/referral_transaction_entity.dart';
import '../cubit/referral_cubit.dart';
import '../cubit/referral_state.dart';

class AllReferralsScreen extends StatefulWidget {
  const AllReferralsScreen({super.key});

  @override
  State<AllReferralsScreen> createState() => _AllReferralsScreenState();
}

class _AllReferralsScreenState extends State<AllReferralsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);
    context.read<ReferralCubit>().loadAllReferrals();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    final filter = switch (_tabController.index) {
      1 => 'joined',
      2 => 'pending',
      _ => '',
    };
    context.read<ReferralCubit>().loadAllReferrals(filter: filter);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ReferralCubit>().loadMoreReferrals();
    }
  }

  Future<void> _onRefresh() async {
    final filter = switch (_tabController.index) {
      1 => 'joined',
      2 => 'pending',
      _ => '',
    };
    await context.read<ReferralCubit>().loadAllReferrals(filter: filter);
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
          'All Referrals',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF3B82F6),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Joined'),
            Tab(text: 'Pending'),
          ],
        ),
      ),
      body: BlocBuilder<ReferralCubit, ReferralState>(
        builder: (context, state) {
          if (state is ReferralLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          if (state is ReferralError) {
            return _buildErrorState(state.message);
          }

          if (state is AllReferralsLoaded) {
            return _buildReferralsList(state);
          }

          return const SizedBox.shrink();
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
            Text(
              message,
              style: TextStyle(fontSize: 14.sp, color: const Color(0xFF9CA3AF)),
              textAlign: TextAlign.center,
            ),
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

  Widget _buildReferralsList(AllReferralsLoaded state) {
    if (state.referrals.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        itemCount: state.referrals.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.referrals.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Center(
                child:
                    CircularProgressIndicator(color: Color(0xFF3B82F6)),
              ),
            );
          }
          return _buildReferralItem(state.referrals[index]);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    final tabLabel = switch (_tabController.index) {
      1 => 'joined',
      2 => 'pending',
      _ => '',
    };

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Icon(Icons.people_outline_rounded,
            size: 64.sp, color: const Color(0xFF2D2D2D)),
        SizedBox(height: 16.h),
        Center(
          child: Text(
            tabLabel.isEmpty
                ? 'No referrals yet'
                : 'No $tabLabel referrals',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Center(
          child: Text(
            'Share your referral code to get started!',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReferralItem(ReferralTransactionEntity referral) {
    final statusColor = switch (referral.status) {
      ReferralStatus.completed => const Color(0xFF10B981),
      ReferralStatus.pending => const Color(0xFFFB923C),
      ReferralStatus.failed => const Color(0xFFEF4444),
      ReferralStatus.cancelled => const Color(0xFF6B7280),
    };

    final statusLabel = switch (referral.status) {
      ReferralStatus.completed => 'Joined',
      ReferralStatus.pending => 'Pending',
      ReferralStatus.failed => 'Failed',
      ReferralStatus.cancelled => 'Cancelled',
    };

    final displayName = referral.refereeDisplayName;
    final initials = _getInitials(referral);

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3B82F6),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                if (referral.refereeUsername.isNotEmpty)
                  Text(
                    '@${referral.refereeUsername}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                SizedBox(height: 2.h),
                Text(
                  _formatDate(referral.createdAt),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          // Status + reward
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
              if (referral.status == ReferralStatus.completed &&
                  referral.referrerRewardAmount > 0) ...[
                SizedBox(height: 4.h),
                Text(
                  '+${_formatAmount(referral.referrerRewardAmount, referral.currency)}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF10B981),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getInitials(ReferralTransactionEntity referral) {
    if (referral.refereeFirstName.isNotEmpty) {
      final first = referral.refereeFirstName[0].toUpperCase();
      final last = referral.refereeLastName.isNotEmpty
          ? referral.refereeLastName[0].toUpperCase()
          : '';
      return '$first$last';
    }
    if (referral.refereeUsername.isNotEmpty) {
      return referral.refereeUsername[0].toUpperCase();
    }
    return '?';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 30) return DateFormat('MMM d, y').format(date);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  String _formatAmount(int amount, String currency) {
    final symbol = switch (currency.toUpperCase()) {
      'GBP' => '£',
      'NGN' => '₦',
      'USD' => '\$',
      'EUR' => '€',
      _ => '\$',
    };
    return '$symbol${(amount / 100).toStringAsFixed(0)}';
  }
}
