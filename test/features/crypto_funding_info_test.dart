import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/crypto_pay/domain/crypto_funding_info.dart';

void main() {
  test('reads the server-quoted total', () {
    final i = CryptoFundingInfo.fromMetadata(
      '{"funding_source":"crypto","required_minor":102500,'
      '"funding_asset":"usdt","service":"electricity"}',
    );
    expect(i, isNotNull);
    expect(i!.requiredMinor, 102500);
    expect(i.asset, 'usdt');
    expect(i.service, 'electricity');
  });

  test('another service\'s metadata is not mistaken for a conversion target',
      () {
    // Without the funding_source marker a stray required_minor from some
    // other writer would be converted against.
    expect(
      CryptoFundingInfo.fromMetadata('{"required_minor":999}'),
      isNull,
    );
  });

  test('rubbish yields null rather than throwing on a receipt', () {
    for (final raw in [null, '', 'not json', '[1,2]', 'null', '{}']) {
      expect(CryptoFundingInfo.fromMetadata(raw), isNull, reason: 'raw: $raw');
    }
  });

  test('a zero or negative total is refused', () {
    // Converting "zero" would open a conversion that can never fund anything.
    for (final v in ['0', '-5']) {
      expect(
        CryptoFundingInfo.fromMetadata(
            '{"funding_source":"crypto","required_minor":$v}'),
        isNull,
      );
    }
  });
}
