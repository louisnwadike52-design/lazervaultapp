import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// TikTok-style rapid tap like counter that shows a big animated number
/// in the center-right area. Distinct from the unique-user like icon counter.
/// Pulses on each tap, fades after 2s of inactivity.
class TapLikeCounterOverlay extends StatefulWidget {
  const TapLikeCounterOverlay({super.key});

  @override
  TapLikeCounterOverlayState createState() => TapLikeCounterOverlayState();
}

class TapLikeCounterOverlayState extends State<TapLikeCounterOverlay>
    with TickerProviderStateMixin {
  int _tapCount = 0;
  Timer? _fadeTimer;
  bool _visible = false;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseScale;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeOpacity;

  // Floating hearts from tap position
  final List<_TapHeart> _hearts = [];
  int _heartIdCounter = 0;
  final _random = Random();

  static const _heartColors = [
    Color(0xFFFF1744),
    Color(0xFFFF4081),
    Color(0xFFE91E63),
    Color(0xFFF50057),
    Color(0xFFFF6090),
    Color(0xFFFFD700),
    Color(0xFF7C4DFF),
  ];

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _pulseScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() {
          _visible = false;
          _tapCount = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    _fadeTimer?.cancel();
    _pulseController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  /// Called when user taps the screen to "like"
  void addTap(Offset position) {
    if (!mounted) return;

    setState(() {
      _tapCount++;
      _visible = true;
    });

    // Reset fade
    _fadeTimer?.cancel();
    _fadeController.reset();

    // Pulse the counter
    _pulseController.forward(from: 0.0);

    // Add floating heart at tap position (cap at 15 to prevent memory overload)
    if (_hearts.length < 15) {
      setState(() {
        _hearts.add(_TapHeart(
          id: _heartIdCounter++,
          x: position.dx,
          y: position.dy,
          color: _heartColors[_random.nextInt(_heartColors.length)],
          size: 24 + _random.nextDouble() * 18,
        ));
      });
    }

    // Start fade timer (2s after last tap)
    _fadeTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        _fadeController.forward();
      }
    });
  }

  void _removeHeart(int id) {
    if (!mounted) return;
    setState(() => _hearts.removeWhere((h) => h.id == id));
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible && _hearts.isEmpty) return const SizedBox.shrink();

    return Stack(
      children: [
        // Floating hearts from tap positions
        ..._hearts.map((heart) => _AnimatedTapHeart(
              key: ValueKey('tap_heart_${heart.id}'),
              heart: heart,
              onComplete: () => _removeHeart(heart.id),
            )),

        // Counter display (center-right area)
        if (_visible)
          Positioned(
            right: 80.w,
            top: MediaQuery.of(context).size.height * 0.35,
            child: FadeTransition(
              opacity: _fadeOpacity,
              child: ScaleTransition(
                scale: _pulseScale,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF1744).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: const Color(0xFFFF1744).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: const Color(0xFFFF1744),
                        size: 24.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _formatCount(_tapCount),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(color: Colors.black54, blurRadius: 6),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) return '${(count / 1000000).toStringAsFixed(1)}M';
    if (count >= 1000) return '${(count / 1000).toStringAsFixed(1)}K';
    return count.toString();
  }
}

class _TapHeart {
  final int id;
  final double x;
  final double y;
  final Color color;
  final double size;

  _TapHeart({
    required this.id,
    required this.x,
    required this.y,
    required this.color,
    required this.size,
  });
}

class _AnimatedTapHeart extends StatefulWidget {
  final _TapHeart heart;
  final VoidCallback onComplete;

  const _AnimatedTapHeart({
    super.key,
    required this.heart,
    required this.onComplete,
  });

  @override
  State<_AnimatedTapHeart> createState() => _AnimatedTapHeartState();
}

class _AnimatedTapHeartState extends State<_AnimatedTapHeart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final _random = Random();
  late final double _driftX;
  late final double _waveFreq;

  @override
  void initState() {
    super.initState();
    _driftX = (_random.nextDouble() - 0.5) * 60;
    _waveFreq = 2 + _random.nextDouble() * 2;

    _controller = AnimationController(
      duration: Duration(milliseconds: 1500 + _random.nextInt(600)),
      vsync: this,
    );
    _controller.forward().then((_) {
      if (mounted) {
        widget.onComplete();
      }
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
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        final waveX = sin(t * pi * _waveFreq) * 15;
        final x = widget.heart.x - widget.heart.size / 2 + _driftX * t + waveX;
        final y = widget.heart.y - widget.heart.size / 2 - 200 * t;
        final opacity = t < 0.6 ? 1.0 : 1.0 - (t - 0.6) / 0.4;
        final scale = t < 0.1 ? t / 0.1 : (t < 0.3 ? 1.2 - (t - 0.1) * 1.0 : 1.0 - (t - 0.3) * 0.4);

        return Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: scale.clamp(0.3, 1.5),
              child: Icon(
                Icons.favorite,
                color: widget.heart.color,
                size: widget.heart.size,
                shadows: const [
                  Shadow(color: Colors.black26, blurRadius: 4),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
