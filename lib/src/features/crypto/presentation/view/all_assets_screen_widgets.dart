part of 'all_assets_screen.dart';

/// Controls what happens when an asset is tapped.
///   - browse : expand an inline accordion (wallet / details CTAs).
///   - buy    : open the streamlined buy bottom sheet locked to the asset.
///   - sell   : go to the asset detail screen (sell entry).
///   - receive: open the receive/deposit address sheet for the asset.
enum AssetSelectionMode { browse, buy, sell, receive }

/// Shimmer loading placeholder for a single asset row.
class _ShimmerAssetItem extends StatefulWidget {
  final int delay;
  const _ShimmerAssetItem({this.delay = 0});

  @override
  State<_ShimmerAssetItem> createState() => _ShimmerAssetItemState();
}

class _ShimmerAssetItemState extends State<_ShimmerAssetItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
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
        final opacity = _animation.value;
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: Colors.grey[850]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[800]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 12.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[800]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 14.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[800]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 18.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[800]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
