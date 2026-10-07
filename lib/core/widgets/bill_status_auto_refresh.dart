library;

import 'dart:async';

import 'package:flutter/widgets.dart';

/// Keeps a pending bill receipt's status up to date without the user pulling
/// to refresh.
///
/// WHY THIS EXISTS
/// ---------------
/// Every bill receipt already had a pull-to-refresh that re-read the status,
/// and every one of them only ran when the user dragged the screen. An airtime
/// top-up that completes two seconds after the receipt opens therefore sat on
/// "Processing" until the user thought to swipe — which looks like a stuck
/// payment for a purchase that already succeeded, and is the state people
/// screenshot and send to support.
///
/// WHY POLLING RATHER THAN A SOCKET
/// --------------------------------
/// A bill reaches its terminal state when the PROVIDER's webhook lands, which
/// can be hundreds of milliseconds or (on a queued purchase) minutes later.
/// There is no push channel from the bill services to the app, and adding one
/// for a screen that is open for under a minute would be a lot of machinery
/// for a question answered by one cheap read. A bounded, backing-off poll that
/// STOPS the moment the status is terminal costs a handful of requests and
/// works the same whether the webhook is fast, slow or replayed.
///
/// WHAT IT GUARANTEES
/// ------------------
///  * Nothing runs for a receipt that is already terminal.
///  * The interval backs off, so a slow provider does not get hammered.
///  * It gives up after [maxDuration] rather than polling forever behind a
///    screen someone left open — the reconciler owns it past that point.
///  * It pauses while the app is backgrounded and resumes on return, so an
///    app left open overnight is not making requests all night.
///
/// Usage: mix into a receipt's State, implement the two members, and call
/// [startBillStatusAutoRefresh] once the first status is known.
/// Constrained on WidgetsBindingObserver rather than `implements`-ing it, so
/// the no-op defaults come along and a consumer that forgets to mix it in
/// fails at the class that forgot rather than here.
mixin BillStatusAutoRefresh<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  Timer? _timer;
  int _tick = 0;
  DateTime? _startedAt;
  bool _inFlight = false;
  bool _observing = false;

  /// Re-read the status from the server. Must not throw.
  Future<void> refreshBillStatus();

  /// Whether the status is final — completed, failed, refunded, cancelled.
  /// Polling stops as soon as this is true.
  bool get isBillStatusTerminal;

  /// How long to keep trying before handing over to the reconciler.
  Duration get maxDuration => const Duration(minutes: 3);

  /// Back-off schedule. Front-loaded because most bills settle in seconds,
  /// then widened so a genuinely queued purchase costs very little.
  static const List<Duration> _backoff = [
    Duration(seconds: 3),
    Duration(seconds: 3),
    Duration(seconds: 5),
    Duration(seconds: 8),
    Duration(seconds: 13),
    Duration(seconds: 20),
  ];

  Duration get _nextInterval =>
      _backoff[_tick < _backoff.length ? _tick : _backoff.length - 1];

  /// Begin polling. Safe to call more than once — a second call is ignored
  /// while one is already running, and does nothing at all once terminal.
  void startBillStatusAutoRefresh() {
    if (_timer != null || isBillStatusTerminal || !mounted) return;
    _startedAt ??= DateTime.now();
    if (!_observing) {
      WidgetsBinding.instance.addObserver(this);
      _observing = true;
    }
    _schedule();
  }

  void stopBillStatusAutoRefresh() {
    _timer?.cancel();
    _timer = null;
  }

  void _schedule() {
    _timer?.cancel();
    _timer = Timer(_nextInterval, _run);
  }

  Future<void> _run() async {
    if (!mounted) return;
    final started = _startedAt;
    if (started != null && DateTime.now().difference(started) > maxDuration) {
      stopBillStatusAutoRefresh();
      return;
    }
    // Never stack requests: a slow refresh must not queue a second one behind
    // it and then a third.
    if (_inFlight) {
      _schedule();
      return;
    }
    _inFlight = true;
    try {
      await refreshBillStatus();
    } catch (_) {
      // Opportunistic by design. A failed poll is indistinguishable from "not
      // settled yet" to the user, and surfacing it would turn a transient
      // network blip into an alarming receipt.
    } finally {
      _inFlight = false;
    }
    if (!mounted) return;
    if (isBillStatusTerminal) {
      stopBillStatusAutoRefresh();
      return;
    }
    _tick++;
    _schedule();
  }

  /// Pause in the background, resume (with an immediate check) on return.
  ///
  /// Coming back to the app is exactly when the answer has most likely
  /// changed, so the first poll after a resume is not delayed.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;
    if (state == AppLifecycleState.resumed) {
      if (!isBillStatusTerminal) {
        _tick = 0;
        _timer?.cancel();
        _timer = Timer(Duration.zero, _run);
      }
    } else {
      stopBillStatusAutoRefresh();
    }
  }

  /// Call from the State's own dispose().
  void disposeBillStatusAutoRefresh() {
    stopBillStatusAutoRefresh();
    if (_observing) {
      WidgetsBinding.instance.removeObserver(this);
      _observing = false;
    }
  }
}
