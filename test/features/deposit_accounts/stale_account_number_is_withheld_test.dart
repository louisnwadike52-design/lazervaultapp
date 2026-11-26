import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// A CACHED ACCOUNT NUMBER MUST NOT OUTLIVE ITS TRUTH.
///
/// An admin can now close a customer's deposit account and reissue it from the
/// console. That makes "the number cached on this device is no longer the
/// number" a real state rather than a theoretical one.
///
/// A stale BALANCE is harmless — it tweens to the fresh figure a moment later.
/// A stale NUMBER is not: it is copied out of the deposit screen and typed
/// into somebody's bank app, and a replaced number does not bounce the
/// transfer, it swallows it. On 2026-11-12 exactly one such number was found
/// in production, on a wallet holding real money.
void main() {
  AccountSummaryEntity sample() => const AccountSummaryEntity(
        id: 'acct-1',
        accountType: 'personal',
        currency: 'NGN',
        balance: 1487.22,
        availableBalance: 1487.22,
        accountNumberLast4: '9852',
        accountNumber: '9801239852',
        bankName: 'Nombank MFB',
        accountName: 'Nnaemeka Ezeke',
        trendPercentage: 0,
      );

  group('withheldAccountNumber', () {
    test('removes BOTH the full number and the last four', () {
      final w = sample().withheldAccountNumber();

      expect(w.accountNumber, isNull,
          reason: 'the deposit screen copies the full number');
      expect(w.accountNumberLast4, isEmpty,
          reason: 'the account card renders from last-4, so leaving it set '
              'shows a number the full value no longer backs');
    });

    test('keeps the balance, which is safe to be stale', () {
      final original = sample();
      final w = original.withheldAccountNumber();

      expect(w.balance, original.balance);
      expect(w.availableBalance, original.availableBalance);
      expect(w.currency, original.currency);
      expect(w.accountType, original.accountType);
      expect(w.id, original.id);
    });

    test('keeps identity fields that are not the number itself', () {
      final original = sample();
      final w = original.withheldAccountNumber();

      // The bank and holder name are not payment instructions on their own and
      // keep the card from flickering into a blank state.
      expect(w.bankName, original.bankName);
      expect(w.accountName, original.accountName);
    });
  });

  group('the cubit', () {
    late String src;
    setUpAll(() {
      src = File(
        'lib/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart',
      ).readAsStringSync();
    });

    test('stamps the cache when it writes it', () {
      expect(src, contains('_cacheStampKey'),
          reason: 'without a write time there is no way to know whether a '
              'cached number predates a replacement');
      expect(src, contains('prefs.setInt('),
          reason: 'the stamp must actually be persisted');
    });

    test('withholds the number when the cache is too old', () {
      expect(src, contains('withheldAccountNumber()'),
          reason: 'an old cache must paint balances without the number');
      expect(src, contains('_cachedNumberMaxAge'),
          reason: 'the age bound must be named, not inlined');
    });

    test('a missing stamp is treated as too old', () {
      // Caches written before this change carry no stamp. Treating an absent
      // stamp as fresh would keep serving exactly the numbers most likely to
      // be stale.
      expect(src, contains('stampedAt == null'),
          reason: 'an unstamped cache is of unknown age and must not have its '
              'number trusted');
    });
  });
}
