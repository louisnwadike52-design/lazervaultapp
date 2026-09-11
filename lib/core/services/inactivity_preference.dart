import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

/// The user's idle-logout choice, cached so it can be read SYNCHRONOUSLY.
///
/// [InactivityWatcher] re-reads its threshold every time it re-arms, which
/// happens on every pointer event. Secure storage is async, so reading it
/// there would either await on the hot path or race the timer it is arming.
/// The value is loaded once at startup and rewritten whenever the user changes
/// it, which is the only way it can change.
///
/// Null means "follow the platform" — the admin-tuned registry value. That is
/// also the state after a failed load, so a storage error degrades to the
/// platform policy rather than to no timeout at all.
class InactivityPreference {
  const InactivityPreference._();

  static int? _seconds;

  /// The user's chosen timeout, or null to follow the platform default.
  static int? get seconds => _seconds;

  /// Load from storage. Safe to call more than once.
  static Future<void> load() async {
    try {
      _seconds =
          await serviceLocator<SecureStorageService>().getInactivityTimeoutSeconds();
    } catch (_) {
      // Fall back to the platform policy rather than leaving the session
      // unprotected — see the class note.
      _seconds = null;
    }
  }

  /// Persist a new choice (null = follow the platform) and update the cache in
  /// the same call, so the watcher picks it up on its very next re-arm rather
  /// than at the next app start.
  static Future<void> set(int? value) async {
    final store = serviceLocator<SecureStorageService>();
    await store.setInactivityTimeoutSeconds(value);
    // Re-read rather than trusting `value`: the setter clamps, so this keeps
    // the cache equal to what was actually stored.
    _seconds = await store.getInactivityTimeoutSeconds();
  }

  /// Drop the cached value — used on logout / user switch so the next user
  /// does not inherit the previous one's session policy.
  static void clear() => _seconds = null;
}
