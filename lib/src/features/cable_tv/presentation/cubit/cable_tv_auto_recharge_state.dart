import 'package:equatable/equatable.dart';
import '../../domain/entities/cable_tv_auto_recharge.dart';

sealed class CableTVAutoRechargeState extends Equatable {
  const CableTVAutoRechargeState();

  @override
  List<Object?> get props => [];
}

class CableTVAutoRechargeInitial extends CableTVAutoRechargeState {}

class CableTVAutoRechargesLoading extends CableTVAutoRechargeState {}

class CableTVAutoRechargesLoaded extends CableTVAutoRechargeState {
  final List<CableTVAutoRecharge> autoRecharges;
  const CableTVAutoRechargesLoaded({required this.autoRecharges});

  @override
  List<Object?> get props => [autoRecharges];
}

class CableTVAutoRechargeMutating extends CableTVAutoRechargeState {}

class CableTVAutoRechargeMutated extends CableTVAutoRechargeState {
  final String message;
  const CableTVAutoRechargeMutated({required this.message});

  @override
  List<Object?> get props => [message];
}

class CableTVAutoRechargeError extends CableTVAutoRechargeState {
  final String message;
  const CableTVAutoRechargeError({required this.message});

  @override
  List<Object?> get props => [message];
}
