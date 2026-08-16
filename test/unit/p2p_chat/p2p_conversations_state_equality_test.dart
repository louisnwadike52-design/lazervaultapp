import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/connection_birthday_entity.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_conversation_entity.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_state.dart';

/// Locks in the value-equality that stops the financial-connections list from
/// flickering on return: a silent refresh that returns identical data must
/// produce a P2PConversationsLoaded that == the previous one, so Bloc de-dupes
/// the emission and the tiles/avatars are not rebuilt/re-faded.
void main() {
  final createdAt = DateTime.utc(2026, 1, 1);
  final lastAt = DateTime.utc(2026, 8, 2, 10, 30);

  P2PConversationEntity conv({int unread = 0, String? avatar = 'a.png'}) =>
      P2PConversationEntity(
        id: 'c1',
        participant1Id: 'u1',
        participant2Id: 'u2',
        createdAt: createdAt,
        lastMessageAt: lastAt,
        lastMessagePreview: 'hi',
        unreadCount: unread,
        otherUserId: 'u2',
        otherUserName: 'Ada',
        otherUserAvatar: avatar,
      );

  ConnectionBirthdayEntity bday() => const ConnectionBirthdayEntity(
        userId: 'u2',
        name: 'Ada',
        dateOfBirth: '1990-08-05',
        daysUntil: 3,
        isToday: false,
        nextBirthday: '2026-08-05',
      );

  P2PConversationsLoaded loaded({int unread = 0, String? avatar = 'a.png'}) =>
      P2PConversationsLoaded(
        conversations: [conv(unread: unread, avatar: avatar)],
        upcomingBirthdays: [bday()],
        totalUnread: unread,
      );

  group('P2PConversationEntity equality', () {
    test('identical field values are equal (deep, by value)', () {
      expect(conv() == conv(), isTrue);
      expect(conv().hashCode == conv().hashCode, isTrue);
    });

    test('a changed field (unread / avatar) is NOT equal', () {
      expect(conv(unread: 0) == conv(unread: 1), isFalse);
      expect(conv(avatar: 'a.png') == conv(avatar: 'b.png'), isFalse);
    });
  });

  group('P2PConversationsLoaded equality (drives Bloc de-dupe)', () {
    test('identical data → equal → Bloc would skip the rebuild', () {
      expect(loaded() == loaded(), isTrue);
    });

    test('a changed unread count → NOT equal → legitimately rebuilds', () {
      expect(loaded(unread: 0) == loaded(unread: 1), isFalse);
    });

    test('distinct state types are never equal even with empty props', () {
      expect(P2PConversationsLoading() == P2PConversationsInitial(), isFalse);
    });
  });
}
