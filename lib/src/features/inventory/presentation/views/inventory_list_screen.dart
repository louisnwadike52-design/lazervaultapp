import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/core/widgets/infinite_scroll_mixin.dart';
import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:lazervault/src/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class InventoryListScreen extends StatefulWidget {
  const InventoryListScreen({super.key});

  @override
  State<InventoryListScreen> createState() => _InventoryListScreenState();
}

class _InventoryListScreenState extends State<InventoryListScreen>
    with InfiniteScrollMixin<InventoryListScreen> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer.search();
  final _repo = serviceLocator<InventoryRepository>();
  String _selectedCategory = 'All';

  static const _limit = 20;

  List<InventoryItemEntity> _items = [];
  bool _loading = false;
  String? _error;

  static const _categories = [
    'All',
    'Electronics',
    'Supplies',
    'Food',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    attachInfiniteScroll();
    _loadFirst();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    detachInfiniteScroll();
    super.dispose();
  }

  Future<void> _loadFirst() async {
    resetPagination();
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await _repo.listItems(
        page: 1,
        limit: _limit,
        category: _selectedCategory == 'All' ? null : _selectedCategory,
        search: _searchController.text.isEmpty ? null : _searchController.text,
      );
      if (!mounted) return;
      setState(() {
        _items = res.items;
        _loading = false;
        hasMore = res.currentPage < res.totalPages;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = e.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_error!),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  @override
  Future<void> onLoadMore() => runLoadMore(() async {
        final res = await _repo.listItems(
          page: page + 1,
          limit: _limit,
          category: _selectedCategory == 'All' ? null : _selectedCategory,
          search:
              _searchController.text.isEmpty ? null : _searchController.text,
        );
        if (!mounted) return;
        setState(() {
          _items.addAll(res.items);
          page += 1;
          hasMore = res.currentPage < res.totalPages;
        });
      });

  void _onSearchChanged(String query) {
    setState(() {}); // Update suffixIcon visibility
    _debouncer.run(() {
      if (!mounted) return;
      _loadFirst();
    });
  }

  void _onCategorySelected(String category) {
    setState(() => _selectedCategory = category);
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
          'Inventory',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          // Per-service voice + chat icons — pin every voice/chat
          // session opened from this screen to the inventory flow
          // on chat-business-service (DIRECT_ROUTES['inventory']
          // → SERVICE_AGENTS['inventory']). Same pattern as
          // crowdfund, autosave, lock-funds, tax, customers.
          ServiceVoiceButton(
            serviceName: 'inventory',
            iconColor: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF3B82F6),
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Inventory',
            sourceContext: 'inventory',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF3B82F6),
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            _buildCategoryFilters(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add screen now returns the created item (or true); refresh on any
          // non-null result.
          final result = await Get.toNamed(AppRoutes.addInventoryItem);
          if (result != null && mounted) _loadFirst();
        },
        backgroundColor: const Color(0xFF3B82F6),
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
          hintText: 'Search inventory...',
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
  // Category Filters
  // ---------------------------------------------------------------------------

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return GestureDetector(
            onTap: () => _onCategorySelected(category),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              child: Center(
                child: Text(
                  category,
                  style: GoogleFonts.inter(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
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

    if (_items.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async => _loadFirst(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        itemCount: _items.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _items.length) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: const Center(child: LazerVaultLoader.small()),
            );
          }
          return _buildInventoryCard(_items[index]);
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Inventory Card
  // ---------------------------------------------------------------------------

  Widget _buildInventoryCard(InventoryItemEntity item) {
    return GestureDetector(
      onTap: () async {
        final result = await Get.toNamed(
          AppRoutes.inventoryItemDetails,
          arguments: item,
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
            // Icon
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                color: const Color(0xFF3B82F6),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.isLowStock)
                        Container(
                          margin: EdgeInsets.only(left: 8.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            'Low Stock',
                            style: GoogleFonts.inter(
                              color: const Color(0xFFFB923C),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      if (item.category.isNotEmpty) ...[
                        Text(
                          item.category,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          '  \u2022  ',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                      Text(
                        'Qty: ${item.quantity}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            // Price
            Text(
              item.formattedUnitPrice,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
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
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.inventory_2_outlined,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No inventory items',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap + to add your first item',
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
