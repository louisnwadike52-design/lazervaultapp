import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/utils/debouncer.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../widgets/crowdfund_card.dart';

class CrowdfundListScreen extends StatefulWidget {
  const CrowdfundListScreen({super.key});

  @override
  State<CrowdfundListScreen> createState() => _CrowdfundListScreenState();
}

class _CrowdfundListScreenState extends State<CrowdfundListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _searchDebouncer = Debouncer.search();
  final ScrollController _browseScrollController = ScrollController();
  String _selectedFilter = 'All';

  static const _filters = ['All', 'Active', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _searchController.addListener(_onSearchTextChanged);
    _browseScrollController.addListener(_onBrowseScroll);
    _loadCrowdfunds();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _searchDebouncer.dispose();
    _browseScrollController.removeListener(_onBrowseScroll);
    _browseScrollController.dispose();
    super.dispose();
  }

  void _onBrowseScroll() {
    if (_browseScrollController.position.pixels >=
        _browseScrollController.position.maxScrollExtent - 200) {
      context.read<CrowdfundCubit>().loadMoreCrowdfunds(
            statusFilter: _statusParam,
          );
    }
  }

  void _onSearchTextChanged() {
    // Rebuild to update suffix icon visibility
    setState(() {});
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    setState(() => _selectedFilter = 'All');
    _searchController.clear();
    _searchDebouncer.cancel(); // Cancel any pending debounced search from clear
    _loadCrowdfunds();
  }

  String? get _statusParam {
    switch (_selectedFilter) {
      case 'Active':
        return 'active';
      case 'Completed':
        return 'completed';
      case 'Cancelled':
        return 'cancelled';
      default:
        return null;
    }
  }

  void _onFilterSelected(String filter) {
    setState(() => _selectedFilter = filter);
    _loadCrowdfunds();
  }

  void _loadCrowdfunds() {
    if (_tabController.index == 1) {
      context.read<CrowdfundCubit>().loadUserDonations();
    } else {
      context.read<CrowdfundCubit>().loadCrowdfunds(
            statusFilter: _statusParam,
          );
    }
  }

  void _onSearchChanged(String query) {
    _searchDebouncer.run(() {
      if (_tabController.index == 1) {
        // For funded tab, just reload (server-side search not supported for donations)
        _loadCrowdfunds();
      } else {
        if (query.trim().length >= 2) {
          context.read<CrowdfundCubit>().searchCrowdfunds(query: query.trim());
        } else if (query.trim().isEmpty) {
          _loadCrowdfunds();
        }
      }
    });
  }

  Future<void> _onRefresh() async {
    _loadCrowdfunds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildTabBar(),
            _buildFilterChips(),
            _buildStaleIndicator(),
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
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Campaigns',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      margin: EdgeInsets.only(bottom: 12.h),
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
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF6B7280),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Color(0xFF6B7280),
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _searchDebouncer.cancel();
                    _loadCrowdfunds();
                  },
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6366F1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Browse All'),
          Tab(text: 'My Funded'),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter == _selectedFilter;
          return GestureDetector(
            onTap: () => _onFilterSelected(filter),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                filter,
                style: GoogleFonts.inter(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStaleIndicator() {
    return BlocBuilder<CrowdfundCubit, CrowdfundState>(
      builder: (context, state) {
        if (state is CrowdfundLoaded && state.isStale) {
          return const LinearProgressIndicator(
            minHeight: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
            backgroundColor: Color(0xFF1F1F1F),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBrowseAllTab() {
    return BlocBuilder<CrowdfundCubit, CrowdfundState>(
      builder: (context, state) {
        if (state is CrowdfundLoading) {
          return _buildCampaignListShimmer();
        }

        if (state is CrowdfundError) {
          return _buildErrorState(state.message);
        }

        if (state is CrowdfundLoaded) {
          if (state.crowdfunds.isEmpty) {
            return _buildEmptyState(
              icon: Icons.campaign_outlined,
              title: _getEmptyTitle(isBrowse: true),
              subtitle: _getEmptySubtitle(isBrowse: true),
            );
          }
          final itemCount = state.crowdfunds.length +
              (state.isLoadingMore || state.hasMore ? 1 : 0);
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF6366F1),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              controller: _browseScrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index >= state.crowdfunds.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Center(
                      child: state.isLoadingMore
                          ? const CircularProgressIndicator(
                              color: Color(0xFF6366F1),
                              strokeWidth: 2,
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                }
                return CrowdfundCard(
                  crowdfund: state.crowdfunds[index],
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.crowdfundDetails,
                      arguments: state.crowdfunds[index].id,
                    );
                  },
                );
              },
            ),
          );
        }

        return _buildCampaignListShimmer();
      },
    );
  }

  Widget _buildMyFundedTab() {
    return BlocBuilder<CrowdfundCubit, CrowdfundState>(
      builder: (context, state) {
        if (state is CrowdfundLoading) {
          return _buildCampaignListShimmer();
        }

        if (state is CrowdfundError) {
          return _buildErrorState(state.message);
        }

        if (state is UserDonationsLoaded) {
          if (state.donations.isEmpty) {
            return _buildEmptyState(
              icon: Icons.volunteer_activism,
              title: 'No funded campaigns yet',
              subtitle: 'Donate to a campaign to see it here!',
            );
          }
          return _buildFundedCampaignsList(state.donations);
        }

        // Default: show shimmer while _onTabChanged triggers loadUserDonations
        return _buildCampaignListShimmer();
      },
    );
  }

  Widget _buildFundedCampaignsList(List<CrowdfundDonation> donations) {
    // Group donations by crowdfundId to show unique campaigns
    final Map<String, List<CrowdfundDonation>> grouped = {};
    for (final donation in donations) {
      grouped.putIfAbsent(donation.crowdfundId, () => []).add(donation);
    }

    final campaignIds = grouped.keys.toList();

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CrowdfundCubit>().loadUserDonations();
      },
      color: const Color(0xFF6366F1),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: campaignIds.length,
        itemBuilder: (context, index) {
          final crowdfundId = campaignIds[index];
          final campaignDonations = grouped[crowdfundId]!;
          final totalDonated = campaignDonations.fold<double>(
            0.0,
            (sum, d) => sum + d.amount,
          );
          final currency = campaignDonations.first.currency;
          final donationCount = campaignDonations.length;
          final latestDonation = campaignDonations.reduce(
            (a, b) => a.donationDate.isAfter(b.donationDate) ? a : b,
          );

          return _buildFundedCampaignCard(
            crowdfundId: crowdfundId,
            totalDonated: totalDonated,
            currency: currency,
            donationCount: donationCount,
            latestDate: latestDonation.donationDate,
          );
        },
      ),
    );
  }

  Widget _buildFundedCampaignCard({
    required String crowdfundId,
    required double totalDonated,
    required String currency,
    required int donationCount,
    required DateTime latestDate,
  }) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.crowdfundDetails,
          arguments: crowdfundId,
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
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
                Expanded(
                  child: Text(
                    'Campaign',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
            SizedBox(height: 16.h),
            // Contribution
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
                  '$currency ${totalDonated.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6366F1),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
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
                const Spacer(),
                Icon(
                  Icons.access_time,
                  color: const Color(0xFF6B7280),
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  _formatDate(latestDate),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            // View details hint
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Tap to view details',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6366F1),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  // ---------------------------------------------------------------------------
  // Shimmer loading
  // ---------------------------------------------------------------------------

  Widget _buildCampaignListShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1F1F1F),
      highlightColor: const Color(0xFF3D3D3D),
      period: const Duration(milliseconds: 1200),
      direction: ShimmerDirection.ltr,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status badge shimmer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _shimmerBox(width: 70.w, height: 24.h),
                    _shimmerBox(width: 80.w, height: 20.h),
                  ],
                ),
                SizedBox(height: 12.h),
                // Creator row shimmer
                Row(
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmerBox(width: 100.w, height: 12.h),
                        SizedBox(height: 4.h),
                        _shimmerBox(width: 70.w, height: 10.h),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Title shimmer
                _shimmerBox(width: double.infinity, height: 16.h),
                SizedBox(height: 8.h),
                // Description shimmer
                _shimmerBox(width: double.infinity, height: 12.h),
                SizedBox(height: 4.h),
                _shimmerBox(width: 200.w, height: 12.h),
                SizedBox(height: 16.h),
                // Progress shimmer
                _shimmerBox(width: double.infinity, height: 8.h),
                SizedBox(height: 12.h),
                // Footer shimmer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _shimmerBox(width: 80.w, height: 12.h),
                    _shimmerBox(width: 80.w, height: 12.h),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty & error states
  // ---------------------------------------------------------------------------

  String _getEmptyTitle({required bool isBrowse}) {
    switch (_selectedFilter) {
      case 'Active':
        return 'No active campaigns';
      case 'Completed':
        return 'No completed campaigns';
      case 'Cancelled':
        return 'No cancelled campaigns';
      default:
        return isBrowse ? 'No campaigns available' : 'No funded campaigns';
    }
  }

  String _getEmptySubtitle({required bool isBrowse}) {
    switch (_selectedFilter) {
      case 'Active':
        return isBrowse
            ? 'There are no active campaigns right now'
            : 'You haven\'t funded any active campaigns';
      case 'Completed':
        return isBrowse
            ? 'No campaigns have been completed yet'
            : 'None of your funded campaigns are completed';
      case 'Cancelled':
        return isBrowse
            ? 'No campaigns have been cancelled'
            : 'None of your funded campaigns were cancelled';
      default:
        return isBrowse
            ? 'Be the first to create a campaign!'
            : 'Donate to a campaign to see it here!';
    }
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF6366F1),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 60.h),
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(36.r),
                    ),
                    child: Icon(
                      icon,
                      size: 32.sp,
                      color: const Color(0xFF6B7280),
                    ),
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
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF6366F1),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 40.h),
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sp,
                    color: const Color(0xFFEF4444),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Failed to Load',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: _onRefresh,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
