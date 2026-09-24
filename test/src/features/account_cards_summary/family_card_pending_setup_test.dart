import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// Why a finished family account kept saying "Pending setup".
///
/// Reported from a device: after creating a second Family & Friends account, the
/// card offered to set it up again, and tapping it opened the activation flow
/// for an account that was already activated.
///
/// The carousel derived the state as:
///
///     isFamilyPendingSetup || !account.isFamilyAccount
///
/// The second clause is the bug. A family-typed VIRTUAL account surfaces in the
/// REGULAR accounts list before the family-entity mapping catches up, and in
/// that window `isFamilyAccount` is false while `familyStatus` already says
/// "active". So the card believed a flag about where the row came from over the
/// server's own statement about what state the account is in.
///
/// The derivation lives inline in a 2,000-line carousel widget whose family
/// branch needs an AccountManager stream, a GetX router and a live cubit to
/// reach, so the guard here is on the SOURCE plus the entity-level truth the
/// derivation is supposed to respect. What matters is that the discarded clause
/// cannot come back: its only symptom is a working account inviting you to
/// recreate it, which reads as a backend problem and sends you looking in the
/// wrong place.
void main() {
  group('familyStatus is the authority on pending setup', () {
    test('an active account is not pending setup, whatever its mapping says',
        () {
      const mappedLate = AccountSummaryEntity(
        id: 'acct-1',
        accountType: 'family',
        accountNumberLast4: '3493',
        trendPercentage: 0,
        balance: 5000,
        currency: 'NGN',
        // The window that caused the bug: status says active, the family-entity
        // mapping has not landed yet.
        isFamilyAccount: false,
        familyAccountId: 'fam-1',
        familyStatus: 'active',
      );
      expect(mappedLate.isFamilyPendingSetup, isFalse);
    });

    test('pending_setup is pending setup', () {
      const pending = AccountSummaryEntity(
        id: 'acct-2',
        accountType: 'family',
        accountNumberLast4: '3494',
        trendPercentage: 0,
        balance: 0,
        currency: 'NGN',
        isFamilyAccount: true,
        familyAccountId: 'fam-2',
        familyStatus: 'pending_setup',
      );
      expect(pending.isFamilyPendingSetup, isTrue);
    });

    test('a frozen account is not pending setup either', () {
      const frozen = AccountSummaryEntity(
        id: 'acct-3',
        accountType: 'family',
        accountNumberLast4: '3495',
        trendPercentage: 0,
        balance: 100,
        currency: 'NGN',
        isFamilyAccount: true,
        familyAccountId: 'fam-3',
        familyStatus: 'frozen',
      );
      expect(frozen.isFamilyPendingSetup, isFalse);
      // Frozen rides the same field, so the two states must stay distinct.
      expect(frozen.isFrozen, isTrue);
    });
  });

  group('the carousel derivation', () {
    late String source;

    setUpAll(() {
      final file = File(
        'lib/src/features/account_cards_summary/presentation/widgets/'
        'account_carousel.dart',
      );
      expect(file.existsSync(), isTrue,
          reason: 'account_carousel.dart moved — update this test');
      source = file.readAsStringSync();
    });

    test('no longer treats a missing family mapping as needing setup', () {
      expect(
        source.contains(
            'account.isFamilyPendingSetup || !account.isFamilyAccount'),
        isFalse,
        reason: 'this is the clause that put "Pending setup" on accounts that '
            'had just been created — familyStatus already said active',
      );
    });

    test('reads familyStatus directly, and only falls back when it is absent',
        () {
      expect(source, contains("familyStatusRaw == 'pending_setup'"),
          reason: 'the server states the status; the card must use it');
      // The fallback is still needed for rows that carry no status at all, but
      // it must require BOTH no mapping and no family id — otherwise it is the
      // old bug with extra steps.
      expect(
        source,
        contains("(account.familyAccountId ?? '').trim().isEmpty"),
        reason: 'a family-typed account that already has a family id is a '
            'mapping gap, not an account waiting to be created',
      );
    });

    test('the family card is no longer navy-on-navy', () {
      // The reported symptom was "the theme there is a little bit too dark" —
      // 0xFF1A1A3E → 0xFF2D2B6B is two dark tones with no lift between them,
      // beside a business card that runs violet-700 → violet-950.
      expect(source.contains('Color(0xFF1A1A3E), Color(0xFF2D2B6B)'), isFalse,
          reason:
              'the flat dark gradient is what made the card read as a slab');
      expect(source, contains('Color(0xFF4F46E5)'),
          reason: 'indigo-600 gives the card the same brightness as the '
              'business card while staying tellable apart from it');
    });
  });
}
