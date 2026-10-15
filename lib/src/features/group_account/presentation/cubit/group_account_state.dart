import 'package:equatable/equatable.dart';
import '../../domain/entities/group_entities.dart';

// Export for convenience
export '../../domain/entities/group_entities.dart';
part 'group_account_state_contribution.dart';
part 'group_account_state_members.dart';
part 'group_account_state_activity_report.dart';
part 'group_account_state_public_invites.dart';
part 'group_account_state_cycles_past.dart';

abstract class GroupAccountState extends Equatable {
  const GroupAccountState();

  @override
  List<Object?> get props => [];
}

class GroupAccountInitial extends GroupAccountState {}

/// Nobody is signed in.
///
/// Deliberately NOT a [GroupAccountError]. On auto-logout the session is
/// cleared while this feature is still on screen, and anything that then
/// touches a per-user read used to emit an error — which the list screen
/// turned into a red "User not authenticated. Please log in." snackbar that
/// floated over the passcode screen the user had just been sent to.
///
/// Not being logged in is not a failure of this screen, and there is nothing
/// for the user to do about it that the login screen in front of them is not
/// already asking. So it gets its own state, every surface renders it as a
/// quiet signed-out placeholder, and no surface toasts it.
class GroupAccountUnauthenticated extends GroupAccountState {
  const GroupAccountUnauthenticated();
}

class GroupAccountLoading extends GroupAccountState {
  final String? message;

  const GroupAccountLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// One PAGE of the caller's groups.
///
/// Distinct from [GroupAccountGroupsLoaded], which carries "all the groups"
/// and is what every older consumer (the stats tile, the leaderboard seed)
/// still reads. Keeping them apart means adding paging to one screen did
/// not have to change what the others mean by "loaded".
class GroupAccountGroupsPageLoaded extends GroupAccountState {
  final PagedResult<GroupAccount> page;

  /// Painted from the disk cache, before the network answered. The list
  /// renders normally; the flag exists so a surface can show a quiet
  /// "updating" hint rather than pretending the data is fresh.
  final bool fromCache;

  const GroupAccountGroupsPageLoaded(this.page, {this.fromCache = false});

  @override
  List<Object?> get props => [page, fromCache];
}

/// One PAGE of a group's contributions.
class GroupAccountContributionsPageLoaded extends GroupAccountState {
  final String groupId;
  final PagedResult<Contribution> page;
  final bool fromCache;

  const GroupAccountContributionsPageLoaded(
    this.groupId,
    this.page, {
    this.fromCache = false,
  });

  @override
  List<Object?> get props => [groupId, page, fromCache];
}

class GroupAccountGroupsLoaded extends GroupAccountState {
  final List<GroupAccount> groups;
  final bool isStale;
  final bool isRevalidating;

  const GroupAccountGroupsLoaded(
    this.groups, {
    this.isStale = false,
    this.isRevalidating = false,
  });

  GroupAccountGroupsLoaded copyWith({
    List<GroupAccount>? groups,
    bool? isStale,
    bool? isRevalidating,
  }) {
    return GroupAccountGroupsLoaded(
      groups ?? this.groups,
      isStale: isStale ?? this.isStale,
      isRevalidating: isRevalidating ?? this.isRevalidating,
    );
  }

  @override
  List<Object?> get props => [groups, isStale, isRevalidating];
}

class GroupAccountGroupLoaded extends GroupAccountState {
  final GroupAccount group;
  final List<GroupMember> members;
  final List<Contribution> contributions;

  const GroupAccountGroupLoaded({
    required this.group,
    required this.members,
    required this.contributions,
  });

  @override
  List<Object?> get props => [group, members, contributions];
}

class GroupAccountGroupCreated extends GroupAccountState {
  final GroupAccount group;

  const GroupAccountGroupCreated(this.group);

  @override
  List<Object?> get props => [group];
}

/// The group exists, but this user may not read it yet.
///
/// Distinct from [GroupAccountError] because it is not a failure: the user
/// asked to join a public group and is waiting on an admin. The backend can
/// only answer the members/contributions reads with PermissionDenied, and
/// rendering that as a red "not authorized" error told a user who had done
/// everything right that something had gone wrong.
///
/// [awaitingApproval] separates "you have asked and nobody has decided yet"
/// from "you are simply not a member", because those need different words and
/// a different call to action.
class GroupAccountAwaitingApproval extends GroupAccountState {
  final String groupId;
  final GroupAccount? group;
  final bool awaitingApproval;

  /// This user holds an UNACCEPTED invite to the group.
  ///
  /// A third case the screen used to collapse into the other two. Someone who
  /// was invited has not "asked to join", so telling them a request is being
  /// reviewed is false and telling them to ask to join is advice they do not
  /// need — they already have the thing, they just have not accepted it.
  final bool hasPendingInvite;

  const GroupAccountAwaitingApproval({
    required this.groupId,
    this.group,
    this.awaitingApproval = true,
    this.hasPendingInvite = false,
  });

  @override
  List<Object?> get props =>
      [groupId, group, awaitingApproval, hasPendingInvite];
}

/// One contribution, fetched by id alone.
///
/// THE STATE A DEEP LINK NEEDS. `loadContributionDetails` fetched the
/// contribution and then emitted `GroupAccountSuccess('Contribution loaded')`
/// — a message with no payload. The details screen only ever learned about a
/// contribution from `GroupAccountGroupLoaded`, which comes from loading a
/// GROUP, so arriving with a contribution id and no group (every push
/// notification, every in-app notification tap, every share link) left
/// `_currentContribution` null forever and the screen spinning on its loading
/// view with nothing on the way.
class ContributionDetailsLoaded extends GroupAccountState {
  final Contribution contribution;

  /// Payments fetched in the same pass, so the screen does not need a second
  /// round trip before it can render its history tab.
  final List<ContributionPayment> payments;

  ContributionDetailsLoaded(this.contribution, {this.payments = const []});
}

class GroupAccountError extends GroupAccountState {
  final String message;

  const GroupAccountError(this.message);

  @override
  List<Object?> get props => [message];
}

class GroupAccountSuccess extends GroupAccountState {
  final String message;

  const GroupAccountSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
