import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/widgets/dashboard/active_account_scope.dart';

AccountSummaryEntity _acct(
  String id,
  String type, {
  String currency = 'NGN',
  bool family = false,
}) =>
    AccountSummaryEntity(
      id: id,
      accountType: type,
      currency: currency,
      balance: 0,
      accountNumberLast4: '0000',
      trendPercentage: 0,
      isFamilyAccount: family,
    );

void main() {
  // The reported bug, twice: with a Savings account active, Trending
  // crowdfunds and Public groups stayed on the dashboard. Both are
  // NGN-denominated communal pots that only a personal wallet can join.
  test('a savings account is NOT personal', () {
    final summaries = [
      _acct('personal-1', 'personal'),
      _acct('savings-1', 'savings'),
    ];
    expect(activeAccountIsPersonalNow(summaries, 'savings-1'), isFalse);
    expect(activeAccountIsPersonalNow(summaries, 'personal-1'), isTrue);
  });

  test('no other account type passes either', () {
    for (final t in ['savings', 'investment', 'business', 'family']) {
      final summaries = [_acct('a', t)];
      expect(activeAccountIsPersonalNow(summaries, 'a'), isFalse,
          reason: '$t must not show the communal rails');
    }
  });

  test('main counts as personal — it is the same wallet under an older name',
      () {
    expect(activeAccountIsPersonalNow([_acct('a', 'main')], 'a'), isTrue);
  });

  // A family pot can arrive with a non-family accountTypeEnum on some
  // payloads, so the explicit flag has to be checked rather than trusted to
  // the enum alone.
  test('the family flag beats the type string', () {
    final summaries = [_acct('fam', 'personal', family: true)];
    expect(activeAccountIsPersonalNow(summaries, 'fam'), isFalse);
  });

  group('fails closed rather than guessing', () {
    test('summaries not loaded yet', () {
      expect(activeAccountIsPersonalNow(null, 'a'), isFalse);
      expect(activeAccountIsPersonalNow([], 'a'), isFalse);
    });

    test('no active account id', () {
      final summaries = [_acct('a', 'personal')];
      expect(activeAccountIsPersonalNow(summaries, null), isFalse);
      expect(activeAccountIsPersonalNow(summaries, ''), isFalse);
    });

    // A stale id that matches nothing on screen must not resolve to the
    // first account in the list.
    test('an id that matches no account', () {
      final summaries = [_acct('a', 'personal'), _acct('b', 'savings')];
      expect(activeAccountIsPersonalNow(summaries, 'gone'), isFalse);
    });
  });

  // The whole reason this function exists rather than reading a cached type:
  // it must be correct the instant it is called, with whatever is active.
  test('switching accounts flips the answer immediately', () {
    final summaries = [
      _acct('personal-1', 'personal'),
      _acct('savings-1', 'savings'),
      _acct('business-1', 'business'),
    ];
    expect(activeAccountIsPersonalNow(summaries, 'personal-1'), isTrue);
    expect(activeAccountIsPersonalNow(summaries, 'savings-1'), isFalse);
    expect(activeAccountIsPersonalNow(summaries, 'business-1'), isFalse);
    expect(activeAccountIsPersonalNow(summaries, 'personal-1'), isTrue);
  });
}
