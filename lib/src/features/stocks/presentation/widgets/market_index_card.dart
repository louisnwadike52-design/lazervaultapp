import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';

class MarketIndexCard extends StatelessWidget {
  final String name;
  final String value;
  final String change;
  final bool isPositive;
  final Color? accentColor;

  const MarketIndexCard({
    super.key,
    required this.name,
    required this.value,
    required this.change,
    required this.isPositive,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? InvestTradingUi.accent;
    final move = isPositive ? InvestTradingUi.buy : InvestTradingUi.sell;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: InvestTradingUi.cardDecoration(
        color: InvestTradingUi.surfaceElevated,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.inter(
                    color: InvestTradingUi.textSecondary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            value,
            style: GoogleFonts.inter(
              color: InvestTradingUi.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                color: move,
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                change,
                style: GoogleFonts.inter(
                  color: move,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
