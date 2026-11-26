import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/domain/pending_signup_identity.dart';

void main() {
  group('isIdentityInfrastructureFailure', () {
    test('our outage is never the customer\'s to fix', () {
      // PROVIDER_UNAVAILABLE is what the BVN branch answers for EVERY customer
      // until Mono enables the BVN Lookup product, so getting this wrong would
      // brick onboarding the moment an admin flips the branch on.
      expect(isIdentityInfrastructureFailure('PROVIDER_UNAVAILABLE'), isTrue);
      expect(isIdentityInfrastructureFailure('BANKING_SERVICE_ERROR'), isTrue);
      expect(isIdentityInfrastructureFailure('SERVICE_UNAVAILABLE'), isTrue);
      expect(isIdentityInfrastructureFailure('VERIFICATION_ERROR'), isTrue);
    });

    test('a refusal the customer CAN fix is theirs, and must stop them', () {
      // Waving these through would let an unchecked or someone else's number
      // past the gate.
      expect(isIdentityInfrastructureFailure('IDENTITY_DETAILS_MISMATCH'),
          isFalse);
      expect(isIdentityInfrastructureFailure('BVN_ALREADY_REGISTERED'), isFalse);
      expect(isIdentityInfrastructureFailure('NIN_ALREADY_REGISTERED'), isFalse);
      expect(isIdentityInfrastructureFailure('BVN_INVALID_FORMAT'), isFalse);
      expect(isIdentityInfrastructureFailure('NIN_INVALID_FORMAT'), isFalse);
    });

    test('an absent or unknown code is not treated as our outage', () {
      expect(isIdentityInfrastructureFailure(null), isFalse);
      expect(isIdentityInfrastructureFailure(''), isFalse);
      expect(isIdentityInfrastructureFailure('SOMETHING_NEW'), isFalse);
    });

    test('casing and padding do not change the answer', () {
      expect(isIdentityInfrastructureFailure('  provider_unavailable  '),
          isTrue);
      expect(isIdentityInfrastructureFailure('Provider_Unavailable'), isTrue);
    });
  });
}
