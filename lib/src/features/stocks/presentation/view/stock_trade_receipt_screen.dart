import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/stock_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/utils/currency_formatter.dart';

class StockTradeReceiptScreen extends StatefulWidget {
  const StockTradeReceiptScreen({super.key});

  @override
  State<StockTradeReceiptScreen> createState() => _StockTradeReceiptScreenState();
}

class _StockTradeReceiptScreenState extends State<StockTradeReceiptScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  Stock? _selectedStock;
  String _tradeType = 'buy';
  double _amount = 0.0;
  int _shares = 0;
  double _fees = 0.0;
  double _total = 0.0;
  String _transactionId = '';
  DateTime _transactionDate = DateTime.now();
  String _paymentMethod = '';
  Map<String, dynamic> _paymentDetails = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _selectedStock = args['stock'] as Stock?;
    _tradeType = args['tradeType'] ?? 'buy';
    _amount = args['amount'] ?? 0.0;
    _shares = args['shares'] ?? 0;
    _fees = args['fees'] ?? 0.0;
    _total = args['total'] ?? 0.0;
    _transactionId = args['transactionId'] ?? 'STK${DateTime.now().millisecondsSinceEpoch}';
    _transactionDate = args['transactionDate'] ?? DateTime.now();
    _paymentMethod = args['paymentMethod'] ?? '';
    _paymentDetails = args['paymentDetails'] ?? {};
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _shareReceipt() {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share functionality coming soon'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _downloadReceipt() {
    // TODO: Implement download functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Receipt downloaded successfully'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _goToHome() {
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void _goToPortfolio() {
    Get.offAllNamed(AppRoutes.stocks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Column(
                        children: [
                          _buildSuccessIcon(),
                          SizedBox(height: 24.h),
                          _buildSuccessMessage(),
                          SizedBox(height: 32.h),
                          _buildReceiptCard(),
                          SizedBox(height: 24.h),
                          _buildActionButtons(),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildBottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Transaction Receipt',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: _shareReceipt,
              icon: Icon(
                Icons.share,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4CAF50),
            const Color(0xFF45A049),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 50.sp,
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      children: [
        Text(
          'Transaction Successful!',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'Your $_tradeType order has been executed successfully',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 16.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildReceiptCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.9),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),        boxShadow: [
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
          _buildStockHeader(),
          SizedBox(height: 24.h),
          _buildTransactionDetails(),
          SizedBox(height: 20.h),
          Divider(color: Colors.grey[600]),
          SizedBox(height: 20.h),
          _buildPaymentDetails(),
          SizedBox(height: 20.h),
          Divider(color: Colors.grey[600]),
          SizedBox(height: 20.h),
          _buildTransactionInfo(),
        ],
      ),
    );
  }

  Widget _buildStockHeader() {
    if (_selectedStock == null) return const SizedBox.shrink();
    
    return Row(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[100]!],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: _selectedStock!.logoUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: _selectedStock!.logoUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.business, color: Colors.grey[600], size: 24.sp),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Text(
                        _selectedStock!.symbol[0],
                        style: GoogleFonts.inter(
                          color: Colors.grey[700],
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: Text(
                      _selectedStock!.symbol[0],
                      style: GoogleFonts.inter(
                        color: Colors.grey[700],
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _selectedStock!.symbol,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _tradeType == 'buy' 
                            ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                            : [const Color(0xFFE53E3E), const Color(0xFFD53F3F)],
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _tradeType.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                _selectedStock!.name,
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        _buildDetailRow('Shares', '$_shares'),
        _buildDetailRow('Price per Share', CurrencySymbols.formatAmountWithCurrency(_amount / _shares, _selectedStock?.currency ?? 'USD')),
        _buildDetailRow('Subtotal', CurrencySymbols.formatAmountWithCurrency(_amount, _selectedStock?.currency ?? 'USD')),
        _buildDetailRow('Trading Fees', CurrencySymbols.formatAmountWithCurrency(_fees, _selectedStock?.currency ?? 'USD')),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                CurrencySymbols.formatAmountWithCurrency(_total, _selectedStock?.currency ?? 'USD'),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        _buildDetailRow('Payment Method', _getPaymentMethodName()),
        if (_paymentDetails.isNotEmpty) ...[
          _buildDetailRow('Account', _getAccountDetails()),
        ],
        _buildDetailRow('Status', 'Completed'),
      ],
    );
  }

  Widget _buildTransactionInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction Information',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        _buildDetailRow('Transaction ID', _transactionId),
        _buildDetailRow('Date & Time', _formatDateTime(_transactionDate)),
        _buildDetailRow('Order Type', 'Market Order'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A3E),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
            ),
            child: ElevatedButton.icon(
              onPressed: _downloadReceipt,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              icon: Icon(
                Icons.download,
                color: Colors.white,
                size: 20.sp,
              ),
              label: Text(
                'Download',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4A90E2),
                  const Color(0xFF357ABD),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ElevatedButton.icon(
              onPressed: _shareReceipt,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              icon: Icon(
                Icons.share,
                color: Colors.white,
                size: 20.sp,
              ),
              label: Text(
                'Share',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4CAF50),
                  const Color(0xFF45A049),
                ],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _goToPortfolio,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                'View Portfolio',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A3E),
              borderRadius: BorderRadius.circular(16.r),            ),
            child: ElevatedButton(
              onPressed: _goToHome,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                'Back to Home',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPaymentMethodName() {
    switch (_paymentMethod) {
      case 'account':
        return 'Bank Account';
      case 'crypto':
        return 'Cryptocurrency';
      case 'international':
        return 'International Wallet';
      default:
        return 'Bank Account';
    }
  }

  String _getAccountDetails() {
    if (_paymentDetails.isEmpty) return 'N/A';
    
    switch (_paymentMethod) {
      case 'account':
        return _paymentDetails['name'] ?? 'Personal Account';
      case 'crypto':
        return '${_paymentDetails['name'] ?? 'Crypto Wallet'} (${_paymentDetails['symbol'] ?? 'BTC'})';
      case 'international':
        return '${_paymentDetails['name'] ?? 'International Wallet'} (${_paymentDetails['currency'] ?? 'USD'})';
      default:
        return 'Personal Account';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
} 