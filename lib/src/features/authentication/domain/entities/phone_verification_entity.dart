import 'package:equatable/equatable.dart';

class PhoneVerificationEntity extends Equatable {
  final bool success;
  final String message;
  final String? verificationId;
  final int? expiresIn; // seconds

  const PhoneVerificationEntity({
    required this.success,
    required this.message,
    this.verificationId,
    this.expiresIn,
  });

  @override
  List<Object?> get props => [success, message, verificationId, expiresIn];
}

class VerifyPhoneEntity extends Equatable {
  final bool success;
  final String message;
  final bool isVerified;

  const VerifyPhoneEntity({
    required this.success,
    required this.message,
    required this.isVerified,
  });

  @override
  List<Object?> get props => [success, message, isVerified];
}
