// Financial Connections painted nothing until listConversations,
// listIncomingRequests AND getUnreadCount had all answered, one after the
// other, behind a realtime handshake. Now: the remembered page paints first,
// the three calls run together, the list repaints the moment IT arrives, and
// a refresh that fails leaves the painted list alone.
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_cubit.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_page_store.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Repo extends Mock implements P2PChatRepository {}

class _Storage extends Mock implements SecureStorageService {}

P2PConversationEntity _conv(String id, {int unread = 0}) =>
    P2PConversationEntity(
      id: id,
      participant1Id: 'me',
      participant2Id: 'peer-$id',
      createdAt: DateTime.utc(2026, 1, 1),
      otherUserId: 'peer-$id',
      otherUserName: 'Peer $id',
      unreadCount: unread,
    );

Future<void> _settle() async {
  for (var i = 0; i < 5; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _Repo repo;
  late _Storage storage;
  late P2PConversationsCubit cubit;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SessionPageStore.resetRegistryForTest();
    P2PConversationsPageStore.clear();
    repo = _Repo();
    storage = _Storage();
    when(() => storage.getUserId()).thenAnswer((_) async => 'u1');
    when(() =>
            repo.listConnectionBirthdays(withinDays: any(named: 'withinDays')))
        .thenAnswer((_) async => []);
    cubit = P2PConversationsCubit(repository: repo, secureStorage: storage);
  });

  tearDown(() => cubit.close());

  test(
      'the remembered page paints before any fetch answers, and the list '
      'repaints when conversations arrive — without waiting for unread',
      () async {
    P2PConversationsPageStore.put('u1',
        conversations: [_conv('old', unread: 2)], requests: const []);

    final convs = Completer<List<P2PConversationEntity>>();
    final reqs = Completer<List<P2PConversationEntity>>();
    final unread = Completer<int>();
    when(() => repo.listConversations()).thenAnswer((_) => convs.future);
    when(() => repo.listIncomingRequests()).thenAnswer((_) => reqs.future);
    when(() => repo.getUnreadCount()).thenAnswer((_) => unread.future);

    final seen = <P2PConversationsState>[];
    final sub = cubit.stream.listen(seen.add);

    final load = cubit.loadConversations();
    await _settle();

    // Painted from the store: no spinner, the old row, provisional badge.
    expect(seen.whereType<P2PConversationsLoading>(), isEmpty);
    final painted = cubit.state as P2PConversationsLoaded;
    expect(painted.conversations.single.id, 'old');
    expect(painted.totalUnread, 2);

    // Conversations land first: the list repaints NOW, unread still pending.
    convs.complete([_conv('fresh', unread: 1)]);
    await _settle();
    expect((cubit.state as P2PConversationsLoaded).conversations.single.id,
        'fresh');
    expect(unread.isCompleted, isFalse);

    reqs.complete([_conv('req')]);
    unread.complete(7);
    await load;
    final fin = cubit.state as P2PConversationsLoaded;
    expect(fin.conversations.single.id, 'fresh');
    expect(fin.incomingRequests.single.id, 'req');
    expect(fin.totalUnread, 7);
    // And the store now holds the fresh rows for the next open.
    expect(
        P2PConversationsPageStore.conversations.peek(userId: 'u1')!.single.id,
        'fresh');
    await sub.cancel();
  });

  test('a refresh in which both lists fail keeps the painted list', () async {
    when(() => repo.listConversations()).thenAnswer((_) async => [_conv('a')]);
    when(() => repo.listIncomingRequests()).thenAnswer((_) async => []);
    when(() => repo.getUnreadCount()).thenAnswer((_) async => 0);
    await cubit.loadConversations();
    expect(
        (cubit.state as P2PConversationsLoaded).conversations.single.id, 'a');

    when(() => repo.listConversations()).thenThrow(Exception('down'));
    when(() => repo.listIncomingRequests()).thenThrow(Exception('down'));
    when(() => repo.getUnreadCount()).thenThrow(Exception('down'));
    await cubit.loadConversations(silent: true);

    expect(cubit.state, isA<P2PConversationsLoaded>());
    expect(
        (cubit.state as P2PConversationsLoaded).conversations.single.id, 'a');
  });

  test(
      'a cold open with nothing remembered still shows the spinner, and a '
      'page remembered for another user is never painted', () async {
    P2PConversationsPageStore.put('someone-else',
        conversations: [_conv('theirs')], requests: const []);
    when(() => repo.listConversations()).thenAnswer((_) async => []);
    when(() => repo.listIncomingRequests()).thenAnswer((_) async => []);
    when(() => repo.getUnreadCount()).thenAnswer((_) async => 0);

    final seen = <P2PConversationsState>[];
    final sub = cubit.stream.listen(seen.add);
    await cubit.loadConversations();
    await _settle(); // stream delivery

    expect(seen.first, isA<P2PConversationsLoading>());
    expect((cubit.state as P2PConversationsLoaded).conversations, isEmpty);
    await sub.cancel();
  });
}
