import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/share_group_report_bottom_sheet.dart';

/// Screen displaying AI-generated group account report with swipeable cards
class GroupAccountReportScreen extends StatelessWidget {
  final GroupAccount group;
  final List<Contribution> contributions;
  final List<GroupMember>? members;
  final String? groupUrl;

  const GroupAccountReportScreen({
    super.key,
    required this.group,
    required this.contributions,
    this.members,
    this.groupUrl,
  });

  static MaterialPageRoute route({
    required GroupAccount group,
    required List<Contribution> contributions,
    List<GroupMember>? members,
    String? groupUrl,
  }) {
    return MaterialPageRoute(
      builder: (context) => GroupAccountReportScreen(
        group: group,
        contributions: contributions,
        members: members,
        groupUrl: groupUrl,
      ),
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Generate report when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GroupAccountCubit>().generateReport(
            group: group,
            contributions: contributions,
            members: members,
            groupUrl: groupUrl,
          );
    });

    return _GroupAccountReportContent(
      group: group,
      contributions: contributions,
      groupUrl: groupUrl,
    );
  }
}

class _GroupAccountReportContent extends StatefulWidget {
  final GroupAccount group;
  final List<Contribution> contributions;
  final String? groupUrl;

  const _GroupAccountReportContent({
    required this.group,
    required this.contributions,
    this.groupUrl,
  });

  @override
  State<_GroupAccountReportContent> createState() =>
      _GroupAccountReportContentState();
}

class _GroupAccountReportContentState extends State<_GroupAccountReportContent> {
  late PageController _pageController;
  int _currentPage = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocConsumer<GroupAccountCubit, GroupAccountState>(
        listener: (context, state) {
          if (state is GroupAccountReportShared) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Report shared successfully'),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
          } else if (state is GroupAccountReportShareError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GroupAccountReportLoading) {
            return _LoadingView(message: state.message);
          }

          if (state is GroupAccountError) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context.read<GroupAccountCubit>().generateReport(
                    group: widget.group,
                    contributions: widget.contributions,
                    groupUrl: widget.groupUrl,
                  ),
              onClose: () => Navigator.of(context).pop(),
            );
          }

          if (state is GroupAccountReportGenerated) {
            return _LoadedView(
              report: state.report,
              group: state.group,
              contributions: state.contributions,
              groupUrl: state.groupUrl,
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

  void _showShareSheet(BuildContext context, GroupAccountReport report) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareGroupReportBottomSheet(
        report: report,
        groupUrl: widget.groupUrl,
      ),
    );
  }

  void _copyToClipboard(BuildContext context, GroupAccountReport report) {
    final text = context.read<GroupAccountCubit>().getShareableText(
          report,
          widget.groupUrl,
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
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 78, 3, 208), Color.fromARGB(255, 78, 3, 208)],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 24.h),
            Text(
              message ?? 'Generating AI report...',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'This may take a moment',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13.sp,
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
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Color(0xFF9CA3AF),
              ),
              SizedBox(height: 24.h),
              Text(
                'Report Generation Failed',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                message,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: const Icon(Icons.refresh),
                label: Text(
                  'Try Again',
                  style: GoogleFonts.inter(fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: onClose,
                child: Text(
                  'Go Back',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
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

class _LoadedView extends StatelessWidget {
  final GroupAccountReport report;
  final GroupAccount group;
  final List<Contribution> contributions;
  final String? groupUrl;
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onShare;
  final VoidCallback onCopy;
  final VoidCallback onClose;

  const _LoadedView({
    required this.report,
    required this.group,
    required this.contributions,
    required this.groupUrl,
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
            _SummaryCard(report: report, group: group),
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
  final GroupAccountReport report;
  final GroupAccount group;

  const _SummaryCard({
    required this.report,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 78, 3, 208), Color.fromARGB(255, 78, 3, 208)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 48,
              ),
              SizedBox(height: 24.h),
              Text(
                report.title,
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  group.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                report.summary,
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14.sp,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.swipe,
                    color: Colors.white54,
                    size: 20,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Swipe to continue',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp,
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
  final GroupAccountReport report;

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
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 48,
              ),
              SizedBox(height: 24.h),
              Text(
                'Your Impact',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    report.impactStory.isNotEmpty
                        ? report.impactStory
                        : 'Your group is making a difference together!',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14.sp,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              if (report.callToAction.isNotEmpty)
                Text(
                  report.callToAction,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
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
  final GroupAccountReport report;

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
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.people,
                color: Colors.white,
                size: 48,
              ),
              SizedBox(height: 24.h),
              Text(
                'Contributor Highlights',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32.h),
              Expanded(
                child: report.contributorHighlights.isEmpty
                    ? Center(
                        child: Text(
                          'No contributions yet. Be the first!',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: report.contributorHighlights.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32.w,
                                    height: 32.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      report.contributorHighlights[index],
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 13.sp,
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
  final GroupAccountReport report;

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
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.flag,
                color: Colors.white,
                size: 48,
              ),
              SizedBox(height: 24.h),
              Text(
                'Milestones',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32.h),
              Expanded(
                child: report.milestones.isEmpty
                    ? Center(
                        child: Text(
                          'Keep going! Your first milestone is within reach.',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: report.milestones.length,
                        itemBuilder: (context, index) {
                          final milestone = report.milestones[index];
                          final isReached = milestone['is_reached'] == true;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12.r),
                                border: isReached
                                    ? Border.all(
                                        color: Colors.white.withValues(alpha: 0.5),
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isReached ? Icons.check_circle : Icons.radio_button_unchecked,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          milestone['title']?.toString() ?? 'Milestone',
                                          style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                        if (milestone['description'] != null)
                                          Text(
                                            milestone['description'].toString(),
                                            style: GoogleFonts.inter(
                                              color: Colors.white.withValues(alpha: 0.8),
                                              fontSize: 13.sp,
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
  final GroupAccountReport report;
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
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.share,
                color: Colors.white,
                size: 48,
              ),
              SizedBox(height: 24.h),
              Text(
                'Share Your Story',
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Spread the word and help your group grow!',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              // Hashtags
              if (report.hashtags.isNotEmpty)
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  alignment: WrapAlignment.center,
                  children: report.hashtags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        '#$tag',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 13.sp,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              SizedBox(height: 48.h),
              // Share button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onShare,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFEC4899),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: const Icon(Icons.share),
                  label: Text(
                    'Share Report',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // Copy button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onCopy,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: const Icon(Icons.copy),
                  label: Text(
                    'Copy Text',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              TextButton(
                onPressed: onClose,
                child: Text(
                  'Done',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
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
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: isActive ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
