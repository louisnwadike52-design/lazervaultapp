import 'package:lazervault/core/config/feature_flags.dart';
import 'package:flutter/widgets.dart' show VoidCallback;

enum AppServiceName {
  sendFunds,
  batchTransfer,
  tagPay,
  splitBills,
  escrow,
  invoice,
  payInvoice,
  payBills,
  invest,
  stocks,
  exchange,
  crypto,
  rmb,
  giftCards,
  aiScanToPay,
  qrPay,
  contactlessPay,
  cardAcceptance,
  groupAccount,
  insurance,
  airtime,
  autoSave,
  crowdfund,
  uplift,
  lockFunds,
  whatsappIntegration,
  phoneBanking,
  idPay,
  payroll,
  businessDashboard,
  businessAnalytics,
  customers,
  expenses,
  inventory,
  tax,
  sales,
  rechargeCard,
  betting,
  bulkSms,
  // APPENDED, not inserted. The fallback rank below is `100 + index`, so
  // inserting a value mid-enum silently reshuffles every service after it.
  data,
  // Open-banking links: the accounts a customer has connected from other
  // banks. Appended for the same reason as `data` above.
  financialConnections,
  // Vendor Campaigns: launch-day promotions at partner venues. The tile is
  // visible ONLY to users enrolled as a vendor, which the quick_service_*
  // flags cannot express on their own — see VendorAccess. Appended for the
  // same reason as the two above.
  vendorCampaigns,
  // Event ticketing: a user publishes an event and sells tickets, buyers'
  // money sits in the TICKET_POOL wallet, and the organiser withdraws once
  // sales close. Appended for the same reason as everything above it.
  ticketing,
}

extension AppServiceRevenuePriority on AppServiceName {
  /// Ordering weight for the quick-services grid — LOWER shows earlier.
  /// Revenue-bearing services (fee/markup generating) rank first so they lead
  /// the grid; everything else falls back to enum order (offset by 100) so
  /// every service still gets a UNIQUE, deterministic rank (no ties → stable
  /// order without needing a stable sort). `sendFunds` is pinned to the very
  /// front separately by the grid, so its rank here is irrelevant.
  int get revenuePriority => switch (this) {
        // PAGE ONE IS THE NIGERIAN SHORTLIST, AND IT IS EXPLICIT.
        //
        // The grid paginates at 12 cells, gives one of them up to the
        // navigation tile and pins sendFunds to the front, so TEN ranks decide
        // what a user sees without swiping. Those ten are enumerated here
        // rather than left to the `100 + index` fallback,
        // because the fallback made page one depend on which services happened
        // to be filtered out: with `invest` hidden and `insurance` admin-gated
        // off, splitBills (rank 103) still landed in the twelfth slot. A page
        // that reshuffles when an unrelated flag flips is not a layout.
        //
        // Airtime and data lead: they are the errands people open the app for
        // several times a week.
        AppServiceName.airtime => 1,
        AppServiceName.data => 2,
        AppServiceName.payBills => 3,
        AppServiceName.crypto => 4,
        AppServiceName.giftCards => 5,
        // Recharge-card printing takes the slot invoice vacated (operator,
        // 31 Oct 2026). Moving invoice off left a hole, and leaving it to be
        // filled by whatever ranked next is the exact accident the note above
        // warns about: the next rank is insurance (20), which is admin-gated
        // OFF, so that tile would have been decided by a flag rather than by
        // anyone. Recharge cards are an everyday Nigerian errand and
        // revenue-bearing, which is what page one is for.
        AppServiceName.rechargeCard => 6,
        AppServiceName.tagPay => 7,
        AppServiceName.qrPay => 8,
        AppServiceName.contactlessPay => 9,
        AppServiceName.batchTransfer => 10,
        // EVENTS OPENS THE SECOND CAROUSEL.
        //
        // Page one is exactly ten explicit ranks plus the pinned sendFunds
        // and the navigation tile, so rank 11 is the FIRST cell a user sees
        // after one swipe — deliberately, rather than by where the enum
        // happens to put it. It was 66, which left it in the `100 + index`
        // neighbourhood of the third page and effectively undiscoverable for
        // a product we are launching.
        //
        // Not on page one: that page is the Nigerian shortlist of errands
        // people run several times a week, and an event is not one of them.
        AppServiceName.ticketing => 11,
        // FINANCIAL CONNECTIONS IS NOT A QUICK-SERVICE TILE.
        //
        // It is reached from an icon on the edge of the services card
        // (_buildFinancialConnectionsCta), because it opens an existing PAGE
        // rather than starting an errand — and giving it a grid slot pushed a
        // real errand off page one.
        //
        // The rank stays defined because revenuePriority is exhaustive over
        // the enum and the value is still used for deep-link routing
        // (route_service_map). Parked in the second-carousel range so that if
        // it is ever listed as a service again it does not lead the grid by
        // accident.
        AppServiceName.financialConnections => 30,

        // ── SECOND CAROUSEL ───────────────────────────────────────────────
        // Still revenue-bearing and still ranked deliberately, just not
        // competing for the first screen.
        AppServiceName.insurance => 20,
        AppServiceName.invest => 21,
        AppServiceName.stocks => 22,
        AppServiceName.betting => 23,
        AppServiceName.bulkSms => 25,

        // Moved OFF page one by operator request (2026-10-30): priced in or
        // settled through a foreign currency, so a minority of Nigerian
        // sessions. Ranked explicitly so "second carousel" is a decision that
        // survives the next service being added, not a side effect of enum
        // position.
        AppServiceName.exchange => 60,
        AppServiceName.rmb => 61,
        AppServiceName.splitBills => 62,
        // Invoice joins split-bills on the second carousel (operator,
        // 31 Oct 2026). Both are "ask someone else for money" rather than the
        // everyday spend page one is for, so they belong together.
        AppServiceName.invoice => 63,
        // Escrow joins them (operator, 1 Nov 2026). Same reason: it is money
        // parked pending someone else's action, not an everyday spend, and
        // page one is now eleven tiles rather than twelve — every page gives
        // up a cell to the navigation tile, not just the first. Airtime and
        // data are what people open the app for several times a week and they
        // keep the lead; escrow moving here is what makes that fit without a
        // hole, since ranks 1..10 plus pinned sendFunds now fill page one
        // exactly and nothing is left to be decided by whichever flag happens
        // to be on.
        AppServiceName.escrow => 64,

        // LAST PAGE, DELIBERATELY. Vendor Campaigns is visible to a handful of
        // enrolled businesses and to nobody else, so it must never compete for
        // a cell on page one. Ranked explicitly rather than left to the
        // `100 + index` fallback, which this file warns against — a fallback
        // rank is a placement nobody decided.
        AppServiceName.vendorCampaigns => 90,

        // Ranked explicitly, like everything else here, because the `100 +
        // index` fallback is a placement nobody decided. Ticketing IS
        // revenue-bearing (the platform takes a commission on every sale), so
        // it sits with the earning services rather than on the last page —
        // but behind the weekly errands, since publishing an event is not a
        // several-times-a-week act.

        // Non-revenue / P2P / internal + business tiles keep their enum order.
        _ => 100 + index,
      };
}

extension AppServiceNameLabel on AppServiceName {
  /// The label a customer actually reads, operator-renameable.
  ///
  /// [displayName] is the SHIPPED word and stays the fallback. This getter is
  /// what every surface should render, so a rename reaches the tile, the
  /// history title and anything else at once — a label overridden in one
  /// place and not another is how a service ends up with two names.
  ///
  /// Synchronous and never awaits: see FeatureFlags.quickServiceLabel.
  String get label => FeatureFlags.quickServiceLabel(name, displayName);
}

extension AppServiceNameExtension on AppServiceName {
  String get displayName {
    switch (this) {
      // The tile label wraps to two lines, as 'AI Scan to Pay' already does.
      case AppServiceName.financialConnections:
        return 'Financial Connections';
      // Two words, like the label above, because the tile wraps to two lines.
      case AppServiceName.vendorCampaigns:
        return 'Vendor Campaigns';
      // "Events", not "Ticketing": the tile is how a user finds something to
      // go to, and only secondarily how an organiser sells. One word also
      // fits the cell without wrapping.
      case AppServiceName.ticketing:
        return 'Events';
      // "Transfer" is what customers here call it; "Send Funds" was our
      // phrasing, not theirs. Operator-renameable through `label` above, so
      // the next wording change does not need a store review.
      case AppServiceName.sendFunds:
        return 'Transfer';
      case AppServiceName.batchTransfer:
        return 'Batch Transfer';
      case AppServiceName.tagPay:
        return 'Tag Pay';
      case AppServiceName.splitBills:
        return 'Split Bills';
      case AppServiceName.escrow:
        return 'Escrow Pay';
      case AppServiceName.invoice:
        return 'Invoices';
      case AppServiceName.payInvoice:
        return 'Invoices';
      case AppServiceName.payBills:
        return 'Bills Hub';
      case AppServiceName.invest:
        return 'Invest';
      case AppServiceName.stocks:
        return 'Stocks';
      case AppServiceName.exchange:
        return 'Exchange';
      case AppServiceName.crypto:
        return 'Crypto';
      case AppServiceName.rmb:
        return 'RMB Transfer';
      case AppServiceName.giftCards:
        return 'Gift Cards';
      case AppServiceName.aiScanToPay:
        return 'AI Scan to Pay';
      case AppServiceName.qrPay:
        return 'QR Pay';
      case AppServiceName.contactlessPay:
        return 'Contactless Pay';
      case AppServiceName.cardAcceptance:
        // The merchant-facing direction: THEY take a card from a customer.
        // "Contactless Pay" is the opposite (paying someone), so the two names
        // have to be unmistakable on a grid where they sit near each other.
        return 'Accept Cards';
      case AppServiceName.groupAccount:
        // Named for what it is on the dashboard grid: a GROUP of people
        // with a shared pot. "Joint" reads as two-party (a joint account)
        // and this is a class, an alumni set, an esusu circle.
        return 'Group Funds';
      case AppServiceName.insurance:
        return 'Insurance';
      case AppServiceName.airtime:
        return 'Airtime';
      case AppServiceName.data:
        return 'Data';
      case AppServiceName.autoSave:
        return 'Auto-Save';
      case AppServiceName.crowdfund:
        return 'Crowdfund';
      case AppServiceName.uplift:
        return 'Lazerfunds';
      case AppServiceName.lockFunds:
        return 'Piggyvault';
      case AppServiceName.whatsappIntegration:
        return 'WhatsApp Banking';
      case AppServiceName.phoneBanking:
        // Consolidated entry (2026-09-07): ONE tile covers both channels — it
        // opens the Banking Channels hub, which manages WhatsApp AND
        // Phone/SMS registration + channel PINs. The separate
        // whatsappIntegration tile is hidden (route + deep links intact).
        return 'WhatsApp/Phone Banking';
      case AppServiceName.idPay:
        return 'PayID';
      case AppServiceName.payroll:
        return 'Payroll';
      case AppServiceName.businessDashboard:
        return 'Dashboard';
      case AppServiceName.businessAnalytics:
        return 'Analytics';
      case AppServiceName.customers:
        return 'Customers';
      case AppServiceName.expenses:
        return 'Expenses';
      case AppServiceName.inventory:
        return 'Inventory';
      case AppServiceName.tax:
        return 'Taxation';
      case AppServiceName.sales:
        return 'Sell';
      case AppServiceName.rechargeCard:
        return 'Recharge Cards';
      case AppServiceName.betting:
        return 'Fund Betting';
      case AppServiceName.bulkSms:
        return 'Bulk SMS';
    }
  }

  /// Maps AppServiceName to backend microservice name for transaction history
  /// This is used when calling accounts-service GetTransactionHistory with service_name filter
  String get backendServiceName {
    switch (this) {
      // Open banking is served by banking-service, which owns the Mono link
      // and the linked-account records behind it.
      case AppServiceName.financialConnections:
        return 'banking-service';
      // Vendor Campaigns live in financial-products-service alongside
      // crowdfund and uplift, reached through products-gateway.
      case AppServiceName.vendorCampaigns:
        return 'financial-products-service';
      // Ticketing lives beside crowdfund, uplift and vendor campaigns, reached
      // through products-gateway.
      case AppServiceName.ticketing:
        return 'financial-products-service';
      case AppServiceName.sendFunds:
        return 'core-payments-service';
      case AppServiceName.batchTransfer:
        return 'core-payments-service';
      case AppServiceName.tagPay:
        return 'tag-pay-service';
      case AppServiceName.splitBills:
        return 'split-bill-service';
      case AppServiceName.escrow:
        return 'escrow-service';
      case AppServiceName.invoice:
        return 'invoice-service';
      case AppServiceName.payInvoice:
        return 'invoice-service';
      case AppServiceName.payBills:
        return 'utility-payments-service';
      case AppServiceName.invest:
        return 'investments-service';
      case AppServiceName.stocks:
        return 'stocks-service';
      case AppServiceName.exchange:
        return 'investments-service';
      case AppServiceName.crypto:
        return 'crypto-service';
      case AppServiceName.rmb:
        return 'rmb-service';
      case AppServiceName.giftCards:
        return 'giftcards-service';
      case AppServiceName.aiScanToPay:
        return 'core-payments-service';
      case AppServiceName.qrPay:
        return 'qr-pay-service';
      case AppServiceName.contactlessPay:
        return 'contactless-payment-service';
      case AppServiceName.cardAcceptance:
        return 'banking-service';
      case AppServiceName.groupAccount:
        return 'accounts-service';
      case AppServiceName.insurance:
        return 'insurance-service';
      case AppServiceName.airtime:
        return 'airtime-service';
      case AppServiceName.data:
        return 'data-service';
      case AppServiceName.autoSave:
        return 'accounts-service';
      case AppServiceName.crowdfund:
        return 'crowdfund-service';
      case AppServiceName.uplift:
        return 'uplift-service';
      case AppServiceName.lockFunds:
        return 'accounts-service';
      case AppServiceName.whatsappIntegration:
        return 'whatsapp-service';
      case AppServiceName.phoneBanking:
        return 'phone-bridge-service';
      case AppServiceName.idPay:
        return 'id-pay-service';
      case AppServiceName.payroll:
        return 'payroll-service';
      case AppServiceName.businessDashboard:
        return 'accounts-service';
      case AppServiceName.businessAnalytics:
        return 'accounts-service';
      case AppServiceName.customers:
        return 'payroll-service';
      case AppServiceName.expenses:
        return 'accounts-service';
      case AppServiceName.inventory:
        return 'payroll-service';
      case AppServiceName.tax:
        return 'payroll-service';
      case AppServiceName.sales:
        return 'payroll-service';
      case AppServiceName.rechargeCard:
        return 'utility-payments-service';
      case AppServiceName.betting:
        return 'utility-payments-service';
      case AppServiceName.bulkSms:
        return 'bulk-sms-service';
    }
  }
}

final List<String> imagePaths = [
  'assets/images/money-receive.png',
  'assets/images/money-send.png',
  'assets/images/receive-square.png',
  'assets/images/wallet.png',
];

enum AppServiceImg {
  sendFunds,
  batchTransfer,
  tagPay,
  splitBills,
  escrow,
  invoice,
  payInvoice,
  payBills,
  invest,
  stocks,
  exchange,
  crypto,
  rmb,
  giftCards,
  aiScanToPay,
  qrPay,
  contactlessPay,
  groupAccount,
  insurance,
  airtime,
  autoSave,
  crowdfund,
  uplift,
  lockFunds,
  whatsappIntegration,
  phoneBanking,
  idPay,
  payroll,
  businessDashboard,
  businessAnalytics,
  customers,
  expenses,
  inventory,
  tax,
  sales,
  rechargeCard,
  betting,
  bulkSms,
  data,
  vendorCampaigns,
  ticketing,
}

extension AppServiceImgExtension on AppServiceImg {
  String get uri {
    switch (this) {
      case AppServiceImg.sendFunds:
        return 'assets/images/money-send.png';
      case AppServiceImg.batchTransfer:
        return 'assets/images/batch-transfer.png';
      case AppServiceImg.vendorCampaigns:
        // No dedicated asset — the tile renders a Material icon via
        // app_service_builder's icon switch (Icons.storefront_rounded).
        return 'assets/images/group-account.png';
      case AppServiceImg.ticketing:
        // No dedicated asset — the tile renders a Material icon via
        // app_service_builder's icon switch (Icons.confirmation_num_rounded).
        return 'assets/images/group-account.png';
      case AppServiceImg.splitBills:
        // No dedicated asset — the tile renders a Material icon via
        // app_service_builder's icon switch (Icons.call_split_rounded).
        return 'assets/images/group-account.png';
      case AppServiceImg.tagPay:
        return 'assets/images/tag-pay.png';
      case AppServiceImg.escrow:
        return 'assets/images/lock.png';
      case AppServiceImg.invoice:
        return 'assets/images/money-receive.png';
      case AppServiceImg.payInvoice:
        return 'assets/images/wallet.png';
      case AppServiceImg.payBills:
        return 'assets/images/receive-square.png';
      case AppServiceImg.invest:
        return 'assets/images/trending-up.png';
      case AppServiceImg.stocks:
        return 'assets/images/stocks.png';
      case AppServiceImg.exchange:
        return 'assets/images/exchange.png';
      case AppServiceImg.crypto:
        return 'assets/images/crypto.png';
      case AppServiceImg.rmb:
        return 'assets/images/rmb.png';
      case AppServiceImg.giftCards:
        return 'assets/images/gift-cards.png';
      case AppServiceImg.aiScanToPay:
        return 'assets/images/ai-scan.png';
      case AppServiceImg.qrPay:
        return 'assets/images/qr-pay.png';
      case AppServiceImg.contactlessPay:
        return 'assets/images/contactless.png';
      case AppServiceImg.groupAccount:
        return 'assets/images/group-account.png';
      case AppServiceImg.insurance:
        return 'assets/images/insurance.png';
      case AppServiceImg.airtime:
        return 'assets/images/airtime.png';
      case AppServiceImg.data:
        // No dedicated asset — the tile renders a Material icon via
        // app_service_builder's icon switch (Icons.wifi_rounded).
        return 'assets/images/airtime.png';
      case AppServiceImg.autoSave:
        return 'assets/images/auto-save.png';
      case AppServiceImg.crowdfund:
        return 'assets/images/volunteer_activism.png';
      case AppServiceImg.uplift:
        return 'assets/images/volunteer_activism.png';
      case AppServiceImg.lockFunds:
        return 'assets/images/lock.png';
      case AppServiceImg.whatsappIntegration:
        return 'assets/images/whatsapp-banking.png';
      case AppServiceImg.phoneBanking:
        return 'assets/images/contactless.png';
      case AppServiceImg.idPay:
        return 'assets/images/money-receive.png';
      case AppServiceImg.payroll:
        return 'assets/images/payroll.png';
      case AppServiceImg.businessDashboard:
        return 'assets/images/payroll.png';
      case AppServiceImg.businessAnalytics:
        return 'assets/images/trending-up.png';
      case AppServiceImg.customers:
        return 'assets/images/group-account.png';
      case AppServiceImg.expenses:
        return 'assets/images/receive-square.png';
      case AppServiceImg.inventory:
        return 'assets/images/payroll.png';
      case AppServiceImg.tax:
        return 'assets/images/receive-square.png';
      case AppServiceImg.sales:
        return 'assets/images/money-receive.png';
      case AppServiceImg.rechargeCard:
        return 'assets/images/airtime.png';
      case AppServiceImg.betting:
        return 'assets/images/receive-square.png';
      case AppServiceImg.bulkSms:
        // No dedicated asset — the tile renders a Material icon via
        // app_service_builder's icon switch (Icons.sms_rounded).
        return 'assets/images/receive-square.png';
    }
  }
}

enum NotificationType { success, error, info, warning }

class NotificationService {
  final AppService appService;
  final String title;
  final String subTitle;
  final DateTime date;

  /// What tapping this row should open, when the notification's type resolves
  /// to a destination. Null means the type is one this build does not
  /// recognise, and the row renders as plain text rather than as a dead
  /// tappable target — a row that looks tappable and does nothing is worse
  /// than one that never invited the tap.
  final VoidCallback? onTap;

  const NotificationService(
      {required this.appService,
      required this.title,
      required this.subTitle,
      required this.date,
      this.onTap});
}

class AppService {
  final AppServiceName serviceName;
  final AppServiceImg serviceImg;

  String get name => serviceName.label;
  String get imgUri => serviceImg.uri;

  const AppService({required this.serviceName, required this.serviceImg});
}
