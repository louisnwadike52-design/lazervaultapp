import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utilities/bank_name_resolver.dart';

/// The bank list is real: these are the spellings and CODES the live Nomba
/// rail returned on 2026-10-06, including its decoys. The codes matter —
/// Flutterwave publishes different ones for every fintech, so resolving
/// against the wrong list produces a declined transfer.
const _liveBanks = <Map<String, String>>[
  {'name': 'GTBank', 'code': '058'},
  {'name': 'Zenith Bank', 'code': '057'},
  {'name': 'Access Bank', 'code': '044'},
  {'name': 'Access Bank (Diamond)', 'code': '063'},
  {'name': 'First Bank of Nigeria', 'code': '011'},
  {'name': 'United Bank for Africa', 'code': '033'},
  {'name': 'Paycom (Opay)', 'code': '305'},
  {'name': 'Palmpay', 'code': '100033'},
  {'name': 'Moniepoint Bank', 'code': '090405'},
  {'name': 'Kuda Microfinance Bank', 'code': '090267'},
  {'name': 'Sterling Bank Plc', 'code': '232'},
  {'name': 'First City Monument Bank', 'code': '214'},
  {'name': 'Stanbic IBTC Bank', 'code': '039'},
  {'name': 'Wema Bank', 'code': '035'},
  {'name': 'Ecobank Nigeria', 'code': '050'},
  {'name': 'Fidelity Bank', 'code': '070'},
  {'name': 'Jaiz Bank', 'code': '301'},
  {'name': 'Providus Bank', 'code': '101'},
  {'name': 'Taj Bank', 'code': '000026'},
  {'name': 'Parallex MF Bank', 'code': '000030'},
  {'name': 'Sparkle', 'code': '090325'},
  {'name': 'VFD Microfinance Bank Limited', 'code': '566'},
  {'name': 'Carbon', 'code': '100026'},
  {'name': 'Paga', 'code': '327'},
  {'name': 'Polaris Bank', 'code': '076'},
  // Decoys — each won a wrong match under the previous matcher.
  {'name': 'Trust Microfinance Bank', 'code': '090327'},
  {'name': 'Citizen Trust Microfinance Bank', 'code': '090076'},
  {'name': 'Capricon Digital', 'code': '956'},
  {'name': 'Yello Digital Services', 'code': '100028'},
  {'name': 'First Multiple MFB', 'code': '090163'},
];

void main() {
  test('every common scanned spelling resolves confidently to the right code', () {
    const expected = <String, String>{
      'GTBank': '058', 'GTB': '058', 'gtb': '058',
      'Guaranty Trust Bank': '058', 'GT Bank': '058', 'GTCO': '058',
      'Zenith Bank': '057', 'Zenith': '057', 'ZENITH BANK PLC': '057',
      'Access Bank Plc': '044', 'access': '044',
      'First Bank': '011', 'FBN': '011', 'FirstBank': '011',
      'UBA': '033', 'United Bank for Africa': '033',
      'Opay': '305', 'OPay Digital Services': '305', 'O-Pay': '305',
      'Palmpay': '100033', 'Palm Pay': '100033',
      'Moniepoint MFB': '090405', 'Moniepoint Microfinance Bank': '090405',
      'MoneyPoint': '090405', // a real OCR misread
      'Kuda': '090267', 'Kuda Bank': '090267',
      'Sterling Bank': '232',
      'FCMB': '214', 'First City Monument Bank': '214',
      'Stanbic IBTC': '039', 'IBTC': '039',
      'Wema Bank': '035', 'ALAT': '035',
      'Ecobank': '050', 'Fidelity Bank': '070', 'Jaiz Bank': '301',
      'Providus': '101', 'Taj Bank': '000026', 'Parallex Bank': '000030',
      'Sparkle': '090325', 'VFD': '566', 'Carbon': '100026', 'Paga': '327',
      'Polaris Bank': '076',
    };
    final failures = <String>[];
    expected.forEach((scanned, wantCode) {
      final r = BankNameResolver.resolve(scanned, _liveBanks);
      final best = r.best;
      if (best == null) {
        failures.add('$scanned: no match at all');
      } else if (best.code != wantCode) {
        failures.add('$scanned: got ${best.name}/${best.code}, want $wantCode');
      } else if (!best.isConfident) {
        failures.add('$scanned: matched ${best.name} only at tier ${best.tier}');
      }
    });
    expect(failures, isEmpty, reason: failures.join('\n'));
  });

  test('a shared generic word never decides a bank', () {
    // The failure that mattered: "Guaranty Trust Bank" resolved to "Trust
    // Microfinance Bank" on the single word "trust".
    final gt = BankNameResolver.resolve('Guaranty Trust Bank', _liveBanks).best;
    expect(gt?.code, '058');

    for (final scanned in ['Trust', 'Digital Services', 'First', 'United']) {
      final r = BankNameResolver.resolve(scanned, _liveBanks);
      final confident = r.alternatives.where((m) => m.isConfident).toList();
      expect(confident, isEmpty,
          reason: '$scanned confidently resolved to '
              '${confident.isEmpty ? "" : confident.first.name}');
    }
  });

  test('an unreadable bank yields no confident match', () {
    for (final scanned in ['', '   ', 'Bank', 'Bank PLC', 'Microfinance Bank',
      'Totally Fictional Savings And Loans', 'xyzzy']) {
      final r = BankNameResolver.resolve(scanned, _liveBanks);
      expect(r.best == null || !r.best!.isConfident, isTrue,
          reason: '$scanned confidently resolved to ${r.best?.name}');
    }
  });

  test('alternatives are offered so the picker can suggest', () {
    final r = BankNameResolver.resolve('Access', _liveBanks);
    final names = r.alternatives.map((m) => m.name).toList();
    expect(names, contains('Access Bank'));
    // Both Access rows are plausible; the user must be able to see the other.
    expect(names, contains('Access Bank (Diamond)'));
  });

  test('codes come from the supplied list, not a hardcoded map', () {
    const flutterwave = <Map<String, String>>[
      {'name': 'Kuda Bank', 'code': '50211'},
      {'name': 'OPay Digital Services Limited (OPay)', 'code': '999992'},
      {'name': 'Moniepoint MFB', 'code': '50515'},
    ];
    expect(BankNameResolver.resolve('Kuda', flutterwave).best?.code, '50211');
    expect(BankNameResolver.resolve('Opay', flutterwave).best?.code, '999992');
    expect(BankNameResolver.resolve('Moniepoint', flutterwave).best?.code, '50515');

    const nomba = <Map<String, String>>[
      {'name': 'Kuda Microfinance Bank', 'code': '090267'},
      {'name': 'Paycom (Opay)', 'code': '305'},
      {'name': 'Moniepoint Bank', 'code': '090405'},
    ];
    expect(BankNameResolver.resolve('Kuda', nomba).best?.code, '090267');
    expect(BankNameResolver.resolve('Opay', nomba).best?.code, '305');
    expect(BankNameResolver.resolve('Moniepoint', nomba).best?.code, '090405');
  });

  test('an empty bank list is not an error', () {
    expect(BankNameResolver.resolve('GTBank', const []).best, isNull);
    expect(BankNameResolver.rank('GTBank', const []), isEmpty);
  });

  test('distinct banks get distinct keys', () {
    const distinct = [
      'Access Bank', 'Zenith Bank', 'First Bank of Nigeria', 'Fidelity Bank',
      'Union Bank of Nigeria', 'Sterling Bank', 'Stanbic IBTC Bank',
      'Ecobank Nigeria', 'Polaris Bank', 'Keystone Bank', 'Unity Bank',
      'Providus Bank', 'Globus Bank', 'Titan Trust Bank', 'Lotus Bank',
      'Suntrust Bank', 'Citibank Nigeria', 'Jaiz Bank', 'TAJ Bank',
      'PalmPay', 'Paga', 'Carbon', 'Sparkle', 'VFD Microfinance Bank',
    ];
    final seen = <String, String>{};
    for (final n in distinct) {
      final k = BankNameResolver.normalise(n);
      expect(k, isNotEmpty, reason: '$n normalised to nothing');
      expect(seen.containsKey(k), isFalse,
          reason: '$n collides with ${seen[k]} on key "$k"');
      seen[k] = n;
    }
  });
}
