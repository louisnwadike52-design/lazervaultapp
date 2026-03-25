import 'dart:math';
import 'package:flutter/material.dart';

/// TikTok-style floating emoji/icon that rises from bottom-right and fades out.
/// Used for likes, gifts, and spray animations.
class FloatingEmojiAnimation extends StatefulWidget {
  final String emoji;
  final VoidCallback onComplete;
  final double startX;
  final double startY;
  final double size;

  const FloatingEmojiAnimation({
    super.key,
    required this.emoji,
    required this.onComplete,
    this.startX = 0.85,
    this.startY = 0.7,
    this.size = 36,
  });

  @override
  State<FloatingEmojiAnimation> createState() => _FloatingEmojiAnimationState();
}

class _FloatingEmojiAnimationState extends State<FloatingEmojiAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _translateY;
  late final Animation<double> _translateX;
  late final Animation<double> _scale;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500 + _random.nextInt(1000)),
      vsync: this,
    );

    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 15),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 55),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_controller);

    _translateY = Tween<double>(begin: 0, end: -300 - _random.nextDouble() * 150)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Sinusoidal horizontal drift
    final drift = (_random.nextDouble() - 0.5) * 80;
    _translateX = Tween<double>(begin: 0, end: drift)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.3, end: 1.2), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.6), weight: 60),
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
        return Positioned(
          right: MediaQuery.of(context).size.width * (1 - widget.startX),
          bottom: MediaQuery.of(context).size.height * (1 - widget.startY),
          child: Transform.translate(
            offset: Offset(_translateX.value, _translateY.value),
            child: Opacity(
              opacity: _opacity.value.clamp(0.0, 1.0),
              child: Transform.scale(
                scale: _scale.value,
                child: Text(
                  widget.emoji,
                  style: TextStyle(fontSize: widget.size),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Burst animation for premium gifts - multiple emojis explode outward
class BurstEmojiAnimation extends StatefulWidget {
  final String emoji;
  final int count;
  final VoidCallback onComplete;
  final Offset center;

  const BurstEmojiAnimation({
    super.key,
    required this.emoji,
    this.count = 8,
    required this.onComplete,
    required this.center,
  });

  @override
  State<BurstEmojiAnimation> createState() => _BurstEmojiAnimationState();
}

class _BurstEmojiAnimationState extends State<BurstEmojiAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_BurstParticle> _particles;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _particles = List.generate(widget.count, (i) {
      final angle = (2 * pi * i / widget.count) + (_random.nextDouble() - 0.5) * 0.5;
      final distance = 80 + _random.nextDouble() * 120;
      return _BurstParticle(
        dx: cos(angle) * distance,
        dy: sin(angle) * distance,
        rotation: _random.nextDouble() * 2 * pi,
        scale: 0.6 + _random.nextDouble() * 0.8,
      );
    });

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
      builder: (context, _) {
        final progress = _controller.value;
        final opacity = progress < 0.7 ? 1.0 : (1.0 - (progress - 0.7) / 0.3);

        return Stack(
          children: _particles.map((p) {
            final curve = Curves.easeOut.transform(progress);
            return Positioned(
              left: widget.center.dx + p.dx * curve - 18,
              top: widget.center.dy + p.dy * curve - 18,
              child: Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: p.scale * (1.0 - progress * 0.3),
                  child: Transform.rotate(
                    angle: p.rotation * progress,
                    child: Text(widget.emoji, style: const TextStyle(fontSize: 36)),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _BurstParticle {
  final double dx;
  final double dy;
  final double rotation;
  final double scale;

  _BurstParticle({
    required this.dx,
    required this.dy,
    required this.rotation,
    required this.scale,
  });
}

/// Rain animation - emojis fall from top of screen
class RainEmojiAnimation extends StatefulWidget {
  final String emoji;
  final int count;
  final VoidCallback onComplete;

  const RainEmojiAnimation({
    super.key,
    required this.emoji,
    this.count = 12,
    required this.onComplete,
  });

  @override
  State<RainEmojiAnimation> createState() => _RainEmojiAnimationState();
}

class _RainEmojiAnimationState extends State<RainEmojiAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_RainDrop> _drops;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _drops = List.generate(widget.count, (_) {
      return _RainDrop(
        x: _random.nextDouble(),
        delay: _random.nextDouble() * 0.4,
        speed: 0.7 + _random.nextDouble() * 0.6,
        scale: 0.5 + _random.nextDouble() * 0.8,
        wobble: (_random.nextDouble() - 0.5) * 30,
      );
    });

    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Stack(
          children: _drops.map((drop) {
            final progress = ((_controller.value - drop.delay) / (1.0 - drop.delay))
                .clamp(0.0, 1.0) * drop.speed;
            final y = -50 + progress * (size.height + 100);
            final x = drop.x * size.width + sin(progress * 3) * drop.wobble;
            final opacity = progress < 0.8 ? 1.0 : (1.0 - (progress - 0.8) / 0.2);

            return Positioned(
              left: x - 18,
              top: y,
              child: Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: drop.scale,
                  child: Text(widget.emoji, style: const TextStyle(fontSize: 32)),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _RainDrop {
  final double x;
  final double delay;
  final double speed;
  final double scale;
  final double wobble;

  _RainDrop({
    required this.x,
    required this.delay,
    required this.speed,
    required this.scale,
    required this.wobble,
  });
}

/// Glow pulse animation around the host avatar
class GlowAnimation extends StatefulWidget {
  final String emoji;
  final VoidCallback onComplete;
  final Offset center;

  const GlowAnimation({
    super.key,
    required this.emoji,
    required this.onComplete,
    required this.center,
  });

  @override
  State<GlowAnimation> createState() => _GlowAnimationState();
}

class _GlowAnimationState extends State<GlowAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
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
      builder: (context, _) {
        final progress = _controller.value;
        final scale = 1.0 + progress * 3;
        final opacity = progress < 0.3 ? progress / 0.3 : (1.0 - (progress - 0.3) / 0.7);

        return Positioned(
          left: widget.center.dx - 60 * scale / 2,
          top: widget.center.dy - 60 * scale / 2,
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Container(
              width: 60 * scale,
              height: 60 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFFD700).withValues(alpha: 0.6),
                    const Color(0xFFFFD700).withValues(alpha: 0.0),
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  widget.emoji,
                  style: TextStyle(fontSize: 36 * (1 + progress * 0.5)),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Shake animation - screen shakes when a big gift is sent
class ShakeAnimation extends StatefulWidget {
  final Widget child;
  final bool isShaking;

  const ShakeAnimation({
    super.key,
    required this.child,
    this.isShaking = false,
  });

  @override
  State<ShakeAnimation> createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticIn),
    );
  }

  @override
  void didUpdateWidget(ShakeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isShaking && !oldWidget.isShaking) {
      _controller.forward(from: 0);
    }
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
        final shake = sin(_animation.value * pi * 6) * 5 * (1 - _animation.value);
        return Transform.translate(
          offset: Offset(shake, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
