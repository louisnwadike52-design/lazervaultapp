import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/generated/statistics.pb.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  int activeTab = 0;
  final List<String> cashFlow = ["Total Income", "Total Expenses"];
  final List<String> timePeriods = ["Week", "Month", "Quarter", "Year"];
  String selectedPeriod = "Month";

  // Sample data for charts
  final Map<String, double> expenseCategories = {
    'Shopping': 1250.00,
    'Bills': 850.00,
    'Food': 650.00,
    'Transport': 450.00,
    'Entertainment': 350.00,
    'Others': 250.00,
  };

  final List<Color> categoryColors = [
    const Color(0xFF4A90E2),
    const Color(0xFFE2844A),
    const Color(0xFF4AE28D),
    const Color(0xFFE24A67),
    const Color(0xFF9B4AE2),
    const Color(0xFFE2E24A),
  ];

  // Add new state variables
  bool showIncome = true;
  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

  // Sample data for income categories
  final Map<String, double> incomeCategories = {
    'Salary': 5500.00,
    'Investments': 1800.00,
    'Freelance': 850.00,
    'Rental': 1200.00,
    'Other': 200.00,
  };

  // Enhanced expense categories with icons
  final Map<String, Map<String, dynamic>> enhancedExpenseCategories = {
    'Shopping': {
      'amount': 1250.00,
      'icon': Icons.shopping_bag,
      'subcategories': {
        'Groceries': 650.00,
        'Clothing': 350.00,
        'Electronics': 250.00,
      }
    },
    'Bills': {
      'amount': 850.00,
      'icon': Icons.receipt_long,
      'subcategories': {
        'Utilities': 400.00,
        'Internet': 250.00,
        'Phone': 200.00,
      }
    },
    'Transport': {
      'amount': 450.00,
      'icon': Icons.directions_car,
      'subcategories': {
        'Fuel': 250.00,
        'Maintenance': 150.00,
        'Public Transit': 50.00,
      }
    },
    // ... existing categories ...
  };

  // Monthly financial data
  final List<Map<String, dynamic>> monthlyData = [
    {'month': 'Jan', 'income': 7500, 'expenses': 5200},
    {'month': 'Feb', 'income': 7800, 'expenses': 4800},
    {'month': 'Mar', 'income': 8200, 'expenses': 5100},
    {'month': 'Apr', 'income': 7900, 'expenses': 4900},
    {'month': 'May', 'income': 8500, 'expenses': 5300},
    {'month': 'Jun', 'income': 8350, 'expenses': 5044},
  ];

  // Add to existing state variables
  bool showAIAssistant = false;
  final TextEditingController _aiQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Load statistics data and AI insights from backend
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<StatisticsCubit>();
      cubit.loadStatistics();
      cubit.getAISpendingInsights(focusArea: 'savings');
      cubit.getAIBudgetingRecommendations(
        monthlyIncome: 8350.00, // TODO: Get from user profile
        financialGoals: ['Emergency Fund', 'Save for Vacation', 'Invest'],
        riskTolerance: 'moderate',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatisticsCubit, StatisticsState>(
      listener: (context, state) {
        // Show error if AI request fails
        if (state is StatisticsLoaded && state.aiError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.aiError!),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          color: AppColors.secondaryBackgroundColor,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.backgroundColor,
                            Color.fromARGB(255, 95, 20, 225),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildHeader(),
                          _buildBalanceOverview(state),
                          SizedBox(height: 20.h),
                          _buildPeriodSelector(),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                    _buildExpenseChart(),
                    _buildCategoryBreakdown(state),
                    _buildBudgetProgress(state),
                    _buildMonthlyTrendChart(),
                    _buildComparisonMetrics(),
                    _buildToggleSection(),
                    showIncome ? _buildIncomeAnalysis(state) : _buildExpenseAnalysis(),
                    _buildInvestmentPortfolio(state),
                    _buildFinancialGoals(state),
                    _buildSavingsGoal(state),
                    _buildUpcomingBills(state),
                    _buildFinancialInsights(state),
                  ],
                ),
              ),
              if (showAIAssistant)
                Positioned(
                  top: 140.h,
                  left: 16.w,
                  right: 16.w,
                  child: _buildAIAssistantPanel(state),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Statistics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                          ),
                          child: TextField(
                            controller: _aiQueryController,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Ask AI Assistant',
                              hintStyle: TextStyle(
                                color: Colors.white.withValues(alpha: 0.5),
                                fontSize: 14.sp,
                              ),
                              prefixIcon: Icon(
                                Icons.chat_outlined,
                                color: Colors.white.withValues(alpha: 0.5),
                                size: 20.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                            ),
                            onTap: () {
                              setState(() => showAIAssistant = true);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.mic_off,
                    color: Colors.grey,
                    size: 20.sp,
                  ),
                  tooltip: 'Voice Commands Disabled',
                  onPressed: null,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String label) {
    return ActionChip(
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
        ),
      ),
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      side: BorderSide(
        color: Colors.white.withValues(alpha: 0.1),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      onPressed: () {
        _aiQueryController.text = label;
        _handleAIQuery(label);
        setState(() => showAIAssistant = false);
      },
    );
  }

  Widget _buildBalanceOverview(StatisticsState state) {
    // Get data from state or use defaults
    double totalSpending = 0.0;
    double totalIncome = 0.0;
    double totalExpenses = 0.0;

    if (state is StatisticsLoaded) {
      // Calculate totals from expenses list
      totalExpenses = state.expenses.fold(0.0, (sum, expense) => sum + expense.amount);
      totalSpending = totalExpenses;
      // Income would need to come from a separate source
      totalIncome = 8350.00; // TODO: Get from user profile or income tracking
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total spending',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '\$${totalSpending.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Income',
                '\$${totalIncome.toStringAsFixed(2)}',
                Icons.arrow_upward,
                Colors.green[300]!,
                true,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildMetricCard(
                'Expenses',
                '\$${totalExpenses.toStringAsFixed(2)}',
                Icons.arrow_downward,
                Colors.red[300]!,
                false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String label, String amount, IconData icon,
      Color color, bool isPositive) {
    // Calculate percentage change (sample data - replace with actual calculations)
    final percentageChange = isPositive ? '+12.5%' : '-8.3%';

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(icon, color: color, size: 16.r),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPositive
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.red.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  percentageChange,
                  style: TextStyle(
                    color: isPositive ? Colors.green[300] : Colors.red[300],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            amount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timePeriods.length,
        itemBuilder: (context, index) {
          final isSelected = timePeriods[index] == selectedPeriod;
          return GestureDetector(
            onTap: () => setState(() => selectedPeriod = timePeriods[index]),
            child: Container(
              margin: EdgeInsets.only(right: 12.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6C5CE7)
                    : const Color(0xFF2D2D3F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              alignment: Alignment.center,
              child: Text(
                timePeriods[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpenseChart() {
    return Container(
      height: 200.h,
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3),
                FlSpot(2.6, 2),
                FlSpot(4.9, 5),
                FlSpot(6.8, 3.1),
                FlSpot(8, 4),
                FlSpot(9.5, 3),
                FlSpot(11, 4),
              ],
              isCurved: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6C5CE7),
                  const Color(0xFF8E5CE7),
                ],
              ),
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                    const Color(0xFF8E5CE7).withValues(alpha: 0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBreakdown(StatisticsState state) {
    List<CategorySpending> categories = [];

    if (state is StatisticsLoaded && state.categoryBreakdown.isNotEmpty) {
      categories = state.categoryBreakdown;
    }

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Breakdown',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),

          if (categories.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Text(
                  'No expense data available',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            )
          else
            ...List.generate(
              categories.length,
              (index) => _buildCategoryItemFromBackend(
                categories[index],
                categoryColors[index % categoryColors.length],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryItemFromBackend(CategorySpending categorySpending, Color color) {
    final categoryName = _formatCategoryName(categorySpending.category);
    final amount = categorySpending.amount;
    final percentage = categorySpending.percentage;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    categoryName,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: percentage / 100.0,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4.h,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ],
      ),
    );
  }

  String _formatCategoryName(ExpenseCategory category) {
    return category.name
        .replaceAll('EXPENSE_CATEGORY_', '')
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
        .join(' ');
  }

  Widget _buildBudgetProgress(StatisticsState state) {
    List<BudgetProgressItem> budgets = [];
    double totalSpent = 0.0;
    double totalBudget = 0.0;

    if (state is StatisticsLoaded && state.budgetProgress.isNotEmpty) {
      budgets = state.budgetProgress;
      for (var budget in budgets) {
        totalSpent += budget.spentAmount;
        totalBudget += budget.budgetAmount;
      }
    }

    final progress = totalBudget > 0 ? totalSpent / totalBudget : 0.0;

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Budget Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),

          if (budgets.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Text(
                  'No budget data available',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            )
          else ...{
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Budget',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '\$${totalSpent.toStringAsFixed(0)} / \$${totalBudget.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress > 0.8 ? Colors.red : const Color(0xFF6C5CE7),
              ),
              minHeight: 8.h,
              borderRadius: BorderRadius.circular(4.r),
            ),
            SizedBox(height: 16.h),

            ...budgets.take(3).map((budget) => _buildBudgetItem(budget)),
          },
        ],
      ),
    );
  }

  Widget _buildBudgetItem(BudgetProgressItem budget) {
    final progress = budget.budgetAmount > 0 ? budget.spentAmount / budget.budgetAmount : 0.0;
    final isOverBudget = progress > 1.0;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                budget.budgetName,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                '\$${budget.spentAmount.toStringAsFixed(0)} / \$${budget.budgetAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  color: isOverBudget ? Colors.red : Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          LinearProgressIndicator(
            value: progress > 1.0 ? 1.0 : progress,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(
              isOverBudget ? Colors.red : const Color(0xFF6C5CE7),
            ),
            minHeight: 4.h,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyTrendChart() {
    return Container(
      height: 280.h,
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Monthly Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10000,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          months[value.toInt()],
                          style:
                              TextStyle(color: Colors.white60, fontSize: 12.sp),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '\$${value.toInt()}',
                          style:
                              TextStyle(color: Colors.white60, fontSize: 12.sp),
                        );
                      },
                      reservedSize: 40,
                    ),
                  ),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2000,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.white.withValues(alpha: 0.1),
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(
                  monthlyData.length,
                  (index) => BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: monthlyData[index]['income'].toDouble(),
                        color: Colors.green[300],
                        width: 12.w,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      BarChartRodData(
                        toY: monthlyData[index]['expenses'].toDouble(),
                        color: Colors.red[300],
                        width: 12.w,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildChartLegend('Income', Colors.green[300]!),
              SizedBox(width: 24.w),
              _buildChartLegend('Expenses', Colors.red[300]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonMetrics() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Month-over-Month Comparison',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          _buildComparisonItem(
            'Total Income',
            8350.00,
            7800.00,
            Icons.trending_up,
            true,
          ),
          _buildComparisonItem(
            'Total Expenses',
            5044.00,
            4800.00,
            Icons.trending_down,
            false,
          ),
          _buildComparisonItem(
            'Savings',
            3306.00,
            3000.00,
            Icons.savings,
            true,
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonItem(String label, double current, double previous,
      IconData icon, bool isPositive) {
    final percentageChange =
        ((current - previous) / previous * 100).toStringAsFixed(1);
    final isIncreased = current > previous;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: (isIncreased == isPositive
                          ? Colors.green
                          : Colors.red)[300]!
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  color: (isIncreased == isPositive
                      ? Colors.green
                      : Colors.red)[300],
                  size: 16.r,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    '\$${current.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color:
                  (isIncreased == isPositive ? Colors.green : Colors.red)[300]!
                      .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${isIncreased ? '+' : ''}$percentageChange%',
              style: TextStyle(
                color: (isIncreased == isPositive
                    ? Colors.green
                    : Colors.red)[300],
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showIncome = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: showIncome
                      ? AppColors.backgroundColor
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Income',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight:
                        showIncome ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => showIncome = false),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: !showIncome
                      ? AppColors.backgroundColor
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'Expenses',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight:
                        !showIncome ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeAnalysis(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return SizedBox.shrink();
    }

    final incomeBreakdown = state.incomeBreakdown;
    if (incomeBreakdown == null || incomeBreakdown.categories.isEmpty) {
      return Container(
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Center(
          child: Text(
            'No income data available',
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Income Breakdown',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${state.totalMonthlyIncome.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.green[300],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          AspectRatio(
            aspectRatio: 1.3,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: _generateIncomeSections(incomeBreakdown),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Column(
            children: incomeBreakdown.categories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              return _buildIncomeCategoryItem(
                _getIncomeCategoryName(category.category),
                category.amount,
                categoryColors[index % categoryColors.length],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getIncomeCategoryName(IncomeCategory category) {
    switch (category) {
      case IncomeCategory.INCOME_CATEGORY_SALARY:
        return 'Salary';
      case IncomeCategory.INCOME_CATEGORY_FREELANCE:
        return 'Freelance';
      case IncomeCategory.INCOME_CATEGORY_BUSINESS:
        return 'Business';
      case IncomeCategory.INCOME_CATEGORY_INVESTMENTS:
        return 'Investment';
      case IncomeCategory.INCOME_CATEGORY_RENTAL:
        return 'Rental';
      case IncomeCategory.INCOME_CATEGORY_DIVIDEND:
        return 'Dividend';
      case IncomeCategory.INCOME_CATEGORY_INTEREST:
        return 'Interest';
      case IncomeCategory.INCOME_CATEGORY_GIFT:
        return 'Gift';
      case IncomeCategory.INCOME_CATEGORY_OTHER:
        return 'Other';
      default:
        return 'Unknown';
    }
  }

  IconData _getBillIcon(String category) {
    switch (category.toLowerCase()) {
      case 'utilities':
        return Icons.electric_bolt;
      case 'rent':
      case 'mortgage':
        return Icons.home;
      case 'internet':
      case 'phone':
        return Icons.wifi;
      case 'insurance':
        return Icons.security;
      case 'subscription':
        return Icons.subscriptions;
      case 'loan':
        return Icons.account_balance;
      default:
        return Icons.receipt_long;
    }
  }

  IconData _getInvestmentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'stocks':
      case 'stock':
        return Icons.show_chart;
      case 'crypto':
      case 'cryptocurrency':
        return Icons.currency_bitcoin;
      case 'bonds':
      case 'bond':
        return Icons.assignment;
      case 'mutual funds':
      case 'mutual_funds':
        return Icons.account_balance;
      case 'real estate':
      case 'real_estate':
        return Icons.home_work;
      case 'commodities':
        return Icons.shopping_basket;
      default:
        return Icons.trending_up;
    }
  }

  Widget _buildSavingsGoal(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return SizedBox.shrink();
    }

    final savingsGoal = state.savingsGoal;
    if (savingsGoal == null) {
      return Container(
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Center(
          child: Text(
            'No savings goal set',
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
        ),
      );
    }

    final percentage = savingsGoal.percentageComplete / 100;

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                savingsGoal.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${savingsGoal.percentageComplete.toStringAsFixed(0)}% achieved',
                style: TextStyle(
                  color: Colors.green[300],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Savings',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    '\$${savingsGoal.currentAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Target',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    '\$${savingsGoal.targetAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          LinearProgressIndicator(
            value: percentage.clamp(0.0, 1.0),
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green[300]!),
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingBills(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return SizedBox.shrink();
    }

    final billsList = state.upcomingBills;
    if (billsList == null || billsList.bills.isEmpty) {
      return Container(
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Center(
          child: Text(
            'No upcoming bills',
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upcoming Bills',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${billsList.totalUpcoming.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.orange[300],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...billsList.bills.map((bill) => _buildBillItem(bill)),
        ],
      ),
    );
  }

  Widget _buildBillItem(RecurringBill bill) {
    final icon = _getBillIcon(bill.category.name);
    final statusColor = bill.status == BillStatus.BILL_STATUS_OVERDUE ? Colors.red[300] : Colors.orange[300];

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bill.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  bill.daysUntilDue > 0
                      ? 'Due in ${bill.daysUntilDue} days'
                      : bill.status == BillStatus.BILL_STATUS_OVERDUE
                          ? 'Overdue'
                          : 'Due today',
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${bill.amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialInsights(StatisticsState state) {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AI Financial Insights',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (state is StatisticsLoaded && state.isLoadingAIInsights)
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),

          // Display AI insights if available
          if (state is StatisticsLoaded && state.aiSpendingInsights != null) ...{
            if (state.aiSpendingInsights!.summary.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12.r),
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  state.aiSpendingInsights!.summary,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),

            ...state.aiSpendingInsights!.insights.take(3).map(
              (insight) => _buildAIInsightCard(
                title: insight.title,
                description: insight.description,
                impactAmount: insight.impactAmount,
                insightType: insight.insightType,
              ),
            ),
          } else ...{
            // Show default insights if no AI data
            _buildInsightCard(
              icon: Icons.trending_up,
              title: 'AI Insights Loading',
              value: 'Analyzing your spending patterns...',
              color: Colors.grey[400]!,
            ),
          },
        ],
      ),
    );
  }

  Widget _buildAIInsightCard({
    required String title,
    required String description,
    required double impactAmount,
    required String insightType,
  }) {
    IconData icon;
    Color color;

    switch (insightType.toLowerCase()) {
      case 'positive':
        icon = Icons.trending_up;
        color = Colors.green[300]!;
        break;
      case 'warning':
        icon = Icons.warning_amber;
        color = Colors.orange[300]!;
        break;
      default:
        icon = Icons.info_outline;
        color = Colors.blue[300]!;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12.sp,
                  ),
                ),
                if (impactAmount > 0) ...{
                  SizedBox(height: 4.h),
                  Text(
                    'Impact: \$${impactAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: color,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                },
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIAssistantPanel(StatisticsState state) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'AI Suggestions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() => showAIAssistant = false);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 20.r,
                ),
              ),
            ],
          ),

          // Show AI advice if available
          if (state is StatisticsLoaded && state.aiFinancialAdvice != null) ...{
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.teal.shade700,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16.r,
                        backgroundColor: Colors.teal.shade900,
                        child: Icon(Icons.smart_toy, size: 18.r, color: Colors.white),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'AI Advisor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    state.aiFinancialAdvice!.advice,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          } else if (state is StatisticsLoaded && state.isLoadingAIAdvice) ...{
            SizedBox(height: 12.h),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          } else ...{
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _buildSuggestionChip('Analyze spending'),
                _buildSuggestionChip('Budget tips'),
                _buildSuggestionChip('Savings advice'),
                _buildSuggestionChip('Investment insights'),
                _buildSuggestionChip('Expense breakdown'),
              ],
            ),
          },
        ],
      ),
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateIncomeSections(IncomeBreakdown breakdown) {
    if (breakdown.totalIncome == 0) return [];

    return breakdown.categories.asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value;
      final percentage = (category.amount / breakdown.totalIncome * 100).roundToDouble();
      return PieChartSectionData(
        color: categoryColors[index % categoryColors.length],
        value: category.amount,
        title: '$percentage%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildIncomeCategoryItem(String category, double amount, Color color) {
    final total = incomeCategories.values.reduce((a, b) => a + b);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    category,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: amount / total,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4.h,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseAnalysis() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expense Analysis',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          AspectRatio(
            aspectRatio: 1.3,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: _generateExpenseSections(),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Column(
            children: enhancedExpenseCategories.entries.map((entry) {
              return _buildExpenseCategoryDetailItem(
                entry.key,
                entry.value,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateExpenseSections() {
    final total = enhancedExpenseCategories.values
        .map((category) => category['amount'] as double)
        .reduce((a, b) => a + b);

    return enhancedExpenseCategories.entries.map((entry) {
      final index = enhancedExpenseCategories.keys.toList().indexOf(entry.key);
      final amount = entry.value['amount'] as double;
      final percentage = (amount / total * 100).roundToDouble();

      return PieChartSectionData(
        color: categoryColors[index % categoryColors.length],
        value: amount,
        title: '$percentage%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildExpenseCategoryDetailItem(
      String category, Map<String, dynamic> details) {
    final total = enhancedExpenseCategories.values
        .map((category) => category['amount'] as double)
        .reduce((a, b) => a + b);
    final amount = details['amount'] as double;
    final percentage = (amount / total * 100).toStringAsFixed(1);
    final color = categoryColors[
        enhancedExpenseCategories.keys.toList().indexOf(category) %
            categoryColors.length];

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      details['icon'] as IconData,
                      color: color,
                      size: 16.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$percentage% of total',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Subcategories
          if (details['subcategories'] != null) ...[
            ...((details['subcategories'] as Map<String, double>)
                .entries
                .map((subcategory) {
              final subAmount = subcategory.value;
              final subPercentage =
                  (subAmount / amount * 100).toStringAsFixed(1);

              return Container(
                margin: EdgeInsets.only(left: 36.w, bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          subcategory.key,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '$subPercentage%',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\$${subAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              );
            }).toList()),
          ],
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: amount / total,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4.h,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ],
      ),
    );
  }

  Widget _buildChartLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  // Add new financial management sections
  Widget _buildInvestmentPortfolio(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return SizedBox.shrink();
    }

    final portfolio = state.investmentPortfolio;
    if (portfolio == null || portfolio.investments.isEmpty) {
      return Container(
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Center(
          child: Text(
            'No investments tracked',
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Investment Portfolio',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${portfolio.totalValue.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${portfolio.totalGainLossPercentage >= 0 ? "+" : ""}${portfolio.totalGainLossPercentage.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: portfolio.totalGainLossPercentage >= 0
                          ? Colors.green[300]
                          : Colors.red[300],
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...portfolio.investments.map((investmentType) => _buildInvestmentTypeItem(investmentType)),
        ],
      ),
    );
  }

  Widget _buildInvestmentTypeItem(InvestmentTypeData investmentType) {
    final isPositive = investmentType.gainLossPercentage >= 0;
    final icon = _getInvestmentIcon(investmentType.investmentType.name);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: Colors.white, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  investmentType.investmentType.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$${investmentType.currentValue.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: (isPositive ? Colors.green : Colors.red)[300]!
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${isPositive ? '+' : ''}${investmentType.gainLossPercentage.toStringAsFixed(2)}%',
              style: TextStyle(
                color: (isPositive ? Colors.green : Colors.red)[300],
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialGoals(StatisticsState state) {
    if (state is! StatisticsLoaded) {
      return SizedBox.shrink();
    }

    final goals = state.financialGoals;
    if (goals.isEmpty) {
      return Container(
        margin: EdgeInsets.all(16.r),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Center(
          child: Text(
            'No financial goals set',
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Financial Goals',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...goals.map((goal) => _buildGoalItem(goal)),
        ],
      ),
    );
  }

  Widget _buildGoalItem(FinancialGoal goal) {
    final icon = _getGoalIcon(goal.goalType.name);
    final color = _getGoalColor(goal.goalType.name);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  goal.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$${goal.currentAmount.toStringAsFixed(0)} / \$${goal.targetAmount.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.green[300]!.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${goal.percentageComplete.toStringAsFixed(0)}%',
              style: TextStyle(
                color: Colors.green[300],
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getGoalIcon(String goalType) {
    switch (goalType.toLowerCase()) {
      case 'emergency_fund':
        return Icons.health_and_safety;
      case 'retirement':
        return Icons.savings;
      case 'education':
        return Icons.school;
      case 'home_purchase':
        return Icons.home;
      case 'vacation':
        return Icons.beach_access;
      case 'vehicle':
        return Icons.directions_car;
      case 'wedding':
        return Icons.favorite;
      case 'debt_payoff':
        return Icons.money_off;
      default:
        return Icons.flag;
    }
  }

  Color _getGoalColor(String goalType) {
    switch (goalType.toLowerCase()) {
      case 'emergency_fund':
        return Colors.blue[300]!;
      case 'retirement':
        return Colors.purple[300]!;
      case 'education':
        return Colors.amber[300]!;
      case 'home_purchase':
        return Colors.green[300]!;
      case 'vacation':
        return Colors.orange[300]!;
      case 'vehicle':
        return Colors.cyan[300]!;
      case 'wedding':
        return Colors.pink[300]!;
      case 'debt_payoff':
        return Colors.red[300]!;
      default:
        return Colors.grey[300]!;
    }
  }

  // Add these methods for AI functionality
  /*
  void _startVoiceCommand() {
    // Implement voice recognition
    // You'll need to add speech_to_text package
    // Show a bottom sheet with voice UI
  }
  */

  void _handleAIQuery(String query) {
    if (query.trim().isEmpty) return;

    // Determine context areas based on query keywords
    List<String> contextAreas = ['spending', 'budgeting', 'savings'];

    if (query.toLowerCase().contains('invest') || query.toLowerCase().contains('stock')) {
      contextAreas.add('investing');
    }
    if (query.toLowerCase().contains('debt') || query.toLowerCase().contains('loan')) {
      contextAreas.add('debt');
    }

    // Call the cubit to get AI financial advice from backend
    context.read<StatisticsCubit>().getAIFinancialAdvice(
      query: query,
      contextAreas: contextAreas,
    );
  }
}
