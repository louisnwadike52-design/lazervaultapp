import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Extension to map AppServiceName to TransactionServiceType
extension AppServiceNameMapper on AppServiceName {
  TransactionServiceType? toTransactionServiceType() {
    switch (this) {
      case AppServiceName.airtime:
        return TransactionServiceType.airtime;
      case AppServiceName.giftCards:
        return TransactionServiceType.giftCard;
      case AppServiceName.payElectricityBill:
        return TransactionServiceType.electricity;
      case AppServiceName.crypto:
        return TransactionServiceType.crypto;
      case AppServiceName.stocks:
        return TransactionServiceType.stocks;
      case AppServiceName.insurance:
        return TransactionServiceType.insurance;
      case AppServiceName.tagPay:
        return TransactionServiceType.tagPay;
      case AppServiceName.autoSave:
        return TransactionServiceType.autosave;
      case AppServiceName.crowdfund:
        return TransactionServiceType.crowdfund;
      case AppServiceName.barcodeQuickPay:
        return TransactionServiceType.barcodePayment;
      case AppServiceName.sendFunds:
      case AppServiceName.batchTransfer:
        return TransactionServiceType.transfer;
      case AppServiceName.invoice:
      case AppServiceName.payInvoice:
        return TransactionServiceType.invoice;
      case AppServiceName.exchange:
        return TransactionServiceType.unknown; // Currency exchange transactions
      case AppServiceName.aiScanToPay:
        return TransactionServiceType.unknown;
      case AppServiceName.groupAccount:
        return TransactionServiceType.unknown;
      case AppServiceName.invest:
        return TransactionServiceType.unknown;
      case AppServiceName.lockFunds:
        return TransactionServiceType.unknown;
      case AppServiceName.whatsappIntegration:
        return TransactionServiceType.unknown;
      case AppServiceName.contactlessPay:
        return TransactionServiceType.unknown;
    }
  }
}

/// Extension to map TransactionServiceType to AppServiceName
extension TransactionServiceTypeMapper on TransactionServiceType {
  AppServiceName? toAppServiceName() {
    switch (this) {
      case TransactionServiceType.airtime:
        return AppServiceName.airtime;
      case TransactionServiceType.giftCard:
        return AppServiceName.giftCards;
      case TransactionServiceType.electricity:
        return AppServiceName.payElectricityBill;
      case TransactionServiceType.water:
        return null; // No direct mapping
      case TransactionServiceType.tvSubscription:
        return null; // No direct mapping
      case TransactionServiceType.transfer:
        return AppServiceName.sendFunds;
      case TransactionServiceType.crypto:
        return AppServiceName.crypto;
      case TransactionServiceType.stocks:
        return AppServiceName.stocks;
      case TransactionServiceType.insurance:
        return AppServiceName.insurance;
      case TransactionServiceType.invoice:
        return AppServiceName.invoice;
      case TransactionServiceType.barcodePayment:
        return AppServiceName.barcodeQuickPay;
      case TransactionServiceType.tagPay:
        return AppServiceName.tagPay;
      case TransactionServiceType.crowdfund:
        return AppServiceName.crowdfund;
      case TransactionServiceType.autosave:
        return AppServiceName.autoSave;
      case TransactionServiceType.deposit:
        return null;
      case TransactionServiceType.withdrawal:
        return null;
      case TransactionServiceType.unknown:
        return null;
    }
  }

  /// Get the corresponding AppService object if available
  AppService? toAppService() {
    final appName = toAppServiceName();
    if (appName == null) return null;

    // Find the corresponding AppServiceImg
    final appImg = AppServiceImg.values.firstWhere(
      (img) => img.name == appName.name,
      orElse: () => AppServiceImg.sendFunds,
    );

    return AppService(serviceName: appName, serviceImg: appImg);
  }
}
