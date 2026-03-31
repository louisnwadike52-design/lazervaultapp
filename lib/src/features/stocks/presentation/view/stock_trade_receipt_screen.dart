import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/investments/presentation/models/invest_asset_hub_config.dart';
import 'package:lazervault/src/features/investments/presentation/navigation/invest_route_args.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';

import '../../domain/entities/stock_entity.dart';

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
  String? _investCollectionId;
  late Color _hubAccent;

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
    _investCollectionId = args['investCollection'] as String?;
    _hubAccent = InvestAssetHubConfig.forCollectionId(_investCollectionId)
        .accentColor;
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
        backgroundColor: _hubAccent,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _downloadReceipt() {
    // TODO: Implement download functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Receipt downloaded successfully'),
        backgroundColor: InvestTradingUi.buy,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _goToHome() {
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void _goToPortfolio() {
    Get.offAllNamed(
      AppRoutes.stockPortfolio,
      arguments: InvestRouteArgs.hub(_investCollectionId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvestTradingUi.background,
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: InvestTradingUi.scaffoldGradient),
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
            decoration: InvestTradingUi.cardDecoration(
              color: InvestTradingUi.surfaceElevated,
            ),
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.close_rounded,
                color: InvestTradingUi.textPrimary,
                size: 22.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Receipt',
              style: GoogleFonts.inter(
                color: InvestTradingUi.textPrimary,
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: InvestTradingUi.cardDecoration(
              color: InvestTradingUi.surfaceElevated,
            ),
            child: IconButton(
              onPressed: _shareReceipt,
              icon: Icon(
                Icons.ios_share_rounded,
                color: InvestTradingUi.textPrimary,
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
        color: InvestTradingUi.buy.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: InvestTradingUi.buy.withValues(alpha: 0.45),
          width: 2,
        ),
      ),
      child: Icon(
        Icons.check_rounded,
        color: InvestTradingUi.buy,
        size: 50.sp,
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Column(
      children: [
        Text(
          'All set',
          style: GoogleFonts.inter(
            color: InvestTradingUi.textPrimary,
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'Your ${_tradeType.toUpperCase()} order has settled',
          style: GoogleFonts.inter(
            color: InvestTradingUi.textSecondary,
            fontSize: 15.sp,
            height: 1.35,
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
        color: InvestTradingUi.surfaceElevated,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
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
          Divider(color: InvestTradingUi.border),
          SizedBox(height: 20.h),
          _buildPaymentDetails(),
          SizedBox(height: 20.h),
          Divider(color: InvestTradingUi.border),
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
                      color: InvestTradingUi.textPrimary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: _tradeType == 'buy'
                          ? InvestTradingUi.buy
                          : InvestTradingUi.sell,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      _tradeType.toUpperCase(),
                      style: GoogleFonts.inter(
                        color: _tradeType == 'buy'
                            ? Colors.black
                            : Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                _selectedStock!.name,
                style: GoogleFonts.inter(
                  color: InvestTradingUi.textSecondary,
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
          'Transaction details',
          style: GoogleFonts.inter(
            color: InvestTradingUi.textPrimary,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16.h),
        _buildDetailRow('Shares', '$_shares'),
        _buildDetailRow(
          'Price / share',
          _shares > 0
              ? CurrencySymbols.formatAmountWithCurrency(
                  _amount / _shares, _selectedStock?.currency ?? 'USD')
              : '—',
        ),
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
                'Total',
                style: GoogleFonts.inter(
                  color: InvestTradingUi.textPrimary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                CurrencySymbols.formatAmountWithCurrency(
                    _total, _selectedStock?.currency ?? 'USD'),
                style: GoogleFonts.inter(
                  color: InvestTradingUi.textPrimary,
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
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
          'Payment',
          style: GoogleFonts.inter(
            color: InvestTradingUi.textPrimary,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
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
          'Reference',
          style: GoogleFonts.inter(
            color: InvestTradingUi.textPrimary,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
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
                color: InvestTradingUi.textSecondary,
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: InvestTradingUi.textPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
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
          child: OutlinedButton.icon(
            onPressed: _downloadReceipt,
            style: OutlinedButton.styleFrom(
              foregroundColor: InvestTradingUi.textPrimary,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            icon: Icon(Icons.download_rounded, size: 20.sp),
            label: Text(
              'Download',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: FilledButton.icon(
            onPressed: _shareReceipt,
            style: FilledButton.styleFrom(
              backgroundColor: _hubAccent,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            icon: Icon(Icons.ios_share_rounded, size: 20.sp),
            label: Text(
              'Share',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
      decoration: InvestTradingUi.bottomBarDecoration,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _goToPortfolio,
              style: FilledButton.styleFrom(
                backgroundColor: InvestTradingUi.buy,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                'View portfolio',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _goToHome,
              style: OutlinedButton.styleFrom(
                foregroundColor: InvestTradingUi.textPrimary,
                side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                'Home',
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
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