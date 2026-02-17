import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_cubit.dart';
import 'package:lazervault/src/features/statistics/cubit/statistics_state.dart';
import 'package:lazervault/src/features/statistics/data/budget_ai_service.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Maps category names from backend to display-friendly names.
String _friendlyCategoryName(String raw) => switch (raw.toLowerCase()) {
  // Backend display names (pass through as-is)
  'p2p transfers' || 'bank transfers' || 'international transfers' ||
  'gift cards' || 'bills & utilities' ||
  'service fees' || 'tagpay' || 'invoices' || 'investments' ||
  'payroll' || 'crowdfunding' || 'deposits' || 'withdrawals' ||
  'reversals' || 'transfers' || 'banking' || 'payments' ||
  'food & drinks' || 'shopping' || 'transportation' || 'entertainment' => raw,

  // PiggyVault (Lock Funds) — savings product
  'piggyvault' || 'piggy vault' || 'lock funds' || 'lock_funds' => 'PiggyVault',
  'autosave' => 'AutoSave',
  'savings & products' => 'Savings & Products',

  // Legacy raw category values
  'transfer' || 'c2c_transfer' => 'P2P Transfers',
  'domestic_transfer' => 'Bank Transfers',
  'international_transfer' => 'International Transfers',
  'deposit' => 'Deposits',
  'withdrawal' => 'Withdrawals',
  'fee' => 'Service Fees',
  'reversal' => 'Reversals',
  'payment' || 'invoice_payment' => 'Payments',
  'tag-pay' => 'TagPay',
  'invoice' => 'Invoices',
  'giftcards' || 'gift-cards' || 'gift_card' => 'Gift Cards',
  'airtime' || 'bill_payment' => 'Bills & Utilities',
  'investment' || 'investments' => 'Investments',

  // Raw service names (fallback)
  'core-payments-service' || 'core-payments' => 'Transfers',
  'banking-service' => 'Banking',
  'invoice-service' => 'Invoices',
  'giftcards-service' => 'Gift Cards',
  'utility-payments-service' => 'Bills & Utilities',
  'tag-pay-service' => 'TagPay',
  'financial-products-service' => 'Savings & Products',
  'investments-service' => 'Investments',
  'payroll-service' => 'Payroll',
  'crowdfund-service' => 'Crowdfunding',
  'accounts-service' => 'Other',

  // Fallback: capitalize and clean up
  _ => raw.replaceAll('-', ' ').replaceAll('_', ' ').split(' ').map((w) =>
      w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '').join(' '),
};

class CategoryAnalysisDetailScreen extends StatefulWidget {
  final String analysisType;

  const CategoryAnalysisDetailScreen({
    super.key,
    required this.analysisType,
  });

  @override
  State<CategoryAnalysisDetailScreen> createState() => _CategoryAnalysisDetailScreenState();
}

class _CategoryAnalysisDetailScreenState extends State<CategoryAnalysisDetailScreen> {
  bool get isIncome => widget.analysisType == 'income';

  // Track which categories are expanded (by name to avoid stale indices on refresh)
  final Set<String> _expandedCategories = {};

  // AI analysis state (local — avoids cubit state conflicts)
  bool _aiLoading = false;
  String? _aiError;
  BudgetAIInsightsResponse? _aiInsights;

  /// Map from category name (lowercased) to its AI insight
  Map<String, CategoryInsightItem> _categoryAIMap = {};

  static const List<Color> categoryColors = [
    Color(0xFF4A90E2),
    Color(0xFFE2844A),
    Color(0xFF4AE28D),
    Color(0xFFE24A67),
    Color(0xFF9B4AE2),
    Color(0xFFE2E24A),
    Color(0xFF4AE2D4),
    Color(0xFFE24ABB),
  ];

  Future<void> _loadAIAnalysis() async {
    if (_aiLoading) return;

    final statsState = context.read<StatisticsCubit>().state;
    if (statsState is! StatisticsLoaded || statsState.categoryAnalytics == null) return;

    final catAnalytics = statsState.categoryAnalytics!;
    final categories = isIncome ? catAnalytics.incomeCategories : catAnalytics.expenseCategories;
    if (categories.isEmpty) return;

    setState(() {
      _aiLoading = true;
      _aiError = null;
    });

    try {
      final analytics = statsState.financialAnalytics;
      final monthlyIncome = (analytics != null && analytics.hasCurrentPeriod())
          ? analytics.currentPeriod.totalIncome
          : 0.0;
      final totalExpenses = catAnalytics.totalExpenses;

      // Build spending data with sub-categories
      final spendingData = <Map<String, dynamic>>[];
      for (final cat in categories) {
        final subCats = cat.subCategories.map((sub) => {
          'name': sub.name,
          'amount': sub.amount,
          'transaction_count': sub.transactionCount,
          'percentage': cat.amount > 0 ? (sub.amount / cat.amount * 100).round() : 0,
        }).toList();

        final total = isIncome ? catAnalytics.totalIncome : totalExpenses;
        spendingData.add({
          'category': cat.categoryName,
          'amount': cat.amount,
          'percentage': total > 0 ? (cat.amount / total * 100).round() : 0,
          'transaction_count': cat.transactionCount,
          if (subCats.isNotEmpty) 'sub_categories': subCats,
        });
      }

      final aiService = serviceLocator<BudgetAIService>();
      final response = await aiService.getAIInsights(
        monthlyIncome: monthlyIncome > 0 ? monthlyIncome : 500000,
        spendingData: spendingData,
        activeBudgets: const [],
        goals: const ['Optimize spending'],
        riskTolerance: 'moderate',
        currency: CurrencySymbols.currentCurrency,
      );

      if (!mounted) return;

      // Build lookup map: lowercase category name → AI insight
      final map = <String, CategoryInsightItem>{};
      for (final ci in response.categoryInsights) {
        map[ci.categoryName.toLowerCase()] = ci;
      }

      setState(() {
        _aiInsights = response;
        _categoryAIMap = map;
        _aiLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _aiError = 'Failed to load AI analysis. Try again.';
        _aiLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          isIncome ? 'Income Analysis' : 'Expense Analysis',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, state) {
          if (state is! StatisticsLoaded) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }
          return RefreshIndicator(
            onRefresh: () => context.read<StatisticsCubit>().refresh(),
            color: const Color(0xFF10B981),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.r),
              children: [
                _buildPieChart(state),
                SizedBox(height: 16.h),
                _buildAIAnalysisSection(),
                SizedBox(height: 24.h),
                _buildCategoryList(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAIAnalysisSection() {
    // Already loaded — show summary
    if (_aiInsights != null) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: const Color(0xFF8B5CF6), size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'AI Spending Analysis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _loadAIAnalysis,
                  child: Icon(Icons.refresh, color: const Color(0xFF9CA3AF), size: 18.sp),
                ),
              ],
            ),
            if (_aiInsights!.summary.isNotEmpty) ...[
              SizedBox(height: 10.h),
              Text(
                _aiInsights!.summary,
                style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 13.sp, height: 1.5),
              ),
            ],
            if (_aiInsights!.savingsOpportunities.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text(
                'Suggestions',
                style: TextStyle(
                  color: const Color(0xFF10B981),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              ..._aiInsights!.savingsOpportunities.take(3).map((tip) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lightbulb_outline, color: const Color(0xFFFB923C), size: 14.sp),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            tip,
                            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      );
    }

    // Loading
    if (_aiLoading) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF8B5CF6),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Analyzing spending patterns...',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
          ],
        ),
      );
    }

    // Error
    if (_aiError != null) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 18.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(_aiError!, style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
            ),
            GestureDetector(
              onTap: _loadAIAnalysis,
              child: Text('Retry', style: TextStyle(color: const Color(0xFF8B5CF6), fontSize: 12.sp, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
    }

    // Default: show button to trigger AI analysis
    return GestureDetector(
      onTap: _loadAIAnalysis,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome, color: const Color(0xFF8B5CF6), size: 20.sp),
            SizedBox(width: 10.w),
            Text(
              'Get AI Spending Analysis',
              style: TextStyle(
                color: const Color(0xFF8B5CF6),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(StatisticsLoaded state) {
    final catAnalytics = state.categoryAnalytics;
    final categories = isIncome
        ? (catAnalytics?.incomeCategories ?? [])
        : (catAnalytics?.expenseCategories ?? []);
    final total = isIncome
        ? (catAnalytics?.totalIncome ?? 0.0)
        : (catAnalytics?.totalExpenses ?? 0.0);

    if (categories.isEmpty) {
      return Container(
        height: 300.h,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pie_chart_outline, color: Colors.white60, size: 48.r),
              SizedBox(height: 12.h),
              Text(
                'No ${isIncome ? 'income' : 'expense'} data available',
                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isIncome ? 'Income Breakdown' : 'Expense Breakdown',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                CurrencySymbols.formatAmount(total),
                style: TextStyle(
                  color: isIncome ? Colors.green[300] : Colors.red[300],
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
                sectionsSpace: 2,
                centerSpaceRadius: 50,
                sections: _generateSections(categories, total),
                pieTouchData: PieTouchData(
                  touchCallback: (event, response) {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateSections(
    List<accounts_pb.CategoryBreakdownItem> categories,
    double total,
  ) {
    if (total == 0) return [];

    return categories.asMap().entries.map((entry) {
      final index = entry.key;
      final cat = entry.value;
      final percentage = cat.percentage > 0
          ? cat.percentage.roundToDouble()
          : (cat.amount / total * 100).roundToDouble();
      return PieChartSectionData(
        color: categoryColors[index % categoryColors.length],
        value: cat.amount,
        title: '$percentage%',
        radius: 60,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildCategoryList(StatisticsLoaded state) {
    final catAnalytics = state.categoryAnalytics;
    final categories = isIncome
        ? (catAnalytics?.incomeCategories ?? [])
        : (catAnalytics?.expenseCategories ?? []);
    final total = isIncome
        ? (catAnalytics?.totalIncome ?? 0.0)
        : (catAnalytics?.totalExpenses ?? 0.0);

    if (categories.isEmpty) return const SizedBox.shrink();

    final safeTotal = total > 0 ? total : 1.0;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...categories.asMap().entries.map((entry) {
            final index = entry.key;
            final cat = entry.value;
            final color = categoryColors[index % categoryColors.length];
            final percentage = (cat.amount / safeTotal * 100);
            final hasSubCats = cat.subCategories.isNotEmpty;
            final isExpanded = _expandedCategories.contains(cat.categoryName);

            return Container(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (hasSubCats || _aiInsights != null)
                        ? () => setState(() {
                              if (isExpanded) {
                                _expandedCategories.remove(cat.categoryName);
                              } else {
                                _expandedCategories.add(cat.categoryName);
                              }
                            })
                        : null,
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: 14.w,
                                height: 14.w,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Flexible(
                                child: Text(
                                  _friendlyCategoryName(cat.categoryName),
                                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '${percentage.toStringAsFixed(1)}%',
                                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                              ),
                              if (hasSubCats || _aiInsights != null) ...[
                                SizedBox(width: 4.w),
                                Icon(
                                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: const Color(0xFF9CA3AF),
                                  size: 18.sp,
                                ),
                              ],
                            ],
                          ),
                        ),
                        Text(
                          CurrencySymbols.formatAmount(cat.amount),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  LinearProgressIndicator(
                    value: (cat.amount / safeTotal).clamp(0.0, 1.0),
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 6.h,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  // Sub-category breakdown + AI insights
                  if (isExpanded) ...[
                    if (hasSubCats)
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
                        padding: EdgeInsets.only(left: 24.w),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: color.withValues(alpha: 0.3),
                              width: 2,
                            ),
                          ),
                        ),
                        child: Column(
                          children: cat.subCategories.map((sub) {
                            final subPct = cat.amount > 0
                                ? (sub.amount / cat.amount * 100).toStringAsFixed(1)
                                : '0.0';
                            final subBarValue = cat.amount > 0
                                ? (sub.amount / cat.amount).clamp(0.0, 1.0)
                                : 0.0;
                            // Find AI tip for this sub-category
                            final aiCat = _categoryAIMap[cat.categoryName.toLowerCase()] ??
                                _categoryAIMap[_friendlyCategoryName(cat.categoryName).toLowerCase()];
                            final aiSub = aiCat?.subCategories
                                .where((s) => s.name.toLowerCase() == sub.name.toLowerCase())
                                .firstOrNull;

                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 8.w,
                                              height: 8.w,
                                              decoration: BoxDecoration(
                                                color: color.withValues(alpha: 0.6),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            Flexible(
                                              child: Text(
                                                sub.name.isNotEmpty ? sub.name : 'Other',
                                                style: TextStyle(
                                                  color: const Color(0xFF9CA3AF),
                                                  fontSize: 13.sp,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(width: 6.w),
                                            Text(
                                              '$subPct%',
                                              style: TextStyle(
                                                color: const Color(0xFF6B7280),
                                                fontSize: 11.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        CurrencySymbols.formatAmount(sub.amount),
                                        style: TextStyle(
                                          color: const Color(0xFFD1D5DB),
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  LinearProgressIndicator(
                                    value: subBarValue,
                                    backgroundColor: Colors.white.withValues(alpha: 0.05),
                                    valueColor: AlwaysStoppedAnimation<Color>(color.withValues(alpha: 0.5)),
                                    minHeight: 3.h,
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                  // AI tip for this sub-category
                                  if (aiSub != null && aiSub.insight.isNotEmpty) ...[
                                    SizedBox(height: 4.h),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.lightbulb_outline, color: const Color(0xFFFB923C), size: 12.sp),
                                        SizedBox(width: 4.w),
                                        Expanded(
                                          child: Text(
                                            aiSub.insight,
                                            style: TextStyle(
                                              color: const Color(0xFF9CA3AF),
                                              fontSize: 11.sp,
                                              fontStyle: FontStyle.italic,
                                              height: 1.3,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    // AI category analysis + action items
                    _buildCategoryAIInsight(cat.categoryName, color),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Inline AI analysis for a category (shown when expanded and AI loaded).
  Widget _buildCategoryAIInsight(String categoryName, Color color) {
    if (_aiInsights == null) return const SizedBox.shrink();

    final aiCat = _categoryAIMap[categoryName.toLowerCase()] ??
        _categoryAIMap[_friendlyCategoryName(categoryName).toLowerCase()];
    if (aiCat == null || aiCat.analysis.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF8B5CF6).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI analysis text
          Row(
            children: [
              Icon(Icons.auto_awesome, color: const Color(0xFF8B5CF6), size: 14.sp),
              SizedBox(width: 6.w),
              Text(
                'AI Analysis',
                style: TextStyle(
                  color: const Color(0xFF8B5CF6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            aiCat.analysis,
            style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 12.sp, height: 1.4),
          ),

          // AI sub-category insights (for categories without real sub-categories)
          if (aiCat.subCategories.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              'Breakdown',
              style: TextStyle(
                color: color.withValues(alpha: 0.8),
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            ...aiCat.subCategories.map((sub) => Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 4.h),
                        width: 5.w,
                        height: 5.w,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${sub.name.isNotEmpty ? sub.name : 'Other'}: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (sub.amount > 0)
                                TextSpan(
                                  text: '${CurrencySymbols.formatAmount(sub.amount)} — ',
                                  style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                                ),
                              TextSpan(
                                text: sub.insight,
                                style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],

          // Action items
          if (aiCat.actionItems.isNotEmpty) ...[
            SizedBox(height: 8.h),
            ...aiCat.actionItems.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: 3.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 13.sp),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(color: const Color(0xFFD1D5DB), fontSize: 11.sp, height: 1.3),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ],
      ),
    );
  }
}
