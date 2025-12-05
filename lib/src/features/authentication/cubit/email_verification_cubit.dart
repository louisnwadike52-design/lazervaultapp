import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/resend_verification_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/verify_email_usecase.dart';
import 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResendVerificationUseCase _resendVerificationUseCase;

  EmailVerificationCubit({
    required VerifyEmailUseCase verifyEmailUseCase,
    required ResendVerificationUseCase resendVerificationUseCase,
  })  : _verifyEmailUseCase = verifyEmailUseCase,
        _resendVerificationUseCase = resendVerificationUseCase,
        super(const EmailVerificationInitial());

  void updateVerificationCode(String code) {
    if (state is EmailVerificationInProgress) {
      final currentState = state as EmailVerificationInProgress;
      emit(currentState.copyWith(verificationCode: code, errorMessage: ''));
    } else {
      emit(EmailVerificationInProgress(verificationCode: code));
    }
  }

  Future<void> verifyEmail() async {
    if (state is EmailVerificationInProgress) {
      final currentState = state as EmailVerificationInProgress;
      final code = currentState.verificationCode.trim();

      if (code.isEmpty) {
        emit(currentState.copyWith(
          errorMessage: 'Please enter the verification code',
          isLoading: false,
        ));
        return;
      }

      if (code.length < 6) {
        emit(currentState.copyWith(
          errorMessage: 'Verification code must be at least 6 characters',
          isLoading: false,
        ));
        return;
      }

      emit(currentState.copyWith(isLoading: true, errorMessage: ''));

      final result = await _verifyEmailUseCase(code);

      result.fold(
        (failure) {
          print('Email verification failed: ${failure.message}');
          emit(currentState.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ));
        },
        (profile) {
          print('Email verified successfully');
          emit(EmailVerificationSuccess(profile: profile));
        },
      );
    }
  }

  Future<void> resendVerificationEmail() async {
    if (state is EmailVerificationInProgress) {
      final currentState = state as EmailVerificationInProgress;

      if (currentState.isResending) {
        return; // Already resending
      }

      emit(currentState.copyWith(isResending: true, errorMessage: ''));

      final result = await _resendVerificationUseCase();

      result.fold(
        (failure) {
          print('Failed to resend verification email: ${failure.message}');
          emit(currentState.copyWith(
            isResending: false,
            errorMessage: failure.message,
          ));
        },
        (_) {
          print('Verification email resent successfully');
          emit(currentState.copyWith(
            isResending: false,
            successMessage: 'Verification code sent! Check your email.',
          ));
        },
      );
    } else {
      emit(const EmailVerificationInProgress(verificationCode: ''));
      await resendVerificationEmail();
    }
  }

  void skipVerification() {
    emit(const EmailVerificationSkipped());
  }
}
