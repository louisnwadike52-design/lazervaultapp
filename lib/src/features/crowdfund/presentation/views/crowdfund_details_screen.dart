import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';
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
    context.read<CrowdfundCubit>().loadCrowdfundDetails(widget.crowdfundId);
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
                          child: DonationPaymentScreen(
                            crowdfund: crowdfund!,
                          ),
                        ),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF6366F1),
                  icon: const Icon(Icons.volunteer_activism,
                      color: Colors.white),
                  label: Text(
                    'Donate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
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
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF6366F1),
        ),
      );
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
    final displayedDonations = _showAllDonors
        ? donations
        : donations.take(5).toList();

    return CustomScrollView(
      slivers: [
        // App bar with hero image
        SliverAppBar(
          expandedHeight: crowdfund.imageUrl != null ? 250.h : 100.h,
          pinned: true,
          backgroundColor: const Color(0xFF0A0A0A),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.auto_awesome, color: Colors.white),
              tooltip: 'Generate AI Report',
              onPressed: () => _navigateToReport(crowdfund, donations, statistics),
            ),
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () => _shareCrowdfund(crowdfund),
            ),
            IconButton(
              icon: const Icon(Icons.content_copy, color: Colors.white),
              onPressed: () => _copyCrowdfundCode(crowdfund),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: crowdfund.imageUrl != null
                ? Image.network(
                    crowdfund.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[600],
                          size: 64.sp,
                        ),
                      ),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and category
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        crowdfund.title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        crowdfund.category,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6366F1),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        crowdfund.crowdfundCode,
                        style: TextStyle(
                          color: const Color(0xFF6366F1),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Creator profile (compact - tap to expand)
                CreatorProfileCard(
                  creator: crowdfund.creator,
                  showFullDetails: false,
                  onTap: () => _showCreatorDetailsDialog(crowdfund.creator),
                ),
                SizedBox(height: 16.h),
                // Description
                Text(
                  'About',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  crowdfund.description,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20.h),
                // Story
                if (crowdfund.story.isNotEmpty) ...[
                  Text(
                    'Story',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    crowdfund.story,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
                // Progress section
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF1A1A3E),
                        const Color(0xFF0A0E27),
                        const Color(0xFF0F0F23),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Raised',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 11.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${crowdfund.currency} ${crowdfund.currentAmount.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF6366F1),
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Goal',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF),
                                  fontSize: 11.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${crowdfund.currency} ${crowdfund.targetAmount.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      CrowdfundProgressIndicator(
                        progressPercentage: crowdfund.progressPercentage,
                        showMilestones: true,
                        height: 8,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStat(
                            icon: Icons.people,
                            label: 'Donors',
                            value: crowdfund.donorCount.toString(),
                          ),
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
                              label: 'Avg Donation',
                              value: '${crowdfund.currency} ${statistics.averageDonation.toStringAsFixed(0)}',
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // Donors section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Donors (${donations.length})',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (donations.length > 5)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _showAllDonors = !_showAllDonors;
                          });
                        },
                        child: Text(
                          _showAllDonors ? 'Show less' : 'View all',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF6366F1),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 12.h),
                if (donations.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Column(
                        children: [
                          Icon(
                            Icons.volunteer_activism,
                            color: const Color(0xFF6B7280),
                            size: 48.sp,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'No donations yet',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Be the first to donate!',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF6B7280),
                              fontSize: 12.sp,
                            ),
                          ),
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
                SizedBox(height: 100.h), // Padding for FAB
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
        Icon(
          icon,
          color: isWarning ? const Color(0xFFF59E0B) : const Color(0xFF6366F1),
          size: 16.sp,
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 10.sp,
          ),
        ),
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
      SnackBar(
        content: const Text('Crowdfund code copied to clipboard'),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showCreatorDetailsDialog(CrowdfundCreator creator) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxWidth: 340.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Campaign Creator',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3D3D3D),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(Icons.close, color: Colors.white70, size: 18.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Large avatar
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                          backgroundImage: creator.profilePicture != null
                              ? NetworkImage(creator.profilePicture!)
                              : null,
                          child: creator.profilePicture == null
                              ? Text(
                                  '${creator.firstName[0]}${creator.lastName[0]}',
                                  style: TextStyle(
                                    color: const Color(0xFF4E03D0),
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : null,
                        ),
                        if (creator.verified)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.verified, color: Colors.white, size: 16.sp),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      '${creator.firstName} ${creator.lastName}',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '@${creator.username}',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    if (creator.verified) ...[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.verified_user, color: const Color(0xFF10B981), size: 16.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Verified Creator',
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF10B981),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (creator.verifiedAt != null) ...[
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.grey[500], size: 14.sp),
                            SizedBox(width: 8.w),
                            Text(
                              'Verified ${_formatCreatorDate(creator.verifiedAt!)}',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: 8.h),
                    ],
                    if (creator.facialRecognitionEnabled) ...[
                      Row(
                        children: [
                          Icon(Icons.face_retouching_natural, color: const Color(0xFF4E03D0), size: 14.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Facial Recognition Enabled',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.grey[400],
                            ),
                          ),
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

  String _formatCreatorDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  void _navigateToReport(
    Crowdfund crowdfund,
    List<CrowdfundDonation> donations,
    CrowdfundStatistics? statistics,
  ) {
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
