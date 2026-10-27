import '../domain/entities/account_summary_entity.dart';

/// ONE order for the account carousel, whatever produced the rows.
///
/// The cubit paints the CACHED rows first and the FRESH rows a moment later.
/// Fresh rows were sorted with `List.sort`, which Dart does not guarantee to
/// be stable, on a single key (family last) — so two personal/savings rows
/// could come back in a different order from the cache they replaced. The
/// carousel builds cards by INDEX, and the balance widget animates whenever
/// the value at its position changes: card 0 would briefly show savings'
/// figure where personal's had been, then roll to personal's. That is the
/// "balance reads wrong for a moment" report.
///
/// Sorting both paints by a total order (type, then currency, then id) means
/// a refresh can only change a card's NUMBER, never which account sits at a
/// position. The per-card key in the carousel is the second half of the fix.
List<AccountSummaryEntity> orderForCarousel(List<AccountSummaryEntity> rows) {
  int typeRank(AccountSummaryEntity a) {
    switch (a.accountTypeEnum) {
      case VirtualAccountType.personal:
        return 0;
      case VirtualAccountType.savings:
        return 1;
      case VirtualAccountType.business:
        return 2;
      case VirtualAccountType.investment:
        return 3;
      case VirtualAccountType.family:
        return 9; // family last, as before
      default:
        return 5;
    }
  }

  final sorted = List<AccountSummaryEntity>.from(rows)
    ..sort((a, b) {
      final t = typeRank(a).compareTo(typeRank(b));
      if (t != 0) return t;
      final c = a.currency.compareTo(b.currency);
      if (c != 0) return c;
      return a.id.compareTo(b.id);
    });
  return sorted;
}
