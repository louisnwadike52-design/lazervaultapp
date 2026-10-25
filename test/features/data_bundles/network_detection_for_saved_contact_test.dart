import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/ng_network_prefixes.dart';

/// Saving a contact from the data history refused with "We couldn't identify
/// the network for this number" on numbers whose carrier is not in doubt.
/// History rows written before the backend stamped `network_code` carry
/// neither code nor name, and the sheet never consulted the number itself —
/// while telling the user to go and use the buy-data flow, which does exactly
/// that. These are the numbers from the report, plus one per network.
void main() {
  group('NCC prefix detection backs the save-contact fallback', () {
    test('the reported numbers resolve', () {
      expect(NgNetworkPrefixes.detect('09041473952'), 'airtel');
      expect(NgNetworkPrefixes.detect('07033609489'), 'mtn');
    });

    test('every network resolves, whichever provider was used', () {
      const samples = {
        'mtn': ['08031234567', '07061234567', '09131234567'],
        'airtel': ['08021234567', '09011234567', '09071234567'],
        'glo': ['08051234567', '08111234567', '09051234567'],
        'etisalat': ['08091234567', '08171234567', '09091234567'],
      };
      samples.forEach((network, numbers) {
        for (final n in numbers) {
          expect(NgNetworkPrefixes.detect(n), network,
              reason: '$n should resolve to $network');
        }
      });
    });

    test('accepts the forms a stored number can take', () {
      for (final form in [
        '07033609489',
        '+2347033609489',
        '2347033609489',
        '7033609489',
        '0703 360 9489',
      ]) {
        expect(NgNetworkPrefixes.detect(form), 'mtn', reason: form);
      }
    });

    // The refusal still has to exist — saving a carrier we guessed wrong is
    // worse than asking, because the plan screen keys off the network.
    test('an unallocated prefix still resolves to nothing', () {
      expect(NgNetworkPrefixes.detect('05001234567'), isNull);
      expect(NgNetworkPrefixes.detect('12345'), isNull);
      expect(NgNetworkPrefixes.detect(''), isNull);
    });
  });
}
