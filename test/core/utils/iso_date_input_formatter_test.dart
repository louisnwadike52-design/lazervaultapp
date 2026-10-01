import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/iso_date_input_formatter.dart';

TextEditingValue _v(String s) => TextEditingValue(
    text: s, selection: TextSelection.collapsed(offset: s.length));

String _type(String keystrokes) {
  const f = IsoDateInputFormatter();
  var value = const TextEditingValue();
  for (final ch in keystrokes.split('')) {
    value = f.formatEditUpdate(value, _v('${value.text}$ch'));
  }
  return value.text;
}

void main() {
  group('inserts the dashes as you type', () {
    test('a full date, digits only', () {
      expect(_type('19900115'), '1990-01-15');
    });

    test('the separators appear at the moment they are needed', () {
      expect(_type('1'), '1');
      expect(_type('1990'), '1990');
      expect(_type('19900'), '1990-0');
      expect(_type('199001'), '1990-01');
      expect(_type('1990011'), '1990-01-1');
    });

    test('a user who types the dashes themselves gets the same result', () {
      expect(_type('1990-01-15'), '1990-01-15');
    });

    test('letters and stray punctuation are dropped', () {
      expect(_type('19a9b0/01.15'), '1990-01-15');
    });

    test('cannot grow past a date', () {
      expect(_type('1990011599999'), '1990-01-15');
    });
  });

  group('deleting behaves the way people expect', () {
    const f = IsoDateInputFormatter();

    // The classic failure — backspace removes the dash, the formatter puts it
    // straight back — cannot happen: a separator is written BEFORE the digit
    // it precedes, so the text never ends in a dash and backspacing from the
    // end always removes a digit. This walks the whole way back to prove it.
    test('backspacing from the end walks the date down cleanly', () {
      var text = '1990-01-15';
      final seen = <String>[];
      while (text.isNotEmpty) {
        text = f
            .formatEditUpdate(_v(text), _v(text.substring(0, text.length - 1)))
            .text;
        seen.add(text);
      }
      expect(seen, [
        '1990-01-1',
        '1990-01',
        '1990-0',
        '1990',
        '199',
        '19',
        '1',
        '',
      ]);
    });

    test('backspacing a digit removes just that digit', () {
      final before = _v('1990-01-15');
      final after = f.formatEditUpdate(before, _v('1990-01-1'));
      expect(after.text, '1990-01-1');
    });

    test('clearing the field clears it', () {
      final after = f.formatEditUpdate(_v('1990-01-15'), _v(''));
      expect(after.text, '');
    });
  });

  test('the caret always lands at the end', () {
    const f = IsoDateInputFormatter();
    final after = f.formatEditUpdate(_v('1990'), _v('19900'));
    expect(after.text, '1990-0');
    expect(after.selection.baseOffset, after.text.length);
  });

  // A formatter runs on every keystroke, so a partially-typed date is invalid
  // almost all the time. Rejecting as you type would make the field
  // impossible to fill; range checks belong to the step validator.
  test('does not reject an impossible month while it is being typed', () {
    expect(_type('19901'), '1990-1');
    expect(_type('199013'), '1990-13');
  });
}
