import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:video_player/video_player.dart';

import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_live_state.dart';

/// Full-bleed background layer that renders the SprayMe live video — either the
/// WebRTC broadcaster track(s) or an HLS stream — with all the money/gift/comment
/// overlays stacked on top by the room screen.
class SprayLiveVideoLayer extends StatelessWidget {
  final SprayLiveState state;

  /// LiveKit identity ("user-<userId>") → display name, from the session roster,
  /// so guest boxes show the real username instead of the token fallback "Guest".
  final Map<String, String> nameByIdentity;

  const SprayLiveVideoLayer({
    super.key,
    required this.state,
    this.nameByIdentity = const {},
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
          child: Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
        );

      case SprayLivePhase.broadcasting:
      case SprayLivePhase.watchingWebRtc:
        base = _WebRtcView(tracks: state.tracks, nameByIdentity: nameByIdentity);

      case SprayLivePhase.idle:
      case SprayLivePhase.error:
        return const SizedBox.shrink();
    }

    // Paused overlay sits above the (frozen) video for both broadcaster and viewers.
    if (state.isPaused && state.isLiveActive) {
      return Positioned.fill(
        child: Stack(fit: StackFit.expand, children: [base, const _PausedOverlay()]),
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
              style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700),
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
  const _WebRtcView({required this.tracks, this.nameByIdentity = const {}});

  @override
  Widget build(BuildContext context) {
    if (tracks.isEmpty) {
      return const ColoredBox(
        color: Color(0xFF0A0A0A),
        child: Center(
          child: Text('Waiting for video…', style: TextStyle(color: Colors.white70)),
        ),
      );
    }

    // Primary = the HOST's track (full-screen), always — never let a guest take
    // over the main view, and never demote the host to a box on their own
    // screen. Fall back to the first remote, then local, if the host track
    // isn't available yet.
    final primary = tracks.firstWhere(
      (t) => t.isHost,
      orElse: () =>
          tracks.firstWhere((t) => !t.isLocal, orElse: () => tracks.first),
    );
    final guests =
        tracks.where((t) => t.participantId != primary.participantId).toList();

    return Stack(
      children: [
        Positioned.fill(
          child: VideoTrackRenderer(
            primary.track,
            fit: VideoViewFit.cover,
          ),
        ),
        // Guest boxes row — horizontally scrollable so up to 8 guests fit.
        if (guests.isNotEmpty)
          Positioned(
            left: 0,
            right: 0,
            bottom: 170.h,
            child: SizedBox(
              height: 116.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: guests.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (_, i) => _GuestBox(
                  track: guests[i],
                  displayName: nameByIdentity[guests[i].participantId],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// A single guest "box": the guest's live video + a name chip.
class _GuestBox extends StatelessWidget {
  final SprayLiveTrack track;
  final String? displayName; // from the roster; falls back to the track name
  const _GuestBox({required this.track, this.displayName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84.w,
      height: 116.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF7C3AED), width: 1.5),
        color: const Color(0xFF0A0A0A),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoTrackRenderer(track.track, fit: VideoViewFit.cover),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              color: Colors.black54,
              child: Text(
                track.isLocal
                    ? 'You'
                    : (displayName != null && displayName!.isNotEmpty
                        ? displayName!
                        : track.name),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
              ),
            ),
          ),
        ],
      ),
    );
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
                style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4.h),
              Text(
                'We couldn’t load the live video',
                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: _retry,
                child: const Text('Retry', style: TextStyle(color: Color(0xFF3B82F6))),
              ),
            ],
          ),
        ),
      );
    }
    if (c == null || !c.value.isInitialized) {
      return const ColoredBox(
        color: Color(0xFF0A0A0A),
        child: Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
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
