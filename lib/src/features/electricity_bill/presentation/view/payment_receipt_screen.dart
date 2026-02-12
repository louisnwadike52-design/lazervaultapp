import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/bill_payment_entity.dart';
import '../../services/electricity_bill_pdf_service.dart';
import '../../../../../core/types/app_routes.dart';

class PaymentReceiptScreen extends StatefulWidget {
  const PaymentReceiptScreen({super.key});

  @override
  State<PaymentReceiptScreen> createState() => _PaymentReceiptScreenState();
}

class _PaymentReceiptScreenState extends State<PaymentReceiptScreen>
    with SingleTickerProviderStateMixin {
  late final BillPaymentEntity payment;
  late AnimationController _checkController;
  late Animation<double> _checkScale;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    // C8: Null safety for args
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null || args['payment'] == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(AppRoutes.electricityBillHome);
      });
      // Provide a dummy payment to avoid late initialization error
      // The screen will redirect before rendering
      payment = BillPaymentEntity.empty();
      _checkController = AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
      _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
      );
      return;
    }
    payment = args['payment'] as BillPaymentEntity;

    _checkController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );

    // Trigger the animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _checkController.forward();
    });
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);

    try {
      final path = await ElectricityBillPdfService.downloadReceipt(
        payment: payment,
      );
      Get.snackbar(
        'Download Complete',
        'Receipt saved to: ${path.split('/').last}',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Could not download receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  Future<void> _shareReceipt() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);

    try {
      await ElectricityBillPdfService.shareReceipt(payment: payment);
    } catch (e) {
      Get.snackbar(
        'Share Failed',
        'Could not share receipt. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.electricityBillHome),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        title: Text(
          'Payment Receipt',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 8.h),
                    _buildSuccessIcon(),
                    SizedBox(height: 24.h),
                    Text(
                      'Payment Successful!',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      payment.isPrepaid
                          ? 'Your electricity token is ready'
                          : 'Your payment has been processed',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    if (payment.hasToken) _buildTokenCard(),
                    if (payment.hasToken) SizedBox(height: 20.h),
                    _buildAmountCard(),
                    SizedBox(height: 20.h),
                    _buildTransactionDetails(),
                  ],
                ),
              ),
            ),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return AnimatedBuilder(
      animation: _checkScale,
      builder: (context, child) {
        return Transform.scale(
          scale: _checkScale.value,
          child: Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle,
              color: const Color(0xFF10B981),
              size: 60.sp,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTokenCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF92400E), Color(0xFFD97706)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD97706).withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.bolt,
                color: const Color(0xFFFDE68A),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'ELECTRICITY TOKEN',
                style: GoogleFonts.inter(
                  color: const Color(0xFFFDE68A),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () {
              if (payment.token != null) {
                Clipboard.setData(ClipboardData(text: payment.token!));
                HapticFeedback.mediumImpact();
                Get.snackbar(
                  'Copied',
                  'Token copied to clipboard',
                  backgroundColor: const Color(0xFF10B981),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.all(16.w),
                );
              }
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFFDE68A).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  SelectableText(
                    payment.token ?? '',
                    style: GoogleFonts.robotoMono(
                      color: const Color(0xFFFEF3C7),
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.copy_rounded,
                        color: const Color(0xFFFDE68A).withValues(alpha: 0.8),
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Tap to copy token',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFFDE68A).withValues(alpha: 0.8),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (payment.units != null) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.electric_bolt,
                    color: const Color(0xFFFDE68A),
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '${payment.units!.toStringAsFixed(2)} kWh',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFEF3C7),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAmountCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildAmountRow(
            'Amount',
            '\u20A6${payment.amount.toStringAsFixed(2)}',
          ),
          SizedBox(height: 12.h),
          _buildAmountRow(
            'Service Fee',
            '\u20A6${payment.serviceFee.toStringAsFixed(2)}',
          ),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          _buildAmountRow(
            'Total',
            '\u20A6${payment.totalAmount.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: isTotal ? Colors.white : const Color(0xFFD1D5DB),
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionDetails() {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final displayDate = payment.completedAt ?? payment.createdAt;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Provider', payment.providerName),
          SizedBox(height: 12.h),
          _buildDetailRow('Customer', payment.customerName),
          SizedBox(height: 12.h),
          _buildDetailRow('Meter Number', payment.meterNumber),
          SizedBox(height: 12.h),
          _buildDetailRow('Meter Type', payment.meterType.displayName),
          SizedBox(height: 12.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 12.h),
          _buildDetailRow('Reference', payment.referenceNumber),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Gateway',
            payment.paymentGateway.toUpperCase(),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow('Date', dateFormat.format(displayDate)),
          SizedBox(height: 12.h),
          _buildDetailRow('Time', timeFormat.format(displayDate)),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Status',
            payment.status.displayName,
            valueColor: const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: valueColor ?? Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isSharing ? null : _shareReceipt,
                  icon: _isSharing
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(Icons.share, size: 18.sp),
                  label: Text(
                    _isSharing ? 'Sharing...' : 'Share',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF3B82F6)),
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
                  onPressed: _isDownloading ? null : _downloadReceipt,
                  icon: _isDownloading
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(Icons.download, size: 18.sp),
                  label: Text(
                    _isDownloading ? 'Saving...' : 'Download',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF3B82F6)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () =>
                  Get.offAllNamed(AppRoutes.electricityBillHome),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Done',
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
}

