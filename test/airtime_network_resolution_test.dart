import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/ng_network_prefixes.dart';

/// The receipt bug, pinned at the level the fix actually turns on.
///
/// A production airtime row read:
///   provider_id      = 02dd9d0f-c40b-4014-a7d5-08cd1feaedf5   (a UUID)
///   customer_number  = 07012406678                            (an Airtel line)
///   metadata         = {"operator_id": "AIRTEL", ...}
///
/// and the payment receipt displayed "MTN Nigeria". Two independent signals —
/// metadata.operator_id and the number's own prefix — both said Airtel, and
/// neither was consulted: a UUID matches none of the network substrings, so
/// resolution fell straight to a hardcoded mtn default.
void main() {
  group('NCC prefix allocation', () {
    test('identifies the line from the receipt as Airtel, not MTN', () {
      expect(NgNetworkPrefixes.detect('07012406678'), 'airtel');
      expect(NgNetworkPrefixes.detect('+2347012406678'), 'airtel');
      expect(NgNetworkPrefixes.detect('2347012406678'), 'airtel');
    });

    test('covers every carrier across dialling forms', () {
      expect(NgNetworkPrefixes.detect('08031234567'), 'mtn');
      expect(NgNetworkPrefixes.detect('07067334850'), 'mtn');
      expect(NgNetworkPrefixes.detect('08021234567'), 'airtel');
      expect(NgNetworkPrefixes.detect('08051234567'), 'glo');
      expect(NgNetworkPrefixes.detect('08091234567'), 'etisalat');
    });

    test('0801 is Airtel — it was mis-filed under MTN in an older copy', () {
      expect(NgNetworkPrefixes.detect('08011234567'), 'airtel');
    });

    test('returns null rather than guessing for unallocated prefixes', () {
      expect(NgNetworkPrefixes.detect('01234567890'), isNull);
      expect(NgNetworkPrefixes.detect(''), isNull);
      expect(NgNetworkPrefixes.detect('12'), isNull);
    });

    test('does not claim a Nigerian carrier for foreign numbers', () {
      // South Africa, Ghana, US — none should resolve to an NG carrier.
      expect(NgNetworkPrefixes.detect('+27831234567'), isNull);
      expect(NgNetworkPrefixes.detect('+233241234567'), isNull);
      expect(NgNetworkPrefixes.detect('+17035551234'), isNull);
    });
  });
}
