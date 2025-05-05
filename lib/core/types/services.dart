enum AppServiceName {
  sendFunds('Send'),
  receiveFunds('Receive'),
  sendCrypto('Send Crypto'),
  receiveCrypto('Crypto'),
  requestFunds('Request'),
  transferFunds('Transfer'),
  payElectricityBill('Electricity'),
  stocks('Stocks'),
  bills('Bills'),
  flights('Flights'),
  crypto('Crypto'),
  exchange('Exchange');

  final String displayName;

  const AppServiceName(this.displayName);
}

final List<String> imagePaths = [
  'assets/images/money-receive.png',
  'assets/images/money-send.png',
  'assets/images/receive-square.png',
  'assets/images/wallet.png',
];

enum AppServiceImg {
  sendFunds('assets/images/money-receive.png'),
  receiveFunds('assets/images/money-send.png'),
  sendCrypto('assets/images/receive-square.png'),
  receiveCrypto('assets/images/wallet.png'),
  requestFunds('assets/images/wallet.png'),
  transferFunds('assets/images/wallet.png'),
  bills('assets/images/wallet.png'),
  payElectricityBill('assets/images/wallet.png'),
  flights('assets/images/wallet.png'),
  crypto('assets/images/wallet.png'),
  stocks('assets/images/wallet.png'),
  exchange('assets/images/wallet.png');

  final String uri;

  const AppServiceImg(this.uri);
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
