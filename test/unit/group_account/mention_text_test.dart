import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/group_account/utils/mention_text.dart';

/// Mentions decide who gets a push. Every case below is one where getting the
/// text handling slightly wrong tags the wrong person, or nobody, or fights the
/// user while they type.
void main() {
  group('queryAt', () {
    test('opens as soon as @ is typed', () {
      final q = MentionText.queryAt('hey @', 5);
      expect(q, isNotNull);
      expect(q!.term, '');
      expect(q.start, 4);
    });

    test('captures the term after @', () {
      final q = MentionText.queryAt('hey @ad', 7);
      expect(q!.term, 'ad');
    });

    // A name can contain spaces, so a token that ended at the first space would
    // make "@Praiz Onah" unmatchable — and most names here are multi-word.
    test('spans spaces so multi-word names can be matched', () {
      final q = MentionText.queryAt('hey @Praiz On', 13);
      expect(q!.term, 'Praiz On');
    });

    // The rule that stops the picker fighting every email address typed in
    // chat.
    test('ignores an @ inside a word', () {
      expect(MentionText.queryAt('pay ada@site.com', 16), isNull);
    });

    test('requires the @ to start a word even mid-sentence', () {
      expect(MentionText.queryAt('a@b', 3), isNull);
      expect(MentionText.queryAt('a @b', 4), isNotNull);
    });

    test('a newline closes the token', () {
      expect(MentionText.queryAt('@ada\nhello', 10), isNull);
    });

    // Otherwise an abandoned '@' near the top of a long message keeps
    // re-opening the picker as the user writes.
    test('gives up after more words than a name could span', () {
      expect(
        MentionText.queryAt('@ one two three four five', 25),
        isNull,
      );
    });

    test('returns null with no @ at all', () {
      expect(MentionText.queryAt('plain message', 13), isNull);
    });

    test('uses the caret, not the end of the text', () {
      // Caret sits right after "@ad"; the rest was typed earlier.
      final q = MentionText.queryAt('hey @ad and then more', 7);
      expect(q!.term, 'ad');
    });

    test('tolerates out-of-range carets', () {
      expect(MentionText.queryAt('abc', 99), isNull);
      expect(MentionText.queryAt('abc', -1), isNull);
    });
  });

  group('applyMention', () {
    test('replaces the token and leaves a trailing space', () {
      final q = MentionText.queryAt('hey @ad', 7)!;
      final r = MentionText.applyMention('hey @ad', q, 'Ada Obi');
      expect(r.text, 'hey @Ada Obi ');
      expect(r.caret, r.text.length);
    });

    // A token may contain spaces, so a trailing space alone cannot end it — the
    // scan would walk over the space and find the '@' just inserted, reopening
    // the picker on top of the chosen name. The boundary recorded at selection
    // is what actually closes it.
    test('the recorded boundary closes the token', () {
      final q = MentionText.queryAt('hey @ad', 7)!;
      final r = MentionText.applyMention('hey @ad', q, 'Ada Obi');
      expect(
        MentionText.queryAt(r.text, r.caret, notBefore: r.caret),
        isNull,
        reason: 'the completed mention must not be re-parsed as a new token',
      );
    });

    test('a NEW @ after the boundary still opens', () {
      final r = MentionText.applyMention(
          'hey @ad', MentionText.queryAt('hey @ad', 7)!, 'Ada Obi');
      final typed = '${r.text}@ch';
      final q = MentionText.queryAt(typed, typed.length, notBefore: r.caret);
      expect(q, isNotNull);
      expect(q!.term, 'ch');
    });

    test('keeps text written after the caret', () {
      final q = MentionText.queryAt('hi @ad rest', 6)!;
      final r = MentionText.applyMention('hi @ad rest', q, 'Ada');
      expect(r.text, 'hi @Ada  rest');
    });
  });

  group('survivingMentions', () {
    final chosen = {'u1': 'Ada Obi', 'u2': 'Chris N'};

    test('keeps ids whose name is still written', () {
      final got = MentionText.survivingMentions('hey @Ada Obi look', chosen);
      expect(got, ['u1']);
    });

    // The case that matters: pick someone, then delete their name. Sending the
    // id would notify a person about a message that never mentions them.
    test('drops an id whose name was deleted', () {
      expect(MentionText.survivingMentions('hey look', chosen), isEmpty);
    });

    test('drops an id whose name was partially backspaced', () {
      expect(MentionText.survivingMentions('hey @Ada O', chosen), isEmpty);
    });

    test('keeps several', () {
      final got = MentionText.survivingMentions(
          '@Ada Obi and @Chris N please', chosen);
      expect(got, containsAll(['u1', 'u2']));
    });

    test('empty selection is empty', () {
      expect(MentionText.survivingMentions('@Ada Obi', const {}), isEmpty);
    });
  });

  group('rank', () {
    final names = ['Chris Ade', 'Ada Obi', 'Bode Ade'];
    String nameOf(String s) => s;

    test('prefix matches come before substring matches', () {
      final got = MentionText.rank(names, 'ad', nameOf: nameOf);
      expect(got.first, 'Ada Obi',
          reason: 'typing "ad" almost always means the name starting with it');
      expect(got, contains('Chris Ade'));
    });

    test('an empty term offers everyone', () {
      expect(MentionText.rank(names, '', nameOf: nameOf).length, 3);
    });

    test('is case-insensitive', () {
      expect(MentionText.rank(names, 'ADA', nameOf: nameOf).first, 'Ada Obi');
    });

    test('no match yields nothing', () {
      expect(MentionText.rank(names, 'zzz', nameOf: nameOf), isEmpty);
    });
  });

  group('MentionHighlighting.spans', () {
    const names = {'u1': 'Ada Obi', 'u2': 'Ada'};

    test('highlights the mentioned name and leaves the rest plain', () {
      final r = MentionHighlighting.spans(
          'hey @Ada Obi please pay', ['u1'], names);
      expect(r.map((s) => s.text).join(), 'hey @Ada Obi please pay',
          reason: 'spans must reassemble into the original message');
      expect(r.where((s) => s.isMention).map((s) => s.text), ['@Ada Obi']);
    });

    // A name containing spaces is the whole reason this is name-driven. An
    // "@word" rule would colour "@Ada" and leave " Obi" plain, which reads as
    // a rendering fault rather than a mention.
    test('a multi-word name is highlighted whole', () {
      final r = MentionHighlighting.spans('@Ada Obi', ['u1'], names);
      expect(r.single.text, '@Ada Obi');
      expect(r.single.isMention, isTrue);
    });

    // "Ada" is a prefix of "Ada Obi": matching the short one first would leave
    // " Obi" dangling outside the highlight.
    test('the longer name wins when one is a prefix of another', () {
      final r =
          MentionHighlighting.spans('@Ada Obi', ['u1', 'u2'], names);
      expect(r.single.text, '@Ada Obi');
    });

    test("your own mention is marked differently from someone else's", () {
      final mine = MentionHighlighting.spans(
          '@Ada Obi', ['u1'], names, selfUserId: 'u1');
      expect(mine.single.isSelf, isTrue);

      final theirs = MentionHighlighting.spans(
          '@Ada Obi', ['u1'], names, selfUserId: 'someone');
      expect(theirs.single.isSelf, isFalse);
    });

    test('an id with no known name is left unhighlighted', () {
      final r = MentionHighlighting.spans('@Ghost hi', ['gone'], names);
      expect(r.single.isMention, isFalse);
      expect(r.single.text, '@Ghost hi');
    });

    test('several mentions in one message', () {
      final r = MentionHighlighting.spans(
          '@Ada Obi and @Ada again', ['u1', 'u2'], names);
      expect(r.map((s) => s.text).join(), '@Ada Obi and @Ada again');
      expect(r.where((s) => s.isMention).length, 2);
    });

    test('no mentions returns the text as one plain span', () {
      final r = MentionHighlighting.spans('plain text', const [], names);
      expect(r.single.text, 'plain text');
      expect(r.single.isMention, isFalse);
    });

    test('empty text yields nothing', () {
      expect(MentionHighlighting.spans('', ['u1'], names), isEmpty);
    });
  });
}
