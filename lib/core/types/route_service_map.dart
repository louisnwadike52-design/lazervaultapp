import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/services.dart';

/// Which quick service a route belongs to.
///
/// WHY THIS EXISTS
/// ---------------
/// The admin "temporarily unavailable" gate lives in the quick-service tile
/// dispatcher, which covers the grid AND the swipe-down all-services search —
/// every way a user TAPS into a service.
///
/// It does not cover a NOTIFICATION DEEP LINK, which calls Get.toNamed with a
/// route directly and never passes a tile. An admin who takes a service
/// offline would still have users landing inside it from a push, which is
/// precisely the confused state the modal exists to prevent.
///
/// Derived from the dispatcher's own switch rather than hand-written, and a
/// test re-derives it from that source so the two cannot drift: a service
/// whose route changes and is not updated here would silently stop being
/// guarded, and nothing in the UI would show it.
const Map<String, AppServiceName> kRouteToService = {
  AppRoutes.aiScanToPay: AppServiceName.aiScanToPay,
  AppRoutes.airtime: AppServiceName.airtime,
  AppRoutes.autoSave: AppServiceName.autoSave,
  AppRoutes.batchTransfer: AppServiceName.batchTransfer,
  AppRoutes.bettingHome: AppServiceName.betting,
  AppRoutes.billsHub: AppServiceName.payBills,
  AppRoutes.bulkSms: AppServiceName.bulkSms,
  // Data bundles. Absent until 31 Oct 2026, so a data deep link bypassed the
  // admin unavailable gate entirely — the one service most likely to be
  // promoted by a campaign, and the one whose gate was not being applied.
  // Found by the sync test the moment it could see the dispatcher again.
  AppRoutes.dataBundlesHome: AppServiceName.data,
  AppRoutes.businessAnalytics: AppServiceName.businessAnalytics,
  AppRoutes.businessDashboard: AppServiceName.businessDashboard,
  AppRoutes.cardAcceptance: AppServiceName.cardAcceptance,
  AppRoutes.contactlessPay: AppServiceName.contactlessPay,
  AppRoutes.crowdfund: AppServiceName.crowdfund,
  AppRoutes.crypto: AppServiceName.crypto,
  AppRoutes.currencyExchange: AppServiceName.exchange,
  AppRoutes.customers: AppServiceName.customers,
  AppRoutes.epinHome: AppServiceName.rechargeCard,
  AppRoutes.escrow: AppServiceName.escrow,
  AppRoutes.expenses: AppServiceName.expenses,
  AppRoutes.giftCards: AppServiceName.giftCards,
  AppRoutes.groupAccount: AppServiceName.groupAccount,
  AppRoutes.idPayHome: AppServiceName.idPay,
  AppRoutes.insurance: AppServiceName.insurance,
  AppRoutes.inventory: AppServiceName.inventory,
  AppRoutes.investments: AppServiceName.invest,
  AppRoutes.invoice: AppServiceName.invoice,
  AppRoutes.lockFunds: AppServiceName.lockFunds,
  AppRoutes.payroll: AppServiceName.payroll,
  AppRoutes.qrPayHome: AppServiceName.qrPay,
  AppRoutes.rmb: AppServiceName.rmb,
  AppRoutes.sales: AppServiceName.sales,
  AppRoutes.selectRecipient: AppServiceName.sendFunds,
  AppRoutes.splitBills: AppServiceName.splitBills,
  AppRoutes.stocks: AppServiceName.stocks,
  AppRoutes.tagPay: AppServiceName.tagPay,
  AppRoutes.taxDashboard: AppServiceName.tax
};

/// Services that deliberately SHARE another service's route.
///
/// `payInvoice` and `invoice` both open the consolidated invoice screen, so
/// one route cannot name both. The route is owned by `invoice`, and a deep
/// link into it is gated by `invoice`'s availability.
///
/// Recorded here rather than silently dropped, because "absent from the map"
/// and "shares someone else's route" look identical at a glance and only one
/// of them is a bug. The sync test treats a listed alias as covered and an
/// unlisted omission as a failure, so a service that genuinely loses its gate
/// is still caught.
const Map<AppServiceName, AppServiceName> kServiceRouteAliases = {
  AppServiceName.payInvoice: AppServiceName.invoice,
};

/// The service a route belongs to, or null when the route is not a service
/// entry point (settings, receipts, auth, …).
AppServiceName? serviceForRoute(String? route) {
  if (route == null || route.isEmpty) return null;
  return kRouteToService[route];
}

/// The route that opens a service, or null when the service has no named
/// route of its own.
///
/// The inverse of [kRouteToService], built once and cached. It exists for
/// PROMOTIONAL DEEP LINKS: a campaign names a service
/// (`lazervault://n/promo?service=airtime`) rather than a route, because a
/// marketing payload should not have to know the app's internal route names,
/// and a route rename would otherwise silently break every link already sent
/// to a handset.
///
/// Deriving it from the same map the availability gate uses means a promo
/// link cannot point somewhere the gate does not know about — the two cannot
/// disagree about what a service is.
///
/// An ALIAS resolves to its owner's route: a link naming `payInvoice` opens
/// the consolidated invoice screen, which is the screen it has always meant.
final Map<AppServiceName, String> kServiceToRoute = () {
  final out = <AppServiceName, String>{};
  kRouteToService.forEach((route, service) => out[service] = route);
  kServiceRouteAliases.forEach((alias, owner) {
    final r = out[owner];
    if (r != null) out[alias] = r;
  });
  return Map<AppServiceName, String>.unmodifiable(out);
}();

/// Resolves a service NAME as a campaign would send it ("airtime",
/// "giftCards", "gift_cards") to the route that opens it.
///
/// Tolerant of spelling on purpose. The name is typed by an operator into a
/// campaign form, and refusing "gift_cards" because the enum says
/// "giftCards" would turn a typo into a dead link on every handset that
/// received the push — discovered, if at all, from a support ticket.
String? routeForServiceName(String? raw) {
  final want =
      (raw ?? '').trim().toLowerCase().replaceAll(RegExp(r'[_\s-]'), '');
  if (want.isEmpty) return null;
  for (final entry in kServiceToRoute.entries) {
    if (entry.key.name.toLowerCase() == want) return entry.value;
  }
  return null;
}
