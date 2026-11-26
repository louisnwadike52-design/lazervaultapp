import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// THE HISTORY REPOSITORY MUST RESOLVE AN ACCOUNT, NEVER JUST DEMAND ONE.
///
/// `AccountManager` holds the active account in memory only — its own doc
/// says it "must be re-selected by the user after each app launch" — and the
/// thing that selects it is the dashboard carousel. Every deep link skips the
/// dashboard, so on a cold start `activeAccountId` is null by definition.
///
/// Seven call sites in this repository read it and threw
/// `No active account selected` when it was null. Each caller's catch
/// re-wrapped that into "We couldn't load transactions just now. Pull down to
/// try again." — a sentence blaming the network for a call that was never
/// made, over a Retry that could not succeed. That is the error a customer
/// saw after tapping a deposit push.
///
/// A source-text guard rather than a behavioural one: the defect is the
/// ABSENCE of resolution, and the shape that caused it is a two-line idiom
/// that is easy to paste back in while adding the eighth method.
void main() {
  final src = File('lib/src/features/transaction_history/data/repository/'
          'transaction_history_repository_grpc.dart')
      .readAsStringSync();

  test('no method demands a pre-selected account', () {
    // The exact idiom that broke: read the id, then throw when it is null.
    // Matched on the throw being guarded by a null test on the manager read,
    // rather than on either half alone — `_resolveAccountId` legitimately
    // contains both a manager read and that same throw.
    final offenders = <int>[];
    final lines = src.split('\n');
    for (var i = 0; i < lines.length; i++) {
      if (!lines[i].contains('accountManager.activeAccountId')) continue;
      // Look at the next few lines for the bare refusal.
      final window = lines.skip(i).take(4).join('\n');
      if (window.contains("throw Exception('No active account selected')")) {
        offenders.add(i + 1);
      }
    }
    expect(offenders, isEmpty,
        reason: 'these read the active account and give up when it is '
            'missing, which is every notification deep link on a cold '
            'start:\n  lines ${offenders.join(', ')}\n'
            'Use _resolveAccountId(), which falls back to '
            'ensureActiveAccountSnapshot() and fetches the account list.');
  });

  test('and the resolver it must use is actually wired', () {
    expect(src.contains('Future<String> _resolveAccountId()'), isTrue,
        reason: 'the resolver is gone; the seven call sites have nothing to '
            'fall back to');
    expect(src.contains('ensureActiveAccountSnapshot()'), isTrue,
        reason: '_resolveAccountId no longer fetches the account list, so a '
            'cold-start deep link still has nothing to resolve against');
    // Every fetch must go through it. Counting is what catches an eighth
    // method added later that reads the manager directly.
    final uses = RegExp(r'await _resolveAccountId\(\)').allMatches(src).length;
    expect(uses, greaterThanOrEqualTo(7),
        reason: 'only $uses call sites resolve the account; there were seven '
            'that needed it');
  });
}
