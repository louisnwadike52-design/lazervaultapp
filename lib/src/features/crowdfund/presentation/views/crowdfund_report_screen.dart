import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../widgets/share_report_bottom_sheet.dart';

/// Screen displaying AI-generated crowdfund campaign report with swipeable cards
class CrowdfundReportScreen extends StatelessWidget {
  final Crowdfund crowdfund;
  final CrowdfundStatistics? statistics;
  final List<CrowdfundDonation>? donations;
  final String? campaignUrl;

  const CrowdfundReportScreen({
    super.key,
    required this.crowdfund,
    this.statistics,
    this.donations,
    this.campaignUrl,
  });

  static MaterialPageRoute route({
    required Crowdfund crowdfund,
    CrowdfundStatistics? statistics,
    List<CrowdfundDonation>? donations,
    String? campaignUrl,
  }) {
    return MaterialPageRoute(
      builder: (context) => CrowdfundReportScreen(
        crowdfund: crowdfund,
        statistics: statistics,
        donations: donations,
        campaignUrl: campaignUrl,
      ),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _CrowdfundReportContent(
      crowdfund: crowdfund,
      statistics: statistics,
      donations: donations,
      campaignUrl: campaignUrl,
    );
  }
}

class _CrowdfundReportContent extends StatefulWidget {
  final Crowdfund crowdfund;
  final CrowdfundStatistics? statistics;
  final List<CrowdfundDonation>? donations;
  final String? campaignUrl;

  const _CrowdfundReportContent({
    required this.crowdfund,
    this.statistics,
    this.donations,
    this.campaignUrl,
  });

  @override
  State<_CrowdfundReportContent> createState() =>
      _CrowdfundReportContentState();
}

class _CrowdfundReportContentState extends State<_CrowdfundReportContent> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Generate report once on init, not in build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CrowdfundCubit>().generateReport(
              crowdfund: widget.crowdfund,
              statistics: widget.statistics,
              donations: widget.donations,
              campaignUrl: widget.campaignUrl,
            );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocConsumer<CrowdfundCubit, CrowdfundState>(
        listener: (context, state) {
          if (state is CrowdfundReportShared) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Report shared successfully'),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          } else if (state is CrowdfundReportShareError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CrowdfundReportLoading) {
            return _LoadingView(message: state.message);
          }

          if (state is CrowdfundError) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context.read<CrowdfundCubit>().generateReport(
                    crowdfund: widget.crowdfund,
                    campaignUrl: widget.campaignUrl,
                  ),
              onClose: () => Navigator.of(context).pop(),
            );
          }

          if (state is CrowdfundReportGenerated) {
            return _LoadedView(
              report: state.report,
              crowdfund: state.crowdfund,
              campaignUrl: state.campaignUrl,
              pageController: _pageController,
              currentPage: _currentPage,
              onPageChanged: (index) {
                HapticFeedback.lightImpact();
                setState(() => _currentPage = index);
              },
              onShare: () => _showShareSheet(context, state.report),
              onCopy: () => _copyToClipboard(context, state.report),
              onClose: () => Navigator.of(context).pop(),
            );
          }

          // Initial/other states - show loading
          return _LoadingView(message: 'Preparing report...');
        },
      ),
    );
  }

  void _showShareSheet(BuildContext context, CrowdfundReport report) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareReportBottomSheet(
        report: report,
        campaignUrl: widget.campaignUrl,
      ),
    );
  }

  void _copyToClipboard(BuildContext context, CrowdfundReport report) {
    final text = context.read<CrowdfundCubit>().getShareableText(
          report,
          widget.campaignUrl,
        );
    if (text != null) {
      Clipboard.setData(ClipboardData(text: text));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard'),
          backgroundColor: Color(0xFF3B82F6),
        ),
      );
    }
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
          colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
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
              message ?? 'Generating AI report...',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'This may take a moment',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
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
  final VoidCallback onClose;

  const _ErrorView({
    required this.message,
    required this.onRetry,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0A0A),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Color(0xFF9CA3AF),
              ),
              const SizedBox(height: 24),
              Text(
                'Report Generation Failed',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF9CA3AF),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: onClose,
                child: const Text(
                  'Go Back',
                  style: TextStyle(color: Color(0xFF9CA3AF)),
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
  final CrowdfundReport report;
  final Crowdfund crowdfund;
  final String? campaignUrl;
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onShare;
  final VoidCallback onCopy;
  final VoidCallback onClose;

  const _LoadedView({
    required this.report,
    required this.crowdfund,
    required this.campaignUrl,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
    required this.onShare,
    required this.onCopy,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // PageView with cards
        PageView(
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: const BouncingScrollPhysics(),
          children: [
            // 1. Summary Card
            _SummaryCard(report: report, crowdfund: crowdfund),
            // 2. Impact Story Card
            _ImpactStoryCard(report: report),
            // 3. Contributor Highlights Card
            _ContributorHighlightsCard(report: report),
            // 4. Milestones Card
            _MilestonesCard(report: report),
            // 5. Share Card
            _ShareCard(
              report: report,
              onShare: onShare,
              onCopy: onCopy,
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
                color: Colors.black.withValues(alpha: 0.3),
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
            currentIndex: currentPage,
            totalCards: 5,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final CrowdfundReport report;
  final Crowdfund crowdfund;

  const _SummaryCard({
    required this.report,
    required this.crowdfund,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(height: 24),
              Text(
                report.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  crowdfund.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                report.summary,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.5,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.swipe,
                    color: Colors.white54,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Swipe to continue',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImpactStoryCard extends StatelessWidget {
  final CrowdfundReport report;

  const _ImpactStoryCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(height: 24),
              Text(
                'Your Impact',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    report.impactStory,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          height: 1.6,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                report.callToAction,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContributorHighlightsCard extends StatelessWidget {
  final CrowdfundReport report;

  const _ContributorHighlightsCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.people,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(height: 24),
              Text(
                'Contributor Highlights',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: report.contributorHighlights.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                report.contributorHighlights[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MilestonesCard extends StatelessWidget {
  final CrowdfundReport report;

  const _MilestonesCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.flag,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(height: 24),
              Text(
                'Milestones',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: report.milestones.isEmpty
                    ? Center(
                        child: Text(
                          'Keep going! Your first milestone is within reach.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: report.milestones.length,
                        itemBuilder: (context, index) {
                          final milestone = report.milestones[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: milestone.isReached
                                    ? Border.all(
                                        color: Colors.white.withValues(alpha: 0.5),
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    milestone.isReached
                                        ? Icons.check_circle
                                        : Icons.radio_button_unchecked,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          milestone.title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          milestone.description,
                                          style: TextStyle(
                                            color: Colors.white.withValues(alpha: 0.8),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShareCard extends StatelessWidget {
  final CrowdfundReport report;
  final VoidCallback onShare;
  final VoidCallback onCopy;
  final VoidCallback onClose;

  const _ShareCard({
    required this.report,
    required this.onShare,
    required this.onCopy,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEC4899), Color(0xFFBE185D)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.share,
                color: Colors.white,
                size: 48,
              ),
              const SizedBox(height: 24),
              Text(
                'Share Your Story',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Text(
                'Spread the word and help your campaign reach more supporters!',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Hashtags
              if (report.hashtags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: report.hashtags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '#$tag',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 48),
              // Share button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onShare,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFEC4899),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.share),
                  label: const Text(
                    'Share Report',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Copy button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onCopy,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.copy),
                  label: const Text(
                    'Copy Text',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: onClose,
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
            color: isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
