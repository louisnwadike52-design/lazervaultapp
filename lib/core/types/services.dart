enum AppServiceName {
  sendFunds,
  invoice,
  payInvoice,
  payElectricityBill,
  invest,
  exchange,
  crypto,
  giftCards,
  aiScanToPay,
  groupAccount,
  insurance,
  airtime,
}

extension AppServiceNameExtension on AppServiceName {
  String get displayName {
    switch (this) {
      case AppServiceName.sendFunds:
        return 'Send Funds';
      case AppServiceName.invoice:
        return 'Invoice';
      case AppServiceName.payInvoice:
        return 'Pay Invoice';
      case AppServiceName.payElectricityBill:
        return 'Pay Electricity Bill';
      case AppServiceName.invest:
        return 'Invest';
      case AppServiceName.exchange:
        return 'Exchange';
      case AppServiceName.crypto:
        return 'Crypto';
      case AppServiceName.giftCards:
        return 'Gift Cards';
      case AppServiceName.aiScanToPay:
        return 'AI Scan to Pay';
      case AppServiceName.groupAccount:
        return 'Joint Funds';
      case AppServiceName.insurance:
        return 'Insurance';
      case AppServiceName.airtime:
        return 'Airtime';
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
  invoice,
  payInvoice,
  payElectricityBill,
  invest,
  exchange,
  crypto,
  giftCards,
  aiScanToPay,
  groupAccount,
  insurance,
  airtime,
}

extension AppServiceImgExtension on AppServiceImg {
  String get uri {
    switch (this) {
      case AppServiceImg.sendFunds:
        return 'assets/images/money-send.png';
      case AppServiceImg.invoice:
        return 'assets/images/money-receive.png';
      case AppServiceImg.payInvoice:
        return 'assets/images/wallet.png';
      case AppServiceImg.payElectricityBill:
        return 'assets/images/receive-square.png';
      case AppServiceImg.invest:
        return 'assets/images/trending-up.png';
      case AppServiceImg.exchange:
        return 'assets/images/exchange.png';
      case AppServiceImg.crypto:
        return 'assets/images/crypto.png';
      case AppServiceImg.giftCards:
        return 'assets/images/gift-cards.png';
      case AppServiceImg.aiScanToPay:
        return 'assets/images/ai-scan.png';
      case AppServiceImg.groupAccount:
        return 'assets/images/group-account.png';
      case AppServiceImg.insurance:
        return 'assets/images/insurance.png';
      case AppServiceImg.airtime:
        return 'assets/images/airtime.png';
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
