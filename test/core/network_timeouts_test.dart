import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/network/network_timeouts.dart';

/// "Increase the timeouts on Flutter-to-backend connections, given that
/// Nigeria and Africa have poorer data connections and poorer device
/// infrastructure."
///
/// A short timeout on a slow-but-working network protects nobody: it turns a
/// slow success into a failure, and the user — who cannot tell those apart —
/// sees an app that does not work on their phone. The retry then pays the
/// same DNS and TLS cost again on a link that was already saturated, so
/// aggressive timeouts make a congested cell worse rather than safer.
void main() {
  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
    return f.readAsStringSync();
  }

  test('every tier is generous enough for a congested 3G cell', () {
    // DNS + TCP + TLS + a round trip regularly exceeds 15s there, so any
    // tier at or under that is a failure generator.
    expect(NetworkTimeouts.interactive.inSeconds, greaterThanOrEqualTo(30));
    expect(NetworkTimeouts.connect.inSeconds, greaterThanOrEqualTo(20));
    expect(NetworkTimeouts.background.inSeconds, greaterThanOrEqualTo(45));
    expect(NetworkTimeouts.upload.inSeconds, greaterThanOrEqualTo(60));
    // The probe tier is allowed to be short — the screen renders without it —
    // but not shorter than a slow handshake.
    expect(NetworkTimeouts.probe.inSeconds, greaterThanOrEqualTo(10));
  });

  test('the tiers stay ordered', () {
    expect(NetworkTimeouts.probe, lessThan(NetworkTimeouts.interactive));
    expect(NetworkTimeouts.interactive, lessThanOrEqualTo(NetworkTimeouts.background));
    expect(NetworkTimeouts.background, lessThanOrEqualTo(NetworkTimeouts.upload));
  });

  test('a user waiting is not cut off sooner than a background refresh', () {
    // The inversion is easy to introduce and reads as reasonable: "the user
    // is waiting, fail fast". It is backwards — the background job can be
    // retried for free, the user's tap cannot.
    expect(NetworkTimeouts.interactive.inSeconds,
        greaterThanOrEqualTo(NetworkTimeouts.probe.inSeconds * 2));
  });

  test('the gRPC deadline caps every backend call and uses a tier', () {
    // This is the single biggest lever: it applies to EVERY authenticated
    // call, so a short value here is a platform-wide failure rate.
    final src = read('lib/core/grpc/grpc_channel_manager.dart');
    expect(src.contains('NetworkTimeouts.interactive'), isTrue,
        reason: 'the gRPC deadline is back to a hardcoded Duration');
    expect(src.contains('timeout: const Duration(seconds: 30)'), isFalse,
        reason: 'the 30s deadline is back — it sounds generous on wifi and '
            'is not on a congested cell');
  });

  test('the HTTP transport budgets each phase separately', () {
    final src = read('lib/core/error/payment_service.dart');
    expect(src.contains('connectTimeout: NetworkTimeouts.connect'), isTrue);
    expect(src.contains('sendTimeout: NetworkTimeouts.upload'), isTrue,
        reason: 'a 10s send budget fails any upload bigger than a thumbnail');
    expect(src.contains('connectTimeout: Duration(seconds: 10)'), isFalse);
  });

  test('no core service still waits under ten seconds on the network', () {
    // Not a blanket sweep. Two kinds of short Duration are legitimate and
    // are excluded:
    //
    //   * UI debounces and animation delays, which are not network calls;
    //   * a call carrying `onTimeout:`, which is an explicit non-fatal
    //     fallback. The App Check attestation is the example — it runs as a
    //     preamble to EVERY RPC, so waiting longer there would add its delay
    //     to every request on a slow network, which is the opposite of what
    //     this change is for. Deliberately not blocking is not the same
    //     defect as cutting a user's request short.
    //
    // What is left is the case that was failing real users: a bare backend
    // call given five to eight seconds to complete.
    final offenders = <String>[];
    final dir = Directory('lib/core/services');
    for (final f in dir.listSync(recursive: true).whereType<File>()) {
      if (!f.path.endsWith('.dart')) continue;
      for (final m in RegExp(
              r'\.timeout\(const Duration\(seconds: (\d+)\)([^)]*)\)')
          .allMatches(f.readAsStringSync())) {
        final secs = int.parse(m.group(1)!);
        final tail = m.group(2) ?? '';
        if (secs < 10 && !tail.contains('onTimeout')) {
          offenders.add('${f.path}: ${secs}s');
        }
      }
    }
    expect(offenders, isEmpty,
        reason: 'these cut off a backend call before a slow-but-working '
            'network can answer:\n  ${offenders.join('\n  ')}');
  });
}
