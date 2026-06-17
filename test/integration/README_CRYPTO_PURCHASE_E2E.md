# Crypto Purchase End-to-End Integration Tests

## Overview

This test suite simulates the complete user journey for purchasing cryptocurrency through the LazerVault app. It tests the actual frontend widgets making real gRPC calls to backend services.

## Test Flow

The complete E2E test covers these steps:

1. **Landing Page Verification**: User lands on crypto screen and views their wallets
2. **Buy Screen Navigation**: User navigates to the purchase screen
3. **Crypto Selection**: User selects a cryptocurrency (Bitcoin by default)
4. **Amount Entry**: User enters the purchase amount
5. **Payment Method Verification**: Confirms LazerVault Wallet as payment source
6. **Purchase Initiation**: User taps the Buy button
7. **PIN Entry**: User enters their 4-digit transaction PIN
8. **Transaction Processing**: System processes the purchase through backend
9. **Success Verification**: Confirms transaction completed successfully

## Prerequisites

### Required Backend Services

All these services must be running locally:

| Service | Port | Purpose |
|---------|------|---------|
| core-gateway | 7878 (HTTP) | Authentication, user data |
| crypto-gateway | 9090 (HTTP) | Crypto operations routing |
| crypto-service | - | Crypto transactions, wallet management |
| accounts-service | - | Balance operations |
| auth-service | 50051 | JWT token validation |

### Start All Services

```bash
cd /Users/louislawrence/Music/apps/stack/lazervault-app-platform
./start_all_local_no_docker.sh
```

### Test User Requirements

The test user must have:
- ✅ Valid JWT token (passed via `--dart-define=TEST_JWT_TOKEN`)
- ✅ 4-digit transaction PIN set (default test PIN: `1234`)
- ✅ At least one crypto wallet created
- ✅ Sufficient balance in LazerVault Wallet (minimum ₦1,000 NGN)
- ✅ Active account status

## Running the Tests

### Option 1: Quick Test (Skip Tests)

```bash
cd lazervaultapp
flutter test test/integration/crypto_purchase_e2e_test.dart
```

Tests will be skipped if `TEST_JWT_TOKEN` is not provided.

### Option 2: Full Integration Test

```bash
# First, get a valid JWT token from your backend or auth service
# Then run the test with the token
flutter test test/integration/crypto_purchase_e2e_test.dart \
  --dart-define=TEST_JWT_TOKEN=your_actual_jwt_token_here
```

### Option 3: Test with Detailed Output

```bash
flutter test test/integration/crypto_purchase_e2e_test.dart \
  --dart-define=TEST_JWT_TOKEN=your_token \
  --reporter expanded
```

## Test Configuration

### Default Test Values

| Configuration | Value | Description |
|--------------|-------|-------------|
| `TEST_JWT_TOKEN` | (required) | JWT token for authentication |
| `_testPin` | `1234` | Transaction PIN to use |
| `_testPurchaseAmount` | `1000.0` | Amount in NGN to spend |
| `_preferredCryptoId` | `bitcoin` | Preferred crypto to buy |
| `_transactionTimeout` | 30 seconds | Max wait for transaction |

### Customizing Test Values

Edit the test file to change defaults:

```dart
const String _testPin = '1234';                    // Your test PIN
const double _testPurchaseAmount = 1000.0;         // Amount to spend
const String _preferredCryptoId = 'bitcoin';       // Crypto to buy
```

## Test Cases

### 1. Complete Purchase Flow

**File**: `crypto_purchase_e2e_test.dart` - Test: `E2E: Complete crypto purchase flow from landing to receipt`

**What it tests**:
- ✅ Landing page displays user wallets
- ✅ Buy screen loads correctly
- ✅ Crypto selection is displayed
- ✅ Amount input works
- ✅ Order summary calculates correctly
- ✅ Payment method is verified
- ✅ Buy button triggers PIN entry
- ✅ PIN validation works
- ✅ Transaction processes successfully
- ✅ Receipt/confirmation appears

**Expected output**:
```
📍 STEP 1: Landing Page - Verify Wallet Display
✅ User can view wallet on landing page

📍 STEP 2: Navigate to Buy Screen
✅ Navigated to Buy Screen

📍 STEP 3: Verify Crypto Selection
✅ Crypto is pre-selected: Bitcoin (BTC)

📍 STEP 4: Enter Purchase Amount
✅ Entered amount: ₦1000.0

📍 STEP 5: Verify Payment Method
✅ Payment method verified: LazerVault Wallet

📍 STEP 6: Initiate Purchase (Tap Buy)
✅ Buy button tapped - PIN entry should appear

📍 STEP 7: Enter Transaction PIN
✅ PIN entered: 1234

📍 STEP 8: Processing Transaction
✅ Transaction is processing...
   Step: executingOrder
   Progress: 60%
✅ Transaction completed successfully!
   Transaction ID: BUY-1234567890
   Crypto: BTC
   Quantity: 0.000021
   Total: ₦1000.00

🎉 COMPLETE: End-to-end crypto purchase flow succeeded!
```

### 2. Quick Amount Button

**Test**: `E2E: Buy with different amount (quick amount button)`

**What it tests**:
- ✅ Quick amount buttons (₦5,000, ₦10,000, ₦25,000, ₦50,000) work
- ✅ Amount is filled correctly
- ✅ Order summary updates

### 3. Insufficient Balance Handling

**Test**: `E2E: Verify insufficient balance handling`

**What it tests**:
- ✅ User can enter any amount
- ✅ Backend validates balance
- ✅ Appropriate error handling (tested at UI level)

## Troubleshooting

### Tests Skipped

**Issue**: All tests are skipped
```
00:00 +0 ~3: All tests skipped.
```

**Solution**: Provide a valid JWT token
```bash
flutter test test/integration/crypto_purchase_e2e_test.dart \
  --dart-define=TEST_JWT_TOKEN=your_token
```

### Service Locator Not Initialized

**Issue**:
```
⚠️  Service locator initialization timed out
```

**Solution**: Ensure all backend services are running
```bash
./start_all_local_no_docker.sh
```

### No Wallets Found

**Issue**:
```
❌ User has no wallets. Cannot proceed with purchase.
```

**Solution**: User needs crypto wallets created. This happens automatically when:
1. User signs up
2. User navigates to crypto screen (wallets are auto-created)

### CryptoCubit Not Registered

**Issue**:
```
Exception: CryptoCubit not registered in service locator
```

**Solution**: Check `lazervaultapp/lib/core/services/injection_container.dart`
- Ensure `registerLazySingleton<CryptoCubit>` is present
- Ensure crypto dependencies are registered

### Transaction Failed

**Issue**:
```
❌ Transaction failed: Insufficient balance
```

**Solution**: Ensure user has sufficient balance
```bash
# Check user balance via API or admin dashboard
curl -H "Authorization: Bearer YOUR_TOKEN" \
  http://localhost:7878/api/v1/accounts/balance
```

### PIN Validation Failed

**Issue**:
```
❌ Transaction failed: Invalid PIN
```

**Solution**:
1. Ensure user has a PIN set
2. Update `_testPin` in test file to match user's actual PIN
3. Or set PIN via API:
```bash
curl -X POST http://localhost:7878/api/v1/users/pin \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"pin": "1234"}'
```

## Backend API Calls Made

During the test, the following gRPC calls are made:

1. **Load Wallets**:
   - `CryptoServiceClient.getWallets()`
   - Returns user's crypto wallets with addresses

2. **Get Supported Assets**:
   - `CryptoServiceClient.getSupportedAssets()`
   - Returns list of tradable cryptocurrencies

3. **Buy Crypto**:
   - `CryptoServiceClient.buyCrypto()`
   - Parameters:
     - `cryptoId`: e.g., "bitcoin"
     - `fiatAmount`: e.g., 1000.0
     - `fiatCurrency`: "NGN"
     - `transactionPin`: "1234"
     - `idempotencyKey`: Generated UUID

4. **Load Cryptos (Post-transaction)**:
   - `CryptoServiceClient.getCryptos()`
   - Reloads to show updated balances

## Test Output Example

### Successful Run

```
00:00 +0: loading /Users/louislawrence/.../crypto_purchase_e2e_test.dart
00:00 +0: (setUpAll)
🔧 Initializing service locator...
✅ Service locator initialized successfully
00:00 +0: Crypto Purchase - End-to-End Flow E2E: Complete crypto purchase flow from landing to receipt
📥 Loading user wallets...
✅ Loaded 5 wallets:
  - BTC: bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh
  - ETH: 0x71C7656EC7ab88b098defB751B7401B5f6d8976F
  - USDT: TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t
  - USDC: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
  - DOGE: D7rXGB4zMk5pUwNvHJj6zY2nZQYqXzYzYz
✅ Selected crypto for purchase: Bitcoin (BTC)
   Current price: ₦45,000,000.00

🏁 Test setup complete

📍 STEP 1: Landing Page - Verify Wallet Display
✅ User can view wallet on landing page
...
🎉 COMPLETE: End-to-end crypto purchase flow succeeded!

00:03 +1: Crypto Purchase - End-to-End Flow E2E: Buy with different amount (quick amount button)
✅ Quick amount button tapped
00:04 +2: Crypto Purchase - End-to-End Flow E2E: Verify insufficient balance handling
✅ Insufficient balance scenario tested
00:04 +3: (tearDownAll)
00:04 +3: All tests passed!
```

### Failed Run (Missing Token)

```
00:00 +0: loading /Users/louislawrence/.../crypto_purchase_e2e_test.dart
00:00 +0: (setUpAll)
🔧 Initializing service locator...
✅ Service locator initialized successfully
00:00 +0 ~1: Crypto Purchase - End-to-End Flow E2E: Complete crypto purchase flow from landing to receipt
00:00 +0 ~2: Crypto Purchase - End-to-End Flow E2E: Buy with different amount (quick amount button)
00:00 +0 ~3: Crypto Purchase - End-to-End Flow E2E: Verify insufficient balance handling
00:00 +0 ~3: (tearDownAll)
00:00 +0 ~3: All tests skipped.
```

## Related Files

- **Test File**: `test/integration/crypto_purchase_e2e_test.dart`
- **Buy Screen**: `lib/src/features/crypto/presentation/view/buy_crypto_screen.dart`
- **Processing Screen**: `lib/src/features/crypto/presentation/view/crypto_processing_screen.dart`
- **Crypto Cubit**: `lib/src/features/crypto/cubit/crypto_cubit.dart`
- **gRPC Client**: `lib/src/core/grpc/crypto_grpc_client.dart`
- **Service Container**: `lib/core/services/injection_container.dart`

## Contributing

When adding new E2E tests:

1. Follow the same structure with clear step-by-step logging
2. Use descriptive test names that explain the scenario
3. Add comments for complex operations
4. Handle timeouts gracefully
5. Clean up state in `tearDown()`
6. Update this README with new test cases

## Support

For issues or questions:
- Check backend logs: `./services/crypto-service/logs/`
- Check gateway logs: `./services/crypto-gateway/logs/`
- Verify all services are running: `ps aux | grep -E "(crypto|gateway)"`
