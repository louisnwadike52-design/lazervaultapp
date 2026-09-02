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
}

extension AppServiceRevenuePriority on AppServiceName {
  /// Ordering weight for the quick-services grid — LOWER shows earlier.
  /// Revenue-bearing services (fee/markup generating) rank first so they lead
  /// the grid; everything else falls back to enum order (offset by 100) so
  /// every service still gets a UNIQUE, deterministic rank (no ties → stable
  /// order without needing a stable sort). `sendFunds` is pinned to the very
  /// front separately by the grid, so its rank here is irrelevant.
  int get revenuePriority => switch (this) {
        AppServiceName.crypto => 1,
        AppServiceName.payBills => 2,
        AppServiceName.exchange => 3,
        AppServiceName.giftCards => 4,
        AppServiceName.rmb => 5,
        AppServiceName.airtime => 6,
        AppServiceName.insurance => 7,
        AppServiceName.invoice => 8,
        // payInvoice is consolidated into invoice; leave it on the default
        // (unique) rank so no two services ever tie.
        AppServiceName.invest => 9,
        AppServiceName.stocks => 10,
        AppServiceName.betting => 11,
        AppServiceName.rechargeCard => 12,
        AppServiceName.bulkSms => 13,
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
      case AppServiceName.groupAccount:
        return 'Joint Funds';
      case AppServiceName.insurance:
        return 'Insurance';
      case AppServiceName.airtime:
        return 'Airtime';
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
        return 'Phone Banking';
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
      case AppServiceName.groupAccount:
        return 'accounts-service';
      case AppServiceName.insurance:
        return 'insurance-service';
      case AppServiceName.airtime:
        return 'airtime-service';
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

  const NotificationService(
      {required this.appService,
      required this.title,
      required this.subTitle,
      required this.date});
}

class AppService {
  final AppServiceName serviceName;
  final AppServiceImg serviceImg;

  String get name => serviceName.displayName;
  String get imgUri => serviceImg.uri;

  const AppService({required this.serviceName, required this.serviceImg});
}
