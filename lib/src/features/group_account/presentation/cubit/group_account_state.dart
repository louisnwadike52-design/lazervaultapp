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
