import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utilities/bank_logo_lookup.dart';

void main() {
  setUp(BankLogoLookup.resetForTest);

  // The index is built from the bank list, but QUERIED with whatever a saved
  // recipient, a receipt or a scanned result happens to store — which is a
  // different spelling of the same bank. These are real pairs: the left is what
  // the live Nomba list returned on 2026-10-06, the right is what other
  // surfaces in the app hold for the same bank.
  test('a bank indexed from the list is found by other surfaces\' spelling', () {
    BankLogoLookup.ingest([
      {'name': 'Zenith Bank', 'code': '057', 'logo_url': 'https://x/zenith'},
      {'name': 'Guaranty Trust Bank', 'code': '058', 'logo_url': 'https://x/gt'},
      {'name': 'Kuda Microfinance Bank', 'code': '090267', 'logo_url': 'https://x/kuda'},
      {'name': 'Paycom (Opay)', 'code': '305', 'logo_url': 'https://x/opay'},
      {'name': 'Moniepoint Bank', 'code': '090405', 'logo_url': 'https://x/moniepoint'},
      {'name': 'United Bank for Africa', 'code': '033', 'logo_url': 'https://x/uba'},
    ]);

    final cases = <String, String>{
      'Zenith bank PLC': 'https://x/zenith',          // saved recipient
      'Zenith Bank': 'https://x/zenith',
      'Guaranty Trust Bank Plc': 'https://x/gt',
      'Kuda Bank': 'https://x/kuda',                  // Flutterwave's spelling
      'Kuda MFB': 'https://x/kuda',
      'Moniepoint Microfinance Bank': 'https://x/moniepoint',
      'United Bank For Africa': 'https://x/uba',      // differing capital F
    };
    cases.forEach((name, want) {
      expect(BankLogoLookup.urlFor(bankName: name), want,
          reason: '$name should resolve to $want');
    });
  });

  // A code lookup is the SECOND attempt and must still work, because some
  // surfaces store a code and a bank label that is really just the code.
  test('falls back to the bank code when the name does not match', () {
    BankLogoLookup.ingest([
      {'name': 'Access Bank', 'code': '044', 'logo_url': 'https://x/access'},
    ]);
    expect(BankLogoLookup.urlFor(bankName: '044', bankCode: '044'),
        'https://x/access');
    expect(BankLogoLookup.urlFor(bankName: 'Something Else', bankCode: '044'),
        'https://x/access');
  });

  // The important negative: a bank we hold nothing for must return null so the
  // widget draws initials. A wrong logo beside a payee is worse than none.
  test('an unknown bank resolves to null', () {
    BankLogoLookup.ingest([
      {'name': 'Access Bank', 'code': '044', 'logo_url': 'https://x/access'},
    ]);
    for (final n in ['Totally Fictional Savings', 'Zzzz Cooperative', '', 'Bank']) {
      expect(BankLogoLookup.urlFor(bankName: n), isNull, reason: n);
    }
  });

  // Distinct banks must not share a key — the same constraint the server-side
  // normaliser is held to.
  test('distinct banks get distinct keys', () {
    const distinct = [
      'Access Bank', 'Zenith Bank', 'First Bank of Nigeria', 'Fidelity Bank',
      'Union Bank of Nigeria', 'Sterling Bank', 'Wema Bank', 'Stanbic IBTC Bank',
      'Ecobank Nigeria', 'Polaris Bank', 'Keystone Bank', 'Unity Bank',
      'Providus Bank', 'Globus Bank', 'Titan Trust Bank', 'Lotus Bank',
      'Suntrust Bank', 'Citibank Nigeria', 'Jaiz Bank', 'TAJ Bank',
      'Kuda Bank', 'PalmPay', 'Moniepoint MFB', 'Paga', 'Carbon', 'Sparkle',
    ];
    final seen = <String, String>{};
    for (final n in distinct) {
      final k = BankLogoLookup.normaliseName(n);
      expect(k, isNotEmpty, reason: '$n normalised to nothing');
      expect(seen.containsKey(k), isFalse,
          reason: '$n collides with ${seen[k]} on key "$k"');
      seen[k] = n;
    }
  });

  // An entry with no logo must not poison the index: storing an empty value
  // would be indistinguishable from "indexed, has none" and would block a
  // later list from filling it.
  test('an entry without a logo does not block a later one', () {
    BankLogoLookup.ingest([{'name': 'Access Bank', 'code': '044'}]);
    expect(BankLogoLookup.urlFor(bankName: 'Access Bank'), isNull);
    BankLogoLookup.ingest([
      {'name': 'Access Bank', 'code': '044', 'logo_url': 'https://x/access'},
    ]);
    expect(BankLogoLookup.urlFor(bankName: 'Access Bank'), 'https://x/access');
  });

  test('the revision notifier fires only when the index actually changes', () {
    final before = BankLogoLookup.revision.value;
    BankLogoLookup.ingest([
      {'name': 'Access Bank', 'code': '044', 'logo_url': 'https://x/access'},
    ]);
    final after = BankLogoLookup.revision.value;
    expect(after, greaterThan(before));
    // Same data again: no repaint should be requested.
    BankLogoLookup.ingest([
      {'name': 'Access Bank', 'code': '044', 'logo_url': 'https://x/access'},
    ]);
    expect(BankLogoLookup.revision.value, after);
  });
}
