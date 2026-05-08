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
  final ScrollController _fundedScrollController = ScrollController();
  String _selectedFilter = 'All';

  static const _filters = ['All', 'Active', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _searchController.addListener(_onSearchTextChanged);
    _browseScrollController.addListener(_onBrowseScroll);
    _fundedScrollController.addListener(_onFundedScroll);
    // Data loading is triggered by the route's BlocProvider (..loadCrowdfunds())
    // Only reload if cubit is in initial state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<CrowdfundCubit>().state;
      if (state is CrowdfundInitial) {
        _loadCrowdfunds();
      }
    });
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
    _fundedScrollController.removeListener(_onFundedScroll);
    _fundedScrollController.dispose();
    super.dispose();
  }

  void _onBrowseScroll() {
    if (_browseScrollController.position.pixels <
        _browseScrollController.position.maxScrollExtent - 200) {
      return;
    }
    // Don't auto-paginate while the user is searching: search results
    // aren't pageable and the cubit marks them hasMore=false anyway, but
    // the early return here also avoids a stray gRPC call during the
    // debounce window before the cubit's state flips.
    if (_searchController.text.trim().isNotEmpty) return;

    final state = context.read<CrowdfundCubit>().state;
    // Only paginate from a settled list state. Skip while a fetch is in
    // flight (Loading), errored (CrowdfundError), or while we're sitting
    // on a different cubit phase (e.g. UserDonationsLoaded after a recent
    // tab switch but before the rebuild has caught up).
    if (state is! CrowdfundLoaded || !state.hasMore || state.isLoadingMore) {
      return;
    }
    context.read<CrowdfundCubit>().loadMoreCrowdfunds(
          statusFilter: _statusParam,
        );
  }

  void _onFundedScroll() {
    if (_fundedScrollController.position.pixels <
        _fundedScrollController.position.maxScrollExtent - 200) {
      return;
    }
    final state = context.read<CrowdfundCubit>().state;
    if (state is! UserDonationsLoaded ||
        !state.hasMore ||
        state.isLoadingMore) {
      return;
    }
    context.read<CrowdfundCubit>().loadMoreUserDonations();
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _exitToCrowdfundHome();
      },
      child: Scaffold(
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
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: _exitToCrowdfundHome,
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(19.r),
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16.sp),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Campaigns',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.createCrowdfund),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 14.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Create',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
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

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 8.h),
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
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF4E03D0),
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
      height: 40.h,
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                    ? const Color(0xFF4E03D0).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                filter,
                style: GoogleFonts.inter(
                  color: isSelected
                      ? const Color(0xFF4E03D0)
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
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
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
            color: const Color(0xFF4E03D0),
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
                              color: Color(0xFF4E03D0),
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
          return _buildFundedCampaignsList(state);
        }

        // Default: show shimmer while _onTabChanged triggers loadUserDonations
        return _buildCampaignListShimmer();
      },
    );
  }

  Widget _buildFundedCampaignsList(UserDonationsLoaded state) {
    // Group donations by crowdfundId to show unique campaigns. We preserve
    // first-seen order so additional pages append cleanly at the bottom.
    final Map<String, List<CrowdfundDonation>> grouped = {};
    for (final donation in state.donations) {
      grouped.putIfAbsent(donation.crowdfundId, () => []).add(donation);
    }

    final campaignIds = grouped.keys.toList();
    final showFooter = state.isLoadingMore || state.hasMore;
    final itemCount = campaignIds.length + (showFooter ? 1 : 0);

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CrowdfundCubit>().loadUserDonations();
      },
      color: const Color(0xFF4E03D0),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        controller: _fundedScrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index >= campaignIds.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(
                child: state.isLoadingMore
                    ? const CircularProgressIndicator(
                        color: Color(0xFF4E03D0),
                        strokeWidth: 2,
                      )
                    : const SizedBox.shrink(),
              ),
            );
          }
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
            campaignTitle: _resolveCampaignTitle(crowdfundId),
            totalDonated: totalDonated,
            currency: currency,
            donationCount: donationCount,
            latestDate: latestDonation.donationDate,
          );
        },
      ),
    );
  }

  String _resolveCampaignTitle(String crowdfundId) {
    final state = context.read<CrowdfundCubit>().state;
    Iterable<Crowdfund>? pool;
    if (state is CrowdfundLoaded) {
      pool = state.crowdfunds;
    } else if (state is MyCrowdfundsLoaded) {
      pool = state.crowdfunds;
    }
    if (pool != null) {
      for (final c in pool) {
        if (c.id == crowdfundId) return c.title;
      }
    }
    final tail = crowdfundId.length > 6
        ? crowdfundId.substring(crowdfundId.length - 6).toUpperCase()
        : crowdfundId.toUpperCase();
    return 'Campaign · $tail';
  }

  Widget _buildFundedCampaignCard({
    required String crowdfundId,
    required String campaignTitle,
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
                    campaignTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
                    color: const Color(0xFF4E03D0),
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
                  color: const Color(0xFF4E03D0),
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
      color: const Color(0xFF4E03D0),
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
      color: const Color(0xFF4E03D0),
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
                      backgroundColor: const Color(0xFF4E03D0),
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
