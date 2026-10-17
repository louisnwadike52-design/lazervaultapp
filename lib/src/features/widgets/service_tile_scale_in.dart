import 'dart:async';

import 'package:flutter/material.dart';

/// A one-shot staggered scale-in for the dashboard's quick-service tiles.
///
/// The grid used to appear fully formed the instant the dashboard painted,
/// which reads as a static image rather than the app's primary set of
/// actions. Scaling each tile up in a short stagger draws the eye across the
/// row and makes the grid feel like it belongs to the account that just
/// loaded.
///
/// ## Why it plays only once
///
/// The grid rebuilds constantly — balance refreshes, account switches, the
/// reorder drag, every cubit emission behind it. Animating on each rebuild
/// would make the dashboard twitch for the rest of the session. The owning
/// state passes a [played] set that lives as long as the grid does, so a tile
/// animates on the dashboard's FIRST appearance (i.e. after login) and is
/// inert thereafter. `Set.add` returning false is the whole mechanism: it is
/// atomic, so two builds in the same frame cannot both claim the animation.
///
/// Swiping to the second page animates that page's tiles once, the first time
/// they are built — which is their first appearance, and the same intent.
class ServiceTileScaleIn extends StatefulWidget {
  /// Stable identity for this tile, used to decide whether it has already
  /// played. Must be unique within the grid.
  final String id;

  /// Position in the grid, which drives the stagger.
  final int index;

  /// Tiles that have already animated. Owned by the grid's State so it is
  /// discarded when the dashboard is.
  final Set<String> played;

  final Widget child;

  const ServiceTileScaleIn({
    super.key,
    required this.id,
    required this.index,
    required this.played,
    required this.child,
  });

  @override
  State<ServiceTileScaleIn> createState() => _ServiceTileScaleInState();
}

class _ServiceTileScaleInState extends State<ServiceTileScaleIn>
    with SingleTickerProviderStateMixin {
  static const Duration _duration = Duration(milliseconds: 260);

  /// Per-tile delay. Deliberately small: 12 tiles at 100ms each would take
  /// over a second before the last action is usable.
  static const Duration _step = Duration(milliseconds: 35);

  /// Beyond this the stagger stops accumulating, so a long grid never leaves
  /// its final tiles waiting.
  static const int _maxStaggered = 12;

  late final AnimationController _controller;
  late final Animation<double> _scale;

  /// The stagger delay, held so dispose can CANCEL it.
  ///
  /// This was a `Future.delayed` with a `mounted` guard, which stops the
  /// crash but not the timer: popping the dashboard mid-stagger left one live
  /// timer per tile still counting down. A widget test caught it as "pending
  /// timers" — the guard made it invisible in the app.
  Timer? _staggerTimer;

  @override
  void initState() {
    super.initState();
    // add() is false when the id was already present — that tile has played.
    final shouldPlay = widget.played.add(widget.id);

    _controller = AnimationController(vsync: this, duration: _duration);
    _scale = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    if (!shouldPlay) {
      _controller.value = 1.0;
      return;
    }
    _start();
  }

  void _start() {
    final delay = _step * widget.index.clamp(0, _maxStaggered);
    if (delay <= Duration.zero) {
      _controller.forward();
      return;
    }
    _staggerTimer = Timer(delay, () {
      // The dashboard can be popped, or the account switched, inside the
      // stagger window.
      if (!mounted) return;
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _staggerTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Honour the OS "reduce motion" setting: show the tile immediately rather
    // than animating it. Checked in build because the accessibility setting
    // can change while the app is open.
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) {
      // Deliberately does NOT touch _controller here. Assigning .value
      // notifies its listeners, and doing that during build is how you get
      // "setState() or markNeedsBuild() called during build". The controller
      // is simply not rendered; if it is mid-flight it finishes unobserved.
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      // The tile subtree is built ONCE and reused every frame — without this
      // the whole tile (icon, label, badge) rebuilds 60 times a second for
      // every tile in the grid.
      child: widget.child,
      builder: (context, child) => Opacity(
        // easeOutBack overshoots past 1.0, so the scale is not a usable
        // opacity value; drive the fade off the raw controller instead.
        opacity: _controller.value,
        child: Transform.scale(scale: _scale.value, child: child),
      ),
    );
  }
}
