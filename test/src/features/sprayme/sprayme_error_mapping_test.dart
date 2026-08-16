import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervault/src/features/sprayme/data/datasources/sprayme_remote_datasource.dart';

// Verifies the SprayMe datasource error mapping — specifically the fixes for the
// operator-gate (503) and multi-meaning 409 responses the backend now returns
// (live_video_disabled, session is full, session is not live, recording gates).

class _MockDio extends Mock implements Dio {}

DioException _err(int status, {dynamic data}) {
  final ro = RequestOptions(path: '/x');
  return DioException(
    requestOptions: ro,
    type: DioExceptionType.badResponse,
    response: Response(requestOptions: ro, statusCode: status, data: data),
  );
}

void main() {
  late _MockDio dio;
  late SprayMeRemoteDataSource ds;

  setUp(() {
    dio = _MockDio();
    ds = SprayMeRemoteDataSource(dio);
  });

  // Drives an error through pauseStream (POST with no body).
  Future<String> viaPause(DioException e) async {
    when(() => dio.post(any())).thenThrow(e);
    try {
      await ds.pauseStream('s1');
      return 'NO EXCEPTION';
    } catch (ex) {
      return ex.toString();
    }
  }

  // Drives an error through joinSession (POST with a body).
  Future<String> viaJoin(DioException e) async {
    when(() => dio.post(any(), data: any(named: 'data'))).thenThrow(e);
    try {
      await ds.joinSession('ABC123');
      return 'NO EXCEPTION';
    } catch (ex) {
      return ex.toString();
    }
  }

  test('503 live_video_disabled maps to a friendly message (NOT "server error")', () async {
    final m = await viaPause(_err(503, data: {'error': 'live_video_disabled'}));
    expect(m, contains("Live video isn't available"));
    expect(m.toLowerCase(), isNot(contains('server error')));
  });

  test('409 "session is not live" maps to a precondition message (NOT "already joined")', () async {
    final m = await viaPause(_err(409, data: {'error': 'session is not live'}));
    expect(m, contains("stream isn't live"));
    expect(m.toLowerCase(), isNot(contains('already joined')));
  });

  test('403 recording_not_entitled maps to a plan message', () async {
    final m = await viaPause(_err(403, data: {'error': 'recording_not_entitled'}));
    expect(m, contains("isn't available on your plan"));
  });

  test('cohost_disabled / recording_disabled map to friendly gate messages', () async {
    expect(await viaPause(_err(503, data: {'error': 'cohost_disabled'})), contains('Co-hosting is turned off'));
    expect(await viaPause(_err(503, data: {'error': 'recording_disabled'})), contains('Recording is turned off'));
  });

  test('401 maps to session-expired', () async {
    expect(await viaPause(_err(401)), contains('Session expired'));
  });

  test('409 "session is full" on join maps to full message (NOT "already joined")', () async {
    final m = await viaJoin(_err(409, data: {'error': 'session is full'}));
    expect(m, contains('This session is full'));
    expect(m.toLowerCase(), isNot(contains('already joined')));
  });

  test('409 without a code on join falls back to already-joined', () async {
    final m = await viaJoin(_err(409));
    expect(m.toLowerCase(), contains('already joined'));
  });
}
