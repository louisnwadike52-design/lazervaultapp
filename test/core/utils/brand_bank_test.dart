import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/brand_bank.dart';

void main() {
  group('BrandBank.isOurs', () {
    test('matches the spelling the BACKEND actually writes', () {
      // accounts-service recipient_service.go writes exactly this. The send
      // funds flow used to compare against 'LazerVault' and therefore said
      // "external" for every internal recipient — free transfers were quoted a
      // fee, and "Bank details are incomplete" blocked them outright.
      expect(BrandBank.isOurs('Lazervault'), isTrue);
    });

    test('matches the old camel-cased spelling still on saved recipients', () {
      // Recipients saved by earlier app versions carry this. They must keep
      // working; a data migration is not a prerequisite for the fix.
      expect(BrandBank.isOurs('LazerVault'), isTrue);
    });

    test('matches the registry variants the name-enquiry rails return', () {
      for (final v in [
        'LAZERVAULT',
        'LAZERVAULT LTD',
        'Lazervault- LTD.',
        'Lazervault MFB',
        '  lazervault  ',
      ]) {
        expect(BrandBank.isOurs(v), isTrue, reason: v);
      }
    });

    test('a real external bank is never ours', () {
      for (final v in [
        'Zenith Bank',
        'Wema Bank',
        'GTBank',
        'Kuda Microfinance Bank',
        'Opay',
      ]) {
        expect(BrandBank.isOurs(v), isFalse, reason: v);
      }
    });

    test('null and empty are not ours', () {
      // An ABSENT bank is not evidence of an internal account — that inference
      // is what made batch transfers default to "internal" and get refused by
      // the backend with "recipient not found on LazerVault".
      expect(BrandBank.isOurs(null), isFalse);
      expect(BrandBank.isOurs(''), isFalse);
      expect(BrandBank.isOurs('   '), isFalse);
    });
  });

  group('BrandBank.display', () {
    test('collapses every variant to the one normal-case spelling', () {
      for (final v in ['LazerVault', 'LAZERVAULT LTD', 'Lazervault- LTD.']) {
        expect(BrandBank.display(v), 'Lazervault', reason: v);
      }
    });

    test('leaves an external bank verbatim', () {
      expect(BrandBank.display('Zenith Bank'), 'Zenith Bank');
    });

    test('displayName is normal case, not the camel-cased logotype', () {
      expect(BrandBank.displayName, 'Lazervault');
    });
  });
}
