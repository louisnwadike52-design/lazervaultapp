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
