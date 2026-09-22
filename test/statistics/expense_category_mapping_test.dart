import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as pb;

/// The mapping the AI budget-allocation screen uses to turn a recommendation's
/// category into the proto enum.
///
/// Kept as a standalone copy of the screen's private helper so the RULE is
/// tested: the screen matched the enum CONSTANT name against a human label, so
/// every allocated budget silently became OTHER — and because budget alerts
/// match on category (and unclassifiable spend also falls back to OTHER), one
/// unrecognised payment then incremented every budget the user had.

String categoryKey(String v) =>
    v.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

pb.ExpenseCategory protoCategory(String raw) {
  final needle = categoryKey(raw);
  if (needle.isEmpty) return pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER;
  const prefix = 'EXPENSECATEGORY';
  for (final c in pb.ExpenseCategory.values) {
    final constant = categoryKey(c.name);
    if (constant == needle) return c;
    if (constant.startsWith(prefix) &&
        constant.substring(prefix.length) == needle) {
      return c;
    }
  }
  return pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER;
}

void main() {
  test('human display labels resolve — the shape that was silently failing', () {
    expect(protoCategory('Bills & Utilities'),
        pb.ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES);
    expect(protoCategory('Food & Dining'),
        pb.ExpenseCategory.EXPENSE_CATEGORY_FOOD_DINING);
    expect(protoCategory('Transportation'),
        pb.ExpenseCategory.EXPENSE_CATEGORY_TRANSPORTATION);
  });

  test('enum constant names still resolve', () {
    expect(protoCategory('EXPENSE_CATEGORY_SHOPPING'),
        pb.ExpenseCategory.EXPENSE_CATEGORY_SHOPPING);
  });

  test('case and punctuation do not matter', () {
    expect(protoCategory('bills and utilities'.replaceAll(' and ', ' & ')),
        pb.ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES);
    expect(protoCategory('bills_utilities'),
        pb.ExpenseCategory.EXPENSE_CATEGORY_BILLS_UTILITIES);
  });

  test('genuinely unknown still falls back to OTHER', () {
    expect(protoCategory('Nonsense Category'),
        pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER);
    expect(protoCategory(''), pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER);
  });

  test('distinct labels map to DISTINCT categories', () {
    // The failure mode was every budget collapsing onto one category, so the
    // property that matters is that they stay apart.
    final mapped = [
      'Bills & Utilities',
      'Food & Dining',
      'Transportation',
      'Shopping',
      'Entertainment',
    ].map(protoCategory).toSet();
    expect(mapped.length, 5);
    expect(mapped.contains(pb.ExpenseCategory.EXPENSE_CATEGORY_OTHER), isFalse);
  });
}
