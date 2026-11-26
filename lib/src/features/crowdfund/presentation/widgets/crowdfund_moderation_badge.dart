import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/crowdfund_moderation.dart';

/// THE MODERATION BADGE — what the platform has decided, shown where it
/// matters.
///
/// ## Separate from [CrowdfundStatusBadge] on purpose
///
/// That one draws the LIFECYCLE: active, completed, cancelled. This draws the
/// platform's verdict, and the two are independent — a campaign can be active
/// and blocked at the same time. Merging them would mean inventing a combined
/// vocabulary in which "blocked" competes with "completed" for one pill, and
/// a creator whose finished campaign was later restricted would see one fact
/// and not the other.
///
/// ## Who sees which
///
/// RESTRICTED is the only one a donor sees, and it is meant to be seen: the
/// platform allows the campaign but does not recommend it, and a donor who
/// reads the badge and gives anyway is making an informed choice.
///
/// BLOCKED and UNDER REVIEW only ever appear on the CREATOR'S own view,
/// because only the creator receives those states from the backend at all —
/// a blocked campaign is absent from every public list, so there is nothing
/// to badge.
///
/// APPROVED draws NOTHING. A badge on every campaign saying "this is fine"
/// is noise that teaches people to stop reading badges.
class CrowdfundModerationBadge extends StatelessWidget {
  const CrowdfundModerationBadge({
    super.key,
    required this.moderation,
    this.compact = false,
  });

  final CrowdfundModeration moderation;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final visual = _visualFor(context, moderation.status);
    if (visual == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: (compact ? 6 : 8).w,
        vertical: (compact ? 2 : 3).h,
      ),
      decoration: BoxDecoration(
        color: visual.background,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: visual.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(visual.emoji, style: TextStyle(fontSize: (compact ? 9 : 10).sp)),
          SizedBox(width: 4.w),
          Text(
            visual.label,
            style: TextStyle(
              color: visual.foreground,
              fontSize: (compact ? 9 : 10).sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  _ModerationVisual? _visualFor(
      BuildContext context, CrowdfundModerationState state) {
    final scheme = Theme.of(context).colorScheme;
    switch (state) {
      case CrowdfundModerationState.approved:
        // Nothing. See the class comment.
        return null;
      case CrowdfundModerationState.restricted:
        return _ModerationVisual(
          // "Not endorsed" rather than "restricted": the user-facing word has
          // to describe what it means for the READER, and "restricted" sounds
          // like the campaign has been punished rather than that we are not
          // recommending it.
          label: 'Not endorsed',
          emoji: '⚠️',
          foreground: const Color(0xFFB26A00),
          background: const Color(0x14FFA000),
          border: const Color(0x33FFA000),
        );
      case CrowdfundModerationState.pending:
      case CrowdfundModerationState.escalated:
        return _ModerationVisual(
          // ONE WORD FOR BOTH, deliberately. The difference between "the
          // model has not answered" and "a person is looking at it" is ours,
          // not the creator's — to them it is the same wait, and naming the
          // distinction would invite a question about which is faster.
          label: 'Under review',
          emoji: '🕒',
          foreground: scheme.onSurfaceVariant,
          background: scheme.surfaceContainerHighest,
          border: scheme.outlineVariant,
        );
      case CrowdfundModerationState.blocked:
        return _ModerationVisual(
          label: 'Not published',
          emoji: '🚫',
          foreground: scheme.error,
          background: scheme.error.withValues(alpha: 0.08),
          border: scheme.error.withValues(alpha: 0.24),
        );
    }
  }
}

class _ModerationVisual {
  const _ModerationVisual({
    required this.label,
    required this.emoji,
    required this.foreground,
    required this.background,
    required this.border,
  });

  final String label;
  final String emoji;
  final Color foreground;
  final Color background;
  final Color border;
}
