import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/receipt_fonts.dart';

// The pdf package RAISES on a glyph the document's font cannot draw rather
// than substituting one, so a receipt that emits ₦ without an embedded
// TrueType font does not render badly — it fails to render at all, and the
// customer sees "Share failed" with no way to get their document out.
//
// That makes this an invariant, not a preference: WITHOUT an embedded font the
// symbol must stay inside ASCII. Thirteen PDF services used to hardcode the
// ISO code to sidestep the problem, which is why receipts printed
// "NGN 1,500.00" against an on-screen "₦1,500.00" for the same transaction.
void main() {
  // These run with no font loaded, which is the dangerous branch — the one
  // that has to stay ASCII.
  setUp(() {
    ReceiptFonts.regular = null;
    ReceiptFonts.bold = null;
  });

  test('without an embedded font every symbol is pure ASCII', () {
    const codes = [
      'NGN', 'GBP', 'EUR', 'USD', 'ZAR', 'CAD', 'AUD',
      'INR', 'JPY', 'KES', 'GHS', 'XOF', 'zar', '',
    ];
    for (final c in codes) {
      final s = receiptCurrencySymbol(c);
      final offending = s.runes
          .where((r) => r < 0x20 || r > 0x7E)
          .map((r) => 'U+${r.toRadixString(16)}');
      expect(
        offending,
        isEmpty,
        reason: '$c produced "$s", which the built-in PDF font cannot draw — '
            'the whole receipt would fail to render',
      );
    }
  });

  test('the fallback still identifies the currency', () {
    // ASCII-safe must not mean information-free: the reader still has to know
    // what currency the number is in.
    expect(receiptCurrencySymbol('NGN'), contains('NGN'));
    expect(receiptCurrencySymbol('GBP'), contains('GBP'));
  });

  test('an unknown code degrades to the code itself, never empty', () {
    // An empty symbol would render a bare number with no currency at all.
    expect(receiptCurrencySymbol('XYZ').trim(), 'XYZ');
  });

  test('the code is normalised, so a lowercase currency is not a new one', () {
    expect(receiptCurrencySymbol('ngn'), receiptCurrencySymbol('NGN'));
  });
}
