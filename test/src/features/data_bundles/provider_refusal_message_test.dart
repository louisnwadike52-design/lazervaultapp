import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/data_bundles/domain/entities/data_purchase_entity.dart';

/// THE PROVIDER'S REASON MUST REACH THE CUSTOMER.
///
/// Measured 2026-11-10: a customer bought airtel-awoof-600mb-daily, the
/// provider refused with "This phone number is not eligible for the selected
/// plan. Please try purchasing Daily Plan 200 (N200) or other plans.", and the
/// screen showed a silent refund. He retried the identical plan 60 seconds
/// later — which is what anyone does when given no reason.
///
/// The backend now stamps the sanitised sentence onto metadata as
/// `provider_message`. This pins the app's side of that contract: the key is
/// read from metadata, only for failures, and absence renders nothing.
void main() {
  DataPurchaseEntity purchase({required String status, String metadata = ''}) {
    return DataPurchaseEntity(
      id: 'p1',
      userId: 'u1',
      accountId: 'a1',
      reference: 'DATA-1794304772-ef9b560d',
      amount: 225,
      status: status,
      phoneNumber: '08140005562',
      dataPlan: 'airtel-awoof-600mb-daily',
      newBalance: 0,
      commissionEarned: 0,
      providerReference: '',
      createdAt: '2026-11-10T08:19:32Z',
      metadata: metadata,
    );
  }

  const liveMessage =
      'Data purchase failed - This phone number is not eligible for the '
      'selected plan. Please try purchasing Daily Plan 200 (N200) or other plans.';

  group('provider_message on a failed data purchase', () {
    test('the live refusal is parsed off metadata', () {
      final p = purchase(
        status: 'failed',
        metadata: jsonEncode({
          'provider_message': liveMessage,
          'plan_label': 'Awoof 600MB Daily',
        }),
      );
      expect(p.metadataMap['provider_message'], liveMessage);
      // The plan label must survive beside it — the backend MERGES onto
      // metadata rather than replacing it, because the receipt renders from
      // that same blob.
      expect(p.metadataMap['plan_label'], 'Awoof 600MB Daily');
    });

    test('absent key means nothing to show', () {
      final p = purchase(status: 'failed', metadata: jsonEncode({'plan_label': 'x'}));
      expect(p.metadataMap['provider_message'], isNull);
    });

    test('malformed metadata never throws', () {
      // A bad blob must not take down a receipt the customer is already
      // looking at after a failure.
      final p = purchase(status: 'failed', metadata: '{not json');
      expect(() => p.metadataMap, returnsNormally);
      expect(p.metadataMap['provider_message'], isNull);
    });

    test('empty metadata is handled', () {
      final p = purchase(status: 'failed', metadata: '');
      expect(p.metadataMap, isEmpty);
    });

    test('a successful purchase carrying the key is still a success', () {
      // isFailed gates the UI, so a stale key on a completed row must not
      // paint a failure banner.
      final p = purchase(
        status: 'completed',
        metadata: jsonEncode({'provider_message': liveMessage}),
      );
      expect(p.isFailed, isFalse);
    });
  });
}
