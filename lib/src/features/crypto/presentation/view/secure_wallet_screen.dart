import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'crypto_wallets_screen.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

// Secure Wallet — opens from the LazerVault Services row on the crypto
// landing page. Educational on the security model (licensed custody,
// segregated sub-accounts, no key management), grounded with the
// user's real Quidax wallet inventory at the top so the message reads
// concrete instead of marketing-speak.
class SecureWalletScreen extends StatelessWidget {
  const SecureWalletScreen({super.key});

  static const _accent = Color.fromARGB(255, 78, 3, 208);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInventoryCard(context),
                    SizedBox(height: 20.h),
                    _buildHero(),
                    SizedBox(height: 28.h),
                    _buildSecurityFeature(
                      Icons.shield_rounded,
                      'Licensed custody',
                      'Your crypto assets are held by our SEC-licensed partner Quidax, a regulated digital-asset exchange.',
                    ),
                    SizedBox(height: 12.h),
                    _buildSecurityFeature(
                      Icons.key_off_rounded,
                      'No key management',
                      'LazerVault handles the complexity. No seed phrases or private keys to lose.',
                    ),
                    SizedBox(height: 12.h),
                    _buildSecurityFeature(
                      Icons.account_balance_rounded,
                      'Segregated sub-accounts',
                      'Each user gets a dedicated Quidax sub-account so funds are never co-mingled.',
                    ),
                    SizedBox(height: 12.h),
                    _buildSecurityFeature(
                      Icons.pin_rounded,
                      'PIN-gated transactions',
                      'Every buy, sell, swap and withdrawal requires your transaction PIN.',
                    ),
                    SizedBox(height: 12.h),
                    _buildSecurityFeature(
                      Icons.sync_lock_rounded,
                      'Fund holds + verification',
                      'External transactions use multi-step fund holds and provider reconciliation to prevent loss.',
                    ),
                  ],
                ),
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
              child: Icon(Icons.arrow_back,
                  color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Asset security',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Pulls live data straight from CryptoCubit so the user sees how
  // many wallets are actually custodied, and the highest-value ones.
  // No mocks — this is the same source the landing page reads.
  Widget _buildInventoryCard(BuildContext context) {
    return BlocBuilder<CryptoCubit, CryptoState>(
      builder: (context, state) {
        if (state is! CryptosLoaded) {
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _accent.withValues(alpha: 0.18),
                  _accent.withValues(alpha: 0.06),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: _accent.withValues(alpha: 0.30)),
            ),
            child: Row(
              children: [
                LazerVaultLoader(size: 18),
                SizedBox(width: 12.w),
                Text(
                  'Loading your secured wallets…',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          );
        }

        final wallets = state.wallets;
        final holdings = state.holdings;
        // Sum custodied value across all holdings — same number shown
        // on the landing-page portfolio overview, so the user sees
        // consistent figures across screens.
        final totalValue =
            holdings.fold<double>(0, (sum, h) => sum + h.totalValue);
        // Map holdings by cryptoId so we can join them with wallets
        // and surface the top 3 by fiat value as a concrete preview.
        final byId = {for (final h in holdings) h.cryptoId: h};
        final topWallets = wallets.toList()
          ..sort((a, b) {
            final av = byId[a.cryptoId]?.totalValue ?? 0;
            final bv = byId[b.cryptoId]?.totalValue ?? 0;
            return bv.compareTo(av);
          });
        final preview = topWallets.take(3).toList();
        final sym = CurrencySymbols.currentSymbol;

        return GestureDetector(
          onTap: () => Get.to(() => const CryptoWalletsScreen()),
          child: Container(
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _accent.withValues(alpha: 0.22),
                  _accent.withValues(alpha: 0.06),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: _accent.withValues(alpha: 0.35)),
              boxShadow: [
                BoxShadow(
                  color: _accent.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [_accent, _accent.withValues(alpha: 0.6)],
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(Icons.verified_user_rounded,
                          color: Colors.white, size: 18.sp),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your secured wallets',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${wallets.length} '
                            '${wallets.length == 1 ? 'wallet' : 'wallets'} '
                            'custodied by Quidax',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.65),
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 22.sp),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Expanded(
                      child: _inventoryStat(
                        label: 'Wallets',
                        value: '${wallets.length}',
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      flex: 2,
                      child: _inventoryStat(
                        label: 'Total value',
                        value: '$sym${totalValue.toStringAsFixed(2)}',
                      ),
                    ),
                  ],
                ),
                if (preview.isNotEmpty) ...[
                  SizedBox(height: 14.h),
                  Text(
                    'TOP HOLDINGS',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ...preview.map((w) {
                    final h = byId[w.cryptoId];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Row(
                        children: [
                          Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Center(
                              child: Text(
                                w.cryptoSymbol.toUpperCase().substring(
                                    0,
                                    w.cryptoSymbol.length >= 2 ? 2 : 1),
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              w.cryptoName.isEmpty
                                  ? w.cryptoSymbol.toUpperCase()
                                  : w.cryptoName,
                              style: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (h != null)
                            Text(
                              '$sym${h.totalValue.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _inventoryStat({required String label, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.55),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 88.w,
            height: 88.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _accent.withValues(alpha: 0.30),
                  _accent.withValues(alpha: 0.10),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.verified_user_rounded,
                color: _accent, size: 42.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            'Custodied, not lost',
            style: GoogleFonts.inter(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              'LazerVault partners with regulated providers so your '
              'crypto stays segregated, recoverable and audit-trailed.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Colors.white.withValues(alpha: 0.65),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityFeature(
      IconData icon, String title, String description) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(9.w),
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: _accent, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
