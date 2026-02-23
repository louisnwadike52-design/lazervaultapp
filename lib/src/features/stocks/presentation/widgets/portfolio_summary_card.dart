import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../domain/entities/stock_entity.dart';

class PortfolioSummaryCard extends StatelessWidget {
  final Portfolio? portfolio;
  final VoidCallback onTap;

  const PortfolioSummaryCard({
    super.key,
    required this.portfolio,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasPortfolio = portfolio != null;
    final totalValue = hasPortfolio ? portfolio!.totalValue : 0.0;
    final dayChange = hasPortfolio ? portfolio!.dayChange : 0.0;
    final dayChangePercent = hasPortfolio ? portfolio!.dayChangePercent : 0.0;
    final isPositive = dayChange >= 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E40AF).withValues(alpha: 0.3),
              const Color(0xFF7C3AED).withValues(alpha: 0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Portfolio Value',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF94A3B8),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF94A3B8),
                  size: 16.sp,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              CurrencySymbols.formatAmountWithCurrency(totalValue, 'USD'),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? const Color(0xFF10B981).withValues(alpha: 0.2)
                        : const Color(0xFFEF4444).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        color: isPositive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        CurrencySymbols.formatAmountWithCurrency(dayChange.abs(), 'USD'),
                        style: GoogleFonts.inter(
                          color: isPositive
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${isPositive ? '+' : ''}${dayChangePercent.toStringAsFixed(2)}%',
                  style: GoogleFonts.inter(
                    color: isPositive
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  'Today',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF64748B),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (hasPortfolio && portfolio!.holdings.isNotEmpty) ...[
              SizedBox(height: 16.h),
              Divider(
                color: Colors.white.withValues(alpha: 0.1),
                height: 1,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStat('Holdings', portfolio!.holdings.length.toString()),
                  _buildStat('Cash', CurrencySymbols.formatAmountWithCurrency(portfolio!.availableCash, 'USD')),
                  _buildStat('Invested', CurrencySymbols.formatAmountWithCurrency(totalValue - portfolio!.availableCash, 'USD')),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF64748B),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
