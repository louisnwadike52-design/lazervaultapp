import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/contribution_round_state.dart';

/// THE END OF A ROUND IS A DECISION, NOT AN ENDING.
///
/// A round is one full pass through the members: three members, three cycles.
/// When the agreed cycles have all run the circle has nothing scheduled, and
/// it stays that way until its creator says what happens next — go round
/// again, or close it. Before this banner existed there was no way to say
/// either, so a circle that finished simply stopped and looked broken.
///
/// WHY MEMBERS SEE IT TOO, WITHOUT THE BUTTONS. The person whose turn is
/// coming in a second round, and the person waiting to be told the circle is
/// over, both need to know which it is. Showing the explanation to everyone
/// and the buttons only to the creator is the same split the stalled-rotation
/// banner uses.
///
/// WHY A REFUSAL IS SHOWN HERE RATHER THAN IN A SNACKBAR. The server's reason
/// is specific and actionable — "a payout from this round has not finished
/// yet (1 outstanding)", "there is still money in the pot from this round" —
/// and a snackbar takes it away after four seconds. It stays on the banner,
/// next to the button it is blocking.
class ContributionRoundBanner extends StatelessWidget {
  final ContributionRoundState state;

  /// Only the creator gets the two buttons. The server refuses anyone else,
  /// so showing them would be offering an action that cannot be taken.
  final bool isCreator;

  /// True while a round action is in flight, so neither button can be pressed
  /// twice. The server is idempotent under its own lock, but a second tap
  /// would still produce a second outcome on screen.
  final bool busy;

  final VoidCallback onStartNextRound;
  final VoidCallback onEndCircle;

  const ContributionRoundBanner({
    super.key,
    required this.state,
    required this.isCreator,
    required this.busy,
    required this.onStartNextRound,
    required this.onEndCircle,
  });

  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _purple = Color(0xFFA78BFA);

  @override
  Widget build(BuildContext context) {
    // Nothing to say while a round is running: the cycle card and the
    // progress bar already describe that, and a banner repeating it would
    // push the tab bar down for no information.
    if (state.roundsEnded) return _endedCard();
    if (!state.roundFinished) return const SizedBox.shrink();
    return _decisionCard();
  }

  /// The circle is over, for good. Stated plainly so nobody waits for a turn
  /// that is not coming.
  Widget _endedCard() {
    return _shell(
      accent: _green,
      icon: Icons.verified_rounded,
      title: 'This circle is complete',
      body: state.currentRound > 1
          ? 'All ${state.currentRound} rounds have finished and the circle '
              'has been closed. Nothing further is scheduled.'
          : 'Every cycle has paid out and the circle has been closed. '
              'Nothing further is scheduled.',
      children: const [],
    );
  }

  Widget _decisionCard() {
    final blocked = !state.canStartNextRound;
    final next = state.activeMembers;

    return _shell(
      accent: blocked ? _amber : _purple,
      icon: blocked ? Icons.pause_circle_outline : Icons.loop_rounded,
      title: 'Round ${state.currentRound} is complete',
      body: blocked
          // The server's sentence verbatim. It names the specific thing to
          // fix, and rewording it here would put two different explanations
          // of one state in two repositories.
          ? state.reason
          : (isCreator
              ? 'Every member has collected. You can go round again, which '
                  'adds ${_cycleCount(next)} and resets the dates, or end '
                  'the circle here.'
              : 'Every member has collected. The circle is waiting for its '
                  'creator to start another round or close it.'),
      children: [
        if (isCreator && !blocked) ...[
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _button(
                  label: busy ? 'Starting...' : 'Go to next round',
                  filled: true,
                  accent: _purple,
                  onTap: busy ? null : onStartNextRound,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _button(
                  label: 'End circle',
                  filled: false,
                  accent: _amber,
                  onTap: busy ? null : onEndCircle,
                ),
              ),
            ],
          ),
        ],
        // Ending is still allowed when a NEW round is blocked for a reason
        // that is not about money in flight — a circle everyone has left, for
        // instance, is precisely one worth closing. The server decides; this
        // only avoids offering it where it would certainly be refused.
        if (isCreator &&
            blocked &&
            state.code == ContributionRoundCode.noActiveMembers) ...[
          SizedBox(height: 12.h),
          _button(
            label: 'End circle',
            filled: false,
            accent: _amber,
            onTap: busy ? null : onEndCircle,
          ),
        ],
      ],
    );
  }

  String _cycleCount(int n) {
    if (n <= 0) return 'more cycles';
    return n == 1 ? '1 more cycle' : '$n more cycles';
  }

  Widget _shell({
    required Color accent,
    required IconData icon,
    required String title,
    required String body,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accent, size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          if (body.trim().isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              body,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.80),
                fontSize: 11.5.sp,
                height: 1.4,
              ),
            ),
          ],
          ...children,
        ],
      ),
    );
  }

  Widget _button({
    required String label,
    required bool filled,
    required Color accent,
    required VoidCallback? onTap,
  }) {
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: disabled ? 0.55 : 1,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: filled ? accent : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: accent),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: filled ? Colors.white : accent,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
