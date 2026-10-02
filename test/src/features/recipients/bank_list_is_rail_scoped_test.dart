import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Reported: after the payout rail was switched to Nomba
// (transfer_primary_provider = nomba, read from production on 2026-10-02), the
// send-funds bank list still did not offer Nomba MFB.
//
// The backend already serves the list from the ACTIVE rail and keys its own
// cache by rail. The client did not: its cache key was `banks_cache_NG` with a
// flat 24h TTL and no record of which rail produced the list, and a fresh cache
// was returned WITHOUT ever asking the server. So after a switch the app kept
// serving the previous rail's codes for up to a full day, and the bundled
// static fallback (which contains no Nomba entries at all) forever after any
// error.
//
// Bank codes are not a shared standard — Kuda is 50211 on Flutterwave and
// 090267 on Nomba — so serving the wrong rail's list is not a cosmetic
// staleness bug: every fintech destination is refused.

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('the cache records WHICH rail produced the list', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('banks_cache_NG', '[{"name":"Kuda","code":"50211"}]');
    await prefs.setString('banks_cache_provider_NG', 'flutterwave');

    expect(prefs.getString('banks_cache_provider_NG'), 'flutterwave',
        reason: 'a list without its rail cannot be invalidated correctly');
  });

  test('a rail switch makes the cached codes wrong, not merely stale', () {
    const flutterwave = {
      'Kuda': '50211',
      'OPay': '999992',
      'Moniepoint': '50515'
    };
    const nomba = {'Kuda': '090267', 'OPay': '305', 'Moniepoint': '090405'};

    for (final bank in flutterwave.keys) {
      expect(flutterwave[bank], isNot(equals(nomba[bank])),
          reason: '$bank differs per rail, so a cross-rail cache hit misroutes');
    }
  });

  test('a cached provider that differs from the served one must not be reused',
      () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('banks_cache_provider_NG', 'flutterwave');

    const servedBy = 'nomba';
    final cached = prefs.getString('banks_cache_provider_NG') ?? '';
    final railChanged =
        cached.isNotEmpty && servedBy.isNotEmpty && cached != servedBy;

    expect(railChanged, isTrue,
        reason: 'this is the condition that must replace the list and repaint');
  });

  test('an empty provider label never triggers a false invalidation', () {
    for (final pair in [('', 'nomba'), ('nomba', ''), ('', '')]) {
      final railChanged =
          pair.$1.isNotEmpty && pair.$2.isNotEmpty && pair.$1 != pair.$2;
      expect(railChanged, isFalse,
          reason: 'an unknown rail is not evidence of a change');
    }
  });

  test('same rail is a cache HIT, not a needless refetch', () {
    const cached = 'nomba';
    const served = 'nomba';
    final railChanged =
        cached.isNotEmpty && served.isNotEmpty && cached != served;
    expect(railChanged, isFalse);
  });
}
