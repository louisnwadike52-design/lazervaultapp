import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';
import '../../domain/entities/stock_entity.dart';

class PortfolioSummaryCard extends StatelessWidget {
  final Portfolio? portfolio;
  final VoidCallback onTap;
  final Color? accentColor;

  const PortfolioSummaryCard({
    super.key,
    required this.portfolio,
    required this.onTap,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? InvestTradingUi.accent;
    final hasPortfolio = portfolio != null;
    final totalValue = hasPortfolio ? portfolio!.totalValue : 0.0;
    final dayChange = hasPortfolio ? portfolio!.dayChange : 0.0;
    final dayChangePercent = hasPortfolio ? portfolio!.dayChangePercent : 0.0;
    final isPositive = dayChange >= 0;
    final move = isPositive ? InvestTradingUi.buy : InvestTradingUi.sell;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: InvestTradingUi.surfaceElevated,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        accent,
                        accent.withValues(alpha: 0.45),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Portfolio value',
                          style: GoogleFonts.inter(
                            color: InvestTradingUi.textSecondary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: InvestTradingUi.textSecondary,
                          size: 22.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      CurrencySymbols.formatAmountWithCurrency(totalValue, 'USD'),
                      style: GoogleFonts.inter(
                        color: InvestTradingUi.textPrimary,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.6,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: move.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: move.withValues(alpha: 0.35)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPositive
                                    ? Icons.trending_up_rounded
                                    : Icons.trending_down_rounded,
                                color: move,
                                size: 14.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                CurrencySymbols.formatAmountWithCurrency(
                                    dayChange.abs(), 'USD'),
                                style: GoogleFonts.inter(
                                  color: move,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${isPositive ? '+' : ''}${dayChangePercent.toStringAsFixed(2)}%',
                          style: GoogleFonts.inter(
                            color: move,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Today',
                          style: GoogleFonts.inter(
                            color: InvestTradingUi.textSecondary,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    if (hasPortfolio && portfolio!.holdings.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      Divider(color: InvestTradingUi.border, height: 1),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStat('Holdings', portfolio!.holdings.length.toString()),
                          _buildStat(
                              'Cash',
                              CurrencySymbols.formatAmountWithCurrency(
                                  portfolio!.availableCash, 'USD')),
                          _buildStat(
                              'Invested',
                              CurrencySymbols.formatAmountWithCurrency(
                                  totalValue - portfolio!.availableCash, 'USD')),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: InvestTradingUi.textSecondary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: InvestTradingUi.textPrimary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
