import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/utils/debouncer.dart';
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

class _BrandSearchBottomSheetState extends State<BrandSearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer.typing();
  String? _selectedCategory;
  List<GiftCardBrand> _filteredBrands = [];
  List<GiftCardBrand> _allBrands = [];

  @override
  void initState() {
    super.initState();
    _allBrands = widget.initialBrands;
    _filteredBrands = widget.initialBrands;

    if (widget.initialBrands.isEmpty) {
      context.read<GiftCardCubit>().loadGiftCardBrands();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
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
            final nameMatch =
                brand.name.toLowerCase().contains(lowercaseQuery);
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

  void _onCategorySelected(String? category) {
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
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
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
    return Container(
      width: 40.w,
      height: 4.h,
      margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title ?? 'Select Gift Card Brand',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${_filteredBrands.length} brands available',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          hintText: 'Search by name or category...',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: const Color(0xFF9CA3AF),
            size: 20.sp,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear_rounded,
                    color: const Color(0xFF9CA3AF),
                    size: 18.sp,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters() {
    final categories = [
      {'label': 'All', 'value': null},
      {'label': 'Shopping', 'value': 'shopping'},
      {'label': 'Dining', 'value': 'dining'},
      {'label': 'Entertainment', 'value': 'entertainment'},
      {'label': 'Travel', 'value': 'travel'},
      {'label': 'Gaming', 'value': 'gaming'},
    ];

    return Container(
      height: 48.h,
      margin: EdgeInsets.only(bottom: 12.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category['value'];
          return Container(
            margin: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                _onCategorySelected(
                    isSelected ? null : category['value']);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                      : const Color(0xFF0A0A0A),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF2D2D2D),
                  ),
                ),
                child: Center(
                  child: Text(
                    category['label'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrandsList() {
    if (_filteredBrands.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: _filteredBrands.length,
      itemBuilder: (context, index) {
        return _buildBrandCard(_filteredBrands[index]);
      },
    );
  }

  Widget _buildBrandCard(GiftCardBrand brand) {
    return GestureDetector(
      onTap: () {
        widget.onBrandSelected(brand);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: brand.logoUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Icon(
                    Icons.image_rounded,
                    color: Colors.grey.shade400,
                    size: 22.sp,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.card_giftcard_rounded,
                    color: Colors.grey.shade400,
                    size: 22.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand.name,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    brand.description,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      if (brand.discountPercentage > 0) ...[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981)
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            '${brand.discountPercentage.toStringAsFixed(0)}% OFF',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF10B981),
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                      ],
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          _getCategoryLabel(brand.category),
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF9CA3AF),
              size: 14.sp,
            ),
          ],
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
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 40.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Brands Found',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
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
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (_searchController.text.isNotEmpty) ...[
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                _searchController.clear();
                _onSearchChanged('');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding:
                    EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
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
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          child: Shimmer.fromColors(
            baseColor: const Color(0xFF2D2D2D),
            highlightColor: const Color(0xFF3D3D3D),
            child: Container(
              height: 80.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(14.r),
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
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 40.sp,
              color: const Color(0xFFEF4444),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Error Loading Brands',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton.icon(
            onPressed: () {
              context.read<GiftCardCubit>().loadGiftCardBrands();
            },
            icon: Icon(Icons.refresh_rounded, size: 18.sp),
            label: Text(
              'Retry',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryLabel(String category) {
    switch (category) {
      case 'shopping':
        return 'Shopping';
      case 'dining':
        return 'Dining';
      case 'entertainment':
        return 'Entertainment';
      case 'travel':
        return 'Travel';
      case 'gaming':
        return 'Gaming';
      case 'other':
        return 'Other';
      default:
        return category[0].toUpperCase() + category.substring(1);
    }
  }
}
