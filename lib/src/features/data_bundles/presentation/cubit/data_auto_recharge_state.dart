import 'package:equatable/equatable.dart';
import '../../domain/entities/data_auto_recharge.dart';

sealed class DataAutoRechargeState extends Equatable {
  const DataAutoRechargeState();

  @override
  List<Object?> get props => [];
}

class DataAutoRechargeInitial extends DataAutoRechargeState {}

class DataAutoRechargesLoading extends DataAutoRechargeState {}

class DataAutoRechargesLoaded extends DataAutoRechargeState {
  final List<DataAutoRecharge> autoRecharges;
  const DataAutoRechargesLoaded({required this.autoRecharges});

  @override
  List<Object?> get props => [autoRecharges];
}

class DataAutoRechargeMutating extends DataAutoRechargeState {}

class DataAutoRechargeMutated extends DataAutoRechargeState {
  final String message;
  const DataAutoRechargeMutated({required this.message});

  @override
  List<Object?> get props => [message];
}

class DataAutoRechargeError extends DataAutoRechargeState {
  final String message;
  const DataAutoRechargeError({required this.message});

  @override
  List<Object?> get props => [message];
}
