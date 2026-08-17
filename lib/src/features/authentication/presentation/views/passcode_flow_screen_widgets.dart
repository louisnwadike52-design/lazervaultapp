part of 'passcode_flow_screen.dart';

/// The three settings-area passcode operations.
///
/// `setup`  : first-time passcode creation (current password gate). Calls
///            `IdentityCubit.setPasscode` → auth-service `RegisterPasscode`.
/// `change` : current → new → confirm. Calls `ChangePasscodeUseCase` →
///            auth-service `ChangePasscode`.
/// `reset`  : OTP-verified passcode reset entered after a `verify-reset-otp`
///            flow has issued a short-lived reset token (passed via
///            `resetToken`). Calls `ChangePasscodeUseCase` with an empty
///            current — backend distinguishes via the reset token header.
///
/// Replaces the three sibling screens that used to live at:
///   * `identity/presentation/view/passcode_setup_screen.dart`
///   * `authentication/presentation/views/change_passcode_screen.dart`
///
/// The first-login onboarding `passcode_setup_screen.dart` (which advances
/// to transaction PIN setup + dashboard) is intentionally kept separate —
/// its post-success navigation is tied to the signup pipeline.
enum PasscodeFlowMode { setup, change, reset }

class PasscodeFlowScreenArgs {
  final PasscodeFlowMode mode;

  /// When [mode] == `setup`, the user's account password is required to
  /// authorise creating the passcode (matches auth-service contract).
  final String? accountPassword;

  /// When [mode] == `reset`, the verified reset-OTP token to authorise the
  /// new passcode write without a current passcode.
  final String? resetToken;

  const PasscodeFlowScreenArgs({
    required this.mode,
    this.accountPassword,
    this.resetToken,
  });
}
