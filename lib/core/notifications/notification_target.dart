/// The destination a notification points at, in a form every delivery channel
/// can agree on.
///
/// A LazerVault notification reaches the user through four different doors —
/// an FCM push, a row in the in-app feed, an email, an SMS — and before this
/// type existed each door decided where to go on its own. Push handled four
/// types in a hand-written if-chain and dropped the rest on the dashboard; the
/// feed was not tappable at all; email and SMS carried no link. Same event,
/// four answers.
///
/// [NotificationTarget] is that one answer. `NotificationRouteResolver` turns a
/// `(type, data)` pair into one of these, and every door routes through it.
library;

/// Where a notification should land, plus what the destination screen needs.
class NotificationTarget {
  const NotificationTarget({
    required this.route,
    this.arguments,
    this.requiresAuth = true,
    this.precision = TargetPrecision.record,
  });

  /// A route name from `AppRoutes` — never a raw path string, so a renamed
  /// route breaks the build here rather than silently dead-ending a link.
  final String route;

  /// Arguments for the destination, matching that screen's existing contract
  /// (some take a bare String, some a Map — the resolver adapts per route).
  final Object? arguments;

  /// Whether the destination requires a signed-in session. Almost everything
  /// does; the exceptions are links that are themselves part of onboarding.
  ///
  /// This is what lets a tap survive the login gate: an auth-requiring target
  /// captured while logged out is stashed rather than pushed over the login
  /// screen, then replayed once the session exists.
  final bool requiresAuth;

  /// How exactly this target identifies what the notification was about.
  final TargetPrecision precision;

  @override
  String toString() =>
      'NotificationTarget($route, precision: ${precision.name}, args: $arguments)';
}

/// How close to the actual record a target lands.
///
/// This distinction is not cosmetic — it records a real constraint. Some
/// destination screens take an id or reference and can open the exact record
/// ([record]). Others are built around an already-hydrated entity: the send-
/// funds receipt does `Get.arguments as Transaction`, and a push payload
/// carries `reference`/`amount`/`currency` but no way to construct a
/// `Transaction`. Routing those to the service's own history screen — where the
/// record sits at the top of the list — is the honest best landing, and is
/// still the right *page* rather than the dashboard.
///
/// Recorded on the target so the gap is visible and can be closed later by
/// adding an id to the server payload, instead of being invisible in a switch.
enum TargetPrecision {
  /// Opens the specific record the notification was about.
  record,

  /// Opens the owning service's list/history page. Used when the destination
  /// screen needs an entity the payload cannot supply.
  serviceLanding,
}

/// The canonical URI form: `lazervault://n/<type>?<data>`.
///
/// One shape, so a link minted by an email template, an SMS, a web page or the
/// push payload all parse back to the same `(type, data)` the resolver takes.
/// The universal-link equivalent is `https://lazervault.app/n/<type>?<data>`,
/// which is what goes in email and SMS — a custom scheme shows an ugly
/// "cannot open page" when the app is not installed, whereas the https form
/// falls through to the website.
class NotificationLink {
  const NotificationLink._();

  static const scheme = 'lazervault';
  static const host = 'lazervault.app';

  /// The path segment that marks a link as notification routing, keeping this
  /// namespace clear of the older `lazervault://deposit/callback` and
  /// `lazervault://family/invite/<token>` links, which still work unchanged.
  static const segment = 'n';

  /// Builds the app-scheme form. Used for the push `deeplink` field.
  static Uri appUri(String type, Map<String, String> data) => Uri(
        scheme: scheme,
        host: segment,
        path: '/$type',
        queryParameters: data.isEmpty ? null : _clean(data),
      );

  /// Builds the universal-link form. Used for email, SMS and web.
  static Uri webUri(String type, Map<String, String> data) => Uri(
        scheme: 'https',
        host: host,
        path: '/$segment/$type',
        queryParameters: data.isEmpty ? null : _clean(data),
      );

  /// Parses either form back into `(type, data)`, or null when [uri] is not a
  /// notification link. Tolerant by design: an unknown or malformed link must
  /// fall through to the caller's existing handling, never throw at a tap.
  static ({String type, Map<String, String> data})? parse(Uri uri) {
    final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
    String? type;

    if (uri.scheme == scheme && uri.host == segment && segments.isNotEmpty) {
      // lazervault://n/<type>
      type = segments.first;
    } else if (uri.scheme == 'https' &&
        uri.host.endsWith(host) &&
        segments.length >= 2 &&
        segments.first == segment) {
      // https://lazervault.app/n/<type>
      type = segments[1];
    }

    if (type == null || type.isEmpty) return null;
    return (type: type, data: Map<String, String>.from(uri.queryParameters));
  }

  /// Drops empty values so a link never carries `?reference=&amount=`, which
  /// would resolve to an empty-string id and open a blank record screen.
  static Map<String, String> _clean(Map<String, String> data) {
    final out = <String, String>{};
    data.forEach((k, v) {
      if (k.isNotEmpty && v.isNotEmpty) out[k] = v;
    });
    return out;
  }
}
