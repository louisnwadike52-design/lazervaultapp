/// WHERE A SAVINGS CIRCLE IS IN ITS ROUNDS, AND WHAT IT CAN DO NEXT.
///
/// A round is one full pass through the members: three members, three cycles.
/// When the agreed cycles have all run the circle sits `completed`, and its
/// creator chooses — go round again, or end it. This is the server's answer
/// about which of those is available and, when neither is, why.
///
/// The codes are the server's, declared in the proto and stable because the
/// screen switches on them. They are not reworded here: a copy of a string
/// constant in two repositories is a drift waiting to happen, so the sentence
/// the user reads comes from [reason], which the server writes.
enum ContributionRoundCode {
  /// Another round can start now.
  ready('round_ready'),

  /// Not a savings circle; only a rotation runs in rounds.
  notRotating('round_not_rotating'),

  /// No agreed cycle count, so the circle keeps rotating on its own and has
  /// no round to finish.
  noAgreedCycles('round_no_agreed_cycles'),

  /// This round still has cycles left to run.
  stillRunning('round_still_running'),

  /// A person cancelled or paused it.
  contributionStopped('round_contribution_stopped'),

  /// The creator has ended the circle.
  alreadyEnded('round_already_ended'),

  /// A payout from this round has not finished.
  payoutInFlight('round_payout_in_flight'),

  /// This round's money is still in the pot.
  potNotEmpty('round_pot_not_empty'),

  /// A new round would have no cycles, because nobody is active.
  noActiveMembers('round_no_active_members'),

  /// SOMEBODY IS STILL OWED THEIR TURN in this round.
  ///
  /// The case that made the fanthom daily savings incident permanent: one
  /// member took both turns of a two-cycle circle, so the agreed cycle count
  /// was satisfied while the other member — who had paid in for both cycles —
  /// had received nothing. Starting a new round there would have buried that
  /// debt under fresh cycles.
  ///
  /// The server's reason NAMES who is owed, so it is shown verbatim rather
  /// than replaced with a generic line.
  turnOutstanding('round_turn_outstanding'),

  /// A code this build does not know.
  ///
  /// Deliberately not folded into one of the real values: a code added by a
  /// newer server must not be silently read as "ready", which would put a
  /// button in front of an action the server is going to refuse.
  unknown('');

  const ContributionRoundCode(this.wire);

  final String wire;

  static ContributionRoundCode fromWire(String? value) {
    final v = (value ?? '').trim();
    for (final c in ContributionRoundCode.values) {
      if (c != ContributionRoundCode.unknown && c.wire == v) return c;
    }
    return ContributionRoundCode.unknown;
  }
}

class ContributionRoundState {
  final ContributionRoundCode code;

  /// The server's sentence for the creator. Names the specific thing to fix.
  final String reason;

  /// Whether the server will accept a new round right now.
  ///
  /// Read from the server's own flag rather than inferred from [code], so a
  /// build that does not recognise a newer code still shows the right button.
  final bool canStartNextRound;

  final int currentRound;
  final int cyclesCompleted;
  final int totalCycles;

  /// How many cycles the NEXT round would have: the active member count.
  final int activeMembers;

  /// Money still in the pot, in minor units. Non-zero is a refusal reason.
  final int residualPotMinor;

  final int payoutsInFlight;

  /// True once the creator has ended the circle; no round can follow.
  final bool roundsEnded;

  const ContributionRoundState({
    this.code = ContributionRoundCode.unknown,
    this.reason = '',
    this.canStartNextRound = false,
    this.currentRound = 1,
    this.cyclesCompleted = 0,
    this.totalCycles = 0,
    this.activeMembers = 0,
    this.residualPotMinor = 0,
    this.payoutsInFlight = 0,
    this.roundsEnded = false,
  });

  /// Whether this round's cycles have all run, so the circle is waiting on a
  /// decision.
  ///
  /// Derived from the counters rather than from `status == completed`: a
  /// circle closed early by something else is also `completed`, and offering
  /// "go round again" there would paper over a stall that needs looking at.
  bool get roundFinished =>
      totalCycles > 0 && cyclesCompleted >= totalCycles && !roundsEnded;

  /// Whether the creator should be offered the two choices.
  bool get awaitingDecision => roundFinished;

  /// Whether the circle is mid-round, which is the ordinary running state.
  bool get inProgress =>
      !roundsEnded && totalCycles > 0 && cyclesCompleted < totalCycles;

  /// Cycles still to run in this round. Never negative.
  int get cyclesRemaining {
    final left = totalCycles - cyclesCompleted;
    return left > 0 ? left : 0;
  }

  /// A short label for a badge: "Round 2".
  String get roundLabel => 'Round $currentRound';

  /// The progress line under it: "Cycle 3 of 4".
  String cycleProgressLabel(int? currentCycle) {
    if (totalCycles <= 0) return '';
    final at = (currentCycle ?? 0) > 0 ? currentCycle! : cyclesCompleted + 1;
    final shown = at > totalCycles ? totalCycles : at;
    return 'Cycle $shown of $totalCycles';
  }
}
