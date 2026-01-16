import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../view/portfolio_rebalance_carousel.dart';

/// Step 2: View proposed rebalancing trades
class RebalanceStrategyScreen extends StatelessWidget {
  final String method;
  final List<RebalanceTrade> proposedTrades;
  final Function(String) onMethodChanged;

  const RebalanceStrategyScreen({
    super.key,
    required this.method,
    required this.proposedTrades,
    required this.onMethodChanged,
  });

  double get _totalBuyValue {
    return proposedTrades
        .where((trade) => trade.action == 'Buy')
        .fold(0.0, (sum, trade) => sum + trade.estimatedTotal);
  }

  double get _totalSellValue {
    return proposedTrades
        .where((trade) => trade.action == 'Sell')
        .fold(0.0, (sum, trade) => sum + trade.estimatedTotal);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Proposed Rebalancing Trades',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Review the trades needed to rebalance your portfolio',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 24.h),

          // Summary card
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.3),
                  const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFF6366F1).withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.swap_horiz,
                  size: 48.sp,
                  color: const Color(0xFF6366F1),
                ),
                SizedBox(height: 16.h),
                Text(
                  '${proposedTrades.length} Trades',
                  style: GoogleFonts.inter(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Required to rebalance',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Buy/Sell summary
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.add_circle, color: Colors.green, size: 32.sp),
                      SizedBox(height: 8.h),
                      Text(
                        'Total Buys',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '\$${_totalBuyValue.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.remove_circle, color: Colors.red, size: 32.sp),
                      SizedBox(height: 8.h),
                      Text(
                        'Total Sells',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '\$${_totalSellValue.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Individual trades
          Text(
            'Trade Details',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          ...proposedTrades.map((trade) {
            final isBuy = trade.action == 'Buy';
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2A2A3E).withValues(alpha: 0.6),
                    const Color(0xFF1F1F35).withValues(alpha: 0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: isBuy
                      ? Colors.green.withValues(alpha: 0.3)
                      : Colors.red.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: isBuy
                                  ? Colors.green.withValues(alpha: 0.2)
                                  : Colors.red.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              isBuy ? Icons.add_circle_outline : Icons.remove_circle_outline,
                              color: isBuy ? Colors.green : Colors.red,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trade.symbol,
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${trade.action} ${trade.sharesToTrade} shares',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${trade.estimatedTotal.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: isBuy ? Colors.green : Colors.red,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '@\$${trade.estimatedPrice.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Divider(
                    color: Colors.white.withValues(alpha: 0.1),
                    height: 1,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Current: ${trade.currentShares} shares',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.grey[600],
                        size: 16.sp,
                      ),
                      Text(
                        'Target: ${trade.targetShares} shares',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFF6366F1),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: 24.h),

          // Info box
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.blue.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Important Information',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'All trades will be executed as market orders. Prices shown are estimates based on current market values. Actual execution prices may vary.',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 80.h),
        ],
      ),
    );
  }
}
