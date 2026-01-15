import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shimmer Loading Widget for Statistics Screen
/// Provides loading skeleton with WCAG AA compliant colors
class StatisticsShimmerLoading extends StatelessWidget {
  const StatisticsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        _buildShimmerCard(200.h),
        SizedBox(height: 16.h),
        _buildShimmerCard(100.h),
        SizedBox(height: 16.h),
        _buildShimmerCard(150.h),
        SizedBox(height: 16.h),
        _buildShimmerCard(120.h),
      ],
    );
  }

  Widget _buildShimmerCard(double height) {
    return Shimmer(
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFE5E7EB),
          const Color(0xFFF3F4F6),
          const Color(0xFFE5E7EB),
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}

class Shimmer extends StatefulWidget {
  final LinearGradient linearGradient;
  final Widget? child;

  const Shimmer({
    super.key,
    required this.linearGradient,
    this.child,
  });

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
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
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return widget.linearGradient.createShader(
              Rect.fromLTWH(
                bounds.left + bounds.width * _animation.value,
                bounds.top,
                bounds.width,
                bounds.height,
              ),
            );
          },
          child: widget.child ?? Container(),
        );
      },
    );
  }
}
