import 'package:flutter/foundation.dart';
import 'package:lazervault/core/cache/session_user_id.dart';

/// The signed-in user's id for stamping a [SessionPageStore], or '' when
/// nobody is signed in (the store then refuses to remember, and the screen
/// simply behaves as it did before — a loader on this open).
///
/// A function-shaped alias of [SessionUserId.current] — one implementation,
/// two spellings, because the stores were written by two hands on the same
/// day. Prefer [SessionUserId.current] in new code.
String sessionPageUserId() {
  final override = sessionPageUserIdOverride;
  if (override != null) return override;
  return SessionUserId.current();
}

/// Test hook: stand in for the signed-in user without wiring the locator.
@visibleForTesting
String? sessionPageUserIdOverride;
