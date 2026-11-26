import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

/// NO THROW SITE MAY INTERPOLATE A RAW ERROR INTO THE UI.
///
/// This is the bug that put a page of gRPC trailers on the Deposit screen:
/// the history repository caught the failure and threw
/// `Exception('Failed to fetch service transactions: $e')`, so what reached
/// the customer was the status code, the trailers, a Cloudflare `cf-ray` and
/// a base64 NEL report URL, under "Something went wrong".
///
/// Kept in its own file with a plain substring search rather than a regex:
/// the first version of this guard used a pattern that did not match what it
/// was looking for and passed against the restored bug, which is the one
/// outcome a guard must not have.
void main() {
  test('the transaction-history repository interpolates no raw errors', () {
    final src = File('lib/src/features/transaction_history/data/repository/'
            'transaction_history_repository_grpc.dart')
        .readAsStringSync();

    final offenders = <String>[];
    for (final line in src.split('\n')) {
      final t = line.trim();
      if (!t.startsWith('throw Exception(')) continue;
      // `$e` is the error object; `$_` and named locals are fine. The two
      // spellings Dart allows for the same thing.
      if (t.contains(r'$e') || t.contains(r'${e')) offenders.add(t);
    }

    expect(offenders, isEmpty,
        reason: 'these put the raw error object on screen:\n'
            '${offenders.join('\n')}\n'
            'Route them through GrpcErrorHandler.userFriendlyMessage, which '
            'already has a sentence for every status code.');
  });

  test('and it does route through the shared handler', () {
    final src = File('lib/src/features/transaction_history/data/repository/'
            'transaction_history_repository_grpc.dart')
        .readAsStringSync();
    expect(src.contains('GrpcErrorHandler.userFriendlyMessage'), isTrue,
        reason: 'without this the repository is building its own copy again, '
            'and the handler it should be using already has the right '
            'sentence for an expired session');
  });
}
