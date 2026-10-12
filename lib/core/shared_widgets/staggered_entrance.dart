import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lazervault/core/config/feature_flags.dart';

/// Brings list items in ONE BY ONE, after the page itself has finished rising.
///
/// [ServiceEntranceAnimation] lifts a whole content area as a single block, so
/// everything inside it arrives at once. For a short, scannable row — the
/// saved recipients on Select Recipient — the items reading in sequence is
/// what makes the list feel populated rather than simply present.
///
/// [index] is the item's position, [startDelay] holds the first item back
/// until the page animation has landed (the sheet slides for 800ms), and
/// [stagger] is the gap between neighbours. Total delay is
/// `startDelay + index * stagger`, capped by [maxStaggerIndex] so a long list
/// cannot push its tail into a visibly late arrival.
///
/// Honours the same [FeatureFlags.serviceEntranceAnimation] switch as the page
/// animation: with it off the child renders immediately and no controller is
/// created. Also skipped when the platform asks for reduced motion, which is
/// an accessibility setting a decorative stagger has no business overriding.
class StaggeredEntrance extends StatefulWidget {
  const StaggeredEntrance({
    super.key,
    required this.child,
    required this.index,
    this.enabled,
    this.startDelay = const Duration(milliseconds: 780),
    this.stagger = const Duration(milliseconds: 90),
    this.duration = const Duration(milliseconds: 380),
    this.beginOffset = const Offset(0.12, 0),
    this.maxStaggerIndex = 8,
  });

  final Widget child;
  final int index;

  /// Overrides the admin flag when non-null (tests, one-off screens).
  final bool? enabled;

  final Duration startDelay;
  final Duration stagger;
  final Duration duration;

  /// Where the item comes FROM. Defaults to a small slide from the trailing
  /// edge, which suits a horizontal rail; pass `Offset(0, 0.15)` for a column.
  final Offset beginOffset;

  final int maxStaggerIndex;

  /// The delay for [index], exposed for testing: the stagger is the whole
  /// point of this widget, so it is worth asserting rather than eyeballing.
  static Duration delayFor(
    int index, {
    Duration startDelay = const Duration(milliseconds: 780),
    Duration stagger = const Duration(milliseconds: 90),
    int maxStaggerIndex = 8,
  }) {
    final capped = index < 0
        ? 0
        : (index > maxStaggerIndex ? maxStaggerIndex : index);
    return startDelay + stagger * capped;
  }

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _fade;
  Animation<Offset>? _slide;
  Timer? _timer;
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    _animate = widget.enabled ?? FeatureFlags.serviceEntranceAnimation;
    if (!_animate) return;

    _controller =
        AnimationController(duration: widget.duration, vsync: this);
    _fade = CurvedAnimation(parent: _controller!, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: widget.beginOffset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));

    _timer = Timer(
      StaggeredEntrance.delayFor(
        widget.index,
        startDelay: widget.startDelay,
        stagger: widget.stagger,
        maxStaggerIndex: widget.maxStaggerIndex,
      ),
      () {
        // The screen can be popped while the item is still waiting its turn.
        if (mounted) _controller?.forward();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reduced motion is read here rather than in initState because it comes
    // from MediaQuery. Jump straight to the end instead of cancelling, so the
    // item is fully visible rather than stuck at its start offset.
    if (_animate && MediaQuery.maybeDisableAnimationsOf(context) == true) {
      _timer?.cancel();
      _controller?.value = 1.0;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_animate) return widget.child;
    return FadeTransition(
      opacity: _fade!,
      child: SlideTransition(position: _slide!, child: widget.child),
    );
  }
}
