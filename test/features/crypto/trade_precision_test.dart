import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto/domain/trade_precision.dart';
import 'dart:io';

// A user holding 29.019800 USDT tapped Max, was shown "You sell 29.019794
// USDT · You receive ₦38,901.04", and the Confirm sheet then said 29.01 USDT /
// ₦38,887.92 — ₦13.16 less. The backend truncates the order quantity to the
// precision the exchange accepts (USDT = 2dp) before placing it, so the
// preview had promised a trade Quidax would not take.
//
// Their words: "different rates within one screen, this may cause distrust".
void main() {
  group('order precision mirrors the exchange', () {
    test('the reported case: 29.0198 USDT floors to 29.01', () {
      expect(floorToOrderPrecision(29.0198, 'usdt'), 29.01);
      expect(floorToOrderPrecision(29.019794, 'USDT'), 29.01);
    });

    test('it FLOORS, never rounds', () {
      // Rounding up sends more than the user holds or authorised. The backend
      // learned this twice: a max-sell of 12.34567 TRX rounded to 12.3457 and
      // the exchange rejected it as insufficient; a 10.76 ADA send rounded to
      // 10.8 and over-sent, irreversibly.
      expect(floorToOrderPrecision(12.34567, 'trx'), 12.3456); // 4dp, not …57
      expect(floorToOrderPrecision(10.76, 'ada'), 10.7); // 1dp, not 10.8
      expect(floorToOrderPrecision(0.999999, 'btc'), 0.99999); // 5dp
    });

    test('a quantity already within precision is untouched', () {
      expect(floorToOrderPrecision(29.01, 'usdt'), 29.01);
      expect(floorToOrderPrecision(5, 'usdt'), 5);
      expect(floorToOrderPrecision(100, 'ngn'), 100);
    });

    test('fiat and whole-unit coins floor to integers', () {
      expect(floorToOrderPrecision(38998.54, 'ngn'), 38998);
      expect(floorToOrderPrecision(1234.99, 'shib'), 1234);
    });

    test('unknown currencies get the conservative 8dp default', () {
      // Matches the backend fallback. Too-fine is rejected cleanly by the
      // exchange; too-coarse would silently shrink a trade.
      expect(orderDecimalsFor('somenewcoin'), 8);
      expect(floorToOrderPrecision(1.123456789, 'somenewcoin'), 1.12345678);
    });

    test('nonsense input yields zero, never NaN or negative', () {
      // This feeds an amount field and a money preview.
      expect(floorToOrderPrecision(0, 'usdt'), 0);
      expect(floorToOrderPrecision(-5, 'usdt'), 0);
      expect(floorToOrderPrecision(double.nan, 'usdt'), 0);
      expect(floorToOrderPrecision(double.infinity, 'usdt'), 0);
    });

    test('a value sitting on a boundary does not lose a whole unit', () {
      // 29.01 can arrive as 29.009999999999998 after a fiat->crypto divide.
      // Without tolerance that floors to 29.00 and silently drops ₦13 again.
      expect(floorToOrderPrecision(29.009999999999998, 'usdt'), 29.01);
      expect(floorToOrderPrecision(0.19999999999999998, 'ada'), 0.2);
    });

    test('order precision is NOT the ledger scale', () {
      // Conflating them is how amounts get sent 10,000x wrong. USDT is 2dp to
      // the exchange and 6dp on the ledger; the config RPC serves the latter.
      expect(orderDecimalsFor('usdt'), 2);
      expect(orderDecimalsFor('ngn'), 0); // ledger NGN is 2 (kobo)
      expect(orderDecimalsFor('btc'), 5); // ledger BTC is 8 (sats)
    });
  });

  group('sell flow wiring', () {
    String codeOf(String p) => File(p)
        .readAsStringSync()
        .split('\n')
        .where((l) => !l.trimLeft().startsWith('//'))
        .join('\n');

    const sheet =
        'lib/src/features/crypto/presentation/view/sell_crypto_sheet.dart';
    const card =
        'lib/src/features/crypto/presentation/widgets/price_quote_card.dart';

    test('the sell sheet quantises the quantity it previews', () {
      final code = codeOf(sheet);
      expect(code, contains('floorToOrderPrecision('),
          reason: 'the preview must describe a trade the exchange will take');
      // Max must floor to the ORDER precision, not the field's 6dp — that was
      // the path that produced 29.019794.
      expect(code, isNot(contains('(h.quantity * 1e6).floorToDouble() / 1e6')),
          reason: 'Max floored to 6dp, offering a quantity the exchange '
              'would truncate anyway');
    });

    test('the rate chip shows the rate the trade fills at', () {
      final code = codeOf(card);
      // The CALL SITE, not just the definition. Asserting the function exists
      // passes even when the render goes back to the raw ticker — which is
      // exactly what a mutation of this file proved.
      expect(code, contains('final effective = _effectiveRate(_price!)'),
          reason: 'the rendered rate must be the direction-adjusted one');
      expect(code, contains('_formatPrice(effective)'),
          reason: 'the card showed the raw ticker while the sheet computed '
              'with the margin-adjusted rate — two rates on one screen');
      expect(code, isNot(contains('_formatPrice(_price!)')),
          reason: 'rendering the raw ticker is the bug being fixed');
      expect(code, contains("case 'sell':"));
      expect(code, contains("case 'buy':"));
      // onRateUpdated must keep reporting the RAW ticker: the sheets apply the
      // margin themselves, so adjusting it here would double-apply.
      expect(code, contains('widget.onRateUpdated?.call(_price)'));
    });

    test('every trading surface declares its direction', () {
      for (final f in [
        'lib/src/features/crypto/presentation/view/buy_crypto_sheet.dart',
        'lib/src/features/crypto/presentation/view/buy_crypto_screen.dart',
        'lib/src/features/crypto/presentation/view/sell_crypto_sheet.dart',
        'lib/src/features/crypto/presentation/view/sell_crypto_screen.dart',
      ]) {
        final code = codeOf(f);
        final i = code.indexOf('PriceQuoteCard(');
        expect(i, greaterThan(-1), reason: '$f should render the card');
        final block = code.substring(i, i + 320);
        expect(block, contains("side: '"),
            reason: '$f renders a rate chip without saying which direction '
                'it is quoting, so it shows the unadjusted ticker');
      }
    });

    test('the comment strip actually strips (self-check)', () {
      const commented = '// floorToOrderPrecision(x)\n  final y = 1;\n';
      final stripped = commented
          .split('\n')
          .where((l) => !l.trimLeft().startsWith('//'))
          .join('\n');
      expect(stripped, isNot(contains('floorToOrderPrecision')));
      expect(stripped, contains('final y = 1;'));
    });
  });
}
