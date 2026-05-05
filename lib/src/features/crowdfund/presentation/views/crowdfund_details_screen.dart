import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _CrowdfundDetailsScreenState extends State<CrowdfundDetailsScreen> {
  bool _showAllDonors = false;

  @override
  void initState() {
    super.initState();
    // Data loading is triggered by the route's BlocProvider (..loadCrowdfundDetails())
    // Only reload if the cubit is in initial state (no data loaded yet)
    final state = context.read<CrowdfundCubit>().state;
    if (state is CrowdfundInitial) {
      context.read<CrowdfundCubit>().loadCrowdfundDetails(widget.crowdfundId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CrowdfundCubit, CrowdfundState>(
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
        Crowdfund? crowdfund;
        if (state is CrowdfundDetailsLoaded) {
          crowdfund = state.crowdfund;
        }

        return Scaffold(
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
                  backgroundColor: const Color(0xFF6366F1),
                  icon: const Icon(Icons.volunteer_activism, color: Colors.white),
                  label: Text(
                    'Donate',
                    style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildBody(CrowdfundState state) {
    if (state is CrowdfundLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF6366F1)));
    }
    if (state is CrowdfundDetailsLoaded) {
      return _buildDetails(state.crowdfund, state.donations, state.statistics);
    }
    return const SizedBox.shrink();
  }

  Widget _buildDetails(
    Crowdfund crowdfund,
    List<CrowdfundDonation> donations,
    CrowdfundStatistics? statistics,
  ) {
    final displayedDonations = _showAllDonors ? donations : donations.take(5).toList();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: crowdfund.imageUrl != null ? 180.h : 0,
          pinned: true,
          backgroundColor: const Color(0xFF0A0A0A),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              tooltip: 'AI Report',
              onPressed: () => _navigateToReport(crowdfund, donations, statistics),
            ),
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white, size: 20),
              onPressed: () => _shareCrowdfund(crowdfund),
            ),
            IconButton(
              icon: const Icon(Icons.content_copy, color: Colors.white, size: 20),
              onPressed: () => _copyCrowdfundCode(crowdfund),
            ),
          ],
          flexibleSpace: crowdfund.imageUrl != null
              ? FlexibleSpaceBar(
                  background: Image.network(
                    crowdfund.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
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
                // Category + code badges
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        crowdfund.category,
                        style: GoogleFonts.inter(color: const Color(0xFF6366F1), fontSize: 11.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        crowdfund.crowdfundCode,
                        style: TextStyle(color: const Color(0xFF6366F1), fontSize: 11.sp, fontWeight: FontWeight.w600, fontFamily: 'monospace'),
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
                                style: GoogleFonts.inter(color: const Color(0xFF6366F1), fontSize: 18.sp, fontWeight: FontWeight.w700),
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
                          if (statistics != null)
                            _buildStat(
                              icon: Icons.analytics,
                              label: 'Avg',
                              value: '${crowdfund.currency} ${statistics.averageDonation.toStringAsFixed(0)}',
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
                // Donors section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Donors (${donations.length})',
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    if (donations.length > 5)
                      GestureDetector(
                        onTap: () => setState(() => _showAllDonors = !_showAllDonors),
                        child: Text(
                          _showAllDonors ? 'Show less' : 'View all',
                          style: GoogleFonts.inter(color: const Color(0xFF6366F1), fontSize: 13.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8.h),
                if (donations.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Column(
                        children: [
                          Icon(Icons.volunteer_activism, color: const Color(0xFF6B7280), size: 36.sp),
                          SizedBox(height: 8.h),
                          Text('No donations yet', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
                          Text('Be the first to donate!', style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 11.sp)),
                        ],
                      ),
                    ),
                  )
                else
                  ...displayedDonations.map((donation) => DonorCard(
                        donation: donation,
                        allDonations: donations,
                        crowdfund: crowdfund,
                      )),
                SizedBox(height: 80.h), // FAB clearance
              ],
            ),
          ),
        ),
      ],
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
        Icon(icon, color: isWarning ? const Color(0xFFF59E0B) : const Color(0xFF6366F1), size: 14.sp),
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
            const Color(0xFF6366F1).withValues(alpha: 0.18),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.ios_share, size: 18.sp, color: const Color(0xFF6366F1)),
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
                    color: const Color(0xFF6366F1),
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
            icon: Icon(Icons.copy, size: 18.sp, color: const Color(0xFF6366F1)),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: 8.w),
          IconButton(
            tooltip: 'Share',
            onPressed: () => _shareLink(crowdfund, url),
            icon: Icon(Icons.share, size: 18.sp, color: const Color(0xFF6366F1)),
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

  void _navigateToReport(Crowdfund crowdfund, List<CrowdfundDonation> donations, CrowdfundStatistics? statistics) {
    final campaignUrl = 'https://app.lazervault.com/crowdfund/${crowdfund.crowdfundCode}';
    final cubit = context.read<CrowdfundCubit>();
    Navigator.push(
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
  }
}
