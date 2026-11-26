import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// A dollar account showed a $0.00 balance, "Deposits open soon", and a list
/// of Naira transfers underneath it. Same on GBP.
///
/// The transaction list was never the bug. The ledger query is scoped by
/// `account_id` AND `locale` on the backend, and the client passes both. What
/// nothing did was MOVE the active account when the user switched region.
///
/// `_autoSelectPersonalAccount` returned early whenever the held account was
/// still present in the summaries — which it always is; the Naira account does
/// not disappear because you tapped the US flag. The services grid re-filtered
/// (it listens to the currency stream), the balance card re-rendered, and
/// `activeAccountId` kept pointing at the Naira account. Every account-scoped
/// fetch in the app then asked for the wrong account under a header that said
/// otherwise.
///
/// Source assertions: both invariants are "which guard is written", a property
/// of the source, and reproducing them needs the DI graph plus a live gRPC
/// channel.
void main() {
  String read(String p) {
    final f = File(p);
    expect(f.existsSync(), isTrue, reason: '$p moved — repoint this test');
    return f.readAsStringSync();
  }

  String code(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  group('the active account follows the region', () {
    const path =
        'lib/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';

    test('a region change re-runs the account selection', () {
      final src = code(read(path));
      expect(src.contains('_localeManager.currencyStream'), isTrue,
          reason: 'nothing re-selects the active account when the currency '
              'changes, so switching region leaves every account-scoped fetch '
              'pointed at the previous currency\'s account');
      expect(src.contains('_autoSelectPersonalAccount(_currentSummaries)'),
          isTrue,
          reason: 'the currency listener no longer re-runs the selection');
      // Currency, not country: two regions can share a currency and there is
      // nothing to re-select then.
      expect(src.contains('.distinct()'), isTrue,
          reason: 'without distinct() a re-emitted identical currency churns '
              'the active account and refetches the whole dashboard');
    });

    test('the subscription is cancelled with the cubit', () {
      final src = code(read(path));
      expect(src.contains('_currencySubscription?.cancel()'), isTrue,
          reason: 'this cubit is a factory registration — instances are built '
              'and closed all day, and a live listener keeps every one of them '
              'alive and emitting after close');
    });

    test('keeping the current selection requires a currency match', () {
      final src = code(read(path));
      expect(src.contains('_sameCurrency(held.currency, expectedCurrency)'),
          isTrue,
          reason: 'the early return is back to "is it still in the list", '
              'which is always true — the Naira account does not disappear '
              'because the user tapped the US flag');
      // Compared case-insensitively: the summaries come from a gRPC read AND
      // a cached SharedPreferences copy, and only one normalises the code.
      // An exact == quietly fails the match and sends the selection down the
      // no-wallet path.
      expect(src.contains('a.trim().toUpperCase() == b.trim().toUpperCase()'),
          isTrue,
          reason: 'currency comparison is case-sensitive again');
    });

    test('no wallet in that currency keeps the current account', () {
      // The narrower version of the same bug. This used to fall back to
      // `summaries.first` — normally the Naira account — so switching to a
      // region the user has no wallet for re-created the dollar-header-over-
      // Naira-data defect that this whole method was fixed for.
      final src = code(read(path));
      expect(src.contains('keeping the current account rather than switching'),
          isTrue,
          reason: 'the no-wallet path churns the active account again');
      expect(src.contains('summaries.first'), isTrue,
          reason: 'first load still needs SOMETHING selected — only the '
              'already-have-a-selection case should keep what it has');
    });
  });

  test('no transaction row in another currency reaches the list', () {
    // Belt and braces for the one path account scoping alone does not cover:
    // the core-payments external-transfer supplement is merged by account_id
    // and has no locale column to filter on.
    const path =
        'lib/src/features/transaction_history/data/repository/transaction_history_repository_grpc.dart';
    final src = code(read(path));
    expect(src.contains('tx.currency == pageCurrency'), isTrue,
        reason: 'the currency guard is gone, so the external-transfer merge '
            'can put a Naira row under a dollar account again');
    // Never filter on a guess: a slow summary load must not blank a correct
    // list, and a row that carries no currency is not evidence of a mismatch.
    expect(src.contains('pageCurrency != null && pageCurrency.isNotEmpty'),
        isTrue,
        reason: 'the guard must not run on an unknown account currency');
    expect(src.contains('tx.currency.isEmpty ||'), isTrue,
        reason: 'a row with no currency must be kept, not dropped');
  });

  group('switching region and back leaves one consistent account', () {
    // The follow-up report: "switching from one currency and back to NGN
    // messes things up — it goes to personal account, and quick services and
    // transaction history on switch of locales." One screen showed three
    // different answers at once: a Personal Naira card in the carousel, a
    // "Family Services" quick-services grid, and "Could not load
    // transactions". Four independent defects, all reachable from one tap.
    const cubit =
        'lib/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
    const carousel =
        'lib/src/features/account_cards_summary/presentation/widgets/account_carousel.dart';
    const grid = 'lib/src/features/widgets/app_services_builder.dart';
    const history =
        'lib/src/features/transaction_history/presentation/cubit/transaction_history_cubit.dart';

    test('the selection sets a SPENDABLE id, never a family group id', () {
      final src = code(read(cubit));
      expect(src.contains('setActiveAccount(chosen.spendingAccountId)'), isTrue,
          reason: 'a family row\'s `id` is the GROUP id, which is not a row '
              'in accounts.accounts — selecting it makes authorizeAccountRead '
              'refuse every account-scoped read ("Could not load '
              'transactions") while the services grid still resolves that id '
              'back to the family summary and renders "Family Services"');
      expect(src.contains('setActiveAccount(chosen.id)'), isFalse,
          reason: 'the row id is back');
    });

    test('`main` counts as personal when choosing a wallet', () {
      final src = code(read(cubit));
      expect(src.contains('VirtualAccountType.main'), isTrue,
          reason: 'accountType is the NORMALISED display value, so a Main '
              'wallet never equals the string "personal" — it fell through to '
              'the any-account branch and the user got their SAVINGS account '
              'auto-selected on every region switch');
      expect(src.contains("accountType.toLowerCase() == 'personal'"), isFalse,
          reason: 'the stringly-typed compare is back');
    });

    test('shared and campaign wallets are never chosen for the user', () {
      final src = code(read(cubit));
      expect(src.contains('static bool _autoSelectable('), isTrue,
          reason: 'the any-account-in-this-currency fallback is unrestricted '
              'again, so it can put the user on a family pot or a crowdfund '
              'campaign wallet without them tapping anything');
      expect(src.contains('VirtualAccountType.campaign'), isTrue,
          reason: 'a campaign wallet holds other people\'s contributions');
      expect(src.contains('_autoSelectable(acc) &&'), isTrue,
          reason: 'the currency fallback no longer consults it');
      expect(src.contains('summaries.firstWhere(_autoSelectable'), isTrue,
          reason: 'the first-load fallback no longer consults it');
    });

    test('the selection is made from the SAME order the carousel renders', () {
      final src = code(read(cubit));
      expect(src.contains('_autoSelectPersonalAccount(sorted)'), isTrue,
          reason: 'handing the selector the unsorted response makes its '
              '"first account in this currency" tie-break depend on backend '
              'row order, so a refresh and a region switch can disagree');
      expect(src.contains('_autoSelectPersonalAccount(summaries)'), isFalse,
          reason: 'the raw list is back');
    });

    test('the auto-select mirrors the frozen/family flags', () {
      final src = code(read(cubit));
      for (final call in [
        'setActiveAccountFrozen(chosen.isFrozen)',
        'isFamily: chosen.isFamilyAccount',
      ]) {
        expect(src.contains(call), isTrue,
            reason: '$call is gone — these are plain fields on AccountManager '
                'read by the frozen-account guard in openAppService and by '
                'refusal dialogs, and only the carousel kept them current, so '
                'after a region switch they described the previous account');
      }
    });

    test('the carousel follows an active account chosen elsewhere', () {
      final src = code(read(carousel));
      expect(src.contains('accountIdStream.listen(_followActive)'), isTrue,
          reason: 'initialPage only applies to the slider\'s FIRST build, so '
              'without this the card on screen and the account every other '
              'surface is reading stay diverged after a region switch');
      expect(src.contains('_activeAccountSub?.cancel()'), isTrue,
          reason: 'the subscription outlives the carousel');
      expect(src.contains('carouselController: _carouselController'), isTrue,
          reason: 'the slider cannot be driven without its controller');
      // Not corrected to card 0 either: mid-refresh the rows and the selection
      // genuinely disagree for a frame.
      expect(src.contains('if (index < 0 || index == _currentIndex)'), isTrue,
          reason: 'an unresolvable id must not snap the user to another card');
    });

    test('the services grid re-resolves on a currency change', () {
      final src = code(read(grid));
      // Three call sites: initState, the account-id listener, and the
      // currency listener. The currency one was a bare setState.
      expect('_checkActiveAccountType()'.allMatches(src).length >= 3, isTrue,
          reason: '_activeAccountType is a cached field only '
              '_checkActiveAccountType writes, so a bare setState re-filtered '
              'the grid for the new currency while still building it from the '
              'PREVIOUS account\'s service list');
    });

    test('the grid never invents an account type it cannot resolve', () {
      final src = code(read(grid));
      expect(src.contains('if (_activeAccountType != null) return;'), isTrue,
          reason: 'falling back to summaries.first does not RESOLVE the active '
              'account, it invents one — and then offers the service set of a '
              'wallet the user is not on');
      expect(src.contains('orElse: () => summaries.first,'), isFalse,
          reason: 'the inventing fallback is back');
    });

    test('a stale transaction response cannot win the race', () {
      final src = code(read(history));
      expect(src.contains('int _beginListLoad()'), isTrue,
          reason: 'one singleton cubit, two listeners (account + country) and '
              'LocaleManager emits country BEFORE currency — so a region '
              'switch fires a fetch with the OUTGOING account id and another '
              'with the incoming one, and whichever answered last won');
      expect(src.contains('generation != _listGeneration) return'), isTrue,
          reason: 'the guard no longer drops stale emits');
      // The visible symptom of losing that race was a sticky error sitting on
      // top of data that had loaded fine.
      // Every list-replacing path emits through the guard. The one remaining
      // bare emit is loadStatistics', and it is now guarded differently — a
      // stats failure returns rather than blanking a populated list.
      expect('emit(TransactionHistoryError('.allMatches(src).length, 1,
          reason: 'an ungated error emit can still clobber a newer success');
      expect(src.contains('if (state is TransactionHistoryLoaded) return;'),
          isTrue,
          reason: 'a statistics failure blanks the transaction list again');
    });

    test('a region switch issues ONE transaction fetch, not two', () {
      final src = code(read('lib/src/features/widgets/recent_history.dart'));
      expect(src.contains('_scheduleReload()'), isTrue,
          reason: 'the account and country listeners each fired their own '
              'fetch, and the country one asks for the account the user has '
              'just left — the request most likely to fail');
      expect(src.contains('_reloadDebounce?.cancel()'), isTrue,
          reason: 'the timer outlives the widget');
    });
  });

  test('both the dashboard list and View All go through that repository', () {
    // The fix only holds if there is ONE fetch path. A screen that calls gRPC
    // directly would bypass every guard above.
    for (final p in [
      'lib/src/features/widgets/recent_history.dart',
      'lib/src/features/transaction_history/presentation/screens/dashboard_transaction_history_screen.dart',
    ]) {
      final src = code(read(p));
      expect(src.contains('loadAllTransactions'), isTrue,
          reason: '$p no longer loads through TransactionHistoryCubit, so it '
              'does not get the account/currency scoping');
    }
  });
}
