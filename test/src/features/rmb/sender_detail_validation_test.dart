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
}
