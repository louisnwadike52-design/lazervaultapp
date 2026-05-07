import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';

/// Bottom sheet that handles the member-exit flow end-to-end:
///
///   1. On open, calls PreviewMemberExit to fetch the saga's
///      decision (refund amount, forfeit amount, blocked / allowed,
///      reason label).
///   2. Renders the breakdown — refund, forfeit, "you've already
///      received your payout" — so the user sees exactly what
///      removing them does before they confirm.
///   3. The Confirm CTA dispatches the actual exit RPC and shows
///      the post-saga refund status (completed / pending / failed)
///      in the success snackbar.
///
/// Caller drives auth context via [actorIsSelf]:
///   * true  — member is leaving voluntarily; copy reads "Leave …"
///   * false — admin is removing someone else; copy reads "Remove …"
///
/// On success the sheet pops and the parent screen reloads via the
/// cubit's onStateChanged behaviour. On failure the sheet stays
/// open with the error message so the user can retry / cancel.
class ExitContributionBottomSheet extends StatefulWidget {
  final String contributionId;
  final String groupId;
  final String memberUserId;
  final String memberDisplayName;
  /// True when the current user is exiting themselves; false when an
  /// admin is removing someone else. Drives copy.
  final bool actorIsSelf;

  const ExitContributionBottomSheet({
    super.key,
    required this.contributionId,
    required this.groupId,
    required this.memberUserId,
    required this.memberDisplayName,
    required this.actorIsSelf,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String contributionId,
    required String groupId,
    required String memberUserId,
    required String memberDisplayName,
    required bool actorIsSelf,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: false,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: ExitContributionBottomSheet(
          contributionId: contributionId,
          groupId: groupId,
          memberUserId: memberUserId,
          memberDisplayName: memberDisplayName,
          actorIsSelf: actorIsSelf,
        ),
      ),
    );
  }

  @override
  State<ExitContributionBottomSheet> createState() =>
      _ExitContributionBottomSheetState();
}

class _ExitContributionBottomSheetState
    extends State<ExitContributionBottomSheet> {
  MemberExitPreview? _preview;
  bool _loading = true;
  bool _confirming = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPreview();
  }

  Future<void> _loadPreview() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final cubit = context.read<GroupAccountCubit>();
    final preview = await cubit.previewMemberExitForContribution(
      contributionId: widget.contributionId,
      userId: widget.memberUserId,
    );
    if (!mounted) return;
    if (preview == null) {
      setState(() {
        _error = 'Could not load exit preview. Please try again.';
        _loading = false;
      });
      return;
    }
    setState(() {
      _preview = preview;
      _loading = false;
    });
  }

  Future<void> _confirmExit() async {
    if (_confirming) return;
    setState(() {
      _confirming = true;
      _error = null;
    });
    final cubit = context.read<GroupAccountCubit>();
    final result = await cubit.removeMemberFromContributionAccount(
      contributionId: widget.contributionId,
      groupId: widget.groupId,
      userId: widget.memberUserId,
    );
    if (!mounted) return;
    if (result == null) {
      // Cubit already emitted an error state with the reason; show
      // it inline so the sheet stays useful (the parent screen also
      // surfaces the error via its BlocListener but a duplicate here
      // is the right UX while the modal is the foreground surface).
      setState(() {
        _confirming = false;
        _error = 'Exit failed. Please try again.';
      });
      return;
    }
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _buildHeader(),
            SizedBox(height: 16.h),
            _buildBody(),
            SizedBox(height: 16.h),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final title = widget.actorIsSelf
        ? 'Leave this contribution?'
        : 'Remove ${widget.memberDisplayName}?';
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            widget.actorIsSelf ? Icons.exit_to_app : Icons.person_remove,
            color: const Color(0xFFEF4444),
            size: 20.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.of(context).pop(false),
          icon: Icon(Icons.close, color: Colors.grey[400], size: 20.sp),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.w),
          tooltip: 'Close',
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFF6366F1)),
        ),
      );
    }
    if (_error != null && _preview == null) {
      return _buildErrorState(_error!);
    }
    final p = _preview!;
    if (!p.exitAllowed) {
      return _buildBlockedState(p);
    }
    return _buildAllowedState(p);
  }

  Widget _buildErrorState(String msg) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF7F1D1D).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline,
              color: const Color(0xFFFCA5A5), size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              msg,
              style: GoogleFonts.inter(
                color: const Color(0xFFFEE2E2),
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlockedState(MemberExitPreview p) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
            color: const Color(0xFFFB923C).withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline,
                  color: const Color(0xFFFB923C), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Exit not allowed',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            p.blockedReason.isNotEmpty
                ? p.blockedReason
                : 'This contribution is in a state that does not allow exit.',
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllowedState(MemberExitPreview p) {
    final amountFmt = NumberFormat.currency(
        symbol: p.currency.isNotEmpty ? '${p.currency} ' : '',
        decimalDigits: 2);
    final hasRefund = p.refundAmount > 0;
    final hasForfeit = p.forfeitedAmount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Lead with the human consequence — refund / no-refund — so
        // the user reads the most important fact first.
        if (p.memberHasReceivedPayout)
          _buildInfoRow(
            icon: Icons.check_circle,
            color: const Color(0xFF10B981),
            title: 'Already received payout',
            body:
                'This member already received a payout in this rotation. No refund is owed; their share is settled.',
          )
        else if (hasRefund)
          _buildInfoRow(
            icon: Icons.account_balance_wallet,
            color: const Color(0xFF10B981),
            title: 'Refund: ${amountFmt.format(p.refundAmount)}',
            body: widget.actorIsSelf
                ? 'We\'ll credit this back to your account when you confirm.'
                : 'We\'ll credit this back to ${widget.memberDisplayName}\'s account on confirm.',
          )
        else
          _buildInfoRow(
            icon: Icons.info_outline,
            color: const Color(0xFF9FB3C2),
            title: 'No refund owed',
            body:
                'No payments have been made in the current cycle that can be refunded.',
          ),
        if (hasForfeit) ...[
          SizedBox(height: 10.h),
          _buildInfoRow(
            icon: Icons.history_toggle_off,
            color: const Color(0xFFFB923C),
            title: 'Forfeit: ${amountFmt.format(p.forfeitedAmount)}',
            body:
                'Contributions to past cycles whose payouts already went to other members. These cannot be returned.',
          ),
        ],
        if (p.currentCycle > 0) ...[
          SizedBox(height: 10.h),
          Text(
            'Cycle ${p.currentCycle} is in progress.',
            style: GoogleFonts.inter(
              color: Colors.grey[500],
              fontSize: 11.sp,
            ),
          ),
        ],
        if (_error != null) ...[
          SizedBox(height: 12.h),
          _buildErrorState(_error!),
        ],
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color color,
    required String title,
    required String body,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  body,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 11.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final p = _preview;
    final canConfirm = p != null && p.exitAllowed && !_confirming;
    final confirmLabel = widget.actorIsSelf ? 'Leave' : 'Remove';
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: _confirming
                ? null
                : () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[300],
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: ElevatedButton(
            onPressed: canConfirm ? _confirmExit : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[800],
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
            ),
            child: _confirming
                ? SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    confirmLabel,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
