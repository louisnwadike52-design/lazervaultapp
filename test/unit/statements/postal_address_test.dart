import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/authentication/domain/entities/postal_address.dart';

void main() {
  group('PostalAddress.lines', () {
    // These must match the server renderer exactly (Go:
    // accounts-service postalAddressLines / auth-service
    // User.PostalAddressLines). If the app previews an address one way and the
    // PDF prints it another, the preview is worse than none.
    test('full address collapses locality onto one line', () {
      const a = PostalAddress(
        line1: '12 Adeola Odeku Street',
        line2: 'Flat 4B',
        city: 'Victoria Island',
        state: 'Lagos',
        postalCode: '101241',
        country: 'Nigeria',
      );
      expect(a.lines, [
        '12 Adeola Odeku Street',
        'Flat 4B',
        'Victoria Island, Lagos 101241',
        'Nigeria',
      ]);
      expect(a.singleLine,
          '12 Adeola Odeku Street, Flat 4B, Victoria Island, Lagos 101241, Nigeria');
    });

    test('no postcode leaves no trailing space', () {
      const a = PostalAddress(
        line1: '12 Adeola Odeku Street',
        city: 'Lagos',
        state: 'Lagos',
        country: 'Nigeria',
      );
      expect(a.lines, ['12 Adeola Odeku Street', 'Lagos, Lagos', 'Nigeria']);
    });

    test('postcode alone stands on its own line', () {
      const a = PostalAddress(line1: 'Plot 9', postalCode: '101241');
      expect(a.lines, ['Plot 9', '101241']);
    });

    test('city only — the common Nigerian case', () {
      const a = PostalAddress(line1: '12 Adeola Odeku Street', city: 'Lagos');
      expect(a.lines, ['12 Adeola Odeku Street', 'Lagos']);
    });

    test('whitespace-only fields are dropped, not printed as blank lines', () {
      const a = PostalAddress(
        line1: '12 Adeola Odeku Street',
        line2: '   ',
        city: ' ',
        state: '\t',
        country: '  ',
      );
      expect(a.lines, ['12 Adeola Odeku Street']);
    });

    test('values are trimmed', () {
      const a = PostalAddress(
        line1: '  12 Adeola Odeku Street  ',
        city: ' Lagos ',
        country: ' Nigeria ',
      );
      expect(a.lines, ['12 Adeola Odeku Street', 'Lagos', 'Nigeria']);
    });

    test('empty gives nothing at all', () {
      expect(PostalAddress.empty.lines, isEmpty);
      expect(PostalAddress.empty.singleLine, '');
    });
  });

  group('PostalAddress flags', () {
    test('line 1 alone counts as set — a partial address still prints', () {
      expect(const PostalAddress(line1: 'Plot 9').isSet, isTrue);
      expect(const PostalAddress(city: 'Lagos').isSet, isFalse);
      expect(PostalAddress.empty.isSet, isFalse);
    });

    test('isBlank sees through whitespace', () {
      expect(const PostalAddress(line1: '   ', city: '\t').isBlank, isTrue);
      expect(const PostalAddress(country: 'Nigeria').isBlank, isFalse);
    });
  });

  test('copyWith replaces only what is passed', () {
    const a = PostalAddress(line1: 'Plot 9', city: 'Lagos');
    final b = a.copyWith(city: 'Abuja');
    expect(b.line1, 'Plot 9');
    expect(b.city, 'Abuja');
    expect(a.city, 'Lagos', reason: 'the original must not be mutated');
  });
}
