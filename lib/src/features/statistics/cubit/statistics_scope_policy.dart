import 'package:flutter/foundation.dart';

import 'statistics_state.dart';

/// WHEN THE STATISTICS TAB MAY PAINT WHAT IT ALREADY HOLDS.
///
/// `StatisticsCubit` is a lazy singleton, so its figures survive leaving the
/// tab. Re-entering used to flip `isRefreshing` on and the screen read that
/// flag as "show the skeleton" — so a page the user looked at a minute ago was
/// torn down to a shimmer while the SAME scope was re-fetched.
///
/// `isRefreshing` means two different things and only one of them deserves a
/// skeleton:
///   * the user switched source / bank / wallet / period — the held figures
///     are for ANOTHER scope and painting them under the new tab would lie;
///   * the same scope is being refreshed (re-entry, pull-to-refresh) — the held
///     figures are the right answer until fresher ones land.
///
/// These helpers tell the two apart by comparing the scope a loaded state was
/// fetched for against the scope the cubit is on now.
bool statisticsLoadedForScope(
  StatisticsState state, {
  required StatisticsSource source,
  required List<String> bankAccountIds,
  required List<String> walletIds,
  required String period,
}) {
  if (state is! StatisticsLoaded) return false;
  return state.source == source &&
      state.currentPeriod == period &&
      setEquals(state.selectedBankAccountIds.toSet(), bankAccountIds.toSet()) &&
      setEquals(state.selectedWalletIds.toSet(), walletIds.toSet());
}

/// True when the metric region has nothing honest to show for the current
/// scope: nothing loaded yet, or a scope switch whose figures are not in.
bool statisticsShowSkeleton(
  StatisticsState state, {
  required StatisticsSource source,
  required List<String> bankAccountIds,
  required List<String> walletIds,
  required String period,
}) {
  if (state is StatisticsInitial || state is StatisticsLoading) return true;
  if (state is! StatisticsLoaded) return false;
  if (!state.isRefreshing) return false;
  return !statisticsLoadedForScope(
    state,
    source: source,
    bankAccountIds: bankAccountIds,
    walletIds: walletIds,
    period: period,
  );
}
