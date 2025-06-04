import 'package:equatable/equatable.dart';
import '../../domain/entities/group_entities.dart';

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
  
  const GroupAccountGroupsLoaded(this.groups);
  
  @override
  List<Object?> get props => [groups];
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

class GroupAccountContributionCreated extends GroupAccountState {
  final Contribution contribution;
  
  const GroupAccountContributionCreated(this.contribution);
  
  @override
  List<Object?> get props => [contribution];
}

class GroupAccountPaymentCompleted extends GroupAccountState {
  final ContributionPayment payment;
  
  const GroupAccountPaymentCompleted(this.payment);
  
  @override
  List<Object?> get props => [payment];
}

class GroupAccountReceiptGenerated extends GroupAccountState {
  final ContributionReceipt receipt;
  
  const GroupAccountReceiptGenerated(this.receipt);
  
  @override
  List<Object?> get props => [receipt];
}

class GroupAccountTranscriptGenerated extends GroupAccountState {
  final ContributionTranscript transcript;
  
  const GroupAccountTranscriptGenerated(this.transcript);
  
  @override
  List<Object?> get props => [transcript];
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