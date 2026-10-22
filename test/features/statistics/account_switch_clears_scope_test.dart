import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/core/grpc/accounts_grpc_client.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/data/financial_analytics_repository.dart';

/// StatisticsCubit is a lazy SINGLETON, so it outlives a session.
///
/// Reported 2026-10-22: an account switch on one phone (Praiz → Chris) left the
/// previous user's account ids in `_availableWallets`, and the statistics
/// screen fans out one analytics call per wallet in that list. Every call went
/// out for somebody else's accounts, accounts-service refused all of them —
///
///     PermissionDenied: account does not belong to user
///
/// — and the page never loaded. The server was right to refuse; the stale
/// client cache was the fault.
///
/// The screen sets `userId` and calls `loadStatistics()` in the same
/// expression, with `loadWallets()` only afterwards, so the first load ALWAYS
/// runs against whatever list was already there. That is why the fix hangs off
/// the userId setter rather than off a refresh: by the time a refresh could
/// correct the list, the wrong requests have gone.
class _FakeGrpc extends Mock implements AccountsGrpcClient {}

void main() {
  late StatisticsCubit cubit;

  StatisticsWallet wallet(String id) => StatisticsWallet(
        id: id,
        name: 'Wallet $id',
        accountType: 'personal',
        currency: 'NGN',
        balance: 0,
        maskedAccountNumber: '••••0000',
      );

  setUp(() {
    cubit = StatisticsCubit(
      analyticsRepository: FinancialAnalyticsRepository(
        grpcClient: _FakeGrpc(),
        accountManager: AccountManager(),
        localeManager: LocaleManager(),
      ),
    );
  });

  tearDown(() async => cubit.close());

  test('switching to a different user drops the previous user\'s wallet ids',
      () {
    cubit.userId = 'praiz';
    cubit.setAvailableWalletsForTest([wallet('praiz-acct-1')]);
    cubit.changeWalletsForTest(['praiz-acct-1']);
    expect(cubit.availableWallets, isNotEmpty);

    cubit.userId = 'chris';

    expect(cubit.availableWallets, isEmpty,
        reason: 'the next load fans out over availableWallets; leaving Praiz '
            'ids here is what produced PermissionDenied on every call');
    expect(cubit.selectedWalletIds, isEmpty,
        reason: 'a scope pinned to another user\'s wallet is not a scope');
  });

  test('the linked-bank scope is dropped too', () {
    cubit.userId = 'praiz';
    cubit.changeBanksForTest(['praiz-bank-1']);
    expect(cubit.selectedBankAccountIds, isNotEmpty);

    cubit.userId = 'chris';

    expect(cubit.selectedBankAccountIds, isEmpty,
        reason: 'linked banks belong to the user who linked them');
  });

  test('re-setting the SAME user keeps the scope', () {
    cubit.userId = 'chris';
    cubit.setAvailableWalletsForTest([wallet('chris-acct-1')]);
    cubit.changeWalletsForTest(['chris-acct-1']);

    cubit.userId = 'chris';

    expect(cubit.availableWallets, isNotEmpty,
        reason: 'navigating back to the page must not reset a scope the user '
            'deliberately chose');
    expect(cubit.selectedWalletIds, ['chris-acct-1']);
  });

  test('clearOnLogout drops the wallet ids, not only the state', () {
    cubit.userId = 'praiz';
    cubit.setAvailableWalletsForTest([wallet('praiz-acct-1')]);
    cubit.changeWalletsForTest(['praiz-acct-1']);

    cubit.clearOnLogout();

    expect(cubit.state, isA<StatisticsInitial>());
    expect(cubit.availableWallets, isEmpty,
        reason: 'this method used to emit StatisticsInitial and stop, which '
            'cleared the screen but left the ids the next load would use');
    expect(cubit.selectedWalletIds, isEmpty);
  });
}
