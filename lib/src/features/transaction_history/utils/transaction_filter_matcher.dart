library;

import 'package:lazervault/core/types/unified_transaction.dart';

/// Applies the filters the user can SEE to the set about to be exported.
///
/// EXPORTING IGNORED EVERY FILTER. The history screen filters server-side
/// through `applyFilters`, but the export called
/// `fetchTransactionsForExport(startDate, endDate)` — dates and nothing else.
/// So someone who narrowed the list to failed bill payments, tapped download,
/// and got a statement of their entire month had no way to tell it was wrong:
/// the file looked plausible and was simply not what they asked for.
///
/// Applied client-side over the same date-ranged set, because the question the
/// export has to answer is "give me what I am looking at", and matching the
/// visible list exactly is the only way to guarantee that.
///
/// A null filter set means "no narrowing" and everything passes — callers must
/// not have to special-case the unfiltered screen.
bool transactionMatchesFilters(
  UnifiedTransaction tx,
  TransactionFilters? filters, {
  String? query,
  TransactionServiceType? serviceType,
}) {
  // The screen can be scoped to one service (opened from a service's own
  // history) independently of the filter sheet.
  if (serviceType != null && tx.serviceType != serviceType) return false;

  final q = query?.trim().toLowerCase();
  if (q != null && q.isNotEmpty) {
    final haystack = [
      tx.title,
      tx.description ?? '',
      tx.counterpartyName ?? '',
      tx.counterpartyAccount ?? '',
      tx.transactionReference ?? '',
    ].join(' ').toLowerCase();
    if (!haystack.contains(q)) return false;
  }

  if (filters == null) return true;

  // An EMPTY list is treated as no constraint, not as "match nothing". The
  // filter sheet can hand back an empty selection while the user is still
  // choosing, and excluding everything there would render a blank screen that
  // looks like having no transactions at all.
  final types = filters.serviceTypes;
  if (types != null && types.isNotEmpty && !types.contains(tx.serviceType)) {
    return false;
  }
  final statuses = filters.statuses;
  if (statuses != null && statuses.isNotEmpty && !statuses.contains(tx.status)) {
    return false;
  }
  final flows = filters.flows;
  if (flows != null && flows.isNotEmpty && !flows.contains(tx.flow)) {
    return false;
  }

  final min = filters.minAmount;
  if (min != null && tx.amount < min) return false;
  final max = filters.maxAmount;
  if (max != null && tx.amount > max) return false;

  // The filter sheet's own dates narrow FURTHER than the export range; the
  // export sheet's range is the outer bound.
  final start = filters.startDate;
  if (start != null && tx.createdAt.isBefore(start)) return false;
  final end = filters.endDate;
  if (end != null && tx.createdAt.isAfter(end)) return false;

  final fq = filters.searchQuery?.trim().toLowerCase();
  if (fq != null && fq.isNotEmpty) {
    final haystack = [
      tx.title,
      tx.description ?? '',
      tx.counterpartyName ?? '',
      tx.counterpartyAccount ?? '',
      tx.transactionReference ?? '',
    ].join(' ').toLowerCase();
    if (!haystack.contains(fq)) return false;
  }

  final cp = filters.counterpartyAccount?.trim();
  if (cp != null && cp.isNotEmpty && tx.counterpartyAccount != cp) return false;

  return true;
}

List<UnifiedTransaction> applyTransactionFilters(
  List<UnifiedTransaction> transactions,
  TransactionFilters? filters, {
  String? query,
  TransactionServiceType? serviceType,
}) =>
    transactions
        .where((t) => transactionMatchesFilters(t, filters,
            query: query, serviceType: serviceType))
        .toList();
