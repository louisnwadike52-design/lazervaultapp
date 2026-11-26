import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/domain/usecases/get_autosave_rules_usecase.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_cubit.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';

/// What breaks if this bank is unlinked.
///
/// UNLINKING USED TO BE A ONE-LINE "ARE YOU SURE?".
///
/// It named the bank and the last four digits and nothing else, while the
/// unlink itself reaches further than the customer can see: banking-service
/// revokes every direct-debit mandate on the account first (and refuses the
/// whole unlink if it cannot confirm the revocation), and any autosave rule
/// whose `sourceLinkedAccountId` is this account stops being able to run at
/// all — it is funded by PULLING from this bank, so without the link there is
/// nothing to pull from.
///
/// Nothing told the customer that. Production carries the proof: autosave rule
/// `c15644bf` sits `paused` against ALAT by WEMA link `e87a9b11`, and that link
/// has status `unlinked`. The rule looks merely paused — as though resuming it
/// were a tap away — when in fact its funding source is gone.
///
/// So: resolve the attachments BEFORE asking, list them, and let the customer
/// choose with the consequences in front of them.
class BankUnlinkImpact {
  /// Autosave rules funded by this bank that would stop working.
  final List<AutoSaveRuleEntity> autoSaveRules;

  /// The direct-debit mandate on this account, if any. Unlinking revokes it.
  final MandateEntity? mandate;

  /// True when this is the customer's default funding bank.
  final bool isDefault;

  /// Set when we could not read the attachments.
  ///
  /// Deliberately NOT treated as "nothing is attached". An unreadable list is
  /// the one case where proceeding silently is worst: the customer would be
  /// told there is nothing to lose and then lose something. The sheet says so
  /// and still allows the unlink, because refusing on a failed read would make
  /// a network blip able to trap a bank permanently.
  final bool attachmentsUnavailable;

  const BankUnlinkImpact({
    this.autoSaveRules = const [],
    this.mandate,
    this.isDefault = false,
    this.attachmentsUnavailable = false,
  });

  /// Rules that were live, in the sense that the customer expects them to run.
  /// A cancelled or completed rule is history and not worth a warning.
  List<AutoSaveRuleEntity> get liveAutoSaveRules => autoSaveRules
      .where((r) =>
          r.status == AutoSaveStatus.active || r.status == AutoSaveStatus.paused)
      .toList();

  /// Whether the mandate would actually be revoked by this unlink — i.e. the
  /// bank can currently debit, or could again after a reinstate.
  ///
  /// `paused` counts: a paused mandate is how "switched from direct debit to
  /// DirectPay" is stored, and it is still a standing authority at the bank.
  /// banking-service's unlink revokes it explicitly for exactly that reason —
  /// "the customer most likely to unlink is exactly the one whose debit
  /// authority would outlive the account".
  bool get revokesDebitAuthority {
    final m = mandate;
    if (m == null) return false;
    switch (m.status) {
      case MandateStatus.active:
      case MandateStatus.readyToDebit:
      case MandateStatus.authorized:
      case MandateStatus.paused:
        return true;
      case MandateStatus.pending:
      case MandateStatus.awaitingAuthorization:
      case MandateStatus.cancelled:
      case MandateStatus.expired:
      case MandateStatus.rejected:
        return false;
    }
  }

  /// True when the mandate is paused — the "moved to DirectPay" state. Worth
  /// naming separately, because the customer did that on purpose and may not
  /// realise the authority is still there to be revoked.
  bool get mandateIsOnDirectPay => mandate?.status == MandateStatus.paused;

  /// Does the customer need to be shown anything beyond "are you sure"?
  bool get hasConsequences =>
      liveAutoSaveRules.isNotEmpty ||
      revokesDebitAuthority ||
      isDefault ||
      attachmentsUnavailable;
}

/// Reads everything attached to [linkedAccountId].
///
/// Resolved through the service locator rather than from provided cubits: the
/// unlink button exists on the linked-accounts screen AND inside the Lazerbeam
/// transfer flow, and neither of those has an autosave cubit in scope. Asking
/// the locator keeps one implementation for both, so the two cannot drift into
/// warning about different things.
///
/// The autosave read is a network call; the mandate read is the in-memory map
/// MandateCubit already maintains (`getMandateForAccount`), so no extra Mono
/// cost is incurred — a mandate refresh would be a paid provider call and is
/// not worth it to draw a dialog.
Future<BankUnlinkImpact> resolveBankUnlinkImpact({
  required String linkedAccountId,
  required bool isDefault,
}) async {
  MandateEntity? mandate;
  try {
    mandate = serviceLocator<MandateCubit>().getMandateForAccount(linkedAccountId);
  } catch (_) {
    // MandateCubit unregistered in some test/bootstrap paths. A missing cubit
    // is not evidence of a missing mandate, but it is not worth failing the
    // whole sheet for either — the backend revokes regardless.
    mandate = null;
  }

  List<AutoSaveRuleEntity> rules = const [];
  var unavailable = false;
  try {
    final result = await serviceLocator<GetAutoSaveRulesUseCase>()();
    result.fold(
      (_) => unavailable = true,
      (all) => rules = all
          .where((r) => r.sourceLinkedAccountId == linkedAccountId)
          .toList(),
    );
  } catch (_) {
    unavailable = true;
  }

  return BankUnlinkImpact(
    autoSaveRules: rules,
    mandate: mandate,
    isDefault: isDefault,
    attachmentsUnavailable: unavailable,
  );
}
