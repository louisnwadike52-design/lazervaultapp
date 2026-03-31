import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';
import '../../../../../core/services/injection_container.dart';
import 'crypto_detail_screen.dart';

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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CryptoHolding> _filteredHoldings(
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

    return filtered;
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
            Expanded(
              child: BlocBuilder<CryptoCubit, CryptoState>(
                builder: (context, state) {
                  if (state is! CryptosLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final supportedSymbols = state.supportedAssets
                      .map((a) => a.symbol.toLowerCase())
                      .toSet();
                  final holdings =
                      _filteredHoldings(state.holdings, supportedSymbols);

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

    return GestureDetector(
      onTap: () {
        final crypto = _resolveCrypto(holding, state);
        if (crypto != null) {
          Get.to(
            () => BlocProvider(
              create: (_) => serviceLocator<CryptoCubit>(),
              child: CryptoDetailScreen(
                crypto: crypto,
                entryMode: CryptoDetailEntryMode.sellOnly,
              ),
            ),
            transition: Transition.rightToLeft,
          );
        }
      },
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

            // Value + P&L
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
    );
  }
}
