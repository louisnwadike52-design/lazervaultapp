import 'package:flutter/material.dart';

/// The ONE success checkmark for payment flows.
///
/// A scalloped "verified" badge that scales in with a spring and throws a
/// soft expanding splash ring behind it — the moment of confirmation every
/// money flow shares. Send Funds, Contactless/Tap Pay and the other payment
/// services each hand-rolled their own success mark (plain circles, different
/// greens, no motion), so the most emotionally important frame in the product
/// looked different in every flow. One widget ends the drift: adopt it and a
/// transfer's success is recognisably the same event as a tap-to-pay's.
///
/// Pure Flutter animation — no Lottie asset to load, nothing to fail; safe on
/// a screen that must render even when the network is gone.
class SuccessCheckmark extends StatefulWidget {
  const SuccessCheckmark({
    super.key,
    this.size = 96,
    this.color = const Color(0xFF10B981),
    this.icon = Icons.verified_rounded,
  });

  /// Diameter of the badge itself; the splash rings extend ~60% beyond it.
  final double size;

  /// Badge colour. Success green by default; pass amber/red to reuse the same
  /// motion for pending/failed states so the family stays consistent.
  final Color color;

  /// The badge glyph. [Icons.verified_rounded] is the scalloped seal; a flow
  /// with its own identity (e.g. a schedule) can swap the glyph and keep the
  /// splash.
  final IconData icon;

  @override
  State<SuccessCheckmark> createState() => _SuccessCheckmarkState();
}

class _SuccessCheckmarkState extends State<SuccessCheckmark>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _badgeScale;
  late final Animation<double> _splash;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    // The badge pops with a spring overshoot — the "stamp" moment.
    _badgeScale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.55, curve: Curves.elasticOut),
    );
    // The splash rings run a beat behind the stamp and fade as they grow.
    _splash = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.15, 1.0, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final outer = widget.size * 1.6;
    return SizedBox(
      width: outer,
      height: outer,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _splash.value;
          return Stack(
            alignment: Alignment.center,
            children: [
              // Two staggered splash rings. Opacity dies as radius grows, so
              // the splash reads as energy leaving the stamp, not a border.
              for (final (delay, strength) in const [(0.0, 0.35), (0.25, 0.22)])
                if (t > delay)
                  Container(
                    width: widget.size + (outer - widget.size) * ((t - delay) / (1 - delay)),
                    height: widget.size + (outer - widget.size) * ((t - delay) / (1 - delay)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color.withValues(
                        alpha: strength * (1 - ((t - delay) / (1 - delay))),
                      ),
                    ),
                  ),
              Transform.scale(
                scale: _badgeScale.value,
                child: Icon(
                  widget.icon,
                  size: widget.size,
                  color: widget.color,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
