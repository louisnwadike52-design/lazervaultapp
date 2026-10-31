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
        // The grid paginates at 12 tiles and pins sendFunds to the front, so
        // eleven ranks decide what a user sees without swiping. Those eleven
        // are enumerated here rather than left to the `100 + index` fallback,
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
        // 31 Oct 2026). Page one is twelve tiles — pinned sendFunds plus
        // ranks 1..11 — so moving invoice off left a hole, and leaving it to
        // be filled by whatever ranked next is the exact accident the note
        // above warns about: the next rank is insurance (20), which is
        // admin-gated OFF, so the twelfth tile would have been decided by a
        // flag rather than by anyone. Recharge cards are an everyday Nigerian
        // errand and revenue-bearing, which is what page one is for.
        AppServiceName.rechargeCard => 6,
        AppServiceName.tagPay => 7,
        AppServiceName.qrPay => 8,
        AppServiceName.contactlessPay => 9,
        AppServiceName.batchTransfer => 10,
        AppServiceName.escrow => 11,

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

        // Non-revenue / P2P / internal + business tiles keep their enum order.
        _ => 100 + index,
      };
}

extension AppServiceNameExtension on AppServiceName {
  String get displayName {
    switch (this) {
      case AppServiceName.sendFunds:
        return 'Send Funds';
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
}

extension AppServiceImgExtension on AppServiceImg {
  String get uri {
    switch (this) {
      case AppServiceImg.sendFunds:
        return 'assets/images/money-send.png';
      case AppServiceImg.batchTransfer:
        return 'assets/images/batch-transfer.png';
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

  String get name => serviceName.displayName;
  String get imgUri => serviceImg.uri;

  const AppService({required this.serviceName, required this.serviceImg});
}
