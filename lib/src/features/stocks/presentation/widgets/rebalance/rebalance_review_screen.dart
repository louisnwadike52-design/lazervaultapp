import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

import '../../view/portfolio_rebalance_carousel.dart';

/// Step 3: Final review before executing rebalance
class RebalanceReviewScreen extends StatelessWidget {
  final List<RebalanceTrade> trades;
  final String strategy;
  final double totalValue;

  const RebalanceReviewScreen({
    super.key,
    required this.trades,
    required this.strategy,
    required this.totalValue,
  });

  double get _estimatedFees {
    // $0.01 per share commission
    final totalShares = trades.fold(0, (sum, trade) => sum + trade.sharesToTrade);
    return totalShares * 0.01;
  }

  double get _totalBuyValue {
    return trades
        .where((trade) => trade.action == 'Buy')
        .fold(0.0, (sum, trade) => sum + trade.estimatedTotal);
  }

  double get _totalSellValue {
    return trades
        .where((trade) => trade.action == 'Sell')
        .fold(0.0, (sum, trade) => sum + trade.estimatedTotal);
  }

  double get _netCashFlow => _totalSellValue - _totalBuyValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.3),
                  const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFF6366F1).withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.auto_fix_high,
                  size: 48.sp,
                  color: const Color(0xFF6366F1),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Rebalancing Summary',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  strategy,
                  style: GoogleFonts.inter(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Rebalance details
          Text(
            'Rebalance Details',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          _buildDetailCard([
            _buildDetailRow('Strategy', strategy),
            _buildDivider(),
            _buildDetailRow('Total Trades', '${trades.length}'),
            _buildDivider(),
            _buildDetailRow('Portfolio Value', CurrencySymbols.formatAmountWithCurrency(totalValue, 'USD')),
            _buildDivider(),
            _buildDetailRow('Estimated Fees', CurrencySymbols.formatAmountWithCurrency(_estimatedFees, 'USD'),
                valueColor: Colors.orange),
          ]),

          SizedBox(height: 24.h),

          // Cash flow summary
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _netCashFlow >= 0
                    ? [
                        Colors.green.withValues(alpha: 0.3),
                        Colors.green.shade700.withValues(alpha: 0.3),
                      ]
                    : [
                        Colors.red.withValues(alpha: 0.3),
                        Colors.red.shade700.withValues(alpha: 0.3),
                      ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: _netCashFlow >= 0
                    ? Colors.green.withValues(alpha: 0.5)
                    : Colors.red.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Net Cash Flow',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${_netCashFlow >= 0 ? '+' : ''}${CurrencySymbols.formatAmountWithCurrency(_netCashFlow.abs(), 'USD')}',
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _netCashFlow >= 0 ? 'Added to cash' : 'Used from cash',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: _netCashFlow >= 0
                        ? Colors.green
                        : Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _netCashFlow >= 0 ? Icons.add : Icons.remove,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Trade breakdown
          Text(
            'Trade Breakdown',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          ...trades.map((trade) {
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
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: isBuy ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${trade.action} ${trade.symbol}',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${trade.sharesToTrade} shares @ ${CurrencySymbols.formatAmountWithCurrency(trade.estimatedPrice, 'USD')}',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    '${isBuy ? '-' : '+'}${CurrencySymbols.formatAmountWithCurrency(trade.estimatedTotal, 'USD')}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: isBuy ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: 24.h),

          // Important info
          _buildInfoBox(
            Icons.info_outline,
            'Important Information',
            'All trades will be executed as market orders at the best available price. The portfolio will be rebalanced according to your target allocations.',
            Colors.orange,
          ),

          SizedBox(height: 16.h),

          // Terms
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'By rebalancing, you agree to execute all trades shown above and acknowledge market price fluctuations.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[400],
                    ),
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

  Widget _buildDetailCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.w),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? labelColor,
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: labelColor ?? Colors.grey[400],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Divider(
        color: Colors.white.withValues(alpha: 0.1),
        height: 1,
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String title, String message, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  message,
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
    );
  }
}
