import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/user_tag_entity.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';

/// The two non-payment ways a pending tag can be closed.
///
/// Cancel belongs to the TAGGER (withdrawing a demand they raised); decline
/// belongs to the TAGGED USER (refusing one raised against them). The server
/// enforces both, plus pending-only; this enum only decides the copy.
enum TagLifecycleAction { cancel, decline }

extension TagLifecycleActionCopy on TagLifecycleAction {
  String get label =>
      this == TagLifecycleAction.cancel ? 'Cancel Tag' : 'Decline';

  String get dialogTitle =>
      this == TagLifecycleAction.cancel ? 'Cancel Tag?' : 'Decline Tag?';

  String get confirmLabel =>
      this == TagLifecycleAction.cancel ? 'Cancel Tag' : 'Decline';

  IconData get icon => this == TagLifecycleAction.cancel
      ? Icons.block_outlined
      : Icons.do_not_disturb_on_outlined;
}

const Color _destructive = Color(0xFFEF4444);
const Color _surface = Color(0xFF1F1F1F);
const Color _field = Color(0xFF2D2D2D);
const Color _muted = Color(0xFF9CA3AF);
const Color _hint = Color(0xFF6B7280);

/// The server caps `reason` at 280 characters and answers InvalidArgument past
/// that, so the field must not let the user write a request that can only fail.
const int kTagLifecycleReasonMaxLength = 280;

/// Confirmation for cancelling or declining a tag, mirroring the split-bill
/// decline dialog (irreversible action + optional free-text reason).
///
/// Returns null if the user backed out. Returns the trimmed reason otherwise —
/// an empty string when they confirmed without typing one.
Future<String?> showTagLifecycleConfirmDialog({
  required BuildContext context,
  required TagLifecycleAction action,
  required UserTagEntity tag,
}) async {
  final reasonController = TextEditingController();
  final isCancel = action == TagLifecycleAction.cancel;
  final counterparty = isCancel
      ? (tag.taggedUserName.isNotEmpty
          ? tag.taggedUserName
          : '@${tag.taggedUserTagPay}')
      : (tag.taggerName.isNotEmpty ? tag.taggerName : '@${tag.taggerTagPay}');

  try {
    return await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: _surface,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          action.dialogTitle,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isCancel
                  ? 'Withdraw your ${tag.formattedAmount} tag on $counterparty? '
                      'They will no longer be able to pay it, and this cannot be undone.'
                  : 'Refuse the ${tag.formattedAmount} tag from $counterparty? '
                      'You will no longer be able to pay it, and this cannot be undone.',
              style: GoogleFonts.inter(color: _muted, fontSize: 14.sp),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: reasonController,
              maxLength: kTagLifecycleReasonMaxLength,
              maxLines: 2,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Reason (optional)',
                hintStyle: GoogleFonts.inter(color: _hint, fontSize: 14.sp),
                counterStyle: GoogleFonts.inter(color: _hint, fontSize: 11.sp),
                filled: true,
                fillColor: _field,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Go Back',
              style: GoogleFonts.inter(color: _muted, fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, reasonController.text.trim()),
            child: Text(
              action.confirmLabel,
              style: GoogleFonts.inter(
                color: _destructive,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  } finally {
    reasonController.dispose();
  }
}

/// Colour + icon for every status the backend can send, including the three
/// that used to have no wire representation and so fell through to PENDING.
(Color, IconData) tagStatusChipStyle(TagStatus status) {
  switch (status) {
    case TagStatus.pending:
      return (const Color(0xFFFB923C), Icons.access_time);
    case TagStatus.paying:
      return (const Color(0xFF60A5FA), Icons.sync);
    case TagStatus.paid:
      return (const Color(0xFF10B981), Icons.check_circle);
    case TagStatus.cancelled:
      return (_destructive, Icons.cancel);
    case TagStatus.declined:
      return (_destructive, Icons.do_not_disturb_on_outlined);
    case TagStatus.expired:
      return (_muted, Icons.history_toggle_off);
    case TagStatus.unknown:
      return (_muted, Icons.help_outline);
  }
}

/// Says, in place of a Pay button, why this tag cannot be paid.
///
/// A tag can close between a list being drawn and the payment screen opening —
/// the tagger cancels it, it lapses, or a transfer is already in flight — and
/// every one of those used to render as an open, payable demand.
class TagUnpayableNotice extends StatelessWidget {
  final UserTagEntity tag;

  const TagUnpayableNotice({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final isPaying = tag.isPaying;
    final color = isPaying ? const Color(0xFF60A5FA) : _muted;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(
            isPaying ? Icons.sync : Icons.lock_outline,
            size: 20.sp,
            color: color,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              isPaying
                  ? 'A payment for this tag is already being processed. No '
                      'action is needed right now.'
                  : 'This tag is ${tag.statusLabel.toLowerCase()} and can no '
                      'longer be paid.',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The destructive outlined button that raises [showTagLifecycleConfirmDialog].
///
/// Rendered only for a tag that is still pending — a tag whose transfer is in
/// flight, or that is already closed, has nothing left to cancel or decline.
class TagLifecycleButton extends StatelessWidget {
  final TagLifecycleAction action;
  final VoidCallback? onPressed;
  final bool isBusy;

  const TagLifecycleButton({
    super.key,
    required this.action,
    required this.onPressed,
    this.isBusy = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: isBusy ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: _destructive,
        side: BorderSide(
          color: isBusy ? _hint : _destructive,
          width: 1.5,
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      icon: Icon(
        action.icon,
        size: 18.sp,
        color: isBusy ? _hint : _destructive,
      ),
      label: Text(
        action.label,
        style: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: isBusy ? _hint : _destructive,
        ),
      ),
    );
  }
}

/// Decline + Pay (incoming) or Cancel (outgoing) for a tag that is still
/// pending, with the confirmation, the dispatch and the result feedback owned
/// in one place so each host only decides where to put it.
///
/// Renders nothing at all once the tag is not pending: paying means a transfer
/// is already in flight, and paid/cancelled/declined/expired are closed.
///
/// Expects a [TagPayCubit] of its OWN above it. Sharing the host's cubit would
/// make the host's error listener and this one both answer the same failure.
class TagLifecycleActionRow extends StatefulWidget {
  final UserTagEntity tag;

  /// True when the signed-in user raised this tag (Cancel), false when it was
  /// raised against them (Decline).
  final bool isOutgoing;

  /// The host's Pay affordance, shown beside Decline. Null for an outgoing tag,
  /// which its own tagger never pays.
  final VoidCallback? onPay;

  /// Called after the server confirms the tag is closed.
  final void Function(TagLifecycleSuccess result) onClosed;

  const TagLifecycleActionRow({
    super.key,
    required this.tag,
    required this.isOutgoing,
    required this.onClosed,
    this.onPay,
  });

  @override
  State<TagLifecycleActionRow> createState() => _TagLifecycleActionRowState();
}

class _TagLifecycleActionRowState extends State<TagLifecycleActionRow> {
  bool _isSubmitting = false;

  TagLifecycleAction get _action => widget.isOutgoing
      ? TagLifecycleAction.cancel
      : TagLifecycleAction.decline;

  Future<void> _submit() async {
    if (_isSubmitting) return;

    final reason = await showTagLifecycleConfirmDialog(
      context: context,
      action: _action,
      tag: widget.tag,
    );
    // null means the user backed out; '' means they confirmed without a reason.
    if (reason == null || !mounted) return;

    setState(() => _isSubmitting = true);

    final cubit = context.read<TagPayCubit>();
    final trimmed = reason.isNotEmpty ? reason : null;
    if (_action == TagLifecycleAction.cancel) {
      await cubit.cancelTag(tagId: widget.tag.id, reason: trimmed);
    } else {
      await cubit.declineTag(tagId: widget.tag.id, reason: trimmed);
    }
  }

  void _onState(BuildContext context, TagPayState state) {
    if (state is TagLifecycleSuccess) {
      if (mounted) setState(() => _isSubmitting = false);
      widget.onClosed(state);
      Get.snackbar(
        'Success',
        state.message,
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else if (state is TagPayError) {
      if (mounted) setState(() => _isSubmitting = false);
      Get.snackbar(
        'Error',
        state.message,
        backgroundColor: _destructive,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.tag.isPending) return const SizedBox.shrink();

    final button = TagLifecycleButton(
      action: _action,
      isBusy: _isSubmitting,
      onPressed: _submit,
    );

    return BlocListener<TagPayCubit, TagPayState>(
      listener: _onState,
      child: widget.onPay == null
          ? SizedBox(width: double.infinity, child: button)
          : Row(
              children: [
                Expanded(child: button),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : widget.onPay,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      disabledBackgroundColor:
                          const Color(0xFF10B981).withValues(alpha: 0.5),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    icon: Icon(Icons.payment, size: 20.sp, color: Colors.white),
                    label: Text(
                      'Pay Now',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
