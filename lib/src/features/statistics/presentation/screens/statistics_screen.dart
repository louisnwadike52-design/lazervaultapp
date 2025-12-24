import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/statistics_cubit.dart';
import '../../cubit/statistics_state.dart';
import '../widgets/expense_list_widget.dart';
import '../widgets/budget_list_widget.dart';
import '../widgets/analytics_dashboard_widget.dart';
import '../widgets/ai_insights_card.dart';
import '../widgets/ai_budget_recommendations_card.dart';
import '../widgets/ai_financial_advice_widget.dart';
import 'add_expense_screen.dart';
import 'add_budget_screen.dart';

/// Main statistics screen with tabbed interface
/// Shows expenses, budgets, and analytics in separate tabs
class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });

    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<StatisticsCubit>();
      cubit.loadStatistics();
      // Load AI insights on startup
      cubit.getAISpendingInsights();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
            tooltip: 'Filter',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<StatisticsCubit>().refresh();
            },
            tooltip: 'Refresh',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Expenses', icon: Icon(Icons.receipt_long)),
            Tab(text: 'Budgets', icon: Icon(Icons.account_balance_wallet)),
            Tab(text: 'Analytics', icon: Icon(Icons.analytics)),
            Tab(text: 'AI Insights', icon: Icon(Icons.psychology)),
          ],
        ),
      ),
      body: BlocConsumer<StatisticsCubit, StatisticsState>(
        listener: (context, state) {
          if (state is StatisticsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () {
                    context.read<StatisticsCubit>().refresh();
                  },
                ),
              ),
            );
          } else if (state is ExpenseCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Expense created successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is BudgetCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Budget created successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ExpenseDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Expense deleted'),
                backgroundColor: Colors.orange,
              ),
            );
          } else if (state is BudgetDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Budget deleted'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is StatisticsInitial || state is StatisticsLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading statistics...'),
                ],
              ),
            );
          }

          if (state is StatisticsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading statistics',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<StatisticsCubit>().refresh();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: const [
              ExpenseListWidget(),
              BudgetListWidget(),
              AnalyticsDashboardWidget(),
              _AIInsightsTab(),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          if (state is StatisticsLoading ||
              state is StatisticsError ||
              state is StatisticsInitial) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton(
            onPressed: () => _handleAddAction(context),
            tooltip: _currentTabIndex == 0 ? 'Add Expense' : 'Add Budget',
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  void _handleAddAction(BuildContext context) {
    if (_currentTabIndex == 0) {
      // Add expense
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.read<StatisticsCubit>(),
            child: const AddExpenseScreen(),
          ),
        ),
      );
    } else if (_currentTabIndex == 1) {
      // Add budget
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.read<StatisticsCubit>(),
            child: const AddBudgetScreen(),
          ),
        ),
      );
    }
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider.value(
        value: context.read<StatisticsCubit>(),
        child: _FilterOptionsSheet(currentTab: _currentTabIndex),
      ),
    );
  }
}

/// Filter options bottom sheet
class _FilterOptionsSheet extends StatefulWidget {
  final int currentTab;

  const _FilterOptionsSheet({required this.currentTab});

  @override
  State<_FilterOptionsSheet> createState() => _FilterOptionsSheetState();
}

class _FilterOptionsSheetState extends State<_FilterOptionsSheet> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Filter Options',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: const Text('Start Date'),
            subtitle: Text(
              _startDate?.toString().split(' ')[0] ?? 'Select date',
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _startDate ?? DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(() {
                  _startDate = date;
                });
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.date_range),
            title: const Text('End Date'),
            subtitle: Text(
              _endDate?.toString().split(' ')[0] ?? 'Select date',
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _endDate ?? DateTime.now(),
                firstDate: _startDate ?? DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(() {
                  _endDate = date;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _startDate = null;
                    _endDate = null;
                  });
                },
                child: const Text('Clear'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_startDate != null && _endDate != null) {
                    context.read<StatisticsCubit>().changeDateRange(
                          startDate: _startDate!,
                          endDate: _endDate!,
                        );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// AI Insights tab content
class _AIInsightsTab extends StatelessWidget {
  const _AIInsightsTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        if (state is! StatisticsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AIInsightsCard(
                insights: state.aiSpendingInsights,
                isLoading: state.isLoadingAIInsights,
                error: state.aiError,
                onRefresh: () {
                  context.read<StatisticsCubit>().getAISpendingInsights(
                        startDate: state.startDate,
                        endDate: state.endDate,
                      );
                },
              ),
              AIBudgetRecommendationsCard(
                recommendations: state.aiBudgetingRecommendations,
                isLoading: state.isLoadingAIRecommendations,
                error: state.aiError,
                onRefresh: () {
                  _showBudgetRecommendationsDialog(context);
                },
                onApplyRecommendation: (recommendation) {
                  _applyBudgetRecommendation(context, recommendation);
                },
              ),
              AIFinancialAdviceWidget(
                advice: state.aiFinancialAdvice,
                isLoading: state.isLoadingAIAdvice,
                error: state.aiError,
                onAskQuestion: (query, contextAreas) {
                  context.read<StatisticsCubit>().getAIFinancialAdvice(
                        query: query,
                        contextAreas: contextAreas,
                      );
                },
              ),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        );
      },
    );
  }

  void _showBudgetRecommendationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Get Budget Recommendations'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter your details to get personalized budget recommendations:'),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Monthly Income',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                // Store for later use
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<StatisticsCubit>().getAIBudgetingRecommendations(
                    monthlyIncome: 5000, // TODO: Get from input
                    financialGoals: ['save_more', 'reduce_debt'],
                    riskTolerance: 'moderate',
                  );
            },
            child: const Text('Get Recommendations'),
          ),
        ],
      ),
    );
  }

  void _applyBudgetRecommendation(BuildContext context, dynamic recommendation) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applying budget recommendation: ${recommendation.toString()}'),
        action: SnackBarAction(
          label: 'Create Budget',
          onPressed: () {
            // Navigate to create budget screen
          },
        ),
      ),
    );
  }
}
