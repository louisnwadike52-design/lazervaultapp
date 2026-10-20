import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A right-edge affordance that appears ONLY when the scrollable it wraps
/// actually overflows, and fades out as the viewer reaches the bottom.
///
/// Why it exists: a panel that scrolls but shows no scrollbar and no clipped
/// content at the fold looks finished. On the group-contribution details screen
/// the block above the tab bar is a variable stack of cards — summary, start /
/// receiver actions, payout banner, status chips, external links — so on a
/// small screen with several of them showing there is more below with nothing
/// on screen to say so.
///
/// It takes no [ScrollController]: it listens for the scroll notifications that
/// bubble out of its child, so wrapping an existing scroll view is a one-line
/// change and nothing inside it has to be rewired. That also means it works
/// with whatever scrollable is in there — [SingleChildScrollView], a
/// [ListView], one nested in a [RefreshIndicator].
class ScrollMoreHint extends StatefulWidget {
  /// The scrollable to wrap.
  final Widget child;

  /// Distance from the bottom, in logical pixels, at which the hint has fully
  /// faded. Below this the content is close enough to done that pointing
  /// further down is noise.
  final double fadeWithin;

  /// Painted behind the chevron so it stays legible over a card edge.
  final Color background;

  /// The chevron itself.
  final Color foreground;

  const ScrollMoreHint({
    super.key,
    required this.child,
    this.fadeWithin = 48,
    this.background = const Color(0xFF2A2A2A),
    this.foreground = Colors.white,
  });

  @override
  State<ScrollMoreHint> createState() => _ScrollMoreHintState();
}

class _ScrollMoreHintState extends State<ScrollMoreHint> {
  /// Quantised so a drag does not setState on every pixel — only when the
  /// hint crosses into a visibly different opacity.
  double _opacity = 0;

  void _update(ScrollMetrics m) {
    // maxScrollExtent is 0 when the content fits. The 1px floor keeps a
    // sub-pixel rounding difference from showing a hint for nothing.
    if (!m.hasContentDimensions || m.maxScrollExtent <= 1) {
      _set(0);
      return;
    }
    final remaining = m.maxScrollExtent - m.pixels;
    if (remaining <= 0) {
      _set(0);
      return;
    }
    final raw = (remaining / widget.fadeWithin).clamp(0.0, 1.0);
    // 4 buckets: enough to read as a fade, few enough to be cheap.
    _set((raw * 4).round() / 4);
  }

  void _set(double value) {
    if (value == _opacity) return;
    // Notifications arrive during layout/paint, so defer the rebuild.
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || value == _opacity) return;
      setState(() => _opacity = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      // Fires when the CONTENT changes size without any scrolling — a card
      // appearing or going away. Without this the hint would only ever be
      // correct after the first drag.
      onNotification: (n) {
        _update(n.metrics);
        return false;
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          _update(n.metrics);
          return false;
        },
        child: Stack(
          children: [
            widget.child,
            Positioned(
              right: 6.w,
              bottom: 10.h,
              child: IgnorePointer(
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(milliseconds: 180),
                  child: Container(
                    width: 26.w,
                    height: 26.w,
                    decoration: BoxDecoration(
                      color: widget.background.withValues(alpha: 0.92),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 18.sp,
                      color: widget.foreground,
                      semanticLabel: 'More below, scroll for the rest',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
