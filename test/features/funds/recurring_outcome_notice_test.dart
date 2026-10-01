import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_outcome_notice.dart';

void main() {
  group('the outcome survives the trip to the receipt', () {
    test('a created rule round-trips', () {
      final args = recurringOutcomeArgs(RecurringOutcome.created);
      expect(recurringOutcomeFrom(args), RecurringOutcome.created);
    });

    test('a failure carries its reason', () {
      final args = recurringOutcomeArgs(RecurringOutcome.failed,
          error: 'Schedule day 31 is not valid for every month');
      expect(recurringOutcomeFrom(args), RecurringOutcome.failed);
      expect(args[kRecurringErrorArg], contains('Schedule day 31'));
    });

    // The receipt is shown for every transfer. Most have no recurring rule,
    // and those must show nothing at all rather than an empty notice.
    test('a transfer with no recurring rule reports nothing', () {
      expect(recurringOutcomeFrom(null), isNull);
      expect(recurringOutcomeFrom({}), isNull);
      expect(recurringOutcomeFrom({'amount': 100}), isNull);
    });

    test('an unrecognised value is ignored rather than guessed', () {
      expect(recurringOutcomeFrom({kRecurringOutcomeArg: 'maybe'}), isNull);
      expect(recurringOutcomeFrom({kRecurringOutcomeArg: 7}), isNull);
    });

    // An empty or whitespace error adds nothing, and an empty box under
    // "the schedule did not" reads as a missing message.
    test('an empty error is left out entirely', () {
      expect(recurringOutcomeArgs(RecurringOutcome.failed, error: '')
          .containsKey(kRecurringErrorArg), isFalse);
      expect(recurringOutcomeArgs(RecurringOutcome.failed, error: '   ')
          .containsKey(kRecurringErrorArg), isFalse);
      expect(recurringOutcomeArgs(RecurringOutcome.failed)
          .containsKey(kRecurringErrorArg), isFalse);
    });
  });

  // The producers and the consumer are in different files; a renamed key
  // would silently stop the receipt from ever showing the notice.
  test('the argument keys are stable', () {
    expect(kRecurringOutcomeArg, 'recurringOutcome');
    expect(kRecurringErrorArg, 'recurringError');
  });

  // The args are spread into the receipt's route arguments, so they must not
  // collide with anything the receipt already reads.
  test('the keys do not collide with the receipt payload', () {
    const receiptKeys = {
      'amount', 'fee', 'currency', 'status', 'reference', 'transferId',
      'recipientName', 'scheduledAt', 'parentBatch', 'transfers', 'network',
    };
    expect(receiptKeys.contains(kRecurringOutcomeArg), isFalse);
    expect(receiptKeys.contains(kRecurringErrorArg), isFalse);
  });
}
