import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'spray_hearts_layer.dart';

/// TikTok-style like counter that shows floating hearts rising up
/// when user taps the like button area.
///
/// The hearts need a tall runway to rise through, and this widget used to get
/// it by reserving `height: 300.h` for ITSELF. That works visually and is
/// ruinous for layout: the widget lives in the room's right-hand action rail,
/// so a ~66pt button was occupying 300pt of a column that also has to fit the
/// avatar and up to seven controls. The rail overflowed, and because it sits
/// in a SingleChildScrollView (which clips, and which nobody thinks to
/// scroll) the host's "End" control was simply not on screen.
///
/// So the runway is now a CONSTRUCTOR ARGUMENT, not a constant. The rail
/// passes [runwayHeight] sized to what the scroll viewport can actually show,
/// and callers with room to spare can ask for more. Everything else is
/// unchanged — same hearts, same colours, same cap of 15 in flight.
class LikeCounterOverlay extends StatefulWidget {
  final int totalLikes;
  final VoidCallback onLikeTap;

  /// Vertical space reserved above the button for hearts to rise through.
  ///
  /// This is layout space the parent must be able to give. In a scrolling
  /// rail it is the difference between the controls below fitting on screen
  /// and not, so it is deliberately the caller's decision.
  final double runwayHeight;

  /// Diameter of the like disc. Defaults to the historical 48; the action
  /// rail passes 40 so the like button lines up with its siblings instead of
  /// bulging out of the column.
  final double buttonSize;

  /// When supplied, this widget renders ONLY the button and forwards each tap
  /// to the controller; the hearts are drawn by a [SprayHeartsLayer]
  /// elsewhere in the tree. [runwayHeight] is then ignored — the whole point
  /// is that the button costs the rail nothing but its own height.
  final SprayHeartsController? heartsController;

  const LikeCounterOverlay({
    super.key,
    required this.totalLikes,
    required this.onLikeTap,
    this.runwayHeight = 300,
    this.buttonSize = 48,
    this.heartsController,
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
    // Hearts are drawn elsewhere — just ring the bell.
    if (widget.heartsController != null) {
      widget.heartsController!.pop();
      return;
    }
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
    // Detached mode: no runway, no heart children — just the control. This is
    // what lets the action rail fit its full set of buttons on screen.
    if (widget.heartsController != null) {
      return SizedBox(width: 80.w, child: _likeButton());
    }
    return SizedBox(
      width: 80.w,
      height: widget.runwayHeight.h,
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
            child: _likeButton(),
          ),
        ],
      ),
    );
  }

  Widget _likeButton() {
    return GestureDetector(
      onTap: _addHeart,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: widget.buttonSize.w,
            height: widget.buttonSize.w,
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
              size: (widget.buttonSize * 0.5).sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            _formatCount(widget.totalLikes),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              shadows: const [
                Shadow(color: Colors.black54, blurRadius: 4),
              ],
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
        final waveX =
            sin(_controller.value * pi * _waveFrequency) * _waveMagnitude;
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

/// The floating-heart animation on its own, with no like button and no
/// reserved layout height of its own — it fills whatever box the parent
/// gives it.
///
/// Exists so the hearts can be rendered OUTSIDE the action rail (see
/// SprayHeartsLayer). Spawning is imperative rather than prop-driven because
/// a heart is an EVENT: rebuilding from a count would replay the whole
/// animation whenever the widget rebuilt for an unrelated reason.
class LikeCounterOverlayHearts extends StatefulWidget {
  const LikeCounterOverlayHearts({super.key});

  @override
  State<LikeCounterOverlayHearts> createState() =>
      LikeCounterOverlayHeartsState();
}

class LikeCounterOverlayHeartsState extends State<LikeCounterOverlayHearts> {
  final List<_FloatingHeart> _hearts = [];
  int _heartIdCounter = 0;
  final _random = Random();

  /// Launch one heart. Capped at 15 in flight, matching the button's own
  /// limit — a fast tapper must not be able to spawn unbounded animations.
  void spawn() {
    if (!mounted || _hearts.length >= 15) return;
    setState(() {
      _hearts.add(_FloatingHeart(
        id: _heartIdCounter++,
        color: _LikeCounterOverlayState._heartColors[
            _random.nextInt(_LikeCounterOverlayState._heartColors.length)],
        startX: _random.nextDouble() * 40 - 20,
        size: 24 + _random.nextDouble() * 16,
      ));
    });
  }

  void _remove(int id) {
    if (!mounted) return;
    setState(() => _hearts.removeWhere((h) => h.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        for (final heart in _hearts)
          _AnimatedHeart(
            key: ValueKey(heart.id),
            heart: heart,
            onComplete: () => _remove(heart.id),
          ),
      ],
    );
  }
}
