import 'package:lazervault/core/cache/session_page_store.dart';

import '../../domain/entities/lock_fund_entity.dart';
import '../../domain/repositories/lock_funds_repository.dart';
import 'lock_funds_state.dart';

/// The lock-funds list and its statistics, remembered across opens.
///
/// WHY: `LockFundsCubit` is a FACTORY, so every open of the list started at
/// `LockFundsInitial`, emitted `LockFundsLoading`, and ran getLockFunds +
/// getStatistics back to back before anything could paint. The list screen
/// already kept its LAST result to survive a refresh — but that memory was
/// screen-local, so a re-entry still blinked. These stores outlive the screen
/// and the cubit, so the first paint on re-entry is the last answer and the
/// two RPCs refresh it behind.
///
/// The list and the statistics are two stores sharing one scope (the status
/// filter) because the screen paints them together: a list with a zeroed
/// stat strip would be its own blink.
///
/// In memory only — `LockFund` carries no JSON codec, so a cold start still
/// pays one loader. Per user (stamped) and cleared with every other
/// SessionPageStore on a user switch.
class LockFundsPageStore {
  LockFundsPageStore._();

  static final SessionPageStore<LockFund> list =
      SessionPageStore<LockFund>('lock_funds_list');

  /// One entry: the statistics the list was fetched alongside.
  static final SessionPageStore<LockFundsStatistics> statistics =
      SessionPageStore<LockFundsStatistics>('lock_funds_statistics');

  /// The store scope for a status filter ('' = every status).
  static String scopeFor(LockStatus? status) => status?.name ?? '';

  /// The exact map shape `LockFundsLoaded.statistics` has always carried.
  static Map<String, dynamic> statisticsMap(LockFundsStatistics s) => {
        'totalLockedAmount': s.totalLockedAmount,
        'totalAccruedInterest': s.totalAccruedInterest,
        'activeLocksCount': s.activeLocksCount,
        'totalCount': s.totalCount,
      };

  /// The remembered list + statistics as a paintable state, or null when
  /// either half is missing for this user and filter.
  static LockFundsLoaded? peek({required String userId, LockStatus? status}) {
    if (userId.isEmpty) return null;
    final scope = scopeFor(status);
    final rows = list.peek(userId: userId, scope: scope);
    final stats = statistics.peek(userId: userId, scope: scope);
    if (rows == null || stats == null || stats.isEmpty) return null;
    return LockFundsLoaded(
      lockFunds: rows,
      statistics: statisticsMap(stats.first),
    );
  }

  /// Remember a freshly loaded list and its statistics together.
  static void remember({
    required String userId,
    LockStatus? status,
    required List<LockFund> lockFunds,
    required LockFundsStatistics stats,
  }) {
    if (userId.isEmpty) return;
    final scope = scopeFor(status);
    list.put(lockFunds, userId: userId, scope: scope);
    statistics.put([stats], userId: userId, scope: scope);
  }
}
