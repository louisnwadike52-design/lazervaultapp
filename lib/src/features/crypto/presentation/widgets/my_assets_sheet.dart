import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../domain/entities/crypto_entity.dart';
import 'asset_wallet_sheet.dart';

const _card = Color(0xFF1F1F1F);
const _bg = Color(0xFF0A0A0A);
const _divider = Color(0xFF2D2D2D);
const _sub = Color(0xFF9CA3AF);
const _accent = Color.fromARGB(255, 78, 3, 208);

/// Bottom sheet listing every asset the user holds. Tapping a row opens the
/// per-asset wallet sheet (balance + networks + deposit address); a trailing
/// chart button (and the wallet sheet's own "View details" CTA) opens the asset
/// detail page. Mirrors the all-assets accordion's wallet/details pattern.
Future<void> showMyAssetsSheet(
  BuildContext context, {
  required List<CryptoHolding> holdings,
  required List<Crypto> assets,
  // Portfolio-level 24h performance, moved here off the landing header so the
  // card stays streamlined. Optional so older callers still work.
  double change24hFiat = 0,
  double change24hPct = 0,
  String bestSymbol = '',
  double bestPct = 0,
  bool has24hData = false,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _MyAssetsSheet(
      holdings: holdings,
      assets: assets,
      change24hFiat: change24hFiat,
      change24hPct: change24hPct,
      bestSymbol: bestSymbol,
      bestPct: bestPct,
      has24hData: has24hData,
    ),
  );
}

class _MyAssetsSheet extends StatelessWidget {
  final List<CryptoHolding> holdings;
  final List<Crypto> assets;
  final double change24hFiat;
  final double change24hPct;
  final String bestSymbol;
  final double bestPct;
  final bool has24hData;

  const _MyAssetsSheet({
    required this.holdings,
    required this.assets,
    required this.change24hFiat,
    required this.change24hPct,
    required this.bestSymbol,
    required this.bestPct,
    required this.has24hData,
  });

  // ── Figure handling (industry standard) ──
  // Keep the exact comma-grouped number until it reaches the MILLIONS, then
  // compact it (₦1.2M / ₦3.4B) so a large fiat value never overflows a tight
  // stat/row. A compacted value is tappable → a modal shows the exact figure.
  static final NumberFormat _fullFmt = NumberFormat('#,##0.00');
  static final NumberFormat _compactFmt = NumberFormat.compact();

  static bool _isBig(double v) => v.abs() >= 1000000;

  String _fullMoney(double v) =>
      '${CurrencySymbols.currentSymbol}${_fullFmt.format(v)}';

  String _money(double v) => _isBig(v)
      ? '${CurrencySymbols.currentSymbol}${_compactFmt.format(v)}'
      : _fullMoney(v);

  /// Modal dialog showing the EXACT full value behind a compacted figure — the
  /// same "tap to see the full amount" idea the landing portfolio value uses.
  void _showFullValue(BuildContext context, String title, double value) {
    showDialog<void>(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: _card,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: GoogleFonts.inter(color: _sub, fontSize: 13.sp)),
              SizedBox(height: 8.h),
              // Selectable so the user can copy the exact figure.
              SelectableText(
                _fullMoney(value),
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close',
                      style: GoogleFonts.inter(
                          color: _accent, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Full market entity for a holding, matched from the already-loaded catalogue
  /// by id then symbol, so the detail page + wallet sheet get image/price. Falls
  /// back to a minimal entity built from the holding when the asset isn't in the
  /// loaded lists.
  Crypto _cryptoFor(CryptoHolding h) {
    for (final c in assets) {
      if (c.id == h.cryptoId ||
          c.symbol.toLowerCase() == h.cryptoSymbol.toLowerCase()) {
        return c;
      }
    }
    return Crypto(
      id: h.cryptoId,
      symbol: h.cryptoSymbol,
      name: h.cryptoName,
      image: '',
      currentPrice: h.currentPrice,
      marketCap: 0,
      marketCapRank: 0,
      totalVolume: 0,
      high24h: 0,
      low24h: 0,
      priceChange24h: 0,
      priceChangePercentage24h: 0,
      circulatingSupply: 0,
      lastUpdated: DateTime.now(),
    );
  }

  void _openWallet(BuildContext context, Crypto c) {
    showAssetWalletSheet(
      context,
      cryptoSymbol: c.symbol,
      cryptoName: c.name,
      currentPrice: c.currentPrice,
      priceChange24hPct: c.priceChangePercentage24h,
      imageUrl: c.image,
      // The wallet sheet pops itself before running this; also close the
      // My assets sheet so the detail page lands on a clean stack.
      onViewDetails: () => _openDetails(context, c),
    );
  }

  void _openDetails(BuildContext context, Crypto c) {
    if (Navigator.canPop(context)) Navigator.pop(context); // close My assets sheet
    Get.toNamed(AppRoutes.cryptoDetails, arguments: c);
  }

  String _qty(double q) {
    if (q >= 1) return q.toStringAsFixed(4);
    if (q >= 0.0001) return q.toStringAsFixed(6);
    return q.toStringAsFixed(8);
  }

  @override
  Widget build(BuildContext context) {
    // Highest-value first so the user's biggest holdings are on top.
    final sorted = [...holdings]
      ..sort((a, b) => b.totalValue.compareTo(a.totalValue));
    final held = sorted.where((h) => h.quantity > 0).toList();
    final h = MediaQuery.of(context).size.height * 0.75;

    return Container(
      height: h,
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: _divider,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
            child: Row(
              children: [
                Icon(Icons.account_balance_wallet_rounded,
                    color: Colors.white, size: 20.sp),
                SizedBox(width: 10.w),
                Text('My assets',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                Text('${held.length}',
                    style: GoogleFonts.inter(color: _sub, fontSize: 14.sp)),
                SizedBox(width: 4.w),
                Text(held.length == 1 ? 'asset' : 'assets',
                    style: GoogleFonts.inter(color: _sub, fontSize: 13.sp)),
              ],
            ),
          ),
          _summary(context),
          Expanded(
            child: held.isEmpty
                ? _empty()
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    itemCount: held.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (_, i) => _row(context, held[i]),
                  ),
          ),
        ],
      ),
    );
  }

  /// Portfolio 24h change + best asset — moved here off the landing header.
  /// Hidden until we have real 24h data (never fabricate a 0%). The fiat change
  /// compacts + is tap-to-expand when it reaches the millions; the percentages
  /// are FittedBox-scaled so an extreme move can't overflow the card.
  Widget _summary(BuildContext context) {
    if (!has24hData) return const SizedBox.shrink();
    const green = Color(0xFF10B981);
    const red = Color(0xFFEF4444);
    final positive = change24hFiat >= 0;
    final changeColor = positive ? green : red;
    final big = _isBig(change24hFiat);
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 8.h),
      child: Row(
        children: [
          Expanded(
            child: _summaryCard(
              label: '24h Change',
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: big
                    ? () => _showFullValue(
                        context, '24h Change', change24hFiat)
                    : null,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                          positive
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          color: changeColor,
                          size: 14.sp),
                      SizedBox(width: 3.w),
                      Text(
                        '${positive ? '+' : '-'}${_money(change24hFiat.abs())}'
                        ' (${change24hPct.abs().toStringAsFixed(2)}%)',
                        maxLines: 1,
                        style: GoogleFonts.inter(
                            color: changeColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _summaryCard(
              label: 'Best Asset',
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  bestSymbol.isNotEmpty
                      ? '${bestSymbol.toUpperCase()} '
                          '${bestPct >= 0 ? '+' : ''}${bestPct.toStringAsFixed(1)}%'
                      : 'None',
                  maxLines: 1,
                  style: GoogleFonts.inter(
                      color: bestSymbol.isEmpty
                          ? Colors.white
                          : (bestPct >= 0 ? green : red),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard({required String label, required Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: GoogleFonts.inter(color: _sub, fontSize: 12.sp)),
          SizedBox(height: 6.h),
          child,
        ],
      ),
    );
  }

  Widget _empty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.savings_outlined, color: _sub, size: 44.sp),
          SizedBox(height: 12.h),
          Text('You don\'t hold any crypto yet',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp)),
          SizedBox(height: 6.h),
          Text('Buy your first asset to see it here',
              style: GoogleFonts.inter(color: _sub, fontSize: 12.sp)),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, CryptoHolding holding) {
    final c = _cryptoFor(holding);
    return Material(
      color: _bg,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: () => _openWallet(context, c),
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: _divider),
          ),
          child: Row(
            children: [
              _avatar(c),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name.isNotEmpty ? c.name : c.symbol.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 2.h),
                    Text(
                      '${_qty(holding.quantity)} ${c.symbol.toUpperCase()}',
                      style: GoogleFonts.inter(color: _sub, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _isBig(holding.totalValue)
                        ? () => _showFullValue(
                            context,
                            c.name.isNotEmpty
                                ? c.name
                                : c.symbol.toUpperCase(),
                            holding.totalValue)
                        : null,
                    child: Text(
                      _money(holding.totalValue),
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  // Real live 24h change for this asset (the backend holdings
                  // carry no cost basis, so a "since purchase" % would be fake).
                  Text(
                    '${c.priceChangePercentage24h >= 0 ? '+' : ''}${c.priceChangePercentage24h.toStringAsFixed(2)}%',
                    style: GoogleFonts.inter(
                      color: c.priceChangePercentage24h >= 0
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 6.w),
              // Jump straight to the asset detail page.
              IconButton(
                onPressed: () => _openDetails(context, c),
                icon: Icon(Icons.bar_chart_rounded, color: _accent, size: 20.sp),
                tooltip: 'View details',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.w),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatar(Crypto c) {
    if (c.image.isNotEmpty) {
      return CircleAvatar(
        radius: 18.r,
        backgroundColor: _divider,
        backgroundImage: NetworkImage(c.image),
      );
    }
    return CircleAvatar(
      radius: 18.r,
      backgroundColor: _accent.withValues(alpha: 0.15),
      child: Text(
        c.symbol.isNotEmpty ? c.symbol.substring(0, 1).toUpperCase() : '?',
        style: GoogleFonts.inter(
            color: _accent, fontSize: 14.sp, fontWeight: FontWeight.w700),
      ),
    );
  }
}
