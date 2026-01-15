# Transaction PIN Integration Guide

## Overview

The Transaction PIN service provides secure verification for all payment operations in the app. This guide explains how to integrate PIN validation into payment flows.

## Architecture

### Components Created

1. **TransactionPinService** (`lib/src/features/transaction_pin/services/transaction_pin_service.dart`)
   - Handles all gRPC calls to the backend
   - Methods: checkUserHasPin, verifyPin, validateToken, createPin, changePin, resetPin

2. **TransactionPinModal** (`lib/src/features/transaction_pin/widgets/transaction_pin_modal.dart`)
   - Reusable PIN entry modal
   - Handles PIN input, visibility toggle, amount display
   - Shows remaining attempts and error messages

3. **TransactionPinMixin** (`lib/src/features/transaction_pin/mixins/transaction_pin_mixin.dart`)
   - Mixin for easy integration into payment screens
   - Handles all edge cases: locked PIN, retry logic, cancellation
   - Provides simple API for payment flows

4. **TransactionPinCubit** (`lib/src/features/transaction_pin/cubit/transaction_pin_cubit.dart`)
   - State management for PIN operations
   - Can be used with BlocBuilder for reactive UI

## Integration Steps

### Option 1: Using TransactionPinMixin (Recommended)

This is the simplest approach for most payment flows.

#### Example: Airtime Payment

```dart
class _AirtimePaymentConfirmationState extends State<AirtimePaymentConfirmationScreen>
    with TransactionPinMixin {

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.ITransactionPinService;

  Future<void> _processPayment() async {
    // Generate unique transaction ID
    final transactionId = 'airtime_${DateTime.now().millisecondsSinceEpoch}';

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'airtime_purchase',
      amount: widget.amount,
      currency: 'NGN',
      title: 'Confirm Airtime Purchase',
      message: 'Enter your PIN to purchase ${widget.amount} airtime',
      onPinValidated: (verificationToken) async {
        // Execute the actual payment with the verification token
        await _executeAirtimePurchase(verificationToken);
      },
    );

    if (!success) {
      // PIN validation failed or was cancelled
      // Handle accordingly (e.g., go back to previous screen)
    }
  }

  Future<void> _executeAirtimePurchase(String token) async {
    try {
      // Call your payment API with the verification token
      final response = await airtimeService.purchase(
        phoneNumber: widget.phoneNumber,
        amount: widget.amount,
        verificationToken: token, // ← Important: include token in API call
      );

      // Handle success
      _navigateToSuccessScreen(response);
    } catch (e) {
      // Handle error
      _showError(e.toString());
    }
  }
}
```

### Option 2: Using TransactionPinCubit

Use this when you need more control over the UI or want reactive state management.

```dart
class _MyPaymentScreen extends State<MyPaymentScreen> {
  late final TransactionPinCubit _pinCubit;

  @override
  void initState() {
    super.initState();
    _pinCubit = GetIt.ITransactionPinCubit;
    _pinCubit.checkUserHasPin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionPinCubit, TransactionPinState>(
      bloc: _pinCubit,
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }

        if (!state.hasPin) {
          return _createSetupPinPrompt();
        }

        return _buildPaymentButton();
      },
    );
  }

  Future<void> _verifyAndProcessPayment() async {
    // Show PIN modal
    final pin = await showTransactionPinModal(
      context,
      amount: widget.amount,
      currency: 'NGN',
    );

    if (pin == null) return; // User cancelled

    // Verify PIN
    final result = await _pinCubit.verifyPin(
      pin: pin,
      transactionId: 'txn_123',
      transactionType: 'transfer',
      amount: widget.amount,
      currency: 'NGN',
    );

    if (result?.success == true) {
      await _executePayment(result!.verificationToken!);
    } else if (result?.isLocked == true) {
      _showPinLockedDialog(result!.lockedUntil!);
    } else {
      _showIncorrectPinDialog(result?.remainingAttempts ?? 0);
    }
  }
}
```

## Edge Cases Handled

### 1. PIN Not Set Up
- User is prompted to create a PIN
- Redirected to PIN creation screen
- Payment blocked until PIN is created

### 2. Incorrect PIN
- Shows error message with remaining attempts
- Allows retry up to max attempts (default: 3)
- Shows warning as attempts decrease

### 3. PIN Locked
- Shows lockout message with time remaining
- Blocks further PIN entry attempts
- Suggests "Forgot PIN" option

### 4. Network Errors
- Shows user-friendly error messages
- Allows retry on transient failures
- Logs detailed errors for debugging

### 5. User Cancellation
- Cleanly cancels the payment flow
- Returns to previous screen
- No partial state left behind

## Payment Flow Checklist

For each payment flow, ensure you:

- [ ] Generate unique transaction ID
- [ ] Add TransactionPinMixin to screen state
- [ ] Implement ITransactionPinService getter
- [ ] Call validateTransactionPin with correct parameters
- [ ] Pass verification token to payment API
- [ ] Handle all response scenarios (success, failure, locked)
- [ ] Test with correct PIN
- [ ] Test with incorrect PIN
- [ ] Test with locked PIN
- [ ] Test cancellation

## Transaction Types

Use these transaction_type values:

| Transaction Type | Value |
|-----------------|-------|
| Airtime/Data Purchase | `airtime_purchase` |
| Bill Payment | `bill_payment` |
| Money Transfer | `transfer` |
| Gift Card Purchase | `gift_card_purchase` |
| Stock Trade | `stock_trade` |
| Crypto Transaction | `crypto_transaction` |
| Currency Exchange | `currency_exchange` |
| Barcode Payment | `barcode_payment` |

## API Integration

When calling your payment microservices, include the verification token:

```dart
// Backend API should expect and validate the token
final response = await paymentService.executeTransfer(
  recipientAccount: recipient,
  amount: amount,
  currency: currency,
  verificationToken: token, // ← From PIN validation
);
```

## Testing

### Test Scenarios

1. **Happy Path**: Correct PIN → Payment succeeds
2. **Wrong PIN**: Incorrect PIN → Error shown → Retry allowed
3. **No PIN**: User without PIN → Prompted to create one
4. **Locked PIN**: Too many attempts → Lockout message shown
5. **Cancellation**: User cancels → Flow aborted cleanly
6. **Network Error**: Connection fails → User-friendly message

### Manual Testing Steps

1. Set up a test account with a known PIN (e.g., 1234)
2. Attempt payment with correct PIN → Should succeed
3. Attempt payment with wrong PIN → Should show error
4. Enter wrong PIN 3 times → Should show locked message
5. Wait for lockout to expire (15 minutes) → Should allow retry
6. Cancel PIN entry → Should return to previous screen

## Files Modified

### Created
- `lib/src/features/transaction_pin/services/transaction_pin_service.dart`
- `lib/src/features/transaction_pin/widgets/transaction_pin_modal.dart`
- `lib/src/features/transaction_pin/mixins/transaction_pin_mixin.dart`
- `lib/src/features/transaction_pin/cubit/transaction_pin_cubit.dart`
- `proto/transaction_pin.proto`
- `lib/src/generated/transaction_pin.pb.dart`
- `lib/src/generated/transaction_pin.pbenum.dart`
- `lib/src/generated/transaction_pin.pbgrpc.dart`
- `lib/src/generated/transaction_pin.pbjson.dart`

### Modified
- `lib/core/services/injection_container.dart` (added registrations)

## Next Steps

To complete the integration:

1. **Airtime/Data Flow**: Integrate into `airtime_payment_processing_screen.dart`
2. **Bill Payment**: Integrate into `electricity_bill/payment_confirmation_screen.dart`
3. **Gift Cards**: Integrate into `gift_card_purchase_processing_screen.dart`
4. **Transfers**: Integrate into `send_funds_transfer_processing_screen.dart`
5. **Stocks**: Integrate into `stock_trade_confirmation_screen.dart`
6. **Crypto**: Integrate into `crypto_confirmation_screen.dart`
7. **Currency Exchange**: Integrate into `exchange_confirmation_screen.dart`
8. **Barcode Payment**: Integrate into `barcode_payment_confirmation_screen.dart`

See `TRANSACTION_PIN_INTEGRATION_EXAMPLE.dart` for a complete working example.
