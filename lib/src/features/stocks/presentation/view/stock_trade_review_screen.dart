import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../domain/entities/stock_entity.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

class StockTradeReviewScreen extends StatefulWidget {
  const StockTradeReviewScreen({super.key});

  @override
  State<StockTradeReviewScreen> createState() => _StockTradeReviewScreenState();
}

class _StockTradeReviewScreenState extends State<StockTradeReviewScreen>
    with TickerProviderStateMixin, TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();
  late AnimationController _animationController;
  late AnimationController _processingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotationAnimation;
  
  Stock? _selectedStock;
  String _tradeType = 'buy';
  double _amount = 0.0;
  int _shares = 0;
  double _fees = 0.0;
  double _estimatedTotal = 0.0;
  String _paymentMethod = '';

  Map<String, dynamic> _paymentDetails = {};
  
  bool _isProcessing = false;
  bool _isCompleted = false;
  String _transactionId = '';

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
    _estimatedTotal = args['estimatedTotal'] ?? 0.0;
    _paymentMethod = args['paymentMethod'] ?? '';
    _paymentDetails = args['paymentDetails'] ?? {};
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _processingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _processingController, curve: Curves.linear),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _processingController.dispose();
    super.dispose();
  }

  void _processTrade() async {
    // Generate unique transaction ID
    final transactionId = 'stock_${_tradeType}_${DateTime.now().millisecondsSinceEpoch}_${_selectedStock?.symbol}';

    // Validate PIN before processing stock trade
    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'stock_trade',
      amount: _estimatedTotal,
      currency: 'USD',
      title: 'Confirm ${_tradeType == 'buy' ? 'Buy' : 'Sell'} Order',
      message: 'Confirm $_tradeType of $_shares shares of ${_selectedStock?.symbol ?? 'stock'} for ${CurrencySymbols.formatAmountWithCurrency(_estimatedTotal, _selectedStock?.currency ?? 'USD')}?',
      onPinValidated: (verificationToken) async {
        // PIN is valid, proceed with trade processing
        _executeTradeWithToken(transactionId, verificationToken);
      },
    );

    if (!success) {
      // PIN validation failed or was cancelled
      // User has already been notified via the mixin
    }
  }

  /// Execute stock trade with verification token
  void _executeTradeWithToken(String transactionId, String verificationToken) async {
    setState(() {
      _isProcessing = true;
    });

    _processingController.repeat();

    // Simulate processing time (in real implementation, this would call your backend API with verification token)
    await Future.delayed(const Duration(seconds: 3));

    _processingController.stop();

    setState(() {
      _isProcessing = false;
      _isCompleted = true;
      _transactionId = transactionId;
    });

    // TODO: In production, call your stock trade API with verification token
    // The verification token should be included in the API call for backend validation
  }

  void _goToHome() {
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void _viewReceipt() {
    Get.toNamed(AppRoutes.stockTradeReceipt, arguments: {
      'stock': _selectedStock,
      'tradeType': _tradeType,
      'amount': _amount,
      'shares': _shares,
      'fees': _fees,
      'total': _estimatedTotal,
      'transactionId': _transactionId,
      'transactionDate': DateTime.now(),
      'paymentMethod': _paymentMethod,
      'paymentDetails': _paymentDetails,
    });
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
                child: AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _isCompleted 
                            ? _buildSuccessScreen()
                            : _isProcessing 
                                ? _buildProcessingScreen()
                                : _buildReviewScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      child: Row(
        children: [
          if (!_isProcessing && !_isCompleted)
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
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          if (!_isProcessing && !_isCompleted) SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isCompleted 
                      ? 'Trade Successful!'
                      : _isProcessing 
                          ? 'Processing Trade...'
                          : 'Review Trade',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (!_isCompleted)
                  Text(
                    _isProcessing 
                        ? 'Please wait while we process your trade'
                        : 'Confirm your trade details',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildTradeDetailsCard(),
          SizedBox(height: 24.h),
          _buildPaymentDetailsCard(),
          SizedBox(height: 24.h),
          _buildSummaryCard(),
          SizedBox(height: 32.h),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildProcessingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value * 2 * 3.14159,
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Icon(
                    Icons.trending_up,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 32.h),
          Text(
            'Processing Your Trade',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Please wait while we execute your $_tradeType order\nfor ${_selectedStock?.symbol ?? 'stock'}',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            width: 200.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.teal],
              ),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 50.sp,
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            'Trade Executed Successfully!',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Your $_tradeType order for $_shares shares of ${_selectedStock?.symbol ?? 'stock'} has been completed.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 32.h),
          _buildSuccessDetailsCard(),
          SizedBox(height: 32.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _viewReceipt,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'View Receipt',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _goToHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Done',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTradeDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A5E),
            const Color(0xFF1A1A3E),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trade Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    _selectedStock?.symbol.substring(0, 2) ?? 'ST',
                    style: GoogleFonts.inter(
                      color: Colors.blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedStock?.symbol ?? 'Stock',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _selectedStock?.name ?? 'Stock Name',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _selectedStock != null ? CurrencySymbols.formatAmountWithCurrency(_selectedStock!.currentPrice, _selectedStock!.currency) : '0.00',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Current Price',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildDetailRow('Order Type', _tradeType.capitalizeFirst ?? _tradeType),
          _buildDetailRow('Shares', _shares.toString()),
          _buildDetailRow('Amount', CurrencySymbols.formatAmountWithCurrency(_amount, _selectedStock?.currency ?? 'USD')),
          _buildDetailRow('Trading Fee', CurrencySymbols.formatAmountWithCurrency(_fees, _selectedStock?.currency ?? 'USD')),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: _getPaymentMethodColor().withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  _getPaymentMethodIcon(),
                  color: _getPaymentMethodColor(),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getPaymentMethodName(),
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _getPaymentMethodDetails(),
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow('Trade Amount', CurrencySymbols.formatAmountWithCurrency(_amount, _selectedStock?.currency ?? 'USD')),
          _buildSummaryRow('Trading Fee', CurrencySymbols.formatAmountWithCurrency(_fees, _selectedStock?.currency ?? 'USD')),
          Divider(color: Colors.grey[700], height: 24.h),
          _buildSummaryRow(
            'Total ${_tradeType == 'buy' ? 'Cost' : 'Proceeds'}',
            CurrencySymbols.formatAmountWithCurrency(_estimatedTotal, _selectedStock?.currency ?? 'USD'),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessDetailsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withValues(alpha: 0.2),
            Colors.teal.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        children: [
          _buildDetailRow('Transaction ID', _transactionId),
          _buildDetailRow('Stock', _selectedStock?.symbol ?? 'N/A'),
          _buildDetailRow('Shares', _shares.toString()),
          _buildDetailRow('Total Amount', CurrencySymbols.formatAmountWithCurrency(_estimatedTotal, _selectedStock?.currency ?? 'USD')),
          _buildDetailRow('Status', 'Completed'),
          _buildDetailRow('Date', DateTime.now().toString().split(' ')[0]),
        ],
      ),
    );
  }



  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: isTotal ? Colors.white : Colors.grey[400],
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _processTrade,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Confirm Trade',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Color _getPaymentMethodColor() {
    switch (_paymentMethod) {
      case 'account':
        return Colors.blue;
      case 'crypto':
        return Colors.orange;
      case 'international':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  IconData _getPaymentMethodIcon() {
    switch (_paymentMethod) {
      case 'account':
        return Icons.account_balance;
      case 'crypto':
        return Icons.currency_bitcoin;
      case 'international':
        return Icons.account_balance_wallet;
      default:
        return Icons.account_balance;
    }
  }

  String _getPaymentMethodName() {
    if (_paymentDetails.isEmpty) return 'Payment Method';
    
    switch (_paymentMethod) {
      case 'account':
        return _paymentDetails['name'] ?? 'Account';
      case 'crypto':
        return _paymentDetails['name'] ?? 'Crypto Wallet';
      case 'international':
        return _paymentDetails['name'] ?? 'International Wallet';
      default:
        return 'Payment Method';
    }
  }

  String _getPaymentMethodDetails() {
    if (_paymentDetails.isEmpty) return '';
    
    switch (_paymentMethod) {
      case 'account':
        return '${_paymentDetails['type']} ${_paymentDetails['accountNumber']}';
      case 'crypto':
        return '${_paymentDetails['balance']} ${_paymentDetails['symbol']}';
      case 'international':
        return '${_paymentDetails['balance']} ${_paymentDetails['currency']}';
      default:
        return '';
    }
  }
} 