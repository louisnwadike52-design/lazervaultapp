import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/kyc/presentation/views/bvn_signup_screen.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';

void main() {
  group('IdentityKind', () {
    test('each kind asks for its own ID type — never both, never crossed', () {
      expect(IdentityKind.bvn.idType, IDType.bvn);
      expect(IdentityKind.nin.idType, IDType.nin);
    });

    test('isBvn is the single branch predicate', () {
      expect(IdentityKind.bvn.isBvn, isTrue);
      expect(IdentityKind.nin.isBvn, isFalse);
    });

    test('labels are what the customer is actually asked for', () {
      expect(IdentityKind.bvn.label, 'BVN');
      expect(IdentityKind.nin.label, 'NIN');
    });

    test('the two kinds report distinct analytics scopes', () {
      // They land in the same funnel otherwise, and the whole point of the
      // admin switch is being able to compare the two branches.
      expect(IdentityKind.bvn.analyticsScope,
          isNot(equals(IdentityKind.nin.analyticsScope)));
    });

    test('there are exactly two — a third would need a routing decision', () {
      expect(IdentityKind.values.length, 2);
    });
  });
}
