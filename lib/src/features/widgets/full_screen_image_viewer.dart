import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// AN IMAGE, FULL SCREEN, PUT BACK WHERE IT CAME FROM.
///
/// ## Why one of these for the whole app
///
/// Three surfaces need the same thing — a support ticket's screenshot, an
/// event flyer, a chat attachment — and each had grown its own: one a bare
/// `showDialog` with no gesture, one a new browser tab, one nothing at all.
/// The behaviour people expect from a photo is the same everywhere, so it is
/// written once.
///
/// ## What it actually does
///
///   * **Hero flight.** The thumbnail grows into the full image and shrinks
///     back into it. That is the "animated restore" — the image returns to the
///     place it was opened from rather than the page cutting, so the reader
///     keeps their position in a long thread.
///   * **Drag to dismiss, in any direction**, with the backdrop fading as the
///     image is pulled away. A short drag springs back; a long one or a flick
///     dismisses.
///   * **Pinch to zoom**, because the reason a screenshot of an error was sent
///     is usually small type in a corner of it.
///   * **Three ways out** — the gesture, a tap anywhere, and a close control —
///     because an overlay covering the whole screen is the wrong place to be
///     clever about how it closes.
///
/// ## The route is transparent on purpose
///
/// An opaque route would leave the page behind it unpainted during the drag,
/// so the image would appear to be pulled off a blank wall. Transparent means
/// the thread stays visible underneath and the dismissal reads as putting the
/// image down.
class FullScreenImageViewer extends StatefulWidget {
  const FullScreenImageViewer({
    super.key,
    required this.url,
    this.heroTag,
    this.caption,
  });

  final String url;

  /// Defaults to the URL. Passed explicitly when one screen shows the same
  /// image twice — two Heroes sharing a tag in one tree throws on flight.
  final String? heroTag;

  /// Optional line under the image: who sent it, when.
  final String? caption;

  /// Opens the viewer over the current route. A blank URL is a no-op rather
  /// than a black screen with a broken-image icon.
  static Future<void> open(
    BuildContext context,
    String url, {
    String? heroTag,
    String? caption,
  }) {
    if (url.trim().isEmpty) return Future<void>.value();
    return Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 260),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, __, ___) => FullScreenImageViewer(
          url: url,
          heroTag: heroTag,
          caption: caption,
        ),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  /// How far the image has been dragged from centre.
  Offset _drag = Offset.zero;

  /// True while the dismiss animation runs, so the image does not spring back
  /// under the fade.
  bool _closing = false;

  /// Set once the viewer is zoomed in. A pan at that point is the reader
  /// moving around the image, NOT dismissing it — without this, scrolling
  /// across a zoomed screenshot throws it away.
  bool _zoomed = false;

  final TransformationController _zoom = TransformationController();

  @override
  void initState() {
    super.initState();
    _zoom.addListener(_onZoomChanged);
  }

  @override
  void dispose() {
    _zoom.removeListener(_onZoomChanged);
    _zoom.dispose();
    super.dispose();
  }

  void _onZoomChanged() {
    // The matrix's x-scale. Anything above ~1 means the reader has zoomed.
    final scaled = _zoom.value.getMaxScaleOnAxis() > 1.01;
    if (scaled != _zoomed) setState(() => _zoomed = scaled);
  }

  /// Past this, letting go dismisses. Below it, the image springs back.
  ///
  /// A quarter of the screen height: far enough that a flick on a tall image
  /// does not throw the viewer away, close enough that the gesture does not
  /// feel like work.
  double get _dismissThreshold => MediaQuery.of(context).size.height * 0.25;

  /// The ground dims in proportion to the drag, so the page underneath comes
  /// back as the image leaves.
  double get _backdropOpacity {
    final max = MediaQuery.of(context).size.height * 0.6;
    return (1 - (_drag.distance / max)).clamp(0.0, 1.0);
  }

  void _onDragEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.distance;
    // Either a long drag or a quick flick dismisses. Velocity matters because
    // a short, fast flick is unambiguously "get rid of this".
    if (_drag.distance > _dismissThreshold || velocity > 900) {
      setState(() => _closing = true);
      Navigator.of(context).maybePop();
      return;
    }
    setState(() => _drag = Offset.zero);
  }

  @override
  Widget build(BuildContext context) {
    final tag = widget.heroTag ?? widget.url;
    final dragging = !_closing && !_zoomed;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        // A tap anywhere also closes — the whole surface is the way out.
        // Suppressed while zoomed, where a tap is how people re-centre.
        onTap: _zoomed ? null : () => Navigator.of(context).maybePop(),
        onPanUpdate:
            dragging ? (d) => setState(() => _drag += d.delta) : null,
        onPanEnd: dragging ? _onDragEnd : null,
        child: Stack(
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 90),
                  color:
                      Colors.black.withValues(alpha: 0.92 * _backdropOpacity),
                ),
              ),
            ),
            Center(
              child: AnimatedContainer(
                // Animated only on the way BACK. While the finger is down the
                // image must track it exactly; an animation there is lag.
                duration: _drag == Offset.zero
                    ? const Duration(milliseconds: 180)
                    : Duration.zero,
                curve: Curves.easeOutCubic,
                transform: Matrix4.translationValues(_drag.dx, _drag.dy, 0),
                child: Hero(
                  tag: tag,
                  child: InteractiveViewer(
                    transformationController: _zoom,
                    minScale: 1,
                    maxScale: 5,
                    child: Image.network(
                      widget.url,
                      fit: BoxFit.contain,
                      // A dead URL must not throw inside a Hero flight. These
                      // are user-uploaded objects behind an edge cache, so a
                      // miss is normal rather than exceptional.
                      errorBuilder: (_, __, ___) => Padding(
                        padding: EdgeInsets.all(32.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.image_not_supported_outlined,
                                color: Colors.white54, size: 40.w),
                            SizedBox(height: 12.h),
                            Text('This image could not be loaded',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 13.sp)),
                          ],
                        ),
                      ),
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : SizedBox(
                              height: 120.w,
                              width: 120.w,
                              child: const Center(
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2, color: Colors.white70)),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.caption != null && widget.caption!.trim().isNotEmpty)
              Positioned(
                left: 16.w,
                right: 16.w,
                bottom: MediaQuery.of(context).padding.bottom + 20.h,
                child: Opacity(
                  opacity: _backdropOpacity,
                  child: Text(
                    widget.caption!.trim(),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                ),
              ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8.h,
              right: 8.w,
              child: Opacity(
                opacity: _backdropOpacity,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).maybePop(),
                  tooltip: 'Close',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
