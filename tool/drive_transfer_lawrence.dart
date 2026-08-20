/// Host-side LIVE transfer E2E on DEV using an existing funded user (no signup —
/// login is never gated). Drives the real gRPC path: login → verifyTransactionPin
/// → sendFunds(external, Flutterwave sandbox NUBAN) and prints the reference so the
/// caller can assert exactly-once debit (hold → capture) against the DB.
///
/// Run: cd lazervaultapp && dart run tool/drive_transfer_lawrence.dart

import 'dart:io';
import 'dart:math';

import 'package:grpc/grpc.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth_pb;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_data;
import 'package:lazervault/src/generated/transaction_pin.pbgrpc.dart' as pin_pb;
import 'package:lazervault/src/generated/transaction_pin.pb.dart' as pin_data;
import 'package:lazervault/src/generated/payments.pbgrpc.dart' as payments_pb;
import 'package:lazervault/src/generated/payments.pb.dart' as payments_data;

const _host = '127.0.0.1';
const _coreGatewayPort = 50070;
const _transferGatewayPort = 50076;

const _email = 'lawrence@gmail.com';
const _password = '144444';
const _pin = '1444';
// lawrence's funded NGN account (₦7,124.68) — verified via DB.
const _fromAccountId = '1669ef2e-0d7b-44bb-92f1-848301b124f2';

// Flutterwave sandbox deterministic-success NUBAN (Access Bank 044).
const _recipientNUBAN = '0690000040';
const _recipientBank = '044';
const _amount = 100.0;

String _rand(int n) {
  final r = Random.secure();
  const a = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return List.generate(n, (_) => a[r.nextInt(a.length)]).join();
}

ClientChannel _ch(int port) => ClientChannel(_host,
    port: port,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure(), connectionTimeout: Duration(seconds: 10)));

Future<void> main() async {
  final coreCh = _ch(_coreGatewayPort);
  stderr.writeln('🔓 loginWithPasscode $_email');
  final login = await auth_pb.AuthServiceClient(coreCh).loginWithPasscode(
    auth_data.LoginWithPasscodeRequest(email: _email, passcode: _password, deviceId: 'host-e2e', deviceName: 'Host E2E'),
    options: CallOptions(timeout: const Duration(seconds: 30)),
  );
  if (!login.success) throw Exception('login failed: ${login.msg}');
  final token = login.accessToken;
  final md = {'authorization': 'Bearer $token'};
  const userId = '0fcc106c-56ef-4f43-a0e0-c284708f35db'; // lawrence (verified via DB)
  stderr.writeln('   ✓ logged in user=$userId');

  final txId = 'tx-${_rand(16)}';
  final pinVerify = await pin_pb.TransactionPinServiceClient(coreCh).verifyTransactionPin(
    pin_data.VerifyTransactionPinRequest(
      userId: userId, pin: _pin, transactionId: txId,
      transactionType: 'transfer', amount: _amount, currency: 'NGN', deviceId: 'host-e2e'),
    options: CallOptions(metadata: md, timeout: const Duration(seconds: 30)),
  );
  if (!pinVerify.success) throw Exception('verifyPin failed: ${pinVerify.message}');
  stderr.writeln('   ✓ PIN verified');

  final txCh = _ch(_transferGatewayPort);
  final sfReq = payments_data.SendFundsRequest(
    fromAccountId: _fromAccountId,
    toAccountNumber: _recipientNUBAN,
    toAccountId: '',
    type: 'external',
    amount: _amount,
    description: 'Lawrence dev E2E double-debit check',
    transactionId: txId,
    verificationToken: pinVerify.verificationToken,
    destinationBankCode: _recipientBank,
    beneficiaryName: 'LazerVault Test Recipient',
    expenseCategory: 0,
  );
  stderr.writeln('📤 request: type=${sfReq.type} toNUBAN=${sfReq.toAccountNumber} toAccountId="${sfReq.toAccountId}" bank=${sfReq.destinationBankCode} from=${sfReq.fromAccountId}');
  final resp = await payments_pb.PaymentsServiceClient(txCh).sendFunds(sfReq,
    options: CallOptions(metadata: {
      ...md,
      'x-account-id': _fromAccountId,
      'x-locale': 'en-NG', // else the server defaults to en-US → USD → currency mismatch vs the NGN account
    }, timeout: const Duration(seconds: 40)),
  );
  stderr.writeln('💸 status=${resp.payment.status} ref=${resp.payment.reference} msg=${resp.message}');

  await coreCh.shutdown();
  await txCh.shutdown();
  stdout.write('E2E_REF=${resp.payment.reference} FROM=$_fromAccountId\n');
}
