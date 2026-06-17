import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';

import '../../../domain/entities/stock_entity.dart';

/// Step 3: Review order details before placing
class TradeReviewScreen extends StatelessWidget {
  final Stock stock;
  final OrderSide orderSide;
  final OrderType orderType;
  final int quantity;
  final double? limitPrice;
  final double? stopPrice;
  final Color? accentColor;

  const TradeReviewScreen({
    super.key,
    required this.stock,
    required this.orderSide,
    required this.orderType,
    required this.quantity,
    this.limitPrice,
    this.stopPrice,
    this.accentColor,
  });

  double get _executionPrice {
    if (orderType == OrderType.limit && limitPrice != null) {
      return limitPrice!;
    }
    return stock.currentPrice;
  }

  double get _estimatedTotal {
    return _executionPrice * quantity;
  }

  double get _estimatedFees {
    // Example: $0.50 per trade + 0.1% of total
    return 0.50 + (_estimatedTotal * 0.001);
  }

  double get _grandTotal {
    return orderSide == OrderSide.buy
        ? _estimatedTotal + _estimatedFees
        : _estimatedTotal - _estimatedFees;
  }

  @override
  Widget build(BuildContext context) {
    final accent = accentColor ?? InvestTradingUi.accent;
    final sideColor =
        orderSide == OrderSide.buy ? InvestTradingUi.buy : InvestTradingUi.sell;

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order summary header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: InvestTradingUi.surfaceElevated,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: sideColor.withValues(alpha: 0.35)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: sideColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    orderSide == OrderSide.buy
                        ? Icons.trending_up_rounded
                        : Icons.trending_down_rounded,
                    size: 36.sp,
                    color: sideColor,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  orderSide == OrderSide.buy ? 'BUY ORDER' : 'SELL ORDER',
                  style: InvestTradingUi.eyebrow(sideColor),
                ),
                SizedBox(height: 8.h),
                Text(
                  '$quantity ${quantity == 1 ? 'share' : 'shares'}',
                  style: GoogleFonts.inter(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w800,
                    color: InvestTradingUi.textPrimary,
                    letterSpacing: -0.6,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  stock.symbol,
                  style: GoogleFonts.inter(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w600,
                    color: InvestTradingUi.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  stock.name,
                  textAlign: TextAlign.center,
                  style: InvestTradingUi.labelMuted(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Order details section
          Text(
            'Order details',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: InvestTradingUi.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          _buildDetailCard([
            _buildDetailRow('Stock', stock.name),
            _buildDivider(),
            _buildDetailRow('Symbol', stock.symbol),
            _buildDivider(),
            _buildDetailRow(
              'Action',
              orderSide == OrderSide.buy ? 'Buy' : 'Sell',
              valueColor: sideColor,
            ),
            _buildDivider(),
            _buildDetailRow('Order Type', _getOrderTypeLabel()),
            _buildDivider(),
            _buildDetailRow('Quantity', '$quantity shares'),
          ]),

          SizedBox(height: 24.h),

          // Price details section
          Text(
            'Price details',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: InvestTradingUi.textPrimary,
            ),
          ),
          SizedBox(height: 16.h),

          _buildDetailCard([
            if (orderType == OrderType.market)
              _buildDetailRow(
                'Market price',
                CurrencySymbols.formatAmountWithCurrency(
                    stock.currentPrice, stock.currency),
                valueColor: InvestTradingUi.textPrimary,
              ),
            if (orderType == OrderType.limit || orderType == OrderType.stopLimit) ...[
              _buildDetailRow(
                'Limit price',
                limitPrice != null
                    ? CurrencySymbols.formatAmountWithCurrency(
                        limitPrice!, stock.currency)
                    : '—',
                valueColor: InvestTradingUi.textPrimary,
              ),
              _buildDivider(),
            ],
            if (orderType == OrderType.stopLoss || orderType == OrderType.stopLimit) ...[
              _buildDetailRow(
                'Stop price',
                stopPrice != null
                    ? CurrencySymbols.formatAmountWithCurrency(
                        stopPrice!, stock.currency)
                    : '—',
                valueColor: InvestTradingUi.textPrimary,
              ),
              _buildDivider(),
            ],
            _buildDetailRow(
              'Execution price',
              CurrencySymbols.formatAmountWithCurrency(_executionPrice, stock.currency),
              valueColor: accent,
            ),
            _buildDivider(),
            _buildDetailRow(
              'Subtotal',
              CurrencySymbols.formatAmountWithCurrency(_estimatedTotal, stock.currency),
            ),
            _buildDivider(),
            _buildDetailRow(
              'Est. Fees',
              CurrencySymbols.formatAmountWithCurrency(_estimatedFees, stock.currency),
              labelColor: Colors.grey[500],
            ),
          ]),

          SizedBox(height: 24.h),

          // Total section
          Container(
            padding: EdgeInsets.all(22.w),
            decoration: BoxDecoration(
              color: InvestTradingUi.surfaceElevated,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: accent.withValues(alpha: 0.45),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderSide == OrderSide.buy
                          ? 'Total cost'
                          : 'Total proceeds',
                      style: InvestTradingUi.labelMuted(),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      CurrencySymbols.formatAmountWithCurrency(
                          _grandTotal, stock.currency),
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: InvestTradingUi.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: sideColor.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: sideColor.withValues(alpha: 0.5)),
                  ),
                  child: Icon(
                    orderSide == OrderSide.buy
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    color: sideColor,
                    size: 28.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Important notes
          _buildInfoBox(
            Icons.info_outline_rounded,
            'Before you confirm',
            _getImportantNote(),
            accent,
          ),

          SizedBox(height: 16.h),

          // Risk warning
          _buildInfoBox(
            Icons.shield_outlined,
            'Risk',
            'Capital at risk. You may get back less than you invest. Past performance is not a guide to the future.',
            const Color(0xFFFB923C),
          ),

          SizedBox(height: 24.h),

          // Terms acceptance
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: InvestTradingUi.cardDecoration(
              color: InvestTradingUi.surfaceElevated,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: InvestTradingUi.buy,
                  size: 22.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'By placing this order you agree to our terms and risk disclosures.',
                    style: InvestTradingUi.labelMuted().copyWith(height: 1.4),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 80.h), // Extra space for bottom buttons
        ],
      ),
    );
  }

  Widget _buildDetailCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: InvestTradingUi.statementCardDecoration(),
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
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: labelColor ?? InvestTradingUi.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: valueColor ?? InvestTradingUi.textPrimary,
              ),
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
        color: InvestTradingUi.border,
        height: 1,
      ),
    );
  }

  Widget _buildInfoBox(IconData icon, String title, String message, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: color,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  message,
                  style: InvestTradingUi.labelMuted().copyWith(height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getOrderTypeLabel() {
    switch (orderType) {
      case OrderType.market:
        return 'Market Order';
      case OrderType.limit:
        return 'Limit Order';
      case OrderType.stopLoss:
        return 'Stop Loss';
      case OrderType.stopLimit:
        return 'Stop Limit';
    }
  }

  String _getImportantNote() {
    final currencySymbol = CurrencySymbols.getSymbol(stock.currency);
    switch (orderType) {
      case OrderType.market:
        return 'This market order will execute immediately at the current market price. The actual execution price may vary slightly from the displayed price.';
      case OrderType.limit:
        return 'This limit order will only execute at your specified price ($currencySymbol${limitPrice?.toStringAsFixed(2)}) or better. There is no guarantee the order will be filled.';
      case OrderType.stopLoss:
        return 'This stop loss order will trigger a market sell order when the price reaches $currencySymbol${stopPrice?.toStringAsFixed(2)}. The execution price may vary from the stop price.';
      case OrderType.stopLimit:
        return 'This stop limit order will trigger when the price reaches $currencySymbol${stopPrice?.toStringAsFixed(2)} and will only execute between $currencySymbol${stopPrice?.toStringAsFixed(2)} and $currencySymbol${limitPrice?.toStringAsFixed(2)}.';
    }
  }
}
