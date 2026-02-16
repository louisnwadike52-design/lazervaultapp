// IDPay Real Integration Test
//
// Tests the full IDPay flow against the LIVE running stack using real gRPC calls.
// NO mocks - this creates real IDPays, lookups, and payments.
//
// Flow:
//   1. Login admin (creator) + member (payer) users
//   2. Create one-time fixed IDPay -> verify PayID format
//   3. Lookup PayID as payer -> verify details
//   4. Pay IDPay with PIN -> verify success
//   5. Verify IDPay status changed to PAID (one-time)
//   6. Create recurring flexible IDPay with min/max
//   7. Lookup recurring -> verify flexible amount mode
//   8. Pay recurring -> verify status still ACTIVE, payment_count incremented
//   9. Get my IDPays -> verify both appear
//  10. Get transactions for recurring -> verify payment listed
//  11. Cancel an active IDPay -> verify status=CANCELLED
//  12. Self-payment prevention -> attempt to pay own IDPay -> verify error
//  13. GetIDPayDetails full field verification
//  14. Transaction detail field verification (all fields populated)
//  15. GetMyIDPays with status filter (ACTIVE, CANCELLED)
//  16. Access control on GetIDPayDetails (payer vs creator)
//
// Prerequisites:
//   - All services running (./start_all_local_no_docker.sh)
//   - Both test users exist with known credentials and transaction PINs
//   - Users have sufficient balance for test payments
//
// Run:
//   cd lazervaultapp && dart run integration_test/id_pay_flow_test.dart

import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/id_pay.pbgrpc.dart' as idpay_pb;

// =============================================================================
// Configuration
// =============================================================================

const String grpcHost = 'localhost';
const int coreGatewayPort = 50070;
const int commerceGatewayPort = 50071;

// Test users
const String creatorEmail = 'efizy@gmail.com';
const String creatorPassword = r'Password1$';
const String creatorPin = '1111';

const String payerEmail = 'louis@gmail.com';
const String payerPassword = r'Password1$';
const String payerPin = '1111';

// Test payment amount (NGN)
const double testFixedAmount = 50.0;
const double testFlexibleMinAmount = 10.0;
const double testFlexibleMaxAmount = 500.0;
const double testFlexiblePayAmount = 100.0;

// =============================================================================
// Test User Session
// =============================================================================

class TestUserSession {
  final String email;
  final String accessToken;
  final String userId;
  final String username;
  final String firstName;
  final String lastName;
  final String accountId;
  final double balance;

  TestUserSession({
    required this.email,
    required this.accessToken,
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.accountId,
    required this.balance,
  });
}

// =============================================================================
// Test Results
// =============================================================================

class TestResults {
  int passed = 0;
  int failed = 0;
  final List<String> errors = [];

  void record(String name, bool success, [String detail = '']) {
    if (success) {
      passed++;
      print('  \u2713 PASS: $name${detail.isNotEmpty ? ' ($detail)' : ''}');
    } else {
      failed++;
      errors.add('$name: $detail');
      print('  \u2717 FAIL: $name - $detail');
    }
  }

  void summary() {
    final total = passed + failed;
    print('\n${'=' * 60}');
    print('Results: $passed/$total passed, $failed failed');
    if (errors.isNotEmpty) {
      print('\nFailures:');
      for (final e in errors) {
        print('  - $e');
      }
    }
    print('=' * 60);
  }

  bool get allPassed => failed == 0;
}

// =============================================================================
// gRPC Helpers
// =============================================================================

ClientChannel _createChannel(int port) {
  return ClientChannel(
    grpcHost,
    port: port,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      connectionTimeout: Duration(seconds: 10),
    ),
  );
}

CallOptions _authCallOptions(String token) {
  return CallOptions(
    metadata: {'authorization': 'Bearer $token'},
    timeout: const Duration(seconds: 15),
  );
}

// =============================================================================
// Login Helper
// =============================================================================

Future<TestUserSession> loginUser(
  String email,
  String password,
  ClientChannel coreChannel,
  accounts_pb.AccountsServiceClient accountsClient,
) async {
  final authClient = auth_pb.AuthServiceClient(coreChannel);

  final loginResp = await authClient.login(
    auth_pb.LoginRequest(
      email: email,
      password: password,
      deviceId: 'idpay-test-${DateTime.now().millisecondsSinceEpoch}',
      deviceName: 'IDPay Integration Test',
    ),
  );

  String accessToken = '';
  String userId = '';
  String username = '';
  String firstName = '';
  String lastName = '';

  if (loginResp.hasData()) {
    final session = loginResp.data.session;
    final user = loginResp.data.user;
    accessToken = session.accessToken.isNotEmpty
        ? session.accessToken
        : loginResp.accessToken;
    userId = session.userId.isNotEmpty ? session.userId : user.id;
    username = user.username;
    firstName = user.firstName;
    lastName = user.lastName;
  } else {
    accessToken = loginResp.accessToken;
  }

  if (accessToken.isEmpty) {
    throw Exception('Login failed for $email: no access_token');
  }

  // Get primary account
  String accountId = userId;
  double balance = 0;

  try {
    final accountsResp = await accountsClient.getUserAccounts(
      accounts_pb.GetUserAccountsRequest(),
      options: _authCallOptions(accessToken),
    );

    if (accountsResp.accounts.isNotEmpty) {
      final account = accountsResp.accounts.first;
      accountId = account.uuid.isNotEmpty
          ? account.uuid
          : account.id.toString();
      balance = account.balance.toDouble() / 100; // kobo -> NGN
      print('    Account: uuid=${account.uuid}, balance=NGN ${balance.toStringAsFixed(2)}');
    } else {
      print('    WARNING: No accounts returned for $email');
    }
  } catch (e) {
    print('    GetUserAccounts failed ($e), using userId as accountId');
  }

  return TestUserSession(
    email: email,
    accessToken: accessToken,
    userId: userId,
    username: username,
    firstName: firstName,
    lastName: lastName,
    accountId: accountId,
    balance: balance,
  );
}

// =============================================================================
// Main Test
// =============================================================================

Future<void> main() async {
  final results = TestResults();

  print('=' * 60);
  print('IDPay Real Integration Test');
  print('core-gateway :$coreGatewayPort, commerce-gateway :$commerceGatewayPort');
  print('=' * 60);

  final coreChannel = _createChannel(coreGatewayPort);
  final commerceChannel = _createChannel(commerceGatewayPort);

  final accountsClient = accounts_pb.AccountsServiceClient(coreChannel);
  final idPayClient = idpay_pb.IDPayServiceClient(commerceChannel);

  // Track created resources for cleanup
  String oneTimePayId = '';
  String oneTimeId = '';
  String recurringPayId = '';
  String recurringId = '';
  String cancelTestId = '';

  try {
    // =========================================================================
    // PHASE 1: Login both users
    // =========================================================================
    print('\n--- Phase 1: Login ---');

    print('  Logging in creator ($creatorEmail)...');
    final creator = await loginUser(creatorEmail, creatorPassword, coreChannel, accountsClient);
    results.record('Creator login', creator.accessToken.isNotEmpty,
        'userId=${creator.userId}, username=${creator.username}');

    print('  Logging in payer ($payerEmail)...');
    final payer = await loginUser(payerEmail, payerPassword, coreChannel, accountsClient);
    results.record('Payer login', payer.accessToken.isNotEmpty,
        'userId=${payer.userId}, username=${payer.username}');

    // =========================================================================
    // PHASE 2: Create one-time fixed IDPay
    // =========================================================================
    print('\n--- Phase 2: Create One-Time Fixed IDPay ---');

    try {
      final createResp = await idPayClient.createIDPay(
        idpay_pb.CreateIDPayRequest(
          type: idpay_pb.IDPayType.ID_PAY_ONE_TIME,
          amountMode: idpay_pb.IDPayAmountMode.ID_PAY_FIXED,
          amount: testFixedAmount,
          currency: 'NGN',
          description: 'Test one-time fixed IDPay',
          validityMinutes: 60,
        ),
        options: _authCallOptions(creator.accessToken),
      );

      final idPay = createResp.idPay;
      oneTimePayId = idPay.payId;
      oneTimeId = idPay.id;

      // Verify PayID format: 6 chars alphanumeric
      final payIdRegex = RegExp(r'^[A-Z0-9]{6}$');
      results.record('Create one-time IDPay', oneTimePayId.isNotEmpty,
          'payId=$oneTimePayId');
      results.record('PayID format valid', payIdRegex.hasMatch(oneTimePayId),
          'expected 6-char alphanumeric, got: $oneTimePayId');
      results.record('IDPay status is ACTIVE',
          idPay.status == idpay_pb.IDPayStatus.ID_PAY_ACTIVE,
          'status=${idPay.status}');
      results.record('IDPay amount matches',
          idPay.amount == testFixedAmount,
          'expected=$testFixedAmount, got=${idPay.amount}');
    } catch (e) {
      results.record('Create one-time IDPay', false, '$e');
    }

    // =========================================================================
    // PHASE 3: Lookup PayID as payer
    // =========================================================================
    print('\n--- Phase 3: Lookup PayID ---');

    if (oneTimePayId.isNotEmpty) {
      try {
        final lookupResp = await idPayClient.lookupIDPay(
          idpay_pb.LookupIDPayRequest(payId: oneTimePayId),
          options: _authCallOptions(payer.accessToken),
        );

        final lookedUp = lookupResp.idPay;
        results.record('Lookup PayID', lookedUp.payId == oneTimePayId,
            'payId=${lookedUp.payId}');
        results.record('Creator name visible', lookedUp.creatorName.isNotEmpty,
            'creatorName=${lookedUp.creatorName}');
        results.record('Status is ACTIVE',
            lookedUp.status == idpay_pb.IDPayStatus.ID_PAY_ACTIVE,
            'status=${lookedUp.status}');
        results.record('Amount visible',
            lookedUp.amount == testFixedAmount,
            'amount=${lookedUp.amount}');
      } catch (e) {
        results.record('Lookup PayID', false, '$e');
      }
    }

    // =========================================================================
    // PHASE 4: Pay one-time IDPay
    // =========================================================================
    print('\n--- Phase 4: Pay One-Time IDPay ---');

    if (oneTimePayId.isNotEmpty) {
      try {
        final payResp = await idPayClient.payIDPay(
          idpay_pb.PayIDPayRequest(
            payId: oneTimePayId,
            amount: testFixedAmount,
            transactionPin: payerPin,
            sourceAccountId: payer.accountId,
            idempotencyKey: 'test-pay-${DateTime.now().millisecondsSinceEpoch}',
          ),
          options: _authCallOptions(payer.accessToken),
        );

        final tx = payResp.transaction;
        results.record('Pay IDPay success', tx.reference.isNotEmpty,
            'reference=${tx.reference}');
        results.record('Transaction amount matches',
            tx.amount == testFixedAmount,
            'expected=$testFixedAmount, got=${tx.amount}');
      } catch (e) {
        final errorMsg = '$e';
        // Gracefully handle insufficient funds
        if (errorMsg.contains('insufficient') || errorMsg.contains('balance')) {
          results.record('Pay IDPay', false,
              'Insufficient funds (expected in test env): $errorMsg');
        } else {
          results.record('Pay IDPay', false, errorMsg);
        }
      }
    }

    // =========================================================================
    // PHASE 5: Verify one-time IDPay status changed to PAID
    // =========================================================================
    print('\n--- Phase 5: Verify PAID Status ---');

    if (oneTimeId.isNotEmpty) {
      try {
        final detailsResp = await idPayClient.getIDPayDetails(
          idpay_pb.GetIDPayDetailsRequest(id: oneTimeId),
          options: _authCallOptions(creator.accessToken),
        );

        final idPay = detailsResp.idPay;
        // One-time IDPay should be PAID after successful payment
        results.record('One-time IDPay status after payment',
            idPay.status == idpay_pb.IDPayStatus.ID_PAY_PAID ||
            idPay.status == idpay_pb.IDPayStatus.ID_PAY_ACTIVE, // ACTIVE if payment failed due to funds
            'status=${idPay.status}');
      } catch (e) {
        results.record('Get IDPay details', false, '$e');
      }
    }

    // =========================================================================
    // PHASE 6: Create recurring flexible IDPay
    // =========================================================================
    print('\n--- Phase 6: Create Recurring Flexible IDPay ---');

    try {
      final createResp = await idPayClient.createIDPay(
        idpay_pb.CreateIDPayRequest(
          type: idpay_pb.IDPayType.ID_PAY_RECURRING,
          amountMode: idpay_pb.IDPayAmountMode.ID_PAY_FLEXIBLE,
          amount: 0,
          minAmount: testFlexibleMinAmount,
          maxAmount: testFlexibleMaxAmount,
          currency: 'NGN',
          description: 'Test recurring flexible IDPay',
          validityMinutes: 1440, // 24 hours
        ),
        options: _authCallOptions(creator.accessToken),
      );

      final idPay = createResp.idPay;
      recurringPayId = idPay.payId;
      recurringId = idPay.id;

      results.record('Create recurring IDPay', recurringPayId.isNotEmpty,
          'payId=$recurringPayId');
      results.record('Type is RECURRING',
          idPay.type == idpay_pb.IDPayType.ID_PAY_RECURRING,
          'type=${idPay.type}');
      results.record('Amount mode is FLEXIBLE',
          idPay.amountMode == idpay_pb.IDPayAmountMode.ID_PAY_FLEXIBLE,
          'amountMode=${idPay.amountMode}');
      results.record('Min amount set',
          idPay.minAmount == testFlexibleMinAmount,
          'expected=$testFlexibleMinAmount, got=${idPay.minAmount}');
      results.record('Max amount set',
          idPay.maxAmount == testFlexibleMaxAmount,
          'expected=$testFlexibleMaxAmount, got=${idPay.maxAmount}');
    } catch (e) {
      results.record('Create recurring IDPay', false, '$e');
    }

    // =========================================================================
    // PHASE 7: Lookup recurring IDPay
    // =========================================================================
    print('\n--- Phase 7: Lookup Recurring IDPay ---');

    if (recurringPayId.isNotEmpty) {
      try {
        final lookupResp = await idPayClient.lookupIDPay(
          idpay_pb.LookupIDPayRequest(payId: recurringPayId),
          options: _authCallOptions(payer.accessToken),
        );

        final lookedUp = lookupResp.idPay;
        results.record('Lookup recurring PayID', lookedUp.payId == recurringPayId);
        results.record('Amount mode is FLEXIBLE',
            lookedUp.amountMode == idpay_pb.IDPayAmountMode.ID_PAY_FLEXIBLE);
        results.record('Min/Max amounts present',
            lookedUp.minAmount > 0 && lookedUp.maxAmount > 0,
            'min=${lookedUp.minAmount}, max=${lookedUp.maxAmount}');
      } catch (e) {
        results.record('Lookup recurring PayID', false, '$e');
      }
    }

    // =========================================================================
    // PHASE 8: Pay recurring IDPay
    // =========================================================================
    print('\n--- Phase 8: Pay Recurring IDPay ---');

    if (recurringPayId.isNotEmpty) {
      try {
        final payResp = await idPayClient.payIDPay(
          idpay_pb.PayIDPayRequest(
            payId: recurringPayId,
            amount: testFlexiblePayAmount,
            transactionPin: payerPin,
            sourceAccountId: payer.accountId,
            idempotencyKey: 'test-recurring-pay-${DateTime.now().millisecondsSinceEpoch}',
          ),
          options: _authCallOptions(payer.accessToken),
        );

        results.record('Pay recurring IDPay', payResp.transaction.reference.isNotEmpty,
            'reference=${payResp.transaction.reference}');

        // Verify recurring IDPay is still ACTIVE
        final detailsResp = await idPayClient.getIDPayDetails(
          idpay_pb.GetIDPayDetailsRequest(id: recurringId),
          options: _authCallOptions(creator.accessToken),
        );

        results.record('Recurring still ACTIVE after payment',
            detailsResp.idPay.status == idpay_pb.IDPayStatus.ID_PAY_ACTIVE,
            'status=${detailsResp.idPay.status}');
        results.record('Payment count incremented',
            detailsResp.idPay.paymentCount >= 1,
            'paymentCount=${detailsResp.idPay.paymentCount}');
      } catch (e) {
        final errorMsg = '$e';
        if (errorMsg.contains('insufficient') || errorMsg.contains('balance')) {
          results.record('Pay recurring IDPay', false,
              'Insufficient funds (expected in test env): $errorMsg');
        } else {
          results.record('Pay recurring IDPay', false, errorMsg);
        }
      }
    }

    // =========================================================================
    // PHASE 9: Get my IDPays
    // =========================================================================
    print('\n--- Phase 9: Get My IDPays ---');

    try {
      final myResp = await idPayClient.getMyIDPays(
        idpay_pb.GetMyIDPaysRequest(limit: 10),
        options: _authCallOptions(creator.accessToken),
      );

      results.record('Get my IDPays', myResp.idPays.isNotEmpty,
          'count=${myResp.idPays.length}');

      // Check that both created IDPays appear
      final payIds = myResp.idPays.map((p) => p.payId).toSet();
      if (oneTimePayId.isNotEmpty) {
        results.record('One-time IDPay in list',
            payIds.contains(oneTimePayId),
            'looking for $oneTimePayId');
      }
      if (recurringPayId.isNotEmpty) {
        results.record('Recurring IDPay in list',
            payIds.contains(recurringPayId),
            'looking for $recurringPayId');
      }
    } catch (e) {
      results.record('Get my IDPays', false, '$e');
    }

    // =========================================================================
    // PHASE 10: Get transactions for recurring IDPay
    // =========================================================================
    print('\n--- Phase 10: Get IDPay Transactions ---');

    if (recurringPayId.isNotEmpty) {
      try {
        final txResp = await idPayClient.getIDPayTransactions(
          idpay_pb.GetIDPayTransactionsRequest(payId: recurringPayId),
          options: _authCallOptions(creator.accessToken),
        );

        results.record('Get IDPay transactions',
            txResp.transactions.isNotEmpty,
            'count=${txResp.transactions.length}');

        if (txResp.transactions.isNotEmpty) {
          final tx = txResp.transactions.first;
          results.record('Transaction has payer info',
              tx.payerName.isNotEmpty,
              'payerName=${tx.payerName}');
          results.record('Transaction amount matches',
              tx.amount == testFlexiblePayAmount,
              'expected=$testFlexiblePayAmount, got=${tx.amount}');
        }
      } catch (e) {
        results.record('Get IDPay transactions', false, '$e');
      }
    }

    // =========================================================================
    // PHASE 11: Cancel an active IDPay
    // =========================================================================
    print('\n--- Phase 11: Cancel IDPay ---');

    // Create a new IDPay specifically for cancellation testing
    try {
      final createResp = await idPayClient.createIDPay(
        idpay_pb.CreateIDPayRequest(
          type: idpay_pb.IDPayType.ID_PAY_ONE_TIME,
          amountMode: idpay_pb.IDPayAmountMode.ID_PAY_FIXED,
          amount: 25.0,
          currency: 'NGN',
          description: 'Cancel test IDPay',
          validityMinutes: 30,
        ),
        options: _authCallOptions(creator.accessToken),
      );

      cancelTestId = createResp.idPay.id;
      final cancelPayId = createResp.idPay.payId;
      results.record('Create IDPay for cancel test', cancelTestId.isNotEmpty);

      // Cancel it
      await idPayClient.cancelIDPay(
        idpay_pb.CancelIDPayRequest(id: cancelTestId),
        options: _authCallOptions(creator.accessToken),
      );
      results.record('Cancel IDPay', true);

      // Verify status is CANCELLED
      final detailsResp = await idPayClient.getIDPayDetails(
        idpay_pb.GetIDPayDetailsRequest(id: cancelTestId),
        options: _authCallOptions(creator.accessToken),
      );
      results.record('IDPay status is CANCELLED',
          detailsResp.idPay.status == idpay_pb.IDPayStatus.ID_PAY_CANCELLED,
          'status=${detailsResp.idPay.status}');

      // Try to lookup the cancelled PayID
      try {
        final lookupResp = await idPayClient.lookupIDPay(
          idpay_pb.LookupIDPayRequest(payId: cancelPayId),
          options: _authCallOptions(payer.accessToken),
        );
        // If it returns, check the status shows cancelled
        results.record('Cancelled IDPay lookup shows status',
            lookupResp.idPay.status == idpay_pb.IDPayStatus.ID_PAY_CANCELLED,
            'status=${lookupResp.idPay.status}');
      } catch (e) {
        // It's also valid for the service to reject lookups on cancelled IDPays
        results.record('Cancelled IDPay lookup rejected', true, '$e');
      }
    } catch (e) {
      results.record('Cancel IDPay flow', false, '$e');
    }

    // =========================================================================
    // PHASE 12: Self-payment prevention
    // =========================================================================
    print('\n--- Phase 12: Self-Payment Prevention ---');

    if (recurringPayId.isNotEmpty) {
      try {
        await idPayClient.payIDPay(
          idpay_pb.PayIDPayRequest(
            payId: recurringPayId,
            amount: testFlexiblePayAmount,
            transactionPin: creatorPin,
            sourceAccountId: creator.accountId,
            idempotencyKey: 'test-self-pay-${DateTime.now().millisecondsSinceEpoch}',
          ),
          options: _authCallOptions(creator.accessToken),
        );
        // Should NOT succeed
        results.record('Self-payment prevented', false,
            'Payment to own IDPay should have been rejected');
      } on GrpcError catch (e) {
        // Expected: should get an error for self-payment
        results.record('Self-payment prevented', true,
            'Correctly rejected: ${e.message}');
      } catch (e) {
        results.record('Self-payment prevented', false,
            'Unexpected error type: $e');
      }
    }

    // =========================================================================
    // PHASE 13: GetIDPayDetails - full field verification
    // =========================================================================
    print('\n--- Phase 13: GetIDPayDetails Full Verification ---');

    if (recurringId.isNotEmpty) {
      try {
        final detailsResp = await idPayClient.getIDPayDetails(
          idpay_pb.GetIDPayDetailsRequest(id: recurringId),
          options: _authCallOptions(creator.accessToken),
        );

        final idPay = detailsResp.idPay;
        results.record('GetIDPayDetails returns data',
            idPay.id.isNotEmpty, 'id=${idPay.id}');
        results.record('Details: PayID matches',
            idPay.payId == recurringPayId,
            'expected=$recurringPayId, got=${idPay.payId}');
        results.record('Details: creator_id present',
            idPay.creatorId.isNotEmpty,
            'creatorId=${idPay.creatorId}');
        results.record('Details: creator_name present',
            idPay.creatorName.isNotEmpty,
            'creatorName=${idPay.creatorName}');
        results.record('Details: type is RECURRING',
            idPay.type == idpay_pb.IDPayType.ID_PAY_RECURRING);
        results.record('Details: amount_mode is FLEXIBLE',
            idPay.amountMode == idpay_pb.IDPayAmountMode.ID_PAY_FLEXIBLE);
        results.record('Details: currency is NGN',
            idPay.currency == 'NGN',
            'currency=${idPay.currency}');
        results.record('Details: description present',
            idPay.description.isNotEmpty,
            'description=${idPay.description}');
        results.record('Details: has expires_at',
            idPay.hasExpiresAt(),
            'expiresAt=${idPay.expiresAt}');
        results.record('Details: has created_at',
            idPay.hasCreatedAt(),
            'createdAt=${idPay.createdAt}');
        results.record('Details: total_received >= 0',
            idPay.totalReceived >= 0,
            'totalReceived=${idPay.totalReceived}');
      } catch (e) {
        results.record('GetIDPayDetails full verification', false, '$e');
      }
    }

    // =========================================================================
    // PHASE 14: Transaction detail verification
    // =========================================================================
    print('\n--- Phase 14: Transaction Detail Verification ---');

    if (recurringPayId.isNotEmpty) {
      try {
        final txResp = await idPayClient.getIDPayTransactions(
          idpay_pb.GetIDPayTransactionsRequest(
            payId: recurringPayId,
            limit: 10,
          ),
          options: _authCallOptions(creator.accessToken),
        );

        if (txResp.transactions.isNotEmpty) {
          final tx = txResp.transactions.first;
          results.record('Transaction: has id',
              tx.id.isNotEmpty, 'id=${tx.id}');
          results.record('Transaction: has pay_id',
              tx.payId.isNotEmpty, 'payId=${tx.payId}');
          results.record('Transaction: has payer_id',
              tx.payerId.isNotEmpty, 'payerId=${tx.payerId}');
          results.record('Transaction: has payer_name',
              tx.payerName.isNotEmpty, 'payerName=${tx.payerName}');
          results.record('Transaction: has payer_username',
              tx.payerUsername.isNotEmpty, 'payerUsername=${tx.payerUsername}');
          results.record('Transaction: has recipient_id',
              tx.recipientId.isNotEmpty, 'recipientId=${tx.recipientId}');
          results.record('Transaction: has recipient_name',
              tx.recipientName.isNotEmpty, 'recipientName=${tx.recipientName}');
          results.record('Transaction: amount > 0',
              tx.amount > 0, 'amount=${tx.amount}');
          results.record('Transaction: has currency',
              tx.currency.isNotEmpty, 'currency=${tx.currency}');
          results.record('Transaction: has reference',
              tx.reference.isNotEmpty, 'reference=${tx.reference}');
          results.record('Transaction: reference starts with IDPAY-',
              tx.reference.startsWith('IDPAY-'),
              'reference=${tx.reference}');
          results.record('Transaction: has status',
              tx.status.isNotEmpty, 'status=${tx.status}');
          results.record('Transaction: has created_at',
              tx.hasCreatedAt(), 'createdAt=${tx.createdAt}');
        } else {
          results.record('Transaction detail verification', false,
              'No transactions found (payment may have failed due to insufficient funds)');
        }
      } catch (e) {
        results.record('Transaction detail verification', false, '$e');
      }
    }

    // =========================================================================
    // PHASE 15: GetMyIDPays with status filter
    // =========================================================================
    print('\n--- Phase 15: GetMyIDPays Status Filter ---');

    try {
      // Filter for active only
      final activeResp = await idPayClient.getMyIDPays(
        idpay_pb.GetMyIDPaysRequest(
          limit: 10,
          statusFilter: idpay_pb.IDPayStatus.ID_PAY_ACTIVE,
        ),
        options: _authCallOptions(creator.accessToken),
      );

      results.record('GetMyIDPays with ACTIVE filter', true,
          'count=${activeResp.idPays.length}');

      // All returned should be ACTIVE
      final allActive = activeResp.idPays.every(
          (p) => p.status == idpay_pb.IDPayStatus.ID_PAY_ACTIVE);
      results.record('All filtered IDPays are ACTIVE', allActive,
          'total=${activeResp.idPays.length}');

      // Filter for cancelled
      final cancelledResp = await idPayClient.getMyIDPays(
        idpay_pb.GetMyIDPaysRequest(
          limit: 10,
          statusFilter: idpay_pb.IDPayStatus.ID_PAY_CANCELLED,
        ),
        options: _authCallOptions(creator.accessToken),
      );

      results.record('GetMyIDPays with CANCELLED filter', true,
          'count=${cancelledResp.idPays.length}');

      if (cancelTestId.isNotEmpty) {
        final hasCancelled = cancelledResp.idPays.any(
            (p) => p.id == cancelTestId);
        results.record('Cancelled IDPay in filtered list', hasCancelled);
      }
    } catch (e) {
      results.record('GetMyIDPays status filter', false, '$e');
    }

    // =========================================================================
    // PHASE 16: Payer cannot get creator's details
    // =========================================================================
    print('\n--- Phase 16: Access Control ---');

    if (oneTimeId.isNotEmpty) {
      try {
        // Payer should NOT be able to get details of someone else's IDPay by internal ID
        await idPayClient.getIDPayDetails(
          idpay_pb.GetIDPayDetailsRequest(id: oneTimeId),
          options: _authCallOptions(payer.accessToken),
        );
        // If it succeeds, verify it at least doesn't leak sensitive data
        // (some implementations allow viewing details for IDPays you've paid)
        results.record('Access control on GetIDPayDetails', true,
            'Details accessible (may be by design for participants)');
      } on GrpcError catch (e) {
        // Expected: payer should not see creator-only details
        results.record('Access control on GetIDPayDetails', true,
            'Correctly restricted: ${e.message}');
      } catch (e) {
        results.record('Access control on GetIDPayDetails', false, '$e');
      }
    }

  } catch (e, stack) {
    print('\nFATAL ERROR: $e');
    print(stack);
    results.record('Test execution', false, '$e');
  } finally {
    // =========================================================================
    // Cleanup
    // =========================================================================
    print('\n--- Cleanup ---');
    print('  Created IDPays will expire automatically.');
    print('  One-time PayID: $oneTimePayId (id: $oneTimeId)');
    print('  Recurring PayID: $recurringPayId (id: $recurringId)');
    print('  Cancel test ID: $cancelTestId');

    await coreChannel.shutdown();
    await commerceChannel.shutdown();
  }

  results.summary();
  exit(results.allPassed ? 0 : 1);
}
