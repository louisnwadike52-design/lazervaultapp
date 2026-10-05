/// How long a PIN/passcode lock has left — sanitised.
///
/// THE BUG THIS EXISTS FOR
/// -----------------------
/// A real user was shown:
///
///   "Your transaction PIN has been locked due to too many failed attempts.
///    Please try again in -29854057 minutes and 14 seconds."
///
/// That is ~56.8 years BEFORE now, which is the signature of an unset
/// timestamp: the server left the field empty, protobuf decoded it as epoch 0,
/// and the dialog subtracted 1970 from today without ever asking whether the
/// answer was sane. Other surfaces formatted the same value as days, so the
/// same bug there reads "20732d 4h 7m".
///
/// The server side is fixed too, but a client must never be one empty field
/// away from telling someone their money is locked for half a century. Every
/// lock countdown in the app goes through here.
library;

/// The longest a transaction-PIN lock can legitimately last.
///
/// Mirrors `transactionpin.DefaultPinConfig().LockoutDuration` in auth-service
/// (5 minutes). Anything longer than this coming back from the server is a bug
/// in the server, and the right response is to show the policy maximum rather
/// than relay a number that cannot be true.
const Duration kMaxPinLockout = Duration(minutes: 5);

/// Remaining lock time, or null when it cannot be established.
///
/// Returns:
///   * `null`  — no usable expiry. The caller should state the policy ("try
///               again in a few minutes") instead of inventing a countdown.
///   * `zero`  — the lock has already lifted; the caller may let them retry.
///   * capped  — a real remaining duration, never longer than [max].
///
/// [now] is injectable so this is testable without clock games.
Duration? pinLockRemaining(
  DateTime? lockedUntil, {
  Duration max = kMaxPinLockout,
  DateTime? now,
}) {
  if (lockedUntil == null) return null;

  // An unset protobuf Timestamp decodes to 1970-01-01. Treat anything near the
  // epoch as "the server told us nothing", NOT as a lock that expired 56 years
  // ago — the difference matters because a caller may reasonably retry on zero.
  if (lockedUntil.isBefore(DateTime.utc(2000))) return null;

  final current = now ?? DateTime.now();
  final remaining = lockedUntil.difference(current);

  if (remaining.isNegative) return Duration.zero;
  // A value beyond the policy maximum cannot be a real PIN lock. Cap it rather
  // than relay it: the user still learns they must wait, and nobody is told to
  // come back next year.
  if (remaining > max) return max;
  return remaining;
}

/// Human-readable countdown for a sanitised duration.
///
/// Never renders a negative or an absurd value because it only ever receives
/// output from [pinLockRemaining].
String formatPinLockRemaining(Duration? remaining) {
  if (remaining == null) {
    // No reliable expiry. State the policy, which is true regardless, instead
    // of a number we cannot stand behind.
    return 'in a few minutes';
  }
  if (remaining <= Duration.zero) return 'now';

  final minutes = remaining.inMinutes;
  final seconds = remaining.inSeconds % 60;
  if (minutes <= 0) {
    return 'in $seconds second${seconds == 1 ? '' : 's'}';
  }
  if (seconds == 0) {
    return 'in $minutes minute${minutes == 1 ? '' : 's'}';
  }
  return 'in $minutes minute${minutes == 1 ? '' : 's'} '
      'and $seconds second${seconds == 1 ? '' : 's'}';
}

/// The full sentence shown when a PIN is locked.
///
/// Kept here so every surface says the same thing, and so the "what do we say
/// when we don't know" decision is made once.
String pinLockedMessage(Duration? remaining) =>
    'Your transaction PIN is locked after too many failed attempts. '
    'Please try again ${formatPinLockRemaining(remaining)}. '
    'You can reset it now if you have forgotten it.';
