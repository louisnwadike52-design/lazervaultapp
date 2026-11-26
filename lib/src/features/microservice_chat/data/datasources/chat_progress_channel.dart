import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lazervault/core/network/ws_safe.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// ONE PROGRESS LINE, FROM THE BACKEND, WHILE THE TURN IS STILL RUNNING.
///
/// ## What this replaces
///
/// Every chat surface showed "Nova is reading / thinking / typing" from a
/// LOCAL STOPWATCH — `novaStageFor(elapsed)`, three hard-coded time buckets.
/// The widget's own documentation admitted it: "the gateway returns one
/// response and does not report progress, so these are timed rather than
/// driven by the server." On a turn that takes eleven seconds (find the
/// recipient, read the balance, quote the fee, send the money) the customer
/// watched three invented phases and learned nothing about which step was slow
/// or whether anything was happening at all.
///
/// Now the backend says. Each chat-*-service agent publishes a line per tool
/// it starts, the gateway publishes the phases only it knows (reading your
/// message, checking with transfers, writing your answer), and this channel
/// carries them to the screen.
///
/// ## Why a separate socket from the chat itself
///
/// The chat is request/response over HTTP and works. Moving it onto a socket
/// to win progress lines would put the feature every customer uses behind a
/// transport change for a cosmetic gain. This is additive: the turn still goes
/// over HTTP, this socket runs alongside, and if it never connects the UI
/// falls back to the timed stages exactly as before. **Nothing in a money
/// path depends on it.**
///
/// ## Reconnection
///
/// Exponential backoff with a ceiling, and it gives up after a bounded number
/// of attempts rather than retrying for the life of the app. A progress line
/// is not worth a socket that reconnects forever in a user's pocket — and a
/// channel that has failed six times is telling you something the seventh
/// attempt will not change.
///
/// ## Every socket operation goes through ws_safe
///
/// `WebSocketChannel.connect` is LAZY: it returns before the handshake and
/// never throws at call time, so a DNS blip fails LATER, on the first write.
/// 314 production hangs on build 1.0.1+468 came from exactly that — a
/// `sink.add` inside a timer, in no try block and no zone the caller controls.
/// So this dials with [wsConnect] (which awaits `ready` inside a try) and
/// writes with [wsSend] / [wsClose], which cannot throw. The first version of
/// this file used the raw calls and `websocket_never_throws_test` failed it,
/// which is precisely what that test is for.
class ChatProgressChannel {
  ChatProgressChannel({
    required this.sessionId,
    required this.userId,
    required Future<String?> Function() accessToken,
    EndpointRegistry? registry,
  })  : _accessToken = accessToken,
        _registry = registry ?? endpointRegistry;

  final String sessionId;
  final String userId;
  final Future<String?> Function() _accessToken;
  final EndpointRegistry _registry;

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _sub;
  Timer? _retry;
  int _attempts = 0;
  bool _closed = false;

  /// After this many consecutive failures the channel stops trying. The UI
  /// has a working fallback, and a socket that will not open is not going to
  /// start working because it was asked a tenth time.
  static const _maxAttempts = 6;

  final _stages = StreamController<ChatProgressStage>.broadcast();

  /// The lines, in the order the backend produced them.
  Stream<ChatProgressStage> get stages => _stages.stream;

  /// True once a frame has arrived. The UI uses this to decide whether to
  /// trust this channel or keep showing its timed stages — a socket that is
  /// OPEN but silent is not yet evidence that the backend is reporting.
  bool get hasReported => _hasReported;
  bool _hasReported = false;

  Future<void> connect() async {
    if (_closed) return;
    _retry?.cancel();

    final token = await _accessToken();
    if (token == null || token.trim().isEmpty) {
      // No session, nothing to subscribe to. Not an error worth retrying:
      // the chat screen cannot be open without one for long.
      return;
    }

    final uri = _progressUri();
    if (uri == null) return;

    // AWAITS THE HANDSHAKE. wsConnect never throws; on failure it has already
    // closed the half-built channel, so there is nothing to clean up here.
    final result = await wsConnect(uri, context: 'chat-progress');
    if (!result.ok) {
      _scheduleRetry('handshake: ${result.error}', retryable: result.isRetryable);
      return;
    }
    if (_closed) {
      // Disposed while the handshake was in flight.
      await wsClose(result.channel, context: 'chat-progress');
      return;
    }

    final channel = result.channel!;
    _channel = channel;
    _sub = channel.stream.listen(
      _onFrame,
      onError: (Object e) => _scheduleRetry('error: $e'),
      onDone: () => _scheduleRetry('closed'),
      cancelOnError: true,
    );

    // The handshake. The server verifies the token, checks it names this
    // user, and refuses a session id that is not theirs.
    //
    // wsSend rather than sink.add: the socket can die between `ready`
    // completing and this line, and a throw here would escape into whatever
    // called connect().
    final sent = wsSend(
      channel,
      jsonEncode({
        'access_token': token,
        'user_id': userId,
        'session_id': sessionId,
      }),
      context: 'chat-progress handshake',
    );
    if (!sent) _scheduleRetry('handshake write failed');
  }

  void _onFrame(dynamic raw) {
    _attempts = 0; // a frame proves the channel works
    if (raw is! String) return;
    Map<String, dynamic> body;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return;
      body = decoded;
    } catch (_) {
      return;
    }

    switch (body['type']) {
      case 'stage':
        final label = (body['label'] ?? '').toString().trim();
        if (label.isEmpty) return;
        _hasReported = true;
        _stages.add(ChatProgressStage(
          label: label,
          tool: (body['tool'] ?? '').toString(),
          phase: (body['phase'] ?? '').toString(),
          service: (body['service'] ?? '').toString(),
        ));
      case 'ping':
      case 'ready':
        break;
      case 'error':
        // A refusal is terminal: a mismatched token or a session that is not
        // ours will be refused identically next time. Retrying would be a
        // loop against our own authorisation.
        debugPrint('ChatProgressChannel refused: ${body['error']}');
        _closed = true;
        _teardownSocket();
    }
  }

  void _scheduleRetry(String why, {bool retryable = true}) {
    _teardownSocket();
    if (_closed) return;
    // A NON-RETRYABLE failure is not retried. wsConnect classifies a DNS or
    // reset as transient and anything else as not — retrying the latter six
    // times would be six timeouts in a user's pocket for a cosmetic line.
    if (!retryable) {
      debugPrint('ChatProgressChannel not retrying ($why)');
      return;
    }
    _attempts += 1;
    if (_attempts > _maxAttempts) {
      debugPrint('ChatProgressChannel giving up after $_attempts attempts ($why)');
      return;
    }
    // 1s, 2s, 4s, 8s, 16s, capped at 20s.
    final seconds = (1 << (_attempts - 1)).clamp(1, 20);
    _retry = Timer(Duration(seconds: seconds), connect);
  }

  void _teardownSocket() {
    _sub?.cancel();
    _sub = null;
    // wsClose, not sink.close(): closing a channel whose connection already
    // failed throws, and this runs from dispose() and from a stream's onDone,
    // neither of which has a catch.
    final channel = _channel;
    _channel = null;
    if (channel != null) {
      unawaited(wsClose(channel, context: 'chat-progress'));
    }
  }

  /// `wss://host/ws/chat-progress`, derived from the registry's chat-agent
  /// base so a repointed environment moves the socket with it.
  ///
  /// The scheme is mapped rather than assumed: `ws://host:443` returns an HTTP
  /// error from Cloudflare's edge, which is the trap the balance socket
  /// documents.
  Uri? _progressUri() {
    final base = _registry.httpChatAgent.trim();
    if (base.isEmpty) return null;
    final parsed = Uri.tryParse(base);
    if (parsed == null || parsed.host.isEmpty) return null;
    final scheme = parsed.scheme == 'https' ? 'wss' : 'ws';
    return parsed.replace(scheme: scheme, path: '/ws/chat-progress', query: '');
  }

  /// Closes for good. Safe to call more than once.
  Future<void> dispose() async {
    _closed = true;
    _retry?.cancel();
    _teardownSocket();
    await _stages.close();
  }
}

/// One line of progress.
@immutable
class ChatProgressStage {
  const ChatProgressStage({
    required this.label,
    this.tool = '',
    this.phase = '',
    this.service = '',
  });

  /// What to show the customer — "Checking your balance", "Sending the money".
  final String label;

  /// The tool that produced it, a code identifier. Carried so the UI can pick
  /// an icon and so a support engineer reading a log can tell which step was
  /// slow; never shown to the customer.
  final String tool;

  /// A gateway phase ("understanding", "routing", "writing") when the line did
  /// not come from a tool.
  final String phase;

  /// Which service, for a routing phase.
  final String service;

  @override
  String toString() => 'ChatProgressStage($label, tool=$tool, phase=$phase)';
}
