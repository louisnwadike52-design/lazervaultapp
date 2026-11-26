import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// THE ROW IS ON A NEAR-BLACK PAGE. THE DIALOG IS ON WHITE.
///
/// `pay_with_crypto_selector.dart` holds both, and that is the trap: the row
/// was styled with the palette of the dialog beneath it, so on the live bill
/// and send-funds screens (#0A0A0A) the label was black-on-black and the
/// brand purple was a dark purple on near-black. Every element was present
/// and the feature read as switched off.
void main() {
  final src = File('lib/src/features/crypto_pay/presentation/'
          'pay_with_crypto_selector.dart')
      .readAsStringSync();

  /// The row widget's own class body — everything before the dialog that
  /// follows it, which is painted on white and keeps the deep brand purple.
  String rowClass() {
    final start = src.indexOf('class PayWithCryptoSelector');
    final end = src.indexOf('class _PaySourceDialog');
    expect(start, greaterThanOrEqualTo(0));
    expect(end, greaterThan(start),
        reason: 'the dialog must still follow the row in this file, or this '
            'test is slicing the wrong thing');
    return src.substring(start, end);
  }

  test('the row never applies near-black ink UNCONDITIONALLY', () {
    // #111827 is the heading colour for a WHITE card. Applied flat on this
    // page it is black on black — which is exactly what happened to
    // "Pay with".
    //
    // UPDATED 2026-11-23. The row became surface-aware on 22 Nov: it now
    // takes `onDarkSurface` and picks a palette per caller, so it legitimately
    // MENTIONS both. The old assertion — that the light-surface colour must
    // not appear at all — could not express that and failed on a strictly
    // better design. What still matters, and is what this now checks, is that
    // every mention sits on the light branch of an onDarkSurface ternary.
    final row = rowClass();
    for (final line in row.split('\n')) {
      if (!line.contains('0xFF111827')) continue;
      expect(line.contains('onDarkSurface'), isTrue,
          reason: 'near-black applied without asking which surface it is on — '
              'on the #0A0A0A bill and send-funds screens that is invisible:\n'
              '  ${line.trim()}');
    }
  });

  test(
      'the row has the light violet, and only picks the deep purple by surface',
      () {
    final row = rowClass();
    expect(row.contains('Color(0xFFA78BFA)'), isTrue,
        reason: 'the row needs the accent this app already uses on dark '
            'surfaces');
    // Same reasoning as above: the deep brand purple may appear, but only as
    // the LIGHT-surface arm of a choice, never as the flat answer.
    for (final line in row.split('\n')) {
      if (!line.contains('Color.fromARGB(255, 78, 3, 208)')) continue;
      expect(line.contains('onDarkSurface'), isTrue,
          reason: '#4E03D0 applied flat — correct on the white dialog below, '
              'unreadable on the page the row sits on:\n  ${line.trim()}');
    }
  });

  test('the dialog KEEPS the deep brand purple', () {
    // The inverse mistake. The dialog is painted on Colors.white, where a
    // pale violet selected-state is as hard to see as the dark one was here.
    final dialog = src.substring(src.indexOf('class _PaySourceDialog'));
    expect(dialog.contains('Color.fromARGB(255, 78, 3, 208)'), isTrue,
        reason: 'the dialog surface is white and must not be retinted with '
            'the row');
  });

  test('both tokens are named for the surface they belong to', () {
    // So the next person adding a colour here picks by surface rather than by
    // which constant happened to be in scope — which is the whole of how this
    // bug happened.
    expect(src.contains('_brandOnDark'), isTrue);
    expect(src.contains('_labelOnDark'), isTrue);
  });
}
