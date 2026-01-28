import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../domain/entities/tagged_invoice_entity.dart';
import '../../domain/repositories/pay_invoice_repository.dart';

class TransactionReceiptScreen extends StatefulWidget {
  final TaggedInvoice invoice;
  final PaymentMethod paymentMethod;
  final String? selectedAccount;
  final String? selectedCrypto;

  const TransactionReceiptScreen({
    super.key,
    required this.invoice,
    required this.paymentMethod,
    this.selectedAccount,
    this.selectedCrypto,
  });

  @override
  State<TransactionReceiptScreen> createState() => _TransactionReceiptScreenState();
}

class _TransactionReceiptScreenState extends State<TransactionReceiptScreen>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  String? _transactionId;
  DateTime? _transactionDate;
  bool _isDownloading = false;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateTransactionDetails();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));
    
    _animationController.forward();
  }

  void _generateTransactionDetails() {
    _transactionDate = DateTime.now();
    _transactionId = _generateTransactionId();
  }

  String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final method = widget.paymentMethod.name.toUpperCase();
    return '${method}_${timestamp.substring(timestamp.length - 8)}';
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
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          _buildSuccessIcon(),
                          SizedBox(height: 32.h),
                          _buildReceiptCard(),
                          SizedBox(height: 24.h),
                          _buildActionButtons(),
                        ],
                      ),
                    ),
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
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment Receipt',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Transaction completed successfully',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        ),
        boxShadow: [
          BoxShadow(
            color: InvoiceThemeColors.successGreen.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
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

  Widget _buildReceiptCard() {
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
        borderRadius: BorderRadius.circular(20.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReceiptHeader(),
          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),
          _buildTransactionDetails(),
          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),
          _buildPaymentMethod(),
          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 24.h),
          _buildAmountBreakdown(),
          SizedBox(height: 24.h),
          _buildDivider(),
          SizedBox(height: 20.h),
          _buildReceiptFooter(),
        ],
      ),
    );
  }

  Widget _buildReceiptHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.receipt_long,
                color: InvoiceThemeColors.infoBlue,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'PAYMENT RECEIPT',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          'Invoice #${widget.invoice.invoiceNumber}',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: InvoiceThemeColors.infoBlue,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: InvoiceThemeColors.successGreen.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Text(
            'PAID',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: InvoiceThemeColors.successGreen,
              letterSpacing: 0.8,
            ),
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
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        _buildDetailRow('Transaction ID', _transactionId ?? 'N/A'),
        _buildDetailRow('Date & Time', _formatDateTime(_transactionDate)),
        _buildDetailRow('From', widget.invoice.fromUserName),
        _buildDetailRow('To', 'You'),
        _buildDetailRow('Status', 'Completed', isStatus: true),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    final methodInfo = _getPaymentMethodInfo();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
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
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: methodInfo['color'].withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: methodInfo['icon'] is IconData
                    ? Icon(
                        methodInfo['icon'],
                        color: methodInfo['color'],
                        size: 20.sp,
                      )
                    : Text(
                        methodInfo['icon'],
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: methodInfo['color'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      methodInfo['name'],
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (methodInfo['description'] != null)
                      Text(
                        methodInfo['description'],
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount Details',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16.h),
        _buildDetailRow('Subtotal', '£${widget.invoice.amount.toStringAsFixed(2)}'),
        if ((widget.invoice.taxAmount ?? 0) > 0)
          _buildDetailRow('Tax', '£${widget.invoice.taxAmount!.toStringAsFixed(2)}'),
        if ((widget.invoice.discountAmount ?? 0) > 0)
          _buildDetailRow('Discount', '-£${widget.invoice.discountAmount!.toStringAsFixed(2)}'),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Paid',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                '£${widget.invoice.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: InvoiceThemeColors.successGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptFooter() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
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
          Text(
            'Thank you for your payment!',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: InvoiceThemeColors.infoBlue,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'This receipt serves as proof of payment for the above invoice. For any questions, please contact the invoice sender.',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.grey[400],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
          ),
          isStatus
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: InvoiceThemeColors.successGreen.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: InvoiceThemeColors.successGreen,
                    ),
                  ),
                )
              : Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.white.withValues(alpha: 0.1),
      thickness: 1,
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _shareReceipt,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share,
                            color: InvoiceThemeColors.infoBlue,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Share',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: InvoiceThemeColors.infoBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _downloadReceipt,
                    borderRadius: BorderRadius.circular(16.r),
                    child: Center(
                      child: _isDownloading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Download',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          height: 56.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(16.r),
              child: Center(
                child: Text(
                  'Done',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Map<String, dynamic> _getPaymentMethodInfo() {
    switch (widget.paymentMethod) {
      case PaymentMethod.accountBalance:
        return {
          'name': 'Account Balance',
          'description': widget.selectedAccount ?? 'Main Account',
          'icon': Icons.account_balance_wallet,
          'color': InvoiceThemeColors.infoBlue,
        };
      case PaymentMethod.bitcoin:
        return {
          'name': 'Bitcoin',
          'description': 'BTC Payment',
          'icon': '₿',
          'color': const Color(0xFFF7931A),
        };
      case PaymentMethod.ethereum:
        return {
          'name': 'Ethereum',
          'description': 'ETH Payment',
          'icon': 'Ξ',
          'color': const Color(0xFF627EEA),
        };
      case PaymentMethod.usdc:
        return {
          'name': 'USD Coin',
          'description': 'USDC Payment',
          'icon': '\$',
          'color': const Color(0xFF2775CA),
        };
      case PaymentMethod.applePay:
        return {
          'name': 'Apple Pay',
          'description': 'Touch ID Payment',
          'icon': Icons.phone_iphone,
          'color': const Color(0xFF000000),
        };
      case PaymentMethod.googlePay:
        return {
          'name': 'Google Pay',
          'description': 'Google Payment',
          'icon': Icons.payment,
          'color': const Color(0xFF4285F4),
        };
      case PaymentMethod.paypal:
        return {
          'name': 'PayPal',
          'description': 'PayPal Payment',
          'icon': Icons.account_balance_wallet,
          'color': const Color(0xFF003087),
        };
      default:
        return {
          'name': 'Bank Transfer',
          'description': 'Bank Payment',
          'icon': Icons.account_balance,
          'color': const Color(0xFF059669),
        };
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    
    return '$day/$month/$year at $hour:$minute';
  }

  Future<void> _shareReceipt() async {
    HapticFeedback.lightImpact();
    
    final receiptText = '''
PAYMENT RECEIPT
LazerVault Payment Receipt

Invoice: #${widget.invoice.invoiceNumber}
Transaction ID: $_transactionId
Date: ${_formatDateTime(_transactionDate)}

From: ${widget.invoice.fromUserName}
To: You
Status: Completed

Payment Method: ${_getPaymentMethodInfo()['name']}
Amount Paid: £${widget.invoice.totalAmount.toStringAsFixed(2)}

Thank you for your payment!
    ''';
    
    await SharePlus.instance.share(ShareParams(
      text: receiptText,
      subject: 'Payment Receipt - Invoice #${widget.invoice.invoiceNumber}',
    ));
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    
    setState(() {
      _isDownloading = true;
    });
    
    try {
      HapticFeedback.lightImpact();
      
      // Create PDF
      final pdf = pw.Document();
      
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(
                  level: 0,
                  child: pw.Text(
                    'PAYMENT RECEIPT',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Invoice #${widget.invoice.invoiceNumber}',
                  style: pw.TextStyle(fontSize: 18),
                ),
                pw.SizedBox(height: 10),
                pw.Text('Transaction ID: $_transactionId'),
                pw.Text('Date: ${_formatDateTime(_transactionDate)}'),
                pw.Text('From: ${widget.invoice.fromUserName}'),
                pw.Text('To: You'),
                pw.Text('Status: Completed'),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Payment Method: ${_getPaymentMethodInfo()['name']}',
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Amount Paid: £${widget.invoice.totalAmount.toStringAsFixed(2)}',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 40),
                pw.Text(
                  'Thank you for your payment!',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontStyle: pw.FontStyle.italic,
                  ),
                ),
              ],
            );
          },
        ),
      );
      
      // Save PDF
      final output = await getApplicationDocumentsDirectory();
      final file = File('${output.path}/receipt_${widget.invoice.invoiceNumber}.pdf');
      await file.writeAsBytes(await pdf.save());
      
      // Show success message
      Get.snackbar(
        'Success',
        'Receipt downloaded successfully',
        backgroundColor: InvoiceThemeColors.successGreen,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(20.w),
        borderRadius: 12.r,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to download receipt',
        backgroundColor: InvoiceThemeColors.errorRed,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(20.w),
        borderRadius: 12.r,
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }
} 