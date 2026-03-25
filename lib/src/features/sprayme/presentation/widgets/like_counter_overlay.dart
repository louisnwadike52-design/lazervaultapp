import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// TikTok-style like counter that shows floating hearts rising up
/// when user taps the like button area.
class LikeCounterOverlay extends StatefulWidget {
  final int totalLikes;
  final VoidCallback onLikeTap;

  const LikeCounterOverlay({
    super.key,
    required this.totalLikes,
    required this.onLikeTap,
  });

  @override
  State<LikeCounterOverlay> createState() => _LikeCounterOverlayState();
}

class _LikeCounterOverlayState extends State<LikeCounterOverlay> {
  final List<_FloatingHeart> _hearts = [];
  int _heartIdCounter = 0;
  final _random = Random();

  void _addHeart() {
    widget.onLikeTap();
    if (_hearts.length >= 15) return;
    setState(() {
      _hearts.add(_FloatingHeart(
        id: _heartIdCounter++,
        color: _heartColors[_random.nextInt(_heartColors.length)],
        startX: _random.nextDouble() * 40 - 20,
        size: 24 + _random.nextDouble() * 16,
      ));
    });
  }

  void _removeHeart(int id) {
    if (!mounted) return;
    setState(() {
      _hearts.removeWhere((h) => h.id == id);
    });
  }

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
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 300.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          // Floating hearts
          ...List.generate(_hearts.length, (i) {
            final heart = _hearts[i];
            return _AnimatedHeart(
              key: ValueKey(heart.id),
              heart: heart,
              onComplete: () => _removeHeart(heart.id),
            );
          }),

          // Like button
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: _addHeart,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1F1F1F).withValues(alpha: 0.8),
                      border: Border.all(
                        color: const Color(0xFFFF1744).withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: const Color(0xFFFF1744),
                      size: 26.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formatCount(widget.totalLikes),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(color: Colors.black54, blurRadius: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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

class _FloatingHeart {
  final int id;
  final Color color;
  final double startX;
  final double size;

  _FloatingHeart({
    required this.id,
    required this.color,
    required this.startX,
    required this.size,
  });
}

class _AnimatedHeart extends StatefulWidget {
  final _FloatingHeart heart;
  final VoidCallback onComplete;

  const _AnimatedHeart({
    super.key,
    required this.heart,
    required this.onComplete,
  });

  @override
  State<_AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<_AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _translateY;
  late final Animation<double> _scale;
  final _random = Random();
  late final double _waveMagnitude;
  late final double _waveFrequency;

  @override
  void initState() {
    super.initState();
    _waveMagnitude = 15 + _random.nextDouble() * 25;
    _waveFrequency = 2 + _random.nextDouble() * 3;

    _controller = AnimationController(
      duration: Duration(milliseconds: 1800 + _random.nextInt(800)),
      vsync: this,
    );

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 40),
    ]).animate(_controller);

    _translateY = Tween<double>(begin: 0, end: -250)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.3), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.5), weight: 70),
    ]).animate(_controller);

    _controller.forward().then((_) => widget.onComplete());
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
        final waveX = sin(_controller.value * pi * _waveFrequency) * _waveMagnitude;
        return Positioned(
          bottom: 60.h - _translateY.value,
          left: 16.w + widget.heart.startX + waveX,
          child: Opacity(
            opacity: _opacity.value.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: _scale.value,
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
