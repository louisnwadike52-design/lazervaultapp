import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../view/escrow_theme.dart';

/// Full-screen viewer for a single escrow evidence item (image or short video).
///
/// Opened by tapping a preview thumbnail; the thumbnail and this view share a
/// [Hero] tag so the media expands smoothly from its tile and collapses back on
/// dismiss. The route is transparent and its animation drives a black backdrop
/// + chrome fade, so the media appears to grow out of the grid rather than a
/// new page sliding in.
///
/// Interactions (as specified): tap the media to MINIMISE it (reverse Hero back
/// to the tile), a close (X) button at the top does the same, images pinch-zoom,
/// videos autoplay/loop with a play-pause control. Every dismiss path is a plain
/// Navigator.pop so the Hero always runs.
Future<void> showEscrowMediaViewer(
  BuildContext context, {
  required String url,
  required bool isVideo,
  required String heroTag,
}) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.transparent, // the view fades its own backdrop
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 280),
      reverseTransitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (_, animation, __) => _EscrowMediaViewer(
        url: url,
        isVideo: isVideo,
        heroTag: heroTag,
        animation: animation,
      ),
    ),
  );
}

class _EscrowMediaViewer extends StatefulWidget {
  final String url;
  final bool isVideo;
  final String heroTag;
  final Animation<double> animation;

  const _EscrowMediaViewer({
    required this.url,
    required this.isVideo,
    required this.heroTag,
    required this.animation,
  });

  @override
  State<_EscrowMediaViewer> createState() => _EscrowMediaViewerState();
}

class _EscrowMediaViewerState extends State<_EscrowMediaViewer> {
  VideoPlayerController? _video;
  bool _videoReady = false;
  bool _videoFailed = false;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) _initVideo();
  }

  Future<void> _initVideo() async {
    final c = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _video = c;
    try {
      await c.initialize();
      if (!mounted) return;
      c
        ..setLooping(true)
        ..play();
      setState(() => _videoReady = true);
    } catch (_) {
      if (mounted) setState(() => _videoFailed = true);
    }
  }

  @override
  void dispose() {
    _video?.dispose();
    super.dispose();
  }

  void _minimise() {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  void _togglePlay() {
    final c = _video;
    if (c == null || !_videoReady) return;
    setState(() => c.value.isPlaying ? c.pause() : c.play());
  }

  @override
  Widget build(BuildContext context) {
    // The route animation fades the backdrop + chrome so the media (carried by
    // the Hero) reads as expanding out of the grid, not a page push.
    final fade = CurvedAnimation(parent: widget.animation, curve: Curves.easeOut);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Backdrop — tapping it (outside the media) also minimises.
          Positioned.fill(
            child: FadeTransition(
              opacity: fade,
              child: GestureDetector(
                onTap: _minimise,
                child: Container(color: Colors.black),
              ),
            ),
          ),
          // The media itself, centred, carried by the shared Hero. Tapping it
          // minimises; images pinch-zoom via InteractiveViewer.
          Center(
            child: Hero(
              tag: widget.heroTag,
              child: GestureDetector(
                onTap: widget.isVideo ? _togglePlay : _minimise,
                child: _buildMedia(),
              ),
            ),
          ),
          // Close (X), top-left, fades in with the chrome. Always dismisses.
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.h,
            left: 12.w,
            child: FadeTransition(
              opacity: fade,
              child: _CircleButton(icon: Icons.close, onTap: _minimise),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedia() {
    if (!widget.isVideo) {
      return InteractiveViewer(
        minScale: 1,
        maxScale: 4,
        child: Image.network(
          widget.url,
          fit: BoxFit.contain,
          errorBuilder: (c, e, s) => _mediaError('Could not load this image'),
        ),
      );
    }
    if (_videoFailed) return _mediaError('Could not play this video');
    if (!_videoReady || _video == null) {
      // Black placeholder while the controller initialises — matches the tile's
      // look so the Hero flight has nothing to jump.
      return Container(
        color: Colors.black,
        width: 220.w,
        height: 220.w,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
            color: EscrowTheme.primary, strokeWidth: 2),
      );
    }
    return AspectRatio(
      aspectRatio: _video!.value.aspectRatio == 0 ? 1 : _video!.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(_video!),
          // Play/pause overlay — shown while paused; a distinct hit target so a
          // tap on it controls playback and a tap elsewhere minimises.
          if (!_video!.value.isPlaying)
            _CircleButton(
                icon: Icons.play_arrow, large: true, onTap: _togglePlay),
        ],
      ),
    );
  }

  Widget _mediaError(String msg) => Container(
        color: EscrowTheme.card,
        padding: EdgeInsets.all(24.w),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.broken_image_outlined,
                color: EscrowTheme.textSecondary, size: 40.sp),
            SizedBox(height: 8.h),
            Text(msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: EscrowTheme.textSecondary, fontSize: 13.sp)),
          ],
        ),
      );
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool large;
  const _CircleButton(
      {required this.icon, required this.onTap, this.large = false});

  @override
  Widget build(BuildContext context) {
    final d = large ? 64.w : 38.w;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: d,
        height: d,
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: large ? 34.sp : 20.sp),
      ),
    );
  }
}
