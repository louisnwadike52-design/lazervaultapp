import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// 314 production hangs on build 1.0.1+468 — every one Android, every one
/// `Failed host lookup: 'api.lazervault.app'` — came from two lines of shape
/// repeated across eighteen websocket call sites:
///
///     _channel = WebSocketChannel.connect(uri);   // LAZY. Not connected yet.
///     _state.add(connected);                      // announced anyway
///     Timer.periodic(30s, (_) {
///       if (_channel != null) _channel!.sink.add(ping);   // throws
///     });
///
/// `_channel != null` is not a liveness test: the OBJECT exists, the
/// CONNECTION is what failed. So `sink.add` threw from inside a `Timer`
/// callback — no try block, no awaited future, no zone the caller controls —
/// and whatever the UI was awaiting on that socket never completed.
///
/// A phone briefly losing DNS is routine and unavoidable at any scale. The DNS
/// itself is fine (dual-stack A + AAAA on Cloudflare anycast), so there is
/// nothing to buy or re-provision; the app simply must not hang because of it.
///
/// These are source assertions because the defect is "which call is written",
/// a property of the source. Reproducing it at runtime needs a real DNS
/// failure mid-handshake on eighteen services.
void main() {
  final dartFiles = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  /// Strips `//` comments, so the explanations above each fix — which quote
  /// the old calls by name — cannot fail the test that enforces them.
  String code(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  test('no websocket sink is written to directly', () {
    final offenders = <String>[];
    for (final f in dartFiles) {
      if (f.path.endsWith('core/network/ws_safe.dart')) continue; // the wrapper
      final src = code(f.readAsStringSync());
      for (final call in ['sink.add(', 'sink.close(']) {
        if (src.contains(call)) offenders.add('${f.path}: $call');
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'These write to a websocket sink directly, which throws when the '
          'connection failed — and these calls live in Timer callbacks and '
          'dispose(), where nothing catches. Use wsSend/wsClose from '
          'core/network/ws_safe.dart.\n  ${offenders.join('\n  ')}',
    );
  });

  test('every websocket dial waits for its handshake', () {
    // WebSocketChannel.connect and IOWebSocketChannel.connect BOTH return
    // before the socket is established. A file that dials without ever
    // awaiting readiness is announcing a connection it does not have.
    final offenders = <String>[];
    for (final f in dartFiles) {
      if (f.path.endsWith('core/network/ws_safe.dart')) continue;
      final src = code(f.readAsStringSync());
      final dials = RegExp(r'\bIOWebSocketChannel\.connect\(|\bWebSocketChannel\.connect\(')
          .allMatches(src)
          .length;
      if (dials == 0) continue;
      if (!src.contains('wsAwaitReady(') && !src.contains('wsConnect(')) {
        offenders.add('${f.path} ($dials dial${dials == 1 ? '' : 's'})');
      }
    }
    expect(
      offenders,
      isEmpty,
      reason: 'These dial a websocket and never await readiness, so the next '
          'line runs while nothing is connected: `connected` becomes a lie and '
          'any backoff counter reset at dial time is inert. Gate the dial with '
          'wsAwaitReady (keep your own constructor and its headers) or use '
          'wsConnect.\n  ${offenders.join('\n  ')}',
    );
  });

  test('a failed ping triggers recovery instead of being discarded', () {
    // THE REGRESSION THIS GUARDS. Making wsSend non-throwing fixed the hang,
    // and silently created a quieter bug: every ping timer called it and
    // threw the answer away.
    //
    // A ping exists precisely to detect a socket the STREAM cannot report
    // on — a half-open connection delivers no onDone and no onError, so the
    // write is the only probe there is. Discarding its result left the
    // service believing it was connected forever: no hang, and no data.
    final offenders = <String>[];
    for (final f in dartFiles) {
      // The wrapper quotes the old call in its own doc comment, which is
      // the explanation of this bug rather than an instance of it.
      if (f.path.endsWith('core/network/ws_safe.dart')) continue;
      final src = code(f.readAsStringSync());
      if (!src.contains("jsonEncode({'type': 'ping'})")) continue;
      if (!src.contains("if (!wsSend(")) offenders.add(f.path);
    }
    expect(offenders, isEmpty,
        reason: 'these ping and ignore the result, so a dead socket is never '
            'noticed:\n  ${offenders.join('\n  ')}');
  });

  test('the wrapper itself still cannot throw', () {
    final src = File('lib/core/network/ws_safe.dart').readAsStringSync();
    // Every public entry point must have a catch. A wrapper that throws is
    // worse than no wrapper, because every call site has stopped guarding.
    for (final fn in ['bool wsSend(', 'Future<void> wsClose(',
                      'Future<WsConnectResult> wsAwaitReady(',
                      'Future<WsConnectResult> wsConnect(']) {
      expect(src.contains(fn), isTrue, reason: '$fn is gone from ws_safe.dart');
    }
    expect('} catch ('.allMatches(src).length, greaterThanOrEqualTo(4),
        reason: 'one of the four entry points lost its catch');
    // The handshake timeout has to stay generous: on a congested Nigerian 3G
    // cell, DNS + TCP + TLS + upgrade legitimately takes >15s, and a short
    // timeout on a slow-but-working network just fails faster.
    final m = RegExp(r'kWsHandshakeTimeout = Duration\(seconds: (\d+)\)')
        .firstMatch(src);
    expect(m, isNotNull, reason: 'the handshake timeout constant is gone');
    expect(int.parse(m!.group(1)!), greaterThanOrEqualTo(20),
        reason: 'a handshake timeout under 20s fails real users on poor '
            'networks, which is who this app is for');
  });
}
