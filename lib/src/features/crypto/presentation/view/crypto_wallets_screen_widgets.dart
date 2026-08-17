part of 'crypto_wallets_screen.dart';

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
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: wallet.address));
                        Get.snackbar(
                          'Copied',
                          'Deposit address copied to clipboard',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.9),
                          colorText: Colors.white,
                          duration: const Duration(seconds: 2),
                        );
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
