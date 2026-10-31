import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The dashboard's exchange-rates strip and the exchange screen read the SAME
/// gRPC endpoint and printed DIFFERENT numbers for the same pair. Three
/// separate causes, all of them silent:
///
///   1. DIRECTION. `CountryRateCard` renders "1 USD = ₦1,600", i.e. target→base.
///      The cubit asked for base→target and inverted with `1.0 / rate`. A
///      quoted rate carries a spread, and the reciprocal of a spread-inclusive
///      rate is not the spread-inclusive rate of the opposite pair — it leans
///      the margin the wrong way. Now it asks for the direction it displays.
///
///   2. UNSUPPORTED PAIRS. The strip filtered on `code != base` alone, so it
///      quoted rates for international-only currencies (CAD, PHP) that the
///      provider cannot convert. A rate on the dashboard is an invitation to
///      exchange; quoting one for a pair that would be refused is the defect.
///
///   3. DEAD HARDCODED RATES. `Currency.exchangeRate` held six constants —
///      NGN 411.0, GBP 0.73, EUR 0.85, GHS 6.1, KES 107.0 — years out of date
///      and read by nothing that displays a rate. A stale number sitting on an
///      identity object is a trap for whoever next needs "the rate".
///
/// Source-level assertions: all three are "which call is made / which constant
/// exists", which is a property of the code. A rendering test would need the
/// gRPC stack and would not catch the direction being flipped back.
void main() {
  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
    return f.readAsStringSync();
  }

  String code(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  const cubit =
      'lib/src/features/currency_exchange/presentation/cubit/dashboard_rates_cubit.dart';

  group('the dashboard strip quotes the direction it shows', () {
    test('fetches target -> base, not base -> target', () {
      final src = code(read(cubit));
      expect(
        src.contains('fromCurrency: target.code') &&
            src.contains('toCurrency: _baseCurrency'),
        isTrue,
        reason: 'the fetch direction no longer matches what CountryRateCard '
            'renders ("1 <target> = <baseSymbol><rate>"), so the strip is '
            'quoting the inverse of the figure it prints',
      );
    });

    test('no client-side inversion remains', () {
      final src = code(read(cubit));
      expect(src.contains('1.0 / exchangeRate.rate'), isFalse,
          reason: 'the reciprocal is back. It does not reproduce the '
              'provider\'s quote for the opposite pair, which is exactly how '
              'the two screens came to disagree.');
      expect(src.contains('invertedRate'), isFalse);
    });

    test('a non-positive rate drops the card instead of printing zero', () {
      final src = code(read(cubit));
      expect(src.contains('if (rate <= 0) return;'), isTrue,
          reason: '"1 USD = ₦0.00" reads as a collapsed currency rather than '
              'as missing data');
    });
  });

  test('the strip only quotes pairs the active provider can convert', () {
    final src = code(read(cubit));
    expect(src.contains('c.supportsConversion'), isTrue,
        reason: 'the capability filter is gone, so the dashboard will quote '
            'rates for international-only currencies (CAD, PHP) that cannot '
            'be exchanged — the reported CAD case');
    // The flag has to come from the service on each fetch, not a local list.
    expect(src.contains('getSupportedCurrencies()'), isTrue,
        reason: 'the currency list must come from the exchange service so a '
            'provider change needs no app release');
  });

  group('no hardcoded rates survive', () {
    test('the Currency entity carries no rate field', () {
      final src = code(read(
        'lib/src/features/currency_exchange/domain/entities/currency_entity.dart',
      ));
      expect(src.contains('exchangeRate'), isFalse,
          reason: 'Currency.exchangeRate is back. Nothing that displays a rate '
              'ever read it, and the values it held were years stale — it is '
              'a trap, not a feature. Rates come from '
              'IExchangeRepository.getExchangeRate.');
    });

    test('the static currency catalogue carries no rates', () {
      final src = code(
          read('lib/src/features/currency_exchange/data/currency_data.dart'));
      expect(src.contains('exchangeRate:'), isFalse,
          reason: 'hardcoded rates are back in the static catalogue');
      // The specific stale values, by number, so a reintroduction under a
      // different field name still fails.
      for (final stale in ['411.0', '0.73', '0.85', '6.1', '107.0']) {
        expect(src.contains(stale), isFalse,
            reason: 'the stale constant $stale is back in currency_data.dart');
      }
    });

    test('the catalogue is still the metadata source it should be', () {
      // Removing the rate must not have gutted the file: flags, symbols and
      // names are legitimately static and are what getCurrencyByCode serves.
      final src = read(
          'lib/src/features/currency_exchange/data/currency_data.dart');
      expect(src.contains('symbol:'), isTrue);
      expect(src.contains('flagUrl:'), isTrue);
      expect(src.contains('getCurrencyByCode'), isTrue,
          reason: 'the per-code metadata lookup is what other screens use for '
              'flags and symbols — only the RATE was wrong to keep here');
    });
  });

  test('the history filter comes from the history, not a catalogue', () {
    final src = code(read(
      'lib/src/features/presentation/views/currency_exchange/transaction_history_screen.dart',
    ));
    expect(src.contains('CurrencyData.allCurrencies'), isFalse,
        reason: 'the filter is back on the static catalogue, so it offers '
            'currencies the user never transacted in (each selecting to an '
            'empty list) and can omit ones they did');
    expect(src.contains('for (final t in _allTransactions)'), isTrue,
        reason: 'the filter should derive from the loaded transactions');
  });
}
