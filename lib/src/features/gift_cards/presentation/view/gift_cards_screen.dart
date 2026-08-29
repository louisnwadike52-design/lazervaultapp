import 'package:flutter/material.dart';
import 'package:lazervault/src/features/gift_cards/presentation/widgets/giftcard_background.dart';
import 'widgets/pre_order_notice.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/widgets/rich_card_text.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../utils/sell_card_logo.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import '../../../widgets/service_voice_button.dart';
import 'widgets/country_selection_bottomsheet.dart';
import 'widgets/gift_card_error_widget.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class GiftCardsScreen extends StatefulWidget {
  const GiftCardsScreen({super.key});

  @override
  State<GiftCardsScreen> createState() => _GiftCardsScreenState();
}

class _GiftCardsScreenState extends State<GiftCardsScreen> {
  String? _selectedCategory;
  int _currentTab = 0; // 0 = Buy, 1 = Sell
  String _selectedCountryCode = ''; // Empty = All Countries (default) — BUY tab

  // SELL country, empty = every region Prestmit supports.
  //
  // This used to be a const pinned to 'US', which meant the Sell tab requested
  // only US cards and every other region Prestmit publishes — UK, EURO,
  // CANADA and OTHERS — was unreachable. 177 subcategories were seeded and
  // sellers could see roughly a third of them; a Turkey iTunes card, for
  // instance, could never be listed for sale at all.
  //
  // Defaulting to empty shows the whole catalogue, and the picker below now
  // narrows it for real (the backend matcher was also fixed — it compared
  // Prestmit's own region labels against ISO aliases, so selecting Canada had
  // returned only untagged cards).
  String _sellCountryCode = '';

  /// Regions Prestmit actually publishes, learned from an UNFILTERED load.
  ///
  /// The picker used to offer Reloadly's country list, which is the BUY
  /// catalogue's. Choosing a country Prestmit has no cards for returned only
  /// the untagged global set, so the filter looked like it worked while
  /// showing the same rows for every such country. Offering only regions that
  /// exist means every option changes the result.
  List<String> _sellRegions = [];
  /// Sell-side category, kept separate from the buy tab's _selectedCategory.
  /// The two catalogues use different taxonomies and must not share state.
  String? _sellCategory;
  /// How many sellable cards are currently rendered. The sell catalogue is a
  /// single live provider read (~177 cards, more before any filter), so it is
  /// paged CLIENT-side: that keeps one page-size rule across all three filter
  /// states (unfiltered, country, category) instead of paging the unfiltered
  /// list server-side and then filtering the page, which would hand back
  /// short or empty pages that still claimed more were coming.
  int _sellVisibleCount = _kSellPageSize;
  static const int _kSellPageSize = 20;
  List<String> _sellCategories = [];
  final ScrollController _scrollController = ScrollController();
  /// The sell grid needs its OWN controller: a ScrollController drives exactly
  /// one attached scroll view, and the buy grid already claims the one above.
  /// Sharing it would leave the sell tab's paging silently dead.
  final ScrollController _sellScrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<GiftCardCountry> _supportedCountries = [];

  List<String> _dynamicCategories = [];
  String _sellSearchQuery = '';

  @override
  void initState() {
    super.initState();
    // Read optional initialTab argument (e.g., from MySales back button)
    // so callers can land users on a specific tab. "sell" → Sell tab,
    // anything else (or absent) → Buy tab default.
    final args = Get.arguments;
    if (args is Map && args['initialTab']?.toString().toLowerCase() == 'sell') {
      _currentTab = 1;
    }
    final cubit = context.read<GiftCardCubit>();
    // Load data for both tabs so switching is instant
    cubit.loadGiftCardBrands();
    cubit.loadSellableCards(
            countryCode: _sellCountryCode.isEmpty ? null : _sellCountryCode);
    cubit.loadSupportedCountries();
    _scrollController.addListener(_onScroll);
    _sellScrollController.addListener(_onSellScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _sellScrollController.dispose();
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

  /// Size of the current filtered sell result set, published by the grid so
  /// the scroll handler can page without recomputing the filters.
  int _sellTotal = 0;

  /// Grows the sell window as the user nears the end. Paging is local, so this
  /// only widens what is rendered — it never refetches, and it can never
  /// promise more rows than the active filters actually yield.
  void _onSellScroll() {
    if (!_sellScrollController.hasClients) return;
    if (_sellScrollController.position.pixels <
        _sellScrollController.position.maxScrollExtent - 200) {
      return;
    }
    if (_sellVisibleCount >= _sellTotal) return;
    setState(() {
      _sellVisibleCount =
          (_sellVisibleCount + _kSellPageSize).clamp(0, _sellTotal);
    });
  }

  /// Any change to the sell filters restarts paging — otherwise switching from
  /// a 100-card region to a 3-card one leaves the window scrolled past the end.
  void _resetSellPaging() {
    _sellVisibleCount = _kSellPageSize;
  }

  Future<void> _onRefresh() async {
    if (_currentTab == 0) {
      _searchController.clear();
      await context.read<GiftCardCubit>().loadGiftCardBrands(
            category: _selectedCategory,
            countryCode:
                _selectedCountryCode.isEmpty ? null : _selectedCountryCode,
          );
    } else {
      await context
          .read<GiftCardCubit>()
          .loadSellableCards(
            countryCode: _sellCountryCode.isEmpty ? null : _sellCountryCode);
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
          backgroundColor: kGiftCardBgTop,
          // Opaque tap-outside-to-dismiss for the catalog search field (the
          // global translucent dismiss in main.dart only fires on empty space).
          body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: GiftCardBackground(
                  child: SafeArea(
                child: Column(
                  children: [
                    // Header stays static; everything below rises + fades in on load.
                    _buildHeader(),
                    Expanded(
                      child: ServiceEntranceAnimation(
                        child: Column(
                          children: [
                            SizedBox(height: 12.h),
                            _buildQuickActions(),
                            SizedBox(height: 12.h),
                            _buildBuySellToggle(),
                            SizedBox(height: 8.h),
                            _buildSearchAndFilters(),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: _onRefresh,
                                color: InvoiceThemeColors.primaryPurple,
                                backgroundColor: const Color(0xFF1F1F1F),
                                // `buildWhen` filters out cubit emissions that belong
                                // to the OTHER tab's data fetch (SellableCards*,
                                // SellRate*, SupportedCountriesLoaded, etc.). Without
                                // it, `context.watch` rebuilt the brand grid every
                                // time loadSellableCards()/loadSupportedCountries()
                                // (both kicked off from initState) emitted a state,
                                // which dropped through the brand-grid fall-through
                                // and re-triggered loadGiftCardBrands() + flashed
                                // shimmer over a settled "no brand" / loaded grid.
                                child:
                                    BlocBuilder<GiftCardCubit, GiftCardState>(
                                  buildWhen: (prev, curr) {
                                    return _currentTab == 0
                                        ? _isBrandTabState(curr)
                                        : _isSellTabState(curr);
                                  },
                                  builder: (context, state) => _currentTab == 0
                                      ? _buildBrandsList(state)
                                      : _buildSellableCardsList(state),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
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
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
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
          // Voice button routes through ServiceVoiceButton so that
          //   1. VoiceSetupGuard gates enrollment + high-risk verify
          //   2. VoiceCommandSheet opens with serviceName='giftcards',
          //      pinning the LLM router to the gift-cards agent (the
          //      previous inline mic opened the sheet without a service,
          //      so the agent defaulted to the general router).
          ServiceVoiceButton(
            serviceName: 'giftcards',
            buttonSize: 44.w,
            iconSize: 20.sp,
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Gift Cards',
            sourceContext: 'giftcards',
            icon: Icons.chat_bubble_outline,
            iconColor: InvoiceThemeColors.primaryPurple,
          ),
        ],
      ),
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
              color: InvoiceThemeColors.primaryPurple,
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

  Widget _buildSearchAndFilters() {
    // Each tab keeps its own country: a seller narrowing to Canada should not
    // silently re-filter the buy catalogue behind them.
    final activeCountry =
        _currentTab == 0 ? _selectedCountryCode : _sellCountryCode;
    final flag = activeCountry.isEmpty
        ? '\u{1F30D}'
        : _getFlagForCountry(activeCountry);
    final countryLabel = activeCountry.isEmpty
        ? 'All'
        : (_currentTab == 1
            ? (_sellRegionNames[activeCountry.toUpperCase()] ??
                activeCountry.toUpperCase())
            : activeCountry.toUpperCase());
    final activeCategory = _currentTab == 0 ? _selectedCategory : _sellCategory;
    final categoryLabel =
        activeCategory == null ? 'All' : _getCategoryName(activeCategory);

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
                  hintText: _currentTab == 0
                      ? 'Search gift cards...'
                      : 'Search sellable cards...',
                  hintStyle: GoogleFonts.inter(
                      fontSize: 14.sp, color: const Color(0xFF6B7280)),
                  prefixIcon: Icon(Icons.search,
                      size: 20.sp, color: const Color(0xFF6B7280)),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _searchController,
                    builder: (context, value, _) {
                      if (value.text.isEmpty) return const SizedBox.shrink();
                      return GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                        child: Icon(Icons.close,
                            size: 18.sp, color: const Color(0xFF9CA3AF)),
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
          // Country filter on BOTH tabs. Sell is no longer pinned to one
          // region, so hiding the picker there would leave the rest of
          // Prestmit's catalogue browsable only by scrolling.
          _buildFilterButton(
            key: const Key('country_selector_button'),
            label: 'Country',
            value: countryLabel,
            emoji: flag,
            onTap: () => _currentTab == 1
                ? _showSellRegionSelection()
                : _showCountrySelection(),
          ),
          SizedBox(width: 8.w),
          _buildFilterButton(
            label: 'Category',
            value: categoryLabel,
            icon: Icons.category_rounded,
            onTap: () => _currentTab == 1
                ? _showSellCategorySelection()
                : _showCategorySelection(),
          ),
        ],
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (_currentTab == 0) {
      // Buy tab: server-side search
      context.read<GiftCardCubit>().searchGiftCardBrands(query,
          countryCode:
              _selectedCountryCode.isEmpty ? null : _selectedCountryCode);
    } else {
      // Sell tab: client-side filter
      setState(() {
        _sellSearchQuery = query.trim().toLowerCase();
        _resetSellPaging();
      });
    }
  }

  /// Learns the available regions from a full (unfiltered) catalogue load.
  /// A filtered load is ignored — it only contains one region by definition
  /// and would shrink the picker to the current selection.
  void _captureSellRegions(List<SellableCard> cards) {
    if (_sellCountryCode.isNotEmpty) return;
    final regions = cards
        .map((c) => c.country.trim().toUpperCase())
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    if (regions.isEmpty || regions.toString() == _sellRegions.toString()) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _sellRegions = regions);
    });
  }

  /// Prestmit's region labels are not ISO codes, so they are given readable
  /// names here rather than run through a flag/ISO lookup that would not
  /// resolve them.
  static const Map<String, String> _sellRegionNames = {
    'USA': 'United States',
    'UK': 'United Kingdom',
    'EURO': 'Europe (Euro)',
    'CANADA': 'Canada',
    'OTHERS': 'Other regions',
  };

  /// Learns the sell taxonomy from the loaded catalogue. Unlike the buy tab
  /// there is no categories RPC for sellable cards, and the categories are
  /// Prestmit's own labels — so they are derived from what actually came back
  /// rather than assumed.
  void _captureSellCategories(List<SellableCard> cards) {
    final cats = cards
        .map((c) => c.category.trim())
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    // A category chosen under one region may not exist in the next. Left in
    // place it silently empties the grid with no indication why, so it is
    // dropped as soon as it is no longer offered.
    final selectionGone = _sellCategory != null &&
        !cats.any((c) => c.toLowerCase() == _sellCategory!.toLowerCase());
    if (!selectionGone &&
        (cats.isEmpty || cats.toString() == _sellCategories.toString())) {
      return;
    }
    // Deferred: this is reached from build(), where setState throws.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _sellCategories = cats;
        if (selectionGone) {
          _sellCategory = null;
          _resetSellPaging();
        }
      });
    });
  }

  /// Resets both sell filters. Country is server-side so it needs a refetch;
  /// category is client-side and clears with setState alone.
  void _clearSellFilters() {
    final hadCountry = _sellCountryCode.isNotEmpty;
    setState(() {
      _sellCountryCode = '';
      _sellCategory = null;
      _resetSellPaging();
    });
    if (hadCountry) {
      context.read<GiftCardCubit>().loadSellableCards();
    }
  }

  void _showSellCategorySelection() {
    if (_sellCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Categories load with the sellable cards.',
              style: GoogleFonts.inter(fontSize: 13.sp)),
          backgroundColor: const Color(0xFF1F1F1F),
        ),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.7),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                Text('Select Category',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 12.h),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _sellCategoryTile(ctx, null, 'All Categories'),
                      ..._sellCategories.map((c) =>
                          _sellCategoryTile(ctx, c, _getCategoryName(c))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sellCategoryTile(BuildContext ctx, String? value, String label) {
    final isSelected = _sellCategory == value;
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
      leading: Icon(
        isSelected ? Icons.check_circle : Icons.circle_outlined,
        color: isSelected
            ? InvoiceThemeColors.primaryPurple
            : const Color(0xFF6B7280),
        size: 20.sp,
      ),
      title: Text(label,
          style: GoogleFonts.inter(
            color: isSelected ? InvoiceThemeColors.primaryPurple : Colors.white,
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          )),
      onTap: () {
        Navigator.pop(ctx);
        // Purely client-side: the sellable catalogue is already loaded, so
        // this must NOT call loadGiftCardBrands (a BUY-catalogue RPC, which
        // is what the shared picker used to do from the sell tab).
        setState(() {
      _sellCategory = value;
      _resetSellPaging();
    });
      },
    );
  }

  void _showSellRegionSelection() {
    final regions = _sellRegions;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Text('Filter by region',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600)),
            ),
            ListTile(
              title: Text('All regions',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
              trailing: _sellCountryCode.isEmpty
                  ? const Icon(Icons.check, color: Color(0xFF10B981))
                  : null,
              onTap: () {
                Navigator.of(ctx).pop();
                _applySellRegion('');
              },
            ),
            ...regions.map((r) => ListTile(
                  title: Text(_sellRegionNames[r] ?? r,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 14.sp)),
                  trailing: _sellCountryCode == r
                      ? const Icon(Icons.check, color: Color(0xFF10B981))
                      : null,
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _applySellRegion(r);
                  },
                )),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  void _applySellRegion(String region) {
    setState(() {
      _sellCountryCode = region;
      _resetSellPaging();
    });
    // Re-fetch: the selected region's cards may not be in the loaded set.
    context.read<GiftCardCubit>().loadSellableCards(
          countryCode: region.isEmpty ? null : region,
        );
  }

  void _showCountrySelection() {
    // Applies to whichever tab is open. Each keeps its own selection, so
    // narrowing the sell catalogue does not silently re-filter the buy one.
    final isSell = _currentTab == 1;
    CountrySelectionBottomsheet.show(
      context: context,
      selectedCountryCode: isSell ? _sellCountryCode : _selectedCountryCode,
      dynamicCountries: _supportedCountries,
      onCountrySelected: (countryCode, countryName) {
        if (isSell) {
          setState(() => _sellCountryCode = countryCode);
          // Re-fetch rather than filter what is already on screen: the
          // catalogue is resolved server-side against Prestmit's region
          // labels, so the selected country's cards may not be in the set
          // currently loaded.
          context.read<GiftCardCubit>().loadSellableCards(
                countryCode: countryCode.isEmpty ? null : countryCode,
              );
          return;
        }
        setState(() => _selectedCountryCode = countryCode);
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
    Key? key,
  }) {
    return GestureDetector(
      key: key,
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
      ..._dynamicCategories
          .map((c) => {'slug': c, 'name': _getCategoryName(c)}),
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
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Text('Select Category',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 12.h),
              ...categories.map((cat) {
                final isSelected = _selectedCategory ==
                    (cat['slug']!.isEmpty ? null : cat['slug']);
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                  leading: Icon(
                    isSelected ? Icons.check_circle : Icons.circle_outlined,
                    color: isSelected
                        ? InvoiceThemeColors.primaryPurple
                        : const Color(0xFF6B7280),
                    size: 20.sp,
                  ),
                  title: Text(cat['name']!,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? InvoiceThemeColors.primaryPurple
                            : Colors.white,
                        fontSize: 14.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      )),
                  onTap: () {
                    Navigator.pop(ctx);
                    final newCat = cat['slug']!.isEmpty ? null : cat['slug'];
                    setState(() => _selectedCategory = newCat);
                    _searchController.clear();
                    final cc = _selectedCountryCode.isEmpty
                        ? null
                        : _selectedCountryCode;
                    context
                        .read<GiftCardCubit>()
                        .loadGiftCardBrands(category: newCat, countryCode: cc);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Filters for the per-tab BlocBuilder. Brand and sell flows share one
  // cubit but emit independent state families; without these gates the
  // brand grid rebuilt on every SellableCards*/SupportedCountriesLoaded
  // emission and re-fired loadGiftCardBrands() through the fall-through
  // branch in _buildBrandsList, flashing shimmer over a settled grid.
  bool _isBrandTabState(GiftCardState s) =>
      s is GiftCardInitial ||
      s is GiftCardBrandsLoading ||
      s is GiftCardBrandsLoaded ||
      s is GiftCardBrandsLoadingMore ||
      s is GiftCardBrandsSearched ||
      s is GiftCardBrandsEmpty ||
      s is GiftCardTimeoutError ||
      s is GiftCardServerUnavailable ||
      s is GiftCardNetworkError ||
      s is GiftCardError;

  bool _isSellTabState(GiftCardState s) =>
      s is GiftCardInitial ||
      s is SellableCardsLoading ||
      s is SellableCardsLoaded ||
      s is SellableCardsEmpty ||
      s is GiftCardTimeoutError ||
      s is GiftCardServerUnavailable ||
      s is GiftCardNetworkError ||
      s is GiftCardError;

  Widget _buildBrandsList(GiftCardState state) {
    if (state is GiftCardBrandsLoading) {
      return _buildLoadingGrid();
    } else if (state is GiftCardBrandsLoaded) {
      return _buildBrandsGrid(state.brands, hasNext: state.hasNext);
    } else if (state is GiftCardBrandsLoadingMore) {
      return _buildBrandsGrid(state.currentBrands,
          hasNext: true, isLoadingMore: true);
    } else if (state is GiftCardBrandsSearched) {
      return _buildBrandsGrid(state.brands,
          hasNext: context.read<GiftCardCubit>().hasNextPage);
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
              countryCode:
                  _selectedCountryCode.isEmpty ? null : _selectedCountryCode,
            );
      });
      return _buildLoadingGrid();
    }
    // Fall-through: any unrelated state (after a redeem, transfer,
    // sell, or purchase). Without recovery this used to shimmer
    // forever — buy tab effectively bricked once the user touched a
    // non-brand flow. Show last-known brands when we have them, and
    // trigger a re-load otherwise so the screen always converges.
    final cachedBrands = context.read<GiftCardCubit>().cachedBrands;
    if (cachedBrands.isNotEmpty) {
      return _buildBrandsGrid(
        cachedBrands,
        hasNext: context.read<GiftCardCubit>().hasNextPage,
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GiftCardCubit>().loadGiftCardBrands(
            countryCode:
                _selectedCountryCode.isEmpty ? null : _selectedCountryCode,
          );
    });
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
        // Keep in sync with the real brands grid (_buildBrandsGrid) so the
        // shimmer placeholders match the loaded cards' (shorter) height.
        childAspectRatio: 1.28,
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

  Widget _buildBrandsGrid(List<GiftCardBrand> brands,
      {bool hasNext = false, bool isLoadingMore = false}) {
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
        // Shorter cards (was 1.0 = square, which wasted vertical space). Keep the
        // shimmer grid (_buildLoadingGrid) at the same ratio.
        childAspectRatio: 1.28,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index >= brands.length) {
          // Loading more indicator
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: LazerVaultLoader.small(),
            ),
          );
        }
        return _buildBrandCard(brands[index]);
      },
    );
  }

  /// Starting price with the pre-order marker beside it.
  ///
  /// The two facts that decide whether to open a card are what it costs and
  /// when it arrives, so they share a line. Placing the marker here rather
  /// than over the logo keeps the brand mark legible, and using the row's
  /// spare horizontal width leaves the tile height (a fixed childAspectRatio
  /// of 1.28 with a Spacer absorbing the slack) completely unchanged.
  Widget _priceWithPreOrder(GiftCardBrand brand, String priceLabel) {
    final price = Text(
      priceLabel,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        // Readable green (matches the sell-tile price + discount badge);
        // the old primaryPurple #4E03D0 was near-invisible on the card.
        color: const Color(0xFF10B981),
      ),
    );
    if (!brand.preOrder) return price;
    return Row(
      children: [
        Flexible(child: price),
        SizedBox(width: 4.w),
        const PreOrderBadge(),
      ],
    );
  }

  Widget _buildBrandCard(GiftCardBrand brand) {
    return GestureDetector(
      key: Key('giftcard_brand_card_${brand.id}'),
      onTap: () => Get.toNamed(AppRoutes.purchaseGiftCard, arguments: brand),
      child: Container(
        // Swap-style gradient card (mirrors crypto swap screen) for a richer,
        // more legible surface than the old flat #1F1F1F.
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1F1F1F), Color(0xFF2D2D2D)],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo plate. The pre-order marker deliberately does NOT overlay
              // this: covering the brand mark costs more than it communicates.
              Stack(
                children: [
                  Container(
                    height: 32.h,
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
                ],
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
                plainFromRichText(brand.description),
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              // Show local currency starting price — works for both fixed and range-based
              if (brand.minSenderAmount > 0 &&
                  brand.senderCurrencyCode.isNotEmpty &&
                  brand.senderCurrencyCode != brand.currencyCode) ...[
                _priceWithPreOrder(
                  brand,
                  'From ${brand.senderCurrencyCode} ${brand.minSenderAmount >= 1000 ? brand.minSenderAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (m) => "${m[1]},") : brand.minSenderAmount.toStringAsFixed(2)}',
                ),
              ] else if (brand.denominations.isNotEmpty) ...[
                _priceWithPreOrder(
                  brand,
                  'From ${brand.currencyCode} ${brand.denominations.first.toStringAsFixed(0)}',
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
                onPressed: () =>
                    context.read<GiftCardCubit>().loadGiftCardBrands(
                          countryCode: _selectedCountryCode,
                        ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: InvoiceThemeColors.primaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
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
      return String.fromCharCode(firstLetter) +
          String.fromCharCode(secondLetter);
    }
    return CountrySelectionBottomsheet.getFlag(countryCode);
  }

  String _getCategoryName(String category) {
    if (category.isEmpty) return category;
    return category[0].toUpperCase() + category.substring(1);
  }


  // Real brand logo for a sellable card — see sellCardLogoUrl() in
  // utils/sell_card_logo.dart. Shared with the sell detail header so both
  // surfaces derive the same Clearbit fallback for logo-less Prestmit cards.
  String _sellCardLogoUrl(SellableCard card) => sellCardLogoUrl(card);

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
                key: const Key('giftcards_buy_tab'),
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
                    color: _currentTab == 0
                        ? InvoiceThemeColors.primaryPurple
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'Buy',
                    style: GoogleFonts.inter(
                      color: _currentTab == 0
                          ? Colors.white
                          : const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                key: const Key('giftcards_sell_tab'),
                onTap: () {
                  if (_currentTab != 1) {
                    _searchController.clear();
                    _sellSearchQuery = '';
                    setState(() => _currentTab = 1);
                    context
                        .read<GiftCardCubit>()
                        .loadSellableCards(
            countryCode: _sellCountryCode.isEmpty ? null : _sellCountryCode);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: _currentTab == 1
                        ? InvoiceThemeColors.primaryPurple
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'Sell',
                    style: GoogleFonts.inter(
                      color: _currentTab == 1
                          ? Colors.white
                          : const Color(0xFF9CA3AF),
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
    // Stale-while-revalidate: if the cubit holds cached sellable cards,
    // always render them — even when the current state is a Loading or an
    // unrelated state from a sibling tab (buy / countries / mySales).
    // The cubit re-emits SellableCardsLoaded on revalidation; users only
    // see a loading state on the very first load.
    final cubit = context.read<GiftCardCubit>();
    final cached = cubit.cachedSellableCards;

    if (state is SellableCardsEmpty) {
      // The backend returns an EMPTY catalogue (never a fallback) when
      // Prestmit — the only rail that can redeem a card — is unconfigured,
      // erroring, or answers with zero cards. With a region selected the same
      // empty result may simply mean that region carries nothing, so the two
      // are told apart rather than blaming the provider for a filter.
      return _sellCountryCode.isEmpty
          ? _buildSellUnavailableState()
          : _buildSellEmptyState(filtered: true);
    }
    if (state is SellableCardsLoaded) {
      _captureSellRegions(state.cards);
      _captureSellCategories(state.cards);
      return _buildSellableCardsGrid(state.cards);
    }
    if (cached.isNotEmpty) {
      return _buildSellableCardsGrid(cached);
    }
    if (state is GiftCardNetworkError) {
      return _buildErrorState(state.message, state.canRetry);
    }
    // Only true cold start (no cache, no data) shows the loading shimmer.
    return _buildLoadingGrid();
  }

  Widget _buildSellableCardsGrid(List<SellableCard> cards) {
    // Region filtering happens SERVER-side: every sell load passes
    // _sellCountryCode as the RPC's countryCode, so `cards` already contains
    // only the chosen region. There used to be a hard USA-only gate here,
    // which silently discarded every UK, EURO, CANADA and OTHERS card the
    // server returned — so widening the backend filter changed nothing that
    // the user could actually see.
    var filteredCards = cards;
    // Category is filtered client-side, against the SELL taxonomy. It must not
    // reuse _selectedCategory: that holds a buy-catalogue slug ("gaming"),
    // while a sellable card's category is Prestmit's own label. Comparing the
    // two is never equal, so picking any category emptied the grid.
    if (_sellCategory != null) {
      filteredCards = filteredCards
          .where((c) =>
              c.category.trim().toLowerCase() ==
              _sellCategory!.trim().toLowerCase())
          .toList();
    }
    if (_sellSearchQuery.isNotEmpty) {
      filteredCards = filteredCards
          .where((c) =>
              c.displayName.toLowerCase().contains(_sellSearchQuery) ||
              c.cardType.toLowerCase().contains(_sellSearchQuery))
          .toList();
    }

    if (filteredCards.isEmpty) return _buildSellEmptyState(filtered: true);

    // Publish the filtered size so _onScroll can page without re-filtering,
    // and clamp the window in case a filter shrank the result set since the
    // last frame.
    _sellTotal = filteredCards.length;
    final visible = _sellVisibleCount.clamp(0, filteredCards.length);
    final pageCards = filteredCards.take(visible).toList();
    final hasMore = visible < filteredCards.length;

    return GridView.builder(
      controller: _sellScrollController,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        // Shorter tiles for parity with the buy grid (was 0.95 = taller-than-wide).
        childAspectRatio: 1.2,
      ),
      // One trailing cell carries the paging footer when a page is still held
      // back, matching how the buy grid appends its load-more indicator.
      itemCount: pageCards.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= pageCards.length) {
          return _buildSellPagingFooter(visible, filteredCards.length);
        }
        return _buildSellableCardTile(pageCards[index]);
      },
    );
  }

  /// Shown when the sell catalogue comes back empty with no region selected.
  ///
  /// The backend serves this surface from ONE provider and deliberately has no
  /// fallback: a sell quote is a promise to pay for a card, and only the rail
  /// that can actually redeem the card can make it. Rather than quote from a
  /// stale local table and commit to a payout nobody can honour, the sell
  /// surface closes and says so. Buying is unaffected, so the copy points
  /// there instead of leaving the user at a dead end.
  Widget _buildSellUnavailableState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 72.h),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 76.w,
                  height: 76.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.10),
                    border: Border.all(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.28),
                    ),
                  ),
                  child: Icon(
                    Icons.pause_circle_outline_rounded,
                    size: 34.sp,
                    color: const Color(0xFFF59E0B),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Selling is paused',
                  key: const Key('sell_unavailable_title'),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'We can\'t reach our gift card partner right now, so live '
                  'rates are unavailable. We\'ve paused selling rather than '
                  'quote a rate we might not be able to honour.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    height: 1.55,
                  ),
                ),
                SizedBox(height: 18.h),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.shield_outlined,
                          size: 17.sp, color: const Color(0xFF10B981)),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'Your cards and balance are safe. Nothing has been '
                          'submitted or charged.',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFD1D5DB),
                            fontSize: 12.5.sp,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    key: const Key('sell_unavailable_retry'),
                    onPressed: () =>
                        context.read<GiftCardCubit>().loadSellableCards(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: InvoiceThemeColors.primaryPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                    ),
                    child: Text(
                      'Try again',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                TextButton(
                  // Mirrors the Buy toggle exactly — switching tabs without
                  // clearing the sell search and loading the buy catalogue
                  // lands the user on an empty buy grid still filtered by a
                  // query they typed on the other tab.
                  onPressed: () {
                    _searchController.clear();
                    _sellSearchQuery = '';
                    setState(() => _currentTab = 0);
                    context.read<GiftCardCubit>().loadGiftCardBrands(
                          category: _selectedCategory,
                          countryCode: _selectedCountryCode,
                        );
                  },
                  child: Text(
                    'Buy gift cards instead',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.primaryPurple,
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
    );
  }

  /// Trailing cell shown while more filtered results are held back. It states
  /// the counts rather than only spinning, so a seller can tell "still
  /// loading" apart from "that is everything" without scrolling to find out.
  Widget _buildSellPagingFooter(int shown, int total) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20.w,
            height: 20.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                  InvoiceThemeColors.primaryPurple),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            '$shown of $total',
            key: const Key('sell_paging_footer'),
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// What this card pays the seller, in the payout currency.
  ///
  /// Uses the provider's own rate (naira per unit of face currency) taken on
  /// the same catalogue read as the rest of the tile, so the figure can never
  /// be a stale stored rate. Returns null when the provider published no rate
  /// or no minimum — showing nothing is correct there, because a payout
  /// computed from a missing rate would be invented.
  String? _sellablePayoutLabel(SellableCard card) {
    final rate = card.payoutRatePerUnit;
    final min = card.minDenomination;
    if (rate <= 0 || min <= 0) return null;
    final payout = min * rate;
    // Same grouping expression the buy tile uses. RegExp is compiled at
    // runtime, so an unbalanced one throws where the analyzer cannot see it.
    final formatted = payout.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
    return 'From NGN $formatted';
  }

  /// Renders a sellable card's accepted range.
  ///
  /// Prestmit publishes a MINIMUM for every subcategory but a maximum for only
  /// some, so the missing ones arrive as 0. Interpolating both blindly printed
  /// "USD 10 - 0" on the catalogue — a range that ends below where it starts,
  /// which reads as broken and tells the seller nothing about what is actually
  /// accepted. An open-ended range is now shown as open-ended.
  String _sellableRangeLabel(SellableCard card) {
    // No currency is NOT USD. Prestmit publishes no currency field, and its
    // OTHERS region spans TRY, CHF, AUD, NZD, SGD and more, so the backend
    // sends none for those. Defaulting to "USD" here printed a lira card as
    // dollars — the seller reads that as the currency they are paid against,
    // so an absent code is shown as absent.
    final ccy = card.currencies.isNotEmpty ? card.currencies.first : '';
    final prefix = ccy.isEmpty ? '' : '$ccy ';
    final min = card.minDenomination;
    final max = card.maxDenomination;
    final minText = min.toStringAsFixed(0);

    // A missing maximum means Prestmit published no band ceiling for this
    // card, not a ceiling of zero. It used to render "USD 10 - 0" — a range
    // ending below where it starts.
    if (max <= 0 || max <= min) {
      return ccy.isEmpty ? 'Min $minText' : '$prefix$minText+';
    }
    return '$prefix$minText - ${max.toStringAsFixed(0)}';
  }

  Widget _buildSellableCardTile(SellableCard card) {
    return GestureDetector(
      key: Key('sellable_card_tile_${card.cardType}'),
      onTap: () => Get.toNamed(AppRoutes.sellGiftCard, arguments: card),
      child: Container(
        // Swap-style gradient card, matching the buy grid.
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1F1F1F), Color(0xFF2D2D2D)],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: _sellCardLogoUrl(card),
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
              // What the seller actually gets, in their own money. The buy
              // list has always led with "From NGN x"; the sell list showed
              // only a foreign face value, which is the figure a Nigerian
              // seller cares least about.
              if (_sellablePayoutLabel(card) != null)
                Text(
                  _sellablePayoutLabel(card)!,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF10B981),
                  ),
                ),
              Text(
                _sellableRangeLabel(card),
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [filtered] is true when the catalogue DID return cards but the user's own
  /// country/category selection excluded all of them. The generic "none
  /// available, try Refresh" copy is wrong there — Refresh re-runs the same
  /// query and the category filter is client-side, so nothing would change.
  Widget _buildSellEmptyState({bool filtered = false}) {
    final activeFilters = <String>[
      if (_sellCountryCode.isNotEmpty)
        _sellRegionNames[_sellCountryCode.toUpperCase()] ??
            _sellCountryCode.toUpperCase(),
      if (_sellCategory != null) _getCategoryName(_sellCategory!),
    ];
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
                filtered ? 'No Matches' : 'No Cards to Sell',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                filtered
                    ? 'No sellable cards match ${activeFilters.join(' + ')}.'
                    : 'Sellable card types will appear here when available',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => filtered
                    ? _clearSellFilters()
                    : context.read<GiftCardCubit>().loadSellableCards(
                        countryCode: _sellCountryCode.isEmpty
                            ? null
                            : _sellCountryCode),
                style: ElevatedButton.styleFrom(
                  backgroundColor: InvoiceThemeColors.primaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  elevation: 0,
                ),
                child: Text(
                  filtered ? 'Clear filters' : 'Refresh',
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
}
