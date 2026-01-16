import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/stock_entity.dart';

/// Confirmation screen showing trade receipt
class StockTradeConfirmationScreen extends StatefulWidget {
  final StockOrder order;
  final Stock stock;

  const StockTradeConfirmationScreen({
    super.key,
    required this.order,
    required this.stock,
  });

  @override
  State<StockTradeConfirmationScreen> createState() =>
      _StockTradeConfirmationScreenState();
}

class _StockTradeConfirmationScreenState extends State<StockTradeConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _copyOrderId() {
    Clipboard.setData(ClipboardData(text: widget.order.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Order ID copied to clipboard',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareReceipt() {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');
    final orderTypeLabel = _getOrderTypeLabel();
    final actionLabel = widget.order.side == OrderSide.buy ? 'BOUGHT' : 'SOLD';
    final estimatedTotal = (widget.order.price ?? widget.stock.currentPrice) * widget.order.quantity;

    final receiptText = '''
📊 Trade Receipt - ${widget.stock.symbol}

Order ID: #${widget.order.id}
Status: ${_getStatusText()}

━━━━━━━━━━━━━━━━━━━━━━
Stock: ${widget.stock.name} (${widget.stock.symbol})
Action: $actionLabel
Order Type: $orderTypeLabel
Quantity: ${widget.order.quantity} shares
${widget.order.price != null ? 'Price: \$${widget.order.price!.toStringAsFixed(2)}' : ''}
Estimated Total: \$${estimatedTotal.toStringAsFixed(2)}
Date: ${dateFormat.format(widget.order.createdAt)}
━━━━━━━━━━━━━━━━━━━━━━

💼 Trade with LazerVault
🚀 Generated with Claude Code
''';

    Share.share(
      receiptText,
      subject: '${widget.stock.symbol} Trade Receipt - Order #${widget.order.id}',
    ).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Receipt shared successfully',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to share receipt',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  String _getStatusText() {
    switch (widget.order.status) {
      case OrderStatus.executed:
        return 'Executed';
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.rejected:
        return 'Rejected';
      case OrderStatus.partiallyFilled:
        return 'Partially Filled';
    }
  }

  void _returnToPortfolio() {
    // Navigate back to portfolio or stocks screen
    Get.until((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // Success icon
                  _buildSuccessIcon(),

                  SizedBox(height: 32.h),

                  // Success message
                  Text(
                    'Order Placed Successfully!',
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    'Your ${widget.order.side == OrderSide.buy ? 'buy' : 'sell'} order has been submitted',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32.h),

                  // Receipt card
                  _buildReceiptCard(),

                  SizedBox(height: 24.h),

                  // Action buttons
                  _buildActionButtons(),

                  SizedBox(height: 24.h),

                  // Return button
                  _buildReturnButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.green.withValues(alpha: 0.3),
            Colors.green.shade700.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Icon(
        Icons.check_circle,
        size: 60.sp,
        color: Colors.green,
      ),
    );
  }

  Widget _buildReceiptCard() {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '#${widget.order.id}',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              _buildStatusBadge(),
            ],
          ),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Stock details
          Row(
            children: [
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
                    SizedBox(height: 2.h),
                    Text(
                      widget.stock.name,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.grey[400],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Transaction details
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          _buildDetailRow('Action', widget.order.side == OrderSide.buy ? 'BUY' : 'SELL',
              valueColor: widget.order.side == OrderSide.buy ? Colors.green : Colors.red),
          SizedBox(height: 12.h),
          _buildDetailRow('Order Type', _getOrderTypeLabel()),
          SizedBox(height: 12.h),
          _buildDetailRow('Quantity', '${widget.order.quantity} shares'),
          SizedBox(height: 12.h),
          if (widget.order.price != null)
            _buildDetailRow('Price', '\$${widget.order.price!.toStringAsFixed(2)}'),
          if (widget.order.price != null) SizedBox(height: 12.h),
          _buildDetailRow(
            'Est. Total',
            '\$${((widget.order.price ?? widget.stock.currentPrice) * widget.order.quantity).toStringAsFixed(2)}',
            valueColor: const Color(0xFF6366F1),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Date & Time',
            dateFormat.format(widget.order.createdAt),
          ),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Confirmation message
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.green, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    widget.order.status == OrderStatus.executed
                        ? 'Your order has been executed successfully'
                        : 'Your order is pending and will be executed when conditions are met',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.green[200],
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

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;
    String statusText;

    switch (widget.order.status) {
      case OrderStatus.executed:
        backgroundColor = Colors.green;
        textColor = Colors.white;
        statusText = 'Executed';
        break;
      case OrderStatus.pending:
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        statusText = 'Pending';
        break;
      case OrderStatus.cancelled:
        backgroundColor = Colors.grey;
        textColor = Colors.white;
        statusText = 'Cancelled';
        break;
      case OrderStatus.rejected:
        backgroundColor = Colors.red;
        textColor = Colors.white;
        statusText = 'Rejected';
        break;
      case OrderStatus.partiallyFilled:
        backgroundColor = Colors.blue;
        textColor = Colors.white;
        statusText = 'Partial';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        statusText,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.grey[400],
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
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.1),
      height: 1,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _copyOrderId,
            icon: Icon(Icons.copy, size: 18.sp),
            label: Text('Copy ID'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _shareReceipt,
            icon: Icon(Icons.share, size: 18.sp),
            label: Text('Share'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReturnButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _returnToPortfolio,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6366F1),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'View Portfolio',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String _getOrderTypeLabel() {
    switch (widget.order.type) {
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
