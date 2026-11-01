/// Non-throwing websocket operations.
///
/// THE BUG THIS EXISTS TO PREVENT, which reached production.
///
/// `WebSocketChannel.connect` is LAZY. It never throws at call time — it hands
/// back a channel immediately and the connection is attempted in the
/// background. So a DNS failure, a captive portal, or a radio that has not
/// reattached after sleep does not fail at `connect()`. It fails LATER, on the
/// first write to the sink, or on the stream.
///
/// Every websocket service in this app then did some version of:
///
///     _channel = WebSocketChannel.connect(uri);
///     _channel!.stream.listen(onData, onError: _handleError);
///     _state.add(connected);                 // announced before it is true
///     _startPingTimer();                     // writes every 30 seconds
///
/// and the ping was:
///
///     Timer.periodic(const Duration(seconds: 30), (_) {
///       if (_channel != null) {
///         _channel!.sink.add(jsonEncode({'type': 'ping'}));
///       }
///     });
///
/// `_channel != null` is not a liveness test. The OBJECT exists; the
/// CONNECTION is what failed. So `sink.add` threw `WebSocketChannelException`
/// from inside a `Timer` callback — which is in no try block, in no awaited
/// future, and in no zone the caller controls. It escaped to
/// `runZonedGuarded` with an EMPTY stack (timers lose it), and whatever the UI
/// was awaiting on that socket never completed.
///
/// 314 of those reached production on build 1.0.1+468, every one of them
/// Android, every one `Failed host lookup: 'api.lazervault.app'`. A phone
/// briefly losing DNS is routine and unavoidable at any scale; an app that
/// hangs because of it is not. The DNS is fine — dual-stack A + AAAA on
/// Cloudflare anycast — so there is nothing to buy or re-provision. This is
/// the fix.
///
/// Use [wsSend] and [wsClose] for every sink operation, and [wsConnect] when
/// the caller needs to know the socket genuinely opened.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// How long to wait for a handshake before giving up.
///
/// Generous on purpose. On a congested Nigerian 3G cell, DNS + TCP + TLS +
/// the websocket upgrade can legitimately take fifteen seconds or more, and a
/// short timeout on a slow-but-working network is indistinguishable to the
/// user from the app being broken — it just fails faster. The retry loop
/// above this decides what to do; the timeout only has to be longer than a
/// slow success and shorter than the user's patience.
const Duration kWsHandshakeTimeout = Duration(seconds: 25);

/// Send on a websocket without ever throwing.
///
/// Returns true if the frame was handed to the sink. False means the socket
/// was not usable — the caller should treat that as "disconnected" and
/// reconnect, NOT as an error to propagate.
///
/// Safe to call from a `Timer` callback, which is the entire point: that is
/// where the production crash came from.
bool wsSend(WebSocketChannel? channel, Object? data, {String? context}) {
  if (channel == null) return false;
  try {
    channel.sink.add(data);
    return true;
  } catch (e) {
    // Deliberately swallowed. A failed heartbeat is not an application error;
    // it is how you discover the socket is gone. Logged at debug so it is
    // visible while developing and silent (and free) in release, where
    // debugPrint is a no-op.
    debugPrint('[ws] send failed${context == null ? '' : ' ($context)'}: $e');
    return false;
  }
}

/// Close a websocket without ever throwing.
///
/// `sink.close()` throws on a channel whose connect failed, for the same
/// reason `add` does — and close is usually called from `dispose()`, where an
/// exception takes down the widget teardown with it.
/// [closeCode] and [closeReason] are forwarded to the sink when given, so a
/// caller that was sending a normal-closure code and a reason keeps doing so.
Future<void> wsClose(
  WebSocketChannel? channel, {
  int? closeCode,
  String? closeReason,
  String? context,
}) async {
  if (channel == null) return;
  try {
    if (closeCode != null) {
      await channel.sink.close(closeCode, closeReason);
    } else {
      await channel.sink.close();
    }
  } catch (e) {
    debugPrint('[ws] close failed${context == null ? '' : ' ($context)'}: $e');
  }
}

/// Wait for a channel the CALLER built to finish its handshake.
///
/// Use this, not [wsConnect], when the construction carries options this
/// wrapper does not model — `IOWebSocketChannel.connect` with an
/// `Authorization` header, `protocols`, `pingInterval`, `connectTimeout`. That
/// is every real site in this app: the mobile path needs the auth header, so
/// the channel has to be built where its headers are known. Readiness is the
/// only part that was missing.
///
/// Both constructors are LAZY, so without this the next line runs while
/// nothing is connected. That is what made `connected: true` a lie and what
/// made exponential backoff inert — a counter zeroed at dial time is zeroed
/// again before the failure it was counting ever arrives.
///
/// Never throws. Check [WsConnectResult.ok]; on false, take the site's own
/// failure path (schedule a reconnect, fall back to SSE, emit disconnected).
Future<WsConnectResult> wsAwaitReady(
  WebSocketChannel? channel, {
  Duration timeout = kWsHandshakeTimeout,
  String? context,
}) async {
  if (channel == null) {
    return const WsConnectResult._(null, 'no channel');
  }
  try {
    await channel.ready.timeout(timeout);
    return WsConnectResult._(channel, null);
  } catch (e) {
    debugPrint('[ws] not ready${context == null ? '' : ' ($context)'}: $e');
    return WsConnectResult._(null, e);
  }
}

/// The outcome of [wsConnect].
class WsConnectResult {
  const WsConnectResult._(this.channel, this.error);

  /// The live channel, or null when the handshake did not complete.
  final WebSocketChannel? channel;

  /// Why it failed, for logging. Null on success.
  final Object? error;

  bool get ok => channel != null;

  /// True when the failure looks like a transient network condition rather
  /// than something a retry cannot fix.
  ///
  /// DNS failures are the common case and are emphatically retryable: the
  /// phone that could not resolve a hostname two seconds ago usually can now.
  /// Treating them as fatal is what turned a blip into a dead screen.
  bool get isRetryable {
    if (error == null) return false;
    final s = error.toString().toLowerCase();
    return s.contains('failed host lookup') ||
        s.contains('no address associated') ||
        s.contains('network is unreachable') ||
        s.contains('connection refused') ||
        s.contains('connection reset') ||
        s.contains('software caused connection abort') ||
        s.contains('timed out') ||
        s.contains('timeout');
  }
}

/// Connect, and WAIT for the handshake, without ever throwing.
///
/// This is the difference that matters: by awaiting `ready` inside a try, a
/// connection failure is discovered HERE — where the caller can retry and show
/// a state — instead of surfacing later from a timer or an unlistened stream.
///
/// A caller that does not await readiness must still never announce
/// `connected`, because at that point nothing has connected.
Future<WsConnectResult> wsConnect(
  Uri uri, {
  Iterable<String>? protocols,
  Duration timeout = kWsHandshakeTimeout,
  String? context,
}) async {
  WebSocketChannel? channel;
  try {
    channel = WebSocketChannel.connect(uri, protocols: protocols);
    await channel.ready.timeout(timeout);
    return WsConnectResult._(channel, null);
  } catch (e) {
    // Close the half-built channel so its socket and its stream subscription
    // do not leak. This itself must not throw — the channel we are discarding
    // is the one that just failed.
    await wsClose(channel, context: context);
    debugPrint('[ws] connect failed${context == null ? '' : ' ($context)'}: $e');
    return WsConnectResult._(null, e);
  }
}
