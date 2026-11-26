import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// One dialog for an account-number change, naming the account that moved.
///
/// Two reports, same screen:
///
///   * "Do not have a different dialog box for each of them." Two services speak
///     during a virtual-account provider migration — the broadcast announcement
///     and the per-user number change — and the dashboard fired both in the same
///     post-frame callback with no coordination, so they stacked.
///   * "Also add the name of the family and friend account as we can have
///     multiple of it." The modal labelled every account with
///     AccountSummaryEntity.displayName, which is the account TYPE. So a user
///     with three family accounts was told "Family & Friends" changed, with no
///     way to tell which.
///
/// The watcher itself already gathered all changes into ONE modal — that part was
/// right, and the test below pins it so a later edit does not turn it back into a
/// modal per account.
void main() {
  group('the watcher shows one modal for all changes', () {
    late String source;

    setUpAll(() {
      final file = File('lib/core/services/account_number_change_watcher.dart');
      expect(file.existsSync(), isTrue,
          reason: 'account_number_change_watcher.dart moved');
      source = file.readAsStringSync();
    });

    test('changes are collected then shown once, not shown per account', () {
      // The loop must ADD to a list; the modal call must be outside it.
      expect(source, contains('changes.add(_AccountNumberChange('));
      expect(source, contains('await _showModal(context, changes)'));
      // A single _showModal call site is the whole guarantee.
      expect('_showModal(context, changes)'.allMatches(source).length, 1);
    });

    test('a family account is named by ITS name, not by its type', () {
      expect(source, contains('_labelFor(a)'),
          reason: 'displayName is the account TYPE, so three family accounts '
              'all reported as "Family & Friends"');
      expect(source, contains('VirtualAccountType.family'));
      expect(source, contains("a.accountLabel ?? ''"),
          reason: 'the backend fills accountLabel with the FAMILY name for '
              'family accounts, which is what the carousel titles the card with');
    });

    test('it falls back to a truthful label rather than an empty one', () {
      expect(source, contains("return 'Family & Friends';"));
    });

    test('it reports whether it showed, so the caller can stand down', () {
      expect(source, contains('Future<bool> check('));
      expect(source, contains('return true;'));
    });

    test('a failure still returns a value rather than throwing', () {
      // This runs on the dashboard's first frame; an exception escaping here
      // would take the dashboard with it.
      expect(source, contains('return false;'));
    });
  });

  group('the dashboard shows at most one of the two', () {
    late String source;

    setUpAll(() {
      final file = File('lib/src/features/widgets/dashboard/dashboard.dart');
      expect(file.existsSync(), isTrue);
      source = file.readAsStringSync();
    });

    test('the specific change is reported first', () {
      // It names the accounts and shows real old/new numbers, where the
      // broadcast is generic admin copy — so it wins when both have something
      // to say.
      final specific = source.indexOf('_announceAccountNumberChanges(');
      final broadcast =
          source.indexOf('AccountUpdateAnnouncementService.instance');
      expect(specific, greaterThan(-1));
      expect(broadcast, greaterThan(-1));
      expect(specific, lessThan(broadcast),
          reason: 'the informative dialog must get first refusal');
    });

    test('the broadcast is skipped when the specific one showed', () {
      // There are THREE modals in this callback now — the per-user account
      // change, the broadcast announcement, and the identity-verification
      // prompt — so pinning one exact line of source no longer describes the
      // invariant. What must hold is that the broadcast is CONDITIONAL on the
      // specific one not having shown.
      expect(source, contains('reportedSpecificChange'),
          reason: 'the broadcast must know whether the specific one showed');
      expect(source, contains('if (!reportedSpecificChange) {'),
          reason: 'without this both fire and the modals stack');
    });

    test('every modal in the chain is awaited before the next is offered', () {
      // The coordination only works if each modal is awaited. A forgotten
      // `await` lets the next one open on top of the one still on screen,
      // which is the exact failure the ordering above exists to prevent.
      expect(source, contains('await AccountUpdateAnnouncementService.instance'),
          reason: 'the broadcast must be awaited, or the KYC prompt stacks on it');
      // The KYC prompt is NO LONGER IN THIS CHAIN (removed 2026-11-10), so
      // there is nothing here to await. It fired on arrival at the dashboard
      // — the one moment it cannot be acted on, because the customer has just
      // finished signing up and has not tried to do anything yet. It now
      // appears where the limit is actually met (send funds, batch transfer,
      // PiggyVault all show KYCUpgradeModal on a tier-cap refusal), and below
      // Tier 2 the dashboard is not reachable at all.
      expect(source, isNot(contains('KycLoginPrompt.maybeShow(')),
          reason: 'identity verification is prompted at the point of use, '
              'not on arrival at the dashboard');
    });

    test('no modal in the chain navigates the user away', () {
      // This used to assert that identity verification came LAST, because it
      // was the only one of the three that could route somewhere else and so
      // must not pre-empt the two that merely inform.
      //
      // It is no longer in the chain at all, which removes the hazard rather
      // than ordering around it: every remaining modal is informational, so
      // none can steal the user mid-chain. Asserting its ABSENCE keeps the
      // property — re-adding a navigating modal here would fail this test.
      expect(source, isNot(contains('KycLoginPrompt.maybeShow(')));
      final broadcast =
          source.indexOf('AccountUpdateAnnouncementService.instance');
      expect(broadcast, greaterThan(-1),
          reason: 'the balance-change broadcast is still part of the chain');
    });

    test('the callback awaits, or the guard cannot work', () {
      // A synchronous callback could not have waited for the watcher's answer.
      expect(source, contains('addPostFrameCallback((_) async {'));
    });
  });
}
