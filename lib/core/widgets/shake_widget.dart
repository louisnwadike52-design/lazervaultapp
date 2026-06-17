import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A widget that shakes its [child] horizontally on demand — the Revolut-style
/// "wrong passcode" / failed-validation nudge.
///
/// Drive it imperatively via a [GlobalKey]:
/// ```dart
/// final _shakeKey = GlobalKey<ShakeWidgetState>();
/// ...
/// ShakeWidget(key: _shakeKey, child: passcodeDots),
/// ...
/// _shakeKey.currentState?.shake();   // on error
/// ```
/// Pair the shake with `Haptics.error()` for the full effect.
class ShakeWidget extends StatefulWidget {
  final Widget child;

  /// Total shake duration.
  final Duration duration;

  /// Peak horizontal offset in logical pixels.
  final double offset;

  /// Number of left-right oscillations.
  final int shakeCount;

  const ShakeWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.offset = 10.0,
    this.shakeCount = 3,
  });

  @override
  State<ShakeWidget> createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  /// Trigger the shake. Safe to call repeatedly; restarts from the beginning.
  void shake() {
    if (!mounted) return;
    _controller
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // A damped sine wave: full amplitude at the start, decaying to 0 so it
        // settles cleanly back to center.
        final t = _controller.value;
        final decay = 1.0 - t;
        final dx = math.sin(t * math.pi * 2 * widget.shakeCount) *
            widget.offset *
            decay;
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: widget.child,
    );
  }
}
