import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_stats.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_cubit.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/sprayme_state.dart';

class SprayMeStatsScreen extends StatefulWidget {
  const SprayMeStatsScreen({super.key});

  @override
  State<SprayMeStatsScreen> createState() => _SprayMeStatsScreenState();
}

class _SprayMeStatsScreenState extends State<SprayMeStatsScreen> {
  String _selectedPeriod = 'all';
  MySprayStats? _stats;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    context.read<SprayMeCubit>().loadMySprayStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'LazerSpray Stats',
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: BlocListener<SprayMeCubit, SprayMeState>(
        listener: (context, state) {
          if (state is MySprayStatsLoaded) {
            setState(() {
              _stats = state.stats;
              _isLoading = false;
              _error = null;
            });
          } else if (state is SprayMeError && _isLoading) {
            setState(() {
              _isLoading = false;
              _error = state.message;
            });
          }
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _stats == null) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)));
    }
    if (_error != null && _stats == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: const Color(0xFF9CA3AF)),
            SizedBox(height: 12.h),
            Text(_error!, style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                setState(() => _isLoading = true);
                context.read<SprayMeCubit>().loadMySprayStats(period: _selectedPeriod);
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6)),
              child: const Text('Retry', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
    if (_stats != null) {
      return _buildStats(_stats!);
    }
    return const SizedBox.shrink();
  }

  bool _isAllZero(MySprayStats stats) {
    return stats.totalSprayed == 0 &&
        stats.totalReceived == 0 &&
        stats.sessionsHosted == 0 &&
        stats.sessionsJoined == 0 &&
        stats.totalGiftsSent == 0 &&
        stats.totalGiftsReceived == 0;
  }

  Widget _buildStats(MySprayStats stats) {
    return RefreshIndicator(
      onRefresh: () => context.read<SprayMeCubit>().loadMySprayStats(period: _selectedPeriod),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        children: [
          // Period selector
          Row(
            children: ['week', 'month', 'year', 'all'].map((period) {
              final isSelected = _selectedPeriod == period;
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPeriod = period;
                      _isLoading = true;
                    });
                    context.read<SprayMeCubit>().loadMySprayStats(period: period);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      period[0].toUpperCase() + period.substring(1),
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24.h),

          // Empty state when all zeros
          if (_isAllZero(stats)) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Column(
                children: [
                  Icon(Icons.bar_chart, size: 48.sp, color: const Color(0xFF9CA3AF)),
                  SizedBox(height: 12.h),
                  Text(
                    'No activity yet',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Start spraying or join a session to see your stats here',
                    style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 80.h),
          ] else ...[

          // Money stats
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBigStat(
                      'Total Sprayed',
                      '${stats.currency} ${(stats.totalSprayed / 100).toStringAsFixed(0)}',
                      const Color(0xFFEF4444),
                      Icons.arrow_upward,
                    ),
                    Container(width: 1, height: 60.h, color: const Color(0xFF2D2D2D)),
                    _buildBigStat(
                      'Total Received',
                      '${stats.currency} ${(stats.totalReceived / 100).toStringAsFixed(0)}',
                      const Color(0xFF10B981),
                      Icons.arrow_downward,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Activity stats grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.4,
            children: [
              _buildStatCard('Sessions Hosted', '${stats.sessionsHosted}', Icons.event, const Color(0xFF7C3AED)),
              _buildStatCard('Sessions Joined', '${stats.sessionsJoined}', Icons.group_add, const Color(0xFF3B82F6)),
              _buildStatCard('Gifts Sent', '${stats.totalGiftsSent}', Icons.card_giftcard, const Color(0xFFFFD700)),
              _buildStatCard('Gifts Received', '${stats.totalGiftsReceived}', Icons.redeem, const Color(0xFFFB923C)),
              _buildStatCard('Likes Given', _formatCount(stats.totalLikesGiven), Icons.favorite, const Color(0xFFFF1744)),
              _buildStatCard('Likes Received', _formatCount(stats.totalLikesReceived), Icons.favorite_border, const Color(0xFFE91E63)),
            ],
          ),
          SizedBox(height: 80.h),
          ], // end else (has data)
        ],
      ),
    );
  }

  Widget _buildBigStat(String label, String value, Color color, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 22.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20.sp),
              const Spacer(),
              Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}
