import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/kyc/presentation/views/bvn_signup_screen.dart';

/// Where onboarding's identity step should send this customer right now.
///
/// ONE DECISION, TWO CALLERS, AND THEY MUST NOT DRIFT. It is made at the end
/// of transaction-PIN setup, and again by the boot router when the app is
/// relaunched after being killed mid-onboarding. Those were separate pieces of
/// code and they disagreed:
///
///   * PIN setup (after the 492 change) sends the customer to the identity
///     screen for whichever number the admin switch selects.
///   * The boot router hardcoded `AppRoutes.kycBVNVerification`.
///
/// So a customer killed at the identity screen came back to the MONO GATE
/// instead, and both branches lost what they exist for:
///
///   BVN on  — the BVN is never captured, so no Tier 2 and no account number,
///             and the Mono widget appears in onboarding on the exact branch
///             that is supposed to remove it.
///   BVN off — Mono is initiated with the typed, unverified name, which is the
///             refusal the NIN screen was added to prevent.
///
/// Reads the same store `saveBvn`/`saveNin` write to (both the DI-registered
/// FlutterSecureStorage and main.dart's own use `encryptedSharedPreferences`,
/// verified 2026-11-09), so "already on file" means the same thing to both
/// callers.
///
/// Never throws: the boot router cannot fail to produce a route.
Future<String> resolveOnboardingIdentityRoute() async {
  final kind = IdentityKind.active;
  String? stored;
  try {
    final storage = serviceLocator<SecureStorageService>();
    stored = kind.isBvn ? await storage.getBvn() : await storage.getNin();
  } catch (_) {
    // Storage unavailable — show the screen and let it ask. Asking a customer
    // for a number they already gave is a far smaller harm than skipping the
    // step that mints their account.
    return AppRoutes.bvnSignup;
  }

  final haveNumber = stored != null && stored.trim().isNotEmpty;
  if (!haveNumber) return AppRoutes.bvnSignup;

  // Already on file, so the identity step is done. Where "done" leads differs
  // by branch — see BVNSignupScreen._nextRoute, which encodes the same rule
  // for the in-session path.
  return kind.isBvn ? AppRoutes.dashboard : AppRoutes.kycBVNVerification;
}
