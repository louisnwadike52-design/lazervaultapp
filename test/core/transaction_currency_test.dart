import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/config/country_config.dart';

// The bug: a GBP wallet's recent transactions on the dashboard rendered with a
// naira sign, while the same rows on "View all" rendered correctly.
//
// Two causes, both pinned here.
//
// 1. The FALLBACK. The repository resolved a row's currency as
//    `activeAccountSnapshot()?.currency ?? 'NGN'`. That helper is synchronous
//    and answers null until AccountCardsSummaryCubit has loaded — its own doc
//    says to use the sync form "only where null degrades harmlessly". Here
//    null became NGN. The dashboard maps rows WHILE those summaries are still
//    loading; "View all" is reached after, which is exactly why one surface
//    was wrong and the other right. The currency is now resolved once per
//    page, awaiting the summaries, and passed into the mapper.
//
// 2. The SYMBOL. Three transaction widgets plus the model each carried
//    `currency == 'NGN' ? '₦' : currency == 'USD' ? '$' : currency`, which
//    knew two currencies and printed the bare CODE for the rest — so even
//    with the right currency a GBP row read "GBP1500.00".

void main() {
  group('currency symbols come from the country table', () {
    test('every currency we operate in resolves to its real symbol', () {
      const expected = <String, String>{
        'NGN': '₦',
        'GBP': '£',
        'USD': r'$',
        'GHS': 'GH₵',
        'KES': 'KSh',
        'ZAR': 'R',
        'CAD': r'C$',
        'PHP': '₱',
      };
      expected.forEach((code, symbol) {
        expect(CountryConfigs.symbolForCurrency(code), symbol,
            reason: '$code must not render as its bare code');
      });
    });

    test('GBP never renders as naira or dollars', () {
      // The two ways this actually went wrong: the NGN default, and
      // open-banking withdrawals which used `'₦' : '\$'` so every non-naira
      // currency became dollars.
      final gbp = CountryConfigs.symbolForCurrency('GBP');
      expect(gbp, isNot('₦'));
      expect(gbp, isNot(r'$'));
      expect(gbp, '£');
    });

    test('case and whitespace do not defeat the lookup', () {
      for (final v in ['gbp', ' GBP ', 'Gbp']) {
        expect(CountryConfigs.symbolForCurrency(v), '£',
            reason: 'a currency arriving as "$v" still means pounds');
      }
    });

    test('an unsupported currency falls back to its code, not a guess', () {
      // A bare correct code beats a confident wrong symbol on a money amount.
      expect(CountryConfigs.symbolForCurrency('XOF'), 'XOF');
      expect(CountryConfigs.symbolForCurrency('JPY'), 'JPY');
    });

    test('an absent currency renders nothing rather than a default symbol', () {
      // Prefixing an amount with ₦ because the currency was missing is how
      // the original bug looked to the user.
      expect(CountryConfigs.symbolForCurrency(null), '');
      expect(CountryConfigs.symbolForCurrency(''), '');
      expect(CountryConfigs.symbolForCurrency('   '), '');
    });
  });
}
