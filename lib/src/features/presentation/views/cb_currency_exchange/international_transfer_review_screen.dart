import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lazervault/core/types/app_routes.dart';

class InternationalTransferReviewScreen extends StatefulWidget {
  const InternationalTransferReviewScreen({super.key});

  @override
  State<InternationalTransferReviewScreen> createState() =>
      _InternationalTransferReviewScreenState();
}

class _InternationalTransferReviewScreenState extends State<InternationalTransferReviewScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _processingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotationAnimation;
  
  String _fromCurrency = '';
  String _toCurrency = '';
  Map<String, dynamic> _fromCurrencyData = {};
  Map<String, dynamic> _toCurrencyData = {};
  double _amount = 0.0;
  double _convertedAmount = 0.0;
  double _exchangeRate = 0.0;
  double _fees = 0.0;
  Map<String, dynamic> _recipient = {};
  
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
    final args = Get.arguments as Map<String, dynamic>;
    _fromCurrency = args['fromCurrency'] ?? 'GBP';
    _toCurrency = args['toCurrency'] ?? 'USD';
    _fromCurrencyData = args['fromCurrencyData'] ?? {};
    _toCurrencyData = args['toCurrencyData'] ?? {};
    _amount = args['amount'] ?? 0.0;
    _convertedAmount = args['convertedAmount'] ?? 0.0;
    _exchangeRate = args['exchangeRate'] ?? 0.0;
    _fees = args['fees'] ?? 0.0;
    _recipient = args['recipient'] ?? {};
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

  void _processTransfer() async {
    setState(() {
      _isProcessing = true;
    });
    
    _processingController.repeat();
    
    // Simulate processing time
    await Future.delayed(const Duration(seconds: 3));
    
    _processingController.stop();
    
    setState(() {
      _isProcessing = false;
      _isCompleted = true;
      _transactionId = 'TXN${DateTime.now().millisecondsSinceEpoch}';
    });
  }

  void _goToHome() {
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void _viewReceipt() {
    // Navigate to receipt screen or show receipt bottom sheet
    _showReceiptBottomSheet();
  }

  void _showReceiptBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: _buildReceiptContent(),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
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
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final currentStep = args['currentStep'] ?? 4;
    final totalSteps = args['totalSteps'] ?? 4;
    final stepTitle = args['stepTitle'] ?? 'Review Transfer';
    final isRepeatTransaction = args['isRepeatTransaction'] ?? false;
    
    return Container(
      padding: EdgeInsets.all(16.w),
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
                      ? 'Transfer Complete!'
                      : _isProcessing 
                          ? 'Processing Transfer...'
                          : stepTitle,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (!_isCompleted)
                  Text(
                    _isProcessing 
                        ? 'Please wait while we process your transfer'
                        : isRepeatTransaction
                            ? 'Step $currentStep of $totalSteps - Repeat previous transfer'
                            : 'Step $currentStep of $totalSteps - Confirm your transfer',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          if (!_isProcessing && !_isCompleted)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                '$currentStep/$totalSteps',
                style: GoogleFonts.inter(
                  color: Colors.blue,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReviewScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24.h),
          _buildTransferSummaryCard(),
          SizedBox(height: 24.h),
          _buildRecipientCard(),
          SizedBox(height: 24.h),
          _buildTransactionDetails(),
          SizedBox(height: 32.h),
          _buildConfirmButton(),
          SizedBox(height: 24.h),
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
                      colors: [Colors.blue[700]!, Colors.blue[500]!],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.sync,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 32.h),
          Text(
            'Processing your transfer...',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'This may take a few moments',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32.w),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[800],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[700]!, Colors.green[500]!],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 50.sp,
            ),
          ),
          SizedBox(height: 32.h),
          Text(
            'Transfer Successful!',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Your money is on its way to ${_recipient['name']}',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          _buildSuccessDetails(),
          SizedBox(height: 32.h),
          _buildSuccessActions(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildTransferSummaryCard() {
    final totalDeducted = _amount + _fees;
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.2),
            Colors.purple.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Send Section
          _buildAmountSection(
            title: 'You Send',
            amount: _amount,
            currency: _fromCurrency,
            currencyData: _fromCurrencyData,
            alignment: CrossAxisAlignment.start,
          ),
          
          SizedBox(height: 20.h),
          
          // Arrow Icon
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_downward_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          
          SizedBox(height: 20.h),
          
          // Receive Section
          _buildAmountSection(
            title: 'They Receive',
            amount: _convertedAmount,
            currency: _toCurrency,
            currencyData: _toCurrencyData,
            alignment: CrossAxisAlignment.end,
          ),
          
          SizedBox(height: 24.h),
          
          // Total Deducted Section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total deducted from your account',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  child: Text(
                    '${_fromCurrencyData['symbol']}${totalDeducted.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection({
    required String title,
    required double amount,
    required String currency,
    required Map<String, dynamic> currencyData,
    required CrossAxisAlignment alignment,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: alignment == CrossAxisAlignment.start 
                ? MainAxisAlignment.start 
                : MainAxisAlignment.end,
            children: [
              if (alignment == CrossAxisAlignment.start) ...[
                _buildCurrencyFlag(currency, size: 28),
                SizedBox(width: 12.w),
              ],
              Flexible(
                child: Text(
                  '${currencyData['symbol']}${amount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: alignment == CrossAxisAlignment.start 
                      ? TextAlign.start 
                      : TextAlign.end,
                ),
              ),
              if (alignment == CrossAxisAlignment.end) ...[
                SizedBox(width: 12.w),
                _buildCurrencyFlag(currency, size: 28),
              ],
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              currency,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipient Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: _recipient['avatar'] ?? '',
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue[700]!, Colors.blue[500]!],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          (_recipient['name'] ?? 'U')[0].toUpperCase(),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
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
                    Text(
                      _recipient['name'] ?? 'Unknown',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${_recipient['bank']} • ${_recipient['account']}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _recipient['country'] ?? 'Unknown',
                      style: GoogleFonts.inter(
                        color: Colors.grey[500],
                        fontSize: 10.sp,
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

  Widget _buildTransactionDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Exchange Rate', '1 $_fromCurrency = ${_exchangeRate.toStringAsFixed(4)} $_toCurrency'),
          _buildDetailRow('Transfer Fee', '${_fromCurrencyData['symbol']}${_fees.toStringAsFixed(2)}'),
          _buildDetailRow('Estimated Arrival', '1-3 business days'),
          _buildDetailRow('Transfer Method', 'Bank Transfer'),
          Divider(color: Colors.white.withValues(alpha: 0.2), height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Cost',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${_fromCurrencyData['symbol']}${(_amount + _fees).toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue[700]!, Colors.blue[500]!]),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _processTransfer,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.security, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Confirm & Send',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withValues(alpha: 0.15),
            Colors.blue.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          _buildSuccessDetailRow('Transaction ID', _transactionId),
          _buildSuccessDetailRow('Amount Sent', '${_fromCurrencyData['symbol']}${_amount.toStringAsFixed(2)} $_fromCurrency'),
          _buildSuccessDetailRow('Amount Received', '${_toCurrencyData['symbol']}${_convertedAmount.toStringAsFixed(2)} $_toCurrency'),
          _buildSuccessDetailRow('Recipient', _recipient['name'] ?? 'Unknown'),
          _buildSuccessDetailRow('Estimated Arrival', '1-3 business days'),
        ],
      ),
    );
  }

  Widget _buildSuccessDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue[700]!, Colors.blue[500]!]),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _viewReceipt,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long, color: Colors.white, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'View Receipt',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _goToHome,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                padding: EdgeInsets.symmetric(vertical: 18.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
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

  Widget _buildReceiptContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Transfer Receipt',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 32.h),
        _buildReceiptSection('Transaction Details', [
          _buildReceiptRow('Transaction ID', _transactionId),
          _buildReceiptRow('Date', DateTime.now().toString().split(' ')[0]),
          _buildReceiptRow('Time', TimeOfDay.now().format(context)),
          _buildReceiptRow('Status', 'Completed'),
        ]),
        SizedBox(height: 24.h),
        _buildReceiptSection('Transfer Information', [
          _buildReceiptRow('From Currency', '$_fromCurrency (${_fromCurrencyData['name']})'),
          _buildReceiptRow('To Currency', '$_toCurrency (${_toCurrencyData['name']})'),
          _buildReceiptRow('Exchange Rate', '1 $_fromCurrency = ${_exchangeRate.toStringAsFixed(4)} $_toCurrency'),
          _buildReceiptRow('Amount Sent', '${_fromCurrencyData['symbol']}${_amount.toStringAsFixed(2)}'),
          _buildReceiptRow('Transfer Fee', '${_fromCurrencyData['symbol']}${_fees.toStringAsFixed(2)}'),
          _buildReceiptRow('Total Deducted', '${_fromCurrencyData['symbol']}${(_amount + _fees).toStringAsFixed(2)}'),
          _buildReceiptRow('Amount Received', '${_toCurrencyData['symbol']}${_convertedAmount.toStringAsFixed(2)}'),
        ]),
        SizedBox(height: 24.h),
        _buildReceiptSection('Recipient Information', [
          _buildReceiptRow('Name', _recipient['name'] ?? 'Unknown'),
          _buildReceiptRow('Bank', _recipient['bank'] ?? 'Unknown'),
          _buildReceiptRow('Account', _recipient['fullAccount'] ?? 'Unknown'),
          _buildReceiptRow('SWIFT Code', _recipient['swift'] ?? 'Unknown'),
          _buildReceiptRow('Country', _recipient['country'] ?? 'Unknown'),
        ]),
        SizedBox(height: 32.h),
        Center(
          child: Text(
            'Thank you for using LazerVault',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.7),
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
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyFlag(String currencyCode, {double size = 24}) {
    final flagUrl = _fromCurrency == currencyCode 
        ? _fromCurrencyData['flag'] 
        : _toCurrencyData['flag'];
    
    return Container(
      width: size,
      height: size * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.r),
        child: CachedNetworkImage(
          imageUrl: flagUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: size * 0.5, color: Colors.grey[600]),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: size * 0.5, color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }
} 