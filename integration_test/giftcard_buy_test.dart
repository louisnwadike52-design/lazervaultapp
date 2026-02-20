// Giftcard Buy Integration Test
// Tests the giftcard purchase flow via commerce-gateway

import 'dart:convert';
import 'dart:io';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pb.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/accounts.pb.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart';
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/generated/giftcards.pb.dart';
import 'package:lazervault/src/generated/giftcards.pbgrpc.dart' as giftcard_pb;

const String grpcHost = 'localhost';
const int commerceGatewayPort = 50071;
const int coreGatewayPort = 50070;

// Test user
const String testEmail = 'iyinoluwa@gmail.com';
const String testPassword = r'Password1$'; // raw string
const String testPin = '1234';

void main() async {
  print('============================================================');
  print('  GIFTCARD BUY INTEGRATION TEST');
  print('============================================================');

  // Create channels
  final coreChannel = ClientChannel(
    grpcHost,
    port: coreGatewayPort,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure,
      connectionTimeout: Duration(seconds: 30),
    ),
  );

  final commerceChannel = ClientChannel(
    grpcHost,
    port: commerceGatewayPort,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure,
      connectionTimeout: Duration(seconds: 30),
    ),
  );

  try {
    final authClient = auth_pb.AuthServiceClient(coreChannel);
    final accountsClient = accounts_pb.AccountsServiceClient(coreChannel);
    final pinClient = pin_pb.TransactionPinServiceClient(coreChannel);
    final giftcardClient = giftcard_pb.GiftCardsServiceClient(commerceChannel);

    // Step 1: Login
    print('\n[1] Logging in as $testEmail...');
    final loginResp = await authClient.login(
      LoginRequest(
        email: testEmail,
        password: testPassword,
        deviceId: 'giftcard-test-${DateTime.now().millisecondsSinceEpoch}',
        deviceName: 'Giftcard Integration Test',
      ),
    );

    String accessToken = '';
    String userId = '';

    if (loginResp.hasData()) {
      final session = loginResp.data.session;
      final user = loginResp.data.user;
      accessToken = session.accessToken.isNotEmpty
          ? session.accessToken
          : loginResp.accessToken;
      userId = session.userId.isNotEmpty ? session.userId : user.id;
    } else {
      accessToken = loginResp.accessToken;
      // Extract user ID from JWT
      try {
        final parts = accessToken.split('.');
        if (parts.length == 3) {
          final payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
          final pad = 4 - (payload.length % 4);
          final bytes = base64.decode(payload + '=' * pad);
          final decoded = String.fromCharCodes(bytes);
          final subMatch = RegExp(r'"sub":"([^"]+)"').firstMatch(decoded);
          userId = subMatch?.group(1) ?? '';
        }
      } catch (e) {
        print('    ⚠ Could not extract user ID from token: $e');
      }
    }

    if (accessToken.isEmpty) {
      print('    ✗ Login failed: no access token');
      exit(1);
    }
    print('    ✓ Logged in! UserID: $userId');

    // Step 2: Get accounts
    print('\n[2] Getting user accounts...');
    final accountsResp = await accountsClient.getUserAccounts(
      GetUserAccountsRequest(),
      options: _authCallOptions(accessToken),
    );

    if (accountsResp.accounts.isEmpty) {
      print('    ✗ No accounts found!');
      exit(1);
    }

    final account = accountsResp.accounts.first;
    final accountId = account.uuid.isNotEmpty ? account.uuid : account.id.toString();
    final balance = account.balance.toInt() / 100;
    print('    ✓ Account: $accountId (Balance: $balance NGN)');

    // Step 3: Get giftcard brands
    print('\n[3] Getting giftcard brands from Reloadly...');
    try {
      final brandsResp = await giftcardClient.getGiftCardBrands(
        GetGiftCardBrandsRequest()
          ..countryCode = 'US'
          ..activeOnly = true,
        options: _authCallOptions(accessToken),
      );

      print('    ✓ Found ${brandsResp.brands.length} brands');
      if (brandsResp.brands.isNotEmpty) {
        for (var i = 0; i < brandsResp.brands.length && i < 5; i++) {
          final brand = brandsResp.brands[i];
          print('       - ${brand.name} (Min: \$${brand.minAmount}, Max: \$${brand.maxAmount})');
        }
      }
    } catch (e) {
      print('    ⚠ Failed to get brands: $e');
    }

    // Step 4: Purchase giftcard
    print('\n[4] Testing giftcard purchase...');
    print('    Product ID: 120 (Reloadly sandbox test)');
    print('    Amount: \$10 USD');

    final transactionId = 'GCTest-${DateTime.now().millisecondsSinceEpoch}';

    // Verify PIN first
    print('    Verifying transaction PIN...');
    final pinResp = await pinClient.verifyTransactionPin(
      VerifyTransactionPinRequest(
        userId: userId,
        pin: testPin,
        transactionId: transactionId,
        transactionType: 'giftcard_purchase',
        amount: 1000, // $10 in cents/minor units
        currency: 'USD',
      ),
      options: _authCallOptions(accessToken),
    );

    if (!pinResp.success) {
      print('    ✗ PIN verification failed: ${pinResp.message}');
      print('       (locked=${pinResp.isLocked}, remaining=${pinResp.remainingAttempts})');
      exit(1);
    }
    print('    ✓ PIN verified');

    // Make purchase
    try {
      final buyResp = await giftcardClient.buyGiftCard(
        BuyGiftCardRequest()
          ..accountId = accountId
          ..productId = Int64(120)
          ..amount = 10.00
          ..countryCode = 'US'
          ..recipientEmail = testEmail
          ..senderName = 'Test User'
          ..transactionId = transactionId
          ..verificationToken = pinResp.verificationToken
          ..idempotencyKey = 'TEST-${DateTime.now().millisecondsSinceEpoch}'
          ..quantity = 1,
        options: _authCallOptions(accessToken),
      );

      print('    ✓ Purchase initiated!');
      print('       GiftCard ID: ${buyResp.giftCard.id}');
      print('       Status: ${buyResp.giftCard.status}');

      if (buyResp.giftCard.redemptionCode.isNotEmpty) {
        print('       ✓✓✓ REDEMPTION CODE: ${buyResp.giftCard.redemptionCode}');
      }
      if (buyResp.giftCard.redemptionPin.isNotEmpty) {
        print('       PIN: ${buyResp.giftCard.redemptionPin}');
      }

      print('\n    ✓✓✓ GIFT CARD PURCHASE SUCCESSFUL! ✓✓✓');
    } catch (e) {
      print('    ✗ Purchase failed: $e');
      print('');
      print('    Possible reasons:');
      print('    - Reloadly sandbox API is rate-limited');
      print('    - Product ID 120 not available');
      print('    - Insufficient account balance');
    }

    // Step 5: Get my giftcards
    print('\n[5] Getting my giftcards...');
    try {
      final myCardsResp = await giftcardClient.getGiftCards(
        GetGiftCardsRequest(),
        options: _authCallOptions(accessToken),
      );

      print('    ✓ Found ${myCardsResp.giftCards.length} gift cards');
      for (final card in myCardsResp.giftCards) {
        print('       - ${card.brandName}: \$${card.originalAmount} (${card.status})');
      }
    } catch (e) {
      print('    ⚠ Failed to get giftcards: $e');
    }

    print('\n============================================================');
    print('  TEST COMPLETE');
    print('============================================================');

  } catch (e) {
    print('Test error: $e');
    exit(1);
  } finally {
    await coreChannel.shutdown();
    await commerceChannel.shutdown();
  }
}

CallOptions _authCallOptions(String token) {
  return CallOptions(
    metadata: <String, String>{
      'authorization': 'Bearer $token',
    },
    timeout: const Duration(seconds: 60),
  );
}
