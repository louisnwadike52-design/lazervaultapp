import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_filter_matcher.dart';

/// EXPORTING IGNORED EVERY FILTER.
///
/// The history list filters server-side, but the export asked only for a date
/// range. Someone who narrowed the list to failed bill payments and tapped
/// download got a statement of their whole month — a plausible-looking file
/// that was simply not what they asked for, with nothing on it to say so.

final _types = TransactionServiceType.values;
final _statuses = UnifiedTransactionStatus.values;

UnifiedTransaction tx({
  String id = 't1',
  TransactionServiceType? type,
  UnifiedTransactionStatus? status,
  TransactionFlow flow = TransactionFlow.outgoing,
  double amount = 500,
  DateTime? at,
  String title = 'Payment',
  String? description,
  String? counterparty,
}) =>
    UnifiedTransaction(
      id: id,
      serviceType: type ?? _types.first,
      title: title,
      description: description,
      amount: amount,
      currency: 'NGN',
      createdAt: at ?? DateTime(2026, 10, 10),
      status: status ?? _statuses.first,
      flow: flow,
      counterpartyName: counterparty,
    );

void main() {
  test('no filters means everything passes', () {
    final rows = [tx(id: 'a'), tx(id: 'b')];
    expect(applyTransactionFilters(rows, null).length, 2);
  });

  test('a service-type filter narrows the export', () {
    // The reported shape: narrow the list, export, and get everything.
    final a = tx(id: 'a', type: _types.first);
    final b = tx(id: 'b', type: _types.last);
    final out = applyTransactionFilters(
        [a, b], TransactionFilters(serviceTypes: [_types.last]));
    expect(out.map((t) => t.id), ['b']);
  });

  test('a status filter narrows the export', () {
    final a = tx(id: 'a', status: _statuses.first);
    final b = tx(id: 'b', status: _statuses.last);
    final out = applyTransactionFilters(
        [a, b], TransactionFilters(statuses: [_statuses.last]));
    expect(out.map((t) => t.id), ['b']);
  });

  test('a flow filter separates money in from money out', () {
    final out = applyTransactionFilters(
      [
        tx(id: 'in', flow: TransactionFlow.incoming),
        tx(id: 'out', flow: TransactionFlow.outgoing),
      ],
      const TransactionFilters(flows: [TransactionFlow.incoming]),
    );
    expect(out.map((t) => t.id), ['in']);
  });

  test('amount bounds are inclusive at both ends', () {
    final rows = [
      tx(id: 'low', amount: 99),
      tx(id: 'min', amount: 100),
      tx(id: 'mid', amount: 500),
      tx(id: 'max', amount: 1000),
      tx(id: 'high', amount: 1001),
    ];
    final out = applyTransactionFilters(
        rows, const TransactionFilters(minAmount: 100, maxAmount: 1000));
    expect(out.map((t) => t.id), ['min', 'mid', 'max'],
        reason: 'a row exactly on the boundary the user typed must be kept');
  });

  test('an EMPTY selection list is no constraint, not "match nothing"', () {
    // The filter sheet can hand back an empty selection mid-choice. Treating
    // that as excluding everything renders a blank export that looks like
    // having no transactions at all.
    final rows = [tx(id: 'a'), tx(id: 'b')];
    expect(
        applyTransactionFilters(
                rows, const TransactionFilters(serviceTypes: []))
            .length,
        2);
    expect(
        applyTransactionFilters(rows, const TransactionFilters(statuses: []))
            .length,
        2);
  });

  test('the search box narrows the export too', () {
    final rows = [
      tx(id: 'a', description: 'Data purchase - MTN-DATA 07033609489'),
      tx(id: 'b', description: 'Electricity - Ikeja prepaid'),
    ];
    expect(applyTransactionFilters(rows, null, query: 'mtn').map((t) => t.id),
        ['a'], reason: 'matching is case-insensitive');
    expect(
        applyTransactionFilters(rows, null, query: '  ').length, 2,
        reason: 'a blank search is not a filter');
  });

  test('search also looks at counterparty, not just the description', () {
    final rows = [
      tx(id: 'a', counterparty: 'Praiz Onah'),
      tx(id: 'b', counterparty: 'Chris E'),
    ];
    expect(applyTransactionFilters(rows, null, query: 'praiz').map((t) => t.id),
        ['a']);
  });

  test('a service-scoped screen exports only that service', () {
    final rows = [
      tx(id: 'a', type: _types.first),
      tx(id: 'b', type: _types.last),
    ];
    expect(
        applyTransactionFilters(rows, null, serviceType: _types.last)
            .map((t) => t.id),
        ['b']);
  });

  test("the filter sheet's own dates narrow further than the export range",
      () {
    final rows = [
      tx(id: 'early', at: DateTime(2026, 10, 2)),
      tx(id: 'late', at: DateTime(2026, 10, 20)),
    ];
    final out = applyTransactionFilters(
      rows,
      TransactionFilters(startDate: DateTime(2026, 10, 10)),
    );
    expect(out.map((t) => t.id), ['late']);
  });

  test('filters combine — all must hold', () {
    final rows = [
      tx(id: 'a', type: _types.first, amount: 500),
      tx(id: 'b', type: _types.first, amount: 50),
      tx(id: 'c', type: _types.last, amount: 500),
    ];
    final out = applyTransactionFilters(
      rows,
      TransactionFilters(serviceTypes: [_types.first], minAmount: 100),
    );
    expect(out.map((t) => t.id), ['a']);
  });
}
