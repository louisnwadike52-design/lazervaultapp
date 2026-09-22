import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/statistics/data/budget_repository.dart';
import 'package:lazervault/src/features/statistics/utils/transaction_category_labels.dart';

/// The user's financial goals, shaped for the AI budgeting/analytics prompt.
///
/// WHY THIS IS SHARED
/// ------------------
/// Every AI surface in the product posts to the same endpoint
/// (`POST /api/budget/ai-insights`), and that endpoint's prompt explicitly
/// reasons over `financial_goals` — naming goals, quoting their progress, and
/// sizing advice against what the user is saving towards.
///
/// Only the AI Budgeting screen was actually sending them. The spending and
/// category analytics screens passed the literal `['Optimize spending']` and no
/// goals at all, so on those pages the model was told the user had no goals and
/// wrote advice from spending alone. Same endpoint, same user, two different
/// pictures — and the analytics page is where people go to ask "what should I
/// do differently".
///
/// Built once, here, so a third surface cannot quietly repeat it.
class FinancialGoalsContext {
  /// The rich per-goal payload the prompt reads (`financial_goals`).
  final List<Map<String, dynamic>> goals;

  /// Plain goal names for the endpoint's legacy `goals` field.
  final List<String> names;

  const FinancialGoalsContext({this.goals = const [], this.names = const []});

  static const empty = FinancialGoalsContext();

  bool get isEmpty => goals.isEmpty;

  /// Loads the caller's goals.
  ///
  /// Never throws: an AI panel must still render from spending when the goals
  /// read fails. It returns EMPTY in that case rather than a placeholder,
  /// because inventing "Save more" tells the model something the user did not
  /// say — and the endpoint already handles an empty list honestly ("Not
  /// specified") instead of guessing.
  static Future<FinancialGoalsContext> load() async {
    try {
      final response =
          await serviceLocator<BudgetRepository>().getFinancialGoals();

      final goals = <Map<String, dynamic>>[];
      for (final goal in response.goalsList.goals) {
        goals.add({
          'name': goal.name,
          'goal_type':
              TransactionCategoryLabels.humaniseEnumName(goal.goalType.name),
          'target_amount': goal.targetAmount,
          'current_amount': goal.currentAmount,
          'monthly_contribution': goal.monthlyContribution,
          'percentage_complete': goal.percentageComplete,
          'months_remaining': goal.monthsRemaining,
        });
      }

      return FinancialGoalsContext(
        goals: goals,
        names: goals.map((g) => g['name'] as String).toList(),
      );
    } catch (_) {
      return empty;
    }
  }

  /// Goal names for the legacy field, with a fallback only when there are none.
  ///
  /// The fallback is a hint about INTENT, not a fabricated goal — it is used
  /// solely for the free-text `goals` field, while `financial_goals` stays
  /// truthfully empty so the model does not invent progress to report.
  List<String> namesOr(List<String> fallback) => names.isEmpty ? fallback : names;
}
