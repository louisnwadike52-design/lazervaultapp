import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/data/services/bvn_lookup_http_service.dart';

void main() {
  group('BvnLookupResult classification', () {
    test('an outage is OURS — never a reason to block onboarding', () {
      // This screen is a gate with no skip, so misclassifying a provider blip
      // would end onboarding for every customer while it lasted.
      expect(
        const BvnLookupResult(ok: false, code: 'PROVIDER_UNAVAILABLE')
            .infrastructure,
        isTrue,
      );
      expect(
        const BvnLookupResult(ok: false, code: 'BANKING_SERVICE_ERROR')
            .infrastructure,
        isTrue,
      );
    });

    test('a refusal the customer owns is NOT an outage', () {
      for (final code in [
        'BVN_INVALID_FORMAT',
        'INVALID_OTP',
        'IDENTITY_DOB_MISMATCH',
        'BVN_ALREADY_REGISTERED',
      ]) {
        expect(BvnLookupResult(ok: false, code: code).infrastructure, isFalse,
            reason: '$code must not wave the customer through');
      }
    });

    test('an expired session is distinct — it needs a restart, not a retry', () {
      const r = BvnLookupResult(ok: false, code: 'SESSION_EXPIRED');
      expect(r.sessionExpired, isTrue);
      // It must NOT be treated as an outage: letting them through unverified
      // on a timeout would skip the check entirely.
      expect(r.infrastructure, isFalse);
    });

    test('an already-registered BVN is its own terminal case', () {
      const r = BvnLookupResult(ok: false, code: 'BVN_ALREADY_REGISTERED');
      expect(r.alreadyRegistered, isTrue);
      expect(r.infrastructure, isFalse);
      expect(r.sessionExpired, isFalse);
    });

    test('an unknown code is not silently treated as our problem', () {
      const r = BvnLookupResult(ok: false, code: 'SOMETHING_NEW');
      expect(r.infrastructure, isFalse);
      expect(r.sessionExpired, isFalse);
      expect(r.alreadyRegistered, isFalse);
    });
  });

  group('BvnLookupMethod labels', () {
    test('every method Mono can return has a readable label', () {
      expect(const BvnLookupMethod(method: 'email', hint: '').label, 'Email');
      expect(
          const BvnLookupMethod(method: 'phone', hint: '').label, 'Text message');
      expect(const BvnLookupMethod(method: 'alternate_phone', hint: '').label,
          'Alternate phone');
    });

    test('an unrecognised method falls back to its raw name, not a blank', () {
      // Mono may add routes. A blank tile would be untappable-looking and
      // unexplainable; the raw name is at least honest.
      expect(const BvnLookupMethod(method: 'whatsapp', hint: '').label,
          'whatsapp');
    });
  });
}
