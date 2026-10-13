import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/utils/mention_text.dart';

/// "@all" and "@Lazervault Support" are SENTINELS, not members.
///
/// Both are offered in the picker keyed by a fake user id, and the send path
/// must pull each one out of the mentions array before it travels. The array
/// decides who is pushed a preview of a private conversation, so a fake id
/// left in it is the one mistake that actually matters here.
///
/// This mirrors the send path in contribution_chat_screen.dart:
///   final mentions = List<String>.of(survivingMentions(text, picked));
///   final mentionSupport = mentions.remove(_supportMentionId);
///   final mentionAll     = mentions.remove(_allMentionId);
const _supportMentionId = 'lazervault-support';
const _allMentionId = 'lazervault-all';

({List<String> ids, bool support, bool all}) sendPath(
  String text,
  Map<String, String> picked,
) {
  final mentions = List<String>.of(MentionText.survivingMentions(text, picked));
  final support = mentions.remove(_supportMentionId);
  final all = mentions.remove(_allMentionId);
  return (ids: mentions, support: support, all: all);
}

void main() {
  group('the send path separates sentinels from member ids', () {
    test('@all sets the flag and leaves no fake id behind', () {
      final r = sendPath('@Everyone please pay today',
          const {_allMentionId: 'Everyone'});
      expect(r.all, isTrue);
      expect(r.support, isFalse);
      expect(r.ids, isEmpty,
          reason: 'the sentinel must never reach mentioned_user_ids');
    });

    test('@all alongside real members keeps both, separately', () {
      final r = sendPath(
        '@Everyone and @Ada specifically',
        const {_allMentionId: 'Everyone', 'user-1': 'Ada'},
      );
      expect(r.all, isTrue);
      expect(r.ids, ['user-1']);
      expect(r.ids, isNot(contains(_allMentionId)));
    });

    test('support and @all are independent flags', () {
      final r = sendPath(
        '@Everyone @Lazervault Support please look',
        const {
          _allMentionId: 'Everyone',
          _supportMentionId: 'Lazervault Support',
        },
      );
      expect(r.all, isTrue);
      expect(r.support, isTrue);
      expect(r.ids, isEmpty);
    });

    test('typing @all without picking it does not set the flag', () {
      // The server expands the FLAG, not the text. Bare text stays text, which
      // is why the picker entry is the thing that has to be reachable.
      final r = sendPath('Hello @all', const {});
      expect(r.all, isFalse);
      expect(r.support, isFalse);
      expect(r.ids, isEmpty);
    });

    test('deleting the word @Everyone after picking it clears the flag', () {
      final r = sendPath('changed my mind', const {_allMentionId: 'Everyone'});
      expect(r.all, isFalse,
          reason: 'the tag did not survive the edit, so it must not travel');
    });

    test('a plain message is unaffected and does not throw', () {
      late final ({List<String> ids, bool support, bool all}) r;
      expect(() => r = sendPath('morning everyone', const {}), returnsNormally);
      expect(r.all, isFalse);
      expect(r.ids, isEmpty);
    });
  });
}
