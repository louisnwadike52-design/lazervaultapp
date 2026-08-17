part of 'budget_override_dialog.dart';

/// Result of a budget override/adjustment action
enum BudgetOverrideAction {
  cancel,
  overrideOnce,
  increaseBudget,
}

/// Result data when user chooses to increase budget
class BudgetIncreaseResult {
  final double increaseAmount;
  final bool confirmWithPin;

  const BudgetIncreaseResult({
    required this.increaseAmount,
    this.confirmWithPin = true,
  });
}
