import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/budget_refusal.dart';

void main() {
  group('recognises a budget refusal', () {
    test('the reason codes statistics-service emits', () {
      expect(isBudgetRefusal('budget_exceeded'), isTrue);
      expect(isBudgetRefusal('budget_exceeded_strict'), isTrue);
      expect(
        isBudgetRefusal(
            'rpc error: code = FailedPrecondition desc = budget_exceeded'),
        isTrue,
      );
    });

    test('the sentences a server might send instead of a code', () {
      expect(isBudgetRefusal('This payment exceeds your budget'), isTrue);
      expect(isBudgetRefusal('You are over your budget for this month'), isTrue);
      expect(isBudgetRefusal('Budget limit reached'), isTrue);
      expect(isBudgetRefusal('BUDGET EXCEEDED'), isTrue);
    });
  });

  // A false positive sends someone to the budget screen to fix something that
  // is not a budget — worse than a generic error, because it wastes the one
  // action they were given and leaves the real problem unexplained.
  group('does not claim unrelated failures', () {
    test('every other refusal in the product', () {
      const others = [
        'Insufficient balance. Amount (₦500) exceeds your balance of ₦100',
        'Daily transfer limit reached for your KYC tier',
        'This user is already at the 3 Family & Friends accounts limit',
        'Our servers are having a problem right now',
        'Network error. Please check your connection and try again',
        'transaction PIN is required to confirm this trade',
        'no data gateway in chain was callable',
        '',
      ];
      for (final e in others) {
        expect(isBudgetRefusal(e), isFalse, reason: e);
      }
      expect(isBudgetRefusal(null), isFalse);
    });

    // "budgeting" and "budget" are different words, and the AI Budgeting
    // feature's name appears in plenty of messages that are not refusals.
    test('a mention of budgeting is not a refusal', () {
      expect(isBudgetRefusal('Open AI Budgeting to see your spending'), isFalse);
      expect(isBudgetRefusal('Could not load budgets'), isFalse);
    });
  });

  group('names the budget that blocked it', () {
    test('pulls the category out of the server sentence', () {
      expect(
        budgetCategoryFrom("You've exceeded your Transfers budget! "
            'Spent: 820.00 of 800.00'),
        'Transfers',
      );
      expect(
        budgetCategoryFrom('This exceeds your Currency Exchange budget'),
        'Currency Exchange',
      );
    });

    test('returns null rather than a filler word', () {
      // "past the budget" must not render as "your the budget".
      expect(budgetCategoryFrom('You are past the budget'), isNull);
      expect(budgetCategoryFrom('budget_exceeded'), isNull);
      expect(budgetCategoryFrom(null), isNull);
    });
  });
}
