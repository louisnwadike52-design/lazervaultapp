import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/utils/currency_formatter.dart';

import 'portfolio_rebalance_carousel.dart';

/// Confirmation screen showing rebalance receipt
class PortfolioRebalanceConfirmationScreen extends StatefulWidget {
  final List<RebalanceTrade> trades;
  final String strategy;

  const PortfolioRebalanceConfirmationScreen({
    super.key,
    required this.trades,
    required this.strategy,
  });

  @override
  State<PortfolioRebalanceConfirmationScreen> createState() =>
      _PortfolioRebalanceConfirmationScreenState();
}

class _PortfolioRebalanceConfirmationScreenState
    extends State<PortfolioRebalanceConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final String _rebalanceId = 'RB${DateTime.now().millisecondsSinceEpoch}';

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

  void _copyRebalanceId() {
    Clipboard.setData(ClipboardData(text: _rebalanceId));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Rebalance ID copied to clipboard',
          style: GoogleFonts.inter(),
        ),
        backgroundColor: const Color(0xFF6366F1),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareReceipt() {
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');
    final now = DateTime.now();

    final receiptText = '''
📊 Portfolio Rebalance Receipt

Rebalance ID: $_rebalanceId
Strategy: ${widget.strategy}
Status: Completed

━━━━━━━━━━━━━━━━━━━━━━
Total Trades: ${widget.trades.length}
Date: ${dateFormat.format(now)}

Trades Executed:
${widget.trades.map((trade) => '  ${trade.action} ${trade.sharesToTrade} ${trade.symbol} @ \$${trade.estimatedPrice.toStringAsFixed(2)}').join('\n')}
━━━━━━━━━━━━━━━━━━━━━━

💼 LazerVault Portfolio
🚀 Generated with Claude Code
''';

    SharePlus.instance.share(ShareParams(
      text: receiptText,
      subject: 'Rebalance Receipt - $_rebalanceId',
    )).then((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Receipt shared successfully',
            style: GoogleFonts.inter(),
          ),
          backgroundColor: const Color(0xFF6366F1),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _returnToPortfolio() {
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
                    'Rebalance Complete!',
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    'Your portfolio has been successfully rebalanced',
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
            const Color(0xFF6366F1).withValues(alpha: 0.3),
            const Color(0xFF8B5CF6).withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Icon(
        Icons.check_circle,
        size: 60.sp,
        color: const Color(0xFF6366F1),
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
                    'Rebalance ID',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _rebalanceId,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Completed',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Strategy
          Center(
            child: Column(
              children: [
                Text(
                  'Strategy',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.strategy,
                  style: GoogleFonts.inter(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF6366F1),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Rebalance details
          Text(
            'Rebalance Details',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),

          _buildDetailRow('Total Trades', '${widget.trades.length}'),
          SizedBox(height: 12.h),
          _buildDetailRow('Date & Time', dateFormat.format(DateTime.now())),
          SizedBox(height: 12.h),
          _buildDetailRow('Status', 'All trades executed'),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Trade list
          Text(
            'Executed Trades',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),

          ...widget.trades.map((trade) {
            final isBuy = trade.action == 'Buy';
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: isBuy ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${trade.action} ${trade.symbol}',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${trade.sharesToTrade} shares',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    CurrencySymbols.formatAmountWithCurrency(trade.estimatedTotal, 'USD'),
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: isBuy ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),

          // Confirmation message
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: const Color(0xFF6366F1), size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Your portfolio is now balanced according to your target allocations.',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF8B9CFF),
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

  Widget _buildDetailRow(String label, String value) {
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
            color: Colors.white,
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
            onPressed: _copyRebalanceId,
            icon: Icon(Icons.copy, size: 18.sp),
            label: const Text('Copy ID'),
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
            label: const Text('Share'),
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
}
