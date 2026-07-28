import 'package:equatable/equatable.dart';
import '../domain/entities/profile_entity.dart';

/// States for the dedicated phone + passcode authentication flow.
///
/// Mirrors the sealed-style structure of [AuthenticationState] (Equatable
/// base, one class per distinct UI state). The working data collected across
/// the signup journey (phone, signupToken, passcode, names) is held on the
/// cubit itself; these states only carry what a screen needs to render.
abstract class PhonePasscodeState extends Equatable {
  const PhonePasscodeState();

  @override
  List<Object?> get props => [];
}

/// Idle / nothing in flight.
class PhonePasscodeInitial extends PhonePasscodeState {
  const PhonePasscodeInitial();
}

/// A repository call is in flight (OTP request, verify, signup, login).
class PhonePasscodeLoading extends PhonePasscodeState {
  const PhonePasscodeLoading();
}

/// A signup OTP has been sent to the phone. Carries the OTP validity window
/// and the resend cooldown so the OTP screen can render a countdown + gate the
/// resend button.
class PhoneOtpSent extends PhonePasscodeState {
  final String phone;
  final int expiresInSeconds;
  final int resendAfterSeconds;

  const PhoneOtpSent({
    required this.phone,
    required this.expiresInSeconds,
    required this.resendAfterSeconds,
  });

  @override
  List<Object?> get props => [phone, expiresInSeconds, resendAfterSeconds];
}

/// The signup OTP was verified; [signupToken] is the single-use token used to
/// complete signup. Held in cubit state (and persisted) so the flow can resume.
class PhoneOtpVerified extends PhonePasscodeState {
  final String signupToken;

  const PhoneOtpVerified(this.signupToken);

  @override
  List<Object?> get props => [signupToken];
}

/// The user has chosen + confirmed their passcode (still in memory; the account
/// is created on [submitSignup]).
class PhonePasscodeSet extends PhonePasscodeState {
  const PhonePasscodeSet();
}

/// Phone-primary account created + session persisted. At this point an email
/// verification code has been sent to the supplied email, so the email step can
/// reveal its code-entry section.
class PhoneSignupSuccess extends PhonePasscodeState {
  final ProfileEntity profile;

  const PhoneSignupSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// The email verification code was confirmed — the account's email is now
/// verified. The email step advances to transaction-PIN setup.
class PhoneEmailVerified extends PhonePasscodeState {
  final ProfileEntity profile;

  const PhoneEmailVerified(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// A fresh email verification code was sent (resend). Carries the resend
/// cooldown so the email step can restart its countdown.
class PhoneEmailCodeResent extends PhonePasscodeState {
  final int cooldownSeconds;

  const PhoneEmailCodeResent(this.cooldownSeconds);

  @override
  List<Object?> get props => [cooldownSeconds];
}

/// Phone + passcode login succeeded + session persisted.
class PhoneLoginSuccess extends PhonePasscodeState {
  final ProfileEntity profile;

  const PhoneLoginSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

/// 2FA required: the phone+passcode user has 2FA enabled. The screen routes to
/// TwoFactorVerificationScreen with the temp token + method.
class PhoneLoginTwoFactorRequired extends PhonePasscodeState {
  final String twoFactorToken;
  final String method;

  const PhoneLoginTwoFactorRequired({required this.twoFactorToken, required this.method});

  @override
  List<Object?> get props => [twoFactorToken, method];
}

/// Risk-based step-up: the phone+passcode login (incl. switch-user) needs a
/// one-time code before a session is issued. The screen routes to LoginOtpScreen.
class PhoneLoginStepUpRequired extends PhonePasscodeState {
  final String stepUpToken;
  final String method;      // "email" | "sms"
  final String destination; // masked

  const PhoneLoginStepUpRequired({
    required this.stepUpToken,
    required this.method,
    required this.destination,
  });

  @override
  List<Object?> get props => [stepUpToken, method, destination];
}

/// A failure; [message] is safe to surface to the user.
///   - [restartFlow]: the signup session is gone/expired and can't continue —
///     the screen should send the user back to the start (phone entry).
///   - [alreadyRegistered]: the phone/email already has an account — the screen
///     should offer to log in instead.
class PhonePasscodeFailure extends PhonePasscodeState {
  final String message;
  final bool restartFlow;
  final bool alreadyRegistered;

  const PhonePasscodeFailure(
    this.message, {
    this.restartFlow = false,
    this.alreadyRegistered = false,
  });

  @override
  List<Object?> get props => [message, restartFlow, alreadyRegistered];
}
