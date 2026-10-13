import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/utils/mention_text.dart';

/// The contribution chat's send button did nothing, for every message where no
/// mention had been picked from the suggestion list.
///
/// `survivingMentions` returned `const []` in that case, and the send path does
///
///   final mentions = MentionText.survivingMentions(text, picked);
///   final mentionSupport = mentions.remove(_supportMentionId);
///
/// Removing from a const list throws UnsupportedError. That happened BEFORE the
/// composer was cleared, so the typed text stayed on screen, no message was
/// created, and no error was shown: the button looked dead. Reported against
/// 1.0.1+402 with the message "Hello @all".
void main() {
  group('survivingMentions returns a list the caller may mutate', () {
    test('the no-mentions case is growable, not const', () {
      final out = MentionText.survivingMentions('Hello @all', const {});
      expect(out, isEmpty);
      // The exact operation the send path performs.
      expect(() => out.remove('support'), returnsNormally);
      expect(() => out.add('x'), returnsNormally);
    });

    test('a plain message with no @ at all is also growable', () {
      final out = MentionText.survivingMentions('good morning', const {});
      expect(() => out.remove('anything'), returnsNormally);
    });

    test('a picked mention that survived is returned and is mutable', () {
      final out = MentionText.survivingMentions(
        'morning @Ada, see this',
        const {'user-1': 'Ada'},
      );
      expect(out, ['user-1']);
      expect(() => out.remove('user-1'), returnsNormally);
      expect(out, isEmpty);
    });

    test('a mention deleted from the text does not notify that person', () {
      final out = MentionText.survivingMentions(
        'morning, see this',
        const {'user-1': 'Ada'},
      );
      expect(out, isEmpty,
          reason: 'the name was removed, so the tag must not travel');
    });

    test('an empty display name cannot match everything', () {
      final out = MentionText.survivingMentions(
        'nothing tagged here',
        const {'user-1': ''},
      );
      expect(out, isEmpty);
    });

    test('several picked mentions all survive', () {
      final out = MentionText.survivingMentions(
        '@Ada and @Bisi please read',
        const {'u1': 'Ada', 'u2': 'Bisi'},
      );
      expect(out, containsAll(<String>['u1', 'u2']));
      expect(() => out.clear(), returnsNormally);
    });
  });
}
