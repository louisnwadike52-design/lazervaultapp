import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:video_player/video_player.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_layout_mode.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_live_state.dart';

part 'spray_live_video_layouts.dart';

/// Full-bleed background layer that renders the SprayMe live video — either the
/// WebRTC broadcaster track(s) or an HLS stream — with all the money/gift/comment
/// overlays stacked on top by the room screen.
class SprayLiveVideoLayer extends StatelessWidget {
  final SprayLiveState state;

  /// LiveKit identity ("user-<userId>") → display name, from the session roster,
  /// so guest boxes show the real username instead of the token fallback "Guest".
  final Map<String, String> nameByIdentity;

  /// How participants are arranged. Defaults to the product default so any
  /// caller that has not been updated still renders a valid layout.
  final SprayLayoutMode layout;

  const SprayLiveVideoLayer({
    super.key,
    required this.state,
    this.nameByIdentity = const {},
    this.layout = kSprayDefaultLayoutMode,
  });

  @override
  Widget build(BuildContext context) {
    late final Widget base;
    switch (state.phase) {
      case SprayLivePhase.watchingHls:
        base = _HlsView(url: state.hlsUrl);

      case SprayLivePhase.connecting:
        base = const ColoredBox(
          color: Color(0xFF0A0A0A),
          child: Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
        );

      case SprayLivePhase.broadcasting:
      case SprayLivePhase.watchingWebRtc:
        base = _WebRtcView(
          tracks: state.tracks,
          nameByIdentity: nameByIdentity,
          isAudioOnly: state.isAudioOnly,
          layout: layout,
        );

      case SprayLivePhase.idle:
      case SprayLivePhase.error:
        return const SizedBox.shrink();
    }

    // Paused overlay sits above the (frozen) video for both broadcaster and viewers.
    if (state.isPaused && state.isLiveActive) {
      return Positioned.fill(
        child: Stack(
            fit: StackFit.expand, children: [base, const _PausedOverlay()]),
      );
    }
    return Positioned.fill(child: base);
  }
}

/// Semi-transparent overlay shown while the host has paused the broadcast.
class _PausedOverlay extends StatelessWidget {
  const _PausedOverlay();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xCC0A0A0A),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.pause_circle_filled, size: 56.sp, color: Colors.white),
            SizedBox(height: 12.h),
            Text(
              'Live paused',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4.h),
            Text(
              'The host will be right back',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders the primary broadcaster (host) full-screen and every additional
/// publisher (seated guests / co-hosts) as a TikTok-style row of "boxes".
/// Every remote publisher IS a stage guest — only host + seated guests receive
/// LiveKit publish tokens — so we simply grid all non-primary tracks.
class _WebRtcView extends StatelessWidget {
  final List<SprayLiveTrack> tracks;
  final Map<String, String> nameByIdentity;

  /// The host is live on audio with the camera off — a valid broadcast, not a
  /// missing one. Without this the audio-only case is indistinguishable from a
  /// stream that has not arrived, and viewers were told "Waiting for video…"
  /// for the whole broadcast.
  final bool isAudioOnly;
  final SprayLayoutMode layout;
  const _WebRtcView({
    required this.tracks,
    this.nameByIdentity = const {},
    this.isAudioOnly = false,
    this.layout = kSprayDefaultLayoutMode,
  });

  @override
  Widget build(BuildContext context) {
    if (tracks.isEmpty) {
      if (isAudioOnly) {
        // Audio mode: say what IS happening. Spraying, gifting and comments all
        // work here, so this must not read as a broken stream.
        return const ColoredBox(
          color: Color(0xFF0A0A0A),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.graphic_eq_rounded, color: Colors.white70, size: 40),
                SizedBox(height: 12),
                Text('Audio only',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 6),
                Text("The host's camera is off",
                    style: TextStyle(color: Colors.white60, fontSize: 13)),
              ],
            ),
          ),
        );
      }
      return const ColoredBox(
        color: Color(0xFF0A0A0A),
        child: Center(
          child: Text('Waiting for video…',
              style: TextStyle(color: Colors.white70)),
        ),
      );
    }

    // Primary = the HOST's track, always — never let a guest take over the main
    // view, and never demote the host to a box on their own screen. Fall back
    // to the first remote, then local, if the host track isn't available yet.
    // Grid has no "primary" and ignores this.
    final primary = tracks.firstWhere(
      (t) => t.isHost,
      orElse: () =>
          tracks.firstWhere((t) => !t.isLocal, orElse: () => tracks.first),
    );
    final others =
        tracks.where((t) => t.participantId != primary.participantId).toList();

    return switch (layout) {
      SprayLayoutMode.grid =>
        _GridLayout(tracks: tracks, nameByIdentity: nameByIdentity),
      SprayLayoutMode.sidebar => _SidebarLayout(
          primary: primary,
          others: others,
          nameByIdentity: nameByIdentity,
        ),
      SprayLayoutMode.spotlight => _SpotlightLayout(
          primary: primary,
          others: others,
          nameByIdentity: nameByIdentity,
        ),
    };
  }
}

/// HLS playback for large rooms. Owns a [VideoPlayerController] tied to the url.
class _HlsView extends StatefulWidget {
  final String url;
  const _HlsView({required this.url});

  @override
  State<_HlsView> createState() => _HlsViewState();
}

class _HlsViewState extends State<_HlsView> {
  VideoPlayerController? _controller;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant _HlsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _controller?.dispose();
      _controller = null;
      _failed = false;
      _init();
    }
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
      await c.setLooping(false);
      await c.play();
      if (mounted) setState(() => _failed = false);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  void _retry() {
    _controller?.dispose();
    _controller = null;
    setState(() => _failed = false);
    _init();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _controller;
    if (_failed) {
      return ColoredBox(
        color: const Color(0xFF0A0A0A),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off, size: 40.sp, color: const Color(0xFF9CA3AF)),
              SizedBox(height: 12.h),
              Text(
                'Stream unavailable',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4.h),
              Text(
                'We couldn’t load the live video',
                style:
                    TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: _retry,
                child: const Text('Retry',
                    style: TextStyle(color: Color(0xFF3B82F6))),
              ),
            ],
          ),
        ),
      );
    }
    if (c == null || !c.value.isInitialized) {
      return const ColoredBox(
        color: Color(0xFF0A0A0A),
        child:
            Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
      );
    }
    return ColoredBox(
      color: Colors.black,
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: c.value.size.width,
          height: c.value.size.height,
          child: VideoPlayer(c),
        ),
      ),
    );
  }
}
