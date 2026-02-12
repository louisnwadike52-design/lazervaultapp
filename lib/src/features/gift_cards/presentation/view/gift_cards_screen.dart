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

class GiftCardsScreen extends StatefulWidget {
  const GiftCardsScreen({super.key});

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  String? _selectedCategory;
  int _currentTab = 0; // 0 = Buy, 1 = Sell

  static const List<String> _categories = [
    'shopping',
    'dining',
    'entertainment',
    'travel',
    'gaming',
    'other',
  ];

  @override
  void initState() {
    super.initState();
    context.read<GiftCardCubit>().loadGiftCardBrands();
  }

  Future<void> _onRefresh() async {
    if (_currentTab == 0) {
      await context.read<GiftCardCubit>().loadGiftCardBrands(
        category: _selectedCategory,
      );
    } else {
      await context.read<GiftCardCubit>().loadSellableCards();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 12.h),
            _buildBuySellToggle(),
            SizedBox(height: 8.h),
            if (_currentTab == 0) _buildCategoryFilter(),
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
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
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
            child: GestureDetector(
              onTap: () => _showBrandSearch(),
              child: Container(
                height: 44.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: const Color(0xFF9CA3AF), size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Search gift cards',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.myGiftCards),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.card_giftcard_rounded, color: const Color(0xFF3B82F6), size: 20.sp),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
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
        child: VoiceCommandSheet(suggestions: giftCardSuggestions),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: _categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildCategoryChip('All', null);
          }
          final category = _categories[index - 1];
          return _buildCategoryChip(_getCategoryName(category), category);
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, String? category) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = isSelected ? null : category;
        });
        if (category != null && !isSelected) {
          context.read<GiftCardCubit>().loadGiftCardBrands(category: category);
        } else {
          context.read<GiftCardCubit>().loadGiftCardBrands();
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF9CA3AF),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildBrandsList(GiftCardState state) {
    if (state is GiftCardBrandsLoading) {
      return _buildLoadingGrid();
    } else if (state is GiftCardBrandsLoaded) {
      return _buildBrandsGrid(state.brands);
    } else if (state is GiftCardBrandsSearched) {
      return _buildBrandsGrid(state.brands);
    } else if (state is GiftCardBrandsEmpty) {
      return _buildEmptyState();
    } else if (state is GiftCardNetworkError) {
      return _buildErrorState(state.message, state.canRetry);
    } else if (state is GiftCardError) {
      return _buildErrorState(state.message, true);
    }
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

  Widget _buildBrandsGrid(List<GiftCardBrand> brands) {
    if (brands.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.85,
      ),
      itemCount: brands.length,
      itemBuilder: (context, index) {
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
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 52.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
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
              SizedBox(height: 12.h),
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
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
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
                'Gift card brands will appear here when available',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => context.read<GiftCardCubit>().loadGiftCardBrands(),
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
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 32.sp,
                  color: const Color(0xFFEF4444),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Something went wrong',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (canRetry) ...[
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () => context.read<GiftCardCubit>().loadGiftCardBrands(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    elevation: 0,
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
            ],
          ),
        ),
      ],
    );
  }

  String _getCategoryName(String category) {
    switch (category) {
      case 'shopping':
        return 'Retail';
      case 'dining':
        return 'Food';
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
                    setState(() => _currentTab = 0);
                    context.read<GiftCardCubit>().loadGiftCardBrands(category: _selectedCategory);
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
    if (cards.isEmpty) return _buildSellEmptyState();

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.95,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) => _buildSellableCardTile(cards[index]),
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
                '\$${card.minDenomination.toStringAsFixed(0)} - \$${card.maxDenomination.toStringAsFixed(0)}',
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
