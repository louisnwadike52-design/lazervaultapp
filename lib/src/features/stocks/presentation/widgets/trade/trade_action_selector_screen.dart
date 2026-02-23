import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

import '../../../domain/entities/stock_entity.dart';

/// Step 1: Select trade action (buy/sell) and order type
class TradeActionSelectorScreen extends StatefulWidget {
  final Stock stock;
  final OrderSide initialSide;
  final OrderType initialType;
  final Function(OrderSide, OrderType) onChanged;

  const TradeActionSelectorScreen({
    super.key,
    required this.stock,
    required this.initialSide,
    required this.initialType,
    required this.onChanged,
  });

  @override
  State<TradeActionSelectorScreen> createState() => _TradeActionSelectorScreenState();
}

class _TradeActionSelectorScreenState extends State<TradeActionSelectorScreen> {
  late OrderSide _selectedSide;
  late OrderType _selectedType;

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
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stock info card
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF2A2A3E).withValues(alpha: 0.8),
                  const Color(0xFF1F1F35).withValues(alpha: 0.9),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                // Logo
                ...[
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: Image.network(
                    widget.stock.logoUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.business, size: 32.sp, color: Colors.grey);
                    },
                  ),
                ),
                SizedBox(width: 16.w),
              ],
                // Symbol and name
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.stock.symbol,
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        widget.stock.name,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.grey[400],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Current price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      CurrencySymbols.formatAmountWithCurrency(widget.stock.currentPrice, widget.stock.currency),
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: widget.stock.isPositive
                            ? Colors.green.withValues(alpha: 0.2)
                            : Colors.red.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        '${widget.stock.isPositive ? '+' : ''}${widget.stock.changePercent.toStringAsFixed(2)}%',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: widget.stock.isPositive ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Buy/Sell selection
          Text(
            'Select Action',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  'Buy',
                  Icons.trending_up,
                  Colors.green,
                  OrderSide.buy,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionButton(
                  'Sell',
                  Icons.trending_down,
                  Colors.red,
                  OrderSide.sell,
                ),
              ),
            ],
          ),

          SizedBox(height: 32.h),

          // Order type selection
          Text(
            'Order Type',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          _buildOrderTypeCard(
            'Market Order',
            'Execute immediately at current market price',
            Icons.flash_on,
            OrderType.market,
          ),
          SizedBox(height: 12.h),
          _buildOrderTypeCard(
            'Limit Order',
            'Set a specific price you want to pay/receive',
            Icons.edit_note,
            OrderType.limit,
          ),
          SizedBox(height: 12.h),
          _buildOrderTypeCard(
            'Stop Loss',
            'Automatically sell when price drops to stop level',
            Icons.shield_outlined,
            OrderType.stopLoss,
          ),
          SizedBox(height: 12.h),
          _buildOrderTypeCard(
            'Stop Limit',
            'Combine stop and limit orders for more control',
            Icons.settings_outlined,
            OrderType.stopLimit,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, OrderSide side) {
    final isSelected = _selectedSide == side;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSide = side;
        });
        _updateSelection();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [color.withValues(alpha: 0.8), color.withValues(alpha: 0.6)],
                )
              : null,
          color: isSelected ? null : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? color : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: isSelected ? Colors.white : Colors.grey[400],
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderTypeCard(
    String title,
    String description,
    IconData icon,
    OrderType type,
  ) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
        _updateSelection();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6366F1).withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6366F1)
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6366F1)
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                size: 24.sp,
                color: isSelected ? Colors.white : Colors.grey[400],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: const Color(0xFF6366F1),
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }
}
