part of 'phone_verification_screen.dart';

/// Phone OTP Verification Screen
///
/// This screen is shown after signup when the user needs to verify their phone number.
/// The OTP is automatically sent during signup, so this screen shows the OTP input directly.
///
/// Arguments:
/// - phoneNumber: The phone number to verify (required)
/// - codeSent: Whether the OTP was already sent (default: true when coming from signup)
/// - expiresIn: Seconds until the OTP expires, as the SERVER reported it.
///   There is no default: see the note on the countdown below — inventing one
///   showed a timer the database did not honour.
/// - isRequired: Whether verification is mandatory or can be skipped (default: true)
/// - secondaryEmail: Email for secondary verification after phone (optional)
class PhoneVerificationScreen extends StatelessWidget {
  final String? phoneNumber;
  final bool codeSent;
  final int? expiresIn;
  final bool isRequired;
  final String? secondaryEmail;
  final String? nextRoute;
  final Map<String, dynamic>? nextRouteArgs;
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
    this.nextRouteArgs,
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
    Map<String, dynamic>? nextRouteArgsArg = nextRouteArgs;
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
      if (m['nextRouteArgs'] is Map) {
        nextRouteArgsArg = Map<String, dynamic>.from(m['nextRouteArgs'] as Map);
      }
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
        // NO INVENTED FALLBACK. This read `expiry ?? 600`, so whenever the
        // server did not send an expiry the screen counted down from TEN
        // MINUTES — while the canonical server TTL
        // (auth_login_otp_ttl_seconds) is 120 SECONDS. The customer watched a
        // confident timer for eight minutes after their code had already
        // died, then typed it and was told it was wrong.
        //
        // A countdown we cannot source is worse than none: it is trusted
        // precisely because it looks authoritative. 0 means "unknown", and
        // _startExpiryCountdown ignores a non-positive value, so the row
        // simply does not render until a real expiry arrives from the send
        // response (PhoneVerificationState.expiresIn).
        expiresIn: expiry ?? 0,
        isRequired: required,
        secondaryEmail: secondaryEmailArg,
        nextRoute: nextRouteArg,
        nextRouteArgs: nextRouteArgsArg,
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
  final Map<String, dynamic>? nextRouteArgs;
  final bool fromSettings;

  const _PhoneOtpVerificationView({
    required this.phoneNumber,
    required this.codeSent,
    required this.expiresIn,
    required this.isRequired,
    this.secondaryEmail,
    this.nextRoute,
    this.nextRouteArgs,
    this.fromSettings = false,
  });

  @override
  State<_PhoneOtpVerificationView> createState() =>
      _PhoneOtpVerificationViewState();
}
