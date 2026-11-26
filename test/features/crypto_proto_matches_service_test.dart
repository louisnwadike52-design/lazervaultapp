import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE APP'S crypto.proto IS A COPY. IT MUST STAY A FAITHFUL ONE.
///
/// It had drifted badly: 2377 lines against the service's 2886, missing 42
/// messages and — the one that bit — `GetCryptoWithdrawalStatusRequest.reference`,
/// a field `crypto_grpc_client.dart` actively sets. The generated Dart had been
/// produced from the SERVICE's proto, so the checked-in .proto and the
/// checked-in .dart described different contracts.
///
/// Nothing caught that, because nothing regenerates this file routinely. The
/// damage only appears when someone finally does regenerate: protoc faithfully
/// emits the stale contract, silently deleting fields live code depends on,
/// inside a 30,000-line diff nobody can read.
///
/// So the copy is pinned. If the service's proto moves, copy it over and
/// regenerate — do not hand-edit this file, and do not regenerate from it
/// without checking it is current first.
void main() {
  final appProto = File('proto/crypto.proto');
  final serviceProto =
      File('../microservices/crypto-service/proto/crypto.proto');

  test('the app proto is byte-identical to crypto-service\'s', () {
    if (!serviceProto.existsSync()) {
      // The service lives in a sibling repository and may not be checked out
      // beside the app. Skip rather than fail — a missing sibling is not a
      // defect in this one.
      return;
    }
    expect(appProto.existsSync(), isTrue);
    expect(
      appProto.readAsStringSync(),
      serviceProto.readAsStringSync(),
      reason: 'proto/crypto.proto has drifted from crypto-service, which is '
          'the source the generated Dart is built from. Regenerating from a '
          'stale copy DELETES fields that live code uses. Copy the service '
          'file over and regenerate.',
    );
  });

  test('the field whose loss broke the build is present', () {
    // A named regression guard, because this is the one that was actually
    // lost and the one whose absence is hardest to spot in a huge diff.
    final dart = File('lib/src/generated/crypto.pb.dart').readAsStringSync();
    final i = dart.indexOf('class GetCryptoWithdrawalStatusRequest');
    expect(i, greaterThan(-1));
    final body = dart.substring(i, i + 4000);
    expect(body, contains('set reference('),
        reason: 'crypto_grpc_client.dart sets this; regenerating from the '
            'stale proto removed it and the app stopped compiling');
  });

  test('the generated Dart carries the Pay-with-Crypto contract', () {
    final dart = File('lib/src/generated/crypto.pb.dart').readAsStringSync();
    for (final t in [
      'CreateFundedPaymentRequest',
      'CreateFundedPaymentResponse',
      'ListPayableAssetsResponse',
      'GetFundedPaymentResponse',
    ]) {
      expect(dart, contains('class $t'),
          reason: '$t is missing — the app cannot reach pay-with-crypto');
    }
  });
}
