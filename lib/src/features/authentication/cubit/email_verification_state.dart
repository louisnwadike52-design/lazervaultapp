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

  const EmailVerificationInProgress({
    this.verificationCode = '',
    this.isLoading = false,
    this.isResending = false,
    this.errorMessage = '',
    this.successMessage = '',
  });

  EmailVerificationInProgress copyWith({
    String? verificationCode,
    bool? isLoading,
    bool? isResending,
    String? errorMessage,
    String? successMessage,
  }) {
    return EmailVerificationInProgress(
      verificationCode: verificationCode ?? this.verificationCode,
      isLoading: isLoading ?? this.isLoading,
      isResending: isResending ?? this.isResending,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
        verificationCode,
        isLoading,
        isResending,
        errorMessage,
        successMessage,
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
