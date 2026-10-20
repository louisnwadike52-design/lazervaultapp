part of 'group_account_state.dart';

// =============================================================
// Cycle history states.
// =============================================================

class ContributionCyclesLoading extends GroupAccountState {
  final String contributionId;
  const ContributionCyclesLoading({required this.contributionId});
  @override
  List<Object?> get props => [contributionId];
}

class ContributionCyclesLoaded extends GroupAccountState {
  final String contributionId;
  final List<ContributionCycle> cycles;
  final int total;
  const ContributionCyclesLoaded({
    required this.contributionId,
    required this.cycles,
    required this.total,
  });
  @override
  List<Object?> get props => [contributionId, cycles, total];
}

class ContributionCycleDetailsLoading extends GroupAccountState {
  final String contributionId;
  final int cycleIndex;
  const ContributionCycleDetailsLoading({
    required this.contributionId,
    required this.cycleIndex,
  });
  @override
  List<Object?> get props => [contributionId, cycleIndex];
}

class ContributionCycleDetailsLoaded extends GroupAccountState {
  final ContributionCycleDetails details;
  const ContributionCycleDetailsLoaded({required this.details});
  @override
  List<Object?> get props => [details];
}

class ContributionRestarted extends GroupAccountState {
  final Contribution contribution;
  final String message;
  const ContributionRestarted({
    required this.contribution,
    this.message = 'Contribution restarted',
  });
  @override
  List<Object?> get props => [contribution, message];
}

// =============================================================
// Savings-circle rounds
// =============================================================
//
// One state for all three outcomes, carrying BOTH the contribution and the
// round state. A refusal is state rather than an error here: the server
// answers OK with the sentence to show ("this round is still running: 2 of 3
// cycles have finished"), so emitting GroupAccountError for it would replace
// the one explanation the creator needs with a generic failure.
//
// [justChanged] distinguishes a read from a mutation that landed, so the
// screen can show a confirmation for the second without announcing one every
// time it polls.

class ContributionRoundLoaded extends GroupAccountState {
  final Contribution contribution;
  final ContributionRoundState roundState;

  /// Non-empty when a round was just started or the circle just ended.
  final String justChanged;

  const ContributionRoundLoaded({
    required this.contribution,
    required this.roundState,
    this.justChanged = '',
  });

  @override
  List<Object?> get props => [contribution, roundState, justChanged];
}

class ContributionRoundBusy extends GroupAccountState {
  final String contributionId;
  final String message;
  const ContributionRoundBusy({
    required this.contributionId,
    this.message = 'Working on it...',
  });
  @override
  List<Object?> get props => [contributionId, message];
}

// =============================================================
// Past Contributions / Past Groups
// =============================================================
//
// Soft-deleted contribution_members / group_members rows surface as
// these states. The Past-Contributions screen subscribes via a
// BlocBuilder<GroupAccountCubit, GroupAccountState> and pattern-
// matches on the loaded variant; loading/error states are siblings
// so the screen can render skeletons / retry CTAs without leaking
// extra fields onto the loaded payload. Pulled in from the data
// source rather than the regular gRPC stub since past-membership
// HTTP endpoints proxy through the financial-gateway grpc-gateway.

class PastContributionsLoading extends GroupAccountState {
  const PastContributionsLoading();
}

class PastContributionsLoaded extends GroupAccountState {
  // Stored as `dynamic` here to keep this state file from importing
  // the data-source layer directly — keeps the layering one-way and
  // avoids circular imports. The cubit owns the typed list and casts
  // back where it lives.
  final List<dynamic> entries;
  final String filter; // ""|"removed"|"left"
  /// ""|"visible"|"hidden"|"all" — independent of [filter]. Carried on the
  /// state so the tab that asked for it can tell whether the list it is
  /// looking at is the one it requested.
  final String visibility;
  const PastContributionsLoaded({
    required this.entries,
    required this.filter,
    this.visibility = '',
  });
  @override
  List<Object?> get props => [entries.length, filter, visibility];
}

class PastContributionsError extends GroupAccountState {
  final String message;
  const PastContributionsError(this.message);
  @override
  List<Object?> get props => [message];
}

class PastGroupsLoading extends GroupAccountState {
  const PastGroupsLoading();
}

class PastGroupsLoaded extends GroupAccountState {
  final List<dynamic> entries;
  final String filter;
  final String visibility;
  const PastGroupsLoaded({
    required this.entries,
    required this.filter,
    this.visibility = '',
  });
  @override
  List<Object?> get props => [entries.length, filter, visibility];
}

class PastGroupsError extends GroupAccountState {
  final String message;
  const PastGroupsError(this.message);
  @override
  List<Object?> get props => [message];
}

class PastContributionDetailsLoading extends GroupAccountState {
  final String contributionId;
  const PastContributionDetailsLoading({required this.contributionId});
  @override
  List<Object?> get props => [contributionId];
}

class PastContributionDetailsLoaded extends GroupAccountState {
  final dynamic details; // PastContributionDetails — same circular-import dodge
  const PastContributionDetailsLoaded({required this.details});
  @override
  List<Object?> get props => [details];
}

class PastContributionDetailsError extends GroupAccountState {
  final String message;
  const PastContributionDetailsError(this.message);
  @override
  List<Object?> get props => [message];
}
