import 'package:equatable/equatable.dart';

abstract class AutoRenewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AutoRenewInitial extends AutoRenewState {}

class AutoRenewLoading extends AutoRenewState {}

class AutoRenewLoaded extends AutoRenewState {
  final List<Map<String, dynamic>> subscriptions;

  AutoRenewLoaded({required this.subscriptions});

  @override
  List<Object?> get props => [subscriptions];
}

class AutoRenewError extends AutoRenewState {
  final String message;

  AutoRenewError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AutoRenewToggling extends AutoRenewState {}

class AutoRenewToggled extends AutoRenewState {
  final bool enabled;
  final String message;

  AutoRenewToggled({required this.enabled, required this.message});

  @override
  List<Object?> get props => [enabled, message];
}
