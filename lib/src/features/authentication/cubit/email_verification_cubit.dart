import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/resend_verification_usecase.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/verify_email_usecase.dart';
import 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResendVerificationUseCase _resendVerificationUseCase;
  String _email = '';

  EmailVerificationCubit({
    required VerifyEmailUseCase verifyEmailUseCase,
    required ResendVerificationUseCase resendVerificationUseCase,
  })  : _verifyEmailUseCase = verifyEmailUseCase,
        _resendVerificationUseCase = resendVerificationUseCase,
        super(const EmailVerificationInitial());

  /// Initialize the cubit with the email address for resending verification
  void initialize(String email) {
    _email = email;
  }

  void updateVerificationCode(String code) {
    if (state is EmailVerificationInProgress) {
      final currentState = state as EmailVerificationInProgress;
      if (isClosed) return;
      // Clear both error and success messages when user types
      emit(currentState.copyWith(
        verificationCode: code,
        errorMessage: '',
        successMessage: '',
      ));
    } else {
      if (isClosed) return;
      emit(EmailVerificationInProgress(verificationCode: code));
    }
  }

  Future<void> verifyEmail() async {
    if (state is EmailVerificationInProgress) {
      final currentState = state as EmailVerificationInProgress;
      final code = currentState.verificationCode.trim();

      if (code.isEmpty) {
        if (isClosed) return;
        emit(currentState.copyWith(
          errorMessage: 'Please enter the verification code',
          isLoading: false,
        ));
        return;
      }

      // Validate 6-digit numeric code
      if (code.length != 6 || code.contains(RegExp(r'[^\d]'))) {
        if (isClosed) return;
        emit(currentState.copyWith(
          errorMessage: 'Please enter a valid 6-digit code',
          isLoading: false,
        ));
        return;
      }

      final finalCode = code;

      if (isClosed) return;
      // Clear messages before starting verification
      emit(currentState.copyWith(
        isLoading: true,
        errorMessage: '',
        successMessage: '',
      ));

      final result = await _verifyEmailUseCase(finalCode);

      if (isClosed) return;
      result.fold(
        (failure) {
          // BUILT FROM THE LIVE STATE, NOT FROM `currentState`.
          //
          // `currentState` is the snapshot taken BEFORE the await, so it still
          // carries whatever `successMessage` was set by an earlier resend —
          // "Verification code sent! Check your email." On a wrong code this
          // emitted an error state that ALSO claimed success, and the screen's
          // listener tests successMessage first: the user saw no error at all,
          // and the resend countdown restarted from 60 instead.
          //
          // The success message is cleared explicitly here. A failure is not
          // the moment to keep telling somebody their code was sent.
          final live = state;
          final base = live is EmailVerificationInProgress
              ? live
              : EmailVerificationInProgress(verificationCode: finalCode);
          emit(base.copyWith(
            isLoading: false,
            errorMessage: failure.message,
            successMessage: '',
            clearCooldown: true,
          ));
        },
        (profile) {
          emit(EmailVerificationSuccess(profile: profile));
        },
      );
    }
  }

  /// Resends the code and RETURNS the cooldown the server asked for, so a
  /// self-contained countdown control can drive itself from the outcome of
  /// this call instead of watching a sticky flag on the state.
  ///
  /// Returns null when nothing was sent (already in flight, or the resend
  /// failed) — the caller then leaves its countdown alone rather than arming
  /// a wait for a code that was never issued.
  Future<int?> resendVerificationEmail() async {
    if (state is EmailVerificationInProgress) {
      final currentState = state as EmailVerificationInProgress;

      if (currentState.isResending) {
        return null; // Already resending
      }

      if (isClosed) return null;
      // NO ADDRESS, NO REQUEST.
      //
      // Reached from a phone+passcode login the screen used to have no email
      // at all, so Resend posted an empty address, the server refused it, and
      // the customer read a validation error about a field they never saw
      // (reported 2026-11-25). Answer here instead, with the step that
      // actually fixes it — signing in again now returns the address with the
      // refusal, which is what populates this screen.
      if (_email.trim().isEmpty) {
        emit(currentState.copyWith(
          isResending: false,
          errorMessage:
              'We need your email address to send the code. Please sign in again, '
              'or message support if this keeps happening.',
          successMessage: '',
          clearCooldown: true,
        ));
        return null;
      }
      // Clear messages before starting resend
      emit(currentState.copyWith(
        isResending: true,
        errorMessage: '',
        successMessage: '',
      ));

      final result = await _resendVerificationUseCase(email: _email);

      if (isClosed) return null;
      // Same rule as verifyEmail: rebuild from the LIVE state so the outcome
      // of this resend cannot carry the message of the previous one, and so a
      // code the user typed while the request was in flight is not discarded.
      final live = state;
      final base =
          live is EmailVerificationInProgress ? live : currentState;
      return result.fold(
        (failure) {
          // A rate-limit refusal carries the real wait; anything else carries
          // none, and must not inherit the last one — see copyWith's note.
          final cooldown =
              failure is ServerFailure ? failure.cooldownSeconds : null;
          emit(base.copyWith(
            isResending: false,
            errorMessage: failure.message,
            successMessage: '',
            cooldownSeconds: cooldown,
            clearCooldown: cooldown == null,
          ));
          // Null, not the cooldown: nothing was sent. A rate-limit wait is
          // surfaced through the state's errorMessage/cooldownSeconds, which
          // is a different thing from "your new code is on its way".
          return null;
        },
        (cooldownSeconds) {
          emit(base.copyWith(
            isResending: false,
            successMessage: 'Verification code sent! Check your email.',
            errorMessage: '',
            cooldownSeconds: cooldownSeconds,
          ));
          return cooldownSeconds;
        },
      );
    } else {
      // Fresh mount: `initialize` only records the address, it does not emit,
      // so the first send arrives while the state is still Initial. Enter the
      // in-progress state and run the real path once.
      if (isClosed) return null;
      emit(const EmailVerificationInProgress(verificationCode: ''));
      return resendVerificationEmail();
    }
  }
}
