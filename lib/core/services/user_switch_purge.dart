import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/account_summaries_store.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/move_money/cubit/mandate_cubit.dart';
import 'package:lazervault/src/features/notifications/presentation/cubit/notification_badge_cubit.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_conversations_cubit.dart';
import 'package:lazervault/src/features/pending_actions/presentation/cubit/pending_actions_cubit.dart';
import 'package:lazervault/src/features/split_bills/presentation/cubit/split_bill_count_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_chat_history_cubit.dart';

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
  // Biometric-login opt-ins are PER USER: without purging them a user switch
  // carried the previous user's Face ID/fingerprint enablement into the new
  // session — and (worse) the biometric-preserving logout would then keep the
  // NEW user's session alive on the strength of the OLD user's setting.
  'face_login_enabled',
  'fingerprint_login_enabled',
  'voice_login_enabled',
  // Same reasoning: how the prompt FIRES is the previous user's preference. A
  // new account inheriting "ask automatically" would meet a Face ID sheet it
  // never asked for, before it had even enabled the biometric.
  'biometric_auto_prompt',
  'biometric_auto_prompt_face',
  'biometric_auto_prompt_fingerprint',
  // And whether the shake escape is armed. Clearing both together means a new
  // account starts on the documented defaults (automatic, escape armed) rather
  // than inheriting a half-configured pair — automatic ON with the only way out
  // of it switched OFF by someone else.
  'biometric_shake_escape',
  'biometric_swipe_up',
  // How long the app may sit idle before signing you out. One person's session
  // policy must not govern the next person's session on a shared device.
  'inactivity_timeout_seconds',
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
/// The CACHE half of [purgeStaleUserCache], without touching credentials.
///
/// For a switch that is TEMPORARY and must leave the operator's own login
/// intact — impersonation. Entering and leaving someone else's account is a
/// user switch in every way that matters to these caches:
///
///   * SWR holds the previous person's profile, accounts, tier, limits and
///     BALANCES. Without this, an admin entering impersonation is shown their
///     OWN cached figures while authenticated as the target — which defeats
///     the entire point of a feature whose purpose is to see what the user
///     sees, and sends support off to answer the wrong question. On the way
///     out, the target's figures persist into the admin's own session.
///   * AccountManager holds an ACTIVE ACCOUNT ID belonging to the other
///     person. Impersonation is read-only server-side (every write is refused
///     with IMPERSONATION_READ_ONLY), so this cannot move money — but it can
///     scope a read to an account the signed-in user does not own.
///
/// Deliberately does NOT delete [kPerUserStorageKeys] or the biometric
/// session, which [purgeStaleUserCache] does. Those are the admin's OWN
/// remembered identity — `stored_email`, `user_passcode`, `login_method` — and
/// clearing them on the way into a 15-minute impersonation session would log
/// the admin out of their own remembered login to come back to. A permanent
/// switch wants them gone; a temporary one must not touch them.
Future<void> purgeUserScopedCaches() async {
  try {
    if (serviceLocator.isRegistered<SWRCacheManager>()) {
      await serviceLocator<SWRCacheManager>().invalidateAll();
    }
  } catch (_) {/* best-effort */}
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
  _purgeSessionScopedSingletons();
}

/// Clears every LAZY SINGLETON that holds state belonging to one person.
///
/// A lazy singleton outlives the session that populated it, so anything
/// per-user it holds is shown to the NEXT person to sign in on the device
/// until a refetch happens to land. Reported in production: Chris's family
/// account appeared on Ella's dashboard after she logged in on the same phone.
///
/// This is the single place that list lives, and
/// test/core/user_switch_purge_coverage_test.dart fails the build if a new
/// lazy-singleton cubit is registered without being added here — the previous
/// arrangement purged four of them and silently missed six, because nothing
/// connected "register a singleton" to "clear it on a switch".
///
/// Every call is individually guarded: one unregistered or throwing singleton
/// must not stop the rest from being cleared, because a half-purged device is
/// exactly the state this exists to prevent.
void _purgeSessionScopedSingletons() {
  void safely(void Function() clear) {
    try {
      clear();
    } catch (_) {/* best-effort — never block the rest of the purge */}
  }

  // The process-wide account rows. Not a cubit — it outlives every cubit on
  // purpose — but it is the single most dangerous thing to carry across a
  // switch: it is what the money sheets resolve a FUNDING SOURCE from.
  safely(AccountSummariesStore.clear);

  safely(() {
    if (serviceLocator.isRegistered<MandateCubit>()) {
      // Direct Debit mandates: the previous user's bank, limits and expiry,
      // keyed by account ids the new user does not own.
      serviceLocator<MandateCubit>().clearOnLogout();
    }
  });
  safely(() {
    if (serviceLocator.isRegistered<StatisticsCubit>()) {
      // Spending analytics — balances, categories, trends.
      serviceLocator<StatisticsCubit>().clearOnLogout();
    }
  });
  safely(() {
    if (serviceLocator.isRegistered<SplitBillCountCubit>()) {
      // "You owe N bills" badge.
      serviceLocator<SplitBillCountCubit>().clearOnLogout();
    }
  });
  safely(() {
    if (serviceLocator.isRegistered<NotificationBadgeCubit>()) {
      serviceLocator<NotificationBadgeCubit>().clear();
    }
  });
  safely(() {
    if (serviceLocator.isRegistered<BudgetCubit>()) {
      serviceLocator<BudgetCubit>().clearCategoryCache();
    }
  });
  safely(() {
    if (serviceLocator.isRegistered<VoiceChatHistoryCubit>()) {
      // Conversation history is the most plainly private of all of these.
      serviceLocator<VoiceChatHistoryCubit>().clearAll();
    }
  });
  safely(() {
    if (serviceLocator.isRegistered<PendingActionsCubit>()) {
      serviceLocator<PendingActionsCubit>().clear();
    }
  });
  safely(() {
    if (serviceLocator.isRegistered<P2PConversationsCubit>()) {
      // Chat threads: names, last messages, unread counts.
      serviceLocator<P2PConversationsCubit>().clearOnLogout();
    }
  });
}

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
  _purgeSessionScopedSingletons();
}
