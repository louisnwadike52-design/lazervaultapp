import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../cubit/gift_card_cubit.dart';
import '../../../cubit/gift_card_state.dart';
import '../../../domain/entities/gift_card_entity.dart';

class BrandSearchBottomSheet extends StatefulWidget {
  final Function(GiftCardBrand) onBrandSelected;
  final List<GiftCardBrand> initialBrands;
  final String? title;

  const BrandSearchBottomSheet({
    super.key,
    required this.onBrandSelected,
    this.initialBrands = const [],
    this.title,
  });

  @override
  State<BrandSearchBottomSheet> createState() => _BrandSearchBottomSheetState();
}

class _BrandSearchBottomSheetState extends State<BrandSearchBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  GiftCardCategory? _selectedCategory;
  List<GiftCardBrand> _filteredBrands = [];
  List<GiftCardBrand> _allBrands = [];

  @override
  void initState() {
    super.initState();
    _allBrands = widget.initialBrands;
    _filteredBrands = widget.initialBrands;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();

    // Load brands if not provided
    if (widget.initialBrands.isEmpty) {
      context.read<GiftCardCubit>().loadGiftCardBrands();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    // Start new timer (300ms debounce)
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (query.isEmpty) {
        setState(() {
          _filteredBrands = _selectedCategory == null
              ? _allBrands
              : _allBrands
                  .where((b) => b.category == _selectedCategory)
                  .toList();
        });
      } else {
        final lowercaseQuery = query.toLowerCase();
        setState(() {
          _filteredBrands = _allBrands.where((brand) {
            final nameMatch = brand.name.toLowerCase().contains(lowercaseQuery);
            final descMatch =
                brand.description.toLowerCase().contains(lowercaseQuery);
            final categoryMatch = _selectedCategory == null ||
                brand.category == _selectedCategory;
            return (nameMatch || descMatch) && categoryMatch;
          }).toList();
        });
      }
    });
  }

  void _onCategorySelected(GiftCardCategory? category) {
    setState(() {
      _selectedCategory = category;
    });
    _onSearchChanged(_searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A3E),
            const Color(0xFF2C3E50),
            const Color(0xFF34495E),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: BlocListener<GiftCardCubit, GiftCardState>(
        listener: (context, state) {
          if (state is GiftCardBrandsLoaded) {
            setState(() {
              _allBrands = state.brands;
              _filteredBrands = state.brands;
            });
          } else if (state is GiftCardBrandsSearched) {
            setState(() {
              _filteredBrands = state.brands;
            });
          }
        },
        child: Column(
          children: [
            _buildHandle(),
            _buildHeader(),
            _buildSearchBar(),
            _buildCategoryFilters(),
            Expanded(
              child: BlocBuilder<GiftCardCubit, GiftCardState>(
                builder: (context, state) {
                  if (state is GiftCardBrandsLoading) {
                    return _buildLoadingState();
                  } else if (state is GiftCardNetworkError) {
                    return _buildErrorState(state.message);
                  }
                  return _buildBrandsList();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: 40.w,
        height: 4.h,
        margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title ?? 'Select Gift Card Brand',
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${_filteredBrands.length} brands available',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            hintText: 'Search by name or category...',
            hintStyle: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.grey[400],
              size: 24.sp,
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: Colors.grey[400],
                      size: 20.sp,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged('');
                    },
                  )
                : null,
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final categories = [
      {'label': 'All', 'value': null, 'icon': Icons.apps_rounded},
      {
        'label': 'Shopping',
        'value': GiftCardCategory.shopping,
        'icon': Icons.shopping_bag_rounded
      },
      {
        'label': 'Dining',
        'value': GiftCardCategory.dining,
        'icon': Icons.restaurant_rounded
      },
      {
        'label': 'Entertainment',
        'value': GiftCardCategory.entertainment,
        'icon': Icons.movie_rounded
      },
      {
        'label': 'Travel',
        'value': GiftCardCategory.travel,
        'icon': Icons.flight_rounded
      },
      {
        'label': 'Gaming',
        'value': GiftCardCategory.gaming,
        'icon': Icons.sports_esports_rounded
      },
    ];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: 56.h,
        margin: EdgeInsets.only(bottom: 16.h),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final isSelected = _selectedCategory == category['value'];
            return Container(
              margin: EdgeInsets.only(right: 8.w),
              child: FilterChip(
                selected: isSelected,
                avatar: Icon(
                  category['icon'] as IconData,
                  size: 18.sp,
                  color: isSelected ? Colors.white : Colors.grey[400],
                ),
                label: Text(
                  category['label'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.grey[400],
                  ),
                ),
                onSelected: (selected) {
                  _onCategorySelected(
                      selected ? category['value'] as GiftCardCategory? : null);
                },
                backgroundColor: Colors.white.withOpacity(0.05),
                selectedColor: const Color(0xFF6366F1),
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected
                      ? const Color(0xFF6366F1)
                      : Colors.white.withOpacity(0.1),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBrandsList() {
    if (_filteredBrands.isEmpty) {
      return _buildEmptyState();
    }

    // Separate popular and regular brands
    final popularBrands =
        _filteredBrands.where((b) => b.isPopular).toList();
    final regularBrands =
        _filteredBrands.where((b) => !b.isPopular).toList();

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          children: [
            if (popularBrands.isNotEmpty &&
                _searchController.text.isEmpty) ...[
              _buildSectionHeader('Popular Brands', popularBrands.length),
              SizedBox(height: 12.h),
              ...popularBrands.map((brand) => _buildBrandCard(brand, true)),
              SizedBox(height: 24.h),
            ],
            if (regularBrands.isNotEmpty) ...[
              if (popularBrands.isNotEmpty && _searchController.text.isEmpty)
                _buildSectionHeader('All Brands', regularBrands.length),
              SizedBox(height: 12.h),
              ...regularBrands.map((brand) => _buildBrandCard(brand, false)),
            ],
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6366F1),
                const Color(0xFF8B5CF6),
              ],
            ),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            '$count',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6366F1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandCard(GiftCardBrand brand, bool isPopular) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isPopular
              ? const Color(0xFF6366F1).withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            widget.onBrandSelected(brand);
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Brand Logo
                Container(
                  width: 56.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: CachedNetworkImage(
                      imageUrl: brand.logoUrl,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(color: Colors.white),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.card_giftcard_rounded,
                        color: Colors.grey[400],
                        size: 28.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              brand.name,
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isPopular) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF6366F1),
                                    const Color(0xFF8B5CF6),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'POPULAR',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        brand.description,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: Colors.grey[400],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          if (brand.discountPercentage != null &&
                              brand.discountPercentage! > 0) ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF10B981),
                                    const Color(0xFF059669),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                '${brand.discountPercentage!.toStringAsFixed(0)}% OFF',
                                style: GoogleFonts.inter(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Text(
                              _getCategoryLabel(brand.category),
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey[400],
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 48.sp,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Brands Found',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              _searchController.text.isNotEmpty
                  ? 'Try searching with different keywords'
                  : 'No brands available in this category',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (_searchController.text.isNotEmpty) ...[
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6366F1),
                    const Color(0xFF8B5CF6),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ElevatedButton(
                onPressed: () {
                  _searchController.clear();
                  _onSearchChanged('');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Clear Search',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          child: Shimmer.fromColors(
            baseColor: Colors.white.withOpacity(0.1),
            highlightColor: Colors.white.withOpacity(0.2),
            child: Container(
              height: 88.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 48.sp,
              color: Colors.red.shade400,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Error Loading Brands',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1),
                  const Color(0xFF8B5CF6),
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ElevatedButton(
              onPressed: () {
                context.read<GiftCardCubit>().loadGiftCardBrands();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh_rounded, size: 20.sp, color: Colors.white),
                  SizedBox(width: 8.w),
                  Text(
                    'Retry',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

  String _getCategoryLabel(GiftCardCategory category) {
    switch (category) {
      case GiftCardCategory.shopping:
        return 'Shopping';
      case GiftCardCategory.dining:
        return 'Dining';
      case GiftCardCategory.entertainment:
        return 'Entertainment';
      case GiftCardCategory.travel:
        return 'Travel';
      case GiftCardCategory.gaming:
        return 'Gaming';
      case GiftCardCategory.other:
        return 'Other';
    }
  }
}
