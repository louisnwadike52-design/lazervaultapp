import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/typedef.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  int activeTab = 0;
  final List<String> cashFlow = ["Total Income", "Total Expenses"];
  String _activeCashFlowType = "Total Income";
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
    _activeCashFlowType = cashFlow[activeTab];
  }

  void _handleOnTimePeriodSelected(TimePeriod timePeriod) {}

  void _handleOnTabChanged(int value) {
    setState(() {
      activeTab = value;
      _activeCashFlowType = cashFlow[value];
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildHeader(),
                      _buildBalanceOverview(),
                      SizedBox(height: 20.h),
                      _buildPeriodSelector(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                _buildExpenseChart(),
                _buildCategoryBreakdown(),
                _buildBudgetProgress(),
                _buildMonthlyTrendChart(),
                _buildComparisonMetrics(),
                _buildToggleSection(),
                showIncome ? _buildIncomeAnalysis() : _buildExpenseAnalysis(),
                _buildInvestmentPortfolio(),
                _buildFinancialGoals(),
                _buildSavingsGoal(),
                _buildUpcomingBills(),
                _buildFinancialInsights(),
              ],
            ),
          ),
          if (showAIAssistant)
            Positioned(
              top: 140.h,
              left: 16.w,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
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
                            color: Colors.white.withOpacity(0.7),
                            size: 20.r,
                          ),
                        ),
                      ],
                    ),
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
                  ],
                ),
              ),
            ),
        ],
      ),
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
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
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
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 14.sp,
                              ),
                              prefixIcon: Icon(
                                Icons.chat_outlined,
                                color: Colors.white.withOpacity(0.5),
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
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                  ),
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
      backgroundColor: Colors.white.withOpacity(0.1),
      side: BorderSide(
        color: Colors.white.withOpacity(0.1),
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

  Widget _buildBalanceOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total spending',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '\$5,044.00',
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
                '\$8,350.00',
                Icons.arrow_upward,
                Colors.green[300]!,
                true,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildMetricCard(
                'Expenses',
                '\$3,306.00',
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
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
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
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(icon, color: color, size: 16.r),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPositive
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
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
                    const Color(0xFF6C5CE7).withOpacity(0.3),
                    const Color(0xFF8E5CE7).withOpacity(0.0),
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

  Widget _buildCategoryBreakdown() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
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
          ...List.generate(
            expenseCategories.length,
            (index) => _buildCategoryItem(
              expenseCategories.keys.elementAt(index),
              expenseCategories.values.elementAt(index),
              categoryColors[index],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category, double amount, Color color) {
    final total = expenseCategories.values.reduce((a, b) => a + b);
    final percentage = (amount / total * 100).toStringAsFixed(1);

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

  Widget _buildBudgetProgress() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monthly Budget',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '\$3,306 / \$5,000',
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
            value: 3306 / 5000,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(
              3306 / 5000 > 0.8 ? Colors.red : const Color(0xFF6C5CE7),
            ),
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(4.r),
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
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
                      color: Colors.white.withOpacity(0.1),
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
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
                      .withOpacity(0.2),
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
                      .withOpacity(0.2),
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
                      : Colors.white.withOpacity(0.05),
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
                      : Colors.white.withOpacity(0.05),
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

  Widget _buildIncomeAnalysis() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Income Breakdown',
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
                sections: _generateIncomeSections(),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Column(
            children: incomeCategories.entries.map((entry) {
              return _buildIncomeCategoryItem(
                entry.key,
                entry.value,
                categoryColors[
                    incomeCategories.keys.toList().indexOf(entry.key) %
                        categoryColors.length],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsGoal() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Savings Goal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '75% achieved',
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
                    '\$15,000',
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
                    '\$20,000',
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
            value: 0.75,
            backgroundColor: Colors.white10,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green[300]!),
            minHeight: 8.h,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingBills() {
    final List<Map<String, dynamic>> upcomingBills = [
      {
        'name': 'Rent',
        'amount': 1200.00,
        'dueDate': DateTime.now().add(Duration(days: 5)),
        'icon': Icons.home,
      },
      {
        'name': 'Electricity',
        'amount': 150.00,
        'dueDate': DateTime.now().add(Duration(days: 8)),
        'icon': Icons.electric_bolt,
      },
      {
        'name': 'Internet',
        'amount': 80.00,
        'dueDate': DateTime.now().add(Duration(days: 12)),
        'icon': Icons.wifi,
      },
    ];

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Bills',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...upcomingBills.map((bill) => _buildBillItem(bill)),
        ],
      ),
    );
  }

  Widget _buildBillItem(Map<String, dynamic> bill) {
    final daysLeft = bill['dueDate'].difference(DateTime.now()).inDays;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              bill['icon'],
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
                  bill['name'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Due in $daysLeft days',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '\$${bill['amount'].toStringAsFixed(2)}',
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

  Widget _buildFinancialInsights() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Financial Insights',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          _buildInsightCard(
            icon: Icons.trending_up,
            title: 'Highest Expense Category',
            value: 'Shopping - \$1,250.00',
            color: Colors.orange[300]!,
          ),
          _buildInsightCard(
            icon: Icons.savings,
            title: 'Monthly Savings Rate',
            value: '28% of Income',
            color: Colors.green[300]!,
          ),
          _buildInsightCard(
            icon: Icons.compare_arrows,
            title: 'Income vs Expense Ratio',
            value: '1.65x',
            color: Colors.blue[300]!,
          ),
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
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

  List<PieChartSectionData> _generateIncomeSections() {
    final total = incomeCategories.values.reduce((a, b) => a + b);
    return incomeCategories.entries.map((entry) {
      final index = incomeCategories.keys.toList().indexOf(entry.key);
      final percentage = (entry.value / total * 100).roundToDouble();
      return PieChartSectionData(
        color: categoryColors[index % categoryColors.length],
        value: entry.value,
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
    final percentage = (amount / total * 100).toStringAsFixed(1);

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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
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
                      color: color.withOpacity(0.2),
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
                            color: color.withOpacity(0.5),
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
  Widget _buildInvestmentPortfolio() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
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
              TextButton(
                onPressed: () {},
                child: Text(
                  'View Details',
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildInvestmentItem(
            'Stocks',
            8500.00,
            0.12,
            Icons.show_chart,
          ),
          _buildInvestmentItem(
            'Crypto',
            3200.00,
            -0.05,
            Icons.currency_bitcoin,
          ),
          _buildInvestmentItem(
            'Mutual Funds',
            5300.00,
            0.08,
            Icons.account_balance,
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentItem(
      String type, double amount, double change, IconData icon) {
    final isPositive = change >= 0;
    final percentageChange = (change * 100).abs().toStringAsFixed(1);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withOpacity(0.3),
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
                  type,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
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
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: (isPositive ? Colors.green : Colors.red)[300]!
                  .withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${isPositive ? '+' : '-'}$percentageChange%',
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

  Widget _buildFinancialGoals() {
    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
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
          _buildGoalItem(
            'Emergency Fund',
            15000,
            20000,
            Icons.health_and_safety,
            Colors.blue[300]!,
          ),
          _buildGoalItem(
            'New Car',
            12000,
            35000,
            Icons.directions_car,
            Colors.green[300]!,
          ),
          _buildGoalItem(
            'Vacation',
            2500,
            5000,
            Icons.beach_access,
            Colors.orange[300]!,
          ),
        ],
      ),
    );
  }

  Widget _buildGoalItem(String name, int currentAmount, int targetAmount,
      IconData icon, Color color) {
    final percentage = (currentAmount / targetAmount * 100).roundToDouble();
    final isPositive = currentAmount <= targetAmount;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
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
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${currentAmount.toString()} / ${targetAmount.toString()}',
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
                  .withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '${isPositive ? '+' : '-'}$percentage%',
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

  // Add these methods for AI functionality
  /*
  void _startVoiceCommand() {
    // Implement voice recognition
    // You'll need to add speech_to_text package
    // Show a bottom sheet with voice UI
  }
  */

  void _handleAIQuery(String query) {
    // Implement AI query handling
    // You can integrate with your LLM service here
  }
}
