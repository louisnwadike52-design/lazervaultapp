import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/notifications/notification_target.dart';

/// Disk backing for [PendingDeepLink], so a tapped notification survives the
/// app being KILLED during the login detour.
///
/// WHY THIS EXISTS
///
/// The stash was memory-only, which works for every case where the process
/// lives long enough to reach the dashboard. The one case it does not cover is
/// the most common one for a signed-out user:
///
///   1. a transfer push arrives and is tapped; the app cold-starts
///   2. there is no session, so the target is stashed and the login gate shows
///   3. login needs an EMAIL OTP, so the user LEAVES THE APP to read their mail
///   4. the OS reclaims the backgrounded app
///   5. they come back, log in — and the stash died with the process, so they
///      land on the dashboard with nothing explaining why
///
/// Step 3 is the killer: the login this gate demands is precisely the one that
/// sends the user out of the app, so the stash is at its most fragile exactly
/// when it is most needed.
///
/// WHAT IS PERSISTED
///
/// Two forms, because the two entry points carry different things:
///
///   * **link form** — the original `(type, data)` pair, stored as the canonical
///     `lazervault://n/<type>?<data>` URI. Re-RESOLVED on restore, so the
///     resolver stays the single source of truth for mapping and a resolver fix
///     reaches restored links too.
///   * **route form** — an explicit route plus arguments, for targets pushed
///     directly (a family invite, an escrow offer). Only persisted when the
///     arguments are JSON-safe; a target carrying a live object (the transaction
///     deep link passes a `TransactionServiceType` enum) is deliberately NOT
///     persisted in this form, which is why the link form is preferred.
///
/// OWNERSHIP IS PART OF THE RECORD
///
/// A target captured under a live session belongs to THAT user. Persisting it
/// without the owner would let it replay into whoever logs in next on a shared
/// device — showing one person's transfer to another. So the owner's id is
/// stored and checked on restore, and a captured-with-no-session target (a
/// fresh cold-start link, which belongs to whoever is opening it) stores no
/// owner and is replayable by anyone.
class PendingDeepLinkStore {
  const PendingDeepLinkStore._();

  static const String _key = 'pending_deep_link_v1';

  /// Overridable for tests. Production always uses SharedPreferences.
  static Future<SharedPreferences> Function() prefs =
      SharedPreferences.getInstance;

  /// Persists a `(type, data)` notification intent.
  static Future<void> saveLink({
    required String type,
    required Map<String, String> data,
    required DateTime stashedAt,
    required String? ownerUserId,
  }) =>
      _write({
        'form': 'link',
        'uri': NotificationLink.appUri(type, data).toString(),
        'at': stashedAt.toIso8601String(),
        if (ownerUserId != null && ownerUserId.isNotEmpty) 'owner': ownerUserId,
      });

  /// Persists an explicit route target, when its arguments can be represented.
  ///
  /// Returns false when they cannot — the caller keeps the in-memory stash and
  /// simply loses the cross-restart guarantee for that one target, which is
  /// strictly better than writing a record that would restore wrong.
  static Future<bool> saveRoute({
    required NotificationTarget target,
    required DateTime stashedAt,
    required String? ownerUserId,
  }) async {
    if (!isPersistableArguments(target.arguments)) return false;
    await _write({
      'form': 'route',
      'route': target.route,
      'args': target.arguments,
      'requiresAuth': target.requiresAuth,
      'precision': target.precision.name,
      'at': stashedAt.toIso8601String(),
      if (ownerUserId != null && ownerUserId.isNotEmpty) 'owner': ownerUserId,
    });
    return true;
  }

  /// Reads the stored record, or null when there is none or it cannot be read.
  ///
  /// Never throws: a corrupt or half-written record must not stop the app from
  /// starting, and the cost of discarding one is a notification that does not
  /// deep-link — the pre-existing behaviour.
  static Future<StoredDeepLink?> load() async {
    try {
      final p = await prefs();
      final raw = p.getString(_key);
      if (raw == null || raw.isEmpty) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      return StoredDeepLink.fromJson(Map<String, dynamic>.from(decoded));
    } catch (_) {
      return null;
    }
  }

  static Future<void> clear() async {
    try {
      final p = await prefs();
      await p.remove(_key);
    } catch (_) {
      // A failed clear is survivable: the staleness window and the owner check
      // both still bound what a leftover record can do.
    }
  }

  static Future<void> _write(Map<String, Object?> record) async {
    try {
      final p = await prefs();
      await p.setString(_key, jsonEncode(record));
    } catch (_) {
      // Persisting is an enhancement; the in-memory stash still works for the
      // same-process case. Never let it break a notification tap.
    }
  }

  /// Whether [args] round-trips through JSON unchanged.
  ///
  /// Deliberately strict. `jsonEncode` would happily turn an enum or an entity
  /// into a string via toString() and we would restore a target whose arguments
  /// the destination screen then rejects — a dead tap that looks like the bug
  /// this file fixes, which is worse than not persisting.
  static bool isPersistableArguments(Object? args) {
    if (args == null || args is String || args is num || args is bool) {
      return true;
    }
    if (args is Map) {
      return args.entries.every(
        (e) => e.key is String && isPersistableArguments(e.value),
      );
    }
    if (args is List) return args.every(isPersistableArguments);
    return false;
  }
}

/// A record read back from disk, before it has been re-resolved.
class StoredDeepLink {
  const StoredDeepLink({
    required this.stashedAt,
    this.ownerUserId,
    this.uri,
    this.route,
    this.arguments,
    this.requiresAuth = true,
    this.precision = TargetPrecision.record,
  });

  final DateTime stashedAt;

  /// Set when the target was captured under a live session. A restored target
  /// with an owner may only replay for that same user.
  final String? ownerUserId;

  /// Link form: re-resolve this to rebuild the target.
  final Uri? uri;

  /// Route form.
  final String? route;
  final Object? arguments;
  final bool requiresAuth;
  final TargetPrecision precision;

  bool get isLink => uri != null;

  /// Rebuilds the route-form target. Link-form records go through the resolver
  /// instead, so this returns null for them.
  NotificationTarget? toTarget() {
    final r = route;
    if (r == null || r.isEmpty) return null;
    return NotificationTarget(
      route: r,
      arguments: arguments,
      requiresAuth: requiresAuth,
      precision: precision,
    );
  }

  static StoredDeepLink? fromJson(Map<String, dynamic> j) {
    final at = DateTime.tryParse('${j['at']}');
    if (at == null) return null; // no timestamp means no staleness bound
    final owner = (j['owner'] as String?)?.trim();
    final form = '${j['form']}';

    if (form == 'link') {
      final uri = Uri.tryParse('${j['uri']}');
      if (uri == null) return null;
      return StoredDeepLink(
        stashedAt: at,
        ownerUserId: (owner == null || owner.isEmpty) ? null : owner,
        uri: uri,
      );
    }
    if (form == 'route') {
      final route = (j['route'] as String?)?.trim();
      if (route == null || route.isEmpty) return null;
      return StoredDeepLink(
        stashedAt: at,
        ownerUserId: (owner == null || owner.isEmpty) ? null : owner,
        route: route,
        arguments: j['args'],
        requiresAuth: j['requiresAuth'] != false,
        precision: TargetPrecision.values.firstWhere(
          (p) => p.name == '${j['precision']}',
          orElse: () => TargetPrecision.record,
        ),
      );
    }
    return null;
  }
}
