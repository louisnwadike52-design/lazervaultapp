import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/rmb/sender_detail_validation.dart';

void main() {
  group('the profile that cost us \$135.40', () {
    // Read back from rmb_compliance_profiles for the user whose two CNY Alipay
    // payouts Klasha failed with "Tazapay payout details are missing." after
    // debiting $62.09 and a $5.61 fee on each:
    //
    //   {"city":"City","state":"State","postcode":"",
    //    "country_code":"NG","street_address":""}
    test('city "City" is rejected, not accepted as filled in', () {
      expect(isPlaceholderValue('City', 'City'), isTrue);
      expect(senderFieldError('City', 'City'), 'Enter your actual city');
    });

    test('state "State" is rejected', () {
      expect(isPlaceholderValue('State', 'State'), isTrue);
      expect(senderFieldError('State', 'State'), 'Enter your actual state');
    });

    test('a blank street address is Required, not silently optional', () {
      expect(senderFieldError('', 'Street address'), 'Required');
    });
  });

  group('a user who typed something gets a different message', () {
    test('empty says Required', () {
      expect(senderFieldError('   ', 'City'), 'Required');
    });

    test('placeholder names the field instead of saying Required', () {
      // "Required" shown against a field the user did fill reads as a bug.
      expect(senderFieldError('city', 'City'), 'Enter your actual city');
      expect(senderFieldError('N/A', 'City'), 'Enter your actual city');
      expect(senderFieldError('street-address', 'Street address'),
          'Enter your actual street address');
    });
  });

  group('real values pass', () {
    test('ordinary addresses are accepted', () {
      for (final v in ['Lagos', 'Lagos State', '12 Admiralty Way', 'Ikeja']) {
        expect(isPlaceholderValue(v, 'City'), isFalse, reason: v);
        expect(senderFieldError(v, 'City'), isNull, reason: v);
      }
    });

    test('a city that merely contains the label is fine', () {
      // "Cityscape Avenue" must not be mistaken for the placeholder "City".
      expect(isPlaceholderValue('Cityscape Avenue', 'City'), isFalse);
    });
  });

  group('matches the backend', () {
    // These must stay in lockstep with placeholderFor() in
    // internal/provider/payout_details.go — if the app accepts what the server
    // refuses the user sees an unexplained failure, and if the server accepts
    // what the app refuses we are back to paying for rejected payouts.
    test('the same junk tokens are rejected on both sides', () {
      for (final junk in [
        'n/a', 'na', 'none', 'null', 'nil', '-', '--', 'unknown',
        'not applicable', 'string', 'test', 'xxx', 'xxxx',
      ]) {
        expect(isPlaceholderValue(junk, 'City'), isTrue, reason: junk);
      }
    });

    test('punctuation and spacing are ignored when comparing to the label', () {
      expect(isPlaceholderValue('  STREET_ADDRESS  ', 'Street address'), isTrue);
      expect(isPlaceholderValue('street.address', 'Street address'), isTrue);
    });
  });

  group('sender government ID', () {
    // The exact value that reached Klasha as a passport number.
    const junk = '888989898989';

    test('the junk ID is rejected whatever document type is claimed', () {
      for (final t in ['PASSPORT', 'ID_CARD', 'DRIVER_LICENSE', 'OTHER']) {
        expect(senderIdError(junk, t, 'NG'), isNotNull, reason: t);
      }
    });

    test('low-variety values are caught, short ones are not judged', () {
      for (final v in ['00000000000', '11111111111', 'aaaaaaaa']) {
        expect(looksLikeKeyboardMash(normalizeSenderId(v)), isTrue, reason: v);
      }
      for (final v in ['AA11', '1234']) {
        expect(looksLikeKeyboardMash(normalizeSenderId(v)), isFalse, reason: v);
      }
    });

    test('real documents pass — a false rejection blocks a real payment', () {
      expect(senderIdError('12345678901', 'ID_CARD', 'NG'), isNull);
      expect(senderIdError('A01234567', 'PASSPORT', 'NG'), isNull);
      expect(senderIdError('a 0123 4567', 'PASSPORT', 'NG'), isNull);
      expect(senderIdError('123456789', 'PASSPORT', 'US'), isNull);
      expect(senderIdError('ABC123456AA11', 'DRIVER_LICENSE', 'NG'), isNull);
    });

    test('wrong shapes explain the format', () {
      expect(senderIdError('1234567', 'ID_CARD', 'NG'), contains('11 digits'));
      expect(senderIdError('012345678', 'PASSPORT', 'NG'),
          contains('one letter'));
    });

    test('foreign nationals are not held to Nigerian formats', () {
      expect(senderIdError('X1234567', 'PASSPORT', 'GB'), isNull);
      expect(senderIdError('A1234567Z', 'ID_CARD', 'GB'), isNull);
    });
  });
}
