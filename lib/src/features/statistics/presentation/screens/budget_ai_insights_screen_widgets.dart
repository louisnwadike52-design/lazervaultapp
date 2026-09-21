part of 'budget_ai_insights_screen.dart';

class _InsightsView extends StatelessWidget {
  final BudgetAIInsightsData insights;

  const _InsightsView({required this.insights});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        // Summary Card
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3A0299), Color(0xFF4E03D0), Color(0xFFA78BFA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
                  SizedBox(width: 12.w),
                  const Expanded(
                    child: Text(
                      'AI Analysis',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                insights.summary,
                style: const TextStyle(
                    color: Colors.white, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Recommended Savings Rate
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              const Text(
                'Recommended Savings Rate',
                style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              ),
              SizedBox(height: 8.h),
              Text(
                '${insights.recommendedSavingsRate.toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: AnalyticsTheme.accent,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Risk Level & Spending Patterns
        if (insights.riskLevel.isNotEmpty ||
            insights.spendingPatterns.isNotEmpty) ...[
          Row(
            children: [
              Container(
                  width: 3,
                  height: 20,
                  decoration: BoxDecoration(
                      color: InvoiceThemeColors.primaryPurple,
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text(
                'Spending Patterns',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (insights.riskLevel.isNotEmpty) ...[
                  Row(
                    children: [
                      const Icon(Icons.shield,
                          color: InvoiceThemeColors.primaryPurple, size: 18),
                      SizedBox(width: 8.w),
                      const Text('Risk Level',
                          style: TextStyle(
                              color: Color(0xFF9CA3AF), fontSize: 13)),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: InvoiceThemeColors.primaryPurple
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          insights.riskLevel[0].toUpperCase() +
                              insights.riskLevel.substring(1),
                          style: const TextStyle(
                              color: AnalyticsTheme.accent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  if (insights.spendingPatterns.isNotEmpty)
                    SizedBox(height: 12.h),
                ],
                ...insights.spendingPatterns.entries.map(
                  (entry) => _SpendingPatternTile(
                    label: entry.key,
                    value: entry.value,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
        ],

        // Category Deep-Dive Insights
        if (insights.categoryInsights.isNotEmpty) ...[
          Row(
            children: [
              Container(
                  width: 3,
                  height: 20,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 78, 3, 208),
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text(
                'Category Deep Dive',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...insights.categoryInsights
              .map((ci) => _CategoryInsightCard(insight: ci)),
          SizedBox(height: 24.h),
        ],

        // Budget Recommendations
        if (insights.budgetRecommendations.isNotEmpty) ...[
          Row(
            children: [
              Container(
                  width: 3,
                  height: 20,
                  decoration: BoxDecoration(
                      color: InvoiceThemeColors.primaryPurple,
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text(
                'Budget Recommendations',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...insights.budgetRecommendations
              .map((rec) => _RecommendationCard(rec: rec)),
          SizedBox(height: 24.h),
        ],

        // Savings Opportunities
        if (insights.savingsOpportunities.isNotEmpty) ...[
          Row(
            children: [
              Container(
                  width: 3,
                  height: 20,
                  decoration: BoxDecoration(
                      color: InvoiceThemeColors.primaryPurple,
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text(
                'Savings Opportunities',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...insights.savingsOpportunities.map((opportunity) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12.w),
                    child: const Icon(Icons.lightbulb,
                        color: Color(0xFFFB923C), size: 20),
                  ),
                  Expanded(
                    child: Text(
                      opportunity,
                      style: const TextStyle(
                          color: Color(0xFF9CA3AF), fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: 32.h),
        ],

        // Apply. This used to call Get.back() and create nothing: the AI's
        // per-category amounts were computed, rendered, then discarded by the
        // button that said it would apply them.
        //
        // It opens a review rather than creating straight away, because these
        // become budgets the send-funds flow ENFORCES — a strict one refuses a
        // transfer — so the amounts have to be seen and editable first.
        ElevatedButton(
          onPressed: insights.budgetRecommendations.isEmpty
              ? null
              : () async {
                  final applied = await Get.to<bool>(
                    () => BlocProvider.value(
                      value: context.read<BudgetCubit>(),
                      child: BudgetAllocationReviewScreen(
                        recommendations: insights.budgetRecommendations,
                        currency: CurrencySymbols.currentCurrency,
                      ),
                    ),
                  );
                  // Once the allocation is applied, this analysis is spent:
                  // its recommendations are now budgets. Returning the user to
                  // the insights screen put them back in front of a finished
                  // job and, because the shared cubit had moved on, in front of
                  // a spinner that looked like a fresh analysis starting.
                  //
                  // Close the insights screen too, so Back from the review
                  // lands where the journey began. The result is forwarded so
                  // the landing page can refresh its budget list.
                  if (applied == true) Get.back(result: true);
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: InvoiceThemeColors.primaryPurple,
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r)),
          ),
          child: Text(
            insights.budgetRecommendations.isEmpty
                ? 'No allocation to apply'
                : 'Review & apply allocation',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

// ── Category Insight Card ──────────────────────────────────────────

class _CategoryInsightCard extends StatefulWidget {
  final CategoryInsightData insight;

  const _CategoryInsightCard({required this.insight});

  @override
  State<_CategoryInsightCard> createState() => _CategoryInsightCardState();
}

class _CategoryInsightCardState extends State<_CategoryInsightCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final ci = widget.insight;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header — always visible, tappable to expand
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(16.r),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 78, 3, 208)
                          .withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.category,
                        color: const Color.fromARGB(255, 78, 3, 208),
                        size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ci.categoryName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        if (ci.subCategories.isNotEmpty)
                          Text(
                            '${ci.subCategories.length} sub-categories',
                            style: TextStyle(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color(0xFF9CA3AF),
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),

          // Analysis — always visible
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              ci.analysis,
              style: TextStyle(
                  color: const Color(0xFFD1D5DB), fontSize: 13.sp, height: 1.5),
            ),
          ),
          SizedBox(height: 12.h),

          // Expanded: sub-categories + action items
          if (_expanded) ...[
            // Sub-categories
            if (ci.subCategories.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Sub-Category Breakdown',
                  style: TextStyle(
                      color: AnalyticsTheme.accent,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 8.h),
              ...ci.subCategories.map((sub) => _SubCategoryRow(sub: sub)),
            ],

            // Action Items
            if (ci.actionItems.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Action Items',
                  style: TextStyle(
                      color: AnalyticsTheme.accent,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 8.h),
              ...ci.actionItems.map((item) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w)
                        .copyWith(bottom: 6.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle,
                            color: InvoiceThemeColors.primaryPurple,
                            size: 16.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                                color: const Color(0xFFD1D5DB),
                                fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
            SizedBox(height: 16.h),
          ],
        ],
      ),
    );
  }
}

class _SubCategoryRow extends StatelessWidget {
  final SubCategoryInsightData sub;

  const _SubCategoryRow({required this.sub});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 10.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.r),
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
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 78, 3, 208),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      sub.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                if (sub.amount > 0)
                  Text(
                    CurrencySymbols.formatAmount(sub.amount),
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  ),
              ],
            ),
            if (sub.insight.isNotEmpty) ...[
              SizedBox(height: 4.h),
              Text(
                sub.insight,
                style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                    height: 1.4),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Existing cards ─────────────────────────────────────────────────

class _RecommendationCard extends StatelessWidget {
  final BudgetRecommendationData rec;

  const _RecommendationCard({required this.rec});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                rec.categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: rec.difference <= 0
                      ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2)
                      : const Color(0xFFEF4444).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  rec.difference <= 0 ? 'Within Budget' : 'Over Budget',
                  style: TextStyle(
                    color: rec.difference <= 0
                        ? AnalyticsTheme.accent
                        : const Color(0xFFEF4444),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _StatLine(
                    label: 'Current',
                    value: CurrencySymbols.formatAmount(rec.currentAmount)),
              ),
              Expanded(
                child: _StatLine(
                    label: 'Recommended',
                    value: CurrencySymbols.formatAmount(rec.recommendedAmount)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            rec.reasoning,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  final String label;
  final String value;

  const _StatLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// ── Enhanced Loading View ──────────────────────────────────────────

class _LoadingView extends StatefulWidget {
  const _LoadingView();

  @override
  State<_LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<_LoadingView>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _progressController;
  int _messageIndex = 0;

  static const _messages = [
    'Analyzing your spending patterns...',
    'Reviewing category breakdowns...',
    'Evaluating sub-category trends...',
    'Comparing with recommended budgets...',
    'Generating savings opportunities...',
    'Building personalized insights...',
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..forward();

    // Cycle through messages
    _cycleMessages();
  }

  void _cycleMessages() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _messageIndex = (_messageIndex + 1) % _messages.length;
        });
        _cycleMessages();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          // Animated AI icon
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color.fromARGB(255, 78, 3, 208).withValues(
                          alpha: 0.3 + _pulseController.value * 0.2),
                      InvoiceThemeColors.primaryPurple.withValues(
                          alpha: 0.1 + _pulseController.value * 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: Color.lerp(
                    const Color.fromARGB(255, 78, 3, 208),
                    InvoiceThemeColors.primaryPurple,
                    _pulseController.value,
                  ),
                  size: 48.sp,
                ),
              );
            },
          ),
          SizedBox(height: 32.h),

          // Title
          Text(
            'AI is analyzing your finances',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),

          // Rotating subtitle
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Text(
              _messages[_messageIndex],
              key: ValueKey<int>(_messageIndex),
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 32.h),

          // Progress bar
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: _progressController.value * 0.9,
                      backgroundColor: const Color(0xFF2D2D2D),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 78, 3, 208)),
                      minHeight: 6.h,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${(_progressController.value * 90).toInt()}%',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 40.h),

          // Shimmer cards
          ..._buildShimmerCards(),
        ],
      ),
    );
  }

  List<Widget> _buildShimmerCards() {
    return List.generate(3, (index) {
      return AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          final opacity = 0.03 + _pulseController.value * 0.04;
          return Container(
            height: 80.h,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: opacity),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 14.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: opacity),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 10.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: opacity * 0.7),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

// ── No-data empty state ────────────────────────────────────────────
// Shown when there's no spending/income/budget data to analyse, so the AI
// isn't asked to invent insights from nothing.
class _NoDataView extends StatelessWidget {
  final VoidCallback onRetry;

  const _NoDataView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88.w,
              height: 88.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.12),
              ),
              child: Icon(Icons.insights_outlined,
                  color: InvoiceThemeColors.primaryPurple, size: 44.sp),
            ),
            SizedBox(height: 24.h),
            Text(
              'No spending data yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'AI insights need something to work with. Link a bank account or '
              'make a few transactions, then check back. The AI will analyse '
              'your spending, budgets and goals here.',
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 14.sp, height: 1.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Check again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.primaryPurple,
                foregroundColor: Colors.white,
                minimumSize: Size(180.w, 48.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFF9CA3AF)),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.primaryPurple,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

/// Renders one entry of the AI's `spending_patterns` map as real UI.
///
/// WHY THIS EXISTS
/// ---------------
/// The value arrives as `Map<String, dynamic>` and was rendered with
/// `entry.value.toString()`. When the model returned a list, Dart printed its
/// own debug form and the user read:
///
///     Spending Patterns [Potential building, Discretionary heavy, ...]
///
/// Square brackets and comma-joined items are a Dart data structure leaking
/// through the screen. A list of findings is a list in the UI too: one row per
/// item, each with its own marker.
class _SpendingPatternTile extends StatelessWidget {
  const _SpendingPatternTile({required this.label, required this.value});

  final String label;
  final dynamic value;

  static const _muted = Color(0xFF9CA3AF);

  /// `savings_rate` -> `Savings rate`.
  String get _displayLabel {
    final words = label.replaceAll('_', ' ').replaceAll('-', ' ').trim();
    if (words.isEmpty) return 'Pattern';
    return words[0].toUpperCase() + words.substring(1);
  }

  /// Flattens a leaf value to display text. Percentages and amounts arrive as
  /// numbers, so they are formatted rather than printed with Dart's trailing
  /// `.0`.
  static String _leafText(dynamic v) {
    if (v is num) {
      final asDouble = v.toDouble();
      return asDouble == asDouble.roundToDouble()
          ? asDouble.toStringAsFixed(0)
          : asDouble.toStringAsFixed(2);
    }
    if (v is bool) return v ? 'Yes' : 'No';
    return v?.toString().trim() ?? '';
  }

  Widget _bullet(String text) => Padding(
        padding: EdgeInsets.only(top: 6.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.h, right: 8.w),
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFF34D399),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white, fontSize: 13.sp, height: 1.45),
              ),
            ),
          ],
        ),
      );

  /// One `key: value` row, for a nested map such as
  /// `{"essential": 62, "discretionary": 38}`.
  Widget _pair(String key, dynamic v) {
    final name = key.replaceAll('_', ' ');
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              name.isEmpty ? '' : name[0].toUpperCase() + name.substring(1),
              style: TextStyle(color: _muted, fontSize: 12.5.sp),
            ),
          ),
          SizedBox(width: 10.w),
          Text(
            _leafText(v),
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    if (value is List) {
      final items =
          (value as List).map(_leafText).where((t) => t.isNotEmpty).toList();
      // An empty list is not a finding; say nothing rather than show a header
      // with nothing under it.
      if (items.isEmpty) return const SizedBox.shrink();
      children.addAll(items.map(_bullet));
    } else if (value is Map) {
      final entries = (value as Map)
          .entries
          .where((e) => _leafText(e.value).isNotEmpty)
          .toList();
      if (entries.isEmpty) return const SizedBox.shrink();
      children.addAll(entries.map((e) => _pair(e.key.toString(), e.value)));
    } else {
      final text = _leafText(value);
      if (text.isEmpty) return const SizedBox.shrink();
      children.add(Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 13.sp, height: 1.45),
        ),
      ));
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights_rounded,
                  color: const Color(0xFF34D399), size: 15.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  _displayLabel,
                  style: TextStyle(
                    color: AnalyticsTheme.accent,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 23.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
