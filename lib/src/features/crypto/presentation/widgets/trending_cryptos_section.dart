import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/crypto_entity.dart';

class TrendingCryptosSection extends StatelessWidget {
  final List<Crypto> cryptos;
  final Function(Crypto)? onCryptoTap;

  const TrendingCryptosSection({
    super.key,
    required this.cryptos,
    this.onCryptoTap,
  });

  @override
  Widget build(BuildContext context) {
    if (cryptos.isEmpty) {
      return Container(
        height: 150.h,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2746),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.trending_up,
                color: Colors.white.withOpacity(0.5),
                size: 32.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                'No trending data available',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 160.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Trending',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Top gainers 24h',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];
    return Container(
                  width: 140.w,
                  margin: EdgeInsets.only(right: 12.w),
                  child: _buildTrendingCard(crypto),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingCard(Crypto crypto) {
    final isPositive = crypto.priceChangePercentage24h >= 0;
    
    return GestureDetector(
      onTap: () => onCryptoTap?.call(crypto),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2746),
          borderRadius: BorderRadius.circular(16.r),          boxShadow: [
            BoxShadow(
              color: isPositive 
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: _getCryptoColor(crypto.symbol).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      crypto.symbol.substring(0, 1).toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: _getCryptoColor(crypto.symbol),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 16.sp,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              crypto.symbol.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '\$${crypto.currentPrice.toStringAsFixed(crypto.currentPrice < 1 ? 4 : 2)}',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: isPositive 
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '${isPositive ? '+' : ''}${crypto.priceChangePercentage24h.toStringAsFixed(2)}%',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: isPositive ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCryptoColor(String symbol) {
    // Simple color mapping based on symbol
    final colors = {
      'BTC': Colors.orange,
      'ETH': Colors.blue,
      'ADA': Colors.blue,
      'SOL': Colors.purple,
      'DOGE': Colors.yellow,
      'DOT': Colors.pink,
      'MATIC': Colors.indigo,
      'LINK': Colors.blue,
    };
    
    return colors[symbol.toUpperCase()] ?? Colors.grey;
  }
} 