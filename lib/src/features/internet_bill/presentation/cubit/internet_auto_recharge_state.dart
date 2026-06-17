import 'package:equatable/equatable.dart';
import '../../domain/entities/internet_auto_recharge.dart';

sealed class InternetAutoRechargeState extends Equatable {
  const InternetAutoRechargeState();

  @override
  List<Object?> get props => [];
}

class InternetAutoRechargeInitial extends InternetAutoRechargeState {}

class InternetAutoRechargesLoading extends InternetAutoRechargeState {}

class InternetAutoRechargesLoaded extends InternetAutoRechargeState {
  final List<InternetAutoRecharge> autoRecharges;
  const InternetAutoRechargesLoaded({required this.autoRecharges});

  @override
  List<Object?> get props => [autoRecharges];
}

class InternetAutoRechargeMutating extends InternetAutoRechargeState {}

class InternetAutoRechargeMutated extends InternetAutoRechargeState {
  final String message;
  const InternetAutoRechargeMutated({required this.message});

  @override
  List<Object?> get props => [message];
}

class InternetAutoRechargeError extends InternetAutoRechargeState {
  final String message;
  const InternetAutoRechargeError({required this.message});

  @override
  List<Object?> get props => [message];
}
