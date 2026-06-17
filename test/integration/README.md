# Crypto Wallet Integration Tests

## Overview

These tests use **real Flutter widgets** and make **real gRPC backend calls** - NO MOCKS.

### What's Tested

✅ **Real Widget Rendering**
- `CryptoScreen` - Main crypto portfolio screen
- `CryptoWalletsScreen` - Wallet list with search
- `UserHoldingsScreen` - Sellable wallets screen

✅ **Real Backend Calls**
- Direct gRPC calls to `crypto-gateway` (localhost:9090)
- Direct gRPC calls to `core-gateway` (localhost:7878)
- Real Quidax sub-account wallet data
- Real balance calculations from wallet mirrors

✅ **Real Data Flow**
- Wallet provisioning from Quidax
- Deposit address generation
- Balance synchronization
- Portfolio value calculation from wallets (not holdings)

## Prerequisites

### 1. Backend Services Running

```bash
# Start all services (or at minimum these two):
./start_all_local_no_docker.sh

# Or start individually:
cd services/core-gateway && go run cmd/server/main.go  # Port 7878
cd services/financial-gateway && go run cmd/server/main.go  # Port 9090
```

### 2. Environment Setup

Ensure your `.env` files have the correct backend URLs:

**`lazervaultapp/.env`**:
```
CORE_GATEWAY_URL=http://localhost:7878
CRYPTO_GATEWAY_URL=http://localhost:9090
```

### 3. Test Data

The backend should have:
- At least one test user
- Crypto wallets provisioned (via Quidax)
- Some wallet balances for sellable wallet tests

## Running the Tests

### Quick Start (All Tests)

```bash
cd lazervaultapp

# Run all crypto integration tests
flutter test test/integration/crypto_wallets_integration_test.dart --timeout=15m
```

### Individual Test Suites

```bash
# Test wallet rendering with real data
flutter test test/integration/crypto_wallets_integration_test.dart --name="CryptoScreen renders"

# Test wallet list screen
flutter test test/integration/crypto_wallets_integration_test.dart --name="CryptoWalletsScreen displays"

# Test sellable wallets
flutter test test/integration/crypto_wallets_integration_test.dart --name="UserHoldingsScreen shows"

# Test wallet search
flutter test test/integration/crypto_wallets_integration_test.dart --name="Wallet search filters"

# Test backend connectivity
flutter test test/integration/crypto_wallets_integration_test.dart --name="Can connect to"
```

### With JWT Token (Optional)

If your backend requires authentication:

```bash
flutter test test/integration/crypto_wallets_integration_test.dart \
  --dart-define=TEST_JWT_TOKEN=your_jwt_token_here
```

## What NOT to Expect

❌ **No Mocked Repositories**
- We use `serviceLocator<CryptoCubit>()` - the real cubit
- We use `CryptoRepository` from DI - real gRPC calls

❌ **No Mocked Data**
- All wallet data comes from real backend
- All balances are real Quidax sub-account mirrors

❌ **No Fake Widgets**
- We pump `CryptoScreen`, `CryptoWalletsScreen` - actual production widgets
- Not simplified test widgets

## Test Output Example

```
✓ Loaded 15 wallets from backend
✓ Total wallet value: $12,450.78
✓ Displayed wallet details for BTC
✓ Address: bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh
✓ Balance: 0.45000000
✓ Displayed 8 sellable wallets
✓ Search filtered wallets for symbol: BTC
✓ All wallets have IDs and addresses from backend
✓ First 3 wallets:
  - BTC: wallet-btc-001 (bc1qxy2kgd...)
  - ETH: wallet-eth-001 (0x742d35Cc...)
  - USDT: wallet-usdt-001 (TRC20-xyz12...)

✓ Successfully connected to crypto-gateway at localhost:9090
✓ Successfully connected to core-gateway at localhost:7878

All tests passed!
```

## Troubleshooting

### "Connection refused" Error

**Problem**: Can't connect to backend

**Solution**:
```bash
# Check if services are running
lsof -i :7878  # core-gateway
lsof -i :9090  # crypto-gateway

# Start services if not running
./start_all_local_no_docker.sh
```

### "No wallets found" Warning

**Problem**: Backend has no wallet data

**Solution**:
- Create a test user in the backend
- Trigger wallet provisioning (via signup or lazy creation)
- Verify wallets exist: `curl http://localhost:9090/api/v1/crypto/wallets`

### Test Timeout

**Problem**: Tests take too long

**Solution**:
```bash
# Increase timeout
flutter test test/integration/crypto_wallets_integration_test.dart \
  --timeout=30m
```

### "State is not CryptosLoaded"

**Problem**: Data loading failed

**Solution**:
- Check backend logs for errors
- Verify Quidax API credentials are correct
- Check network connectivity to Quidax

## Continuous Integration

These tests are designed to run against a real backend in CI/CD:

```yaml
# .github/workflows/integration-tests.yml
- name: Start Backend Services
  run: ./start_all_local_no_docker.sh

- name: Wait for Services
  run: |
    npx wait-on http://localhost:7878
    npx wait-on http://localhost:9090

- name: Run Crypto Integration Tests
  run: |
    cd lazervaultapp
    flutter test test/integration/crypto_wallets_integration_test.dart \
      --timeout=15m
```

## Adding More Tests

Follow this pattern for new real backend tests:

```dart
testWidgets('Test description', (WidgetTester tester) async {
  // 1. Load real data
  await cryptoCubit.loadCryptos();
  await tester.pumpAndSettle(const Duration(seconds: 10));

  // 2. Pump real widget
  await tester.pumpWidget(
    MaterialApp(
      home: BlocProvider.value(
        value: cryptoCubit,  // REAL cubit, not mock
        child: YourRealScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();

  // 3. Assert on real data
  expect(find.text('Real Data From Backend'), findsOneWidget);
});
```

## Key Differences from Unit Tests

| Aspect | Unit Tests | These Integration Tests |
|--------|-----------|------------------------|
| **Widgets** | Simplified test widgets | Real production widgets |
| **Cubit** | MockCubit | `serviceLocator<CryptoCubit>()` |
| **Repository** | MockRepository | Real gRPC repository |
| **Data** | Fake fixtures | Real backend data |
| **Network** | No calls | Real gRPC to localhost |
| **Purpose** | Isolate logic | Test full stack |

## Verification

To verify tests are using real backend:

1. **Check logs** - You'll see real gRPC network calls
2. **Check backend** - Backend logs show incoming requests
3. **Change data** - Modify backend data, test results change
4. **Stop backend** - Tests fail with connection errors

If tests pass with backend stopped → **NOT** using real backend ❌
If tests fail with backend stopped → **USING** real backend ✅
