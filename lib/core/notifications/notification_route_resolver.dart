import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/types/app_routes.dart';
// TransactionServiceType lives in unified_transaction_widgets.dart, which is a
// `part of` this library — import the parent, not the part.
import 'package:lazervault/core/types/unified_transaction.dart';

part 'resolver_money.dart';
part 'resolver_commerce.dart';
part 'resolver_social.dart';
part 'resolver_account.dart';

/// Turns a notification's `(type, data)` into the page it is about.
///
/// This is the single mapping. Push taps, in-app feed rows, universal links and
/// the server's email/SMS links all resolve here, so one notification means one
/// destination no matter which door the user came through.
///
/// ## Why this exists
///
/// Routing used to be spread across three places that disagreed:
///   * `main.dart`'s push tap handler — a hand-written if-chain covering four
///     types out of roughly sixty. Everything else fell through to the
///     dashboard.
///   * `DeepLinkService` — a five-case enum, only one of which navigated.
///   * The in-app feed — no tap handling at all.
///
/// ## Tiering, and why it is honest
///
/// Destination screens have inconsistent argument contracts. Some take an id
/// (`splitBillDetail` wants `{'splitBillId': ...}`); some take a bare String
/// (`groupDetails`); and some take a fully hydrated entity — `sendFundReceipt`
/// does `Get.arguments as Transaction`, which no push payload can construct.
///
/// So a target is either [TargetPrecision.record] (we can open the exact thing)
/// or [TargetPrecision.serviceLanding] (we open that service's own history
/// page, where the record is the newest row). The second is not a fallback to
/// the dashboard — it is the correct page for the notification, just not the
/// individual receipt. Marking it on the target keeps the gap visible: adding
/// an id to a server payload upgrades that type from landing to record without
/// touching any caller.
///
/// ## Adding a type
///
/// Add a case to the matching `_resolveX` part file. If the type is unknown,
/// [resolve] returns null and the caller opens the notifications feed — the
/// user still reads the message, and no tap ever dead-ends on the dashboard.
class NotificationRouteResolver {
  const NotificationRouteResolver._();

  /// Resolves a destination, or null when nothing in the app corresponds to
  /// [rawType]. Never throws: this runs on a notification tap, and an exception
  /// here would look to the user like the app ignoring the tap entirely.
  static NotificationTarget? resolve(
    String rawType,
    Map<String, dynamic> rawData,
  ) {
    try {
      final type = rawType.trim().toLowerCase();
      if (type.isEmpty) return null;
      final data = _stringify(rawData);

      return _resolveMoney(type, data) ??
          _resolveCommerce(type, data) ??
          _resolveSocial(type, data) ??
          _resolveAccount(type, data);
    } catch (_) {
      return null;
    }
  }

  /// Resolves straight from a `lazervault://n/...` or
  /// `https://lazervault.app/n/...` link.
  static NotificationTarget? resolveUri(Uri uri) {
    final parsed = NotificationLink.parse(uri);
    if (parsed == null) return null;
    return resolve(parsed.type, parsed.data);
  }
}

// ---------------------------------------------------------------------------
// Shared helpers.
//
// Top-level and private, so every `resolver_*.dart` part can call them bare.
// A `part` shares the parent library's private scope, which is exactly why the
// mapping is split this way: four focused files, one library, no exported
// surface beyond NotificationRouteResolver itself.
// ---------------------------------------------------------------------------

/// Matches a type against a domain prefix, tolerating both the bare form and
/// the dotted form. `split_bill.created`, `split_bill` and `split_bill.paid`
/// all match the `split_bill` domain — the server emits both shapes, and a new
/// status suffix must not silently stop resolving.
bool _is(String type, String prefix) =>
    type == prefix ||
    type.startsWith('$prefix.') ||
    type.startsWith('${prefix}_');

/// FCM delivers every value as a String, but the in-app feed's `data` comes
/// from parsed JSON and can hold numbers or bools. Flatten both to strings so
/// the mapping never has to care which door it came through.
Map<String, String> _stringify(Map<String, dynamic> raw) {
  final out = <String, String>{};
  raw.forEach((k, v) {
    if (v == null) return;
    final s = v.toString();
    if (s.isEmpty) return;
    out[k] = s;
  });
  return out;
}

/// Reads the first non-empty value among [keys].
///
/// Payload key names drift between the services that publish them — a bill id
/// arrives as `split_bill_id` from one handler and `bill_id` from another — and
/// a resolver that insists on one spelling silently degrades to a landing page.
/// Accepting the known aliases keeps the deep link precise.
String? _first(Map<String, String> data, List<String> keys) {
  for (final k in keys) {
    final v = data[k];
    if (v != null && v.trim().isNotEmpty) return v.trim();
  }
  return null;
}

/// A service's own transaction history — the standard
/// [TargetPrecision.serviceLanding] for money events whose receipt screen needs
/// a hydrated `Transaction` the payload cannot build.
NotificationTarget _history(TransactionServiceType service) =>
    NotificationTarget(
      route: AppRoutes.serviceTransactionHistory,
      arguments: service,
      precision: TargetPrecision.serviceLanding,
    );

/// A plain landing page for a service with no per-record screen to reach.
NotificationTarget _landing(String route, {Object? arguments}) =>
    NotificationTarget(
      route: route,
      arguments: arguments,
      precision: TargetPrecision.serviceLanding,
    );

/// An exact record.
NotificationTarget _record(String route, {Object? arguments}) =>
    NotificationTarget(
      route: route,
      arguments: arguments,
      precision: TargetPrecision.record,
    );
