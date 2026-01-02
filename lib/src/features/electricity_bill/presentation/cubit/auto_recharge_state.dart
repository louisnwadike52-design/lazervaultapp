import 'package:equatable/equatable.dart';
import '../../domain/entities/auto_recharge_entity.dart';

abstract class AutoRechargeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AutoRechargeInitial extends AutoRechargeState {}

class AutoRechargeLoading extends AutoRechargeState {}

class AutoRechargeCreating extends AutoRechargeState {}

class AutoRechargeCreated extends AutoRechargeState {
  final AutoRechargeEntity autoRecharge;
  final String message;

  AutoRechargeCreated({
    required this.autoRecharge,
    this.message = 'Auto-recharge created successfully',
  });

  @override
  List<Object?> get props => [autoRecharge, message];
}

class AutoRechargesLoaded extends AutoRechargeState {
  final List<AutoRechargeEntity> autoRecharges;

  AutoRechargesLoaded({required this.autoRecharges});

  @override
  List<Object?> get props => [autoRecharges];
}

class AutoRechargeLoaded extends AutoRechargeState {
  final AutoRechargeEntity autoRecharge;

  AutoRechargeLoaded({required this.autoRecharge});

  @override
  List<Object?> get props => [autoRecharge];
}

class AutoRechargeUpdating extends AutoRechargeState {}

class AutoRechargeUpdated extends AutoRechargeState {
  final AutoRechargeEntity autoRecharge;
  final String message;

  AutoRechargeUpdated({
    required this.autoRecharge,
    this.message = 'Auto-recharge updated successfully',
  });

  @override
  List<Object?> get props => [autoRecharge, message];
}

class AutoRechargePausing extends AutoRechargeState {}

class AutoRechargePaused extends AutoRechargeState {
  final String message;

  AutoRechargePaused({this.message = 'Auto-recharge paused'});

  @override
  List<Object?> get props => [message];
}

class AutoRechargeResuming extends AutoRechargeState {}

class AutoRechargeResumed extends AutoRechargeState {
  final String message;

  AutoRechargeResumed({this.message = 'Auto-recharge resumed'});

  @override
  List<Object?> get props => [message];
}

class AutoRechargeDeleting extends AutoRechargeState {}

class AutoRechargeDeleted extends AutoRechargeState {
  final String message;

  AutoRechargeDeleted({this.message = 'Auto-recharge deleted successfully'});

  @override
  List<Object?> get props => [message];
}

class AutoRechargeError extends AutoRechargeState {
  final String message;

  AutoRechargeError({required this.message});

  @override
  List<Object?> get props => [message];
}
