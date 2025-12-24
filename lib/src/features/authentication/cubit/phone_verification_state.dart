import 'package:equatable/equatable.dart';

sealed class PhoneVerificationState extends Equatable {
  const PhoneVerificationState();

  @override
  List<Object?> get props => [];
}

// Initial state
class PhoneVerificationInitial extends PhoneVerificationState {}

// Loading states
class PhoneVerificationSending extends PhoneVerificationState {}

class PhoneVerificationVerifying extends PhoneVerificationState {}

// In-progress state with optional error/success messages
class PhoneVerificationInProgress extends PhoneVerificationState {
  final String phoneNumber;
  final String verificationCode;
  final bool isSending;
  final bool isVerifying;
  final String errorMessage;
  final String successMessage;

  const PhoneVerificationInProgress({
    this.phoneNumber = '',
    this.verificationCode = '',
    this.isSending = false,
    this.isVerifying = false,
    this.errorMessage = '',
    this.successMessage = '',
  });

  PhoneVerificationInProgress copyWith({
    String? phoneNumber,
    String? verificationCode,
    bool? isSending,
    bool? isVerifying,
    String? errorMessage,
    String? successMessage,
  }) {
    return PhoneVerificationInProgress(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationCode: verificationCode ?? this.verificationCode,
      isSending: isSending ?? this.isSending,
      isVerifying: isVerifying ?? this.isVerifying,
      errorMessage: errorMessage ?? '',
      successMessage: successMessage ?? '',
    );
  }

  @override
  List<Object?> get props => [
        phoneNumber,
        verificationCode,
        isSending,
        isVerifying,
        errorMessage,
        successMessage,
      ];
}

// Success state - code sent
class PhoneVerificationCodeSent extends PhoneVerificationState {
  final String message;
  final String? verificationId;
  final int? expiresIn;

  const PhoneVerificationCodeSent({
    required this.message,
    this.verificationId,
    this.expiresIn,
  });

  @override
  List<Object?> get props => [message, verificationId, expiresIn];
}

// Success state - phone verified
class PhoneVerificationSuccess extends PhoneVerificationState {
  final String message;

  const PhoneVerificationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

// Failure state
class PhoneVerificationFailure extends PhoneVerificationState {
  final String message;

  const PhoneVerificationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

// Skipped state
class PhoneVerificationSkipped extends PhoneVerificationState {}
