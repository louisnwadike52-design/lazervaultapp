import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every surface that renders a bill payment's status must be able to SEE a
/// refund.
///
/// WHAT WENT WRONG
/// ---------------
/// A refunded cable TV subscription read "Refunded" in the dashboard's
/// transaction history and "Failed" on the Cable TV landing page, in the
/// receipt, in the text the receipt shares, and in the history actions sheet.
/// Same payment, five renderings, two answers — and the wrong one was on four
/// of the five surfaces the customer actually reaches from the bill flow.
///
/// None of it was a wrong rule. `bill_receipt_status.dart` has had the right
/// rule for some time, and the PDFs used it. The failures were all the same
/// shape: the surface never received `refund_source`, so there was nothing
/// for the rule to act on.
///
///   * nine of sixteen BillHistoryItem call sites omitted the argument
///   * two receipt screens rebuilt the entity on refresh and dropped it,
///     so the auto-refresher un-refunded the payment every poll
///   * one actions sheet rebuilt the entity from the proto and dropped it,
///     so the receipt it opened disagreed with the row that opened it
///   * four surfaces re-implemented the rule, and three of those checked a
///     raw-status predicate FIRST, which a refunded row matches
///
/// An omission reads as "no refund", which is indistinguishable from a
/// genuine failure. So these tests go after the omission, not the rule.
/// `refundSource: null` / `refundSource: ''` / `refundSource: ""` — the
/// spellings that satisfy the required parameter while saying "no refund".
final _emptyRefundSignal =
    RegExp('refundSource:' r'\s*' '(null|' r"''" '|' r'"")' r'\s*,?\s*$');

void main() {
  final lib = Directory('lib');

  group('bill status surfaces', () {
    test('no BillHistoryItem passes a hardcoded empty refund signal', () {
      // The constructor requires refundSource, which stops the silent
      // omission — but `refundSource: null` or `refundSource: ''` satisfies
      // the compiler and restores the bug. Those are only ever correct when
      // the row genuinely has no such field, and every bill entity has one.
      final offenders = <String>[];
      for (final f in _dartFiles(lib)) {
        final lines = f.readAsLinesSync();
        for (var i = 0; i < lines.length; i++) {
          final m = _emptyRefundSignal.firstMatch(lines[i]);
          if (m != null) {
            offenders.add('${f.path}:${i + 1}  ${lines[i].trim()}');
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'These pass a literal "no refund" instead of the row\'s own '
            'refund_source, which satisfies the required parameter while '
            'reintroducing the exact bug it was made required to stop:\n'
            '${offenders.join('\n')}',
      );
    });

    test('every bill status renderer routes through the canonical rule', () {
      // A file that turns a bill status into words or a colour, in a bill
      // feature, must reference the canonical rule — directly, or via
      // BillHistoryItem.statusInfo / an entity getter that does.
      const billFeatures = <String>[
        'cable_tv',
        'internet_bill',
        'water_bill',
        'education',
        'airtime',
        'data_bundles',
        'electricity_bill',
        'betting',
      ];
      // Names that derive a USER-FACING bill status. Deliberately narrow:
      // _statusColor over a card status or a reminder state is not this.
      final deriver = RegExp(
          r'(String|Color|PdfColor)\s+(get\s+)?_?(formatStatus|statusLabel|statusText|statusColor)\b');

      final offenders = <String>[];
      for (final f in _dartFiles(lib)) {
        final p = f.path;
        if (!billFeatures.any((b) => p.contains('/features/$b/'))) continue;
        final src = f.readAsStringSync();
        if (!deriver.hasMatch(src)) continue;

        final routed = src.contains('billReceiptStatusLabel') ||
            src.contains('BillHistoryItem.statusInfo') ||
            // Entities that collapse the raw status into a refund-aware
            // category of their own, which is the same rule by another name.
            src.contains('statusCategory') ||
            src.contains('displayStatus');
        if (!routed) offenders.add(p);
      }
      expect(
        offenders,
        isEmpty,
        reason: 'These derive a bill status label or colour without the one '
            'rule, so they cannot distinguish a refund from a failure — the '
            'backend keeps a refunded row as `failed` on purpose, with '
            'refund_source set:\n${offenders.join('\n')}',
      );
    });

    test('a refund-aware predicate is never shadowed by a raw-status one', () {
      // The water and data sheets both read, in this order:
      //     if (p.isCompleted) ...
      //     if (p.isFailed)    return 'Failed';   // literal status
      //     if (p.isRefunded)  return 'Refunded'; // reads refund_source
      // A refunded row keeps `failed`, so isFailed matched and returned and
      // the one test that could see the refund was never reached. The bug
      // was the ORDER, which is invisible unless you know the backend keeps
      // the row as failed.
      // Any test that can SEE a refund counts, whatever it is called —
      // electricity's receipt uses `isRefundedViaSource`, which is the same
      // question. What matters is only that one of them is asked first.
      final refundAware = RegExp(
          r'(isRefundedViaSource|isRefunded|hasRefundActivity|refundSource|'
          r'refundSignal|isRefundLabel|billReceiptStatusLabel)');
      final offenders = <String>[];
      for (final f in _dartFiles(lib)) {
        final src = f.readAsStringSync();
        final failedAt = src.indexOf('isFailed) return');
        if (failedAt < 0) continue;
        final firstAware = refundAware.firstMatch(src)?.start ?? -1;
        if (firstAware < 0 || firstAware > failedAt) offenders.add(f.path);
      }
      expect(
        offenders,
        isEmpty,
        reason: 'isFailed is tested before isRefunded here. A refunded bill '
            'row is stored as `failed`, so the refund branch is dead:\n'
            '${offenders.join('\n')}',
      );
    });
  });
}

Iterable<File> _dartFiles(Directory d) => d
    .listSync(recursive: true)
    .whereType<File>()
    .where((f) => f.path.endsWith('.dart'))
    // Generated protobuf code has its own shape and is not a UI surface.
    .where((f) => !f.path.contains('/generated/'));
