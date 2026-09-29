import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/masked_contact.dart';

void main() {
  group('isMaskedContact', () {
    test('the exact value payroll prefilled and then rejected', () {
      // Straight from the Add Employee screen: the app wrote this into its own
      // Email field and the field's validator answered "Enter a valid email
      // address".
      expect(isMaskedContact('ez***@gmail.com'), isTrue);
    });

    test('the other shapes auth-service masks with', () {
      for (final v in ['***1234', 'j*@x.co', '+234***5678', '*']) {
        expect(isMaskedContact(v), isTrue, reason: v);
      }
    });

    test('a real address or number is not masked', () {
      for (final v in [
        'ezeke@gmail.com',
        'nnaemeka.ezeke@lazervault.app',
        '+2348012345678',
        '08012345678',
      ]) {
        expect(isMaskedContact(v), isFalse, reason: v);
      }
    });

    test('null and empty are not masked', () {
      expect(isMaskedContact(null), isFalse);
      expect(isMaskedContact(''), isFalse);
    });
  });

  group('prefillableContact', () {
    test('a masked value prefills as blank, not as the mask', () {
      // Blank leaves the placeholder showing, which is the honest state: we do
      // not have their address. The mask looked like data and was not.
      expect(prefillableContact('ez***@gmail.com'), '');
      expect(prefillableContact('***1234'), '');
    });

    test('a real value prefills, trimmed', () {
      expect(prefillableContact('  ezeke@gmail.com '), 'ezeke@gmail.com');
    });

    test('null and empty prefill as blank', () {
      expect(prefillableContact(null), '');
      expect(prefillableContact('   '), '');
    });
  });
}
