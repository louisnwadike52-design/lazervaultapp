part of 'email_verification_screen.dart';

/// Email OTP Verification Screen
///
/// This screen is shown after signup when the user needs to verify their email.
/// The OTP is automatically sent during signup.
///
/// Arguments:
/// - email: The email address to verify (required)
/// - codeSent: Whether the OTP was already sent (default: true)
/// - isRequired: Whether verification is mandatory or can be skipped (default: true)
/// - secondaryPhone: Phone number for secondary verification after email (optional)
class EmailVerificationScreen extends StatelessWidget {
  final String? email;
  final bool codeSent;
  final bool isRequired;
  final String? secondaryPhone;
  // When set, verifying (or skipping) navigates here instead of the default
  // email-onboarding chain. Used by the phone+passcode flow to continue to
  // transaction-PIN setup after the optional email step. Null = unchanged
  // email-flow behaviour.
  final String? nextRoute;
  // When true, the screen was launched from Settings (not onboarding): it
  // requests a fresh code on load and, on success, returns to Settings instead
  // of routing into the signup/passcode-setup chain. Skip is hidden.
  final bool fromSettings;

  const EmailVerificationScreen({
    super.key,
    this.email,
    this.codeSent = true,
    this.isRequired = true,
    this.secondaryPhone,
    this.nextRoute,
    this.fromSettings = false,
  });

  @override
  Widget build(BuildContext context) {
    // Extract arguments if passed via route
    final args = Get.arguments;
    String? emailArg = email;
    bool otpSent = codeSent;
    bool required = isRequired;
    String? secondaryPhoneArg = secondaryPhone;
    String? nextRouteArg = nextRoute;

    // Handle Map arguments - check for general Map type to handle both
    // Map<String, dynamic> and Map<String, Object> from route arguments
    if (args is Map) {
      final mapArgs = Map<String, dynamic>.from(args);
      emailArg = mapArgs['email']?.toString() ?? emailArg;
      otpSent = mapArgs['codeSent'] as bool? ?? otpSent;
      required = mapArgs['isRequired'] as bool? ?? required;
      secondaryPhoneArg = mapArgs['secondaryPhone']?.toString();
      nextRouteArg = mapArgs['nextRoute']?.toString() ?? nextRouteArg;
    } else if (args is String) {
      // Simple string argument (email only)
      emailArg = args;
    }

    return _EmailOtpVerificationView(
      email: emailArg ?? '',
      // From Settings we always want a fresh code requested on load.
      codeSent: fromSettings ? false : otpSent,
      isRequired: required,
      secondaryPhone: secondaryPhoneArg,
      nextRoute: nextRouteArg,
      fromSettings: fromSettings,
    );
  }
}

class _EmailOtpVerificationView extends StatefulWidget {
  final String email;
  final bool codeSent;
  final bool isRequired;
  final String? secondaryPhone;
  final String? nextRoute;
  final bool fromSettings;

  const _EmailOtpVerificationView({
    required this.email,
    required this.codeSent,
    required this.isRequired,
    this.secondaryPhone,
    this.nextRoute,
    this.fromSettings = false,
  });

  @override
  State<_EmailOtpVerificationView> createState() =>
      _EmailOtpVerificationViewState();
}
