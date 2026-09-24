import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

/// When the server REFUSES an action and explains why.
///
/// A refusal is not a failure. "This user is already at the 3 Family & Friends
/// accounts limit" is the server telling the user something true about their
/// situation that they have to understand and act on — and it was being delivered
/// in a three-second red snackbar, which truncates a sentence that length,
/// dismisses itself before it can be read, and offers nothing to do next.
///
/// A failure ("couldn't reach the server") is different in kind: not the user's
/// fault, and often fixed by trying again — but it still belongs here rather than
/// in a snackbar, for a reason specific to money flows. A refusal can truthfully
/// say "nothing was changed". A failure CANNOT: a dropped response is
/// indistinguishable from a rejected request, so the honest message has to tell
/// the user how to check what actually happened, and that does not fit a flash.
///
/// Hence the two tones. Both stay put until dismissed, scroll a long message
/// rather than clipping it, and can carry the one action that resolves the
/// situation — but a rule that says no is amber, and a breakage is red.
///
/// Success confirmations are still snackbars. Nothing to read, nothing to decide.
enum ServerRefusalTone {
  /// A business rule said no. The user can usually do something about it.
  refusal,

  /// Something went wrong that the user did not cause. Offer a retry.
  failure,
}

/// True while a refusal sheet is on screen.
///
/// Every caller is a BlocListener, and a cubit re-emitting the same error state —
/// a rebuild, a failed retry, two screens listening to one cubit — would open a
/// second sheet on top of the first. The user then has to dismiss the same message
/// twice, and the one underneath looks like the app got stuck.
///
/// A module-level flag rather than per-call state, because the sheets stack
/// globally: the guard has to be the same one for every caller.
bool _sheetIsOpen = false;

/// The context of the sheet currently believed to be open.
///
/// The flag alone is not safe. `showModalBottomSheet`'s future completes when the
/// sheet is POPPED — so if the tree it lives in is torn down another way (the host
/// screen popped underneath it, a stack replacement, a logout) that future never
/// completes, the `finally` below never runs, and the flag stays set for the rest
/// of the session: every subsequent refusal silently does nothing.
///
/// Caught by the tests, which are exactly that scenario — a test that leaves the
/// sheet up ends by discarding the tree, and every later test then saw no sheet.
///
/// So the flag is cross-checked against whether that context is still mounted,
/// which makes the guard self-healing rather than something that can leak shut.
BuildContext? _openSheetContext;

/// Shows the refusal sheet. Returns true when the user tapped the action.
///
/// [message] is the SERVER'S own words. It is deliberately not replaced with
/// generic copy: the server knows whether the limit is three accounts or five,
/// and which of them is full, and that specificity is the entire value of the
/// message. It is only sanitised for raw transport noise.
Future<bool> showServerRefusal(
  BuildContext context, {
  required String title,
  required String message,
  ServerRefusalTone tone = ServerRefusalTone.refusal,
  String? actionLabel,
  VoidCallback? onAction,
  String dismissLabel = 'Got it',
  String? hint,
}) async {
  if (_sheetIsOpen) {
    final open = _openSheetContext;
    // null  → a sheet is opening but has not built yet (two emits in one frame):
    //         still a duplicate, drop it.
    // mounted → genuinely on screen: drop it, the user is reading it.
    if (open == null || open.mounted) return false;
    // Unmounted: the tree went away without the sheet being popped. The flag is
    // stale, not a live sheet — clear it and show this one.
    _sheetIsOpen = false;
    _openSheetContext = null;
  }
  _sheetIsOpen = true;
  try {
    return await _present(
      context,
      title: title,
      message: message,
      tone: tone,
      actionLabel: actionLabel,
      onAction: onAction,
      dismissLabel: dismissLabel,
      hint: hint,
    );
  } finally {
    // In a finally so a throw from the sheet route cannot leave the guard set.
    // This is the normal path; the mounted check above is the backstop for the
    // case where this never runs at all.
    _sheetIsOpen = false;
    _openSheetContext = null;
  }
}

Future<bool> _present(
  BuildContext context, {
  required String title,
  required String message,
  required ServerRefusalTone tone,
  required String dismissLabel,
  String? actionLabel,
  VoidCallback? onAction,
  String? hint,
}) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    // Dismissible: this is information, not a decision that must be made. A
    // barrier-locked sheet on an error is a trap.
    isDismissible: true,
    builder: (sheetContext) {
      // Recorded so the guard above can tell a live sheet from a stale flag.
      // Assigned on every build, not just the first, so it always refers to a
      // context that is currently in the tree.
      _openSheetContext = sheetContext;
      return _ServerRefusalSheet(
        title: title,
        message: message,
        tone: tone,
        actionLabel: actionLabel,
        onAction: onAction,
        dismissLabel: dismissLabel,
        hint: hint,
      );
    },
  );
  return result ?? false;
}

class _ServerRefusalSheet extends StatelessWidget {
  const _ServerRefusalSheet({
    required this.title,
    required this.message,
    required this.tone,
    required this.dismissLabel,
    this.actionLabel,
    this.onAction,
    this.hint,
  });

  final String title;
  final String message;
  final ServerRefusalTone tone;
  final String dismissLabel;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? hint;

  static const _bg = Color(0xFF121218);
  static const _border = Color(0xFF26262F);
  static const _muted = Color(0xFF9A9AAE);

  Color get _accent => tone == ServerRefusalTone.refusal
      // Amber, not red: a rule that says no is not an error, and red trains
      // people to read every refusal as something broken.
      ? const Color(0xFFF59E0B)
      : const Color(0xFFEF4444);

  IconData get _icon => tone == ServerRefusalTone.refusal
      ? Icons.info_outline_rounded
      : Icons.error_outline_rounded;

  @override
  Widget build(BuildContext context) {
    final body = sanitizeUserFacingError(message).trim();

    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        border: Border.all(color: _border),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: _accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(_icon, color: _accent, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            // Scrolls rather than clips. The messages this sheet exists for are
            // full sentences, sometimes two, and a snackbar ate the end of them.
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 260.h),
              child: SingleChildScrollView(
                child: Text(
                  // Never empty: sanitizeUserFacingError substitutes its own
                  // line for a blank or technical message, so there is no
                  // "blank sheet" case to guard against here.
                  body,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            if ((hint ?? '').trim().isNotEmpty) ...[
              SizedBox(height: 14.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: _border),
                ),
                child: Text(
                  hint!.trim(),
                  style: TextStyle(
                    color: _muted,
                    fontSize: 12.5.sp,
                    height: 1.45,
                  ),
                ),
              ),
            ],
            SizedBox(height: 18.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: _border),
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      dismissLabel,
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (actionLabel != null && onAction != null) ...[
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Pop FIRST, then act. Running the action while the sheet
                        // is still mounted has the callback navigate underneath
                        // it, which strands the sheet over the new screen.
                        Navigator.of(context).pop(true);
                        onAction!();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        actionLabel!,
                        style: TextStyle(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// True when a server message is a business-rule REFUSAL rather than a transient
/// failure — i.e. when it belongs in the sheet instead of a snackbar.
///
/// Matched on the server's own vocabulary rather than on gRPC codes, because the
/// codes are not reliably distinct here: accounts-service returns
/// FailedPrecondition for both "you are at your limit" and "the pool account is
/// still being provisioned", and only the message separates them.
bool looksLikeServerRefusal(String message) {
  final m = message.toLowerCase();
  const markers = <String>[
    'limit',
    'maximum',
    'already',
    'not allowed',
    'only the creator',
    'permission',
    'cannot ',
    'must be',
    'requires',
    'insufficient',
    'exceed',
    'at capacity',
    'no longer',
    'not eligible',
    'already exists',
  ];
  return markers.any(m.contains);
}
