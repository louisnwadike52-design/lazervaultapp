import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../../../core/services/injection_container.dart';
import '../../data/services/crowdfund_share_service.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../widgets/creator_profile_card.dart';
import '../widgets/donor_card.dart';
import '../widgets/progress_indicator_widget.dart';
import 'crowdfund_report_screen.dart';
import 'donation_payment_screen.dart';

class CrowdfundDetailsScreen extends StatefulWidget {
  final String crowdfundId;

  const CrowdfundDetailsScreen({
    super.key,
    required this.crowdfundId,
  });

  @override
  State<CrowdfundDetailsScreen> createState() => _CrowdfundDetailsScreenState();
}

class _CrowdfundDetailsScreenState extends State<CrowdfundDetailsScreen>
    with WidgetsBindingObserver {
  // Scroll controller drives the "load more donations" trigger. Anchored
  // to the outer CustomScrollView so we can fire when the user reaches
  // the bottom of the page rather than tracking a separate ListView.
  final ScrollController _scrollController = ScrollController();

  /// Last successful CrowdfundDetailsLoaded snapshot. The cubit is
  /// shared with the AI report sub-flow, which emits its own report
  /// states on the same instance. When that screen pops back, the
  /// cubit's current state may be CrowdfundReportGenerated — without
  /// this cache _buildBody would render an empty SizedBox and the user
  /// would see a black screen. Re-rendering from the last snapshot
  /// keeps the page populated until loadCrowdfundDetails refreshes.
  CrowdfundDetailsLoaded? _lastDetails;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController.addListener(_onScroll);
    // Data loading is triggered by the route's BlocProvider (..loadCrowdfundDetails())
    // Only reload if the cubit is in initial state (no data loaded yet)
    final state = context.read<CrowdfundCubit>().state;
    if (state is CrowdfundInitial) {
      context.read<CrowdfundCubit>().loadCrowdfundDetails(widget.crowdfundId);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Foreground refresh: when the app comes back from the background
    // and this screen is still on top, kick off an SWR revalidation so
    // counters / donations don't sit on stale data. The SWR layer
    // skips the network call when nothing is stale.
    if (state == AppLifecycleState.resumed && mounted) {
      context.read<CrowdfundCubit>().loadCrowdfundDetails(widget.crowdfundId);
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels < position.maxScrollExtent - 240) return;

    final state = context.read<CrowdfundCubit>().state;
    if (state is! CrowdfundDetailsLoaded ||
        !state.hasMoreDonations ||
        state.isLoadingMoreDonations) {
      return;
    }
    context.read<CrowdfundCubit>().loadMoreDonations();
  }

  void _exitToCrowdfundHome() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      Get.offAllNamed(AppRoutes.crowdfund);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CrowdfundCubit, CrowdfundState>(
      // Skip repaints triggered by sibling cubit operations on the
      // shared instance: report generation states, my-campaigns /
      // user-donations refreshes, leaderboard loads, etc. Only the
      // states actually rendered by this screen should drive a build.
      // Without this, opening the AI report repaints the whole
      // details tree on every report state transition.
      buildWhen: (prev, curr) =>
          curr is CrowdfundDetailsLoaded ||
          curr is CrowdfundLoading ||
          curr is CrowdfundError ||
          curr is CrowdfundInitial,
      // Only fire side-effects (snackbars) for state transitions that
      // this screen drove. The cubit is shared with sibling features
      // (report flow, list refresh, my-campaigns) — without listenWhen
      // a CrowdfundError emitted by an unrelated background fetch
      // would pop a snackbar on top of the donor list.
      listenWhen: (prev, curr) =>
          curr is CrowdfundError && prev is! CrowdfundError,
      listener: (context, state) {
        if (state is CrowdfundError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CrowdfundDetailsLoaded) {
          _lastDetails = state;
        }
        Crowdfund? crowdfund;
        final renderState =
            state is CrowdfundDetailsLoaded ? state : _lastDetails;
        if (renderState != null) {
          crowdfund = renderState.crowdfund;
        }

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            _exitToCrowdfundHome();
          },
          child: Scaffold(
            backgroundColor: const Color(0xFF0A0A0A),
            body: _buildBody(state),
            floatingActionButton: crowdfund != null &&
                    crowdfund.isActive &&
                    !crowdfund.isExpired
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<CrowdfundCubit>(),
                            child: DonationPaymentScreen(crowdfund: crowdfund!),
                          ),
                        ),
                      );
                    },
                    backgroundColor: const Color(0xFF4E03D0),
                    icon: const Icon(Icons.volunteer_activism, color: Colors.white),
                    label: Text(
                      'Donate',
                      style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                  )
                : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
        );
      },
    );
  }

  Widget _buildBody(CrowdfundState state) {
    if (state is CrowdfundDetailsLoaded) {
      return _buildDetails(state);
    }
    // Fallback: while the cubit is in a sibling state (report flow,
    // statistics, generic loading) keep showing the last good details
    // so we never bottom out at a black screen.
    final fallback = _lastDetails;
    if (fallback != null) {
      return _buildDetails(fallback);
    }
    if (state is CrowdfundError) {
      return _buildErrorBody(state.message);
    }
    if (state is CrowdfundLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF4E03D0)));
    }
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF4E03D0)),
    );
  }

  Widget _buildErrorBody(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 16.h),
            Text('Failed to load campaign',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 8.h),
            Text(message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () => context
                  .read<CrowdfundCubit>()
                  .loadCrowdfundDetails(widget.crowdfundId),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
              ),
              child: Text('Retry',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(CrowdfundDetailsLoaded state) {
    final crowdfund = state.crowdfund;
    final donations = state.donations;
    final statistics = state.statistics;
    // Total donor count surface uses the server-maintained denormalized
    // counter so the header doesn't lie when only the first page of
    // donations is loaded.
    final donorCount = crowdfund.donorCount > 0
        ? crowdfund.donorCount
        : donations.length;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          expandedHeight: crowdfund.imageUrl != null ? 180.h : 0,
          pinned: true,
          backgroundColor: const Color(0xFF0A0A0A),
          // Subtle revalidation indicator while SWR refreshes in the
          // background. Renders a 2-px progress bar pinned to the
          // bottom of the app bar; invisible when fresh so it doesn't
          // shift any layout below.
          bottom: state.isStale
              ? const PreferredSize(
                  preferredSize: Size.fromHeight(2),
                  child: LinearProgressIndicator(
                    minHeight: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
                    backgroundColor: Color(0xFF1F1F1F),
                  ),
                )
              : null,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: _exitToCrowdfundHome,
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              color: const Color(0xFF1F1F1F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              onSelected: (value) {
                switch (value) {
                  case 'report':
                    _navigateToReport(crowdfund, donations, statistics);
                    break;
                  case 'share':
                    _shareCrowdfund(crowdfund);
                    break;
                  case 'copy_code':
                    _copyCrowdfundCode(crowdfund);
                    break;
                }
              },
              itemBuilder: (_) => [
                _menuItem(value: 'report', icon: Icons.auto_awesome, label: 'AI Report'),
                _menuItem(value: 'share', icon: Icons.share, label: 'Share'),
                _menuItem(value: 'copy_code', icon: Icons.content_copy, label: 'Copy code'),
              ],
            ),
          ],
          flexibleSpace: crowdfund.imageUrl != null
              ? FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: crowdfund.imageUrl!,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 180),
                    placeholder: (context, _) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)]),
                      ),
                    ),
                    errorWidget: (context, error, stackTrace) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)]),
                      ),
                      child: Center(child: Icon(Icons.image_not_supported, color: Colors.grey[600], size: 48.sp)),
                    ),
                  ),
                )
              : null,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  crowdfund.title,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8.h),
                // Status + category + code badges
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: [
                    _buildStatusPill(crowdfund),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        crowdfund.category,
                        style: GoogleFonts.inter(color: const Color(0xFF4E03D0), fontSize: 11.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        crowdfund.crowdfundCode,
                        style: TextStyle(color: const Color(0xFF4E03D0), fontSize: 11.sp, fontWeight: FontWeight.w600, fontFamily: 'monospace'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Creator profile
                CreatorProfileCard(
                  creator: crowdfund.creator,
                  showFullDetails: false,
                  onTap: () => _showCreatorDetailsDialog(crowdfund.creator),
                ),
                SizedBox(height: 12.h),
                // Progress section (compact)
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Raised', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 10.sp)),
                              Text(
                                '${crowdfund.currency} ${crowdfund.currentAmount.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(color: const Color(0xFF4E03D0), fontSize: 18.sp, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Goal', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 10.sp)),
                              Text(
                                '${crowdfund.currency} ${crowdfund.targetAmount.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      CrowdfundProgressIndicator(progressPercentage: crowdfund.progressPercentage, showMilestones: true),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStat(icon: Icons.people, label: 'Donors', value: crowdfund.donorCount.toString()),
                          if (crowdfund.hasDeadline)
                            _buildStat(
                              icon: Icons.access_time,
                              label: 'Days Left',
                              value: crowdfund.daysRemaining.toString(),
                              isWarning: crowdfund.daysRemaining < 7,
                            ),
                          if (crowdfund.donorCount > 0)
                            _buildStat(
                              icon: Icons.analytics,
                              label: 'Avg',
                              value: '${crowdfund.currency} ${crowdfund.averageDonation.toStringAsFixed(0)}',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                _buildShareLinkCard(crowdfund),
                SizedBox(height: 12.h),
                // Description
                Text('About', style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                SizedBox(height: 4.h),
                Text(
                  crowdfund.description,
                  style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.sp, height: 1.4),
                ),
                // Story
                if (crowdfund.story.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  Text('Story', style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                  SizedBox(height: 4.h),
                  Text(
                    crowdfund.story,
                    style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.sp, height: 1.4),
                  ),
                ],
                SizedBox(height: 12.h),
                // Donors section. The header count uses the server-side
                // donor count rather than the loaded page so it doesn't
                // jump as more pages stream in.
                Text(
                  'Donors ($donorCount)',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8.h),
                if (donations.isEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 18.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.volunteer_activism,
                            color: const Color(0xFF4E03D0),
                            size: 18.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('No donations yet',
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(height: 2.h),
                              Text(
                                crowdfund.isActive && !crowdfund.isExpired
                                    ? 'Be the first to back this campaign.'
                                    : 'No one donated before this campaign closed.',
                                style: GoogleFonts.inter(
                                    color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...donations.map((donation) => DonorCard(
                        donation: donation,
                        crowdfund: crowdfund,
                      )),
                _buildDonationsPaginationFooter(state),
                SizedBox(height: 80.h), // FAB clearance
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Renders the bottom of the donor list:
  ///   - spinner while a `loadMoreDonations` round-trip is in flight,
  ///   - an explicit "Load more" button so the user can recover if the
  ///     scroll trigger doesn't fire on a short page (keyboard, fold),
  ///   - nothing once we've reached the end.
  Widget _buildDonationsPaginationFooter(CrowdfundDetailsLoaded state) {
    if (state.donations.isEmpty) return const SizedBox.shrink();

    if (state.isLoadingMoreDonations) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              color: Color(0xFF4E03D0),
              strokeWidth: 2,
            ),
          ),
        ),
      );
    }
    if (state.hasMoreDonations) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Center(
          child: TextButton(
            onPressed: () =>
                context.read<CrowdfundCubit>().loadMoreDonations(),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF4E03D0),
            ),
            child: Text(
              'Load more',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }
    if (state.donations.length >= state.donationsPageSize) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Center(
          child: Text(
            "You've reached the end",
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  PopupMenuItem<String> _menuItem({
    required String value,
    required IconData icon,
    required String label,
  }) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4E03D0), size: 18.sp),
          SizedBox(width: 12.w),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  ({Color color, String label, IconData icon}) _statusVisuals(Crowdfund c) {
    if (c.isExpired && c.isActive) {
      return (
        color: const Color(0xFFEF4444),
        label: 'Expired',
        icon: Icons.access_time_filled,
      );
    }
    if (c.isCompleted) {
      return (
        color: const Color(0xFF10B981),
        label: 'Completed',
        icon: Icons.verified,
      );
    }
    if (c.isCancelled) {
      return (
        color: const Color(0xFFEF4444),
        label: 'Cancelled',
        icon: Icons.block,
      );
    }
    if (c.isPaused) {
      return (
        color: const Color(0xFFF59E0B),
        label: 'Paused',
        icon: Icons.pause_circle,
      );
    }
    return (
      color: const Color(0xFF4E03D0),
      label: 'Active',
      icon: Icons.bolt,
    );
  }

  Widget _buildStatusPill(Crowdfund c) {
    final v = _statusVisuals(c);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: v.color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(v.icon, size: 11.sp, color: v.color),
          SizedBox(width: 4.w),
          Text(
            v.label,
            style: GoogleFonts.inter(
              color: v.color,
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required String label,
    required String value,
    bool isWarning = false,
  }) {
    return Column(
      children: [
        Icon(icon, color: isWarning ? const Color(0xFFF59E0B) : const Color(0xFF4E03D0), size: 14.sp),
        SizedBox(height: 2.h),
        Text(value, style: GoogleFonts.inter(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w700)),
        Text(label, style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 9.sp)),
      ],
    );
  }

  void _shareCrowdfund(Crowdfund crowdfund) {
    SharePlus.instance.share(ShareParams(
      text: 'Support my crowdfunding campaign: ${crowdfund.title}\n\n'
          'Code: ${crowdfund.crowdfundCode}\n'
          'Target: ${crowdfund.currency} ${crowdfund.targetAmount.toStringAsFixed(2)}\n'
          'Raised: ${crowdfund.currency} ${crowdfund.currentAmount.toStringAsFixed(2)}\n\n'
          'Help me reach my goal!',
      subject: crowdfund.title,
    ));
  }

  void _copyCrowdfundCode(Crowdfund crowdfund) {
    Clipboard.setData(ClipboardData(text: crowdfund.crowdfundCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Crowdfund code copied to clipboard'),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 2),
      ),
    );
  }

  /// Public share link card. Anyone with this URL can fund the campaign;
  /// the URL pattern is `<base>/crowdfund/<id>` where `<base>` comes from
  /// CrowdfundShareService (configurable via the admin dashboard).
  Widget _buildShareLinkCard(Crowdfund crowdfund) {
    final url = serviceLocator<CrowdfundShareService>().shareUrlFor(crowdfund.id);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4E03D0).withValues(alpha: 0.18),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.ios_share, size: 18.sp, color: const Color(0xFF4E03D0)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share link (anyone can fund)',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4E03D0),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  url,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            tooltip: 'Copy link',
            onPressed: () => _copyShareLink(url),
            icon: Icon(Icons.copy, size: 18.sp, color: const Color(0xFF4E03D0)),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: 8.w),
          IconButton(
            tooltip: 'Share',
            onPressed: () => _shareLink(crowdfund, url),
            icon: Icon(Icons.share, size: 18.sp, color: const Color(0xFF4E03D0)),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  void _copyShareLink(String url) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share link copied'),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _shareLink(Crowdfund crowdfund, String url) {
    SharePlus.instance.share(
      ShareParams(
        text: 'Support "${crowdfund.title}" on LazerVault: $url',
        subject: crowdfund.title,
      ),
    );
  }

  void _showCreatorDetailsDialog(CrowdfundCreator creator) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxWidth: 320.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Campaign Creator', style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.close, color: Colors.white70, size: 18.sp),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 32.r,
                          backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                          backgroundImage: creator.profilePicture != null ? NetworkImage(creator.profilePicture!) : null,
                          child: creator.profilePicture == null
                              ? Text(creator.initials, style: TextStyle(color: const Color(0xFF4E03D0), fontSize: 20.sp, fontWeight: FontWeight.bold))
                              : null,
                        ),
                        if (creator.verified)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(3.w),
                              decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                              child: Icon(Icons.verified, color: Colors.white, size: 14.sp),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text('${creator.firstName} ${creator.lastName}', style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                    SizedBox(height: 2.h),
                    Text('@${creator.username}', style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.grey[400])),
                  ],
                ),
              ),
              if (creator.verified || creator.facialRecognitionEnabled)
                Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    children: [
                      if (creator.verified)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.verified_user, color: const Color(0xFF10B981), size: 14.sp),
                              SizedBox(width: 6.w),
                              Text('Verified Creator', style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
                            ],
                          ),
                        ),
                      if (creator.facialRecognitionEnabled) ...[
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(Icons.face_retouching_natural, color: const Color(0xFF4E03D0), size: 14.sp),
                            SizedBox(width: 6.w),
                            Text('Facial Recognition Enabled', style: GoogleFonts.inter(fontSize: 11.sp, color: Colors.grey[400])),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToReport(Crowdfund crowdfund, List<CrowdfundDonation> donations, CrowdfundStatistics? statistics) async {
    final campaignUrl = 'https://app.lazervault.com/crowdfund/${crowdfund.crowdfundCode}';
    final cubit = context.read<CrowdfundCubit>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: CrowdfundReportScreen(
            crowdfund: crowdfund,
            statistics: statistics,
            donations: donations,
            campaignUrl: campaignUrl,
          ),
        ),
      ),
    );
    // After the report screen pops, the cubit state is in one of the
    // CrowdfundReport* variants. Re-emit CrowdfundDetailsLoaded so the
    // builder picks up a fresh details payload (stale-while-revalidate
    // through the SWR cache makes this near-instant).
    if (!mounted) return;
    cubit.loadCrowdfundDetails(crowdfund.id);
  }
}
