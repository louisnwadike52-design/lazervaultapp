import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../data/models/crypto_wallet_model.dart';
import '../../domain/entities/crypto_entity.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'crypto_wallets_screen_widgets.dart';


/// Screen showing user's crypto wallets with deposit addresses and balances.
/// Each wallet mirrors a Quidax sub-account wallet.
class CryptoWalletsScreen extends StatefulWidget {
  const CryptoWalletsScreen({super.key});

  @override
  State<CryptoWalletsScreen> createState() => _CryptoWalletsScreenState();
}

class _CryptoWalletsScreenState extends State<CryptoWalletsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fresh live balances on mount — the wallet list is derived from holdings
    // (see _walletsOf), so a stale mirror must not show outdated amounts.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<CryptoCubit>().refreshHoldingsLive();
    });
  }

  /// The wallet list for this screen. `state.wallets` was NEVER populated by
  /// the cubit (no fetch ever wrote it), so the screen permanently showed
  /// "No crypto wallets" even for funded users. Derive the list from the LIVE
  /// holdings instead (Quidax-truth balances the landing page already loads);
  /// deposit addresses resolve on demand in the wallet detail / receive flow.
  List<CryptoWalletModel> _walletsOf(CryptosLoaded state) {
    if (state.wallets.isNotEmpty) return state.wallets;
    return state.holdings
        .where((h) => h.quantity > 0)
        .map((h) => CryptoWalletModel(
              id: h.id,
              cryptoId: h.cryptoId,
              cryptoSymbol: h.cryptoSymbol,
              address: '',
              balance: h.quantity,
              walletType: 'trading',
              chain: '',
              cryptoName: h.cryptoName,
            ))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CryptoWalletModel> _filteredWallets(List<CryptoWalletModel> wallets) {
    if (_searchQuery.isEmpty) return wallets;
    final query = _searchQuery.toLowerCase();
    return wallets
        .where((w) =>
            w.cryptoName.toLowerCase().contains(query) ||
            w.cryptoSymbol.toLowerCase().contains(query))
        .toList();
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
                    return const Center(child: LazerVaultLoader.small());
                  }

                  final wallets = _filteredWallets(_walletsOf(state));

                  if (wallets.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    itemCount: wallets.length,
                    itemBuilder: (context, index) => _buildWalletItem(wallets[index], state),
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
                  'Your Crypto Wallets',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Deposit addresses and balances',
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
          hintText: 'Search wallets...',
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet_outlined, size: 64.sp, color: Colors.grey[600]),
            SizedBox(height: 16.h),
            Text(
              _searchQuery.isNotEmpty ? 'No matching wallets' : 'No crypto wallets',
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
                  : 'Your crypto wallets will appear here after your first purchase.',
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

  Widget _buildWalletItem(CryptoWalletModel wallet, CryptosLoaded state) {
    final crypto = state.cryptos.firstWhere(
          (c) => c.symbol.toLowerCase() == wallet.cryptoSymbol.toLowerCase(),
          orElse: () => state.supportedAssets.firstWhere(
                (c) => c.symbol.toLowerCase() == wallet.cryptoSymbol.toLowerCase(),
                orElse: () => state.cryptos.first,
              ),
        );
    final currentPrice = crypto?.currentPrice ?? 0.0;
    final fiatValue = wallet.balance * currentPrice;

    return GestureDetector(
      onTap: () => Get.to(
        () => BlocProvider.value(
          value: context.read<CryptoCubit>(),
          child: CryptoWalletDetailScreen(wallet: wallet, crypto: crypto),
        ),
        transition: Transition.rightToLeft,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 46.w,
              height: 46.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: crypto?.image != null && crypto!.image.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(
                          crypto.image,
                          width: 30.w,
                          height: 30.w,
                          errorBuilder: (context, error, stackTrace) => Container(),
                        ),
                      )
                    : Text(
                        wallet.cryptoSymbol.length >= 2
                            ? wallet.cryptoSymbol.substring(0, 2).toUpperCase()
                            : wallet.cryptoSymbol.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            SizedBox(width: 14.w),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wallet.cryptoName,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        wallet.formattedBalance,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      if (wallet.chain.isNotEmpty) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D2D),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            wallet.chain,
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${CurrencySymbols.currentSymbol}${fiatValue.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),

            // Chevron
            Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.4), size: 20.sp),
          ],
        ),
      ),
    );
  }
}
