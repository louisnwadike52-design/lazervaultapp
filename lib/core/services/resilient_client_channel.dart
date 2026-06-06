import 'dart:async';

import 'package:grpc/grpc.dart';

/// A self-healing gRPC channel.
///
/// grpc-dart's `ClientChannelBase` never resets its `_connected` flag once the
/// underlying HTTP/2 connection reaches [ConnectionState.shutdown] (keepalive
/// ceiling, transport teardown, or an explicit shutdown from a logout path).
/// Because every channel is a GetIt SINGLETON, one wedged connection meant
/// every later RPC failed with "Connection shutting down." until the app was
/// killed — retries could never succeed because they kept dispatching onto
/// the same dead object.
///
/// This wrapper delegates per-call to an inner [ClientChannel] and swaps in a
/// FRESH inner channel the moment the old one reports shutdown:
///   * reactively — a state-stream listener watches for shutdown
///   * proactively — `createCall` checks a wedged flag and swaps before
///     dispatching, so the first RPC after a wedge already gets a live pipe
///
/// All existing `serviceLocator<ClientChannel>()` registrations keep working:
/// generated clients only ever call [createCall]/[shutdown]/[terminate].
class ResilientClientChannel extends ClientChannel {
  final ClientChannel Function() _build;
  final String _name;

  ClientChannel _inner;
  StreamSubscription<ConnectionState>? _stateSub;
  bool _wedged = false;
  bool _closedByApp = false;
  DateTime? _lastSwap;

  /// Survives inner-channel swaps so app-level listeners never lose the
  /// stream.
  final StreamController<ConnectionState> _states =
      StreamController<ConnectionState>.broadcast();

  ResilientClientChannel(
    this._build, {
    required String host,
    required String name,
  })  : _inner = _build(),
        _name = name,
        // The base class never connects: createCall below always delegates
        // to the inner channel, so the super's own connection stays unused.
        super(host) {
    _watch();
  }

  void _watch() {
    _stateSub = _inner.onConnectionStateChanged.listen((s) {
      if (!_states.isClosed) _states.add(s);
      if (s == ConnectionState.shutdown && !_closedByApp) {
        // The inner channel can no longer carry calls — mark it wedged so the
        // next createCall swaps in a fresh one (also swap eagerly here).
        _wedged = true;
        _swap();
      }
    }, onError: (_) {});
  }

  void _swap() {
    if (_closedByApp) return;
    // Debounce: at most one swap per second so a flapping transport cannot
    // thrash channel creation.
    final now = DateTime.now();
    if (_lastSwap != null &&
        now.difference(_lastSwap!) < const Duration(seconds: 1)) {
      return;
    }
    _lastSwap = now;

    // ignore: avoid_print
    print('♻️ [$_name] gRPC channel wedged (shutdown) — creating a fresh one');
    _stateSub?.cancel();
    final dead = _inner;
    _inner = _build();
    _wedged = false;
    _watch();
    // Tear the old one down quietly in the background.
    unawaited(dead.terminate().catchError((_) {}));
  }

  @override
  ClientCall<Q, R> createCall<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options) {
    if (_wedged && !_closedByApp) _swap();
    return _inner.createCall(method, requests, options);
  }

  @override
  Future<void> shutdown() {
    _closedByApp = true;
    _stateSub?.cancel();
    if (!_states.isClosed) _states.close();
    return _inner.shutdown();
  }

  @override
  Future<void> terminate() {
    _closedByApp = true;
    _stateSub?.cancel();
    if (!_states.isClosed) _states.close();
    return _inner.terminate();
  }

  @override
  Stream<ConnectionState> get onConnectionStateChanged => _states.stream;
}
