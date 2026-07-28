import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'auth_background.dart';

/// A full-bleed auth background that cycles through every bundled
/// [AuthBackground] variant, swapping to a new image on a fixed interval with a
/// smooth cross-fade (fade-out old / fade-in new).
///
/// Order is shuffled once per mount so successive images differ from launch to
/// launch, and the next image is precached before it's shown to avoid a flash
/// of empty background mid-transition. All images are the compressed webp assets
/// bundled under `assets/images/bg/`.
class RotatingAuthBackground extends StatefulWidget {
  const RotatingAuthBackground({
    super.key,
    this.interval = const Duration(seconds: 5),
    this.fadeDuration = const Duration(milliseconds: 900),
    this.fit = BoxFit.cover,
  });

  /// How long each image stays before fading to the next.
  final Duration interval;

  /// Duration of the cross-fade between images.
  final Duration fadeDuration;

  final BoxFit fit;

  @override
  State<RotatingAuthBackground> createState() => _RotatingAuthBackgroundState();
}

class _RotatingAuthBackgroundState extends State<RotatingAuthBackground> {
  late final List<String> _order;
  int _index = 0;
  Timer? _timer;
  bool _didPrecache = false;

  @override
  void initState() {
    super.initState();
    // Shuffle a private copy so we cycle through all variants in a random order
    // without repeating until every image has been shown.
    _order = List<String>.of(AuthBackground.all)..shuffle(Random());
    if (_order.isEmpty) {
      _order.add(AuthBackground.current);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didPrecache) {
      _didPrecache = true;
      // Warm the current + next image so the first swap is seamless.
      _precache(_index);
      _precache(_nextIndex(_index));
    }
    // Only rotate when there's more than one image to rotate through.
    if (_timer == null && _order.length > 1) {
      _timer = Timer.periodic(widget.interval, (_) => _advance());
    }
  }

  int _nextIndex(int i) => (i + 1) % _order.length;

  void _precache(int i) {
    if (i < 0 || i >= _order.length) return;
    // Guard against precaching after dispose.
    if (!mounted) return;
    precacheImage(AssetImage(_order[i]), context);
  }

  void _advance() {
    if (!mounted) return;
    final next = _nextIndex(_index);
    setState(() => _index = next);
    // Preload the image after next so it's ready by the following tick.
    _precache(_nextIndex(next));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final path = _order[_index];
    return AnimatedSwitcher(
      duration: widget.fadeDuration,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      // Default AnimatedSwitcher transition is a fade — old image fades out as
      // the new one fades in, both stacked full-bleed.
      layoutBuilder: (currentChild, previousChildren) => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      child: Image(
        key: ValueKey<String>(path),
        image: AssetImage(path),
        fit: widget.fit,
        width: double.infinity,
        height: double.infinity,
        gaplessPlayback: true,
      ),
    );
  }
}
