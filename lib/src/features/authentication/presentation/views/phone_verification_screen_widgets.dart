part of 'phone_verification_screen.dart';

/// Phone OTP Verification Screen
///
/// This screen is shown after signup when the user needs to verify their phone number.
/// The OTP is automatically sent during signup, so this screen shows the OTP input directly.
///
/// Arguments:
/// - phoneNumber: The phone number to verify (required)
/// - codeSent: Whether the OTP was already sent (default: true when coming from signup)
/// - expiresIn: Seconds until the OTP expires (optional, default: 600 seconds / 10 minutes)
/// - isRequired: Whether verification is mandatory or can be skipped (default: true)
/// - secondaryEmail: Email for secondary verification after phone (optional)
class PhoneVerificationScreen extends StatelessWidget {
  final String? phoneNumber;
  final bool codeSent;
  final int? expiresIn;
  final bool isRequired;
  final String? secondaryEmail;
  final String? nextRoute;
  // Launched from Settings: request a fresh code on load, return to Settings on
  // success, hide Skip.
  final bool fromSettings;

  const PhoneVerificationScreen({
    super.key,
    this.phoneNumber,
    this.codeSent = true, // Default true - OTP sent during signup
    this.expiresIn,
    this.isRequired = true,
    this.secondaryEmail,
    this.nextRoute,
    this.fromSettings = false,
  });

  @override
  Widget build(BuildContext context) {
    // Extract arguments if passed via route
    final args = Get.arguments;
    String? phone = phoneNumber;
    bool otpSent = codeSent;
    int? expiry = expiresIn;
    bool required = isRequired;
    String? secondaryEmailArg = secondaryEmail;
    String? nextRouteArg = nextRoute;
    // Whether this was launched from a logged-in profile surface (Settings / My
    // Account). MUST be parseable from route args so callers that push via
    // Get.toNamed can opt in — otherwise the screen falls into the onboarding
    // chain and "skip" routes to passcode setup, which is wrong post-login.
    bool settingsSource = fromSettings;

    if (args is Map) {
      final m = Map<String, dynamic>.from(args);
      phone = m['phoneNumber'] as String? ?? phone;
      otpSent = m['codeSent'] as bool? ?? otpSent;
      expiry = m['expiresIn'] as int? ?? expiry;
      required = m['isRequired'] as bool? ?? required;
      secondaryEmailArg = m['secondaryEmail'] as String?;
      nextRouteArg = m['nextRoute']?.toString() ?? nextRouteArg;
      settingsSource = m['fromSettings'] as bool? ?? settingsSource;
    } else if (args is String) {
      // Simple string argument (phone number only)
      phone = args;
    }

    return BlocProvider(
      create: (_) => serviceLocator<PhoneVerificationCubit>(),
      child: _PhoneOtpVerificationView(
        phoneNumber: phone ?? '',
        codeSent: settingsSource ? false : otpSent,
        expiresIn: expiry ?? 600, // Default 10 minutes
        isRequired: required,
        secondaryEmail: secondaryEmailArg,
        nextRoute: nextRouteArg,
        fromSettings: settingsSource,
      ),
    );
  }
}

class _PhoneOtpVerificationView extends StatefulWidget {
  final String phoneNumber;
  final bool codeSent;
  final int expiresIn;
  final bool isRequired;
  final String? secondaryEmail;
  final String? nextRoute;
  final bool fromSettings;

  const _PhoneOtpVerificationView({
    required this.phoneNumber,
    required this.codeSent,
    required this.expiresIn,
    required this.isRequired,
    this.secondaryEmail,
    this.nextRoute,
    this.fromSettings = false,
  });

  @override
  State<_PhoneOtpVerificationView> createState() =>
      _PhoneOtpVerificationViewState();
}
