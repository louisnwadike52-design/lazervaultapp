import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/wrapped_types_stub.dart';
import '../../cubit/wrapped_cubit.dart';
import '../../cubit/wrapped_state.dart';
import '../../data/statistics_repository.dart';
import '../widgets/wrapped/wrapped_summary_card.dart';
import '../widgets/wrapped/wrapped_top_categories_card.dart';
import '../widgets/wrapped/wrapped_top_merchants_card.dart';
import '../widgets/wrapped/wrapped_trends_card.dart';
import '../widgets/wrapped/wrapped_ai_insights_card.dart';
import '../widgets/wrapped/wrapped_fun_facts_card.dart';
import '../widgets/wrapped/wrapped_achievements_card.dart';
import '../widgets/wrapped/wrapped_share_card.dart';

/// Main Financial Wrapped screen with swipeable cards
class WrappedScreen extends StatelessWidget {
  final int? year;
  final int? month;
  final WrappedPeriod period;

  const WrappedScreen({
    super.key,
    this.year,
    this.month,
    this.period = WrappedPeriod.WRAPPED_PERIOD_YEARLY,
  });

  static MaterialPageRoute route({
    int? year,
    int? month,
    WrappedPeriod period = WrappedPeriod.WRAPPED_PERIOD_YEARLY,
  }) {
    return MaterialPageRoute(
      builder: (context) => WrappedScreen(
        year: year,
        month: month,
        period: period,
      ),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WrappedCubit(
        repository: context.read<StatisticsRepository>(),
      )..loadWrapped(
          period: period,
          year: year ?? DateTime.now().year,
          month: month,
        ),
      child: _WrappedScreenContent(
        year: year ?? DateTime.now().year,
      ),
    );
  }
}

class _WrappedScreenContent extends StatefulWidget {
  final int year;

  const _WrappedScreenContent({required this.year});

  @override
  State<_WrappedScreenContent> createState() => _WrappedScreenContentState();
}

class _WrappedScreenContentState extends State<_WrappedScreenContent> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<WrappedCubit, WrappedState>(
        listener: (context, state) {
          if (state is WrappedLoaded) {
            if (_pageController.hasClients) {
              _animateToPage(state.currentCardIndex);
            }
          }
        },
        builder: (context, state) {
          if (state is WrappedLoading) {
            return _LoadingView(message: state.loadingMessage);
          }

          if (state is WrappedError) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context.read<WrappedCubit>().retry(),
            );
          }

          if (state is WrappedLoaded) {
            return _LoadedView(
              state: state,
              pageController: _pageController,
              year: widget.year,
              onPageChanged: (index) {
                HapticFeedback.lightImpact();
                context.read<WrappedCubit>().goToCard(index);
              },
              onShare: () => _shareWrapped(context, state.wrapped),
              onReplay: () {
                context.read<WrappedCubit>().reset();
                _animateToPage(0);
              },
              onClose: () => Navigator.of(context).pop(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _shareWrapped(BuildContext context, FinancialWrapped wrapped) {
    final summary = wrapped.summary;
    final shareText = '''
My ${wrapped.year} Financial Wrapped!

Total Spent: \$${summary?.totalSpent.toStringAsFixed(2) ?? '0.00'}
Total Saved: \$${summary?.totalSaved.toStringAsFixed(2) ?? '0.00'}
Savings Rate: ${summary?.savingsRate.toStringAsFixed(1) ?? '0.0'}%
Transactions: ${summary?.transactionCount ?? 0}

${wrapped.aiInsights?.financialPersona ?? ''}

Shared from LazerVault
''';

    Share.share(shareText, subject: 'My ${wrapped.year} Financial Wrapped');
  }
}

class _LoadingView extends StatelessWidget {
  final String? message;

  const _LoadingView({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 24),
            Text(
              message ?? 'Generating your wrapped...',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This may take a moment',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.7),
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

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF232526), Color(0xFF414345)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.white54,
              ),
              const SizedBox(height: 24),
              Text(
                'Oops! Something went wrong',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final WrappedLoaded state;
  final PageController pageController;
  final int year;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onShare;
  final VoidCallback onReplay;
  final VoidCallback onClose;

  const _LoadedView({
    required this.state,
    required this.pageController,
    required this.year,
    required this.onPageChanged,
    required this.onShare,
    required this.onReplay,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final wrapped = state.wrapped;

    return Stack(
      children: [
        // PageView with cards
        PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const BouncingScrollPhysics(),
          children: [
            // 1. Summary Card
            WrappedSummaryCard(
              summary: wrapped.summary ?? WrappedSummary(),
              year: year,
            ),
            // 2. Top Categories Card
            WrappedTopCategoriesCard(
              categories: wrapped.topCategories,
            ),
            // 3. Top Merchants Card
            WrappedTopMerchantsCard(
              merchants: wrapped.topMerchants,
            ),
            // 4. Trends Card
            WrappedTrendsCard(
              trends: wrapped.trends ?? WrappedTrends(),
            ),
            // 5. AI Insights Card
            WrappedAIInsightsCard(
              aiInsights: wrapped.aiInsights ?? WrappedAIInsights(),
            ),
            // 6. Fun Facts Card
            WrappedFunFactsCard(
              funFacts: wrapped.funFacts,
            ),
            // 7. Achievements Card
            WrappedAchievementsCard(
              achievements: wrapped.achievements,
            ),
            // 8. Share Card
            WrappedShareCard(
              wrapped: wrapped,
              onShare: onShare,
              onReplay: onReplay,
              onClose: onClose,
            ),
          ],
        ),
        // Close button
        Positioned(
          top: MediaQuery.of(context).padding.top + 16,
          right: 16,
          child: IconButton(
            onPressed: onClose,
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        // Progress indicator
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 16,
          left: 24,
          right: 24,
          child: _ProgressIndicator(
            currentIndex: state.currentCardIndex,
            totalCards: state.totalCards,
          ),
        ),
      ],
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalCards;

  const _ProgressIndicator({
    required this.currentIndex,
    required this.totalCards,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalCards, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
