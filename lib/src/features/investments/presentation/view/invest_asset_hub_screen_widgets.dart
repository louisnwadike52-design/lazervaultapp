part of 'invest_asset_hub_screen.dart';

class _InstrumentTile extends StatelessWidget {
  const _InstrumentTile({
    required this.stock,
    required this.accent,
    required this.onTap,
  });

  final Stock stock;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final symbol = stock.symbol;
    final name = stock.name;
    final price = stock.currentPrice;
    final change = stock.changePercent;
    final currency = stock.currency.isNotEmpty ? stock.currency : 'USD';
    final isPositive = change >= 0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: InvestTradingUi.cardDecoration(
            color: const Color(0xFF1C1C1E),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: accent.withValues(alpha: 0.35)),
                ),
                child: Center(
                  child: Text(
                    symbol
                        .substring(0, math.min(3, symbol.length))
                        .toUpperCase(),
                    style: GoogleFonts.inter(
                      color: accent,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
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
                      symbol.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: InvestTradingUi.textPrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: InvestTradingUi.labelMuted(),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencySymbols.formatAmountWithCurrency(
                      price.toDouble(),
                      currency,
                    ),
                    style: GoogleFonts.inter(
                      color: InvestTradingUi.textPrimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${isPositive ? '+' : ''}${change.toStringAsFixed(2)}%',
                    style: GoogleFonts.inter(
                      color: isPositive ? InvestTradingUi.buy : InvestTradingUi.sell,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
