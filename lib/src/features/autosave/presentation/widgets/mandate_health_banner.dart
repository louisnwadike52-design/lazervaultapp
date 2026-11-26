import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/helpers/autosave_funding_health.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_cubit.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/open_banking/presentation/helpers/account_reauth_helper.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/domain/entities/linked_bank_account.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_state.dart';
import 'package:lazervault/src/features/move_money/domain/entities/mandate_entity.dart';
import 'package:lazervault/src/features/move_money/domain/mandate_auth_attempt_store.dart';
import 'package:lazervault/src/features/move_money/presentation/widgets/mandate_management_bottomsheet.dart';

/// Warning banner shown on a linked-bank autosave rule (bank inflow) when the
/// Direct Debit mandate that powers the pull is NOT in a debitable state.
///
/// Why this exists: a linked-bank rule can only be CREATED with a live mandate,
/// but the mandate can lapse afterwards (the user revokes it, it expires, it's
/// paused, or NIBSS deactivates it). At scheduled-fire time no human is present,
/// so the pull fails and the save silently stops. This banner surfaces that
/// state the next time the user opens the rule and gives them a one-tap path to
/// re-authorize — reusing the same mandate-management sheet the deposit flow
/// uses. Renders nothing for wallet-sourced rules or while the mandate status
/// is still unknown (so it never false-alarms before the fetch completes).
class MandateHealthBanner extends StatelessWidget {
  final AutoSaveRuleEntity rule;
  final String userId;

  const MandateHealthBanner({
    super.key,
    required this.rule,
    required this.userId,
  });

  bool get _isLinkedBankRule =>
      (rule.triggerType == TriggerType.externalInflow ||
          rule.triggerType == TriggerType.scheduledExternal) &&
      rule.sourceLinkedAccountId.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (!_isLinkedBankRule) return const SizedBox.shrink();

    // Fire-and-forget, idempotent — makes the local auth-attempt stamps
    // available to _copyFor even when autosave is the first mandate surface
    // opened after an app restart.
    MandateAuthAttemptStore.hydrate();
    // THE BANK LINK IS CHECKED FIRST, AND IT WINS.
    //
    // Every branch below this point assumes the linked bank still exists —
    // they all end in "authorize / re-authorize the Direct Debit", which is
    // an instruction you cannot carry out on an account that is no longer
    // linked. There is no mandate to fix, and the management sheet has
    // nothing to open.
    //
    // Production carries the case: autosave rule `c15644bf` sits `paused`
    // against ALAT by WEMA link `e87a9b11`, whose status is `unlinked`. The
    // banner would have told that customer to re-authorize a Direct Debit on
    // a bank that is gone, and the only honest first step — reconnect the
    // bank — was never offered.
    //
    // `reauthorize` is in here deliberately as well: banking-service parks an
    // account in that state when it could NOT confirm an unlink with Mono
    // ("UNLINK NOT CONFIRMED at Mono — account parked for re-authorisation").
    // Such an account is not usable as-is either.
    final linkBanner = _linkHealthCopy();
    if (linkBanner != null) return _banner(context, linkBanner, null);

    final cubit = serviceLocator<MandateCubit>();
    return BlocBuilder<MandateCubit, MandateState>(
      bloc: cubit,
      builder: (context, state) {
        // Only decide once a fetch/action has produced mandate data — never
        // flash a warning before we actually know the status.
        final known = state is UserMandatesLoaded ||
            state is MandateCreated ||
            state is MandatePaused ||
            state is MandateReinstated ||
            state is MandateCancelled;
        if (!known) return const SizedBox.shrink();

        final mandate = cubit.getMandateForAccount(rule.sourceLinkedAccountId);
        if (mandate != null && mandate.isActive) return const SizedBox.shrink();

        final copy = _copyFor(mandate);
        return _banner(context, copy, mandate);
      },
    );
  }

  /// The bank-link problem to report, or null when the link is healthy
  /// (or not yet known, in which case nothing is claimed).
  ///
  /// Reads the OpenBankingCubit singleton's already-loaded list rather than
  /// fetching: it is the same shared instance the linked-banks screen and the
  /// deposit flow populate, so by the time a rule is on screen it is warm. An
  /// EMPTY list is treated as "not loaded yet" rather than "the bank is gone",
  /// because the alternative is telling a customer their bank was disconnected
  /// every time this widget builds before the first fetch lands.
  _BannerCopy? _linkHealthCopy() {
    final problem = resolveAutosaveFundingProblem(rule);
    if (!problem.overridesMandateState) return null;

    final bankName = rule.sourceBankName.trim().isEmpty
        ? 'this bank'
        : rule.sourceBankName.trim();

    switch (problem) {
      case AutosaveFundingProblem.bankMissing:
        // Not in the list at all: unlinked and dropped. There is nothing to
        // reconnect in place, so the honest action is to point the rule at a
        // bank that exists.
        return _BannerCopy(
          title: 'This bank is no longer linked',
          body: '$bankName was removed, so this automatic save has nothing to '
              'pull from and cannot run. Link the bank again, or edit this '
              'rule to save from a different one.',
          cta: 'Link a bank',
          action: _BannerAction.linkBank,
        );
      case AutosaveFundingProblem.bankUnlinked:
        return _BannerCopy(
          title: 'This bank was disconnected',
          body: '$bankName is no longer connected, so this automatic save '
              'cannot pull from it. Reconnect it to start saving again — your '
              'Direct Debit has to be authorised again too.',
          cta: 'Reconnect bank',
          action: _BannerAction.reconnectBank,
        );
      case AutosaveFundingProblem.bankNeedsReauth:
        return _BannerCopy(
          title: 'Reconnect $bankName',
          body: 'Your connection to $bankName needs renewing before this '
              'automatic save can run again. It takes about a minute.',
          cta: 'Reconnect bank',
          action: _BannerAction.reconnectBank,
        );
      case AutosaveFundingProblem.bankInactive:
        return _BannerCopy(
          title: 'This bank connection is inactive',
          body: '$bankName is not currently usable for automatic saves. '
              'Reconnect it to resume.',
          cta: 'Reconnect bank',
          action: _BannerAction.reconnectBank,
        );
      case AutosaveFundingProblem.none:
      case AutosaveFundingProblem.unknown:
        return null;
    }
  }

  _BannerCopy _copyFor(MandateEntity? mandate) {
    // Activating (user authorized, NIBSS finishing) — informational, not an error.
    if (mandate != null && mandate.isActivating) {
      return const _BannerCopy(
        title: 'Direct Debit is activating',
        body:
            'Your bank is finalizing the Direct Debit. Automatic saves will resume '
            'once it\'s active (this can take up to 24 hours).',
        cta: 'View status',
        info: true,
      );
    }
    if (mandate != null && mandate.isPaused) {
      return const _BannerCopy(
        title: 'Direct Debit is paused',
        body:
            'Automatic saves from this bank are paused. Resume Direct Debit to '
            'start pulling again.',
        cta: 'Resume Direct Debit',
      );
    }
    if (mandate != null && mandate.awaitingUserAuthorization) {
      // Auth widget opened recently (this or any device): the payment leg is
      // likely done and the bank is confirming — informational, no CTA into
      // the spent Mono link.
      if (mandate.authAttemptedRecently ||
          MandateAuthAttemptStore.openedRecently(mandate.id)) {
        return const _BannerCopy(
          title: 'Direct Debit is setting up',
          body: 'Your bank is confirming your authorization. This can take up '
              'to 30 minutes and completes automatically.',
          cta: 'View status',
          info: true,
        );
      }
      return const _BannerCopy(
        title: 'Finish setting up Direct Debit',
        body:
            'This automatic save can\'t run until you authorize the Direct Debit '
            'with your bank.',
        cta: 'Authorize Direct Debit',
      );
    }
    // Terminal (expired / cancelled / rejected) or absent.
    //
    // "Re-" only if there was ever a working mandate to go back to. A setup
    // abandoned at the bank reaches these same statuses, and in production
    // that is in fact the ONLY way they are reached, so the unqualified
    // "no longer active" told every user they had lost something they never
    // had. A null mandate keeps the re-authorize wording: nothing is loaded
    // to prove otherwise, and that branch is reached from surfaces that
    // already know a mandate once existed.
    if (mandate != null && !mandate.everAuthorized) {
      return const _BannerCopy(
        title: 'Finish setting up Direct Debit',
        body:
            'Direct Debit for this bank was never finished, so automatic saves '
            'can\'t run yet. Authorize once with your bank to complete it.',
        cta: 'Authorize Direct Debit',
      );
    }
    return const _BannerCopy(
      title: 'Re-authorize Direct Debit',
      body:
          'The Direct Debit for this bank is no longer active, so automatic saves '
          'can\'t run. Set it up again to resume.',
      cta: 'Re-authorize Direct Debit',
    );
  }

  Widget _banner(
      BuildContext context, _BannerCopy copy, MandateEntity? mandate) {
    final accent =
        copy.info ? const Color(0xFF3B82F6) : const Color(0xFFFB923C);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                copy.info
                    ? Icons.hourglass_top_rounded
                    : Icons.warning_amber_rounded,
                color: accent,
                size: 20.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  copy.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            copy.body,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              height: 1.45,
            ),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _onCta(context, copy, mandate),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                copy.cta,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onCta(
      BuildContext context, _BannerCopy copy, MandateEntity? mandate) async {
    switch (copy.action) {
      case _BannerAction.manageMandate:
        return _openReauthSheet(context, mandate);
      case _BannerAction.reconnectBank:
        return _reconnectBank(context);
      case _BannerAction.linkBank:
        return _linkABank(context);
    }
  }

  /// Reconnect the SPECIFIC account this rule is funded by.
  ///
  /// Uses the shared reauthorisation helper the linked-banks screen uses, so
  /// the Mono session, the fee notice and the KYC gate behave identically
  /// wherever a reconnection starts from.
  Future<void> _reconnectBank(BuildContext context) async {
    List<LinkedBankAccount> accounts;
    try {
      accounts = serviceLocator<OpenBankingCubit>().linkedAccounts;
    } catch (_) {
      return _linkABank(context);
    }
    for (final a in accounts) {
      if (a.id == rule.sourceLinkedAccountId) {
        await startAccountReauthorization(context, a);
        if (userId.isNotEmpty) {
          serviceLocator<MandateCubit>().fetchUserMandates(userId: userId);
        }
        return;
      }
    }
    // Vanished between render and tap — fall through to linking rather than
    // doing nothing.
    if (context.mounted) await _linkABank(context);
  }

  /// No account to reconnect: send them where a new bank is linked.
  Future<void> _linkABank(BuildContext context) async {
    await Get.toNamed(AppRoutes.linkedBanks);
  }

  Future<void> _openReauthSheet(
      BuildContext context, MandateEntity? mandate) async {
    final bank =
        rule.sourceBankName.isNotEmpty ? rule.sourceBankName : 'Linked bank';
    await showMandateManagementBottomSheet(
      context: context,
      linkedAccountId: rule.sourceLinkedAccountId,
      userId: userId,
      bankName: bank,
      accountName: bank,
      mandate: mandate,
    );
    // Refresh mandate state so the banner updates (or disappears) once the
    // sheet closes.
    if (userId.isNotEmpty) {
      serviceLocator<MandateCubit>().fetchUserMandates(userId: userId);
    }
  }
}

/// What the CTA should actually do.
///
/// The banner used to send EVERY CTA into the mandate-management sheet,
/// because every banner was about a mandate. Once the bank-link states joined
/// it that stopped being true: "Reconnect bank" opening a Direct Debit sheet
/// for a bank that is no longer linked is a dead end, and the customer has no
/// way to tell that the button was simply pointed at the wrong thing.
enum _BannerAction { manageMandate, reconnectBank, linkBank }

class _BannerCopy {
  final String title;
  final String body;
  final String cta;
  final bool info;
  final _BannerAction action;
  const _BannerCopy({
    required this.title,
    required this.body,
    required this.cta,
    this.info = false,
    this.action = _BannerAction.manageMandate,
  });
}
