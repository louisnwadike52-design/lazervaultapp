import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../voice_session/widgets/voice_command_sheet.dart';
import '../../../microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'widgets/brand_search_bottomsheet.dart';
import 'widgets/country_selection_bottomsheet.dart';
import 'widgets/gift_card_error_widget.dart';

class GiftCardsScreen extends StatefulWidget {
  const GiftCardsScreen({super.key});

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  String? _selectedCategory;
  int _currentTab = 0; // 0 = Buy, 1 = Sell
  String _selectedCountryCode = ''; // Empty = All Countries (default)
  String _selectedCountryName = 'All Countries';
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<GiftCardCountry> _supportedCountries = [];

  List<String> _dynamicCategories = [];
  String _sellSearchQuery = '';

  @override
  void initState() {
    super.initState();
    final cubit = context.read<GiftCardCubit>();
    // Load data for both tabs so switching is instant
    cubit.loadGiftCardBrands();
    cubit.loadSellableCards();
    cubit.loadSupportedCountries();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<GiftCardCubit>().state;
      if (state is GiftCardBrandsLoaded && state.hasNext) {
        context.read<GiftCardCubit>().loadMoreBrands();
      }
    }
  }

  Future<void> _onRefresh() async {
    if (_currentTab == 0) {
      _searchController.clear();
      await context.read<GiftCardCubit>().loadGiftCardBrands(
            category: _selectedCategory,
            countryCode: _selectedCountryCode.isEmpty ? null : _selectedCountryCode,
          );
    } else {
      await context.read<GiftCardCubit>().loadSellableCards();
    }
  }

  void _updateDynamicCategories(List<GiftCardBrand> brands) {
    final categories = brands
        .map((b) => b.category)
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    if (categories.toString() != _dynamicCategories.toString()) {
      setState(() {
        _dynamicCategories = categories;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GiftCardCubit, GiftCardState>(
      listener: (context, state) {
        if (state is SupportedCountriesLoaded) {
          setState(() {
            _supportedCountries = state.countries;
          });
        } else if (state is GiftCardBrandsLoaded && _selectedCategory == null) {
          _updateDynamicCategories(state.brands);
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) Get.offAllNamed(AppRoutes.dashboard);
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 12.h),
                _buildQuickActions(),
                SizedBox(height: 12.h),
                _buildBuySellToggle(),
                SizedBox(height: 8.h),
                _buildSearchAndFilters(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: const Color(0xFF3B82F6),
                    backgroundColor: const Color(0xFF1F1F1F),
                    child: _currentTab == 0
                        ? _buildBrandsList(context.watch<GiftCardCubit>().state)
                        : _buildSellableCardsList(context.watch<GiftCardCubit>().state),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.offAllNamed(AppRoutes.dashboard),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18.sp),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Gift Cards',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 78, 3, 208), Color(0xFF6366F1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: IconButton(
              icon: Icon(Icons.mic, color: Colors.white, size: 20.sp),
              onPressed: () => _showVoiceAgentSheet(),
            ),
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Gift Cards',
            sourceContext: 'giftcards',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }

  void _showVoiceAgentSheet() {
    final giftCardSuggestions = [
      'Buy Amazon gift card',
      'Show my gift cards',
      'Find gift card deals',
      'Buy Netflix gift card',
    ];

    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.85,
        child: VoiceCommandSheet(),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // Quick actions section — My Cards + Sales History
  Widget _buildQuickActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.card_giftcard_rounded,
              label: 'My Cards',
              color: const Color(0xFF3B82F6),
              onTap: () => Get.toNamed(AppRoutes.myGiftCards),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.history_rounded,
              label: 'My Sales',
              color: const Color(0xFFF59E0B),
              onTap: () => Get.toNamed(AppRoutes.mySales),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Country selector
  Widget _buildCountrySelector() {
    return GestureDetector(
      onTap: () => _showCountrySelection(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Text(
                _getFlagForCountry(_selectedCountryCode),
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  _selectedCountryName,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    final flag = _selectedCountryCode.isEmpty
        ? '\u{1F30D}'
        : _getFlagForCountry(_selectedCountryCode);
    final countryLabel = _selectedCountryCode.isEmpty
        ? 'All'
        : _selectedCountryCode.toUpperCase();
    final categoryLabel = _selectedCategory == null
        ? 'All'
        : _getCategoryName(_selectedCategory!);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          // Search bar on the left (both buy and sell tabs)
          Expanded(
            child: Container(
              height: 44.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: TextField(
                controller: _searchController,
                style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
                decoration: InputDecoration(
                  hintText: _currentTab == 0 ? 'Search gift cards...' : 'Search sellable cards...',
                  hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF6B7280)),
                  prefixIcon: Icon(Icons.search, size: 20.sp, color: const Color(0xFF6B7280)),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _searchController,
                    builder: (context, value, _) {
                      if (value.text.isEmpty) return const SizedBox.shrink();
                      return GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        child: Icon(Icons.close, size: 18.sp, color: const Color(0xFF9CA3AF)),
                      );
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (query) => _onSearchChanged(query),
                onChanged: (query) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if (_searchController.text == query) {
                      _onSearchChanged(query);
                    }
                  });
                },
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Filter buttons on the right
          _buildFilterButton(
            label: 'Country',
            value: countryLabel,
            emoji: flag,
            onTap: () => _showCountrySelection(),
          ),
          SizedBox(width: 8.w),
          _buildFilterButton(
            label: 'Category',
            value: categoryLabel,
            icon: Icons.category_rounded,
            onTap: () => _showCategorySelection(),
          ),
        ],
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (_currentTab == 0) {
      // Buy tab: server-side search
      context.read<GiftCardCubit>().searchGiftCardBrands(query,
        countryCode: _selectedCountryCode.isEmpty ? null : _selectedCountryCode);
    } else {
      // Sell tab: client-side filter
      setState(() => _sellSearchQuery = query.trim().toLowerCase());
    }
  }

  void _showCountrySelection() {
    CountrySelectionBottomsheet.show(
      context: context,
      selectedCountryCode: _selectedCountryCode,
      dynamicCountries: _supportedCountries,
      onCountrySelected: (countryCode, countryName) {
        setState(() {
          _selectedCountryCode = countryCode;
          _selectedCountryName = countryName;
        });
        context.read<GiftCardCubit>().loadGiftCardBrands(
              category: _selectedCategory,
              countryCode: countryCode.isEmpty ? null : countryCode,
            );
      },
    );
  }

  Widget _buildFilterButton({
    required String label,
    required String value,
    required VoidCallback onTap,
    String? emoji,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (emoji != null) ...[
              Text(emoji, style: TextStyle(fontSize: 14.sp)),
              SizedBox(width: 4.w),
            ] else if (icon != null) ...[
              Icon(icon, size: 16.sp, color: const Color(0xFF9CA3AF)),
              SizedBox(width: 4.w),
            ],
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 2.w),
            Icon(Icons.keyboard_arrow_down_rounded,
                color: const Color(0xFF9CA3AF), size: 16.sp),
          ],
        ),
      ),
    );
  }

  void _showCategorySelection() {
    final categories = [
      {'slug': '', 'name': 'All Categories'},
      ..._dynamicCategories.map((c) => {'slug': c, 'name': _getCategoryName(c)}),
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w, height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Text('Select Category',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
              SizedBox(height: 12.h),
              ...categories.map((cat) {
                final isSelected = _selectedCategory == (cat['slug']!.isEmpty ? null : cat['slug']);
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
                    size: 20.sp,
                  ),
                  title: Text(cat['name']!,
                    style: GoogleFonts.inter(
                      color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                      fontSize: 14.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    )),
                  onTap: () {
                    Navigator.pop(ctx);
                    final newCat = cat['slug']!.isEmpty ? null : cat['slug'];
                    setState(() => _selectedCategory = newCat);
                    _searchController.clear();
                    final cc = _selectedCountryCode.isEmpty ? null : _selectedCountryCode;
                    context.read<GiftCardCubit>().loadGiftCardBrands(category: newCat, countryCode: cc);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: TextField(
          controller: _searchController,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Search gift cards...',
            hintStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF6B7280),
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 20.sp,
              color: const Color(0xFF6B7280),
            ),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _searchController,
              builder: (context, value, _) {
                if (value.text.isEmpty) return const SizedBox.shrink();
                return GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    context.read<GiftCardCubit>().searchGiftCardBrands(
                      '',
                      countryCode: _selectedCountryCode.isEmpty ? null : _selectedCountryCode,
                    );
                  },
                  child: Icon(
                    Icons.close,
                    size: 18.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                );
              },
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (query) {
            context.read<GiftCardCubit>().searchGiftCardBrands(
              query,
              countryCode: _selectedCountryCode.isEmpty ? null : _selectedCountryCode,
            );
          },
          onChanged: (query) {
            // Debounce search — trigger after 500ms of no typing
            Future.delayed(const Duration(milliseconds: 500), () {
              if (_searchController.text == query) {
                context.read<GiftCardCubit>().searchGiftCardBrands(
                  query,
                  countryCode: _selectedCountryCode.isEmpty ? null : _selectedCountryCode,
                );
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildBrandsList(GiftCardState state) {
    if (state is GiftCardBrandsLoading) {
      return _buildLoadingGrid();
    } else if (state is GiftCardBrandsLoaded) {
      return _buildBrandsGrid(state.brands, hasNext: state.hasNext);
    } else if (state is GiftCardBrandsLoadingMore) {
      return _buildBrandsGrid(state.currentBrands, hasNext: true, isLoadingMore: true);
    } else if (state is GiftCardBrandsSearched) {
      return _buildBrandsGrid(state.brands, hasNext: context.read<GiftCardCubit>().hasNextPage);
    } else if (state is GiftCardBrandsEmpty) {
      return _buildEmptyState();
    } else if (state is GiftCardTimeoutError) {
      return _buildTimeoutState();
    } else if (state is GiftCardServerUnavailable) {
      return _buildServerUnavailableState();
    } else if (state is GiftCardNetworkError) {
      return _buildErrorState(state.message, state.canRetry);
    } else if (state is GiftCardError) {
      return _buildErrorState(state.message, true);
    } else if (state is GiftCardInitial) {
      // Trigger initial load if needed
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<GiftCardCubit>().loadGiftCardBrands(
              countryCode: _selectedCountryCode.isEmpty ? null : _selectedCountryCode,
            );
      });
      return _buildLoadingGrid();
    }
    // For any unrelated state (e.g. after a redeem/transfer), show the last known brands
    // or trigger a fresh load
    return _buildLoadingGrid();
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.85,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: const Color(0xFF1F1F1F),
          highlightColor: const Color(0xFF2D2D2D),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBrandsGrid(List<GiftCardBrand> brands, {bool hasNext = false, bool isLoadingMore = false}) {
    if (brands.isEmpty) {
      return _buildEmptyState();
    }

    // Total items = brands + optional loading indicator at the bottom
    final itemCount = brands.length + (hasNext ? 1 : 0);

    return GridView.builder(
      controller: _scrollController,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 1.0,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= brands.length) {
          // Loading more indicator
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ),
          );
        }
        return _buildBrandCard(brands[index]);
      },
    );
  }

  Widget _buildBrandCard(GiftCardBrand brand) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.purchaseGiftCard, arguments: brand),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 36.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: brand.logoUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Icon(
                      Icons.image_rounded,
                      color: Colors.grey.shade400,
                      size: 24.sp,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.card_giftcard_rounded,
                      color: Colors.grey.shade400,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                brand.name,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2.h),
              Text(
                brand.description,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              // Show local currency starting price — works for both fixed and range-based
              if (brand.minSenderAmount > 0 &&
                  brand.senderCurrencyCode.isNotEmpty &&
                  brand.senderCurrencyCode != brand.currencyCode) ...[
                Text(
                  'From ${brand.senderCurrencyCode} ${brand.minSenderAmount >= 1000 ? brand.minSenderAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (m) => "${m[1]},") : brand.minSenderAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ] else if (brand.denominations.isNotEmpty) ...[
                Text(
                  'From ${brand.currencyCode} ${brand.denominations.first.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
              ],
              if (brand.discountPercentage > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
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
                  Icons.store_outlined,
                  size: 32.sp,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Brands Available',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Try selecting a different country or category',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => context.read<GiftCardCubit>().loadGiftCardBrands(
                      countryCode: _selectedCountryCode,
                    ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  elevation: 0,
                ),
                child: Text(
                  'Refresh',
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
      ],
    );
  }

  Widget _buildErrorState(String message, bool canRetry) {
    return GiftCardErrorList.fromRaw(
      rawMessage: message,
      onRetry: () => context.read<GiftCardCubit>().loadGiftCardBrands(
            countryCode: _selectedCountryCode,
            category: _selectedCategory,
          ),
    );
  }

  Widget _buildTimeoutState() {
    return GiftCardErrorList(
      message: 'Request timed out. Please try again.',
      connectionError: true,
      onRetry: () => context.read<GiftCardCubit>().loadGiftCardBrands(
            countryCode: _selectedCountryCode,
            category: _selectedCategory,
          ),
    );
  }

  Widget _buildServerUnavailableState() {
    return GiftCardErrorList(
      message: 'Something went wrong on our end. Please try again later.',
      onRetry: () => context.read<GiftCardCubit>().loadGiftCardBrands(
            countryCode: _selectedCountryCode,
            category: _selectedCategory,
          ),
    );
  }

  String _getFlagForCountry(String countryCode) {
    // Use dynamic country if available, otherwise generate from code
    if (countryCode.length == 2) {
      final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
      final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
      return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
    }
    return CountrySelectionBottomsheet.getFlag(countryCode);
  }

  String _getCategoryName(String category) {
    if (category.isEmpty) return category;
    return category[0].toUpperCase() + category.substring(1);
  }

  Widget _buildBuySellToggle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (_currentTab != 0) {
                    _searchController.clear();
                    _sellSearchQuery = '';
                    setState(() => _currentTab = 0);
                    context.read<GiftCardCubit>().loadGiftCardBrands(
                          category: _selectedCategory,
                          countryCode: _selectedCountryCode,
                        );
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: _currentTab == 0 ? const Color(0xFF3B82F6) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'Buy',
                    style: GoogleFonts.inter(
                      color: _currentTab == 0 ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (_currentTab != 1) {
                    _searchController.clear();
                    _sellSearchQuery = '';
                    setState(() => _currentTab = 1);
                    context.read<GiftCardCubit>().loadSellableCards();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: _currentTab == 1 ? const Color(0xFF3B82F6) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'Sell',
                    style: GoogleFonts.inter(
                      color: _currentTab == 1 ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSellableCardsList(GiftCardState state) {
    if (state is SellableCardsLoading) {
      return _buildLoadingGrid();
    } else if (state is SellableCardsLoaded) {
      return _buildSellableCardsGrid(state.cards);
    } else if (state is SellableCardsEmpty) {
      return _buildSellEmptyState();
    } else if (state is GiftCardNetworkError) {
      return _buildErrorState(state.message, state.canRetry);
    }
    return _buildLoadingGrid();
  }

  Widget _buildSellableCardsGrid(List<SellableCard> cards) {
    // Apply category and search filters client-side for sell cards
    var filteredCards = _selectedCategory == null
        ? cards
        : cards.where((c) => c.category == _selectedCategory).toList();
    if (_sellSearchQuery.isNotEmpty) {
      filteredCards = filteredCards
          .where((c) =>
              c.displayName.toLowerCase().contains(_sellSearchQuery) ||
              c.cardType.toLowerCase().contains(_sellSearchQuery))
          .toList();
    }

    if (filteredCards.isEmpty) return _buildSellEmptyState();

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.95,
      ),
      itemCount: filteredCards.length,
      itemBuilder: (context, index) => _buildSellableCardTile(filteredCards[index]),
    );
  }

  Widget _buildSellableCardTile(SellableCard card) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.sellGiftCard, arguments: card),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: card.logoUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Icon(
                      Icons.image_rounded,
                      color: Colors.grey.shade400,
                      size: 24.sp,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.card_giftcard_rounded,
                      color: Colors.grey.shade400,
                      size: 24.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                card.displayName,
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
                card.currencies.join(', '),
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              const Spacer(),
              Text(
                '${card.currencies.isNotEmpty ? card.currencies.first : "USD"} ${card.minDenomination.toStringAsFixed(0)} - ${card.maxDenomination.toStringAsFixed(0)}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSellEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
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
                  Icons.sell_outlined,
                  size: 32.sp,
                  color: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Cards to Sell',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Sellable card types will appear here when available',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => context.read<GiftCardCubit>().loadSellableCards(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  elevation: 0,
                ),
                child: Text(
                  'Refresh',
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
      ],
    );
  }

  void _showBrandSearch() {
    final currentState = context.read<GiftCardCubit>().state;
    List<GiftCardBrand> availableBrands = [];

    if (currentState is GiftCardBrandsLoaded) {
      availableBrands = currentState.brands;
    } else if (currentState is GiftCardBrandsSearched) {
      availableBrands = currentState.brands;
    }

    Get.bottomSheet(
      BlocProvider.value(
        value: context.read<GiftCardCubit>(),
        child: BrandSearchBottomSheet(
          initialBrands: availableBrands,
          onBrandSelected: (brand) {
            Get.toNamed(AppRoutes.purchaseGiftCard, arguments: brand);
          },
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
    );
  }

}
