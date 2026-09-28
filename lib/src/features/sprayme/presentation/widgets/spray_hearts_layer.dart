import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'like_counter_overlay.dart';

/// Fires a heart. Held by the room, bumped by the like button in the action
/// rail, listened to by [SprayHeartsLayer].
///
/// The indirection exists because the two halves have to live in DIFFERENT
/// parts of the widget tree. The button belongs in the right-hand action rail;
/// the hearts must rise through space the rail does not own — the rail sits in
/// a SingleChildScrollView, which clips, so anything drawn above the button
/// inside it is either cut off or paid for in layout height the rail cannot
/// spare.
class SprayHeartsController extends ChangeNotifier {
  int _tick = 0;

  /// Monotonic counter; [SprayHeartsLayer] spawns a heart on each change.
  int get tick => _tick;

  void pop() {
    _tick++;
    notifyListeners();
  }
}

/// The floating-heart animation, rendered OVER the action rail rather than
/// inside it.
///
/// Position this in the room's own Stack, aligned to the rail's column and
/// tall enough for a satisfying rise. It is purely decorative and must not
/// intercept touches — the controls underneath have to stay tappable — hence
/// [IgnorePointer].
class SprayHeartsLayer extends StatefulWidget {
  final SprayHeartsController controller;

  const SprayHeartsLayer({super.key, required this.controller});

  @override
  State<SprayHeartsLayer> createState() => _SprayHeartsLayerState();
}

class _SprayHeartsLayerState extends State<SprayHeartsLayer> {
  int _seen = 0;
  final GlobalKey<LikeCounterOverlayHeartsState> _heartsKey =
      GlobalKey<LikeCounterOverlayHeartsState>();

  @override
  void initState() {
    super.initState();
    _seen = widget.controller.tick;
    widget.controller.addListener(_onTick);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTick);
    super.dispose();
  }

  void _onTick() {
    if (!mounted) return;
    final t = widget.controller.tick;
    if (t == _seen) return;
    _seen = t;
    _heartsKey.currentState?.spawn();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: LikeCounterOverlayHearts(key: _heartsKey),
    );
  }
}
