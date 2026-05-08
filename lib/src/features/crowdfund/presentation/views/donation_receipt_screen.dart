import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../data/services/crowdfund_pdf_service.dart';
import '../../domain/entities/crowdfund_entities.dart';

class DonationReceiptScreen extends StatefulWidget {
  final CrowdfundDonation donation;
  final CrowdfundReceipt? receipt;
  final Crowdfund crowdfund;

  const DonationReceiptScreen({
    super.key,
    required this.donation,
    this.receipt,
    required this.crowdfund,
  });

  @override
  State<DonationReceiptScreen> createState() => _DonationReceiptScreenState();
}

class _DonationReceiptScreenState extends State<DonationReceiptScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late CrowdfundPdfService _pdfService;
  bool _isProcessingPdf = false;

  @override
  void initState() {
    _pdfService = GetIt.I<CrowdfundPdfService>();
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _downloadPDF() async {
    if (widget.receipt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Receipt not available for download'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_isProcessingPdf) return;

    setState(() => _isProcessingPdf = true);

    try {
      final filePath = await _pdfService.downloadReceipt(
        widget.receipt!,
        widget.donation,
        widget.crowdfund,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Receipt saved to: ${filePath.split('/').last}'),
          backgroundColor: const Color(0xFF10B981),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download: ${e.toString().replaceAll('Exception: ', '')}'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessingPdf = false);
      }
    }
  }

  Future<void> _sharePDF() async {
    if (widget.receipt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Receipt not available for sharing'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_isProcessingPdf) return;

    setState(() => _isProcessingPdf = true);

    try {
      await _pdfService.shareReceipt(
        widget.receipt!,
        widget.donation,
        widget.crowdfund,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to share: ${e.toString().replaceAll('Exception: ', '')}'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessingPdf = false);
      }
    }
  }

  /// Goes back to the crowdfund landing — same exit pattern the
  /// send-funds receipt uses (`Get.offAllNamed(AppRoutes.dashboard)`),
  /// but for the crowdfund flow we land back on the crowdfund home.
  void _exitReceipt() {
    Get.offAllNamed(AppRoutes.crowdfund);
  }

  /// Stable QR payload encoding the donation reference. Donor scans
  /// it to surface the receipt later, or campaign owner uses it for
  /// reconciliation.
  String get _qrData {
    final txn = widget.donation.transactionId ?? widget.donation.id;
    return 'lazervault://crowdfund/donation/$txn';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _exitReceipt();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      // Success animation
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        '${widget.donation.currency} ${widget.donation.amount.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Donation Successful',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Thank you for your generous support',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF8E8E93),
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 18.h),
                // Receipt card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFF2D2D2D),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'LazerVault',
                              style: TextStyle(
                                color: const Color(0xFF4E03D0),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'DONATION RECEIPT',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12.sp,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      if (widget.receipt != null) ...[
                        _buildReceiptRow(
                          'Receipt Number',
                          widget.receipt!.receiptNumber,
                          isHighlighted: true,
                        ),
                        SizedBox(height: 16.h),
                      ],
                      _buildReceiptRow(
                        'Donation ID',
                        widget.donation.id,
                      ),
                      SizedBox(height: 16.h),
                      Divider(color: const Color(0xFF2D2D2D)),
                      SizedBox(height: 16.h),
                      _buildReceiptRow(
                        'Campaign',
                        widget.crowdfund.title,
                      ),
                      SizedBox(height: 16.h),
                      _buildReceiptRow(
                        'Creator',
                        '${widget.crowdfund.creator.firstName} ${widget.crowdfund.creator.lastName}',
                        trailing: widget.crowdfund.creator.verified
                            ? Icon(
                                Icons.verified,
                                color: const Color(0xFF10B981),
                                size: 16.sp,
                              )
                            : null,
                      ),
                      SizedBox(height: 16.h),
                      Divider(color: const Color(0xFF2D2D2D)),
                      SizedBox(height: 16.h),
                      _buildReceiptRow(
                        'Amount',
                        '${widget.donation.currency} ${widget.donation.amount.toStringAsFixed(2)}',
                        isAmount: true,
                      ),
                      SizedBox(height: 16.h),
                      _buildReceiptRow(
                        'Date & Time',
                        DateFormat('MMM dd, yyyy • hh:mm a')
                            .format(widget.donation.donationDate),
                      ),
                      SizedBox(height: 16.h),
                      if (widget.donation.transactionId != null) ...[
                        _buildReceiptRow(
                          'Transaction ID',
                          widget.donation.transactionId!,
                        ),
                        SizedBox(height: 16.h),
                      ],
                      _buildReceiptRow(
                        'Payment Method',
                        widget.donation.paymentMethod,
                      ),
                      SizedBox(height: 16.h),
                      _buildReceiptRow(
                        'Status',
                        _getStatusText(widget.donation.status),
                        trailing: _buildStatusBadge(widget.donation.status),
                      ),
                      if (widget.donation.message != null &&
                          widget.donation.message!.isNotEmpty) ...[
                        SizedBox(height: 16.h),
                        Divider(color: const Color(0xFF2D2D2D)),
                        SizedBox(height: 16.h),
                        Text(
                          'Your Message',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0A0A0A),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            widget.donation.message!,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 13.sp,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 16.h),
                      Divider(color: const Color(0xFF2D2D2D)),
                      SizedBox(height: 16.h),
                      // QR code + reference at the bottom of the
                      // receipt card. Same shape as the send-funds
                      // receipt — scan to surface this donation later.
                      Center(
                        child: QrImageView(
                          data: _qrData,
                          version: QrVersions.auto,
                          size: 90.w,
                          backgroundColor: Colors.transparent,
                          dataModuleStyle: const QrDataModuleStyle(
                            color: Colors.white,
                          ),
                          eyeStyle: const QrEyeStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: Text(
                          widget.donation.transactionId ?? widget.donation.id,
                          style: GoogleFonts.robotoMono(
                            fontSize: 10.sp,
                            color: const Color(0xFF8E8E93),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
              _buildBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  /// Top bar — back chevron on the left, LazerVault logo on the
  /// right. Mirrors the send-funds receipt's `_buildBackButton`.
  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _exitReceipt,
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Image.asset(
            'assets/images/logo.png',
            width: 28.w,
            height: 28.w,
            errorBuilder: (_, __, ___) => Icon(
              Icons.shield_outlined,
              color: const Color(0xFF4E03D0),
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom actions — icon-only Download + Share side-by-side, then
  /// a full-width Done. Buttons live OUTSIDE the scroll so they stay
  /// pinned and visible against the dark background.
  Widget _buildBottomActions() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 6.h, 20.w, 12.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _iconAction(
                  icon: Icons.download_outlined,
                  label: 'Download',
                  isLoading: _isProcessingPdf,
                  onTap: _isProcessingPdf ? () {} : _downloadPDF,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _iconAction(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  isLoading: _isProcessingPdf,
                  onTap: _isProcessingPdf ? () {} : _sharePDF,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _exitReceipt,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E03D0),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Done',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return Material(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                SizedBox(
                  width: 16.sp,
                  height: 16.sp,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else
                Icon(icon, color: Colors.white, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                label,
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
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value, {
    bool isHighlighted = false,
    bool isAmount = false,
    Widget? trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 13.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: isAmount
                        ? const Color(0xFF4E03D0)
                        : isHighlighted
                            ? const Color(0xFF4E03D0)
                            : Colors.white,
                    fontSize: isAmount ? 18.sp : 13.sp,
                    fontWeight: isAmount || isHighlighted
                        ? FontWeight.bold
                        : FontWeight.w600,
                    fontFamily: isHighlighted ? 'monospace' : null,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              if (trailing != null) ...[
                SizedBox(width: 6.w),
                trailing,
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(DonationStatus status) {
    Color color;
    switch (status) {
      case DonationStatus.completed:
        color = const Color(0xFF10B981);
        break;
      case DonationStatus.processing:
        color = const Color(0xFFF59E0B);
        break;
      case DonationStatus.pending:
        color = const Color(0xFF6B7280);
        break;
      case DonationStatus.failed:
        color = const Color(0xFFEF4444);
        break;
      case DonationStatus.refunded:
        color = const Color.fromARGB(255, 78, 3, 208);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _getStatusText(status),
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getStatusText(DonationStatus status) {
    switch (status) {
      case DonationStatus.pending:
        return 'Pending';
      case DonationStatus.processing:
        return 'Processing';
      case DonationStatus.completed:
        return 'Completed';
      case DonationStatus.failed:
        return 'Failed';
      case DonationStatus.refunded:
        return 'Refunded';
    }
  }
}
