import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

/// What a member is told about auto-pay attempts on their own row.
///
/// Until these fields existed the attempt history lived only in the service's
/// contribution_auto_charges table: auto-pay could fail, retry on the daily
/// backoff and exhaust its attempts while the member saw nothing but "behind".
/// Somebody whose account was empty on the 1st deserves to know we tried, how
/// many times, and what the bank said.
///
/// Mirrors the attempt section built in _showAutoDebitDialog.
String attemptCopy({
  required int attempts,
  required String status,
  required DateTime? lastAttemptAt,
  required String lastError,
}) {
  final buf = StringBuffer();
  buf.write(attempts == 1 ? 'We tried once' : 'We tried $attempts times');
  if (lastAttemptAt != null) {
    buf.write(', last on ${DateFormat('MMM d, h:mm a').format(lastAttemptAt)}');
  }
  buf.write('. ');
  if (status == 'exhausted') {
    buf.write('We have stopped trying for this cycle, so please pay manually.');
  } else if (status == 'failed') {
    buf.write('We will try again tomorrow. You can also pay manually at any time.');
  } else {
    buf.write('It went through.');
  }
  if (lastError.trim().isNotEmpty && !status.startsWith('succ')) {
    buf.write('\n\nLast reason: $lastError');
  }
  return buf.toString();
}

void main() {
  final when = DateTime(2026, 10, 13, 9, 0);

  group('auto-charge attempt copy', () {
    test('a single try is not "1 times"', () {
      final s = attemptCopy(
          attempts: 1, status: 'failed', lastAttemptAt: when, lastError: '');
      expect(s, startsWith('We tried once'));
      expect(s, isNot(contains('1 times')));
    });

    test('several tries are counted', () {
      final s = attemptCopy(
          attempts: 3, status: 'failed', lastAttemptAt: when, lastError: '');
      expect(s, contains('We tried 3 times'));
    });

    test('a failed row promises tomorrow, not silence', () {
      final s = attemptCopy(
          attempts: 2, status: 'failed', lastAttemptAt: when, lastError: '');
      expect(s, contains('try again tomorrow'));
      expect(s, contains('pay manually'));
    });

    test('an exhausted row says we have STOPPED', () {
      final s = attemptCopy(
          attempts: 5, status: 'exhausted', lastAttemptAt: when, lastError: '');
      expect(s, contains('stopped trying'));
      expect(s, isNot(contains('try again tomorrow')),
          reason: 'promising a retry that will never come is the worse lie');
    });

    test('the bank\'s reason is carried when it failed', () {
      final s = attemptCopy(
        attempts: 2,
        status: 'failed',
        lastAttemptAt: when,
        lastError: 'insufficient funds in wallet',
      );
      expect(s, contains('Last reason: insufficient funds in wallet'));
    });

    test('a stale error is NOT shown once it succeeded', () {
      final s = attemptCopy(
        attempts: 3,
        status: 'succeeded',
        lastAttemptAt: when,
        lastError: 'insufficient funds in wallet',
      );
      expect(s, contains('It went through.'));
      expect(s, isNot(contains('Last reason')),
          reason: 'the money arrived; the old failure is not the headline');
    });

    test('a missing timestamp does not produce a dangling "last on"', () {
      final s = attemptCopy(
          attempts: 1, status: 'failed', lastAttemptAt: null, lastError: '');
      expect(s, isNot(contains('last on')));
      expect(s, startsWith('We tried once. '));
    });

    test('an empty reason adds no trailing section', () {
      final s = attemptCopy(
          attempts: 1, status: 'failed', lastAttemptAt: when, lastError: '   ');
      expect(s, isNot(contains('Last reason')));
    });
  });
}
