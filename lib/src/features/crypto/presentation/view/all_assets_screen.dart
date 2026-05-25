import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import '../widgets/asset_wallet_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// Controls what happens when an asset is tapped.
enum AssetSelectionMode { browse, buy, sell }

class AllAssetsScreen extends StatefulWidget {
  final AssetSelectionMode mode;

  const AllAssetsScreen({super.key, this.mode = AssetSelectionMode.browse});

  @override
  State<AllAssetsScreen> createState() => _AllAssetsScreenState();
}

class _AllAssetsScreenState extends State<AllAssetsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Gainers', 'Losers'];
  // Symbol of the currently expanded row, or null. We keep a single
  // expansion at a time so the list stays tidy and the user clearly sees
  // which asset's choices they're looking at. Tapping the same row
  // collapses it; tapping a different row swaps the expansion.
  String? _expandedSymbol;

  @override
  void initState() {
    super.initState();
    context.read<CryptoCubit>().loadSupportedAssets();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Crypto> _filteredAssets(List<Crypto> assets) {
    var filtered = assets;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((c) =>
        c.name.toLowerCase().contains(query) ||
        c.symbol.toLowerCase().contains(query)
      ).toList();
    }

    // Apply category filter
    switch (_selectedFilter) {
      case 'Gainers':
        filtered = filtered.where((c) => c.priceChangePercentage24h > 0).toList();
        filtered.sort((a, b) => b.priceChangePercentage24h.compareTo(a.priceChangePercentage24h));
      case 'Losers':
        filtered = filtered.where((c) => c.priceChangePercentage24h < 0).toList();
        filtered.sort((a, b) => a.priceChangePercentage24h.compareTo(b.priceChangePercentage24h));
    }

    return filtered;
  }

  Future<void> _onRefresh() async {
    await context.read<CryptoCubit>().loadSupportedAssets();
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
            SizedBox(height: 12.h),
            _buildFilterTabs(),
            SizedBox(height: 8.h),
            Expanded(
              child: BlocBuilder<CryptoCubit, CryptoState>(
                builder: (context, state) {
                  if (state is CryptosLoaded) {
                    final assets = _filteredAssets(state.supportedAssets);
                    if (assets.isEmpty && state.supportedAssets.isEmpty) {
                      return _buildShimmerLoading();
                    }
                    if (assets.isEmpty) {
                      return _buildEmptySearch();
                    }
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: const Color.fromARGB(255, 78, 3, 208),
                      backgroundColor: const Color(0xFF1F1F1F),
                      child: _buildAssetsList(assets),
                    );
                  }
                  return _buildShimmerLoading();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All Assets',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                BlocBuilder<CryptoCubit, CryptoState>(
                  builder: (context, state) {
                    final count = state is CryptosLoaded ? state.supportedAssets.length : 0;
                    return Text(
                      '$count supported assets',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.inter(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search assets...',
          hintStyle: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.5)),
          prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.5)),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                      _expandedSymbol = null;
                    });
                  },
                  child: Icon(Icons.close, color: Colors.white.withValues(alpha: 0.5), size: 18.sp),
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
        onChanged: (value) => setState(() {
          _searchQuery = value;
          // If the user typed a query that hides the previously
          // expanded asset, collapse it so the dangling chevron+CTAs
          // don't sit detached from any row.
          _expandedSymbol = null;
        }),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          return GestureDetector(
            onTap: () => setState(() {
              _selectedFilter = filter;
              _expandedSymbol = null;
            }),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color.fromARGB(255, 78, 3, 208)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
                border: isSelected
                    ? null
                    : Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Text(
                filter,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAssetsList(List<Crypto> assets) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      itemCount: assets.length,
      itemBuilder: (context, index) => _buildAssetItem(assets[index]),
    );
  }

  Widget _buildAssetItem(Crypto crypto) {
    final change = crypto.priceChangePercentage24h;
    final isPositive = change >= 0;
    // In browse mode, tapping a row expands it inline to reveal two
    // CTAs: "Show wallet" (opens the wallet sheet) and "View details"
    // (navigates to the full asset detail screen). Single-expansion
    // policy: opening another row collapses the previous one. Buy/sell
    // modes bypass the accordion entirely and use the original flow
    // (caller expects an asset to be picked, not browsed).
    final isExpanded = widget.mode == AssetSelectionMode.browse &&
        _expandedSymbol == crypto.symbol;

    // Brand orange used as the accordion accent. Solid pop on the
    // dark sheet without competing with the global purple-primary.
    const accent = Color(0xFFFB923C);
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        // When expanded, tint the entire card a warm orange so the
        // open state reads at a glance. Border picks up the same hue.
        gradient: isExpanded
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  accent.withValues(alpha: 0.18),
                  accent.withValues(alpha: 0.08),
                ],
              )
            : null,
        color: isExpanded ? null : const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: isExpanded ? Border.all(color: accent, width: 1.2) : null,
        boxShadow: isExpanded
            ? [
                BoxShadow(
                  color: accent.withValues(alpha: 0.18),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
          if (widget.mode == AssetSelectionMode.browse) {
            setState(() {
              _expandedSymbol = isExpanded ? null : crypto.symbol;
            });
            return;
          }
          // Buy / sell selection modes go straight to the details
          // route as before (those callers select an asset to act on).
          Get.toNamed(
            AppRoutes.cryptoDetails,
            arguments: crypto,
          );
        },
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
            // Crypto icon
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: crypto.image.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(
                        crypto.image,
                        width: 42.w,
                        height: 42.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildSymbolFallback(crypto.symbol),
                      ),
                    )
                  : _buildSymbolFallback(crypto.symbol),
            ),
            SizedBox(width: 12.w),

            // Name and symbol
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    crypto.name,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          '#${crypto.marketCapRank}',
                          style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        crypto.symbol,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Price and change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${CurrencySymbols.currentSymbol}${_formatPrice(crypto.currentPrice)}',
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: (isPositive ? Colors.green : Colors.red).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive ? Colors.green : Colors.red,
                        size: 10.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${change.abs().toStringAsFixed(2)}%',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.mode == AssetSelectionMode.browse) ...[
                  SizedBox(height: 4.h),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.white.withValues(alpha: 0.5),
                    size: 18.sp,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
            ),
          ),
          // Inline accordion drawer. AnimatedSize keeps the toggle gentle.
          AnimatedSize(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            child: isExpanded
                ? Padding(
                    padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.white.withValues(alpha: 0.06),
                          height: 12.h,
                        ),
                        Row(children: [
                          Expanded(child: _accordionCta(
                            label: 'Show wallet',
                            icon: Icons.account_balance_wallet_outlined,
                            onTap: () => _openWalletSheet(crypto),
                          )),
                          SizedBox(width: 10.w),
                          Expanded(child: _accordionCta(
                            label: 'View details',
                            icon: Icons.bar_chart_rounded,
                            primary: true,
                            onTap: () => _openCryptoDetails(crypto),
                          )),
                        ]),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void _openWalletSheet(Crypto crypto) {
    showAssetWalletSheet(
      context,
      cryptoSymbol: crypto.symbol,
      cryptoName: crypto.name,
      currentPrice: crypto.currentPrice,
      priceChange24hPct: crypto.priceChangePercentage24h,
      imageUrl: crypto.image,
      onViewDetails: () => _openCryptoDetails(crypto),
    );
  }

  void _openCryptoDetails(Crypto crypto) {
    Get.toNamed(AppRoutes.cryptoDetails, arguments: crypto);
  }

  Widget _accordionCta({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool primary = false,
  }) {
    // Orange-tinted CTAs to harmonize with the orange accordion
    // background. Primary action gets solid fill; secondary keeps the
    // softer tint so the two read as a hierarchy.
    const accent = Color(0xFFFB923C);
    final bg = primary ? accent : accent.withValues(alpha: 0.18);
    final fg = primary
        ? Colors.white.withValues(alpha: 0.98)
        : accent;
    final border = primary
        ? null
        : Border.all(color: accent.withValues(alpha: 0.45));
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(10.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: border,
          ),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: fg, size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: fg,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymbolFallback(String symbol) {
    return Center(
      child: Text(
        symbol.length >= 2 ? symbol.substring(0, 2) : symbol,
        style: GoogleFonts.inter(
          color: const Color.fromARGB(255, 78, 3, 208),
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000) return price.toStringAsFixed(0);
    if (price >= 1) return price.toStringAsFixed(2);
    if (price >= 0.01) return price.toStringAsFixed(4);
    return price.toStringAsFixed(6);
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      itemCount: 10,
      itemBuilder: (context, index) => _ShimmerAssetItem(delay: index * 80),
    );
  }

  Widget _buildEmptySearch() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 48.sp, color: Colors.white.withValues(alpha: 0.3)),
          SizedBox(height: 12.h),
          Text(
            'No assets found',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Try a different search term',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer loading placeholder for a single asset row.
class _ShimmerAssetItem extends StatefulWidget {
  final int delay;
  const _ShimmerAssetItem({this.delay = 0});

  @override
  State<_ShimmerAssetItem> createState() => _ShimmerAssetItemState();
}

class _ShimmerAssetItemState extends State<_ShimmerAssetItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final opacity = _animation.value;
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: Colors.grey[850]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[800]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 12.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[800]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 14.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[800]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Container(
                    height: 18.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[800]?.withValues(alpha: opacity) ?? Colors.grey.withValues(alpha: opacity),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
