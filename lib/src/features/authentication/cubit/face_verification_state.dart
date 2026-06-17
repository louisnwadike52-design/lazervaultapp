import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/authentication/domain/entities/face_registration_entity.dart';
import 'package:lazervault/src/features/authentication/domain/entities/face_verification_entity.dart';

abstract class FaceVerificationState extends Equatable {
  const FaceVerificationState();

  @override
  List<Object?> get props => [];
}

class FaceVerificationInitial extends FaceVerificationState {
  const FaceVerificationInitial();
}

class FaceVerificationLoading extends FaceVerificationState {
  const FaceVerificationLoading();
}

// Registration States
class FaceRegistrationSuccess extends FaceVerificationState {
  final FaceRegistrationEntity registration;

  const FaceRegistrationSuccess(this.registration);

  @override
  List<Object?> get props => [registration];
}

class FaceRegistrationFailure extends FaceVerificationState {
  final String message;
  final int? statusCode;

  const FaceRegistrationFailure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

// Verification States
class FaceVerificationSuccess extends FaceVerificationState {
  final FaceVerificationEntity verification;

  const FaceVerificationSuccess(this.verification);

  @override
  List<Object?> get props => [verification];
}

class FaceVerificationFailure extends FaceVerificationState {
  final String message;
  final int? statusCode;

  const FaceVerificationFailure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class FaceVerified extends FaceVerificationState {
  final FaceVerificationEntity verification;

  const FaceVerified(this.verification);

  @override
  List<Object?> get props => [verification];
}

class FaceVerificationRejected extends FaceVerificationState {
  final FaceVerificationEntity verification;
  final String reason;

  const FaceVerificationRejected(this.verification, this.reason);

  @override
  List<Object?> get props => [verification, reason];
}
