import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import 'sell_crypto_sheet.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Shows the user's crypto holdings filtered to Quidax-supported assets.
/// Tapping a holding navigates to CryptoDetailScreen in sell-only mode.
class UserHoldingsScreen extends StatefulWidget {
  const UserHoldingsScreen({super.key});

  @override
  State<UserHoldingsScreen> createState() => _UserHoldingsScreenState();
}

class _UserHoldingsScreenState extends State<UserHoldingsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  // Owned assets always float to the top; the chips further filter by 24h market
  // move (mirrors the all-assets page's All / Gainers / Losers).
  String _selectedFilter = 'All';
  static const _filters = ['All', 'Gainers', 'Losers'];
  // Last successful holdings snapshot. Kept so the list stays on screen while
  // the shared CryptoCubit is transiently in a NON-CryptosLoaded state — which
  // it is for the entire sell flow (SwapQuotePending → SwapPending/Completed).
  // Without this cache the screen collapsed to a bare centered loader the moment
  // a sell started, and that loader showed through underneath the receipt →
  // the "blank screen with loader after PIN" report. We only fall back to the
  // spinner on the very first load, before any holdings have ever arrived.
  CryptosLoaded? _lastLoaded;

  @override
  void initState() {
    super.initState();
    // Quidax-as-source-of-truth: refresh holdings on every mount via
    // the backend's Quidax-live overlay, so external deposits to the
    // user's Quidax sub-account surface in the picker immediately.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // ignore: use_build_context_synchronously
      context.read<CryptoCubit>().refreshHoldingsLive();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CryptoHolding> _filteredHoldings(
    CryptosLoaded state,
    List<CryptoHolding> holdings,
    Set<String> supportedSymbols,
  ) {
    var filtered = holdings;

    // Filter to Quidax-supported only
    if (supportedSymbols.isNotEmpty) {
      filtered = filtered
          .where((h) => supportedSymbols.contains(h.cryptoSymbol.toLowerCase()))
          .toList();
    }

    // Apply search
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered
          .where((h) =>
              h.cryptoName.toLowerCase().contains(query) ||
              h.cryptoSymbol.toLowerCase().contains(query))
          .toList();
    }

    // 24h market change per holding (via the resolved market Crypto) — powers
    // the Gainers/Losers chips, same signal the all-assets page uses.
    double change24h(CryptoHolding h) =>
        _resolveCrypto(h, state)?.priceChangePercentage24h ?? 0.0;

    switch (_selectedFilter) {
      case 'Gainers':
        filtered = filtered.where((h) => change24h(h) > 0).toList()
          ..sort((a, b) => change24h(b).compareTo(change24h(a)));
        break;
      case 'Losers':
        filtered = filtered.where((h) => change24h(h) < 0).toList()
          ..sort((a, b) => change24h(a).compareTo(change24h(b)));
        break;
      default:
        // All: owned (quantity > 0) assets first, then zero-balance rows, each
        // group keeping its original (market-cap) order — a stable partition.
        final owned = filtered.where((h) => h.quantity > 0).toList();
        final rest = filtered.where((h) => h.quantity <= 0).toList();
        filtered = [...owned, ...rest];
    }

    return filtered;
  }

  /// All / Gainers / Losers chips — same style + behaviour as the all-assets
  /// page, so the two listings feel consistent.
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
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Crypto? _resolveCrypto(CryptoHolding holding, CryptosLoaded state) {
    return state.cryptos.cast<Crypto?>().firstWhere(
          (c) =>
              c?.id == holding.cryptoId ||
              c?.symbol.toLowerCase() == holding.cryptoSymbol.toLowerCase(),
          orElse: () => state.supportedAssets.cast<Crypto?>().firstWhere(
                (c) =>
                    c?.symbol.toLowerCase() ==
                    holding.cryptoSymbol.toLowerCase(),
                orElse: () => null,
              ),
        );
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
            SizedBox(height: 12.h),
            Expanded(
              child: BlocBuilder<CryptoCubit, CryptoState>(
                builder: (context, rawState) {
                  // Cache the freshest holdings snapshot; render from it while a
                  // sell (or any other flow) has driven the shared cubit into a
                  // transient non-CryptosLoaded state, so the picker never blinks
                  // to a bare loader mid-trade.
                  if (rawState is CryptosLoaded) _lastLoaded = rawState;
                  final state = _lastLoaded;
                  if (state == null) {
                    return const Center(child: LazerVaultLoader.small());
                  }

                  final supportedSymbols = state.supportedAssets
                      .map((a) => a.symbol.toLowerCase())
                      .toSet();
                  final holdings =
                      _filteredHoldings(state, state.holdings, supportedSymbols);

                  if (holdings.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    itemCount: holdings.length,
                    itemBuilder: (context, index) =>
                        _buildHoldingItem(holdings[index], state),
                  );
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
                  'Your Holdings',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Select an asset to sell',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
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
          hintText: 'Search holdings...',
          hintStyle:
              GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.5)),
          prefixIcon:
              Icon(Icons.search, color: Colors.white.withValues(alpha: 0.5)),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                  child: Icon(Icons.close,
                      color: Colors.white.withValues(alpha: 0.5), size: 18.sp),
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_outlined,
                size: 64.sp, color: Colors.grey[600]),
            SizedBox(height: 16.h),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No matching holdings'
                  : 'No sellable holdings',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Try a different search term'
                  : 'You don\'t have any supported crypto holdings to sell yet.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoldingItem(CryptoHolding holding, CryptosLoaded state) {
    final pnlColor =
        holding.totalGainLossPercentage >= 0 ? Colors.green : Colors.red;
    final hasBalance = holding.quantity > 0;

    return GestureDetector(
      onTap: () {
        if (!hasBalance) {
          // Zero balance — Sell stays locked until they hold something.
          Get.snackbar(
            'No ${holding.cryptoSymbol.toUpperCase()} balance',
            'Buy or receive ${holding.cryptoSymbol.toUpperCase()} first; the Sell action unlocks once you have a balance.',
            backgroundColor: const Color(0xFF1F1F1F),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          );
          return;
        }
        // Streamlined: go straight to the pre-selected Sell sheet (amount →
        // live quote → PIN → outcome). The crypto is resolved from the loaded
        // market list, falling back to a minimal entry synthesized from the
        // holding so a not-yet-loaded list never strands the tap.
        final crypto =
            _resolveCrypto(holding, state) ?? Crypto.fromHolding(holding);
        showSellCryptoSheet(
          context,
          crypto: crypto,
          holding: holding,
          cubit: context.read<CryptoCubit>(),
        );
      },
      child: Opacity(
        opacity: hasBalance ? 1.0 : 0.55,
        child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  holding.cryptoSymbol.length >= 2
                      ? holding.cryptoSymbol.substring(0, 2).toUpperCase()
                      : holding.cryptoSymbol.toUpperCase(),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Name + quantity
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holding.cryptoName,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${holding.quantity.toStringAsFixed(6)} ${holding.cryptoSymbol.toUpperCase()}',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),

            // Value + P&L. While the lazy fiat fetch is in-flight, render
            // a thin skeleton bar in place of "₦0.00" so users don't
            // misread a missing rate as a zero balance.
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (holding.priceLoading)
                  Container(
                    width: 64.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  )
                else
                  Text(
                    '${CurrencySymbols.currentSymbol}${holding.totalValue.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                SizedBox(height: 2.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: pnlColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        holding.totalGainLossPercentage >= 0
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: pnlColor,
                        size: 10.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${holding.totalGainLossPercentage.abs().toStringAsFixed(2)}%',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: pnlColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(width: 8.w),
            Icon(Icons.chevron_right,
                color: Colors.white.withValues(alpha: 0.4), size: 20.sp),
          ],
        ),
        ),
      ),
    );
  }
}
