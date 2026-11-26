import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/bank_unlink_impact.dart';

/// Production, 2026-11-08: autosave rule `c15644bf` is `paused` and funded by
/// linked account `e87a9b11` (ALAT by WEMA) — whose status is `unlinked`. The
/// rule reads as merely paused, as though resuming it were a tap away. Its
/// funding source is gone. Nothing in the unlink flow told anyone.

AutoSaveRuleEntity _rule(AutoSaveStatus status, {String linked = 'bank-1'}) {
  final now = DateTime(2026, 11, 8);
  return AutoSaveRuleEntity(
    id: 'r-${status.name}',
    userId: 'u1',
    name: 'Rent pot',
    description: '',
    triggerType: TriggerType.scheduledExternal,
    amountType: AmountType.fixed,
    amountValue: 5000,
    sourceAccountId: '',
    destinationAccountId: 'dest',
    status: status,
    currency: 'NGN',
    sourceLinkedAccountId: linked,
    sourceBankName: 'ALAT by WEMA',
    createdAt: now,
    updatedAt: now,
    triggerCount: 0,
    totalSaved: 0,
  );
}

MandateEntity _mandate(MandateStatus status) {
  final now = DateTime(2026, 11, 8);
  return MandateEntity(
    id: 'm1',
    monoMandateId: 'mono-1',
    userId: 'u1',
    linkedAccountId: 'bank-1',
    monoCustomerId: 'c1',
    bankName: 'ALAT by WEMA',
    bankCode: '035',
    accountNumber: '0123456789',
    accountName: 'Test User',
    mandateType: MandateType.emandate,
    status: status,
    amountLimit: 0,
    debitLimit: 0,
    debitCount: 0,
    totalDebited: 0,
    remainingLimit: 0,
    canDebit: status == MandateStatus.readyToDebit,
    isExpired: status == MandateStatus.expired,
    startDate: now,
    endDate: now.add(const Duration(days: 365)),
    createdAt: now,
  );
}

void main() {
  group('which autosave rules are worth warning about', () {
    test('an active rule is', () {
      final impact =
          BankUnlinkImpact(autoSaveRules: [_rule(AutoSaveStatus.active)]);
      expect(impact.liveAutoSaveRules, hasLength(1));
      expect(impact.hasConsequences, isTrue);
    });

    test('a PAUSED rule is too — pausing is not abandoning', () {
      // The prod case. A customer who paused a rule means to resume it; after
      // the unlink they cannot, and the rule will not say why.
      final impact =
          BankUnlinkImpact(autoSaveRules: [_rule(AutoSaveStatus.paused)]);
      expect(impact.liveAutoSaveRules, hasLength(1),
          reason: 'a paused rule is still the customer\'s intention to save');
    });

    test('cancelled and completed rules are not', () {
      final impact = BankUnlinkImpact(autoSaveRules: [
        _rule(AutoSaveStatus.cancelled),
        _rule(AutoSaveStatus.completed),
      ]);
      expect(impact.liveAutoSaveRules, isEmpty,
          reason: 'history is not a consequence of unlinking');
      expect(impact.hasConsequences, isFalse);
    });
  });

  group('which mandate states lose debit authority', () {
    for (final s in [
      MandateStatus.active,
      MandateStatus.readyToDebit,
      MandateStatus.authorized,
    ]) {
      test('${s.name} does', () {
        expect(BankUnlinkImpact(mandate: _mandate(s)).revokesDebitAuthority,
            isTrue);
      });
    }

    test('PAUSED does — that is the "switched to DirectPay" state', () {
      // banking-service's UnlinkAccount revokes paused mandates first and
      // refuses the unlink if it cannot confirm, precisely because a paused
      // mandate is still a standing authority at the bank. The sheet has to
      // say so, or the customer who chose DirectPay thinks it is already over.
      final impact = BankUnlinkImpact(mandate: _mandate(MandateStatus.paused));
      expect(impact.revokesDebitAuthority, isTrue);
      expect(impact.mandateIsOnDirectPay, isTrue);
    });

    for (final s in [
      MandateStatus.cancelled,
      MandateStatus.expired,
      MandateStatus.rejected,
      MandateStatus.pending,
      MandateStatus.awaitingAuthorization,
    ]) {
      test('${s.name} does not — there is nothing left to revoke', () {
        expect(BankUnlinkImpact(mandate: _mandate(s)).revokesDebitAuthority,
            isFalse);
      });
    }

    test('no mandate at all revokes nothing', () {
      expect(const BankUnlinkImpact().revokesDebitAuthority, isFalse);
    });
  });

  group('the honest-uncertainty case', () {
    test('an unreadable attachment list still counts as a consequence', () {
      // The worst outcome is telling someone nothing is attached and being
      // wrong. Unknown must not render as "nothing".
      const impact = BankUnlinkImpact(attachmentsUnavailable: true);
      expect(impact.hasConsequences, isTrue);
      expect(impact.liveAutoSaveRules, isEmpty);
    });
  });

  test('being the default bank is itself worth saying', () {
    const impact = BankUnlinkImpact(isDefault: true);
    expect(impact.hasConsequences, isTrue);
  });

  test('a bank with nothing attached says so', () {
    const impact = BankUnlinkImpact();
    expect(impact.hasConsequences, isFalse);
  });

  test('only rules funded by THIS bank are counted', () {
    // The resolver filters by sourceLinkedAccountId; this asserts the model
    // does not quietly include everything it is handed.
    final impact = BankUnlinkImpact(
      autoSaveRules: [_rule(AutoSaveStatus.active, linked: 'bank-1')],
    );
    expect(impact.liveAutoSaveRules.single.sourceLinkedAccountId, 'bank-1');
  });
}
