import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;

/// One row of the bill-service catalogue (GetBillServices), as the hub needs
/// it. Plain data so it can be mirrored to disk and painted before the
/// network answers.
class BillServiceEntry {
  const BillServiceEntry({
    required this.type,
    required this.enabled,
    this.label = '',
    this.disabledReason = '',
  });

  /// Catalogue type string — matches the hub's static tile registry.
  final String type;
  final bool enabled;
  final String label;
  final String disabledReason;

  factory BillServiceEntry.fromProto(pb.BillService s) => BillServiceEntry(
        type: s.type,
        enabled: s.enabled,
        label: s.label,
        disabledReason: s.disabledReason,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'enabled': enabled,
        'label': label,
        'disabled_reason': disabledReason,
      };

  factory BillServiceEntry.fromJson(Map<String, dynamic> j) => BillServiceEntry(
        type: (j['type'] ?? '').toString(),
        enabled: j['enabled'] == true || j['enabled'] == 'true',
        label: (j['label'] ?? '').toString(),
        disabledReason: (j['disabled_reason'] ?? '').toString(),
      );
}

/// `type → enabled` for a catalogue page. What the hub actually consults.
Map<String, bool> billServicesEnabledByType(List<BillServiceEntry> entries) =>
    <String, bool>{for (final e in entries) e.type: e.enabled};

/// The bill-services catalogue, remembered across opens of the Bills Hub.
///
/// WHY: the hub used to ask GetBillServices from `initState` on EVERY open
/// and paint a spinner until it answered. The catalogue changes only when an
/// admin toggles a service, so the previous answer is almost always the right
/// thing to paint NOW — then the fresh answer is fetched behind it and, if a
/// tile was toggled, that tile updates in place.
///
/// Stamped by user and scoped by country (the only per-request inputs the
/// commerce client sends with an empty GetBillServicesRequest), mirrored to
/// SharedPreferences so a cold start paints too, and cleared with every other
/// SessionPageStore on a user switch.
class BillServicesCatalogue {
  BillServicesCatalogue._();

  static final SessionPageStore<BillServiceEntry> store =
      SessionPageStore<BillServiceEntry>(
    'bill_services',
    toJson: (e) => e.toJson(),
    fromJson: BillServiceEntry.fromJson,
    // A catalogue is near-static; a day on disk is still worth painting.
    maxAge: const Duration(days: 1),
  );

  /// Whoever is signed in, or '' when nobody is (the store then refuses to
  /// remember, and the hub falls back to in-memory state for this open).
  static String currentUserId() {
    try {
      if (serviceLocator.isRegistered<AuthenticationCubit>()) {
        return serviceLocator<AuthenticationCubit>().userId ?? '';
      }
    } catch (_) {/* best-effort */}
    return '';
  }

  /// Whether an APP RESUME should re-ask for the catalogue.
  ///
  /// `AppLifecycleState.resumed` is not once per visit to the app: a
  /// permission dialog, a share sheet, the app switcher and the notification
  /// shade each produce an inactive→resumed pair, and Android can fire several
  /// in a row — so refreshing on every one means a fetch per flap, on a screen
  /// the user may not even be looking at (the hub keeps its observer while it
  /// sits under a pushed route). The store's own staleness window is the
  /// floor; with nothing remembered [SessionPageStore.isStale] is true, so a
  /// cold hub still refreshes immediately.
  static bool shouldRefreshOnResume({
    required String userId,
    required String scope,
  }) =>
      store.isStale(userId: userId, scope: scope);

  /// The country the request is made for — a catalogue toggled per country
  /// must not be painted for another.
  static String currentScope() {
    try {
      if (serviceLocator.isRegistered<LocaleManager>()) {
        return serviceLocator<LocaleManager>().currentCountry;
      }
    } catch (_) {/* best-effort */}
    return '';
  }

  /// The network call, UNCHANGED from the hub's original: utility payments
  /// rides the commerce gRPC client (same instance the data-bundle / betting
  /// datasources use for GetDataPlans etc.), with the same 8s timeout.
  static Future<List<BillServiceEntry>> fetch() async {
    final client =
        serviceLocator<GrpcClient>(instanceName: 'commerceGrpcClient');
    final options = await client.callOptions;
    final resp = await client.utilityPaymentsClient
        .getBillServices(pb.GetBillServicesRequest(), options: options)
        .timeout(const Duration(seconds: 8));
    return [for (final s in resp.services) BillServiceEntry.fromProto(s)];
  }

  /// Fetch and remember. Throws what [fetch] throws; the caller decides what a
  /// failure means (nothing, when a previous page is already on screen).
  static Future<List<BillServiceEntry>> refresh({
    required String userId,
    required String scope,
  }) async {
    final fresh = await fetch();
    store.put(fresh, userId: userId, scope: scope);
    return fresh;
  }
}
