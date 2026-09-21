import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/statistics/presentation/widgets/scope_pills.dart';

/// A scope pill's second line is drawn from whatever the caller put in
/// `subtitle`, and one caller (the bank selector) passes a RAW account number.
/// While subtitles only appeared inside the picker sheet that was contained;
/// once they render on the inline pills too, an unmasked value would sit in
/// full view on the analytics page.
///
/// So the masking lives at the single point the subtitle is painted, and these
/// tests pin the two properties that make that safe: digits are always masked,
/// and anything already safe survives untouched.
void main() {
  group('ScopeItem.maskIdentifier', () {
    test('masks a raw account number to its last four digits', () {
      expect(ScopeItem.maskIdentifier('0279098300'), '••••8300');
      expect(ScopeItem.maskIdentifier('12345678'), '••••5678');
    });

    test('is idempotent — an already-masked value is not re-masked', () {
      // The server sends maskedAccountNumber pre-masked. Masking it again
      // would mangle it, so this is the property that lets both a raw and a
      // pre-masked source flow through the same render path.
      const already = '••••8300';
      expect(ScopeItem.maskIdentifier(already), already);
      expect(ScopeItem.maskIdentifier(ScopeItem.maskIdentifier('0279098300')),
          '••••8300');
    });

    test('leaves non-account subtitles alone', () {
      // Wallets fall back to a type label when no number is known.
      for (final v in ['Personal', 'Savings', 'Business', 'Wallet']) {
        expect(ScopeItem.maskIdentifier(v), v);
      }
    });

    test('handles empty, null and too-short values without throwing', () {
      expect(ScopeItem.maskIdentifier(null), '');
      expect(ScopeItem.maskIdentifier(''), '');
      expect(ScopeItem.maskIdentifier('   '), '');
      // Nothing to hide in fewer than five digits, and masking it would leave
      // an empty-looking chip.
      expect(ScopeItem.maskIdentifier('123'), '123');
      expect(ScopeItem.maskIdentifier('1234'), '1234');
    });

    test('no digit run longer than four survives unmasked', () {
      // The property that actually matters, stated directly: whatever goes in,
      // what comes out must not contain the full number.
      const raw = '0279098300';
      final out = ScopeItem.maskIdentifier(raw);
      expect(out.contains(raw), isFalse);
      expect(RegExp(r'\d{5,}').hasMatch(out), isFalse);
    });
  });
}
