import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/ng_msisdn.dart';

void main() {
  group('every spelling a person might type', () {
    // The reported case: the field shows "+234", so the customer types the
    // ten digits the prefix is asking for and the Buy button stays dead.
    test('ten digits under the +234 prefix', () {
      expect(normaliseNgMsisdn('9035137654'), '09035137654');
      expect(isValidNgMsisdn('9035137654'), isTrue);
    });

    test('the canonical eleven-digit form', () {
      expect(normaliseNgMsisdn('09035137654'), '09035137654');
    });

    test('dialling code, with and without the plus', () {
      expect(normaliseNgMsisdn('2349035137654'), '09035137654');
      expect(normaliseNgMsisdn('+2349035137654'), '09035137654');
      expect(normaliseNgMsisdn('+234 903 513 7654'), '09035137654');
    });

    test('international access prefix, as a roaming contact saves it', () {
      expect(normaliseNgMsisdn('002349035137654'), '09035137654');
    });

    test('a contact book that kept the trunk zero after the country code', () {
      expect(normaliseNgMsisdn('+23409035137654'), '09035137654');
    });

    test('spaces, dashes and brackets', () {
      expect(normaliseNgMsisdn('0903 513 7654'), '09035137654');
      expect(normaliseNgMsisdn('0903-513-7654'), '09035137654');
      expect(normaliseNgMsisdn('(0903) 513 7654'), '09035137654');
      expect(normaliseNgMsisdn('  09035137654  '), '09035137654');
    });

    test('every live Nigerian mobile prefix', () {
      for (final p in ['070', '071', '080', '081', '090', '091']) {
        final n = '${p}12345678';
        expect(normaliseNgMsisdn(n), n, reason: 'prefix $p must be accepted');
      }
    });
  });

  group('what must still be refused', () {
    test('too short, even with a valid prefix', () {
      expect(normaliseNgMsisdn('090351376'), isNull);
      expect(isValidNgMsisdn('0903513765'), isFalse); // 10 digits, has the 0
    });

    test('too long', () {
      expect(normaliseNgMsisdn('090351376543'), isNull);
    });

    test('a landline or a non-mobile prefix — these flows top up a SIM', () {
      expect(normaliseNgMsisdn('0123456789'), isNull);
      expect(normaliseNgMsisdn('2341234567890'), isNull);
      expect(normaliseNgMsisdn('6035137654'), isNull);
    });

    test('empty and junk', () {
      expect(normaliseNgMsisdn(''), isNull);
      expect(normaliseNgMsisdn('   '), isNull);
      expect(normaliseNgMsisdn('abcdefghijk'), isNull);
      expect(isValidNgMsisdn('+++'), isFalse);
    });
  });

  group('what the field tells the customer', () {
    test('silent while the number is empty or still being typed', () {
      expect(ngMsisdnHint(''), isNull);
      expect(ngMsisdnHint('0903'), isNull);
      expect(ngMsisdnHint('090351'), isNull);
    });

    test('silent once the number is good — the enabled button says it', () {
      expect(ngMsisdnHint('9035137654'), isNull);
      expect(ngMsisdnHint('09035137654'), isNull);
      expect(ngMsisdnHint('+2349035137654'), isNull);
    });

    test('names the problem once there is enough to judge', () {
      expect(ngMsisdnHint('1234567890'), contains('Nigerian mobile'));
      expect(ngMsisdnHint('090351376543210'), contains('too long'));
    });
  });

  // The whole point of the change: the button and the request must agree on
  // what a valid number is. Anything the button accepts must normalise to the
  // eleven digits the provider is sent.
  test('accepted implies sendable, for every spelling', () {
    const spellings = [
      '9035137654',
      '09035137654',
      '2349035137654',
      '+2349035137654',
      '002349035137654',
      '0903 513 7654',
      '+234 903-513-7654',
    ];
    for (final s in spellings) {
      expect(isValidNgMsisdn(s), isTrue, reason: s);
      final sent = normaliseNgMsisdn(s);
      expect(sent, '09035137654', reason: s);
      expect(sent!.length, 11);
      expect(sent.startsWith('0'), isTrue);
    }
  });
}
