import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';

import '../../../domain/entities/stock_entity.dart';

/// Step 1: Buy/sell + order type (Revolut / eToro style, hub accent for order types).
class TradeActionSelectorScreen extends StatefulWidget {
  final Stock stock;
  final OrderSide initialSide;
  final OrderType initialType;
  final Color? accentColor;
  final Function(OrderSide, OrderType) onChanged;

  const TradeActionSelectorScreen({
    super.key,
    required this.stock,
    required this.initialSide,
    required this.initialType,
    this.accentColor,
    required this.onChanged,
  });

  @override
  State<TradeActionSelectorScreen> createState() =>
      _TradeActionSelectorScreenState();
}

class _TradeActionSelectorScreenState extends State<TradeActionSelectorScreen> {
  late OrderSide _selectedSide;
  late OrderType _selectedType;

  Color get _accent => widget.accentColor ?? InvestTradingUi.accent;

  @override
  void initState() {
    super.initState();
    _selectedSide = widget.initialSide;
    _selectedType = widget.initialType;
  }

  void _updateSelection() {
    widget.onChanged(_selectedSide, _selectedType);
  }

  @override
  Widget build(BuildContext context) {
    final up = InvestTradingUi.buy;
    final down = InvestTradingUi.sell;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: InvestTradingUi.cardDecoration(
              color: InvestTradingUi.surfaceElevated,
            ),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: _accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: _accent.withValues(alpha: 0.35)),
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: widget.stock.logoUrl.isEmpty
                      ? Icon(
                          Icons.show_chart_rounded,
                          size: 26.sp,
                          color: _accent,
                        )
                      : Image.network(
                          widget.stock.logoUrl,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.business_rounded,
                              size: 26.sp,
                              color: _accent,
                            );
                          },
                        ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.stock.symbol,
                        style: GoogleFonts.inter(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w800,
                          color: InvestTradingUi.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.stock.name,
                        style: InvestTradingUi.labelMuted(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      CurrencySymbols.formatAmountWithCurrency(
                        widget.stock.currentPrice,
                        widget.stock.currency,
                      ),
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: InvestTradingUi.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: (widget.stock.isPositive ? up : down)
                            .withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: (widget.stock.isPositive ? up : down)
                              .withValues(alpha: 0.35),
                        ),
                      ),
                      child: Text(
                        '${widget.stock.isPositive ? '+' : ''}${widget.stock.changePercent.toStringAsFixed(2)}%',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: widget.stock.isPositive ? up : down,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 28.h),

          Text(
            'Buy or sell',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: InvestTradingUi.textPrimary,
            ),
          ),
          SizedBox(height: 14.h),

          Row(
            children: [
              Expanded(
                child: _buildSideTile(
                  label: 'Buy',
                  icon: Icons.trending_up_rounded,
                  side: OrderSide.buy,
                  activeColor: up,
                  fgWhenActive: Colors.black,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildSideTile(
                  label: 'Sell',
                  icon: Icons.trending_down_rounded,
                  side: OrderSide.sell,
                  activeColor: down,
                  fgWhenActive: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 28.h),

          Text(
            'Order type',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: InvestTradingUi.textPrimary,
            ),
          ),
          SizedBox(height: 14.h),

          _buildOrderTypeRow(
            'Market',
            'Execute at the best price now',
            Icons.bolt_rounded,
            OrderType.market,
          ),
          SizedBox(height: 10.h),
          _buildOrderTypeRow(
            'Limit',
            'Set the max you pay or min you accept',
            Icons.edit_note_rounded,
            OrderType.limit,
          ),
          SizedBox(height: 10.h),
          _buildOrderTypeRow(
            'Stop loss',
            'Triggers a market order at your stop',
            Icons.shield_outlined,
            OrderType.stopLoss,
          ),
          SizedBox(height: 10.h),
          _buildOrderTypeRow(
            'Stop limit',
            'Stop trigger + limit price',
            Icons.tune_rounded,
            OrderType.stopLimit,
          ),
        ],
      ),
    );
  }

  Widget _buildSideTile({
    required String label,
    required IconData icon,
    required OrderSide side,
    required Color activeColor,
    required Color fgWhenActive,
  }) {
    final selected = _selectedSide == side;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() => _selectedSide = side);
          _updateSelection();
        },
        borderRadius: BorderRadius.circular(14.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 18.h),
          decoration: BoxDecoration(
            color: selected
                ? activeColor
                : InvestTradingUi.surfaceElevated,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected
                  ? activeColor
                  : Colors.white.withValues(alpha: 0.1),
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 30.sp,
                color: selected ? fgWhenActive : InvestTradingUi.textSecondary,
              ),
              SizedBox(height: 8.h),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w800,
                  color: selected ? fgWhenActive : InvestTradingUi.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderTypeRow(
    String title,
    String description,
    IconData icon,
    OrderType type,
  ) {
    final selected = _selectedType == type;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() => _selectedType = type);
          _updateSelection();
        },
        borderRadius: BorderRadius.circular(14.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: selected
                ? _accent.withValues(alpha: 0.12)
                : InvestTradingUi.surfaceElevated,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: selected
                  ? _accent.withValues(alpha: 0.55)
                  : Colors.white.withValues(alpha: 0.08),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: selected
                      ? _accent.withValues(alpha: 0.22)
                      : InvestTradingUi.surface,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 22.sp,
                  color: selected ? _accent : InvestTradingUi.textSecondary,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: InvestTradingUi.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      description,
                      style: InvestTradingUi.labelMuted().copyWith(height: 1.3),
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(
                  Icons.check_circle_rounded,
                  color: _accent,
                  size: 24.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
