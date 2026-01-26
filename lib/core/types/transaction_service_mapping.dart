import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/core/types/services.dart';

/// Extension to map TransactionServiceType to AppServiceName
/// This bridges the gap between transaction history types and app service features
extension TransactionServiceTypeMapping on TransactionServiceType {
  /// Maps TransactionServiceType to AppServiceName
  /// Returns null if there's no corresponding service
  AppServiceName? get toAppServiceName {
    switch (this) {
      case TransactionServiceType.airtime:
        return AppServiceName.airtime;
      case TransactionServiceType.giftCard:
        return AppServiceName.giftCards;
      case TransactionServiceType.electricity:
        return AppServiceName.payElectricityBill;
      case TransactionServiceType.water:
        return null; // No dedicated service yet
      case TransactionServiceType.tvSubscription:
        return null; // No dedicated service yet
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
        return null; // Not a specific service
      case TransactionServiceType.withdrawal:
        return null; // Not a specific service
      case TransactionServiceType.unknown:
        return null;
    }
  }

  /// Maps TransactionServiceType directly to backend service name
  /// This is the primary method to use when calling accounts-service
  String? get backendServiceName {
    final appName = toAppServiceName;
    return appName?.backendServiceName;
  }
}

/// Extension to create reverse mapping from AppServiceName to TransactionServiceType
extension AppServiceNameTransactionMapping on AppServiceName {
  /// Maps AppServiceName to TransactionServiceType
  /// Returns unknown if there's no direct mapping, but never null
  TransactionServiceType get toTransactionServiceType {
    switch (this) {
      case AppServiceName.sendFunds:
        return TransactionServiceType.transfer;
      case AppServiceName.batchTransfer:
        return TransactionServiceType.transfer;
      case AppServiceName.tagPay:
        return TransactionServiceType.tagPay;
      case AppServiceName.invoice:
        return TransactionServiceType.invoice;
      case AppServiceName.payInvoice:
        return TransactionServiceType.invoice;
      case AppServiceName.payElectricityBill:
        return TransactionServiceType.electricity;
      case AppServiceName.invest:
        return TransactionServiceType.stocks;
      case AppServiceName.stocks:
        return TransactionServiceType.stocks;
      case AppServiceName.exchange:
        return TransactionServiceType.crypto;
      case AppServiceName.crypto:
        return TransactionServiceType.crypto;
      case AppServiceName.giftCards:
        return TransactionServiceType.giftCard;
      case AppServiceName.aiScanToPay:
        return TransactionServiceType.barcodePayment;
      case AppServiceName.barcodeQuickPay:
        return TransactionServiceType.barcodePayment;
      case AppServiceName.groupAccount:
        return TransactionServiceType.unknown; // Not a transaction type
      case AppServiceName.insurance:
        return TransactionServiceType.insurance;
      case AppServiceName.airtime:
        return TransactionServiceType.airtime;
      case AppServiceName.autoSave:
        return TransactionServiceType.autosave;
      case AppServiceName.crowdfund:
        return TransactionServiceType.crowdfund;
      case AppServiceName.lockFunds:
        return TransactionServiceType.unknown; // Not a transaction type
      case AppServiceName.whatsappIntegration:
        return TransactionServiceType.unknown; // Not a transaction type
      case AppServiceName.contactlessPay:
        return TransactionServiceType.unknown; // Not a transaction type
    }
  }
}
