import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import 'crypto_receipt_screen.dart';

class CryptoConfirmationScreen extends StatefulWidget {
  final CryptoTransactionDetails transactionDetails;

  const CryptoConfirmationScreen({
    super.key,
    required this.transactionDetails,
  });

  @override
  State<CryptoConfirmationScreen> createState() => _CryptoConfirmationScreenState();
}

class _CryptoConfirmationScreenState extends State<CryptoConfirmationScreen>
    with TickerProviderStateMixin, TransactionPinMixin {
  late AnimationController _animationController;
  late AnimationController _processingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotationAnimation;

  bool _isProcessing = false;
  bool _isCompleted = false;
  String _transactionId = '';

  // Rate countdown
  int _rateCountdown = 30;
  Timer? _countdownTimer;

  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startRateCountdown();
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

  void _startRateCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_rateCountdown > 0) {
          _rateCountdown--;
        } else {
          timer.cancel();
          // Rate expired - could refresh rate here
        }
      });
    });
  }

  void _resetRateCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _rateCountdown = 30;
    });
    _startRateCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _animationController.dispose();
    _processingController.dispose();
    super.dispose();
  }

  void _processTransaction() async {
    if (_rateCountdown <= 0) {
      // Rate expired, refresh
      _resetRateCountdown();
      Get.snackbar(
        'Rate Expired',
        'Exchange rate has been refreshed. Please confirm again.',
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final details = widget.transactionDetails;
    final success = await validateTransactionPin(
      context: context,
      transactionId: 'CRYPTO-${DateTime.now().millisecondsSinceEpoch}',
      transactionType: details.type.name,
      amount: details.fiatAmount,
      currency: CurrencySymbols.currentCurrency,
      currencySymbol: CurrencySymbols.currentSymbol,
      fee: details.networkFee + details.tradingFee,
      totalAmount: details.totalAmount,
      onPinValidated: (verificationToken) async {
        // PIN validated - now show processing screen
        if (mounted) {
          setState(() {
            _isProcessing = true;
          });
          _processingController.repeat();
        }

        // Simulate backend trade execution
        await Future.delayed(const Duration(seconds: 3));

        _processingController.stop();

        if (mounted) {
          setState(() {
            _isProcessing = false;
            _isCompleted = true;
            _transactionId = 'TXN${DateTime.now().millisecondsSinceEpoch}';
          });
        }

        // Navigate to receipt after brief success display
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) _viewReceipt();
      },
    );

    if (!success && mounted) {
      // PIN validation was cancelled or failed
      _resetRateCountdown();
    }
  }

  void _viewReceipt() {
    final receipt = CryptoTransactionReceipt(
      transactionId: _transactionId,
      transactionDetails: widget.transactionDetails,
      timestamp: DateTime.now(),
      status: CryptoTransactionStatus.completed,
    );
    
    Get.off(() => CryptoReceiptScreen(receipt: receipt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F1F1F),
              const Color(0xFF0A0A0A),
              const Color(0xFF0A0A0A),
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
                                : _buildConfirmationScreen(),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: _isProcessing ? null : () => Get.back(),
              child: Icon(
                Icons.arrow_back,
                color: _isProcessing ? Colors.grey : Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              _isCompleted 
                  ? 'Transaction Complete'
                  : _isProcessing 
                      ? 'Processing...'
                      : 'Confirm Transaction',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTransactionSummaryCard(),
          SizedBox(height: 24.h),
          _buildPaymentMethodCard(),
          SizedBox(height: 24.h),
          _buildSecurityCard(),
          SizedBox(height: 24.h),
          _buildImportantNotice(),
          SizedBox(height: 32.h),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildTransactionSummaryCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C5CE7).withValues(alpha: 0.1),
            const Color(0xFF1F1F1F),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: _getTransactionTypeColor().withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _getTransactionTypeIcon(),
                  color: _getTransactionTypeColor(),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getTransactionTypeTitle(),
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.transactionDetails.cryptoName,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildSummaryRow('Amount', widget.transactionDetails.cryptoAmount, widget.transactionDetails.cryptoSymbol),
          SizedBox(height: 12.h),
          _buildSummaryRow('Price per ${widget.transactionDetails.cryptoSymbol}', '${CurrencySymbols.currentSymbol}${widget.transactionDetails.pricePerUnit.toStringAsFixed(2)}', ''),
          SizedBox(height: 12.h),
          _buildSummaryRow('Total ${CurrencySymbols.currentCurrency}', '${CurrencySymbols.currentSymbol}${widget.transactionDetails.fiatAmount.toStringAsFixed(2)}', ''),
          SizedBox(height: 12.h),
          _buildSummaryRow('Network Fee', '${CurrencySymbols.currentSymbol}${widget.transactionDetails.networkFee.toStringAsFixed(2)}', ''),
          SizedBox(height: 12.h),
          _buildSummaryRow('LazerVault Fee', '${CurrencySymbols.currentSymbol}${widget.transactionDetails.tradingFee.toStringAsFixed(2)}', ''),
          Divider(color: Colors.white.withValues(alpha: 0.2), height: 24.h),
          _buildSummaryRow('Total', '${CurrencySymbols.currentSymbol}${widget.transactionDetails.totalAmount.toStringAsFixed(2)}', '', isTotal: true),
          SizedBox(height: 16.h),
          // Rate countdown indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: _rateCountdown > 10
                  ? Colors.green.withValues(alpha: 0.1)
                  : _rateCountdown > 0
                      ? Colors.orange.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.timer,
                  size: 16.sp,
                  color: _rateCountdown > 10
                      ? Colors.green
                      : _rateCountdown > 0
                          ? Colors.orange
                          : Colors.red,
                ),
                SizedBox(width: 8.w),
                Text(
                  _rateCountdown > 0
                      ? 'Rate valid for ${_rateCountdown}s'
                      : 'Rate expired - tap confirm to refresh',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: _rateCountdown > 10
                        ? Colors.green
                        : _rateCountdown > 0
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
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
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _getPaymentMethodIcon(),
                  color: const Color(0xFF6C5CE7),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.transactionDetails.paymentMethod,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _getPaymentMethodDetails(),
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.verified,
                color: Colors.green,
                size: 20.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
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
          Row(
            children: [
              Icon(
                Icons.security,
                color: Colors.green,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Security Features',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSecurityFeature('256-bit SSL Encryption', Icons.lock),
          SizedBox(height: 8.h),
          _buildSecurityFeature('Cold Storage Wallet', Icons.ac_unit),
          SizedBox(height: 8.h),
          _buildSecurityFeature('Multi-Signature Protection', Icons.verified_user),
          SizedBox(height: 8.h),
          _buildSecurityFeature('SEC Nigeria Licensed', Icons.gavel),
        ],
      ),
    );
  }

  Widget _buildSecurityFeature(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.green,
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildImportantNotice() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.orange,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Important Notice',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Cryptocurrency transactions are irreversible. Please review all details carefully before confirming.',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
              ],
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
        onPressed: _processTransaction,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getTransactionTypeColor(),
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Confirm ${_getTransactionTypeTitle()}',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(40.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              shape: BoxShape.circle,
            ),
            child: AnimatedBuilder(
              animation: _rotationAnimation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAnimation.value * 2 * 3.14159,
                  child: Icon(
                    Icons.sync,
                    size: 48.sp,
                    color: const Color(0xFF6C5CE7),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            'Processing Transaction',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Please do not close this screen',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 32.h),
          _buildProcessingSteps(),
        ],
      ),
    );
  }

  Widget _buildProcessingSteps() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildProcessingStep('Verifying payment', true),
          SizedBox(height: 12.h),
          _buildProcessingStep('Executing trade', true),
          SizedBox(height: 12.h),
          _buildProcessingStep('Updating wallet', false),
        ],
      ),
    );
  }

  Widget _buildProcessingStep(String text, bool isCompleted) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? Colors.green : Colors.grey,
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(40.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 64.sp,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            'Transaction Successful!',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Your ${widget.transactionDetails.type.name.toLowerCase()} order has been executed',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Transaction ID: $_transactionId',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF6C5CE7),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, String unit, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: Colors.white.withValues(alpha: isTotal ? 1.0 : 0.8),
          ),
        ),
        Text(
          '$value $unit',
          style: GoogleFonts.inter(
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: FontWeight.w600,
            color: isTotal ? const Color(0xFF6C5CE7) : Colors.white,
          ),
        ),
      ],
    );
  }

  Color _getTransactionTypeColor() {
    switch (widget.transactionDetails.type) {
      case CryptoTransactionType.buy:
        return Colors.green;
      case CryptoTransactionType.sell:
        return Colors.red;
      case CryptoTransactionType.swap:
        return const Color(0xFF6C5CE7);
    }
  }

  IconData _getTransactionTypeIcon() {
    switch (widget.transactionDetails.type) {
      case CryptoTransactionType.buy:
        return Icons.add_circle_outline;
      case CryptoTransactionType.sell:
        return Icons.remove_circle_outline;
      case CryptoTransactionType.swap:
        return Icons.swap_horiz;
    }
  }

  String _getTransactionTypeTitle() {
    switch (widget.transactionDetails.type) {
      case CryptoTransactionType.buy:
        return 'Buy Crypto';
      case CryptoTransactionType.sell:
        return 'Sell Crypto';
      case CryptoTransactionType.swap:
        return 'Swap Crypto';
    }
  }

  IconData _getPaymentMethodIcon() {
    switch (widget.transactionDetails.paymentMethod.toLowerCase()) {
      case 'card':
        return Icons.credit_card;
      case 'bank transfer':
        return Icons.account_balance;
      case 'apple pay':
        return Icons.apple;
      case 'google pay':
        return Icons.account_balance_wallet;
      default:
        return Icons.payment;
    }
  }

  String _getPaymentMethodDetails() {
    switch (widget.transactionDetails.paymentMethod.toLowerCase()) {
      case 'card':
        return 'Visa ending in 1234';
      case 'bank transfer':
        return 'Instant bank transfer';
      case 'apple pay':
        return 'Touch ID verification';
      case 'google pay':
        return 'Fingerprint verification';
      default:
        return 'Secure payment';
    }
  }
}

// Transaction details model
class CryptoTransactionDetails {
  final CryptoTransactionType type;
  final String cryptoName;
  final String cryptoSymbol;
  final String cryptoAmount;
  final double pricePerUnit;
  final double fiatAmount;
  final double networkFee;
  final double tradingFee;
  final double totalAmount;
  final String paymentMethod;
  final String? fromCrypto; // For swaps
  final String? toCrypto; // For swaps

  const CryptoTransactionDetails({
    required this.type,
    required this.cryptoName,
    required this.cryptoSymbol,
    required this.cryptoAmount,
    required this.pricePerUnit,
    required this.fiatAmount,
    required this.networkFee,
    required this.tradingFee,
    required this.totalAmount,
    required this.paymentMethod,
    this.fromCrypto,
    this.toCrypto,
  });
}

enum CryptoTransactionType { buy, sell, swap } 