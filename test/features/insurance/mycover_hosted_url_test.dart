import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/insurance/presentation/widgets/mycover_hosted_url.dart';

// Mirrors the Go composeMyCoverHostedEntryURL test: the Buy/Manage URL must
// carry identity params (email/phone/client_reference=LV-<id>) INSIDE the
// hash so MyCover's hash-routed SPA reads them and the resulting purchase
// can be tied back to the LazerVault user.
void main() {
  const base = 'https://s.mycover.ai/#XIDgIDGGWV';

  group('MyCoverHostedUrl.compose', () {
    test('appends identity params inside the hash', () {
      final got = MyCoverHostedUrl.compose(
        base: base,
        email: 'user@example.com',
        phone: '+2348012345678',
        userId: 'abc-123',
      );
      expect(got, isNotNull);
      expect(got!.startsWith('https://s.mycover.ai/#XIDgIDGGWV'), isTrue);

      final hashAt = got.indexOf('#');
      final beforeHash = got.substring(0, hashAt);
      expect(beforeHash.contains('email'), isFalse,
          reason: 'params must not leak before the hash');
      expect(beforeHash.contains('client_reference'), isFalse);

      expect(got.contains('email=user%40example.com'), isTrue);
      expect(got.contains('phone=%2B2348012345678'), isTrue);
      expect(got.contains('client_reference=LV-abc-123'), isTrue);
    });

    test('returns bare base when no identity params', () {
      expect(MyCoverHostedUrl.compose(base: base), base);
    });

    test('returns null when base is empty', () {
      expect(MyCoverHostedUrl.compose(base: '', email: 'u@e.com'), isNull);
    });

    test('client_reference omitted when userId empty', () {
      final got = MyCoverHostedUrl.compose(base: base, email: 'u@e.com');
      expect(got!.contains('client_reference'), isFalse);
    });

    test('fragment already with ? uses &', () {
      final got = MyCoverHostedUrl.compose(base: '$base?x=9', userId: 'u1');
      expect(got, 'https://s.mycover.ai/#XIDgIDGGWV?x=9&client_reference=LV-u1');
    });
  });
}
