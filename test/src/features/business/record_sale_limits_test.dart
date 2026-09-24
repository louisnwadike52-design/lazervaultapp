import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Record a sale had no input limits at all.
///
/// The description reached the server, the sales list and the receipt PDF at
/// whatever length someone pasted, and the amount field accepted letters that only
/// failed on submit — with nothing to say which character was the problem.
///
/// The formatter below is exercised directly. A widget test of the screen would
/// need a business account, a live sales service and an inventory list to reach the
/// field at all, and none of that is what is worth pinning here.

/// A local copy of the screen's rule, so the behaviour is testable without
/// standing up the screen. Kept in step by the source assertions at the bottom.
class SingleDecimalPoint extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final dots = newValue.text.split('.').length - 1;
    return dots > 1 ? oldValue : newValue;
  }
}

void main() {
  group('the amount accepts one decimal point', () {
    final f = SingleDecimalPoint();

    TextEditingValue v(String t) => TextEditingValue(text: t);

    test('a plain number passes', () {
      expect(f.formatEditUpdate(v('12'), v('123')).text, '123');
    });

    test('the first decimal point passes', () {
      expect(f.formatEditUpdate(v('123'), v('123.')).text, '123.');
      expect(f.formatEditUpdate(v('123.'), v('123.4')).text, '123.4');
    });

    test('a SECOND decimal point is rejected, keeping the old text', () {
      // "1.2.3" parses to null and fails on submit, which is the wrong moment and
      // the wrong message.
      expect(f.formatEditUpdate(v('1.2'), v('1.2.')).text, '1.2');
      expect(f.formatEditUpdate(v('1.2'), v('1.2.3')).text, '1.2');
    });

    test('it rejects rather than rewriting', () {
      // A formatter that edits the string has to fix up the selection too, and
      // getting that wrong moves the caret mid-typing. Returning oldValue keeps
      // the caret where the framework already had it.
      final old = const TextEditingValue(
        text: '1.2',
        selection: TextSelection.collapsed(offset: 3),
      );
      final result = f.formatEditUpdate(old, v('1.2.'));
      expect(result, same(old));
    });

    test('deleting back to a single point is allowed again', () {
      expect(f.formatEditUpdate(v('1.2'), v('1.')).text, '1.');
    });
  });

  group('the screen declares its limits', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/business/presentation/view/record_sale_screen.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'record_sale_screen.dart moved — update this test');
      source = file.readAsStringSync();
    });

    test('the description is capped at the transfer-narration limit', () {
      // 100, the same as the transfer note, because this text lands on the sales
      // list and the receipt PDF where a pasted paragraph truncates or breaks the
      // layout.
      expect(source, contains('maxLength: 100'));
    });

    test('the amount is capped and digit-filtered', () {
      expect(source, contains('maxLength: 13'),
          reason: 'ten digits plus a point and two decimals — more than any '
              'single sale, and short of overflowing the amount column');
      expect(source,
          contains("FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))"),
          reason:
              'the numeric keyboard is a hint, not a constraint: a hardware '
              'keyboard, a paste or the symbols pad all put letters in');
      expect(source, contains('_SingleDecimalPointFormatter()'));
    });

    test('the shared field builder can carry both', () {
      // Both fields go through one builder, so the limits have to be parameters
      // rather than copied into each call site.
      expect(source, contains('int? maxLength,'));
      expect(source, contains('List<TextInputFormatter>? inputFormatters,'));
    });

    test('the formatter only ever rejects', () {
      expect(source, contains('return dots > 1 ? oldValue : newValue;'));
    });
  });
}
