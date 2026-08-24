import 'package:shared_preferences/shared_preferences.dart';

/// Remembers WHEN a mandate's Mono authorization was last GRANTED on this
/// device (the widget's explicit success callback — never a mere open/close,
/// which means nothing and must not change any badge).
///
/// Why: after authorization is granted, Mono/NIBSS provision the mandate for
/// up to ~30 minutes. During that window the mandate can still read
/// `awaiting_authorization` server-side (webhook latency), but the auth LINK
/// is spent — reopening it dead-ends in Mono's "Configuration error". With
/// this stamp the UI shows "Setting up" (and polls to converge); without it an
/// unauthorized mandate simply reads "One-time" (setup resumable from the
/// account action sheet).
class MandateAuthAttemptStore {
  MandateAuthAttemptStore._();

  static const _prefix = 'mandate_auth_opened_';

  /// How long a granted authorization renders as "Setting up". Mono's confirm
  /// window is "up to 30 minutes"; 40 gives headroom. If the mandate never
  /// converges (lost webhook AND Mono still unconfirmed), the badge decays
  /// back to "One-time" so the user can retry from the action sheet.
  static const window = Duration(minutes: 40);

  // In-memory mirror so UI code can check synchronously during build.
  static final Map<String, DateTime> _cache = {};
  static bool _hydrated = false;

  /// Load persisted stamps into the sync cache. Fire-and-forget from screen
  /// init; safe to call repeatedly.
  static Future<void> hydrate() async {
    if (_hydrated) return;
    _hydrated = true;
    try {
      final p = await SharedPreferences.getInstance();
      for (final k in p.getKeys()) {
        if (!k.startsWith(_prefix)) continue;
        final ms = p.getInt(k);
        if (ms == null) continue;
        final t = DateTime.fromMillisecondsSinceEpoch(ms);
        if (DateTime.now().difference(t) <= window) {
          _cache[k.substring(_prefix.length)] = t;
        } else {
          await p.remove(k); // expired — tidy up
        }
      }
    } catch (_) {
      // Best-effort; a failed hydrate just means the CTA shows as before.
    }
  }

  /// Stamp that authorization for [mandateId] was just GRANTED (call only on
  /// the auth widget's explicit success callback).
  static Future<void> markOpened(String mandateId) async {
    if (mandateId.isEmpty) return;
    final now = DateTime.now();
    _cache[mandateId] = now;
    try {
      final p = await SharedPreferences.getInstance();
      await p.setInt('$_prefix$mandateId', now.millisecondsSinceEpoch);
    } catch (_) {}
  }

  /// True when authorization for [mandateId] was granted within [window].
  static bool openedRecently(String mandateId) {
    final t = _cache[mandateId];
    return t != null && DateTime.now().difference(t) <= window;
  }

  /// Remove the stamp — used when the user closed the webview almost
  /// immediately (no payment can have happened), so the link is still fresh
  /// and Finish setup must reopen it rather than claim "confirming".
  static Future<void> clear(String mandateId) async {
    _cache.remove(mandateId);
    try {
      final p = await SharedPreferences.getInstance();
      await p.remove('$_prefix$mandateId');
    } catch (_) {}
  }
}
