import 'package:equatable/equatable.dart';
import '../domain/entities/mandate_entity.dart';

sealed class MandateState extends Equatable {
  const MandateState();

  @override
  List<Object?> get props => [];
}

class MandateInitial extends MandateState {}

class MandateLoading extends MandateState {}

class MandateCreated extends MandateState {
  final MandateEntity mandate;
  final bool needsAuthorization;
  final String? authorizationUrl;

  const MandateCreated({
    required this.mandate,
    required this.needsAuthorization,
    this.authorizationUrl,
  });

  @override
  List<Object?> get props => [mandate, needsAuthorization, authorizationUrl];
}

class UserMandatesLoaded extends MandateState {
  final List<MandateEntity> mandates;

  const UserMandatesLoaded({required this.mandates});

  @override
  List<Object?> get props => [mandates];
}

class MandatePaused extends MandateState {
  final MandateEntity mandate;

  const MandatePaused({required this.mandate});

  @override
  List<Object?> get props => [mandate];
}

class MandateReinstated extends MandateState {
  final MandateEntity mandate;

  const MandateReinstated({required this.mandate});

  @override
  List<Object?> get props => [mandate];
}

class MandateCancelled extends MandateState {
  final String mandateId;

  const MandateCancelled({required this.mandateId});

  @override
  List<Object?> get props => [mandateId];
}

class MandateError extends MandateState {
  final String message;

  const MandateError({required this.message});

  @override
  List<Object?> get props => [message];
}
