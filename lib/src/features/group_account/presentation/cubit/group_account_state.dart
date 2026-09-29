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

class GroupAccountLoading extends GroupAccountState {
  final String? message;

  const GroupAccountLoading({this.message});

  @override
  List<Object?> get props => [message];
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

  const GroupAccountAwaitingApproval({
    required this.groupId,
    this.group,
    this.awaitingApproval = true,
  });

  @override
  List<Object?> get props => [groupId, group, awaitingApproval];
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
