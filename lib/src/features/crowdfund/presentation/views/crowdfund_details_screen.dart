import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../widgets/creator_profile_card.dart';
import '../widgets/donor_card.dart';
import '../widgets/progress_indicator_widget.dart';
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
                        builder: (context) => DonationPaymentScreen(
                          crowdfund: crowdfund!,
                        ),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF4E03D0),
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
          color: Color(0xFF4E03D0),
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
          backgroundColor: const Color(0xFF1F1F1F),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
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
                      color: const Color(0xFF0A0A0A),
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
                    color: const Color(0xFF0A0A0A),
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
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
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        crowdfund.category,
                        style: TextStyle(
                          color: const Color(0xFF4E03D0),
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
                        color: const Color(0xFF0A0A0A),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        crowdfund.crowdfundCode,
                        style: TextStyle(
                          color: const Color(0xFF4E03D0),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Creator profile
                CreatorProfileCard(
                  creator: crowdfund.creator,
                  showFullDetails: true,
                ),
                SizedBox(height: 20.h),
                // Description
                Text(
                  'About',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  crowdfund.description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20.h),
                // Story
                if (crowdfund.story.isNotEmpty) ...[
                  Text(
                    'Story',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    crowdfund.story,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
                // Progress section
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4E03D0).withValues(alpha: 0.1),
                        const Color(0xFF6B21E0).withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
                    ),
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
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${crowdfund.currency} ${crowdfund.currentAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: const Color(0xFF4E03D0),
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Goal',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${crowdfund.currency} ${crowdfund.targetAmount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      CrowdfundProgressIndicator(
                        progressPercentage: crowdfund.progressPercentage,
                        showMilestones: true,
                        height: 10,
                      ),
                      SizedBox(height: 16.h),
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
                SizedBox(height: 24.h),
                // Donors section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Donors (${donations.length})',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
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
                          style: TextStyle(
                            color: const Color(0xFF4E03D0),
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
                            color: Colors.grey[600],
                            size: 48.sp,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'No donations yet',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Be the first to donate!',
                            style: TextStyle(
                              color: Colors.grey[600],
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
          color: isWarning ? const Color(0xFFF59E0B) : const Color(0xFF4E03D0),
          size: 20.sp,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 11.sp,
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
}
