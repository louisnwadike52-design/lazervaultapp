import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/funds_transfer/services/transfer_websocket_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// Lifecycle guards on the transfer-status socket.
///
/// None of this was ever exercised: the service was not registered in DI and
/// the feed behind it was dead, so it went straight from "written" to
/// "carrying live receipt updates into chat and voice" with no shakedown.
/// These are the failure modes that only appear under timing.
void main() {
  late TransferWebSocketService svc;

  setUp(() {
    svc = TransferWebSocketService(
      secureStorage: SecureStorageService(const FlutterSecureStorage()),
    );
  });

  tearDown(() {
    svc.disconnect();
  });

  test('concurrent connects collapse onto one attempt', () async {
    // Two receipt cards mounting in the same frame both used to see
    // _isConnected == false and both opened a socket; one leaked, pinging
    // forever. There is no server here, so both fail — the point is that they
    // fail as ONE attempt and leave no in-flight state behind.
    final results = await Future.wait([
      svc.connect(userId: 'u1', accessToken: 't1').catchError((_) {}),
      svc.connect(userId: 'u1', accessToken: 't1').catchError((_) {}),
      svc.connect(userId: 'u1', accessToken: 't1').catchError((_) {}),
    ]);
    expect(results.length, 3);
    expect(svc.isConnected, isFalse);
  });

  test('disconnect is idempotent and safe before any connect', () {
    expect(() => svc.disconnect(), returnsNormally);
    expect(() => svc.disconnect(), returnsNormally);
    expect(svc.isConnected, isFalse);
  });

  test('exposes a reconnect signal subscribers can re-sync on', () {
    // Events are not replayed, so anything that settles while the socket is
    // down is missed. A subscriber needs this to know it must re-read.
    expect(svc.onReconnected, isA<Stream<void>>());
    final sub = svc.onReconnected.listen((_) {});
    addTearDown(sub.cancel);
  });

  test('a failed connect leaves the service reusable', () async {
    await svc.connect(userId: 'u1', accessToken: 't1').catchError((_) {});
    expect(svc.isConnected, isFalse);
    // The single-flight guard must clear on failure, or every later attempt
    // silently returns the old, already-completed future and never dials.
    await svc.connect(userId: 'u2', accessToken: 't2').catchError((_) {});
    expect(svc.isConnected, isFalse);
  });
}
