# Transaction History Integration Guide

This guide shows you how to integrate the new transaction history system into your existing service screens.

## Quick Start

### Option 1: Simple Button (Recommended)

Just add the history button anywhere in your service screen:

```dart
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

// In your build method
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        // Your existing content
        ...buildYourContent(),

        // Add history button
        ViewTransactionHistoryButton.airtime(
          isFullWidth: true,
        ),
      ],
    ),
  );
}
```

### Option 2: Using the Helper Class

```dart
import 'package:lazervault/src/features/transaction_history/integrations/add_transaction_history_to_screens.dart';

// In your build method
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        // Your existing content
        ...buildYourContent(),

        // Add complete history section
        ...TransactionHistoryScreenIntegration.buildHistorySection(
          serviceName: AppServiceName.airtime,
        ),
      ],
    ),
  );
}
```

## Service-Specific Examples

### 1. Airtime Service

**File:** `lib/src/features/airtime/presentation/view/airtime_screen.dart`

```dart
// Add this import
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

class AirtimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Your existing airtime UI
          AirtimePurchaseForm(),
          RecentAirtimeTransactions(),

          // Add history button at the bottom
          Padding(
            padding: const EdgeInsets.all(20),
            child: ViewTransactionHistoryButton.airtime(
              isFullWidth: true,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 2. Gift Cards Service

**File:** `lib/src/features/gift_cards/presentation/view/gift_cards_screen.dart`

```dart
// Add this import
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

class GiftCardsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gift Cards'),
        actions: [
          // Add history icon to app bar
          ViewTransactionHistoryIconButton.giftCards(),
        ],
      ),
      body: Column(
        children: [
          // Your existing gift cards UI
          GiftCardOptions(),

          // Add history section
          ...TransactionHistoryScreenIntegration.buildHistorySection(
            serviceName: AppServiceName.giftCards,
          ),
        ],
      ),
    );
  }
}
```

### 3. Crypto Service

**File:** `lib/src/features/crypto/presentation/view/crypto_screen.dart`

```dart
// Add this import
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

class CryptoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Your existing crypto UI
          CryptoPortfolio(),

          // Add history button
          Padding(
            padding: const EdgeInsets.all(20),
            child: ViewTransactionHistoryButton.crypto(
              customLabel: 'View Crypto Transactions',
              isFullWidth: true,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 4. Electricity Bill Service

**File:** `lib/src/features/electricity_bill/presentation/view/electricity_bill_home_screen.dart`

```dart
// Add this import
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

class ElectricityBillHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Your existing electricity bill UI
          BillPaymentForm(),

          // Add history section
          ...TransactionHistoryScreenIntegration.buildHistorySection(
            serviceName: AppServiceName.payElectricityBill,
            customTitle: 'Payment History',
          ),
        ],
      ),
    );
  }
}
```

### 5. Stocks Service

**File:** `lib/src/features/stocks/presentation/view/stocks_home_screen.dart`

```dart
// Add this import
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

class StocksHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks'),
        actions: [
          // Add history button to app bar
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              TransactionHistoryNavigationHelper.navigateToStocksHistory();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Your existing stocks UI
          StockPortfolio(),

          // Add text button for history
          Padding(
            padding: const EdgeInsets.all(20),
            child: ViewTransactionHistoryTextButton.stocks(),
          ),
        ],
      ),
    );
  }
}
```

### 6. Insurance Service

**File:** `lib/src/features/insurance/presentation/view/insurance_list_screen.dart`

```dart
// Add this import
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

class InsuranceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Your existing insurance UI
          InsurancePolicies(),

          // Add history button
          Padding(
            padding: const EdgeInsets.all(20),
            child: ViewTransactionHistoryButton.insurance(
              isFullWidth: true,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 7. Tag Pay Service

**File:** `lib/src/features/tag_pay/presentation/view/tag_pay_home_screen.dart`

```dart
// Add this import
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

class TagPayHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tag Pay'),
        actions: [
          ViewTransactionHistoryIconButton.tagPay(),
        ],
      ),
      body: Column(
        children: [
          // Your existing tag pay UI
          TagPayOptions(),

          // Add history section
          ...TransactionHistoryScreenIntegration.buildHistorySection(
            serviceName: AppServiceName.tagPay,
          ),
        ],
      ),
    );
  }
}
```

### 8. AutoSave Service

**File:** `lib/src/features/autosave/presentation/views/autosave_dashboard_screen.dart`

```dart
// Add this import
import 'package:lazervault/src/features/transaction_history/presentation/widgets/view_transaction_history_button.dart';

class AutoSaveDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Your existing autosave UI
          AutoSaveRules(),

          // Add history button
          Padding(
            padding: const EdgeInsets.all(20),
            child: ViewTransactionHistoryButton.autoSave(
              isFullWidth: true,
            ),
          ),
        ],
      ),
    );
  }
}
```

## Navigate After Successful Transaction

After a user completes a transaction, navigate them to the transaction history:

```dart
// In your payment success handler
void _onPaymentSuccess() {
  // Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Payment successful!')),
  );

  // Navigate to transaction history
  TransactionHistoryNavigationHelper.navigateToAirtimeHistory();
}
```

## All Available Button Variants

### 1. Full Width Button
```dart
ViewTransactionHistoryButton.airtime(isFullWidth: true)
```

### 2. Outlined Button
```dart
ViewTransactionHistoryButton.giftCards(isOutlined: true)
```

### 3. Text Button
```dart
ViewTransactionHistoryTextButton.crypto()
```

### 4. Icon Button (for AppBars)
```dart
ViewTransactionHistoryIconButton.stocks()
```

### 5. Custom Label
```dart
ViewTransactionHistoryButton(
  serviceName: AppServiceName.electricity,
  customLabel: 'View Payment History',
)
```

### 6. View All Transactions (Dashboard)
```dart
ViewTransactionHistoryButton.showAll()
```

## Direct Navigation (No Widget)

Sometimes you just want to navigate without showing a button:

```dart
import 'package:lazervault/src/features/transaction_history/utils/transaction_history_navigation_helper.dart';

// Navigate to dashboard (all transactions)
onPressed: () {
  TransactionHistoryNavigationHelper.navigateToDashboard();
}

// Navigate to specific service
onPressed: () {
  TransactionHistoryNavigationHelper.navigateToAirtimeHistory();
  TransactionHistoryNavigationHelper.navigateToGiftCardHistory();
  TransactionHistoryNavigationHelper.navigateToElectricityBillHistory();
  TransactionHistoryNavigationHelper.navigateToCryptoHistory();
  TransactionHistoryNavigationHelper.navigateToStocksHistory();
  TransactionHistoryNavigationHelper.navigateToInsuranceHistory();
  TransactionHistoryNavigationHelper.navigateToTagPayHistory();
  TransactionHistoryNavigationHelper.navigateToAutoSaveHistory();
}
```

## Switching from Mock Data to Real API

When your backend API is ready, update the dependency injection:

**File:** `lib/core/services/injection_container.dart`

Change line:
```dart
useMockData: true, // Change to false when API is ready
```

To:
```dart
useMockData: false, // Now using real API
```

## API Endpoints Required

Your backend should implement these endpoints:

```
GET  /transactions                    - Get all transactions (paginated)
GET  /transactions/{serviceType}      - Get transactions for a service
GET  /transactions/{id}               - Get single transaction
GET  /transactions/search?q={query}   - Search transactions
GET  /transactions/statistics         - Get transaction statistics
POST /transactions/sync               - Refresh/sync transactions
```

## Testing

To test the integration:

1. Run your app
2. Navigate to any service screen
3. Click the "View History" button
4. Verify the transaction history screen opens
5. Test filters and search functionality
6. Verify transaction details modal works

## Troubleshooting

**Button not appearing:**
- Make sure you've added the import
- Check that the widget is in the widget tree
- Verify the service name is correct

**Navigation not working:**
- Ensure routes are registered in `app_router.dart`
- Check that dependency injection is set up correctly
- Verify the navigation helper is imported

**Transactions not showing:**
- Check that `useMockData: true` in injection container (for testing)
- Verify mock data is initialized
- Check for any console errors

## Need Help?

For issues or questions, refer to:
- `/lib/core/types/unified_transaction.dart` - Data models
- `/lib/src/features/transaction_history/presentation/widgets/` - UI widgets
- `/lib/src/features/transaction_history/utils/transaction_history_navigation_helper.dart` - Navigation helpers
