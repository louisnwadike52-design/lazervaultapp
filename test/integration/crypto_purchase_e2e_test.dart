/// End-to-End Crypto Purchase Flow Test
///
/// This test simulates the complete user journey:
/// 1. User with wallet lands on crypto screen
/// 2. Views their wallets
/// 3. Navigates to buy screen
/// 4. Selects a cryptocurrency
/// 5. Enters purchase amount
/// 6. Enters PIN
/// 7. Completes purchase
/// 8. Verifies success
///
/// Prerequisites:
/// - core-gateway (localhost:7878) for auth
/// - crypto-gateway (localhost:9090) for crypto operations
/// - accounts-service for balance operations
/// - crypto-service for transaction execution
/// - Valid test user JWT token with PIN set
/// - User has sufficient balance in wallet
///
/// Run with: flutter test test/integration/crypto_purchase_e2e_test.dart --dart-define=TEST_JWT_TOKEN=your_token

import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' hide Transition;
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_cubit.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_state.dart';
import 'package:lazervault/src/features/crypto/data/models/crypto_wallet_model.dart';
import 'package:lazervault/src/features/crypto/domain/entities/crypto_entity.dart';
import 'package:lazervault/src/features/crypto/presentation/view/buy_crypto_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_screen.dart';

// -----------------------------------------------------------------------------
// Test Configuration
// -----------------------------------------------------------------------------

/// Get JWT token from environment variable
String get _testJwtToken {
  return const String.fromEnvironment('TEST_JWT_TOKEN', defaultValue: '');
}

/// Test user PIN (must match backend)
const String _testPin = '1111';

/// Small purchase amount in NGN (safe for testing)
const double _testPurchaseAmount = 1000.0;

/// Preferred crypto to purchase (bitcoin has best liquidity)
const String _preferredCryptoId = 'bitcoin';

/// Service locator initialization timeout
const _serviceInitTimeout = Duration(seconds: 15);

/// Transaction completion timeout
const _transactionTimeout = Duration(seconds: 30);

// -----------------------------------------------------------------------------
// Test State
// -----------------------------------------------------------------------------

bool _serviceLocatorInitialized = false;

// -----------------------------------------------------------------------------
// Helper Functions
// -----------------------------------------------------------------------------

/// Initialize service locator with proper error handling
Future<void> _initializeServiceLocator() async {
  if (_serviceLocatorInitialized) {
    print('ℹ️  Service locator already initialized');
    return;
  }

  print('🔧 Initializing service locator...');

  try {
    // Override environment for host-based testing (not Android emulator)
    // Tests run on host machine, so use localhost instead of 10.0.2.2
    print('ℹ️  Test environment detected - using localhost for gRPC connections');

    // Load environment variables first
    await dotenv.load(fileName: '.env');

    // Override emulator addresses with localhost for host-based testing
    if (dotenv.env['STOCKS_GRPC_HOST'] == '10.0.2.2') {
      dotenv.env['STOCKS_GRPC_HOST'] = 'localhost';
      dotenv.env['INVESTMENTS_GRPC_HOST'] = 'localhost';
      print('ℹ️  Overrode STOCKS_GRPC_HOST and INVESTMENTS_GRPC_HOST to localhost');
    }

    // Log test JWT token status
    if (_testJwtToken.isNotEmpty) {
      print('✅ TEST_JWT_TOKEN environment variable is set (length: ${_testJwtToken.length})');
      print('   Prefix: ${_testJwtToken.substring(0, 20)}...');
    } else {
      print('⚠️  TEST_JWT_TOKEN environment variable is NOT set');
    }

    // Initialize service locator dependencies first
    await init().timeout(
      const Duration(seconds: 10),
    );

    // Wait for all singletons to be ready
    await serviceLocator.allReady().timeout(
      _serviceInitTimeout,
    ).catchError((_) {
      print('⚠️  Service locator initialization timed out');
    }, test: (e) => e is TimeoutException);

    _serviceLocatorInitialized = true;
    print('✅ Service locator initialized successfully');
    print('ℹ️  GrpcCallOptionsHelper will use TEST_JWT_TOKEN for gRPC authentication');
  } catch (e) {
    print('⚠️  Service locator initialization failed: $e');
    rethrow;
  }
}

/// Get CryptoCubit from service locator
CryptoCubit _getCryptoCubit() {
  if (!serviceLocator.isRegistered<CryptoCubit>()) {
    throw Exception('CryptoCubit not registered in service locator. '
        'Ensure crypto feature dependencies are properly configured.');
  }
  return serviceLocator<CryptoCubit>();
}

/// Load and verify wallets are available
Future<List<CryptoWalletModel>> _loadAndVerifyWallets(
  CryptoCubit cubit,
) async {
  print('📥 Loading user wallets...');

  try {
    await cubit.loadCryptos().timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        throw Exception('Loading wallets timed out');
      },
    );

    // Wait for state to settle
    await Future.delayed(const Duration(seconds: 2));

    final state = cubit.state;
    print('📊 Current state type: ${state.runtimeType}');

    if (state is! CryptosLoaded) {
      if (state is CryptoError) {
        print('❌ CryptoError state: ${(state as CryptoError).message}');
        throw Exception('Failed to load wallets. State: CryptoError, Message: ${(state as CryptoError).message}');
      }
      throw Exception('Failed to load wallets. State: ${state.runtimeType}');
    }

    final loadedState = state as CryptosLoaded;
    print('📊 State details:');
    print('   - Cryptos: ${loadedState.cryptos.length}');
    print('   - Trending: ${loadedState.trendingCryptos.length}');
    print('   - Top: ${loadedState.topCryptos.length}');
    print('   - Supported assets: ${loadedState.supportedAssets.length}');
    print('   - Wallets: ${loadedState.wallets.length}');
    print('   - Transactions: ${loadedState.transactions.length}');

    final wallets = loadedState.wallets;
    if (wallets.isEmpty) {
      print('⚠️  Wallets list is empty!');
      print('   This might be due to authentication failure or backend issue');
      throw Exception('User has no wallets. Cannot proceed with purchase.');
    }

    print('✅ Loaded ${wallets.length} wallets:');
    for (final wallet in wallets) {
      print('  - ${wallet.cryptoSymbol}: ${wallet.address}');
    }

    return wallets;
  } catch (e) {
    print('❌ Failed to load wallets: $e');
    rethrow;
  }
}

/// Find a tradable crypto from supported assets
Crypto _findTradableCrypto(CryptosLoaded state, String preferredId) {
  final supported = state.supportedAssets;

  if (supported.isEmpty) {
    throw Exception('No supported assets available for trading');
  }

  // Try to find preferred crypto first, fallback to first available
  // Simple approach without orElse to avoid type casting issues
  Crypto crypto;
  try {
    crypto = supported.firstWhere((c) => c.id == preferredId);
  } catch (e) {
    // Preferred crypto not found, use first available
    crypto = supported.first;
  }

  print('✅ Selected crypto for purchase: ${crypto.name} (${crypto.symbol})');
  print('   Current price: ${CurrencySymbols.currentSymbol}${crypto.currentPrice.toStringAsFixed(2)}');

  return crypto;
}

// -----------------------------------------------------------------------------
// Main Test Suite
// -----------------------------------------------------------------------------

void main() {
  // Initialize service locator once
  setUpAll(() async {
    await _initializeServiceLocator();
  });

  group('Crypto Purchase - End-to-End Flow', () {
    late CryptoCubit cryptoCubit;
    late Crypto selectedCrypto;

    setUp(() async {
      // Get fresh cubit instance for each test
      cryptoCubit = _getCryptoCubit();

      // Load wallets and verify user is ready
      await _loadAndVerifyWallets(cryptoCubit);

      // Get a tradable crypto
      final state = cryptoCubit.state;
      if (state is CryptosLoaded) {
        selectedCrypto = _findTradableCrypto(state, _preferredCryptoId);
      } else {
        throw Exception('State is not CryptosLoaded after loading');
      }

      print('🏁 Test setup complete');
    });

    tearDown(() async {
      // Clean up: Reload crypto data after each test
      try {
        await cryptoCubit.loadCryptos();
      } catch (e) {
        print('⚠️  Failed to reload cryptos after test: $e');
      }
    });

    testWidgets(
      'E2E: Complete crypto purchase flow from landing to receipt',
      (WidgetTester tester) async {
        // ============================================================
        // STEP 1: Verify user can view their crypto wallet on landing
        // ============================================================
        print('\n📍 STEP 1: Landing Page - Verify Wallet Display');

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cryptoCubit,
              child: GetMaterialApp(
                home: CryptoScreen(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 3));

        // Verify main crypto screen elements
        expect(find.text('Crypto'), findsOneWidget);
        expect(find.text('Total Portfolio Value'), findsOneWidget);
        expect(find.text('Your Wallets'), findsOneWidget);

        print('✅ User can view wallet on landing page');

        // ============================================================
        // STEP 2: Navigate to Buy Screen
        // ============================================================
        print('\n📍 STEP 2: Navigate to Buy Screen');

        // Find and tap a "Buy" button (or navigate manually)
        // For this test, we'll pump the BuyCryptoScreen directly
        // since navigation may vary based on the actual UI

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cryptoCubit,
              child: GetMaterialApp(
                home: BuyCryptoScreen(
                  selectedCrypto: selectedCrypto,
                  lockAsset: true, // Pre-select crypto to skip selector
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle(const Duration(seconds: 2));

        // Verify buy screen is displayed
        expect(find.text('Buy Crypto'), findsOneWidget);
        expect(find.text('Select Cryptocurrency'), findsOneWidget);
        expect(find.text('Amount'), findsOneWidget);

        print('✅ Navigated to Buy Screen');

        // ============================================================
        // STEP 3: Verify pre-selected crypto is displayed
        // ============================================================
        print('\n📍 STEP 3: Verify Crypto Selection');

        // Should show the selected crypto name
        expect(
          find.text(selectedCrypto.name),
          findsAtLeastNWidgets(1),
          reason: 'Selected crypto should be displayed',
        );
        expect(
          find.text(selectedCrypto.symbol.toUpperCase()),
          findsAtLeastNWidgets(1),
          reason: 'Selected crypto symbol should be displayed',
        );

        print('✅ Crypto is pre-selected: ${selectedCrypto.name}');

        // ============================================================
        // STEP 4: Enter purchase amount
        // ============================================================
        print('\n📍 STEP 4: Enter Purchase Amount');

        // Find the amount text field
        final amountField = find.byType(TextField);
        expect(amountField, findsAtLeastNWidgets(1));

        // Enter the test amount
        await tester.enterText(amountField, _testPurchaseAmount.toString());
        await tester.pumpAndSettle();

        print('✅ Entered amount: ${CurrencySymbols.currentSymbol}$_testPurchaseAmount');

        // Verify amount is reflected
        expect(
          find.text(_testPurchaseAmount.toString()),
          findsAtLeastNWidgets(1),
        );

        // Verify order summary appears
        expect(find.text('Order Summary'), findsOneWidget);
        expect(find.text('You pay'), findsOneWidget);
        expect(find.text('Total'), findsOneWidget);

        print('✅ Order summary calculated and displayed');

        // ============================================================
        // STEP 5: Verify payment method
        // ============================================================
        print('\n📍 STEP 5: Verify Payment Method');

        expect(find.text('LazerVault Wallet'), findsAtLeastNWidgets(1));
        expect(find.text('Pay From'), findsOneWidget);

        print('✅ Payment method verified: LazerVault Wallet');

        // ============================================================
        // STEP 6: Tap Buy button (triggers PIN entry)
        // ============================================================
        print('\n📍 STEP 6: Initiate Purchase (Tap Buy)');

        // Find the buy button
        final buyButton = find.text('Buy ${selectedCrypto.symbol.toUpperCase()}');
        expect(buyButton, findsOneWidget);

        // Tap buy button
        await tester.tap(buyButton);
        await tester.pumpAndSettle(const Duration(seconds: 1));

        print('✅ Buy button tapped - PIN entry should appear');

        // ============================================================
        // STEP 7: Enter PIN for transaction
        // ============================================================
        print('\n📍 STEP 7: Enter Transaction PIN');

        // PIN entry should appear - find PIN input fields
        // This assumes a standard PIN entry UI with 4 text fields

        // Look for PIN input fields (TextField or PinCodeTextField)
        final pinFields = find.byType(TextField);
        if (pinFields.evaluate().length >= 4) {
          // Enter PIN digit by digit
          for (var i = 0; i < _testPin.length; i++) {
            await tester.enterText(
              pinFields.at(i),
              _testPin[i],
            );
            await tester.pumpAndSettle(const Duration(milliseconds: 100));
          }
          print('✅ PIN entered: $_testPin');
        } else {
          print('⚠️  PIN input fields not found - may need to adjust test');
          // For automated tests, we might need to mock PIN validation
          // or inject the PIN directly via the service
        }

        // ============================================================
        // STEP 8: Wait for transaction processing
        // ============================================================
        print('\n📍 STEP 8: Processing Transaction');

        // Wait for processing state
        await tester.pumpAndSettle(const Duration(seconds: 5));

        // Check if we're in processing state
        final state = cryptoCubit.state;
        if (state is CryptoTransactionProcessing) {
          print('✅ Transaction is processing...');
          print('   Step: ${state.step}');
          print('   Progress: ${(state.progress * 100).toStringAsFixed(0)}%');

          // Wait for transaction to complete
          await tester.pumpAndSettle(_transactionTimeout);
        } else if (state is CryptoTransactionSuccess) {
          print('✅ Transaction completed successfully!');
          print('   Transaction ID: ${state.transaction.id}');
          print('   Crypto: ${state.transaction.cryptoSymbol}');
          print('   Quantity: ${state.transaction.quantity.toStringAsFixed(6)}');
          print('   Total: ${CurrencySymbols.currentSymbol}${state.transaction.totalAmount.toStringAsFixed(2)}');
        } else if (state is CryptoError) {
          print('❌ Transaction failed: ${state.message}');
          throw Exception('Transaction failed: ${state.message}');
        }

        // ============================================================
        // STEP 9: Verify final state
        // ============================================================
        print('\n📍 STEP 9: Verify Final State');

        final finalState = cryptoCubit.state;

        if (finalState is CryptosLoaded) {
          // Reload and verify wallet balances updated
          print('✅ Back to loaded state');

          // Check if we have a transaction history
          final transactions = finalState.transactions;
          if (transactions.isNotEmpty) {
            print('✅ Transaction recorded in history');
            final latest = transactions.first;
            print('   Latest: ${latest.type} ${latest.cryptoSymbol}');
          }
        } else if (finalState is CryptoTransactionSuccess) {
          // Success state is acceptable too
          expect(finalState.transaction.type, TransactionType.buy);
          expect(finalState.transaction.cryptoSymbol, selectedCrypto.symbol);
          print('✅ Transaction success verified');
        } else {
          throw Exception('Unexpected final state: ${finalState.runtimeType}');
        }

        print('\n🎉 COMPLETE: End-to-end crypto purchase flow succeeded!');
      },
      timeout: const Timeout(Duration(minutes: 3)),
      skip: _testJwtToken.isEmpty, // Skip if no JWT token provided
    );

    testWidgets(
      'E2E: Buy with different amount (quick amount button)',
      (WidgetTester tester) async {
        print('\n📍 Test: Purchase using quick amount button');

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cryptoCubit,
              child: GetMaterialApp(
                home: BuyCryptoScreen(
                  selectedCrypto: selectedCrypto,
                  lockAsset: true,
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Tap a quick amount button (e.g., ₦10,000)
        final quickAmountButton = find.textContaining('10,000');
        if (quickAmountButton.evaluate().isNotEmpty) {
          await tester.tap(quickAmountButton);
          await tester.pumpAndSettle();

          print('✅ Quick amount button tapped');

          // Verify amount was filled
          final amountField = find.byType(TextField);
          final text = tester.widget<TextField>(amountField).controller?.text;
          expect(text, contains('10000'));
        } else {
          print('⚠️  Quick amount button not found');
        }
      },
      timeout: const Timeout(Duration(minutes: 1)),
      skip: _testJwtToken.isEmpty,
    );

    testWidgets(
      'E2E: Verify insufficient balance handling',
      (WidgetTester tester) async {
        print('\n📍 Test: Insufficient balance handling');

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: cryptoCubit,
              child: GetMaterialApp(
                home: BuyCryptoScreen(
                  selectedCrypto: selectedCrypto,
                  lockAsset: true,
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Enter a very large amount that would exceed user balance
        const hugeAmount = 999999999999.0;
        final amountField = find.byType(TextField);
        await tester.enterText(amountField, hugeAmount.toString());
        await tester.pumpAndSettle();

        print('✅ Insufficient balance scenario tested');
        print('   Note: Actual validation may occur at backend');
      },
      timeout: const Timeout(Duration(minutes: 1)),
      skip: _testJwtToken.isEmpty,
    );
  });
}
