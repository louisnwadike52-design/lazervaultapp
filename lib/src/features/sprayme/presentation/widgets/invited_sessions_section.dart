import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/session_invite.dart';

/// Celebrations you have been tagged into.
///
/// Before this, the only way to learn a session existed was for the host to
/// send you its six-character code out of band — so people were tagged into
/// nothing, and hosts paid for live rooms their friends never found.
///
/// Sits directly under the funds card and above your own sessions: an
/// invitation is time-limited in a way your own session history is not, and the
/// live ones stop being joinable when the host ends the party.
class InvitedSessionsSection extends StatelessWidget {
  const InvitedSessionsSection({
    super.key,
    required this.invites,
    required this.onJoin,
    required this.onDismiss,
  });

  final List<InvitedSession> invites;
  final void Function(InvitedSession) onJoin;
  final void Function(InvitedSession) onDismiss;

  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _accent = Color(0xFFD946EF);

  @override
  Widget build(BuildContext context) {
    // Nothing to show is the normal state for most people most of the time. An
    // empty "You're invited" card would be a standing reminder that nobody has
    // invited you anywhere.
    if (invites.isEmpty) return const SizedBox.shrink();

    // Live invitations first — those are the ones that can still be acted on.
    final live = invites.where((i) => i.session.isActive).toList();
    final past = invites.where((i) => !i.session.isActive).toList();
    final ordered = [...live, ...past.take(3)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "You're invited",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (live.isNotEmpty) ...[
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: _accent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '${live.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 12.h),
        for (final i in ordered) ...[
          _tile(context, i),
          SizedBox(height: 10.h),
        ],
      ],
    );
  }

  Widget _tile(BuildContext context, InvitedSession i) {
    final live = i.session.isActive;
    final joinable = i.isActionable;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: live ? _accent.withValues(alpha: 0.35) : _border,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.celebration_outlined,
                color: _accent, size: 21.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  i.session.title.isEmpty
                      ? 'Lazerspray celebration'
                      : i.session.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  // Names who tagged you. An invitation from nobody in
                  // particular is the kind of thing people assume is spam.
                  i.inviterName.isEmpty
                      ? 'You were tagged'
                      : '${i.inviterName} tagged you',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
                if (!live) ...[
                  SizedBox(height: 4.h),
                  Text(
                    // Said plainly rather than hiding the row: a session you
                    // remember being tagged into vanishing without explanation
                    // is worse than being told it finished.
                    'This celebration has ended',
                    style: TextStyle(
                      color: const Color(0xFF6B7280),
                      fontSize: 11.5.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 8.w),
          if (joinable)
            ElevatedButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                onJoin(i);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: Colors.white,
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('Join', style: TextStyle(fontSize: 13.sp)),
            )
          else
            IconButton(
              tooltip: 'Dismiss',
              onPressed: () {
                HapticFeedback.selectionClick();
                onDismiss(i);
              },
              icon: Icon(Icons.close_rounded,
                  color: const Color(0xFF6B7280), size: 18.sp),
            ),
        ],
      ),
    );
  }
}
