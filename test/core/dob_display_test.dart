import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/dob_display.dart';

/// A DATE OF BIRTH MUST READ THE SAME TO EVERYONE.
///
/// THE CASE, 2026-11-12. A customer's profile held `1999-07-09` and her BVN
/// record held `1999-09-07`. Every screen showed her the ISO string — which
/// is 9 July to a day/month reader and 7 September to a month/day one — so
/// the one fact that would have explained the refusal was displayed in the
/// one format that could not express it. She re-submitted the same date
/// against a three-attempt cap and could not get past it.
void main() {
  test('the month is spelled out, so the order cannot be misread', () {
    expect(humanDob(DateTime(1999, 7, 9)), '9 July 1999');
    expect(humanDob(DateTime(1999, 9, 7)), '7 September 1999');
  });

  test('the two dates that were confused are now plainly different', () {
    final profile = humanDobFromIso('1999-07-09');
    final registry = humanDobFromIso('1999-09-07');
    expect(profile, '9 July 1999');
    expect(registry, '7 September 1999');
    expect(profile == registry, isFalse,
        reason: 'these read identically in ISO to a reader using the other '
            'convention — that ambiguity is the bug');
  });

  test('the wire format is unchanged — ISO still goes to the registry', () {
    expect(isoDob(DateTime(1999, 7, 9)), '1999-07-09');
    expect(isoDob(DateTime(2001, 12, 31)), '2001-12-31');
    // Zero padding matters: an unpadded month is rejected by the parsers on
    // the other side of this.
    expect(isoDob(DateTime(1999, 1, 2)), '1999-01-02');
  });

  test('an unparseable value is shown as-is, never blanked', () {
    expect(humanDobFromIso(null), '');
    expect(humanDobFromIso(''), '');
    expect(humanDobFromIso('not a date'), 'not a date',
        reason: 'showing a raw value beats showing nothing — a blank field '
            'reads as "we lost it"');
  });

  test('the hint names the ORDER and gives an example', () {
    expect(dobFormatHint.toLowerCase(), contains('day'));
    expect(dobFormatHint.toLowerCase(), contains('month'));
    expect(dobFormatHint, contains('9 July 1999'));
  });
}
