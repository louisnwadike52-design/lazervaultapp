import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

/// Full-screen playback for a recorded SprayMe session. The recording URL is
/// captured server-side (LiveKit recording egress → egress webhook → SetRecording)
/// and stored on the session as `recording_url`; this screen finally lets users
/// watch that replay. Handles MP4 (recording egress) and HLS URLs alike.
class SprayReplayPlayer extends StatefulWidget {
  final String url;
  final String title;

  const SprayReplayPlayer({super.key, required this.url, required this.title});

  static Future<void> open(BuildContext context, {required String url, required String title}) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SprayReplayPlayer(url: url, title: title)),
    );
  }

  @override
  State<SprayReplayPlayer> createState() => _SprayReplayPlayerState();
}

class _SprayReplayPlayerState extends State<SprayReplayPlayer> {
  VideoPlayerController? _controller;
  bool _failed = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    if (widget.url.isEmpty) {
      if (mounted) setState(() => _failed = true);
      return;
    }
    final c = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _controller = c;
    try {
      await c.initialize();
      await c.play();
      c.addListener(_onTick);
      if (mounted) setState(() => _failed = false);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  void _onTick() {
    if (mounted) setState(() {});
  }

  void _retry() {
    _controller?.removeListener(_onTick);
    _controller?.dispose();
    _controller = null;
    setState(() => _failed = false);
    _init();
  }

  void _togglePlay() {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    setState(() => c.value.isPlaying ? c.pause() : c.play());
  }

  @override
  void dispose() {
    _controller?.removeListener(_onTick);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: _buildVideo()),
          // Tap surface to toggle controls.
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _showControls = !_showControls),
          ),
          if (_showControls) _buildControls(),
        ],
      ),
    );
  }

  Widget _buildVideo() {
    final c = _controller;
    if (_failed) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 44.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(height: 12.h),
          Text('Replay unavailable',
              style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text("We couldn't load this recording",
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
          SizedBox(height: 12.h),
          TextButton(onPressed: _retry, child: const Text('Retry', style: TextStyle(color: Color(0xFF3B82F6)))),
        ],
      );
    }
    if (c == null || !c.value.isInitialized) {
      return const CircularProgressIndicator(color: Color(0xFF3B82F6));
    }
    return AspectRatio(aspectRatio: c.value.aspectRatio, child: VideoPlayer(c));
  }

  Widget _buildControls() {
    final c = _controller;
    return SafeArea(
      child: Column(
        children: [
          // Top bar: close + title.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
                Expanded(
                  child: Text(widget.title,
                      style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
          const Spacer(),
          if (c != null && c.value.isInitialized) ...[
            IconButton(
              iconSize: 56.sp,
              icon: Icon(c.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  color: Colors.white),
              onPressed: _togglePlay,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: VideoProgressIndicator(
                c,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: Color(0xFF3B82F6),
                  bufferedColor: Colors.white24,
                  backgroundColor: Colors.white10,
                ),
              ),
            ),
          ] else
            const Spacer(),
        ],
      ),
    );
  }
}
