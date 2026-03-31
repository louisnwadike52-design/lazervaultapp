import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';

import '../../../domain/entities/stock_entity.dart';

/// Step 2: Enter trade quantity and price details
class TradeQuantityScreen extends StatefulWidget {
  final Stock stock;
  final OrderSide orderSide;
  final OrderType orderType;
  final int initialQuantity;
  final double? initialLimitPrice;
  final double? initialStopPrice;
  final Color? accentColor;
  final Function(int, double?, double?) onChanged;

  const TradeQuantityScreen({
    super.key,
    required this.stock,
    required this.orderSide,
    required this.orderType,
    required this.initialQuantity,
    this.initialLimitPrice,
    this.initialStopPrice,
    this.accentColor,
    required this.onChanged,
  });

  @override
  State<TradeQuantityScreen> createState() => _TradeQuantityScreenState();
}

class _TradeQuantityScreenState extends State<TradeQuantityScreen> {
  Color get _accent => widget.accentColor ?? InvestTradingUi.accent;

  Color get _sideColor =>
      widget.orderSide == OrderSide.buy ? InvestTradingUi.buy : InvestTradingUi.sell;

  late TextEditingController _quantityController;
  late TextEditingController _limitPriceController;
  late TextEditingController _stopPriceController;

  int _quantity = 1;
  double? _limitPrice;
  double? _stopPrice;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
    _limitPrice = widget.initialLimitPrice;
    _stopPrice = widget.initialStopPrice;

    _quantityController = TextEditingController(text: _quantity.toString());
    _limitPriceController = TextEditingController(
      text: _limitPrice?.toStringAsFixed(2) ?? '',
    );
    _stopPriceController = TextEditingController(
      text: _stopPrice?.toStringAsFixed(2) ?? '',
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _limitPriceController.dispose();
    _stopPriceController.dispose();
    super.dispose();
  }

  void _updateQuantity(int value) {
    setState(() {
      _quantity = value;
    });
    widget.onChanged(_quantity, _limitPrice, _stopPrice);
  }

  void _updateLimitPrice(String value) {
    setState(() {
      _limitPrice = double.tryParse(value);
    });
    widget.onChanged(_quantity, _limitPrice, _stopPrice);
  }

  void _updateStopPrice(String value) {
    setState(() {
      _stopPrice = double.tryParse(value);
    });
    widget.onChanged(_quantity, _limitPrice, _stopPrice);
  }

  double get _estimatedTotal {
    double price = widget.stock.currentPrice;
    if (widget.orderType == OrderType.limit && _limitPrice != null) {
      price = _limitPrice!;
    }
    return price * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order summary
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: InvestTradingUi.surfaceElevated,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: _sideColor.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderSide == OrderSide.buy ? 'BUYING' : 'SELLING',
                      style: InvestTradingUi.eyebrow(_sideColor),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.stock.symbol,
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: InvestTradingUi.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _getOrderTypeLabel(),
                      style: InvestTradingUi.labelMuted(),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: _sideColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        widget.orderSide == OrderSide.buy ? 'BUY' : 'SELL',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          color: widget.orderSide == OrderSide.buy
                              ? Colors.black
                              : Colors.white,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Quantity input
          Text(
            'Number of shares',
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: InvestTradingUi.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),

          // Quantity selector with +/- buttons
          Row(
            children: [
              // Decrement button
              _buildQuantityButton(
                Icons.remove,
                () {
                  if (_quantity > 1) {
                    _updateQuantity(_quantity - 1);
                    _quantityController.text = _quantity.toString();
                  }
                },
              ),
              SizedBox(width: 12.w),
              // Quantity input
              Expanded(
                child: TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: InvestTradingUi.textPrimary,
                  ),
                  decoration: InvestTradingUi.tradingInputDecoration(
                    accentColor: _accent,
                  ).copyWith(
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    final qty = int.tryParse(value) ?? 1;
                    _updateQuantity(qty);
                  },
                ),
              ),
              SizedBox(width: 12.w),
              // Increment button
              _buildQuantityButton(
                Icons.add,
                () {
                  _updateQuantity(_quantity + 1);
                  _quantityController.text = _quantity.toString();
                },
              ),
            ],
          ),

          SizedBox(height: 24.h),

          // Price inputs based on order type
          if (widget.orderType == OrderType.limit ||
              widget.orderType == OrderType.stopLimit) ...[
            Text(
              'Limit price',
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: InvestTradingUi.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _limitPriceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                color: InvestTradingUi.textPrimary,
              ),
              decoration: InvestTradingUi.tradingInputDecoration(
                accentColor: _accent,
                prefixText: '${CurrencySymbols.getSymbol(widget.stock.currency)} ',
                hintText: widget.stock.currentPrice.toStringAsFixed(2),
              ).copyWith(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
              onChanged: _updateLimitPrice,
            ),
            SizedBox(height: 24.h),
          ],

          if (widget.orderType == OrderType.stopLoss ||
              widget.orderType == OrderType.stopLimit) ...[
            Text(
              'Stop price',
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: InvestTradingUi.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _stopPriceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                color: InvestTradingUi.textPrimary,
              ),
              decoration: InvestTradingUi.tradingInputDecoration(
                accentColor: _accent,
                prefixText: '${CurrencySymbols.getSymbol(widget.stock.currency)} ',
                hintText: widget.stock.currentPrice.toStringAsFixed(2),
              ).copyWith(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
              onChanged: _updateStopPrice,
            ),
            SizedBox(height: 24.h),
          ],

          // Estimated total
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: InvestTradingUi.statementCardDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated total',
                  style: InvestTradingUi.labelMuted().copyWith(fontSize: 14.sp),
                ),
                Text(
                  CurrencySymbols.formatAmountWithCurrency(
                      _estimatedTotal, widget.stock.currency),
                  style: GoogleFonts.inter(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: InvestTradingUi.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Info note
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: _accent.withValues(alpha: 0.28)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: _accent,
                  size: 22.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.orderType == OrderType.market
                        ? 'Market orders execute at the best available price now.'
                        : widget.orderType == OrderType.limit
                            ? 'Limit orders fill at your price or better only.'
                            : 'Stop orders activate when the market hits your stop level.',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      height: 1.35,
                      color: InvestTradingUi.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: InvestTradingUi.surfaceElevated,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          width: 52.w,
          height: 52.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: _accent.withValues(alpha: 0.45)),
          ),
          child: Icon(icon, color: _accent, size: 24.sp),
        ),
      ),
    );
  }

  String _getOrderTypeLabel() {
    switch (widget.orderType) {
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
}
