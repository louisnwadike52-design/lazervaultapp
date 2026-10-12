import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Copy / 👍 / 👎 under an assistant answer.
///
/// WHY THE VERDICT IS A TOGGLE, NOT A PRESS
/// ----------------------------------------
/// Tapping the thumb you already gave RETRACTS it. A rating widget that can
/// only ever add a vote quietly makes its own data useless: a user who
/// mis-taps has no way back, and every accidental press lands in the
/// training set as a real opinion. The retraction reaches the server as
/// `verdict: none`, which deletes the row rather than storing a third state.
///
/// Exactly one verdict can be active, so pressing the opposite thumb moves
/// the vote rather than casting a second one.
///
/// The row is deliberately quiet — small, low-contrast, no labels — because
/// it sits under every single answer. It should be findable when wanted and
/// invisible when not.
enum ChatFeedbackVerdict { none, up, down }

class ChatResponseActions extends StatelessWidget {
  /// The answer text, for the copy button.
  final String responseText;

  /// What this viewer has already voted, so a reopened conversation shows
  /// the thumb they pressed instead of a blank row inviting a second vote.
  final ChatFeedbackVerdict verdict;

  /// Called with the NEW verdict. Passing [ChatFeedbackVerdict.none] means
  /// the user un-toggled and the stored vote should be deleted.
  final ValueChanged<ChatFeedbackVerdict> onVerdict;

  /// Null disables the thumbs entirely — used where there is no session to
  /// attribute a vote to, so we never collect a rating we cannot store.
  final bool canRate;

  const ChatResponseActions({
    super.key,
    required this.responseText,
    required this.verdict,
    required this.onVerdict,
    this.canRate = true,
  });

  @override
  Widget build(BuildContext context) {
    if (responseText.trim().isEmpty) return const SizedBox.shrink();
    final muted = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withValues(alpha: 0.45)
        : Colors.black.withValues(alpha: 0.42);
    const active = Color(0xFF8B5CF6);

    return Padding(
      padding: EdgeInsets.only(left: 6.w, top: 2.h, bottom: 2.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _IconAction(
            icon: Icons.copy_rounded,
            tooltip: 'Copy',
            color: muted,
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: responseText));
              if (!context.mounted) return;
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                const SnackBar(
                  content: Text('Copied'),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          if (canRate) ...[
            _IconAction(
              icon: verdict == ChatFeedbackVerdict.up
                  ? Icons.thumb_up_rounded
                  : Icons.thumb_up_outlined,
              tooltip: verdict == ChatFeedbackVerdict.up
                  ? 'Remove your rating'
                  : 'Good answer',
              color: verdict == ChatFeedbackVerdict.up ? active : muted,
              onTap: () => onVerdict(verdict == ChatFeedbackVerdict.up
                  ? ChatFeedbackVerdict.none
                  : ChatFeedbackVerdict.up),
            ),
            _IconAction(
              icon: verdict == ChatFeedbackVerdict.down
                  ? Icons.thumb_down_rounded
                  : Icons.thumb_down_outlined,
              tooltip: verdict == ChatFeedbackVerdict.down
                  ? 'Remove your rating'
                  : 'Poor answer',
              color: verdict == ChatFeedbackVerdict.down ? active : muted,
              onTap: () => onVerdict(verdict == ChatFeedbackVerdict.down
                  ? ChatFeedbackVerdict.none
                  : ChatFeedbackVerdict.down),
            ),
          ],
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  const _IconAction({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        // A 16sp glyph is below the 48dp minimum on its own, so the padding
        // is the tap target rather than decoration.
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Icon(icon, size: 16.sp, color: color),
        ),
      ),
    );
  }
}
