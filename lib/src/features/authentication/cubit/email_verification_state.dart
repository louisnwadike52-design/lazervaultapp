import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';

abstract class EmailVerificationState extends Equatable {
  const EmailVerificationState();

  @override
  List<Object?> get props => [];
}

class EmailVerificationInitial extends EmailVerificationState {
  const EmailVerificationInitial();
}

class EmailVerificationInProgress extends EmailVerificationState {
  final String verificationCode;
  final bool isLoading;
  final bool isResending;
  final String errorMessage;
  final String successMessage;
  final int? cooldownSeconds;  // Seconds to wait before next resend (from backend)

  const EmailVerificationInProgress({
    this.verificationCode = '',
    this.isLoading = false,
    this.isResending = false,
    this.errorMessage = '',
    this.successMessage = '',
    this.cooldownSeconds,
  });

  EmailVerificationInProgress copyWith({
    String? verificationCode,
    bool? isLoading,
    bool? isResending,
    String? errorMessage,
    String? successMessage,
    int? cooldownSeconds,
  }) {
    return EmailVerificationInProgress(
      verificationCode: verificationCode ?? this.verificationCode,
      isLoading: isLoading ?? this.isLoading,
      isResending: isResending ?? this.isResending,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      cooldownSeconds: cooldownSeconds ?? this.cooldownSeconds,
    );
  }

  @override
  List<Object?> get props => [
        verificationCode,
        isLoading,
        isResending,
        errorMessage,
        successMessage,
        cooldownSeconds,
      ];
}

class EmailVerificationSuccess extends EmailVerificationState {
  final ProfileEntity profile;

  const EmailVerificationSuccess({required this.profile});

  @override
  List<Object?> get props => [profile];
}

class EmailVerificationSkipped extends EmailVerificationState {
  const EmailVerificationSkipped();
}

class EmailVerificationFailure extends EmailVerificationState {
  final String message;

  const EmailVerificationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
