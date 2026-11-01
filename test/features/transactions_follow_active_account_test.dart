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
