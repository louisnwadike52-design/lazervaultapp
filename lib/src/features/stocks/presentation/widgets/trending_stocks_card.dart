import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/stock_entity.dart';

class TrendingStocksCard extends StatelessWidget {
  final List<Stock> stocks;
  final Function(Stock) onStockTap;

  const TrendingStocksCard({
    super.key,
    required this.stocks,
    required this.onStockTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Icon(
                  Icons.whatshot,
                  color: const Color(0xFFF59E0B),
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Trending Now',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          if (stocks.isEmpty)
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: const Color(0xFF64748B),
                      size: 40.sp,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'No trending stocks',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF94A3B8),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...stocks.asMap().entries.map((entry) {
              final index = entry.key;
              final stock = entry.value;
              return _buildStockRow(stock, index + 1);
            }),
        ],
      ),
    );
  }

  Widget _buildStockRow(Stock stock, int rank) {
    final isPositive = stock.changePercent >= 0;

    return GestureDetector(
      onTap: () => onStockTap(stock),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFF59E0B).withValues(alpha: 0.3),
                    const Color(0xFFFB923C).withValues(alpha: 0.2),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  rank.toString(),
                  style: GoogleFonts.inter(
                    color: const Color(0xFFF59E0B),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stock.symbol,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    stock.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF64748B),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${stock.currentPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? const Color(0xFF10B981).withValues(alpha: 0.15)
                        : const Color(0xFFEF4444).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                        size: 10.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${stock.changePercent.abs().toStringAsFixed(2)}%',
                        style: GoogleFonts.inter(
                          color: isPositive
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
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
    );
  }
}
