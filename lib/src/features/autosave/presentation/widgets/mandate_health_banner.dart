import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_cubit.dart';
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
          body:
              'Your bank is confirming your authorization — this can take up '
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
    // null / expired / cancelled / rejected — needs a fresh authorization.
    return const _BannerCopy(
      title: 'Re-authorize Direct Debit',
      body:
          'The Direct Debit for this bank is no longer active, so automatic saves '
          'can\'t run. Set it up again to resume.',
      cta: 'Re-authorize Direct Debit',
    );
  }

  Widget _banner(BuildContext context, _BannerCopy copy, MandateEntity? mandate) {
    final accent = copy.info ? const Color(0xFF3B82F6) : const Color(0xFFFB923C);
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
              onPressed: () => _openReauthSheet(context, mandate),
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

  Future<void> _openReauthSheet(
      BuildContext context, MandateEntity? mandate) async {
    final bank = rule.sourceBankName.isNotEmpty ? rule.sourceBankName : 'Linked bank';
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

class _BannerCopy {
  final String title;
  final String body;
  final String cta;
  final bool info;
  const _BannerCopy({
    required this.title,
    required this.body,
    required this.cta,
    this.info = false,
  });
}
