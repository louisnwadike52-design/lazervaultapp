import 'package:equatable/equatable.dart';
import '../../domain/entities/water_auto_recharge.dart';

sealed class WaterAutoRechargeState extends Equatable {
  const WaterAutoRechargeState();

  @override
  List<Object?> get props => [];
}

class WaterAutoRechargeInitial extends WaterAutoRechargeState {}

class WaterAutoRechargesLoading extends WaterAutoRechargeState {}

class WaterAutoRechargesLoaded extends WaterAutoRechargeState {
  final List<WaterAutoRecharge> autoRecharges;
  const WaterAutoRechargesLoaded({required this.autoRecharges});

  @override
  List<Object?> get props => [autoRecharges];
}

class WaterAutoRechargeMutating extends WaterAutoRechargeState {}

class WaterAutoRechargeMutated extends WaterAutoRechargeState {
  final String message;
  const WaterAutoRechargeMutated({required this.message});

  @override
  List<Object?> get props => [message];
}

class WaterAutoRechargeError extends WaterAutoRechargeState {
  final String message;
  const WaterAutoRechargeError({required this.message});

  @override
  List<Object?> get props => [message];
}
