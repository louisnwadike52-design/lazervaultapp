import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_session.dart';
import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';
import 'package:lazervault/src/features/sprayme/services/sprayme_websocket_service.dart';
import 'package:lazervault/src/features/sprayme/presentation/cubit/spray_live_cubit.dart';

// Verifies SprayLiveCubit logic that does NOT require a live LiveKit Room:
// co-host invite handling and the host-only guards on the media controls.
// (The broadcasting/watching state transitions need a real LiveKit Room and are
// covered end-to-end by the backend integration + live authenticated round-trip.)

class _MockRepo extends Mock implements ISprayMeRepository {}

class _MockWs extends Mock implements SprayMeWebSocketService {}

SpraySession _session({String host = 'HOST'}) => SpraySession(
      id: 's1',
      hostUserId: host,
      hostName: 'Host',
      title: 'T',
      occasionType: 'party',
      sessionCode: 'ABC123',
      status: 'active',
      createdAt: DateTime(2026, 1, 1),
    );

void main() {
  late _MockRepo repo;
  late _MockWs ws;
  late StreamController<SprayRoomEvent> events;

  setUp(() {
    repo = _MockRepo();
    ws = _MockWs();
    events = StreamController<SprayRoomEvent>.broadcast();
    when(() => ws.events).thenAnswer((_) => events.stream);
  });

  tearDown(() => events.close());

  SprayLiveCubit build() => SprayLiveCubit(repository: repo, wsService: ws);

  test('cohost_invited addressed to me sets the pending banner; decline clears it', () async {
    final c = build();
    c.bind(_session(), 'ME'); // ME is a viewer, not the host
    events.add(const SprayRoomEvent(
      type: 'cohost_invited', sessionId: 's1', data: {'user_id': 'ME'}, timestamp: 1,
    ));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(c.state.coHostInvitePending, isTrue);

    c.declineCoHostInvite();
    expect(c.state.coHostInvitePending, isFalse);
    await c.close();
  });

  test('cohost_invited addressed to someone else is ignored', () async {
    final c = build();
    c.bind(_session(), 'ME');
    events.add(const SprayRoomEvent(
      type: 'cohost_invited', sessionId: 's1', data: {'user_id': 'OTHER'}, timestamp: 1,
    ));
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(c.state.coHostInvitePending, isFalse);
    await c.close();
  });

  test('inviteCoHost as a non-host is rejected and never calls the repository', () async {
    final c = build();
    c.bind(_session(host: 'HOST'), 'ME');
    final err = await c.inviteCoHost(userId: 'X');
    expect(err, isNotNull);
    verifyNever(() => repo.inviteCoHost(any(), userId: any(named: 'userId'), userName: any(named: 'userName')));
    await c.close();
  });

  test('inviteCoHost as the host calls the repository', () async {
    when(() => repo.inviteCoHost(any(), userId: any(named: 'userId'), userName: any(named: 'userName')))
        .thenAnswer((_) async {});
    final c = build();
    c.bind(_session(host: 'ME'), 'ME');
    final err = await c.inviteCoHost(userId: 'X', userName: 'Bob');
    expect(err, isNull);
    verify(() => repo.inviteCoHost('s1', userId: 'X', userName: 'Bob')).called(1);
    await c.close();
  });

  test('toggleRecording as a non-host returns the host-only guard message', () async {
    final c = build();
    c.bind(_session(host: 'HOST'), 'ME');
    final err = await c.toggleRecording();
    expect(err, contains('only the host'));
    await c.close();
  });

  test('pause() as a non-host is a safe no-op (no repo call)', () async {
    final c = build();
    c.bind(_session(host: 'HOST'), 'ME');
    final err = await c.pause();
    expect(err, isNull);
    verifyNever(() => repo.pauseStream(any()));
    await c.close();
  });
}
