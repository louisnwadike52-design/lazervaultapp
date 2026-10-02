import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// Two cards both titled "Personal".
///
/// A user's dashboard showed his real personal wallet (••••8852, ₦21.34) AND
/// his crowdfund CAMPAIGN wallet (••••3589, ₦81.00), both labelled "Personal".
/// VirtualAccountType had no `campaign` member, and fromString's default was:
///
///     default: return VirtualAccountType.personal;
///
/// So an unmapped backend type did not merely get a wrong label — it became a
/// specific, spendable wallet type with its own feature gates. isPersonalAccount
/// returned true for a campaign wallet, and anything keyed off "is this
/// personal" (the dashboard's personal-only sections, send-funds source rules)
/// treated it as one.
///
/// The failure was silent in both directions: nothing logged, and the wrong
/// answer looked entirely plausible.
void main() {
  group('every backend account type maps to itself', () {
    const cases = <String, VirtualAccountType>{
      'personal': VirtualAccountType.personal,
      'savings': VirtualAccountType.savings,
      'business': VirtualAccountType.business,
      'family': VirtualAccountType.family,
      'investment': VirtualAccountType.investment,
      'campaign': VirtualAccountType.campaign,
    };
    cases.forEach((raw, want) {
      test('"$raw" → $want', () {
        expect(VirtualAccountType.fromString(raw), want);
        expect(VirtualAccountType.fromString(raw.toUpperCase()), want);
      });
    });
  });

  test('a campaign wallet is NOT labelled Personal', () {
    final t = VirtualAccountType.fromString('campaign');
    expect(t.displayName, 'Campaign');
    expect(t, isNot(VirtualAccountType.personal),
        reason: 'this is the reported bug: two cards both reading "Personal"');
  });

  test('a campaign wallet does not inherit personal-only behaviour', () {
    expect(VirtualAccountType.fromString('campaign') == VirtualAccountType.personal,
        isFalse,
        reason: 'isPersonalAccount gates real features; a campaign wallet '
            'passing that check grants it rules it should not have');
  });

  test('an UNKNOWN type does not impersonate a personal wallet', () {
    for (final raw in ['', 'escrow', 'something_new_2027', 'pool']) {
      final t = VirtualAccountType.fromString(raw);
      expect(t, VirtualAccountType.unknown, reason: '"$raw" should be unknown');
      expect(t, isNot(VirtualAccountType.personal),
          reason: 'guessing `personal` for a type we cannot name is how the '
              'campaign wallet became a personal one');
      expect(t.displayName, 'Account');
    }
  });
}
