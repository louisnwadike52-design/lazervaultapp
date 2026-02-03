import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TagPayStatsShimmer extends StatelessWidget {
  const TagPayStatsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1F1F1F),
      highlightColor: const Color(0xFF3D3D3D),
      period: const Duration(milliseconds: 1200),
      direction: ShimmerDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: List.generate(
            3,
            (index) => Expanded(
              child: Container(
                margin: EdgeInsets.only(right: index < 2 ? 12.w : 0),
                padding:
                    EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Column(
                  children: [
                    _shimmerBox(width: 40.w, height: 24.h),
                    SizedBox(height: 8.h),
                    _shimmerBox(width: 50.w, height: 12.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

/// Horizontal animated shimmer for tag list loading state
class TagPayListShimmer extends StatelessWidget {
  const TagPayListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _TagPayCardShimmer(
          delay: Duration(milliseconds: index * 100),
        );
      },
    );
  }
}

class _TagPayCardShimmer extends StatefulWidget {
  final Duration delay;

  const _TagPayCardShimmer({this.delay = Duration.zero});

  @override
  State<_TagPayCardShimmer> createState() => _TagPayCardShimmerState();
}

class _TagPayCardShimmerState extends State<_TagPayCardShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Staggered appearance
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Stack(
              children: [
                // Content
                Row(
                  children: [
                    // Avatar shimmer
                    _buildShimmerContainer(
                      width: 48.w,
                      height: 48.w,
                      borderRadius: 24.r,
                      animation: _animation,
                    ),
                    SizedBox(width: 12.w),
                    // Text content shimmer
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShimmerContainer(
                            width: 140.w,
                            height: 16.h,
                            borderRadius: 4.r,
                            animation: _animation,
                          ),
                          SizedBox(height: 8.h),
                          _buildShimmerContainer(
                            width: 90.w,
                            height: 12.h,
                            borderRadius: 4.r,
                            animation: _animation,
                          ),
                        ],
                      ),
                    ),
                    // Amount shimmer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildShimmerContainer(
                          width: 80.w,
                          height: 20.h,
                          borderRadius: 4.r,
                          animation: _animation,
                        ),
                        SizedBox(height: 6.h),
                        _buildShimmerContainer(
                          width: 50.w,
                          height: 18.h,
                          borderRadius: 8.r,
                          animation: _animation,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerContainer({
    required double width,
    required double height,
    required double borderRadius,
    required Animation<double> animation,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [
              Color(0xFF2D2D2D),
              Color(0xFF3D3D3D),
              Color(0xFF4D4D4D),
              Color(0xFF3D3D3D),
              Color(0xFF2D2D2D),
            ],
            stops: [
              0.0,
              (animation.value - 0.3).clamp(0.0, 1.0),
              animation.value.clamp(0.0, 1.0),
              (animation.value + 0.3).clamp(0.0, 1.0),
              1.0,
            ],
          ),
        ),
      ),
    );
  }
}

/// Horizontal scrolling shimmer for compact loading views
class TagPayHorizontalShimmer extends StatelessWidget {
  const TagPayHorizontalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Shimmer.fromColors(
        baseColor: const Color(0xFF1F1F1F),
        highlightColor: const Color(0xFF3D3D3D),
        period: const Duration(milliseconds: 1200),
        direction: ShimmerDirection.ltr,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              width: 160.w,
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Container(
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 80.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Full screen loading shimmer with animated gradient
class TagPayFullScreenShimmer extends StatelessWidget {
  const TagPayFullScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1F1F1F),
      highlightColor: const Color(0xFF3D3D3D),
      period: const Duration(milliseconds: 1200),
      direction: ShimmerDirection.ltr,
      child: Column(
        children: [
          // Stats shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: index < 2 ? 12.w : 0),
                    height: 70.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // List items shimmer
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
