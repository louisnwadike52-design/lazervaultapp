import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'auth_background.dart';

/// A full-bleed auth background that cycles through the bundled
/// [AuthBackground] variants, swapping on a fixed interval with a cross-fade.
///
/// WHAT THIS COSTS, AND WHY THE LIMITS BELOW EXIST
/// -----------------------------------------------
/// Reported from the field: "I think that's why it's slow". Measured, it was
/// a fair suspicion. The thirteen bundled photos are 1.6 MB on disk but
/// **79 MB decoded** (eight of them are 1080x1920 = 7.9 MB of ARGB each), and
/// Flutter's default ImageCache budget is 100 MB. A login screen was therefore
/// able to claim about four fifths of the entire app's image cache and evict
/// everything else, so the dashboard behind it had to re-decode its own
/// images on arrival.
///
/// On top of that the old version decoded at FULL native resolution regardless
/// of the device, precached one image ahead forever, and never stopped — a
/// 7.9 MB decode plus a GPU texture upload every interval, with two
/// full-screen bitmaps composited for the length of the cross-fade. That work
/// lands on the raster thread, and it was still running while the user tapped
/// their passcode, which is the exact moment the UI must stay responsive.
///
/// Three limits follow, and none of them changes how it looks:
///
///   1. DECODE AT DISPLAY SIZE. `cacheWidth`/`cacheHeight` are derived from the
///      real device pixels, so a 720p phone decodes 3.5 MB instead of 7.9 MB
///      and nothing is downsampled at paint time.
///   2. EVICT WHAT WE HAVE LEFT. Once a cross-fade finishes, the image we faded
///      away from is dropped from the ImageCache. Resident memory stays at
///      roughly two images instead of growing to all thirteen.
///   3. STOP WHEN NOBODY IS LOOKING. The timer is cancelled when the app is
///      not in the foreground, instead of decoding photos behind a locked
///      screen.
///
/// Order is shuffled once per mount so successive images differ from launch to
/// launch, and the next image is precached before it is shown to avoid a flash
/// of empty background mid-transition.
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

class _RotatingAuthBackgroundState extends State<RotatingAuthBackground>
    with WidgetsBindingObserver {
  late final List<String> _order;
  int _index = 0;
  Timer? _timer;
  bool _didPrecache = false;

  /// Decode target in PHYSICAL pixels, resolved from the first build that has
  /// a MediaQuery. Null until then, which simply means "decode natively" for
  /// that one frame rather than guessing a size.
  int? _decodeWidth;
  int? _decodeHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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

    // Physical pixels of the viewport. Decoding larger than this buys nothing:
    // the extra samples are thrown away by the GPU on every frame.
    final mq = MediaQuery.maybeOf(context);
    if (mq != null) {
      final dpr = mq.devicePixelRatio;
      _decodeWidth = (mq.size.width * dpr).round();
      _decodeHeight = (mq.size.height * dpr).round();
    }

    if (!_didPrecache) {
      _didPrecache = true;
      // Warm the current + next image so the first swap is seamless.
      _precache(_index);
      _precache(_nextIndex(_index));
    }
    _startTimer();
  }

  void _startTimer() {
    // Only rotate when there's more than one image to rotate through.
    if (_timer == null && _order.length > 1) {
      _timer = Timer.periodic(widget.interval, (_) => _advance());
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// Rotating photos behind a backgrounded app is pure waste — a decode and a
  /// texture upload per interval that nobody can see, competing with whatever
  /// the user actually switched to.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startTimer();
    } else {
      _stopTimer();
    }
  }

  int _nextIndex(int i) => (i + 1) % _order.length;

  /// The provider for [path], sized for this device. Built in one place so the
  /// cache key used by precache, paint and evict is always identical — a
  /// mismatched key would precache one entry and then decode a second.
  ImageProvider _providerFor(String path) {
    final asset = AssetImage(path);
    if (_decodeWidth == null || _decodeHeight == null) return asset;
    return ResizeImage(
      asset,
      width: _decodeWidth,
      height: _decodeHeight,
      policy: ResizeImagePolicy.fit,
      allowUpscaling: false,
    );
  }

  void _precache(int i) {
    if (i < 0 || i >= _order.length) return;
    // Guard against precaching after dispose.
    if (!mounted) return;
    precacheImage(_providerFor(_order[i]), context);
  }

  void _advance() {
    if (!mounted) return;
    final leaving = _index;
    final next = _nextIndex(_index);
    setState(() => _index = next);
    // Preload the image after next so it's ready by the following tick.
    _precache(_nextIndex(next));
    // Drop the one we are fading AWAY from, but only once the cross-fade has
    // finished — evicting mid-transition would blank the outgoing layer.
    // Without this the cache grows to every variant the session has shown.
    Future.delayed(widget.fadeDuration + const Duration(milliseconds: 100), () {
      if (!mounted) return;
      if (leaving == _index) return; // we came back to it; keep it
      _providerFor(_order[leaving]).evict();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopTimer();
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
        image: _providerFor(path),
        fit: widget.fit,
        width: double.infinity,
        height: double.infinity,
        gaplessPlayback: true,
        // The photo is decoration behind a login form; it must never be
        // announced or focused by a screen reader.
        excludeFromSemantics: true,
      ),
    );
  }
}
