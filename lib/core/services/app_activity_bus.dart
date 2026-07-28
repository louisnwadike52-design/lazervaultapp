import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// App-wide "the user is engaged" signal for the inactivity auto-logout.
///
/// The [InactivityWatcher] already resets its logout timer on raw pointer /
/// scroll events (via a root `Listener`). But a lot of genuine engagement never
/// produces a pointer event the Flutter tree can see:
///   * typing on the soft keyboard (an OS overlay — key taps don't hit the
///     Flutter `Listener`),
///   * an incoming or outgoing P2P chat message,
///   * a streaming AI-chatbot response the user is reading,
///   * voice-agent activity (per-service or general) while hands-free.
///
/// Any such surface calls [ping] to signal engagement; the watcher listens and
/// re-arms its timer, so the user is never logged out mid-interaction. This is
/// deliberately tiny and dependency-free so it can be pinged from anywhere
/// (cubits, services, widgets) without a BuildContext.
class AppActivityBus {
  AppActivityBus._();
  static final AppActivityBus instance = AppActivityBus._();

  /// Monotonic counter bumped on every engagement signal. Listeners (the
  /// inactivity watcher) only care that it CHANGED, not its value.
  final ValueNotifier<int> tick = ValueNotifier<int>(0);

  /// Signal that the user is actively engaged right now. Cheap + safe to call
  /// very frequently (e.g. per keystroke or per streamed token).
  void ping() {
    // Wrap so a listener error can never propagate into a hot path.
    try {
      tick.value = tick.value + 1;
    } catch (_) {}
  }
}

/// Mix into a screen's [State] to treat simply BEING on that screen as ongoing
/// engagement — the inactivity auto-logout is kept at bay for as long as the
/// screen is mounted, then normal timing resumes on dispose. Use for immersive,
/// low-touch surfaces where the user is clearly engaged without tapping:
/// voice/chatbot conversations, P2P chats, live spray rooms, media playback.
///
/// It pings [AppActivityBus] immediately and every 25s (well under the ~60–90s
/// logout window). Requires the host State to chain `super.initState()` /
/// `super.dispose()` (the Flutter norm).
mixin EngagementKeepAlive<T extends StatefulWidget> on State<T> {
  Timer? _engagementKeepAliveTimer;

  @override
  void initState() {
    super.initState();
    AppActivityBus.instance.ping();
    // 15s stays comfortably under any sane inactivity timeout (platform default
    // 90s, dev 60s) so the timer is always re-armed before it can fire, even if
    // an admin sets a shorter window. Cost is a trivial counter bump.
    _engagementKeepAliveTimer = Timer.periodic(
        const Duration(seconds: 15), (_) => AppActivityBus.instance.ping());
  }

  @override
  void dispose() {
    _engagementKeepAliveTimer?.cancel();
    super.dispose();
  }
}
