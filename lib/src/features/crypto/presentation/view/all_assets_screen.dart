import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
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
                    setState(() => _searchQuery = '');
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
        onChanged: (value) => setState(() => _searchQuery = value),
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
            onTap: () => setState(() => _selectedFilter = filter),
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Use Get.toNamed with the registered route for consistency
          Get.toNamed(
            AppRoutes.cryptoDetails,
            arguments: crypto,
          );
        },
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
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
              ],
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
