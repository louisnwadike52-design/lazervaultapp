import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';

/// Per-user state that must not outlive the user it belongs to.
///
/// This lives outside any cubit because there is MORE THAN ONE login path that
/// persists a session — AuthenticationCubit._saveSession (email/password,
/// email+passcode, step-up OTP) and PhonePasscodeCubit._persistSession (phone
/// signup + phone login). The purge originally existed only in the first, so
/// signing in as a different person over the phone path — the primary path on
/// a phone_passcode deployment — left the previous user's passcode credential,
/// cached BVN/NIN, biometric refresh token, SWR-cached balances and active
/// account in place for the new user.
///
/// Anything added here is a key or singleton that is keyed to ONE person.

/// Secure-storage keys written per user. Two classes live here and both matter:
///
///  * DISPLAY state (name, avatar) — cosmetic, but showing the previous user's
///    name to a new one is its own bug.
///  * LOGIN IDENTIFIERS (`stored_phone`, `stored_email`, `user_email`) — these
///    are submitted VERBATIM by the returning-user lock screen. A stale one is
///    not a cosmetic slip: it spends a failed-login attempt against whoever the
///    identifier really belongs to, and three of those lock THAT person out of
///    their own account. This is not hypothetical — it happened on prod.
const List<String> kPerUserStorageKeys = [
  'user_passcode',
  'user_avatar_url',
  'user_first_name',
  'user_last_name',
  'login_method',
  'has_passcode',
  'kyc_onboarding_pending',
  'has_skipped_kyc',
  'chat_current_session_id',
  'stored_phone',
  'stored_email',
  'user_email',
  'preferred_login_method',
];

/// True when [newUserId]/[newEmail] describe someone other than whoever this
/// device last stored. Callers pass what they already read so this makes no
/// extra storage round trip.
bool isUserSwitch({
  required String? previousUserId,
  required String? previousEmail,
  required String newUserId,
  required String newEmail,
}) {
  final byId = previousUserId != null &&
      previousUserId.isNotEmpty &&
      previousUserId != newUserId;
  // NOTE: a non-empty previous email vs an EMPTY new one still counts as a
  // switch. Phone-only accounts legitimately have no email, and "the last user
  // had one, this one doesn't" is a different person — erring toward purging is
  // the safe direction here, since the cost of a spurious purge is re-fetching
  // caches while the cost of a missed one is one user seeing another's data.
  final byEmail = previousEmail != null &&
      previousEmail.isNotEmpty &&
      previousEmail.toLowerCase() != newEmail.toLowerCase();
  return byId || byEmail;
}

/// Drop every per-user cache that survives a logout.
///
/// Best-effort throughout: an individual failure is swallowed so a partial
/// purge can never block (or crash) the new user's sign-in. Callers must still
/// treat their own identity assignment as separate from this — a failure here
/// must not leave the app authenticated as nobody.
Future<void> purgeStaleUserCache(FlutterSecureStorage storage) async {
  // 1. Per-user secure-storage keys. A same-user re-login deliberately KEEPS
  // these (the "remember me" UX); only a confirmed SWITCH gets here.
  for (final key in kPerUserStorageKeys) {
    try {
      await storage.delete(key: key);
    } catch (_) {/* best-effort */}
  }

  // Cached identity numbers (BVN/NIN) are PII keyed to the prior user.
  try {
    if (serviceLocator.isRegistered<SecureStorageService>()) {
      await serviceLocator<SecureStorageService>().deleteIdentityNumbers();
    }
  } catch (_) {/* best-effort */}

  // The durable biometric session belongs to the PRIOR user — never let the
  // new user inherit it (biometric_user_id would also mismatch, but drop the
  // token itself so a stale refresh token can't linger on a shared device).
  try {
    if (serviceLocator.isRegistered<SecureStorageService>()) {
      await serviceLocator<SecureStorageService>().clearBiometricSession();
    }
  } catch (_) {/* best-effort */}

  // 2. SWR API cache (per-user profile/accounts/tier/limits/balances).
  try {
    if (serviceLocator.isRegistered<SWRCacheManager>()) {
      await serviceLocator<SWRCacheManager>().invalidateAll();
    }
  } catch (_) {/* best-effort */}

  // 3. In-memory singleton state that outlives a session.
  try {
    if (serviceLocator.isRegistered<AccountManager>()) {
      serviceLocator<AccountManager>().clearActiveAccount();
    }
  } catch (_) {/* best-effort */}
  try {
    if (serviceLocator.isRegistered<CurrencySyncService>()) {
      serviceLocator<CurrencySyncService>().clear();
    }
  } catch (_) {/* best-effort */}
  try {
    if (serviceLocator.isRegistered<GroupAccountCubit>()) {
      serviceLocator<GroupAccountCubit>().clearOnLogout();
    }
  } catch (_) {/* best-effort */}
}
