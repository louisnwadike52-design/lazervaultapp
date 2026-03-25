import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// TikTok-style full-screen gift entrance animation.
///
/// For premium/luxury/legendary gifts, shows a dramatic entrance:
/// - Screen dims
/// - Large gift emoji sweeps in from the left with trail particles
/// - Sender name + gift name displayed
/// - Glowing aura around the gift
/// - Fades out after animation completes
class GiftEntranceAnimation extends StatefulWidget {
  final String emoji;
  final String giftName;
  final String senderName;
  final String category;
  final VoidCallback onComplete;

  const GiftEntranceAnimation({
    super.key,
    required this.emoji,
    required this.giftName,
    required this.senderName,
    this.category = 'premium',
    required this.onComplete,
  });

  @override
  State<GiftEntranceAnimation> createState() => _GiftEntranceAnimationState();
}

class _GiftEntranceAnimationState extends State<GiftEntranceAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _glowController;

  // Main emoji animations
  late final Animation<double> _emojiX;
  late final Animation<double> _emojiScale;
  late final Animation<double> _emojiRotation;

  // Overlay animations
  late final Animation<double> _dimOpacity;
  late final Animation<double> _textOpacity;
  late final Animation<double> _textSlide;

  // Glow pulse
  late final Animation<double> _glowScale;

  // Trail particles
  late final List<_TrailParticle> _particles;
  final _random = Random();

  @override
  void initState() {
    super.initState();

    // Main animation: 3 seconds per gift
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Glow pulses during the hold phase
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Emoji enters from left, holds center, exits right
    _emojiX = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: -0.5, end: 0.5)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.5, end: 0.5), // hold center
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.5, end: 1.5)
            .chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 25,
      ),
    ]).animate(_mainController);

    // Scale: start small, grow big at center, shrink on exit
    _emojiScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.3, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.0), // hold
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.5)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 25,
      ),
    ]).animate(_mainController);

    // Subtle rotation during entrance
    _emojiRotation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: -0.15, end: 0.05),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.05, end: 0.0),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.0),
        weight: 50,
      ),
    ]).animate(_mainController);

    // Screen dim
    _dimOpacity = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 0.5),
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.5, end: 0.5),
        weight: 55,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.5, end: 0.0),
        weight: 30,
      ),
    ]).animate(_mainController);

    // Text fade in after emoji arrives
    _textOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 25),
    ]).animate(_mainController);

    _textSlide = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 20.0, end: 20.0), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 20.0, end: 0.0), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 55),
    ]).animate(_mainController);

    _glowScale = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    // Generate trail particles
    _particles = List.generate(20, (_) {
      return _TrailParticle(
        offsetY: (_random.nextDouble() - 0.5) * 120,
        delay: _random.nextDouble() * 0.3,
        size: 4 + _random.nextDouble() * 8,
        opacity: 0.3 + _random.nextDouble() * 0.7,
      );
    });

    // Start animations — stop glow when main completes to prevent leak
    _mainController.forward().then((_) {
      if (!mounted) return; // Guard against calling stop on disposed controller
      _glowController.stop();
      widget.onComplete();
    });
    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Stop before dispose to prevent callbacks firing after disposal
    _mainController.stop();
    _glowController.stop();
    _mainController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  Color _glowColor() {
    switch (widget.category) {
      case 'legendary':
        return const Color(0xFFFFD700);
      case 'luxury':
      case 'deluxe':
        return const Color(0xFFFF6B35);
      default:
        return const Color(0xFFA78BFA);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final glowColor = _glowColor();

    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, _) {
        final emojiX = _emojiX.value * size.width;
        final emojiY = size.height * 0.35;

        return Stack(
          children: [
            // Dim overlay
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  color: Colors.black.withValues(alpha: _dimOpacity.value),
                ),
              ),
            ),

            // Trail particles (behind emoji)
            ..._particles.map((p) {
              final progress = (_mainController.value - p.delay).clamp(0.0, 1.0);
              if (progress <= 0) return const SizedBox.shrink();
              final trailX = emojiX - 40 - (progress * 60);
              final trailOpacity = p.opacity * (1.0 - progress);
              return Positioned(
                left: trailX,
                top: emojiY + p.offsetY,
                child: Opacity(
                  opacity: trailOpacity.clamp(0.0, 1.0),
                  child: Container(
                    width: p.size,
                    height: p.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: glowColor,
                      boxShadow: [
                        BoxShadow(
                          color: glowColor.withValues(alpha: 0.5),
                          blurRadius: p.size * 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Glow aura behind emoji
            Positioned(
              left: emojiX - 60,
              top: emojiY - 60,
              child: AnimatedBuilder(
                animation: _glowController,
                builder: (context, _) {
                  return Transform.scale(
                    scale: _emojiScale.value * _glowScale.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            glowColor.withValues(
                                alpha: 0.4 * _dimOpacity.value),
                            glowColor.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Main emoji
            Positioned(
              left: emojiX - 50,
              top: emojiY - 50,
              child: Transform.scale(
                scale: _emojiScale.value,
                child: Transform.rotate(
                  angle: _emojiRotation.value,
                  child: Text(
                    widget.emoji,
                    style: TextStyle(
                      fontSize: 80.sp,
                      shadows: [
                        Shadow(
                          color: glowColor.withValues(alpha: 0.6),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Sender info text
            Positioned(
              left: 0,
              right: 0,
              top: emojiY + 60,
              child: Opacity(
                opacity: _textOpacity.value.clamp(0.0, 1.0),
                child: Transform.translate(
                  offset: Offset(0, _textSlide.value),
                  child: Column(
                    children: [
                      Text(
                        widget.senderName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(color: Colors.black54, blurRadius: 8),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: glowColor.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: glowColor.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          'lazersprayed a ${widget.giftName}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            shadows: const [
                              Shadow(color: Colors.black38, blurRadius: 4),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TrailParticle {
  final double offsetY;
  final double delay;
  final double size;
  final double opacity;

  _TrailParticle({
    required this.offsetY,
    required this.delay,
    required this.size,
    required this.opacity,
  });
}
