import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/features/airtime/data/models/airtime_transaction_model.dart';
import 'package:lazervault/src/features/airtime/domain/entities/airtime_transaction.dart';

/// PAY WITH CRYPTO — the amount that gets converted for a bill or top-up.
///
/// The purchase reserves face + platform fee. Converting the face amount alone
/// is short by exactly the fee, and the purchase then fails on insufficient
/// funds — which the customer is told was a rate move. The server quotes the
/// real total; these pin that it survives the trip.
void main() {
  pb.BuyAirtimeResponse parked({
    required String metadata,
    double amount = 1000,
    String status = 'awaiting_crypto_funding',
  }) {
    return pb.BuyAirtimeResponse(
      phoneNumber: '08031234567',
      payment: pb.BillPayment(
        id: 'p1',
        reference: 'CFB-1',
        amount: amount,
        status: status,
        providerId: 'mtn',
        metadata: metadata,
      ),
    );
  }

  test('the server-quoted total survives into the transaction', () {
    final t = AirtimeTransactionModel.fromBuyAirtimeResponse(
      parked(
        metadata: '{"funding_source":"crypto","required_minor":102500,'
            '"funding_asset":"usdt","service":"airtime"}',
      ),
      currency: 'NGN',
    );
    // 1,000 face + 25 fee = 102,500 kobo, NOT 100,000.
    expect(t.metadata?['required_minor'], 102500);
    expect(t.metadata?['funding_asset'], 'usdt');
    expect(t.metadata?['service'], 'airtime');
  });

  test('an awaiting conversion is pending, never completed', () {
    // The default branch of the status mapper must catch this. Reading it as
    // completed would tell a customer their airtime had been delivered while
    // the coin was still being sold.
    final t = AirtimeTransactionModel.fromBuyAirtimeResponse(
      parked(metadata: '{}'),
      currency: 'NGN',
    );
    expect(t.status, AirtimeTransactionStatus.pending);
    expect(t.status, isNot(AirtimeTransactionStatus.completed));
    expect(t.status, isNot(AirtimeTransactionStatus.failed));
  });

  test('another service\'s metadata is ignored, not misread as funding', () {
    final t = AirtimeTransactionModel.fromBuyAirtimeResponse(
      parked(metadata: '{"required_minor":999,"some_other":"thing"}'),
      currency: 'NGN',
    );
    // No funding_source marker: these are not our fields.
    expect(t.metadata?['required_minor'], isNull);
  });

  test('unparseable metadata yields nothing rather than throwing', () {
    // The field is a plain string carrying whatever a service wrote. A
    // receipt must render, not crash.
    for (final raw in ['', 'not json', '[1,2,3]', 'null']) {
      final t = AirtimeTransactionModel.fromBuyAirtimeResponse(
        parked(metadata: raw),
        currency: 'NGN',
      );
      expect(t.metadata?['required_minor'], isNull, reason: 'raw: $raw');
    }
  });

  test('an ordinary completed purchase is unchanged', () {
    final t = AirtimeTransactionModel.fromBuyAirtimeResponse(
      parked(metadata: '', status: 'completed'),
      currency: 'NGN',
    );
    expect(t.status, AirtimeTransactionStatus.completed);
    expect(t.metadata?['funding_asset'], isNull);
  });
}
