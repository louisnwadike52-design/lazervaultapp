import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/src/features/crypto_pay/domain/fund_payment_with_crypto.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/data/datasources/payments_transfer_data_source.dart';

/// PAY WITH CRYPTO — the rules that keep a conversion honest.
///
/// These are regressions, not hypotheticals. Each one was a live defect in the
/// first wiring of this path, and each one costs a customer money or lies to
/// them about it.
void main() {
  // AnalyticsService is a lazy singleton reached inside sendFunds, and it
  // reads secure storage over a platform channel. Unstubbed, that read throws
  // AFTER the test it was triggered from has already passed, which the runner
  // reports against an unrelated test. Stub the channel rather than reorder
  // the tests around it.
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.it_nomads.com/flutter_secure_storage'),
      (call) async => call.method == 'readAll' ? <String, String>{} : null,
    );
  });

  group('crypto-funded transfer', () {
    test(
        'the conversion is asked for ONLY after the payment is recorded, and names that payment',
        () async {
      final calls = <Map<String, Object?>>[];
      final ds = _FakeDataSource(
        result: _ok(reference: 'TRF-9001', amount: 450000, fee: 2500),
      );
      final cubit = TransferCubit(
        paymentsTransferDataSource: ds,
        fundWithCrypto: ({
          required String accountId,
          required String paymentReference,
          required int requiredMinor,
          required String asset,
          String service = 'transfer',
          String currency = 'NGN',
        }) async {
          // The payment must already exist by the time this runs.
          expect(ds.sendCalls, 1,
              reason: 'crypto was sold before the payment was recorded');
          calls.add({
            'ref': paymentReference,
            'required': requiredMinor,
            'asset': asset,
          });
          return const CryptoFundingStart(
              fundedPaymentId: 'cfp-1',
              status: 'converting',
              alreadyExists: false);
        },
      );

      await cubit.sendFunds(
        fromAccountId: 'acct-1',
        toAccountNumber: '0123456789',
        type: 'external',
        amount: 4500,
        description: 'rent',
        transactionId: 'tx-1',
        verificationToken: 'tok-1',
        fundingAsset: 'USDT',
      );

      expect(calls, hasLength(1), reason: 'exactly one conversion per payment');
      expect(calls.single['ref'], 'TRF-9001');
      // amount + fee: converting only the amount lands short of what the
      // transfer actually costs, and the payment then cannot be spent.
      expect(calls.single['required'], 452500);
      // Normalised — the server keys assets lowercase.
      expect(calls.single['asset'], 'usdt');
    });

    test('the asset reaches the data source so the server can park the payment',
        () async {
      final ds = _FakeDataSource(result: _ok(reference: 'TRF-2'));
      final cubit = TransferCubit(
        paymentsTransferDataSource: ds,
        fundWithCrypto: _noopFunding,
      );
      await cubit.sendFunds(
        fromAccountId: 'a',
        toAccountNumber: '1',
        type: 'internal',
        amount: 100,
        description: '',
        transactionId: 't',
        verificationToken: 'v',
        fundingAsset: 'btc',
      );
      expect(ds.lastFundingAsset, 'btc');
    });

    test('a crypto-funded transfer is IN FLIGHT, never a finished receipt',
        () async {
      // Was a live defect: isInFlight only covered external pending, so a
      // crypto-funded transfer rendered a completed receipt while the coin was
      // still being sold — and a customer shown money as sent may send it again.
      final cubit = TransferCubit(
        paymentsTransferDataSource: _FakeDataSource(
          result: _ok(reference: 'TRF-3', status: 'awaiting_crypto_funding'),
        ),
        fundWithCrypto: _noopFunding,
      );
      await cubit.sendFunds(
        fromAccountId: 'a',
        toAccountNumber: '1',
        type: 'internal',
        amount: 100,
        description: '',
        transactionId: 't',
        verificationToken: 'v',
        fundingAsset: 'usdt',
      );
      final s = cubit.state;
      expect(s, isA<TransferSuccess>());
      expect((s as TransferSuccess).isInFlight, isTrue);
    });

    test('an ordinary wallet transfer never asks for a conversion', () async {
      var funded = false;
      final cubit = TransferCubit(
        paymentsTransferDataSource: _FakeDataSource(result: _ok()),
        fundWithCrypto: ({
          required String accountId,
          required String paymentReference,
          required int requiredMinor,
          required String asset,
          String service = 'transfer',
          String currency = 'NGN',
        }) async {
          funded = true;
          return const CryptoFundingStart(
              fundedPaymentId: '', status: '', alreadyExists: false);
        },
      );
      await cubit.sendFunds(
        fromAccountId: 'a',
        toAccountNumber: '1',
        type: 'internal',
        amount: 100,
        description: '',
        transactionId: 't',
        verificationToken: 'v',
      );
      expect(funded, isFalse);
      expect((cubit.state as TransferSuccess).isInFlight, isFalse);
    });

    test('a short wallet does not refuse the transfer the sell is meant to fund',
        () async {
      // Was a live defect: the client-side pre-flight balance check refused
      // exactly the transfers this feature exists to serve, before the server
      // ever saw them.
      final ds = _FakeDataSource(result: _ok(reference: 'TRF-4'));
      final cubit = TransferCubit(
        paymentsTransferDataSource: ds,
        fundWithCrypto: _noopFunding,
      );
      await cubit.sendFunds(
        fromAccountId: 'a',
        toAccountNumber: '1',
        type: 'internal',
        amount: 50000,
        description: '',
        transactionId: 't',
        verificationToken: 'v',
        availableBalance: 12, // nowhere near enough
        fundingAsset: 'usdt',
      );
      expect(ds.sendCalls, 1, reason: 'refused in the client, never sent');
      expect(cubit.state, isA<TransferSuccess>());
    });

    test('a short wallet STILL refuses an ordinary wallet transfer', () async {
      final ds = _FakeDataSource(result: _ok());
      final cubit = TransferCubit(
        paymentsTransferDataSource: ds,
        fundWithCrypto: _noopFunding,
      );
      await cubit.sendFunds(
        fromAccountId: 'a',
        toAccountNumber: '1',
        type: 'internal',
        amount: 50000,
        description: '',
        transactionId: 't',
        verificationToken: 'v',
        availableBalance: 12,
      );
      expect(ds.sendCalls, 0);
      expect(cubit.state, isA<TransferFailure>());
    });

    test('a refusal promises no charge; a lost reply never does', () async {
      Future<CryptoFundingStart> throwing(GrpcError err) => Future.error(err);

      // Refused on its merits — nothing was converted, so we may say so.
      final refused = TransferCubit(
        paymentsTransferDataSource:
            _FakeDataSource(result: _ok(reference: 'TRF-5')),
        fundWithCrypto: ({
          required String accountId,
          required String paymentReference,
          required int requiredMinor,
          required String asset,
          String service = 'transfer',
          String currency = 'NGN',
        }) =>
            throwing(GrpcError.failedPrecondition('Not enough USDT.')),
      );
      await refused.sendFunds(
        fromAccountId: 'a',
        toAccountNumber: '1',
        type: 'internal',
        amount: 100,
        description: '',
        transactionId: 't',
        verificationToken: 'v',
        fundingAsset: 'usdt',
      );
      expect(refused.state, isA<TransferFailure>());
      expect((refused.state as TransferFailure).message,
          contains('not been charged'));

      // Lost reply — the conversion may well have started. Claiming "no
      // charge" here would be a guess about the customer's money.
      final lost = TransferCubit(
        paymentsTransferDataSource:
            _FakeDataSource(result: _ok(reference: 'TRF-6')),
        fundWithCrypto: ({
          required String accountId,
          required String paymentReference,
          required int requiredMinor,
          required String asset,
          String service = 'transfer',
          String currency = 'NGN',
        }) =>
            throwing(GrpcError.deadlineExceeded('timeout')),
      );
      await lost.sendFunds(
        fromAccountId: 'a',
        toAccountNumber: '1',
        type: 'internal',
        amount: 100,
        description: '',
        transactionId: 't',
        verificationToken: 'v',
        fundingAsset: 'usdt',
      );
      final msg = (lost.state as TransferFailure).message;
      expect(msg, isNot(contains('not been charged')));
      expect(msg, contains('could not confirm'));
    });

    test('a payment with no reference is never funded', () async {
      // Funding a payment we cannot name is how crypto gets sold for an
      // errand nothing is tracking — and the sale cannot be undone.
      var funded = false;
      final cubit = TransferCubit(
        paymentsTransferDataSource: _FakeDataSource(result: _ok(reference: '')),
        fundWithCrypto: ({
          required String accountId,
          required String paymentReference,
          required int requiredMinor,
          required String asset,
          String service = 'transfer',
          String currency = 'NGN',
        }) async {
          funded = true;
          return const CryptoFundingStart(
              fundedPaymentId: '', status: '', alreadyExists: false);
        },
      );
      await cubit.sendFunds(
        fromAccountId: 'a',
        toAccountNumber: '1',
        type: 'internal',
        amount: 100,
        description: '',
        transactionId: 't',
        verificationToken: 'v',
        fundingAsset: 'usdt',
      );
      expect(funded, isFalse);
      expect(cubit.state, isA<TransferFailure>());
    });
  });
}

Future<CryptoFundingStart> _noopFunding({
  required String accountId,
  required String paymentReference,
  required int requiredMinor,
  required String asset,
  String service = 'transfer',
  String currency = 'NGN',
}) async =>
    const CryptoFundingStart(
        fundedPaymentId: 'cfp', status: 'converting', alreadyExists: false);

PaymentsTransferResult _ok({
  String? reference = 'TRF-1',
  String status = 'pending',
  int amount = 10000,
  int fee = 0,
}) =>
    PaymentsTransferResult(
      success: true,
      transferId: 'id-1',
      reference: reference,
      status: status,
      amount: amount,
      fee: fee,
      createdAt: DateTime(2026, 11, 19),
    );

class _FakeDataSource implements IPaymentsTransferDataSource {
  _FakeDataSource({required this.result});

  final PaymentsTransferResult result;
  int sendCalls = 0;
  String? lastFundingAsset;

  @override
  Future<PaymentsTransferResult> sendFunds({
    required String fromAccountId,
    required String toAccountNumber,
    String? toAccountId,
    required String type,
    required double amount,
    required String description,
    required String transactionId,
    required String verificationToken,
    String? destinationBankCode,
    String? beneficiaryName,
    DateTime? scheduledAt,
    int? expenseCategory,
    String? flow,
    String? fundingAsset,
  }) async {
    sendCalls++;
    lastFundingAsset = fundingAsset;
    return result;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
