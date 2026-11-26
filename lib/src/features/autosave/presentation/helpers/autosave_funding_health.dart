import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';

/// Why a bank-funded autosave rule cannot pull.
///
/// ONE DECISION, TWO SURFACES. The rule-details banner and the list card both
/// warn about autosave funding, and both used to reason only about the Direct
/// Debit mandate. Neither considered that the BANK ITSELF might be gone, so
/// both would tell a customer to "Re-authorize Direct Debit" on an account
/// that is no longer linked — an instruction with nowhere to carry it out.
///
/// Production: autosave rule `c15644bf` is `paused` and funded by linked
/// account `e87a9b11` (ALAT by WEMA), whose status is `unlinked`.
///
/// Keeping the decision here rather than in each widget is the point: two
/// copies of this logic is how one of them ends up saying the wrong thing
/// after the next change.
enum AutosaveFundingProblem {
  /// The link is healthy, or this is not a bank-funded rule. Carry on to the
  /// mandate checks.
  none,

  /// Nothing is known yet (accounts not loaded). Claim nothing.
  unknown,

  /// The account is not in the list at all — unlinked and dropped.
  bankMissing,

  /// Explicitly `unlinked`.
  bankUnlinked,

  /// Parked for re-authorisation. banking-service puts an account here when it
  /// could not CONFIRM an unlink with Mono — "account parked for
  /// re-authorisation rather than marked unlinked". Not usable as-is.
  bankNeedsReauth,

  /// Inactive for some other reason.
  bankInactive,
}

extension AutosaveFundingProblemX on AutosaveFundingProblem {
  /// True when this problem should PRE-EMPT any mandate messaging.
  bool get overridesMandateState =>
      this != AutosaveFundingProblem.none &&
      this != AutosaveFundingProblem.unknown;

  /// Short label for a list chip. Kept to a few words — the full explanation
  /// lives on the rule-details banner.
  String get chipLabel {
    switch (this) {
      case AutosaveFundingProblem.bankMissing:
        return 'Bank no longer linked';
      case AutosaveFundingProblem.bankUnlinked:
        return 'Bank disconnected';
      case AutosaveFundingProblem.bankNeedsReauth:
      case AutosaveFundingProblem.bankInactive:
        return 'Reconnect bank';
      case AutosaveFundingProblem.none:
      case AutosaveFundingProblem.unknown:
        return '';
    }
  }
}

/// True for the two trigger types that fund themselves by pulling from a
/// linked bank. Every other trigger moves money between wallets and is
/// unaffected by any of this.
bool isBankFundedRule(AutoSaveRuleEntity rule) =>
    (rule.triggerType == TriggerType.externalInflow ||
        rule.triggerType == TriggerType.scheduledExternal) &&
    rule.sourceLinkedAccountId.isNotEmpty;

/// Resolves the funding problem for [rule] from the shared OpenBankingCubit.
///
/// An EMPTY account list reads as [AutosaveFundingProblem.unknown], not as
/// "the bank is gone": the cubit is a lazy singleton whose list is populated
/// by whichever surface loaded first, and announcing a disconnection on every
/// cold build would be a false alarm on the customer's savings.
AutosaveFundingProblem resolveAutosaveFundingProblem(AutoSaveRuleEntity rule) {
  if (!isBankFundedRule(rule)) return AutosaveFundingProblem.none;

  List<LinkedBankAccount> accounts;
  try {
    accounts = serviceLocator<OpenBankingCubit>().linkedAccounts;
  } catch (_) {
    return AutosaveFundingProblem.unknown;
  }
  if (accounts.isEmpty) return AutosaveFundingProblem.unknown;

  for (final a in accounts) {
    if (a.id != rule.sourceLinkedAccountId) continue;
    switch (a.status) {
      case LinkedAccountStatus.active:
        return AutosaveFundingProblem.none;
      case LinkedAccountStatus.unlinked:
        return AutosaveFundingProblem.bankUnlinked;
      case LinkedAccountStatus.reauthorize:
        return AutosaveFundingProblem.bankNeedsReauth;
      case LinkedAccountStatus.inactive:
        return AutosaveFundingProblem.bankInactive;
    }
  }
  return AutosaveFundingProblem.bankMissing;
}

/// Finds the linked account backing [rule], or null.
LinkedBankAccount? linkedAccountForRule(AutoSaveRuleEntity rule) {
  try {
    for (final a in serviceLocator<OpenBankingCubit>().linkedAccounts) {
      if (a.id == rule.sourceLinkedAccountId) return a;
    }
  } catch (_) {
    return null;
  }
  return null;
}
