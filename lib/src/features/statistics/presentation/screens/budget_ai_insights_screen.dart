import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/statistics/presentation/screens/budget_allocation_review_screen.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/budget_state.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/data/budget_repository.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/generated/statistics.pb.dart' as stats_pb;
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
part 'budget_ai_insights_screen_widgets.dart';


/// Budget AI Insights Screen
class BudgetAIInsightsScreen extends StatefulWidget {
  const BudgetAIInsightsScreen({super.key});

  @override
  State<BudgetAIInsightsScreen> createState() => _BudgetAIInsightsScreenState();
}

class _BudgetAIInsightsScreenState extends State<BudgetAIInsightsScreen> {
  // True when there is genuinely nothing to analyse (no wallet/linked-bank
  // spend, no income, no budgets/goals/bills). We show an explicit empty state
  // instead of asking the AI to reason over nothing — which returned sparse,
  // generic text that read as "broken".
  bool _noData = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInsights();
    });
  }

  void _loadInsights() async {
    if (!mounted) return;
    if (_noData) setState(() => _noData = false); // reset on retry

    // Pull real data from StatisticsCubit for income/spending analysis.
    double monthlyIncome = 0;
    List<Map<String, dynamic>> spendingData = [];
    final statisticsCubit = context.read<StatisticsCubit>();
    // Respect the ACTIVE scope the user chose on the analytics page
    // (Lazervault-only / Bank-only / Both) — the AI must reason about exactly the
    // tab being viewed, not silently widen to "both" (the old force-to-both here
    // is why AI insights always reflected everything regardless of the tab, and
    // made a Lazervault-only view impossible). Any active-bank narrowing the cubit
    // already applied is preserved. We only kick a load if no stats exist yet
    // (cold deep link), then await a settled load below so the prompt is never
    // built on a stale/refreshing snapshot.
    if (statisticsCubit.state is! StatisticsLoaded) {
      statisticsCubit.loadStatistics();
    }
    final cur = statisticsCubit.state;
    if (cur is! StatisticsLoaded || cur.isRefreshing) {
      await statisticsCubit.stream
          .firstWhere((s) => s is StatisticsLoaded && !s.isRefreshing)
          .timeout(const Duration(seconds: 12),
              onTimeout: () => statisticsCubit.state);
      if (!mounted) return;
    }
    final statsState = statisticsCubit.state;

    if (statsState is StatisticsLoaded && statsState.financialAnalytics != null) {
      final analytics = statsState.financialAnalytics!;
      if (analytics.hasCurrentPeriod()) {
        monthlyIncome = analytics.currentPeriod.totalIncome;
      }
    }

    if (statsState is StatisticsLoaded && statsState.categoryAnalytics != null) {
      final catAnalytics = statsState.categoryAnalytics!;
      final totalExpenses = catAnalytics.totalExpenses;
      for (final cat in catAnalytics.expenseCategories) {
        // Include sub-category breakdowns so AI can give granular advice
        final subCats = cat.subCategories.map((sub) => {
          'name': sub.name,
          'amount': sub.amount,
          'transaction_count': sub.transactionCount,
          'percentage': cat.amount > 0 ? (sub.amount / cat.amount * 100).round() : 0,
        }).toList();

        spendingData.add({
          'category': cat.categoryName,
          'amount': cat.amount,
          'percentage': totalExpenses > 0 ? (cat.amount / totalExpenses * 100).round() : 0,
          'transaction_count': cat.transactionCount,
          if (subCats.isNotEmpty) 'sub_categories': subCats,
        });
      }
    }

    // Pull active budgets from BudgetCubit if previously loaded
    List<Map<String, dynamic>> activeBudgets = [];
    final budgetState = context.read<BudgetCubit>().state;
    if (budgetState is BudgetsLoaded) {
      for (final budget in budgetState.budgets) {
        activeBudgets.add({
          'name': budget.name,
          'category': budget.category.name,
          'budget_amount': budget.amount,
          'spent_amount': budget.spentAmount,
          'remaining': budget.amount - budget.spentAmount,
          'percentage_used': budget.amount > 0
              ? (budget.spentAmount / budget.amount * 100).round()
              : 0,
        });
      }
    }

    // Fetch financial goals, upcoming bills, and budget alerts directly
    // from the repository (since the cubit can only hold one state at a time)
    List<Map<String, dynamic>> financialGoals = [];
    List<Map<String, dynamic>> upcomingBills = [];
    List<Map<String, dynamic>> budgetAlerts = [];

    try {
      final budgetRepo = serviceLocator<BudgetRepository>();
      final results = await Future.wait([
        budgetRepo.getFinancialGoals(),
        budgetRepo.getUpcomingBills(daysAhead: 30),
        budgetRepo.getBudgetAlerts(unreadOnly: false, limit: 20),
      ]);
      if (!mounted) return;

      // Financial goals
      final goalsResponse = results[0] as stats_pb.GetFinancialGoalsResponse;
      for (final goal in goalsResponse.goalsList.goals) {
        financialGoals.add({
          'name': goal.name,
          'goal_type': goal.goalType.name,
          'target_amount': goal.targetAmount,
          'current_amount': goal.currentAmount,
          'monthly_contribution': goal.monthlyContribution,
          'percentage_complete': goal.percentageComplete,
          'months_remaining': goal.monthsRemaining,
        });
      }

      // Upcoming bills
      final billsResponse = results[1] as stats_pb.GetUpcomingBillsResponse;
      for (final bill in billsResponse.billsList.bills) {
        upcomingBills.add({
          'name': bill.name,
          'amount': bill.amount,
          'days_until_due': bill.daysUntilDue,
          'recurrence_pattern': bill.recurrencePattern,
          'auto_pay_enabled': bill.autoPayEnabled,
        });
      }

      // Budget alerts
      final alertsResponse = results[2] as stats_pb.GetBudgetAlertsResponse;
      for (final alert in alertsResponse.alerts) {
        budgetAlerts.add({
          'budget_name': alert.budgetName,
          'alert_type': alert.alertType.name,
          'message': alert.message,
          'current_spent': alert.currentSpent,
          'budget_limit': alert.budgetLimit,
          'percentage_used': alert.percentageUsed,
        });
      }
    } catch (_) {
      // Non-critical — proceed with empty lists if fetch fails
    }

    // Build goal name list for legacy field
    final goalNames = financialGoals.isNotEmpty
        ? financialGoals.map((g) => g['name'] as String).toList()
        : ['Save more', 'Reduce spending'];

    // Honesty: pass the REAL income (even if 0/unavailable) — never a
    // fabricated placeholder. The AI prompt + insights UI handle the
    // no-data case. spendingData stays empty when there's genuinely none.

    // Extract failed/reversed transactions for AI analysis
    List<Map<String, dynamic>> failedTransactions = [];
    if (statsState is StatisticsLoaded && statsState.failedTransactions != null) {
      for (final tx in statsState.failedTransactions!.transactions) {
        failedTransactions.add({
          'reference': tx.reference,
          'amount': tx.amount,
          'category': tx.category,
          'description': tx.description,
          'status': tx.status,
          'date': tx.createdAt,
        });
      }
    }

    // Tell the AI which money sources this spending reflects, so it reasons
    // about linked-bank spend explicitly and notes (rather than silently drops)
    // any bank data it couldn't load. Derived from the loaded scope.
    // Reflect the ACTIVE scope so the AI reasons only about the sources actually
    // in view: wallet is excluded on the Bank-only tab; linked banks on the
    // Lazervault-only tab.
    final includesWallet = statsState is! StatisticsLoaded ||
        statsState.source != StatisticsSource.bank;
    final dataSources = <String, dynamic>{'wallet': includesWallet};
    if (statsState is StatisticsLoaded) {
      final includesExternal = statsState.source != StatisticsSource.lazervault;
      dataSources['linked_banks'] =
          includesExternal && statsState.externalStatus == ExternalDataStatus.ready;
      dataSources['linked_banks_status'] = includesExternal
          ? statsState.externalStatus.name // ready | empty | unavailable | ...
          : 'not_included';
      if (statsState.externalError != null &&
          statsState.externalError!.isNotEmpty) {
        dataSources['linked_banks_note'] = statsState.externalError;
      }
    }

    if (!mounted) return;

    // Nothing meaningful to analyse → show the empty state rather than a
    // generic AI response built on no data.
    final hasAnyData = spendingData.isNotEmpty ||
        monthlyIncome > 0 ||
        activeBudgets.isNotEmpty ||
        financialGoals.isNotEmpty ||
        upcomingBills.isNotEmpty ||
        failedTransactions.isNotEmpty;
    if (!hasAnyData) {
      setState(() => _noData = true);
      return;
    }

    context.read<BudgetCubit>().loadAIInsights(
      monthlyIncome: monthlyIncome,
      spendingData: spendingData,
      activeBudgets: activeBudgets,
      goals: goalNames,
      riskTolerance: 'moderate',
      currency: CurrencySymbols.currentCurrency,
      monthsOfData: 3,
      financialGoals: financialGoals,
      upcomingBills: upcomingBills,
      budgetAlerts: budgetAlerts,
      failedTransactions: failedTransactions,
      dataSources: dataSources,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'AI Analytics Insights',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<BudgetCubit, BudgetState>(
        listener: (context, state) {
          if (state is BudgetError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
        },
        builder: (context, state) {
          if (_noData) {
            return _NoDataView(onRetry: _loadInsights);
          }

          if (state is BudgetAIInsightsLoading) {
            return const _LoadingView();
          }

          if (state is BudgetAIInsightsLoaded) {
            return _InsightsView(insights: state.insights);
          }

          if (state is BudgetAIInsightsError) {
            return _ErrorView(
              message: state.message,
              onRetry: _loadInsights,
            );
          }

          return const _LoadingView();
        },
      ),
    );
  }
}
