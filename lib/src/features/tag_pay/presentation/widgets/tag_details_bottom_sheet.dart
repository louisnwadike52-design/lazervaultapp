import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../domain/entities/user_tag_entity.dart';

class TagDetailsBottomSheet extends StatelessWidget {
  final UserTagEntity tag;
  final bool isOutgoing; // true for sent tags, false for received tags

  const TagDetailsBottomSheet({
    super.key,
    required this.tag,
    required this.isOutgoing,
  });

  Future<void> _downloadTagDetails(BuildContext context) async {
    try {
      // Show loading
      Get.dialog(
        Center(
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Generating PDF...',
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
        barrierDismissible: false,
      );

      // Create PDF
      final pdf = pw.Document();
      final isPending = tag.status == TagStatus.pending;
      final isPaid = tag.status == TagStatus.paid;

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              padding: pw.EdgeInsets.all(40),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Header
                  pw.Container(
                    padding: pw.EdgeInsets.only(bottom: 20),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(width: 2, color: PdfColors.grey300),
                      ),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          isOutgoing ? 'TAG PAYMENT DETAILS' : 'TAG INVOICE',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          isOutgoing ? 'Tags I Sent' : 'Tags I Received',
                          style: pw.TextStyle(
                            fontSize: 14,
                            color: PdfColors.grey700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 30),

                  // Status Badge
                  pw.Container(
                    padding: pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: pw.BoxDecoration(
                      color: isPaid ? PdfColors.green100 : PdfColors.orange100,
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Text(
                      isPending ? 'PENDING' : 'PAID',
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                        color: isPaid ? PdfColors.green900 : PdfColors.orange900,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 30),

                  // Tag Details
                  _buildPdfRow('Tag ID', tag.id),
                  pw.SizedBox(height: 16),

                  pw.Divider(thickness: 1, color: PdfColors.grey300),
                  pw.SizedBox(height: 16),

                  _buildPdfRow(
                    isOutgoing ? 'To' : 'From',
                    isOutgoing ? tag.taggedUserName : tag.taggerName,
                  ),
                  pw.SizedBox(height: 12),
                  _buildPdfRow(
                    'Tag',
                    '@${isOutgoing ? tag.taggedUserTagPay : tag.taggerTagPay}',
                  ),
                  pw.SizedBox(height: 12),
                  _buildPdfRow(
                    'Amount',
                    '${tag.currency} ${tag.amount.toStringAsFixed(2)}',
                    isBold: true,
                  ),

                  if (tag.description.isNotEmpty) ...[
                    pw.SizedBox(height: 12),
                    _buildPdfRow('Description', tag.description),
                  ],

                  pw.SizedBox(height: 12),
                  _buildPdfRow(
                    'Created At',
                    DateFormat('MMM dd, yyyy • hh:mm a').format(tag.createdAt),
                  ),

                  if (isPaid && tag.paidAt != null) ...[
                    pw.SizedBox(height: 12),
                    _buildPdfRow(
                      'Paid At',
                      DateFormat('MMM dd, yyyy • hh:mm a').format(tag.paidAt!),
                    ),
                  ],

                  pw.SizedBox(height: 30),
                  pw.Divider(thickness: 1, color: PdfColors.grey300),
                  pw.SizedBox(height: 20),

                  // Footer
                  pw.Text(
                    'Generated by LazerVault',
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                  pw.Text(
                    DateFormat('MMM dd, yyyy • hh:mm a').format(DateTime.now()),
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

      // Save PDF
      final output = await getTemporaryDirectory();
      final fileName = 'tag_${tag.id.substring(0, 8)}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${output.path}/$fileName');
      await file.writeAsBytes(await pdf.save());

      // Close loading dialog
      Get.back();

      // Share PDF
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        subject: 'Tag Payment Details - ${tag.currency} ${tag.amount.toStringAsFixed(2)}',
      ));

      Get.snackbar(
        'Success',
        'Tag details downloaded successfully',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      // Close loading dialog if open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      Get.snackbar(
        'Error',
        'Failed to download tag details: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  pw.Widget _buildPdfRow(String label, String value, {bool isBold = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 12,
            color: PdfColors.grey700,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: isBold ? 16 : 12,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPending = tag.status == TagStatus.pending;
    final isPaid = tag.status == TagStatus.paid;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tag Details',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: const Color(0xFF9CA3AF),
                  size: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isPaid
                  ? const Color(0xFF10B981).withValues(alpha: 0.1)
                  : const Color(0xFFFB923C).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPaid ? Icons.check_circle : Icons.access_time,
                  color: isPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  isPending ? 'PENDING' : 'PAID',
                  style: GoogleFonts.inter(
                    color: isPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Details
          _buildDetailRow(
            isOutgoing ? 'To' : 'From',
            isOutgoing ? tag.taggedUserName : tag.taggerName,
          ),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Tag',
            '@${isOutgoing ? tag.taggedUserTagPay : tag.taggerTagPay}',
          ),
          SizedBox(height: 16.h),
          Divider(color: const Color(0xFF2D2D2D)),
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Amount',
            '${tag.currency} ${tag.amount.toStringAsFixed(2)}',
            valueColor: isPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C),
            isBold: true,
          ),
          if (tag.description.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildDetailRow('Description', tag.description),
          ],
          SizedBox(height: 16.h),
          _buildDetailRow(
            'Created At',
            DateFormat('MMM dd, yyyy • hh:mm a').format(tag.createdAt),
          ),
          if (isPaid && tag.paidAt != null) ...[
            SizedBox(height: 16.h),
            _buildDetailRow(
              'Paid At',
              DateFormat('MMM dd, yyyy • hh:mm a').format(tag.paidAt!),
            ),
          ],
          SizedBox(height: 24.h),

          // Download Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () => _downloadTagDetails(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(Icons.download, size: 20.sp, color: Colors.white),
              label: Text(
                isOutgoing ? 'Download Details' : 'Download Tag Invoice',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
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
              fontSize: isBold ? 18.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
