import 'package:flutter/foundation.dart';
import 'package:lazervault/core/services/account_summaries_store.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';

/// The signed-in user's id, SYNCHRONOUSLY, for stamping a [SessionPageStore].
///
/// A cubit that wants to paint a remembered page before its first `await`
/// needs the user id without going to secure storage. The app-wide
/// `AuthenticationCubit` is a lazy singleton that already holds the profile,
/// so that is the source; the dashboard's `AccountSummariesStore` stamp is
/// the fallback for the brief window before the profile is bound.
///
/// Returns '' when nobody is signed in or the locator is not set up (tests).
/// `SessionPageStore.put` ignores an empty id and `peek` never matches one,
/// so an unknown user simply means "no cached paint" — never a wrong one.
class SessionUserId {
  SessionUserId._();

  /// Test hook: replace the resolver so cubit tests need no service locator.
  @visibleForTesting
  static String Function()? resolverForTest;

  static String current() {
    final override = resolverForTest;
    if (override != null) return override();
    try {
      final fromAuth = serviceLocator<AuthenticationCubit>().userId;
      if (fromAuth != null && fromAuth.isNotEmpty) return fromAuth;
    } catch (_) {
      // Locator not initialised (tests) or cubit not registered yet.
    }
    return AccountSummariesStore.userId ?? '';
  }
}
