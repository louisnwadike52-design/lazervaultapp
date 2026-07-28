import 'package:equatable/equatable.dart';

/// States for the phone+passcode "Forgot your passcode?" reset flow.
///
/// The backend verifies the OTP and sets the new passcode in a single call
/// (ResetPasscodeWithOTP), so there is no separate "OTP verified" state — the
/// screen collects the code locally and submits it together with the new
/// passcode.
abstract class PasscodeResetState extends Equatable {
  const PasscodeResetState();

  @override
  List<Object?> get props => [];
}

/// Idle / nothing in flight.
class PasscodeResetInitial extends PasscodeResetState {
  const PasscodeResetInitial();
}

/// A repository call is in flight (request OTP, submit reset).
class PasscodeResetLoading extends PasscodeResetState {
  const PasscodeResetLoading();
}

/// A reset OTP has been sent to the phone. Carries the validity window + resend
/// cooldown so the OTP screen can render a countdown + gate the resend button.
class PasscodeResetOtpSent extends PasscodeResetState {
  final String phone;
  final int expiresInSeconds;
  final int resendAfterSeconds;

  const PasscodeResetOtpSent({
    required this.phone,
    required this.expiresInSeconds,
    required this.resendAfterSeconds,
  });

  @override
  List<Object?> get props => [phone, expiresInSeconds, resendAfterSeconds];
}

/// The entered OTP was validated by the backend WITHOUT being consumed. The
/// screen may now advance to the new-passcode step. An invalid/expired code
/// never reaches this state (it surfaces as [PasscodeResetFailure]).
class PasscodeResetCodeVerified extends PasscodeResetState {
  const PasscodeResetCodeVerified();
}

/// The new passcode was set. The user can now log in with it.
class PasscodeResetSuccess extends PasscodeResetState {
  const PasscodeResetSuccess();
}

/// A failure; [message] is safe to surface to the user.
///   - [restartFlow]: the reset session is unusable (e.g. too many wrong codes)
///     and the screen should send the user back to the phone step.
class PasscodeResetFailure extends PasscodeResetState {
  final String message;
  final bool restartFlow;

  const PasscodeResetFailure(this.message, {this.restartFlow = false});

  @override
  List<Object?> get props => [message, restartFlow];
}
