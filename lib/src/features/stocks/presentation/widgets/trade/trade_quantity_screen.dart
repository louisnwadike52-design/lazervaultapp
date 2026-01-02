import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entities/stock_entity.dart';

/// Step 2: Enter trade quantity and price details
class TradeQuantityScreen extends StatefulWidget {
  final Stock stock;
  final OrderSide orderSide;
  final OrderType orderType;
  final int initialQuantity;
  final double? initialLimitPrice;
  final double? initialStopPrice;
  final Function(int, double?, double?) onChanged;

  const TradeQuantityScreen({
    super.key,
    required this.stock,
    required this.orderSide,
    required this.orderType,
    required this.initialQuantity,
    this.initialLimitPrice,
    this.initialStopPrice,
    required this.onChanged,
  });

  @override
  State<TradeQuantityScreen> createState() => _TradeQuantityScreenState();
}

class _TradeQuantityScreenState extends State<TradeQuantityScreen> {
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
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (widget.orderSide == OrderSide.buy ? Colors.green : Colors.red)
                      .withValues(alpha: 0.2),
                  (widget.orderSide == OrderSide.buy ? Colors.green : Colors.red)
                      .withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderSide == OrderSide.buy ? 'Buying' : 'Selling',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.stock.symbol,
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _getOrderTypeLabel(),
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: widget.orderSide == OrderSide.buy
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        widget.orderSide == OrderSide.buy ? 'BUY' : 'SELL',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
            'Number of Shares',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
                    ),
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
              'Limit Price',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _limitPriceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                prefixText: '\$ ',
                hintText: widget.stock.currentPrice.toStringAsFixed(2),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
              onChanged: _updateLimitPrice,
            ),
            SizedBox(height: 24.h),
          ],

          if (widget.orderType == OrderType.stopLoss ||
              widget.orderType == OrderType.stopLimit) ...[
            Text(
              'Stop Price',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            TextFormField(
              controller: _stopPriceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                prefixText: '\$ ',
                hintText: widget.stock.currentPrice.toStringAsFixed(2),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
              onChanged: _updateStopPrice,
            ),
            SizedBox(height: 24.h),
          ],

          // Estimated total
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated Total',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[400],
                  ),
                ),
                Text(
                  '\$${_estimatedTotal.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.orderType == OrderType.market
                        ? 'Market orders execute immediately at the current price'
                        : widget.orderType == OrderType.limit
                            ? 'Your order will only execute at your limit price or better'
                            : 'Stop orders will trigger when the price reaches your stop level',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.blue[200],
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
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 24.sp),
        onPressed: onPressed,
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
