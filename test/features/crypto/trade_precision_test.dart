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

  group('no value is lost anywhere in the flow', () {
    // The amount must survive every conversion the sheet performs. Quantising
    // introduced a NEW way to lose a unit: Max fills a fiat figure, the sheet
    // divides it back into a quantity, and floors that — so flooring the fiat
    // too drops 0.01 USDT on the round trip.
    const rate = 1343.86;

    double maxFiatCeil(double sellable) =>
        (sellable * rate * 100).ceilToDouble() / 100;

    test('fiat Max round-trips back to the SAME quantity', () {
      final sellable = floorToOrderPrecision(29.0198, 'usdt'); // 29.01
      final filled = maxFiatCeil(sellable);
      final back = floorToOrderPrecision(filled / rate, 'usdt');
      expect(back, sellable,
          reason: 'Max filled $filled, which divided back to ${filled / rate} '
              'and floored to $back — the Max button itself would have '
              'dropped ${(sellable - back).toStringAsFixed(2)} USDT');
    });

    test('flooring the fiat instead would lose a unit (the bug)', () {
      // Pins WHY it ceils, so nobody "tidies" it back to floor.
      final sellable = floorToOrderPrecision(29.0198, 'usdt');
      final flooredFiat = (sellable * rate * 100).floorToDouble() / 100;
      final back = floorToOrderPrecision(flooredFiat / rate, 'usdt');
      expect(back, lessThan(sellable),
          reason: 'if this no longer loses a unit the ceil may be removable, '
              'but verify across rates before doing so');
    });

    test('the round trip lands EXACTLY on the sellable quantity, any rate', () {
      // Ceil alone undershoots at high rates; cap alone overshoots at low
      // ones. At rate 0.37 one kobo is worth MORE than one unit of order
      // precision, so Max's fiat divides back to 29.027 → floors to 29.02
      // against a holding of 29.0198, tripping the over-hold guard. The sheet
      // ceils the fiat AND caps the quantity; both are required.
      double sheetQuantity(double filledFiat, double rate, double sellable) {
        final q = floorToOrderPrecision(filledFiat / rate, 'usdt');
        return (sellable > 0 && q > sellable) ? sellable : q;
      }

      for (final r in [1343.86, 1.0, 0.37, 98765.4321, 1600.0, 0.0001]) {
        for (final qty in [29.0198, 0.9999, 1.0, 123.456789, 7.07]) {
          final sellable = floorToOrderPrecision(qty, 'usdt');
          if (sellable <= 0) continue;
          final filled = (sellable * r * 100).ceilToDouble() / 100;
          final got = sheetQuantity(filled, r, sellable);
          expect(got, sellable,
              reason: 'rate $r, qty $qty: Max round-tripped to $got, not the '
                  'sellable $sellable');
          expect(got, lessThanOrEqualTo(qty + 1e-9),
              reason: 'rate $r, qty $qty: round trip exceeded the holding');
        }
      }
    });

    test('quantising never sells more than the user holds', () {
      for (final qty in [29.0198, 0.004, 1.0, 999.999999]) {
        expect(floorToOrderPrecision(qty, 'usdt'), lessThanOrEqualTo(qty));
      }
    });

    test('quantising loses nothing that could have been sold anyway', () {
      // The remainder is below the exchange's order precision, so it was
      // never sellable. It stays in the wallet — not lost, just not tradable.
      final sellable = floorToOrderPrecision(29.0198, 'usdt');
      final dust = 29.0198 - sellable;
      expect(dust, lessThan(0.01),
          reason: 'anything at or above one unit of precision WAS sellable '
              'and must not be left behind');
      expect(dust, greaterThan(0));
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

    test('the sheet both ceils the Max fiat and caps the quantity', () {
      // The round-trip test above proves the ALGORITHM; this pins the SHEET
      // to it. Without that distinction, deleting the cap from the sheet
      // leaves every arithmetic test passing.
      final code = codeOf(sheet);
      expect(code, contains('ceilToDouble() / 100'),
          reason: 'flooring the Max fiat loses a unit on the round trip at '
              'high rates (29.01 -> 29.00)');
      expect(code, contains('(cap > 0 && q > cap) ? cap : q'),
          reason: 'without the cap, a low rate overshoots the holding '
              '(29.0198 -> 29.02) and the over-hold guard blocks Max');
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
