import 'package:equatable/equatable.dart';

import '../utils/login_identifier.dart';

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

/// A reset OTP has been sent. Carries the validity window + resend cooldown so
/// the OTP screen can render a countdown + gate the resend button, and the
/// channel the server ACTUALLY used so the screen can name where to look.
class PasscodeResetOtpSent extends PasscodeResetState {
  /// The identifier the user supplied (E.164 phone or email address).
  final String phone;
  final int expiresInSeconds;
  final int resendAfterSeconds;

  /// Where the code went. The server decides this, not the screen: the app
  /// asks for a channel and the server may only have one it can use.
  final ResetDeliveryChannel channel;

  /// Masked destination to show the user ("jo***@gmail.com"). Empty when the
  /// server did not supply one (an older backend), in which case the screen
  /// falls back to the identifier it already has.
  final String destinationMasked;

  const PasscodeResetOtpSent({
    required this.phone,
    required this.expiresInSeconds,
    required this.resendAfterSeconds,
    this.channel = ResetDeliveryChannel.phone,
    this.destinationMasked = '',
  });

  @override
  List<Object?> get props => [
        phone,
        expiresInSeconds,
        resendAfterSeconds,
        channel,
        destinationMasked,
      ];
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
