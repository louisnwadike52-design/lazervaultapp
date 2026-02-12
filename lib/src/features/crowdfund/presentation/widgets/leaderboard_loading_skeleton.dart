import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderboardLoadingSkeleton extends StatefulWidget {
  const LeaderboardLoadingSkeleton({super.key});

  @override
  State<LeaderboardLoadingSkeleton> createState() =>
      _LeaderboardLoadingSkeletonState();
}

class _LeaderboardLoadingSkeletonState extends State<LeaderboardLoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.6).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: List.generate(5, (index) => _buildSkeletonCard()),
        );
      },
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Rank circle
          _shimmerBox(36.w, 36.w, isCircle: true),
          SizedBox(width: 12.w),
          // Image placeholder
          _shimmerBox(60.w, 60.w, radius: 12.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(double.infinity, 14.h, radius: 4.r),
                SizedBox(height: 6.h),
                _shimmerBox(100.w, 10.h, radius: 4.r),
                SizedBox(height: 8.h),
                _shimmerBox(double.infinity, 4.h, radius: 2.r),
                SizedBox(height: 6.h),
                _shimmerBox(150.w, 10.h, radius: 4.r),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox(double width, double height,
      {double radius = 0, bool isCircle = false}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: _animation.value),
        borderRadius: isCircle ? null : BorderRadius.circular(radius),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
