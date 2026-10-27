// P2PChatThreadStore keeps the last page of a chat thread on disk so a cold
// open paints. It is the one place in the app that creates a SessionPageStore
// PER KEY (one per peer) and evicts them, and SessionPageStore registers every
// instance in a process-lifetime static list — so eviction has to unregister
// as well as clear, or the list grows by one for every peer the user has ever
// opened a chat with, and SessionPageStore.clearAll then walks (and issues a
// disk delete for) each dead entry on every user switch.
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_state.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_thread_store.dart';

P2PChatLoaded _thread(String peerId, {String deliveryStatus = 'delivered'}) =>
    P2PChatLoaded(
      conversationId: 'c-$peerId',
      messages: [
        P2PMessageEntity(
          id: 'm-$peerId',
          conversationId: 'c-$peerId',
          senderId: 'u1',
          messageType: 'text',
          content: 'hello $peerId',
          deliveryStatus: deliveryStatus,
          createdAt: DateTime(2026, 10, 27),
        ),
      ],
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    SessionPageStore.resetRegistryForTest();
    P2PChatThreadStore.clear();
  });

  test('a remembered thread comes back for the same user', () async {
    P2PChatThreadStore.put('u1', 'peer-1', _thread('peer-1'));
    final back = await P2PChatThreadStore.hydrate('u1', 'peer-1');
    expect(back, isNotNull);
    expect(back!.conversationId, 'c-peer-1');
    expect(back.messages.single.content, 'hello peer-1');
  });

  test('never for another user', () async {
    P2PChatThreadStore.put('u1', 'peer-1', _thread('peer-1'));
    expect(await P2PChatThreadStore.hydrate('u2', 'peer-1'), isNull);
  });

  test('an unsent or failed bubble is not mirrored', () async {
    P2PChatThreadStore.put(
        'u1', 'peer-1', _thread('peer-1', deliveryStatus: 'sending'));
    final back = await P2PChatThreadStore.hydrate('u1', 'peer-1');
    // The thread is still remembered (its metadata row is), but a bubble with
    // nothing to retry it with after a relaunch is not.
    expect(back!.messages, isEmpty);
  });

  test('eviction past the peer cap does not grow the static registry', () {
    // Twice the cap of distinct peers: the registry must end up holding the
    // live stores only, not one per peer ever opened.
    for (var i = 0; i < 20; i++) {
      P2PChatThreadStore.put('u1', 'peer-$i', _thread('peer-$i'));
    }
    expect(SessionPageStore.registeredCountForTest, lessThanOrEqualTo(8),
        reason: 'evicted per-peer stores must unregister, not just clear');

    // And clear() leaves nothing behind at all.
    P2PChatThreadStore.clear();
    expect(SessionPageStore.registeredCountForTest, 0);
  });

  test('the most recent peers survive eviction, the oldest do not', () async {
    for (var i = 0; i < 10; i++) {
      P2PChatThreadStore.put('u1', 'peer-$i', _thread('peer-$i'));
    }
    expect(await P2PChatThreadStore.hydrate('u1', 'peer-9'), isNotNull);
    expect(await P2PChatThreadStore.hydrate('u1', 'peer-0'), isNull);
  });
}
