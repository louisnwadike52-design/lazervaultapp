import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/crowdfund/domain/entities/crowdfund_entities.dart';
import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

abstract class DiscoveryState extends Equatable {
  const DiscoveryState();

  @override
  List<Object?> get props => [];
}

class DiscoveryInitial extends DiscoveryState {}

class DiscoveryLoading extends DiscoveryState {
  final String? message;
  const DiscoveryLoading({this.message});

  @override
  List<Object?> get props => [message];
}

class TrendingCrowdfundsLoaded extends DiscoveryState {
  final List<Crowdfund> crowdfunds;
  final bool isStale;

  const TrendingCrowdfundsLoaded({required this.crowdfunds, this.isStale = false});

  @override
  List<Object?> get props => [crowdfunds, isStale];
}

class PublicGroupsLoaded extends DiscoveryState {
  final List<GroupAccount> groups;
  final bool isStale;

  const PublicGroupsLoaded({required this.groups, this.isStale = false});

  @override
  List<Object?> get props => [groups, isStale];
}

class PublicGroupDetailLoaded extends DiscoveryState {
  final PublicGroupDetail detail;

  const PublicGroupDetailLoaded(this.detail);

  @override
  List<Object?> get props => [detail];
}

class GroupJoinSuccess extends DiscoveryState {
  final GroupAccount group;
  final String message;

  const GroupJoinSuccess({
    required this.group,
    this.message = 'Successfully joined group',
  });

  @override
  List<Object?> get props => [group, message];
}

class DiscoveryError extends DiscoveryState {
  final String message;

  const DiscoveryError(this.message);

  @override
  List<Object?> get props => [message];
}
