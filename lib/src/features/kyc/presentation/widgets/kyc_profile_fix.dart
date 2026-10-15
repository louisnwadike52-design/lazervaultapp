import 'package:get/get.dart';

import 'package:lazervault/src/features/profile/presentation/view/change_phone_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// WHEN KYC FAILS BECAUSE OF *OUR* PROFILE DATA, SAY WHERE TO FIX IT.
///
/// Several identity checks refuse before they ever reach the provider, because
/// the profile is missing something they need:
///
///   * no Nigerian phone ("0 followed by 10 digits")
///   * a phone that is present but unusable for verification
///   * no email
///   * no name
///
/// Each of those messages ends with "please update it and try again" — and the
/// dialog then offered exactly two buttons, Cancel and **Try Again**. Trying
/// again runs the identical check against the identical profile and fails the
/// identical way. The one thing the user had to do was the one thing the
/// screen would not take them to, and the place to do it is several taps away
/// inside Settings.
///
/// So the refusal now carries the fix. The classification reads the SERVER's
/// sentence rather than re-deriving the rule in the app: banking-service owns
/// what "valid" means for each provider, and a second copy here would drift
/// the first time a corridor changed.
enum KycProfileField { phone, email, name, none }

/// Which profile field a refusal is really about, or [KycProfileField.none]
/// when it is a provider/network failure the user cannot fix from Settings.
///
/// Substring matching, deliberately: these strings are produced by
/// prove_kyc.go and prove_kyc_progress.go and are shown verbatim, so matching
/// on their distinctive words survives rewording better than an exact compare,
/// and an unrecognised message correctly falls through to a plain Try Again.
KycProfileField kycProfileFieldFor(String? rawMessage) {
  final m = (rawMessage ?? '').toLowerCase();
  if (m.isEmpty) return KycProfileField.none;

  // Phone first: its messages are the most specific, and the Nigerian-number
  // one also contains the word "number", which nothing else does.
  if (m.contains('phone')) return KycProfileField.phone;
  if (m.contains('email')) return KycProfileField.email;
  // "we need your name on your profile" — guarded on "profile" so an
  // unrelated message mentioning a bank name is not mistaken for this.
  if (m.contains('name') && m.contains('profile')) return KycProfileField.name;
  return KycProfileField.none;
}

/// The primary button's label for [field]. Names the field, because "Open
/// Settings" leaves the user hunting for which setting.
String kycProfileFixLabel(KycProfileField field) {
  switch (field) {
    case KycProfileField.phone:
      return 'Update phone';
    case KycProfileField.email:
      return 'Update email';
    case KycProfileField.name:
      return 'Update profile';
    case KycProfileField.none:
      return 'Try Again';
  }
}

/// Takes the user to the right editor and reports whether anything changed.
///
/// A `true` result is the caller's cue to re-run verification immediately:
/// the user came here from a failed check, fixed the thing it complained
/// about, and should not have to find their way back and start again.
///
/// Phone has its own screen (it is OTP-verified, so it cannot be a text field
/// in a dialog). Name lives in the profile editor on the Settings screen, and
/// email is not directly editable today — both route to Settings, which is
/// where the editor is opened from, rather than pretending to a destination
/// that does not exist.
Future<bool> openKycProfileFix(KycProfileField field) async {
  switch (field) {
    case KycProfileField.phone:
      final changed = await Get.to(() => const ChangePhoneScreen());
      return changed == true;
    case KycProfileField.name:
    case KycProfileField.email:
      await Get.toNamed(AppRoutes.profileSettings);
      // Settings cannot tell us whether the user edited anything, so this
      // never auto-retries. Returning false leaves them on the KYC screen
      // with Continue still there, which is honest about what we know.
      return false;
    case KycProfileField.none:
      return false;
  }
}
