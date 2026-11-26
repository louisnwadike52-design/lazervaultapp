import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/helpers/autosave_funding_health.dart';

AutoSaveRuleEntity _rule(TriggerType t, {String linked = 'bank-1'}) {
  final now = DateTime(2026, 11, 8);
  return AutoSaveRuleEntity(
    id: 'r1',
    userId: 'u1',
    name: 'Rent pot',
    description: '',
    triggerType: t,
    amountType: AmountType.fixed,
    amountValue: 5000,
    sourceAccountId: 'wallet',
    destinationAccountId: 'dest',
    status: AutoSaveStatus.active,
    currency: 'NGN',
    sourceLinkedAccountId: linked,
    sourceBankName: 'ALAT by WEMA',
    createdAt: now,
    updatedAt: now,
    triggerCount: 0,
    totalSaved: 0,
  );
}

void main() {
  group('which rules are bank-funded at all', () {
    test('external inflow and scheduled external are', () {
      expect(isBankFundedRule(_rule(TriggerType.externalInflow)), isTrue);
      expect(isBankFundedRule(_rule(TriggerType.scheduledExternal)), isTrue);
    });

    test('wallet-sourced triggers are not, whatever else is set', () {
      // These move money between the customer's own wallets. No bank link is
      // involved, so no bank-link warning may ever appear on them.
      for (final t in [
        TriggerType.onDeposit,
        TriggerType.scheduled,
        TriggerType.roundUp,
      ]) {
        expect(isBankFundedRule(_rule(t)), isFalse, reason: t.name);
      }
    });

    test('a bank trigger with no linked account id is not bank-funded', () {
      // Defensive: a half-written rule must not render a warning about a bank
      // it does not name.
      expect(isBankFundedRule(_rule(TriggerType.externalInflow, linked: '')),
          isFalse);
    });
  });

  group('which problems pre-empt the Direct Debit messaging', () {
    test('every real bank-link problem does', () {
      for (final p in [
        AutosaveFundingProblem.bankMissing,
        AutosaveFundingProblem.bankUnlinked,
        AutosaveFundingProblem.bankNeedsReauth,
        AutosaveFundingProblem.bankInactive,
      ]) {
        expect(p.overridesMandateState, isTrue, reason: p.name);
        expect(p.chipLabel, isNotEmpty,
            reason: '${p.name} overrides the mandate chip, so it must have '
                'something to say in its place');
      }
    });

    test('none and unknown do NOT', () {
      // `unknown` is the cold-start case: the accounts list has not loaded.
      // Treating it as a problem would announce "bank disconnected" on every
      // first build, about the customer's savings.
      for (final p in [
        AutosaveFundingProblem.none,
        AutosaveFundingProblem.unknown,
      ]) {
        expect(p.overridesMandateState, isFalse, reason: p.name);
        expect(p.chipLabel, isEmpty, reason: p.name);
      }
    });
  });

  test('a non-bank rule resolves to none without touching the locator', () {
    // No DI is registered in this test; a wallet rule must short-circuit
    // before it would ask for OpenBankingCubit.
    expect(resolveAutosaveFundingProblem(_rule(TriggerType.scheduled)),
        AutosaveFundingProblem.none);
  });

  test('an unregistered locator reads as unknown, never as a problem', () {
    expect(resolveAutosaveFundingProblem(_rule(TriggerType.externalInflow)),
        AutosaveFundingProblem.unknown);
  });
}
