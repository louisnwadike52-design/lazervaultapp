import 'package:flutter/material.dart';
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
                    return const Center(child: CircularProgressIndicator());
                  }

                  final wallets = _filteredWallets(state.wallets);

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

/// Detail screen for a single crypto wallet showing deposit address, QR code, etc.
class CryptoWalletDetailScreen extends StatelessWidget {
  final CryptoWalletModel wallet;
  final Crypto? crypto;

  const CryptoWalletDetailScreen({
    super.key,
    required this.wallet,
    this.crypto,
  });

  @override
  Widget build(BuildContext context) {
    final currentPrice = crypto?.currentPrice ?? 0.0;
    final fiatValue = wallet.balance * currentPrice;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
        ),
        title: Text(
          wallet.cryptoName,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            _buildBalanceCard(fiatValue),
            SizedBox(height: 24.h),

            // Deposit Address Section
            _buildDepositAddressSection(),
            SizedBox(height: 24.h),

            // Wallet Info
            _buildWalletInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(double fiatValue) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF4E03D0), const Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            wallet.formattedBalance,
            style: GoogleFonts.inter(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            wallet.cryptoSymbol.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Text(
                '≈ ${CurrencySymbols.currentSymbol}${fiatValue.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDepositAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deposit Address',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
          ),
          child: Column(
            children: [
              // QR Code
              if (wallet.address.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: QrImageView(
                    data: wallet.address,
                    version: QrVersions.auto,
                    size: 180.w,
                  ),
                ),
              SizedBox(height: 20.h),

              // Address Text
              Text(
                'Wallet Address',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      wallet.address.isNotEmpty
                          ? _formatAddress(wallet.address)
                          : 'No address available',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (wallet.address.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        // Copy address
                        // TODO: Implement copy to clipboard
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        child: Icon(Icons.copy, color: const Color(0xFF4E03D0), size: 18.sp),
                      ),
                    ),
                ],
              ),
              if (wallet.chain.isNotEmpty) ...[
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(Icons.link, color: Colors.white.withValues(alpha: 0.5), size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Network: ${wallet.chain}',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWalletInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wallet Information',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
          ),
          child: Column(
            children: [
              _buildInfoRow('Wallet Type', wallet.walletType),
              SizedBox(height: 12.h),
              _buildInfoRow('Asset', wallet.cryptoName),
              SizedBox(height: 12.h),
              _buildInfoRow('Symbol', wallet.cryptoSymbol.toUpperCase()),
              if (wallet.chain.isNotEmpty) ...[
                SizedBox(height: 12.h),
                _buildInfoRow('Chain', wallet.chain),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _formatAddress(String address) {
    if (address.length <= 20) return address;
    return '${address.substring(0, 10)}...${address.substring(address.length - 8)}';
  }
}
