import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/repositories/i_auth_repository.dart';
import 'passcode_reset_state.dart';

/// Drives the phone+passcode "Forgot your passcode?" reset flow:
/// request OTP → (collect code) → set new passcode. The OTP code is held here
/// across the passcode step and submitted together with the new passcode, since
/// the backend verifies + sets in a single call (ResetPasscodeWithOTP).
class PasscodeResetCubit extends Cubit<PasscodeResetState> {
  final IAuthRepository _authRepository;

  PasscodeResetCubit({required IAuthRepository authRepository})
      : _authRepository = authRepository,
        super(const PasscodeResetInitial());

  String _phone = '';
  String _countryCode = 'NG';
  String _code = '';

  String get phone => _phone;

  /// Step 1: send a reset OTP to [phone].
  Future<void> requestReset({
    required String phone,
    required String countryCode,
  }) async {
    if (isClosed || state is PasscodeResetLoading) return;
    _phone = phone;
    _countryCode = countryCode;
    emit(const PasscodeResetLoading());

    final result = await _authRepository.requestPasscodeReset(
      phone: phone,
      countryCode: countryCode,
    );
    if (isClosed) return;
    result.fold(
      (failure) => emit(PasscodeResetFailure(failure.message)),
      (otp) => emit(PasscodeResetOtpSent(
        phone: phone,
        expiresInSeconds: otp.expiresInSeconds,
        resendAfterSeconds: otp.resendAfterSeconds,
      )),
    );
  }

  /// Resend the OTP for the current phone.
  Future<void> resendOtp() =>
      requestReset(phone: _phone, countryCode: _countryCode);

  /// Step 2: stash the entered OTP so the passcode step can submit it.
  void setCode(String code) {
    _code = code;
  }

  /// Step 2 (validated): verify the entered OTP with the backend WITHOUT
  /// consuming it, so the UI can confirm the code the moment it is entered and
  /// only advance to the new-passcode step for a valid code. On success the code
  /// is stashed for the final [submitNewPasscode] call. A bad/expired code emits
  /// [PasscodeResetFailure] (with [restartFlow] when the session is unusable).
  Future<void> verifyCode(String code) async {
    if (isClosed || state is PasscodeResetLoading) return;
    emit(const PasscodeResetLoading());

    final result = await _authRepository.verifyPasscodeReset(
      phone: _phone,
      code: code,
      countryCode: _countryCode,
    );
    if (isClosed) return;
    result.fold(
      (failure) {
        final lower = failure.message.toLowerCase();
        final badCode = lower.contains('code') &&
            (lower.contains('incorrect') ||
                lower.contains('expired') ||
                lower.contains('no attempts') ||
                lower.contains('request a'));
        emit(PasscodeResetFailure(failure.message, restartFlow: badCode));
      },
      (_) {
        _code = code;
        emit(const PasscodeResetCodeVerified());
      },
    );
  }

  /// Step 3: set the new passcode, submitting it with the stashed OTP.
  Future<void> submitNewPasscode(String newPasscode) async {
    if (isClosed || state is PasscodeResetLoading) return;
    if (_code.isEmpty) {
      emit(const PasscodeResetFailure(
        'Your reset session expired. Please start again.',
        restartFlow: true,
      ));
      return;
    }
    emit(const PasscodeResetLoading());

    final result = await _authRepository.resetPasscodeWithOtp(
      phone: _phone,
      code: _code,
      newPasscode: newPasscode,
    );
    if (isClosed) return;
    result.fold(
      (failure) {
        final lower = failure.message.toLowerCase();
        // A bad/expired code means the OTP step must be redone.
        final badCode = lower.contains('code') &&
            (lower.contains('incorrect') ||
                lower.contains('expired') ||
                lower.contains('no attempts') ||
                lower.contains('request a'));
        emit(PasscodeResetFailure(failure.message, restartFlow: badCode));
      },
      (_) => emit(const PasscodeResetSuccess()),
    );
  }
}
