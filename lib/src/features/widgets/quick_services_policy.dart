/// Who decides the order of the quick-services grid, and who may change it.
///
/// THE PROBLEM THIS REPLACES. Order was decided by three things that could
/// each silently beat the others, none of them visible to an operator:
///
///   * `revenuePriority`, the shipped default;
///   * a saved hand-arrangement, per user, created by one drag and never
///     expiring;
///   * adaptive usage ordering, per user, behind a user-level toggle.
///
/// So airtime and data — ranked first by the operator precisely because they
/// are the errands people open the app for — rendered on the LAST page of
/// the carousel on a real device, and no setting anywhere could fix it. The
/// operator had an intent and no lever.
///
/// THE MODEL. The admin dashboard owns an ORDER and a set of LOCKS. A user
/// owns their arrangement only in the space the admin leaves them:
///
///   1. Services named in the admin order come first, in that order.
///   2. With enforcement on, that order is the WHOLE answer — user
///      arrangement and adaptive are ignored for every service.
///   3. Otherwise the rest fall to user arrangement, then adaptive, then
///      revenue priority, exactly as before.
///   4. A tile is draggable only if dragging is on globally, the service is
///      not individually locked, and it is not one of the ordered leaders.
///
/// Rule 4 matters more than it looks: a drag that "succeeds" on a pinned
/// service writes a hand-rank that would outrank the pin on the next build,
/// so allowing the gesture is how an admin's order quietly comes undone.
///
/// READ COST IS ZERO ON THE GESTURE PATH. Every value here comes from
/// SharedPreferences, which the settings poll fills in the background well
/// before anyone touches a tile. Nothing in this file awaits, and nothing
/// here may ever start doing so — a drag that has to ask the network whether
/// it is allowed is a dropped frame at best.
library;

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/services.dart';

/// Settings keys, all under `quick_service_` so they ride the app's existing
/// verbatim ingestion of that family — no new plumbing in the gateway, the
/// settings poll, or the app.
class QuickServiceKeys {
  QuickServiceKeys._();

  /// CSV of service slugs in the admin's intended order. These render first,
  /// in this order. Default pins the three the operator asked for.
  static const String order = 'quick_service_order';

  /// "false" releases the admin order, returning those services to the
  /// ordinary user-controlled list.
  static const String orderEnabled = 'quick_service_order_enabled';

  /// "true" makes the admin order the ONLY order — user arrangement and
  /// adaptive are ignored for every service, not just the named ones.
  static const String orderEnforcedAll = 'quick_service_order_enforced_all';

  /// CSV of slugs that may not be dragged, beyond the ordered leaders.
  static const String dragLocked = 'quick_service_drag_locked';

  /// "false" switches dragging off for everyone.
  static const String dragEnabled = 'quick_service_drag_enabled';

  /// "false" switches adaptive (usage-based) ordering off for all users,
  /// overriding each user's own preference.
  static const String adaptiveEnabled = 'quick_service_adaptive_enabled';
}

/// The resolved policy for one render.
///
/// Built once per build and passed down, so a grid of twenty tiles parses the
/// settings once rather than twenty times.
class QuickServicePolicy {
  const QuickServicePolicy({
    required this.orderedLeaders,
    required this.dragLocked,
    required this.dragEnabled,
    required this.enforcedForAll,
    required this.adaptiveAllowed,
  });

  /// Admin-ordered services, in render order. Empty when the order is off.
  final List<AppServiceName> orderedLeaders;

  /// Individually locked services, beyond the leaders.
  final Set<AppServiceName> dragLocked;

  /// Whether dragging is permitted at all.
  final bool dragEnabled;

  /// Whether the admin order replaces user ordering entirely.
  final bool enforcedForAll;

  /// Whether a user's adaptive preference is allowed to apply.
  final bool adaptiveAllowed;

  /// Read the live policy. Synchronous by design — see the library note.
  factory QuickServicePolicy.current() {
    final orderOn = _notFalse(QuickServiceKeys.orderEnabled);
    return QuickServicePolicy(
      orderedLeaders: orderOn ? _slugs(QuickServiceKeys.order, _defaultOrder) : const [],
      dragLocked: _slugs(QuickServiceKeys.dragLocked, '').toSet(),
      dragEnabled: _notFalse(QuickServiceKeys.dragEnabled),
      // Default OFF: enforcing globally takes every user's arrangement away,
      // which is a deliberate act and must not be the behaviour nobody chose.
      enforcedForAll: _isTrue(QuickServiceKeys.orderEnforcedAll),
      adaptiveAllowed: _notFalse(QuickServiceKeys.adaptiveEnabled),
    );
  }

  /// The three the operator asked to keep on the first row.
  static const String _defaultOrder = 'sendFunds,airtime,data';

  /// Whether this service's tile may be dragged.
  bool isDraggable(AppServiceName name) {
    if (!dragEnabled) return false;
    if (dragLocked.contains(name)) return false;
    // A leader's position IS the admin's instruction. Allowing the gesture
    // would write a hand-rank that outranks the order on the next build.
    if (orderedLeaders.contains(name)) return false;
    return true;
  }

  /// Whether ANY tile on this grid can move — drives the one-line notice
  /// shown to the user, so a dead drag gesture is explained rather than
  /// read as a broken screen.
  bool get anyDraggable => dragEnabled && !enforcedForAll;

  /// Why the grid cannot be rearranged, or null when it can.
  String? get lockReason {
    if (!dragEnabled) return 'Your bank arranges these services.';
    if (enforcedForAll) return 'Your bank sets the order of these services.';
    return null;
  }

  /// Whether a user's adaptive preference should be honoured.
  bool get adaptiveEffective => adaptiveAllowed && !enforcedForAll;

  static bool _isTrue(String key) =>
      (FeatureFlags.rawString(key) ?? '').trim().toLowerCase() == 'true';

  /// Only a literal "false" disables. A typo must not silently unpin the
  /// grid or switch dragging off for everyone.
  static bool _notFalse(String key) =>
      (FeatureFlags.rawString(key) ?? '').trim().toLowerCase() != 'false';

  static List<AppServiceName> _slugs(String key, String fallback) {
    final raw = (FeatureFlags.rawString(key) ?? '').trim();
    final csv = raw.isEmpty ? fallback : raw;
    if (csv.isEmpty) return const [];
    final bySlug = <String, AppServiceName>{
      for (final s in AppServiceName.values) s.name.toLowerCase(): s,
    };
    final out = <AppServiceName>[];
    for (final part in csv.split(',')) {
      final slug = part.trim().toLowerCase();
      if (slug.isEmpty) continue;
      final match = bySlug[slug];
      // An unknown slug costs that one entry and nothing else. Defaulting it
      // would pin or lock a service nobody named.
      if (match != null && !out.contains(match)) out.add(match);
    }
    return out;
  }
}

/// Put the admin-ordered leaders at the front, in their configured order.
///
/// Applied AFTER every other ordering rule, because it has to beat all of
/// them. Unordered services keep the relative order the caller produced.
List<T> applyAdminOrder<T>(
  List<T> services,
  QuickServicePolicy policy, {
  required AppServiceName Function(T) nameOf,
}) {
  final leaders = policy.orderedLeaders;
  if (leaders.isEmpty) return services;

  final pinned = <T>[];
  for (final want in leaders) {
    for (final s in services) {
      if (nameOf(s) == want) {
        pinned.add(s);
        break;
      }
    }
  }
  if (pinned.isEmpty) return services;

  return [
    ...pinned,
    for (final s in services)
      if (!leaders.contains(nameOf(s))) s,
  ];
}
