import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'crypto_confirmation_screen.dart';
import 'crypto_transaction_history_screen.dart';

class CryptoReceiptScreen extends StatefulWidget {
  final CryptoTransactionReceipt receipt;

  const CryptoReceiptScreen({
    super.key,
    required this.receipt,
  });

  @override
  State<CryptoReceiptScreen> createState() => _CryptoReceiptScreenState();
}

class _CryptoReceiptScreenState extends State<CryptoReceiptScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.w),
                  child: AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              _buildSuccessHeader(),
                              SizedBox(height: 32.h),
                              _buildReceiptCard(),
                              SizedBox(height: 24.h),
                              _buildActionButtons(),
                              SizedBox(height: 24.h),
                              _buildTransactionDetails(),
                              SizedBox(height: 24.h),
                              _buildSecurityInfo(),
                              SizedBox(height: 32.h),
                              _buildNavigationButtons(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
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
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: _shareReceipt,
              child: Icon(
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

  Widget _buildSuccessHeader() {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withOpacity(0.2),
            Colors.green.withOpacity(0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
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
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              size: 48.sp,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Transaction Successful!',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _getSuccessMessage(),
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Receipt',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  widget.receipt.status.name.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildReceiptRow('Transaction ID', widget.receipt.transactionId, canCopy: true),
          SizedBox(height: 16.h),
          _buildReceiptRow('Date & Time', _formatDateTime(widget.receipt.timestamp)),
          SizedBox(height: 16.h),
          _buildReceiptRow('Transaction Type', _getTransactionTypeDisplay()),
          SizedBox(height: 16.h),
          _buildReceiptRow('Cryptocurrency', widget.receipt.transactionDetails.cryptoName),
          SizedBox(height: 16.h),
          _buildReceiptRow('Amount', '${widget.receipt.transactionDetails.cryptoAmount} ${widget.receipt.transactionDetails.cryptoSymbol}'),
          SizedBox(height: 16.h),
          _buildReceiptRow('Price per ${widget.receipt.transactionDetails.cryptoSymbol}', '£${widget.receipt.transactionDetails.pricePerUnit.toStringAsFixed(2)}'),
          SizedBox(height: 16.h),
          _buildReceiptRow('Subtotal', '£${widget.receipt.transactionDetails.gbpAmount.toStringAsFixed(2)}'),
          SizedBox(height: 16.h),
          _buildReceiptRow('Trading Fee', '£${widget.receipt.transactionDetails.tradingFee.toStringAsFixed(2)}'),
          SizedBox(height: 16.h),
          _buildReceiptRow('Network Fee', '£${widget.receipt.transactionDetails.networkFee.toStringAsFixed(2)}'),
          Divider(color: Colors.white.withOpacity(0.2), height: 32.h),
          _buildReceiptRow('Total Amount', '£${widget.receipt.transactionDetails.totalAmount.toStringAsFixed(2)}', isTotal: true),
          SizedBox(height: 16.h),
          _buildReceiptRow('Payment Method', widget.receipt.transactionDetails.paymentMethod),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _downloadReceipt,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.2),
              foregroundColor: const Color(0xFF6C5CE7),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: const Color(0xFF6C5CE7).withOpacity(0.3)),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Download',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            onPressed: _shareReceipt,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.share, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Share',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionDetails() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
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
            'Transaction Details',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Executed at', '${_formatDateTime(widget.receipt.timestamp)}'),
          SizedBox(height: 12.h),
          _buildDetailRow('Settlement', 'Instant'),
          SizedBox(height: 12.h),
          _buildDetailRow('Blockchain Network', _getBlockchainNetwork()),
          SizedBox(height: 12.h),
          _buildDetailRow('Exchange Rate', '1 ${widget.receipt.transactionDetails.cryptoSymbol} = £${widget.receipt.transactionDetails.pricePerUnit.toStringAsFixed(2)}'),
          if (widget.receipt.transactionDetails.type == CryptoTransactionType.buy) ...[
            SizedBox(height: 12.h),
            _buildDetailRow('Wallet Address', '1A2B3C...XYZ789', canCopy: true),
          ],
        ],
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
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
                'Security & Compliance',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSecurityFeature('Transaction secured with 256-bit SSL encryption'),
          SizedBox(height: 8.h),
          _buildSecurityFeature('Funds stored in cold storage wallet'),
          SizedBox(height: 8.h),
          _buildSecurityFeature('LazerVault is FCA regulated and authorized'),
          SizedBox(height: 8.h),
          _buildSecurityFeature('Transaction recorded on blockchain'),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Get.to(() => const CryptoTransactionHistoryScreen()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'View Transaction History',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Get.offAllNamed('/crypto'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              side: BorderSide(color: Colors.white.withOpacity(0.3)),
            ),
            child: Text(
              'Back to Crypto',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptRow(String label, String value, {bool canCopy = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
            color: Colors.white.withOpacity(isTotal ? 1.0 : 0.8),
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: isTotal ? 18.sp : 14.sp,
                fontWeight: FontWeight.w600,
                color: isTotal ? const Color(0xFF6C5CE7) : Colors.white,
              ),
            ),
            if (canCopy) ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => _copyToClipboard(value),
                child: Icon(
                  Icons.copy,
                  size: 16.sp,
                  color: const Color(0xFF6C5CE7),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool canCopy = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            if (canCopy) ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () => _copyToClipboard(value),
                child: Icon(
                  Icons.copy,
                  size: 14.sp,
                  color: const Color(0xFF6C5CE7),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildSecurityFeature(String text) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 16.sp,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (widget.receipt.status) {
      case CryptoTransactionStatus.completed:
        return Colors.green;
      case CryptoTransactionStatus.pending:
        return Colors.orange;
      case CryptoTransactionStatus.failed:
        return Colors.red;
    }
  }

  String _getSuccessMessage() {
    switch (widget.receipt.transactionDetails.type) {
      case CryptoTransactionType.buy:
        return 'You have successfully purchased ${widget.receipt.transactionDetails.cryptoAmount} ${widget.receipt.transactionDetails.cryptoSymbol}';
      case CryptoTransactionType.sell:
        return 'You have successfully sold ${widget.receipt.transactionDetails.cryptoAmount} ${widget.receipt.transactionDetails.cryptoSymbol}';
      case CryptoTransactionType.swap:
        return 'You have successfully swapped ${widget.receipt.transactionDetails.fromCrypto} for ${widget.receipt.transactionDetails.toCrypto}';
    }
  }

  String _getTransactionTypeDisplay() {
    switch (widget.receipt.transactionDetails.type) {
      case CryptoTransactionType.buy:
        return 'Buy ${widget.receipt.transactionDetails.cryptoSymbol}';
      case CryptoTransactionType.sell:
        return 'Sell ${widget.receipt.transactionDetails.cryptoSymbol}';
      case CryptoTransactionType.swap:
        return 'Swap ${widget.receipt.transactionDetails.fromCrypto} → ${widget.receipt.transactionDetails.toCrypto}';
    }
  }

  String _getBlockchainNetwork() {
    final symbol = widget.receipt.transactionDetails.cryptoSymbol.toUpperCase();
    switch (symbol) {
      case 'BTC':
        return 'Bitcoin Network';
      case 'ETH':
        return 'Ethereum Network';
      case 'BNB':
        return 'Binance Smart Chain';
      case 'SOL':
        return 'Solana Network';
      default:
        return 'Ethereum Network (ERC-20)';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      'Copied',
      'Copied to clipboard',
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
      duration: const Duration(seconds: 2),
    );
  }

  void _shareReceipt() {
    final receiptText = '''
LazerVault Crypto Transaction Receipt

Transaction ID: ${widget.receipt.transactionId}
Date: ${_formatDateTime(widget.receipt.timestamp)}
Type: ${_getTransactionTypeDisplay()}
Amount: ${widget.receipt.transactionDetails.cryptoAmount} ${widget.receipt.transactionDetails.cryptoSymbol}
Total: £${widget.receipt.transactionDetails.totalAmount.toStringAsFixed(2)}
Status: ${widget.receipt.status.name.toUpperCase()}

Powered by LazerVault - Your trusted crypto platform
''';

    Share.share(receiptText, subject: 'LazerVault Transaction Receipt');
  }

  void _downloadReceipt() {
    // In a real implementation, this would generate a PDF or save the receipt
    Get.snackbar(
      'Download',
      'Receipt saved to Downloads',
      backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.1),
      colorText: const Color(0xFF6C5CE7),
      duration: const Duration(seconds: 3),
    );
  }
}

// Transaction receipt model
class CryptoTransactionReceipt {
  final String transactionId;
  final CryptoTransactionDetails transactionDetails;
  final DateTime timestamp;
  final CryptoTransactionStatus status;

  const CryptoTransactionReceipt({
    required this.transactionId,
    required this.transactionDetails,
    required this.timestamp,
    required this.status,
  });
}

enum CryptoTransactionStatus { completed, pending, failed } 