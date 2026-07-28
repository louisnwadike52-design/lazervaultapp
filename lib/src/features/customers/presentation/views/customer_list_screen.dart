import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/core/widgets/infinite_scroll_mixin.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_entity.dart';
import 'package:lazervault/src/features/customers/domain/repositories/customer_repository.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen>
    with InfiniteScrollMixin<CustomerListScreen> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer.search();
  String _selectedSegment = 'All';

  static const int _limit = 20;

  List<CustomerEntity> _customers = [];
  bool _loading = true;

  static const _segments = [
    'All',
    'VIP',
    'Retail',
    'Wholesale',
    'Government',
    'Overdue',
  ];

  /// Maps a segment display name to the integer value expected by the API.
  /// Returns null for "All" (no filter).
  static int? _segmentToInt(String segment) {
    switch (segment) {
      case 'VIP':
        return 1;
      case 'Retail':
        return 2;
      case 'Wholesale':
        return 3;
      case 'Government':
        return 4;
      case 'Overdue':
        return 5;
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    attachInfiniteScroll();
    _loadFirst();
  }

  @override
  void dispose() {
    detachInfiniteScroll();
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  Future<void> _loadFirst() async {
    resetPagination();
    setState(() => _loading = true);
    try {
      final res = await serviceLocator<CustomerRepository>().listCustomers(
        page: 1,
        limit: _limit,
        segment: _segmentToInt(_selectedSegment),
        search: _searchController.text.isEmpty ? null : _searchController.text,
      );
      if (!mounted) return;
      setState(() {
        _customers = res.items;
        _loading = false;
        hasMore = res.currentPage < res.totalPages;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  @override
  Future<void> onLoadMore() => runLoadMore(() async {
        final res = await serviceLocator<CustomerRepository>().listCustomers(
          page: page + 1,
          limit: _limit,
          segment: _segmentToInt(_selectedSegment),
          search:
              _searchController.text.isEmpty ? null : _searchController.text,
        );
        if (!mounted) return;
        setState(() {
          _customers.addAll(res.items);
          page += 1;
          hasMore = page < res.totalPages;
        });
      });

  void _onSearchChanged(String query) {
    setState(() {}); // Update suffixIcon visibility
    _debouncer.run(() {
      if (!mounted) return;
      _loadFirst();
    });
  }

  void _onSegmentSelected(String segment) {
    setState(() => _selectedSegment = segment);
    _loadFirst();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Customers',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          // Per-service voice + chat icons — pin every voice/chat
          // session opened from this screen to the customers CRM
          // flow on chat-business-service (DIRECT_ROUTES['customers']
          // → SERVICE_AGENTS['customers']). Same pattern as crowdfund,
          // autosave, lock-funds, tax.
          ServiceVoiceButton(
            serviceName: 'customers',
            iconColor: const Color(0xFFA78BFA),
            backgroundColor: const Color(0xFFA78BFA),
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Customers',
            sourceContext: 'customers',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFFA78BFA),
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildSegmentFilters(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add screen now returns the created customer (or true); refresh on
          // any non-null result.
          final result = await Get.toNamed(AppRoutes.addCustomer);
          if (result != null && mounted) _loadFirst();
        },
        backgroundColor: const Color.fromARGB(255, 78, 3, 208),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Search Bar
  // ---------------------------------------------------------------------------

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: 'Search customers...',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 15.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xFF9CA3AF),
            size: 20.sp,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: const Color(0xFF9CA3AF),
                    size: 18.sp,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _loadFirst();
                  },
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Segment Filters
  // ---------------------------------------------------------------------------

  Widget _buildSegmentFilters() {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _segments.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final segment = _segments[index];
          final isSelected = segment == _selectedSegment;

          return GestureDetector(
            onTap: () => _onSegmentSelected(segment),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFA78BFA).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFA78BFA)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              child: Center(
                child: Text(
                  segment,
                  style: GoogleFonts.inter(
                    color: isSelected
                        ? const Color(0xFFA78BFA)
                        : const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: LazerVaultLoader.small(),
      );
    }

    if (_customers.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async => _loadFirst(),
      color: const Color(0xFFA78BFA),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        itemCount: _customers.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _customers.length) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: const Center(child: LazerVaultLoader.small()),
            );
          }
          return _buildCustomerCard(_customers[index]);
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Customer Card
  // ---------------------------------------------------------------------------

  /// Returns the avatar colour for a given segment.
  Color _segmentColor(CustomerSegment segment) {
    switch (segment) {
      case CustomerSegment.vip:
        return const Color(0xFFFB923C); // gold / orange
      case CustomerSegment.retail:
        return const Color(0xFFA78BFA); // blue
      case CustomerSegment.wholesale:
        return const Color(0xFF10B981); // green
      case CustomerSegment.government:
        return const Color.fromARGB(255, 78, 3, 208); // purple
      case CustomerSegment.overdue:
        return const Color(0xFFEF4444); // red
      case CustomerSegment.none:
        return const Color(0xFF9CA3AF); // gray
    }
  }

  Widget _buildCustomerCard(CustomerEntity customer) {
    final avatarColor = _segmentColor(customer.segment);

    return GestureDetector(
      onTap: () async {
        final result = await Get.toNamed(
          AppRoutes.customerDetails,
          arguments: customer,
        );
        if (result == true && mounted) _loadFirst();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Avatar with initials
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: avatarColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  customer.initials,
                  style: GoogleFonts.inter(
                    color: avatarColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Name, subtitle, segment badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          customer.email.isNotEmpty
                              ? customer.email
                              : customer.phone,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (customer.segment != CustomerSegment.none) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: avatarColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            customer.segmentDisplay,
                            style: GoogleFonts.inter(
                              color: avatarColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            // Status badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 5.h,
              ),
              decoration: BoxDecoration(
                color: customer.statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                customer.statusDisplay,
                style: GoogleFonts.inter(
                  color: customer.statusColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async => _loadFirst(),
      color: const Color(0xFFA78BFA),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.people_outline,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No customers',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap + to add your first customer',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
