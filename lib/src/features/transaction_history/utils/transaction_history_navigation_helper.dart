import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/unified_transaction.dart';

/// Navigation helper for Transaction History screens
///
/// Usage:
/// ```dart
/// // Navigate to dashboard transaction history (all services)
/// TransactionHistoryNavigationHelper.navigateToDashboard();
///
/// // Navigate to service-specific transaction history
/// TransactionHistoryNavigationHelper.navigateToServiceHistory(TransactionServiceType.airtime);
///
/// // Navigate with filters
/// TransactionHistoryNavigationHelper.navigateToDashboard(filters: ...);
/// ```
class TransactionHistoryNavigationHelper {
  TransactionHistoryNavigationHelper._();

  /// Navigate to Dashboard Transaction History (All Services)
  ///
  /// Shows all transactions from all services with filtering options
  static Future<void> navigateToDashboard() async {
    await Get.toNamed(AppRoutes.dashboardTransactionHistory);
  }

  /// Navigate to Service-Specific Transaction History
  ///
  /// [serviceType] - The type of service (airtime, giftCard, electricity, etc.)
  ///
  /// Example:
  /// ```dart
  /// TransactionHistoryNavigationHelper.navigateToServiceHistory(
  ///   TransactionServiceType.airtime,
  /// );
  /// ```
  static Future<void> navigateToServiceHistory(
    TransactionServiceType serviceType,
  ) async {
    await Get.toNamed(
      AppRoutes.serviceTransactionHistory,
      arguments: serviceType,
    );
  }

  /// Navigate to Airtime Transaction History
  static Future<void> navigateToAirtimeHistory() async {
    await navigateToServiceHistory(TransactionServiceType.airtime);
  }

  /// Navigate to Gift Card Transaction History
  static Future<void> navigateToGiftCardHistory() async {
    await navigateToServiceHistory(TransactionServiceType.giftCard);
  }

  /// Navigate to Electricity Bill Transaction History
  static Future<void> navigateToElectricityBillHistory() async {
    await navigateToServiceHistory(TransactionServiceType.electricity);
  }

  /// Navigate to Water Bill Transaction History
  static Future<void> navigateToWaterBillHistory() async {
    await navigateToServiceHistory(TransactionServiceType.water);
  }

  /// Navigate to TV Subscription Transaction History
  static Future<void> navigateToTVSubscriptionHistory() async {
    await navigateToServiceHistory(TransactionServiceType.tvSubscription);
  }

  /// Navigate to Transfer Transaction History
  static Future<void> navigateToTransferHistory() async {
    await navigateToServiceHistory(TransactionServiceType.transfer);
  }

  /// Navigate to Crypto Transaction History
  static Future<void> navigateToCryptoHistory() async {
    await navigateToServiceHistory(TransactionServiceType.crypto);
  }

  /// Navigate to Stocks Transaction History
  static Future<void> navigateToStocksHistory() async {
    await navigateToServiceHistory(TransactionServiceType.stocks);
  }

  /// Navigate to Insurance Transaction History
  static Future<void> navigateToInsuranceHistory() async {
    await navigateToServiceHistory(TransactionServiceType.insurance);
  }

  /// Navigate to Invoice Payment Transaction History
  static Future<void> navigateToInvoiceHistory() async {
    await navigateToServiceHistory(TransactionServiceType.invoice);
  }

  /// Navigate to Tag Pay Transaction History
  static Future<void> navigateToTagPayHistory() async {
    await navigateToServiceHistory(TransactionServiceType.tagPay);
  }

  /// Navigate to Crowdfund Transaction History
  static Future<void> navigateToCrowdfundHistory() async {
    await navigateToServiceHistory(TransactionServiceType.crowdfund);
  }

  /// Navigate to AutoSave Transaction History
  static Future<void> navigateToAutoSaveHistory() async {
    await navigateToServiceHistory(TransactionServiceType.autosave);
  }

  /// Navigate to Deposit Transaction History
  static Future<void> navigateToDepositHistory() async {
    await navigateToServiceHistory(TransactionServiceType.deposit);
  }

  /// Navigate to Withdrawal Transaction History
  static Future<void> navigateToWithdrawalHistory() async {
    await navigateToServiceHistory(TransactionServiceType.withdrawal);
  }

  /// Navigate to Barcode Payment Transaction History
  static Future<void> navigateToBarcodePaymentHistory() async {
    await navigateToServiceHistory(TransactionServiceType.barcodePayment);
  }

  /// Replace current screen with Dashboard Transaction History
  ///
  /// Use this when you want to replace the current screen instead of pushing
  static Future<void> replaceWithDashboard() async {
    await Get.offAllNamed(AppRoutes.dashboardTransactionHistory);
  }

  /// Replace current screen with Service-Specific Transaction History
  ///
  /// Use this when you want to replace the current screen instead of pushing
  static Future<void> replaceWithServiceHistory(
    TransactionServiceType serviceType,
  ) async {
    await Get.offAllNamed(
      AppRoutes.serviceTransactionHistory,
      arguments: serviceType,
    );
  }

  /// Navigate back from transaction history
  static void goBack() {
    Get.back();
  }

  /// Navigate back to dashboard transaction history
  ///
  /// Useful when navigating from service-specific history back to dashboard
  static void goToDashboardFromService() {
    Get.until((route) {
      return route.settings.name == AppRoutes.dashboardTransactionHistory ||
             route.settings.name == AppRoutes.dashboard;
    });
  }
}

/// Extension to provide easy access to transaction history navigation
extension TransactionHistoryNavigation on GetInterface {
  /// Navigate to dashboard transaction history
  Future<void> toDashboardTransactionHistory() =>
      TransactionHistoryNavigationHelper.navigateToDashboard();

  /// Navigate to service-specific transaction history
  Future<void> toServiceTransactionHistory(TransactionServiceType serviceType) =>
      TransactionHistoryNavigationHelper.navigateToServiceHistory(serviceType);
}
