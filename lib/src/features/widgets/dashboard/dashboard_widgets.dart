part of 'dashboard.dart';

/// Pill chip rendered at the top of the dashboard while the user is pulling
/// down. Reads from a [ValueNotifier<double>] (0..1) so only this widget
/// rebuilds during the drag — not the whole dashboard tree.
class _SwipeDownIndicator extends StatelessWidget {
  final ValueListenable<double> progress;

  const _SwipeDownIndicator({required this.progress});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: progress,
      builder: (_, value, __) {
        if (value <= 0.0) return const SizedBox.shrink();
        final ready = value >= 1.0;
        final scale = 0.85 + 0.15 * value;
        // Opacity comes in fast so even a tiny pull confirms the gesture is
        // being read.
        final opacity = (value * 1.6).clamp(0.0, 1.0);
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, value * 8),
            child: Transform.scale(
              scale: scale,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: ready
                        ? const Color(0xFF10B981)
                        : const Color(0xFF3B82F6).withValues(
                            alpha: 0.4 + 0.6 * value,
                          ),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      ready
                          ? Icons.check_circle_rounded
                          : Icons.swipe_down_rounded,
                      size: 14.sp,
                      color: ready
                          ? const Color(0xFF10B981)
                          : Colors.white,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      ready ? 'Release for actions' : 'Pull to open actions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
