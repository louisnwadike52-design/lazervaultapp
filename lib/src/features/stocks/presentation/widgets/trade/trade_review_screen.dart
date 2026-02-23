import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

import '../../../domain/entities/stock_entity.dart';

/// Step 3: Review order details before placing
class TradeReviewScreen extends StatelessWidget {
  final Stock stock;
  final OrderSide orderSide;
  final OrderType orderType;
  final int quantity;
  final double? limitPrice;
  final double? stopPrice;

  const TradeReviewScreen({
    super.key,
    required this.stock,
    required this.orderSide,
    required this.orderType,
    required this.quantity,
    this.limitPrice,
    this.stopPrice,
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
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order summary header
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (orderSide == OrderSide.buy ? Colors.green : Colors.red)
                      .withValues(alpha: 0.3),
                  (orderSide == OrderSide.buy ? Colors.green : Colors.red)
                      .withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: (orderSide == OrderSide.buy ? Colors.green : Colors.red)
                    .withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  orderSide == OrderSide.buy
                      ? Icons.shopping_cart_outlined
                      : Icons.sell_outlined,
                  size: 48.sp,
                  color: orderSide == OrderSide.buy ? Colors.green : Colors.red,
                ),
                SizedBox(height: 16.h),
                Text(
                  orderSide == OrderSide.buy ? 'Buying' : 'Selling',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$quantity ${quantity == 1 ? 'Share' : 'Shares'}',
                  style: GoogleFonts.inter(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'of ${stock.symbol}',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Order details section
          Text(
            'Order Details',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
              orderSide == OrderSide.buy ? 'BUY' : 'SELL',
              valueColor: orderSide == OrderSide.buy ? Colors.green : Colors.red,
            ),
            _buildDivider(),
            _buildDetailRow('Order Type', _getOrderTypeLabel()),
            _buildDivider(),
            _buildDetailRow('Quantity', '$quantity shares'),
          ]),

          SizedBox(height: 24.h),

          // Price details section
          Text(
            'Price Details',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          _buildDetailCard([
            if (orderType == OrderType.market)
              _buildDetailRow(
                'Market Price',
                CurrencySymbols.formatAmountWithCurrency(stock.currentPrice, stock.currency),
                valueColor: Colors.white,
              ),
            if (orderType == OrderType.limit || orderType == OrderType.stopLimit) ...[
              _buildDetailRow(
                'Limit Price',
                limitPrice != null ? CurrencySymbols.formatAmountWithCurrency(limitPrice!, stock.currency) : 'N/A',
                valueColor: Colors.white,
              ),
              _buildDivider(),
            ],
            if (orderType == OrderType.stopLoss || orderType == OrderType.stopLimit) ...[
              _buildDetailRow(
                'Stop Price',
                stopPrice != null ? CurrencySymbols.formatAmountWithCurrency(stopPrice!, stock.currency) : 'N/A',
                valueColor: Colors.white,
              ),
              _buildDivider(),
            ],
            _buildDetailRow(
              'Execution Price',
              CurrencySymbols.formatAmountWithCurrency(_executionPrice, stock.currency),
              valueColor: const Color(0xFF6366F1),
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
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: const Color(0xFF6366F1).withValues(alpha: 0.5),
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
                      orderSide == OrderSide.buy ? 'Total Cost' : 'Total Proceeds',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      CurrencySymbols.formatAmountWithCurrency(_grandTotal, stock.currency),
                      style: GoogleFonts.inter(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: orderSide == OrderSide.buy ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    orderSide == OrderSide.buy
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Important notes
          _buildInfoBox(
            Icons.info_outline,
            'Important Information',
            _getImportantNote(),
            Colors.blue,
          ),

          SizedBox(height: 16.h),

          // Risk warning
          _buildInfoBox(
            Icons.warning_amber_outlined,
            'Risk Warning',
            'Trading stocks involves risk. You may lose some or all of your investment. Past performance does not guarantee future results.',
            Colors.orange,
          ),

          SizedBox(height: 24.h),

          // Terms acceptance
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
                    'By placing this order, you agree to our Terms of Service and Risk Disclosure.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[400],
                    ),
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
