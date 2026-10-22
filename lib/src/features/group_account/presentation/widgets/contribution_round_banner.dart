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

  /// Extend the rotation by changing its cycle count.
  ///
  /// On the BODY, not only behind the overflow menu. When a round finishes,
  /// "run it longer" is one of the three things a creator might want, and the
  /// other two are already buttons here — burying the third in a three-dot
  /// menu makes it the option nobody finds.
  final VoidCallback onExtendCycles;

  const ContributionRoundBanner({
    super.key,
    required this.state,
    required this.isCreator,
    required this.busy,
    required this.onStartNextRound,
    required this.onEndCircle,
    required this.onExtendCycles,
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
    // A RUNNING ROUND STILL NEEDS ITS CONTROLS.
    //
    // This returned nothing at all until a round finished, so for most of a
    // circle's life there was no way to extend it or close it from the
    // contribution page — extend lived in the three-dot menu and end lived
    // nowhere. A creator looking at an overdue circle saw no action at all.
    //
    // Mid-round it renders the two standing actions and NOT the "Round N is
    // complete" framing, which would be a lie.
    if (!state.roundFinished) {
      return isCreator ? _runningControls() : const SizedBox.shrink();
    }
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
        // BOTH STANDING ACTIONS ARE ON THE BODY, EVERY ROUND.
        //
        // "Run it longer" and "close it" are the two things a creator does
        // with a finished circle, and they were reachable only from the
        // three-dot menu (extend) or only in one narrow state (end). A
        // control a creator cannot find is a control that does not exist, and
        // they recur every time a round completes — so they live here, not in
        // a menu, for as long as the circle runs.
        if (isCreator) ...[
          if (!blocked) ...[
            SizedBox(height: 12.h),
            _button(
              label: busy ? 'Starting...' : 'Go to next round',
              filled: true,
              accent: _purple,
              onTap: busy ? null : onStartNextRound,
            ),
          ],
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _button(
                  label: 'Extend cycles',
                  filled: false,
                  accent: _purple,
                  onTap: busy ? null : onExtendCycles,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _button(
                  label: 'End contribution',
                  filled: false,
                  accent: _amber,
                  // SHOWN ALWAYS, ENABLED ONLY WHEN THE SERVER WILL ACCEPT.
                  //
                  // Hiding it left creators unable to find how to close a
                  // circle at all; offering it unconditionally would hand
                  // them a guaranteed refusal. Disabled-with-a-reason is the
                  // honest middle, and the reason is the server's own
                  // sentence, printed below.
                  onTap: (busy || !state.code.allowsEnding)
                      ? null
                      : onEndCircle,
                ),
              ),
            ],
          ),
          if (!state.code.allowsEnding) ...[
            SizedBox(height: 6.h),
            Text(
              _endBlockedNote(),
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 11.sp,
              ),
            ),
          ],
        ],
      ],
    );
  }

  /// Why "End contribution" is unavailable, in one line.
  ///
  /// Derived from the state rather than written per-call-site, so it can never
  /// contradict the sentence already shown above it.
  String _endBlockedNote() {
    switch (state.code) {
      case ContributionRoundCode.turnOutstanding:
        return 'The circle cannot be closed while a member is still owed '
            'their turn — paying them out is what unblocks it.';
      case ContributionRoundCode.potNotEmpty:
        return 'The circle cannot be closed while this round\'s money is '
            'still in the pot.';
      case ContributionRoundCode.payoutInFlight:
        return 'The circle cannot be closed while a payout is still moving.';
      case ContributionRoundCode.stillRunning:
        return 'The circle can be closed once this round finishes.';
      case ContributionRoundCode.alreadyEnded:
        return 'This circle has already been closed.';
      default:
        return 'Closing is unavailable in this state.';
    }
  }

  /// The two standing creator actions, while a round is still running.
  ///
  /// Deliberately plain: no icon, no status headline. The cards above already
  /// say where the circle is; this is only the pair of controls.
  Widget _runningControls() {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _button(
                  label: 'Extend cycles',
                  filled: false,
                  accent: _purple,
                  onTap: busy ? null : onExtendCycles,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _button(
                  label: 'End contribution',
                  filled: false,
                  accent: _amber,
                  onTap: (busy || !state.code.allowsEnding)
                      ? null
                      : onEndCircle,
                ),
              ),
            ],
          ),
          if (!state.code.allowsEnding) ...[
            SizedBox(height: 6.h),
            Text(
              _endBlockedNote(),
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 11.sp,
              ),
            ),
          ],
        ],
      ),
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
