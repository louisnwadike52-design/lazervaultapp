import 'package:flutter_test/flutter_test.dart';

/// Inserting a mention chosen from the Members sheet, isolated from Flutter.
///
/// Different from the picker's path: there is no "@" token to replace,
/// because the choice came from a sheet rather than from typing. The spacing
/// rule is the whole substance — without it, tagging someone mid-sentence
/// welds the tag onto the previous word.
({String text, int caret}) insertMention(
  String text,
  int caret,
  String name,
) {
  final needsLeadingSpace =
      caret > 0 && !RegExp(r'\s$').hasMatch(text.substring(0, caret));
  final token = '${needsLeadingSpace ? ' ' : ''}@$name ';
  return (
    text: text.replaceRange(caret, caret, token),
    caret: caret + token.length,
  );
}

void main() {
  group('insert from the members sheet', () {
    test('an empty composer gets no leading space', () {
      final r = insertMention('', 0, 'Ada');
      expect(r.text, '@Ada ');
      expect(r.caret, 5);
    });

    test('mid-sentence gets a space so the tag is not welded on', () {
      final r = insertMention('pay up', 6, 'Ada');
      expect(r.text, 'pay up @Ada ');
    });

    test('an existing trailing space is not doubled', () {
      final r = insertMention('pay up ', 7, 'Ada');
      expect(r.text, 'pay up @Ada ');
    });

    test('a newline counts as whitespace', () {
      final r = insertMention('line\n', 5, 'Ada');
      expect(r.text, 'line\n@Ada ');
    });

    test('inserting at the caret, not the end', () {
      // Caret after "pay", so the tag lands there rather than after "up".
      final r = insertMention('pay up', 3, 'Ada');
      expect(r.text, 'pay @Ada  up');
      expect(r.caret, 'pay @Ada '.length);
    });

    test('always ends with a space so the picker does not reopen', () {
      for (final name in ['Ada', 'Ada Lovelace', 'X']) {
        expect(insertMention('hi', 2, name).text.endsWith(' '), isTrue);
      }
    });

    test('a two-word name survives intact', () {
      // Names contain spaces; the survivingMentions check looks for the
      // whole "@Ada Lovelace", so the inserted form has to match it.
      final r = insertMention('', 0, 'Ada Lovelace');
      expect(r.text, '@Ada Lovelace ');
      expect(r.text.contains('@Ada Lovelace'), isTrue);
    });
  });
}
