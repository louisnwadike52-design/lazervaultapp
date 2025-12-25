import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
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

  void _downloadPDF() {
    // TODO: Implement PDF download using PDF service
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Receipt downloaded successfully!'),
        backgroundColor: Color(0xFF10B981),
      ),
    );
  }

  void _sharePDF() {
    // TODO: Implement PDF share using PDF service
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality coming soon!'),
        backgroundColor: Color(0xFF4E03D0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                // Success animation
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF10B981),
                          Color(0xFF059669),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 60.sp,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Donation Successful!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Thank you for your generous support',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                // Receipt card
                Container(
                  padding: EdgeInsets.all(20.w),
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
                      SizedBox(height: 24.h),
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
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _downloadPDF,
                        icon: const Icon(Icons.download),
                        label: const Text('Download PDF'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF4E03D0),
                          side: const BorderSide(color: Color(0xFF4E03D0)),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _sharePDF,
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4E03D0),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.w),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F1F1F),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: const BorderSide(color: Color(0xFF2D2D2D)),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
        color = const Color(0xFF8B5CF6);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
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
