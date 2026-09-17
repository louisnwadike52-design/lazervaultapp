import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'uplift_widgets.dart' show kUpDivider, kUpPrimary, kUpTextSecondary;

/// The funder's view of a founder's pitch video.
///
/// Inline rather than a launch-to-browser: the pitch is part of the decision,
/// and sending an investor out of the app mid-review is where reviews get
/// abandoned. Loads lazily — the controller is only created when the card is
/// built, so an application list does not spin up a decoder per row.
class UpliftVideoPlayer extends StatefulWidget {
  const UpliftVideoPlayer({required this.url, super.key});

  final String url;

  @override
  State<UpliftVideoPlayer> createState() => _UpliftVideoPlayerState();
}

class _UpliftVideoPlayerState extends State<UpliftVideoPlayer> {
  VideoPlayerController? _controller;
  bool _initialising = false;
  String? _error;

  @override
  void dispose() {
    // Disposed explicitly: a leaked controller holds a decoder and, on
    // Android, keeps audio focus after the screen is gone.
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _start() async {
    if (_initialising || _controller != null) return;
    setState(() {
      _initialising = true;
      _error = null;
    });
    try {
      final c = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      await c.initialize();
      if (!mounted) {
        await c.dispose();
        return;
      }
      setState(() {
        _controller = c;
        _initialising = false;
      });
      await c.play();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _initialising = false;
        // Deliberately not the raw exception: a codec error means nothing to
        // an investor, and the useful part is that the pitch is still there.
        _error = 'This video could not be played on your device.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _controller;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Founder pitch',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: c != null && c.value.isInitialized
                ? c.value.aspectRatio
                : 16 / 9,
            child: c != null && c.value.isInitialized
                ? Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      VideoPlayer(c),
                      VideoProgressIndicator(c, allowScrubbing: true),
                      // Tap anywhere to pause/resume — a separate control bar
                      // would crowd a card that already carries the decision.
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => setState(
                              () => c.value.isPlaying ? c.pause() : c.play()),
                          child: c.value.isPlaying
                              ? const SizedBox.shrink()
                              : const Center(
                                  child: Icon(Icons.play_circle_fill,
                                      color: Colors.white70, size: 52),
                                ),
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: _initialising ? null : _start,
                    child: Container(
                      color: kUpDivider,
                      child: Center(
                        child: _initialising
                            ? const CircularProgressIndicator(
                                strokeWidth: 2, color: kUpPrimary)
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.play_circle_outline,
                                      color: Colors.white70, size: 46),
                                  const SizedBox(height: 6),
                                  Text(_error ?? 'Play the founder\'s pitch',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: kUpTextSecondary,
                                          fontSize: 12)),
                                ],
                              ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
