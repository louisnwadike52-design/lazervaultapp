import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../widgets/crowdfund_card.dart';
import 'crowdfund_details_screen.dart';

class CrowdfundListScreen extends StatefulWidget {
  const CrowdfundListScreen({super.key});

  @override
  State<CrowdfundListScreen> createState() => _CrowdfundListScreenState();
}

class _CrowdfundListScreenState extends State<CrowdfundListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  String? _selectedStatus;
  final bool _myCrowdfundsOnly = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _loadCrowdfunds();
        });
      }
    });
    _loadCrowdfunds();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadCrowdfunds() {
    if (_tabController.index == 1) {
      // My Funded Campaigns - load user's donations
      context.read<CrowdfundCubit>().loadUserDonations();
    } else {
      // Browse All - load all campaigns
      context.read<CrowdfundCubit>().loadCrowdfunds(
            statusFilter: _selectedStatus,
            categoryFilter: _selectedCategory,
            myCrowdfundsOnly: _myCrowdfundsOnly,
          );
    }
  }

  void _onSearchChanged(String query) {
    if (_tabController.index == 1) {
      // Search in funded campaigns
      if (query.trim().length >= 2) {
        // For funded campaigns, we'd need a search method on donations
        // For now, just reload
        _loadCrowdfunds();
      } else if (query.trim().isEmpty) {
        _loadCrowdfunds();
      }
    } else {
      // Search in all campaigns
      if (query.trim().length >= 2) {
        context.read<CrowdfundCubit>().searchCrowdfunds(query: query.trim());
      } else if (query.trim().isEmpty) {
        _loadCrowdfunds();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Campaigns',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF9CA3AF),
          unselectedLabelColor: const Color(0xFF6B7280),
          indicatorColor: const Color(0xFF6366F1),
          indicatorWeight: 3,
          labelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Browse All'),
            Tab(text: 'My Funded'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search campaigns...',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color(0xFF6B7280),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: const Color(0xFF6B7280),
                        ),
                        onPressed: () {
                          _searchController.clear();
                          _loadCrowdfunds();
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
              ),
            ),
          ),
          // Filter chips
          if (_selectedCategory != null || _selectedStatus != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Wrap(
                spacing: 8.w,
                children: [
                  if (_selectedCategory != null)
                    _buildFilterChip(
                      label: _selectedCategory!,
                      onDeleted: () {
                        setState(() {
                          _selectedCategory = null;
                        });
                        _loadCrowdfunds();
                      },
                    ),
                  if (_selectedStatus != null)
                    _buildFilterChip(
                      label: _selectedStatus!,
                      onDeleted: () {
                        setState(() {
                          _selectedStatus = null;
                        });
                        _loadCrowdfunds();
                      },
                    ),
                ],
              ),
            ),
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBrowseAllTab(),
                _buildMyFundedTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrowseAllTab() {
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
        if (state is CrowdfundLoading) {
          return _buildLoadingWidget(state.message);
        }

        if (state is CrowdfundLoaded) {
          if (state.crowdfunds.isEmpty) {
            return _buildEmptyCampaignsWidget(
              icon: Icons.campaign_outlined,
              title: 'No campaigns available',
              subtitle: 'Be the first to create a campaign!',
            );
          }
          return _buildCampaignsList(state.crowdfunds);
        }

        return _buildLoadingWidget();
      },
    );
  }

  Widget _buildMyFundedTab() {
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
        if (state is CrowdfundLoading) {
          return _buildLoadingWidget(state.message);
        }

        if (state is UserDonationsLoaded) {
          if (state.donations.isEmpty) {
            return _buildEmptyCampaignsWidget(
              icon: Icons.volunteer_activism,
              title: 'No funded campaigns yet',
              subtitle: 'Donate to a campaign to see it here!',
            );
          }
          return _buildFundedCampaignsList(state.donations);
        }

        // Initial state - trigger load
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<CrowdfundCubit>().loadUserDonations();
        });

        return _buildLoadingWidget('Loading your funded campaigns...');
      },
    );
  }

  Widget _buildLoadingWidget([String? message]) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: const Color(0xFF6366F1),
          ),
          if (message != null) ...[
            SizedBox(height: 16.h),
            Text(
              message,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyCampaignsWidget({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF6B7280),
              size: 64.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampaignsList(List<dynamic> campaigns) {
    return RefreshIndicator(
      onRefresh: () async {
        _loadCrowdfunds();
      },
      color: const Color(0xFF6366F1),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: campaigns.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: CrowdfundCard(
              crowdfund: campaigns[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CrowdfundDetailsScreen(
                      crowdfundId: campaigns[index].id,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFundedCampaignsList(List<dynamic> donations) {
    // Group donations by crowdfund to show unique campaigns
    Map<String, dynamic> uniqueCampaigns = {};
    for (var donation in donations) {
      final crowdfund = donation.crowdfund;
      if (crowdfund != null && !uniqueCampaigns.containsKey(crowdfund.id)) {
        uniqueCampaigns[crowdfund.id] = {
          'crowdfund': crowdfund,
          'donations': [donation],
          'totalDonated': donation.amount,
        };
      } else if (crowdfund != null) {
        uniqueCampaigns[crowdfund.id]['donations'].add(donation);
        uniqueCampaigns[crowdfund.id]['totalDonated'] += donation.amount;
      }
    }

    final campaignList = uniqueCampaigns.values.toList();

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CrowdfundCubit>().loadUserDonations();
      },
      color: const Color(0xFF6366F1),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: campaignList.length,
        itemBuilder: (context, index) {
          final item = campaignList[index];
          final crowdfund = item['crowdfund'];
          final totalDonated = item['totalDonated'];
          final donationCount = item['donations'].length;

          return _buildFundedCampaignCard(
            crowdfund: crowdfund,
            totalDonated: totalDonated,
            donationCount: donationCount,
          );
        },
      ),
    );
  }

  Widget _buildFundedCampaignCard({
    required dynamic crowdfund,
    required double totalDonated,
    required int donationCount,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CrowdfundDetailsScreen(
              crowdfundId: crowdfund.id,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  crowdfund.category,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6366F1),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'Funded',
                    style: GoogleFonts.inter(
                      color: Colors.green,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Title
            Text(
              crowdfund.title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.h),
            // Description
            Text(
              crowdfund.description,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16.h),
            // Progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Contribution',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 11.sp,
                      ),
                    ),
                    Text(
                      '${crowdfund.currency} ${totalDonated.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6366F1),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'of ${crowdfund.currency} ${crowdfund.targetAmount.toStringAsFixed(2)} goal',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                        fontSize: 11.sp,
                      ),
                    ),
                    Text(
                      '${(totalDonated / crowdfund.targetAmount * 100).toStringAsFixed(0)}%',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6366F1),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  value: (totalDonated / crowdfund.targetAmount).clamp(0.0, 1.0),
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                  minHeight: 6.h,
                ),
                SizedBox(height: 12.h),
                // Stats row
                Row(
                  children: [
                    Icon(
                      Icons.volunteer_activism,
                      color: const Color(0xFF6B7280),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '$donationCount ${donationCount == 1 ? 'donation' : 'donations'}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.people,
                      color: const Color(0xFF6B7280),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${crowdfund.donorCount} total',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.inter(
          color: const Color(0xFF6366F1),
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      deleteIcon: const Icon(
        Icons.close,
        color: Color(0xFF6366F1),
        size: 16,
      ),
      onDeleted: onDeleted,
      backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.1),
    );
  }
}
