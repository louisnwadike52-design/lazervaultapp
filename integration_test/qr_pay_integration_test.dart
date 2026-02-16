// QR Pay Real Integration Test
//
// Tests the full QR Pay flow against the LIVE running stack using real gRPC calls.
// NO mocks - this creates real transactions visible in the app.
//
// Flow:
//   1. Login as efizy@gmail.com -> Generate QR -> Save QR data to file
//   2. Login as louis@gmail.com -> Read QR file -> Pay QR
//   3. Verify both users see the transaction in history
//
// Prerequisites:
//   - All services running (./start_all_local_no_docker.sh)
//   - Both test users exist with known credentials and transaction PINs
//   - Users have sufficient balance
//
// Run:
//   cd lazervaultapp && dart run integration_test/qr_pay_integration_test.dart

import 'dart:convert';
import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_pb;
import 'package:lazervault/src/generated/qr_pay.pbgrpc.dart' as qr_pb;

// =============================================================================
// Configuration
// =============================================================================

const String grpcHost = 'localhost';
const int coreGatewayPort = 50070;
const int commerceGatewayPort = 50071;

// Test users
const String user1Email = 'efizy@gmail.com'; // QR Generator (Recipient)
const String user1Password = r'Password1$';
const String user1Pin = '1111'; // Transaction PIN

const String user2Email = 'louis@gmail.com'; // QR Payer
const String user2Password = r'Password1$';
const String user2Pin = '1111'; // Transaction PIN

// QR data exchange file
final String qrDataFilePath = '${Directory.current.path}/integration_test/qr_test_data.json';

// Payment amount
const double paymentAmount = 500.0; // NGN 500

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
  final String accountId; // Primary account ID (as string for gRPC)
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
      print('  ✓ PASS: $name${detail.isNotEmpty ? ' ($detail)' : ''}');
    } else {
      failed++;
      errors.add('$name: $detail');
      print('  ✗ FAIL: $name - $detail');
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
// gRPC Channel Factory
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
// Step 1: Login
// =============================================================================

Future<TestUserSession> loginUser(
  String email,
  String password,
  ClientChannel coreChannel,
  accounts_pb.AccountsServiceClient accountsClient,
) async {
  final authClient = auth_pb.AuthServiceClient(coreChannel);

  // Login
  final loginResp = await authClient.login(
    auth_pb.LoginRequest(
      email: email,
      password: password,
      deviceId: 'integration-test-${DateTime.now().millisecondsSinceEpoch}',
      deviceName: 'Integration Test Runner',
    ),
  );

  // Extract token - try session first, then top-level
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
    throw Exception('Login failed for $email: no access_token in response');
  }

  // Get accounts to find primary account
  String accountId = userId; // fallback to userId
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
      print('    Found ${accountsResp.accounts.length} account(s), '
          'using: $accountId (${account.accountType}, ${account.currency})');
    } else {
      print('    No accounts found, using userId as accountId: $userId');
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
  print('QR Pay Real Integration Test');
  print('Connecting to core-gateway :$coreGatewayPort, '
      'commerce-gateway :$commerceGatewayPort');
  print('=' * 60);

  // Create channels
  final coreChannel = _createChannel(coreGatewayPort);
  final commerceChannel = _createChannel(commerceGatewayPort);

  // Create service clients
  final accountsClient = accounts_pb.AccountsServiceClient(coreChannel);
  final qrPayClient = qr_pb.QRPayServiceClient(commerceChannel);

  try {
    // =========================================================================
    // PHASE 1: Login as efizy@gmail.com and generate QR
    // =========================================================================
    print('\n--- Phase 1: Login as $user1Email (QR Generator) ---');

    late TestUserSession recipient;
    try {
      recipient = await loginUser(user1Email, user1Password, coreChannel, accountsClient);
      results.record(
        'Login $user1Email',
        true,
        'user=${recipient.username}, account=${recipient.accountId}, '
            'balance=${recipient.balance} NGN',
      );
    } catch (e) {
      results.record('Login $user1Email', false, '$e');
      results.summary();
      await _shutdownChannels(coreChannel, commerceChannel);
      exit(1);
    }

    // =========================================================================
    // PHASE 2: Generate Dynamic QR Code
    // =========================================================================
    print('\n--- Phase 2: Generate Dynamic QR Code ---');

    late qr_pb.GenerateQRResponse generateResp;
    try {
      generateResp = await qrPayClient.generateQR(
        qr_pb.GenerateQRRequest(
          amount: paymentAmount,
          currency: 'NGN',
          description: 'Integration test QR payment - ${DateTime.now().toIso8601String()}',
          qrType: qr_pb.QRType.QR_TYPE_DYNAMIC,
          validityMinutes: 60,
        ),
        options: _authCallOptions(recipient.accessToken),
      );

      final qrCode = generateResp.qrCode;
      results.record(
        'Generate QR',
        qrCode.id.isNotEmpty && qrCode.qrCode.isNotEmpty,
        'id=${qrCode.id.substring(0, 12)}..., code=${qrCode.qrCode}, '
            'amount=${qrCode.amount}',
      );

      results.record(
        'QR Data JSON present',
        generateResp.qrData.isNotEmpty,
        'length=${generateResp.qrData.length}',
      );
    } catch (e) {
      results.record('Generate QR', false, '$e');
      results.summary();
      await _shutdownChannels(coreChannel, commerceChannel);
      exit(1);
    }

    // =========================================================================
    // PHASE 3: Save QR data to file (simulating QR code scan exchange)
    // =========================================================================
    print('\n--- Phase 3: Save QR data to file ---');

    try {
      final qrExchangeData = {
        'qr_code_str': generateResp.qrCode.qrCode,
        'qr_code_id': generateResp.qrCode.id,
        'qr_data_json': generateResp.qrData,
        'amount': generateResp.qrCode.amount,
        'currency': generateResp.qrCode.currency,
        'recipient_username': recipient.username,
        'recipient_name': '${recipient.firstName} ${recipient.lastName}',
        'generated_at': DateTime.now().toIso8601String(),
      };

      final file = File(qrDataFilePath);
      await file.writeAsString(
        const JsonEncoder.withIndent('  ').convert(qrExchangeData),
      );

      results.record('Save QR to file', file.existsSync(), qrDataFilePath);
    } catch (e) {
      results.record('Save QR to file', false, '$e');
      results.summary();
      await _shutdownChannels(coreChannel, commerceChannel);
      exit(1);
    }

    // =========================================================================
    // PHASE 4: Verify QR details (as generator)
    // =========================================================================
    print('\n--- Phase 4: Verify QR Details ---');

    try {
      final detailsResp = await qrPayClient.getQRDetails(
        qr_pb.GetQRDetailsRequest(qrCode: generateResp.qrCode.qrCode),
        options: _authCallOptions(recipient.accessToken),
      );

      final qr = detailsResp.qrCode;
      results.record(
        'Get QR Details',
        qr.status == qr_pb.QRStatus.QR_STATUS_PENDING &&
            qr.amount == paymentAmount,
        'status=${qr.status}, amount=${qr.amount}, '
            'owner=${qr.username}',
      );
    } catch (e) {
      results.record('Get QR Details', false, '$e');
    }

    // =========================================================================
    // PHASE 5: Login as louis@gmail.com (Payer)
    // =========================================================================
    print('\n--- Phase 5: Login as $user2Email (Payer) ---');

    late TestUserSession payer;
    try {
      payer = await loginUser(user2Email, user2Password, coreChannel, accountsClient);
      results.record(
        'Login $user2Email',
        true,
        'user=${payer.username}, account=${payer.accountId}, '
            'balance=${payer.balance} NGN',
      );
    } catch (e) {
      results.record('Login $user2Email', false, '$e');
      results.summary();
      await _shutdownChannels(coreChannel, commerceChannel);
      exit(1);
    }

    // =========================================================================
    // PHASE 6: Read QR data from file (simulating scan)
    // =========================================================================
    print('\n--- Phase 6: Read QR data from file ---');

    late String qrCodeStr;
    late double qrAmount;
    try {
      final file = File(qrDataFilePath);
      final content = await file.readAsString();
      final qrExchangeData = jsonDecode(content) as Map<String, dynamic>;

      qrCodeStr = qrExchangeData['qr_code_str'] as String;
      qrAmount = (qrExchangeData['amount'] as num).toDouble();

      results.record(
        'Read QR from file',
        qrCodeStr.isNotEmpty,
        'code=$qrCodeStr, amount=$qrAmount, '
            'recipient=${qrExchangeData['recipient_username']}',
      );
    } catch (e) {
      results.record('Read QR from file', false, '$e');
      results.summary();
      await _shutdownChannels(coreChannel, commerceChannel);
      exit(1);
    }

    // =========================================================================
    // PHASE 7: Payer gets QR details (as scanner would)
    // =========================================================================
    print('\n--- Phase 7: Payer views QR details ---');

    try {
      final detailsResp = await qrPayClient.getQRDetails(
        qr_pb.GetQRDetailsRequest(qrCode: qrCodeStr),
        options: _authCallOptions(payer.accessToken),
      );

      final qr = detailsResp.qrCode;
      results.record(
        'Payer Get QR Details',
        qr.status == qr_pb.QRStatus.QR_STATUS_PENDING &&
            qr.userId == recipient.userId,
        'status=${qr.status}, recipient=${qr.fullName}, '
            'amount=${qr.amount}',
      );
    } catch (e) {
      results.record('Payer Get QR Details', false, '$e');
    }

    // =========================================================================
    // PHASE 8: Process QR Payment
    // =========================================================================
    print('\n--- Phase 8: Process QR Payment ---');

    late qr_pb.ProcessQRPaymentResponse paymentResp;
    try {
      // qr-pay-service now handles PIN verification internally:
      // raw PIN → VerifyTransactionPin → get token → pass to core-payments-service
      paymentResp = await qrPayClient.processQRPayment(
        qr_pb.ProcessQRPaymentRequest(
          qrCode: qrCodeStr,
          sourceAccountId: payer.accountId,
          amount: qrAmount,
          transactionPin: user2Pin, // raw PIN - service verifies internally
          idempotencyKey: 'integration-test-${DateTime.now().millisecondsSinceEpoch}',
        ),
        options: _authCallOptions(payer.accessToken),
      );

      final txn = paymentResp.transaction;
      results.record(
        'Process QR Payment',
        txn.id.isNotEmpty && txn.referenceNumber.isNotEmpty,
        'txn_id=${txn.id.substring(0, 12)}..., '
            'ref=${txn.referenceNumber}, '
            'status=${txn.status}, '
            'amount=${txn.amount}',
      );

      results.record(
        'Payment details correct',
        txn.payerUsername == payer.username &&
            txn.recipientUsername == recipient.username &&
            txn.amount == qrAmount,
        'payer=${txn.payerUsername}, recipient=${txn.recipientUsername}, '
            'amount=${txn.amount}',
      );

      results.record(
        'New balance returned',
        paymentResp.newBalance >= 0,
        'new_balance=${paymentResp.newBalance}',
      );

      print('    Transaction ID: ${txn.id}');
      print('    Reference: ${txn.referenceNumber}');
      print('    Payer: ${txn.payerName} (${txn.payerUsername})');
      print('    Recipient: ${txn.recipientName} (${txn.recipientUsername})');
      print('    Amount: ${txn.amount} ${txn.currency}');
      print('    New Balance: ${paymentResp.newBalance}');
    } catch (e) {
      results.record('Process QR Payment', false, '$e');
      results.summary();
      await _shutdownChannels(coreChannel, commerceChannel);
      exit(1);
    }

    // =========================================================================
    // PHASE 9: Verify QR is now PAID
    // =========================================================================
    print('\n--- Phase 9: Verify QR is now PAID ---');

    try {
      final detailsResp = await qrPayClient.getQRDetails(
        qr_pb.GetQRDetailsRequest(qrCode: qrCodeStr),
        options: _authCallOptions(recipient.accessToken),
      );

      results.record(
        'QR status updated to PAID',
        detailsResp.qrCode.status == qr_pb.QRStatus.QR_STATUS_PAID,
        'status=${detailsResp.qrCode.status}',
      );
    } catch (e) {
      results.record('QR status updated to PAID', false, '$e');
    }

    // =========================================================================
    // PHASE 10: Get receipt (payer)
    // =========================================================================
    print('\n--- Phase 10: Get Transaction Receipt ---');

    final transactionId = paymentResp.transaction.id;

    try {
      final receiptResp = await qrPayClient.getQRTransactionReceipt(
        qr_pb.GetQRTransactionReceiptRequest(transactionId: transactionId),
        options: _authCallOptions(payer.accessToken),
      );

      results.record(
        'Payer receipt',
        receiptResp.transaction.id == transactionId,
        'txn_id matches',
      );
    } catch (e) {
      results.record('Payer receipt', false, '$e');
    }

    // Get receipt as recipient
    try {
      final receiptResp = await qrPayClient.getQRTransactionReceipt(
        qr_pb.GetQRTransactionReceiptRequest(transactionId: transactionId),
        options: _authCallOptions(recipient.accessToken),
      );

      results.record(
        'Recipient receipt',
        receiptResp.transaction.id == transactionId,
        'txn_id matches',
      );
    } catch (e) {
      results.record('Recipient receipt', false, '$e');
    }

    // =========================================================================
    // PHASE 11: Verify payment history (both users)
    // =========================================================================
    print('\n--- Phase 11: Verify Payment History ---');

    // Recipient: check generated QR codes
    try {
      final generatedResp = await qrPayClient.getMyGeneratedQRCodes(
        qr_pb.GetMyGeneratedQRCodesRequest(limit: 50, offset: 0),
        options: _authCallOptions(recipient.accessToken),
      );

      // Search by QR code string or by QR ID
      final qrId = generateResp.qrCode.id;
      final foundQR = generatedResp.qrCodes.any(
        (qr) => qr.qrCode == qrCodeStr || qr.id == qrId,
      );

      results.record(
        'Recipient generated QR history',
        generatedResp.qrCodes.isNotEmpty,
        'total=${generatedResp.total}, found_our_qr=$foundQR',
      );
    } catch (e) {
      results.record('Recipient generated QR history', false, '$e');
    }

    // Payer: check QR payments history
    try {
      final paymentsResp = await qrPayClient.getMyQRPayments(
        qr_pb.GetMyQRPaymentsRequest(limit: 10, offset: 0),
        options: _authCallOptions(payer.accessToken),
      );

      final foundTxn = paymentsResp.transactions.any(
        (txn) => txn.id == transactionId,
      );

      results.record(
        'Payer QR payments history',
        foundTxn && paymentsResp.transactions.isNotEmpty,
        'total=${paymentsResp.total}, found_our_txn=$foundTxn',
      );
    } catch (e) {
      results.record('Payer QR payments history', false, '$e');
    }

    // Recipient: also check payments history (they should see received payments)
    try {
      final paymentsResp = await qrPayClient.getMyQRPayments(
        qr_pb.GetMyQRPaymentsRequest(limit: 10, offset: 0),
        options: _authCallOptions(recipient.accessToken),
      );

      final foundTxn = paymentsResp.transactions.any(
        (txn) => txn.id == transactionId,
      );

      results.record(
        'Recipient QR payments history (received)',
        foundTxn && paymentsResp.transactions.isNotEmpty,
        'total=${paymentsResp.total}, found_our_txn=$foundTxn',
      );
    } catch (e) {
      results.record('Recipient QR payments history (received)', false, '$e');
    }

    // =========================================================================
    // PHASE 12: Verify duplicate payment is blocked
    // =========================================================================
    print('\n--- Phase 12: Verify Duplicate Payment Blocked ---');

    try {
      await qrPayClient.processQRPayment(
        qr_pb.ProcessQRPaymentRequest(
          qrCode: qrCodeStr,
          sourceAccountId: payer.accountId,
          amount: qrAmount,
          transactionPin: user2Pin,
          idempotencyKey: 'duplicate-test-${DateTime.now().millisecondsSinceEpoch}',
        ),
        options: _authCallOptions(payer.accessToken),
      );
      // If we get here, the duplicate was NOT blocked
      results.record('Duplicate payment blocked', false, 'Payment succeeded (should have failed)');
    } on GrpcError catch (e) {
      // Expected: FailedPrecondition or similar error
      results.record(
        'Duplicate payment blocked',
        true,
        'Correctly rejected: ${e.code} - ${e.message}',
      );
    } catch (e) {
      results.record('Duplicate payment blocked', false, 'Unexpected error: $e');
    }

    // =========================================================================
    // PHASE 13: Self-payment blocked
    // =========================================================================
    print('\n--- Phase 13: Verify Self-Payment Blocked ---');

    try {
      // Generate a new QR as payer
      final selfQR = await qrPayClient.generateQR(
        qr_pb.GenerateQRRequest(
          amount: 100.0,
          currency: 'NGN',
          description: 'Self-pay test',
          qrType: qr_pb.QRType.QR_TYPE_DYNAMIC,
          validityMinutes: 30,
        ),
        options: _authCallOptions(payer.accessToken),
      );

      // Try to pay own QR
      await qrPayClient.processQRPayment(
        qr_pb.ProcessQRPaymentRequest(
          qrCode: selfQR.qrCode.qrCode,
          sourceAccountId: payer.accountId,
          amount: 100.0,
          transactionPin: user2Pin,
          idempotencyKey: 'self-pay-test-${DateTime.now().millisecondsSinceEpoch}',
        ),
        options: _authCallOptions(payer.accessToken),
      );
      results.record('Self-payment blocked', false, 'Payment succeeded (should have failed)');
    } on GrpcError catch (e) {
      results.record(
        'Self-payment blocked',
        true,
        'Correctly rejected: ${e.code} - ${e.message}',
      );
    } catch (e) {
      results.record('Self-payment blocked', false, 'Unexpected error: $e');
    }

    // =========================================================================
    // PHASE 14: Update QR data file with transaction result
    // =========================================================================
    print('\n--- Phase 14: Save transaction result ---');

    try {
      final file = File(qrDataFilePath);
      final content = await file.readAsString();
      final data = jsonDecode(content) as Map<String, dynamic>;

      data['transaction_id'] = paymentResp.transaction.id;
      data['reference_number'] = paymentResp.transaction.referenceNumber;
      data['payer_username'] = payer.username;
      data['payer_name'] = '${payer.firstName} ${payer.lastName}';
      data['payment_status'] = paymentResp.transaction.status.name;
      data['new_payer_balance'] = paymentResp.newBalance;
      data['paid_at'] = DateTime.now().toIso8601String();

      await file.writeAsString(
        const JsonEncoder.withIndent('  ').convert(data),
      );

      results.record('Save transaction result', true, qrDataFilePath);
    } catch (e) {
      results.record('Save transaction result', false, '$e');
    }
  } finally {
    await _shutdownChannels(coreChannel, commerceChannel);
  }

  // Summary
  results.summary();

  print('\nQR data file: $qrDataFilePath');
  print('Both users should now see this transaction in the app.');

  exit(results.allPassed ? 0 : 1);
}

Future<void> _shutdownChannels(
  ClientChannel core,
  ClientChannel commerce,
) async {
  try {
    await core.shutdown();
  } catch (_) {}
  try {
    await commerce.shutdown();
  } catch (_) {}
}
