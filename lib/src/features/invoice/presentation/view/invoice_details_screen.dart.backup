import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';

import '../../domain/entities/invoice_entity.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import '../../../../../core/types/app_routes.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final String invoiceId;

  const InvoiceDetailsScreen({
    super.key,
    required this.invoiceId,
  });

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  Invoice? _currentInvoice;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InvoiceCubit>().loadInvoiceDetails(widget.invoiceId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<InvoiceCubit, InvoiceState>(
          listener: (context, state) {
            if (state is InvoiceError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is InvoiceLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF6366F1)),
              );
            }

            if (state is InvoiceDetailsLoaded) {
              _currentInvoice = state.invoice;
              return _buildContent(state.invoice);
            }

            if (state is QRCodeGenerated && _currentInvoice != null) {
              return _buildQRCodeView(state.qrData, _currentInvoice!);
            }

            return _buildErrorState();
          },
        ),
      ),
    );
  }

  Widget _buildContent(Invoice invoice) {
    return Column(
      children: [
        _buildHeader(invoice),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInvoiceHeader(invoice),
                SizedBox(height: 24.h),
                _buildInvoiceDetails(invoice),
                SizedBox(height: 24.h),
                _buildParticipantDetails(invoice),
                SizedBox(height: 24.h),
                _buildItemsList(invoice.items),
                SizedBox(height: 24.h),
                _buildAmountBreakdown(invoice),
                if (invoice.notes?.isNotEmpty == true) ...[
                  SizedBox(height: 24.h),
                  _buildNotesSection(invoice),
                ],
                SizedBox(height: 32.h),
                _buildActions(invoice),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(Invoice invoice) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invoice Details',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  invoice.title,
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusBadge(invoice.status),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(InvoiceStatus status) {
    Color backgroundColor;
    Color textColor;
    
    switch (status) {
      case InvoiceStatus.draft:
        backgroundColor = Colors.grey.withOpacity(0.2);
        textColor = Colors.grey;
        break;
      case InvoiceStatus.pending:
        backgroundColor = Colors.orange.withOpacity(0.2);
        textColor = Colors.orange;
        break;
      case InvoiceStatus.paid:
        backgroundColor = Colors.green.withOpacity(0.2);
        textColor = Colors.green;
        break;
      case InvoiceStatus.expired:
      case InvoiceStatus.cancelled:
        backgroundColor = Colors.red.withOpacity(0.2);
        textColor = Colors.red;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInvoiceHeader(Invoice invoice) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Invoice #${invoice.id.substring(0, 8).toUpperCase()}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${invoice.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6366F1),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            invoice.description,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetails(Invoice invoice) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Invoice Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDetailRow('Created', '${invoice.createdAt.day}/${invoice.createdAt.month}/${invoice.createdAt.year}'),
          if (invoice.dueDate != null)
            _buildDetailRow('Due Date', '${invoice.dueDate!.day}/${invoice.dueDate!.month}/${invoice.dueDate!.year}'),
          if (invoice.toName != null)
            _buildDetailRow('Recipient', invoice.toName!),
          if (invoice.toEmail != null)
            _buildDetailRow('Email', invoice.toEmail!),
          _buildDetailRow('Type', invoice.typeDisplayName),
          _buildDetailRow('Currency', invoice.currency),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
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

  Widget _buildItemsList(List<InvoiceItem> items) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Items (${items.length})',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          ...items.map((item) => _buildItemCard(item)).toList(),
        ],
      ),
    );
  }

  Widget _buildItemCard(InvoiceItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (item.description != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    item.description!,
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 12.sp,
                    ),
                  ),
                ],
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      'Qty: ${item.quantity.toStringAsFixed(1)}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[300],
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Unit: \$${item.unitPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: Colors.grey[300],
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '\$${item.totalPrice.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountBreakdown(Invoice invoice) {
    final subtotal = invoice.items.fold<double>(0, (sum, item) => sum + item.totalPrice);
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount Breakdown',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildAmountRow('Subtotal', subtotal),
          if (invoice.taxAmount != null && invoice.taxAmount! > 0)
            _buildAmountRow('Tax', invoice.taxAmount!),
          if (invoice.discountAmount != null && invoice.discountAmount! > 0)
            _buildAmountRow('Discount', -invoice.discountAmount!),
          Divider(color: Colors.grey[600], height: 24.h),
          _buildAmountRow('Total', invoice.totalAmount, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: isTotal ? Colors.white : Colors.grey[300],
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '\$${amount.abs().toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: isTotal 
                  ? Colors.white 
                  : amount < 0 
                      ? Colors.red 
                      : Colors.grey[300],
              fontSize: isTotal ? 16.sp : 14.sp,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(Invoice invoice) {
    return Column(
      children: [
        // Preview button - full width
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _viewPreview(invoice),
            icon: const Icon(Icons.preview),
            label: const Text('Preview Invoice'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        
        // QR Code button if pending
        if (invoice.status == InvoiceStatus.pending) ...[
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _generateQRCode(invoice),
              icon: const Icon(Icons.qr_code),
              label: const Text('Generate QR Code'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF6366F1)),
                foregroundColor: const Color(0xFF6366F1),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
        
        // Share and Edit buttons in row
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _shareInvoice(invoice),
                icon: const Icon(Icons.share),
                label: const Text('Share'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[600]!),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            if (invoice.canBeEdited) ...[
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _editInvoice(invoice),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildQRCodeView(String qrData, Invoice invoice) {
    // Global key to capture QR code widget
    final GlobalKey qrKey = GlobalKey();

    return Column(
      children: [
        _buildSimpleHeader(),
        Expanded(
          child: Center(
            child: RepaintBoundary(
              key: qrKey,
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.w,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Scan to Pay',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      invoice.title,
                      style: GoogleFonts.inter(
                        color: Colors.black87,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '\$${invoice.totalAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: Colors.black54,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _shareQRCode(context, qrKey, 'Payment QR Code', invoice),
                  icon: Icon(
                    Icons.share,
                    color: const Color(0xFF6366F1),
                    size: 18.sp,
                  ),
                  label: Text(
                    'Share QR',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6366F1),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF6366F1)),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.read<InvoiceCubit>().loadInvoiceDetails(widget.invoiceId),
                  child: const Text('Close'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.read<InvoiceCubit>().loadInvoiceDetails(widget.invoiceId),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Payment QR Code',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: Colors.red[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'Failed to load invoice',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<InvoiceCubit>().loadInvoiceDetails(widget.invoiceId),
            child: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _generateQRCode(Invoice invoice) {
    context.read<InvoiceCubit>().generateQRCode(invoice.id);
  }

  void _shareInvoice(Invoice invoice) {
    context.read<InvoiceCubit>().shareInvoice(invoice.id, []);
  }

  void _viewPreview(Invoice invoice) {
    Get.toNamed(AppRoutes.invoicePreview, arguments: invoice);
  }

  void _editInvoice(Invoice invoice) {
    // Navigate to edit screen
    // Get.to(() => CreateInvoiceScreen(editingInvoice: invoice));
  }

  Widget _buildParticipantDetails(Invoice invoice) {
    return Column(
      children: [
        // Recipient Details
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: const Color(0xFF6366F1),
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Recipient Details',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _buildParticipantInfo(
                invoice.recipientDetails,
                invoice.toName,
                invoice.toEmail,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Payer Details
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.business_outlined,
                      color: const Color(0xFF10B981),
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Payer Details',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              _buildParticipantInfo(invoice.payerDetails, null, null),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantInfo(AddressDetails? details, String? fallbackName, String? fallbackEmail) {
    if (details == null && fallbackName == null && fallbackEmail == null) {
      return Text(
        'No information provided',
        style: GoogleFonts.inter(
          color: Colors.grey[500],
          fontSize: 14.sp,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (details?.companyName?.isNotEmpty == true) 
          _buildDetailRow('Company', details!.companyName!),
        if (details?.contactName?.isNotEmpty == true) 
          _buildDetailRow('Contact', details!.contactName!),
        if (details?.email?.isNotEmpty == true) 
          _buildDetailRow('Email', details!.email!)
        else if (fallbackEmail?.isNotEmpty == true) 
          _buildDetailRow('Email', fallbackEmail!),
        if (details?.phone?.isNotEmpty == true) 
          _buildDetailRow('Phone', details!.phone!),
        if (details?.addressLine1?.isNotEmpty == true) 
          _buildDetailRow('Address', details!.addressLine1!),
        if (details?.city?.isNotEmpty == true) 
          _buildDetailRow('City', details!.city!),
        if (details?.state?.isNotEmpty == true) 
          _buildDetailRow('State/Province', details!.state!),
        if (details?.postcode?.isNotEmpty == true) 
          _buildDetailRow('Postcode/ZIP', details!.postcode!),
        if (details?.country?.isNotEmpty == true) 
          _buildDetailRow('Country', details!.country!),
        if (fallbackName?.isNotEmpty == true && details?.companyName?.isEmpty != false) 
          _buildDetailRow('Name', fallbackName!),
      ],
    );
  }

  Widget _buildNotesSection(Invoice invoice) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            invoice.notes!,
            style: GoogleFonts.inter(
              color: Colors.grey[300],
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _shareQRCode(BuildContext context, GlobalKey qrKey, String title, Invoice invoice) async {
    try {
      // Show loading
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 16.w),
              Text('Preparing QR code...'),
            ],
          ),
          backgroundColor: const Color(0xFF6366F1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );

      // Capture the QR code widget as an image
      RenderRepaintBoundary boundary = qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData == null) {
        throw Exception('Failed to generate QR code image');
      }

      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Get temporary directory
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName = 'qr_code_${invoice.id.substring(0, 8)}.png';
      final File file = File('${tempDir.path}/$fileName');
      
      // Write image to file
      await file.writeAsBytes(pngBytes);

      // Hide loading
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Share the QR code image
      await Share.shareXFiles(
        [XFile(file.path)],
        text: '$title - ${invoice.title}\nAmount: \$${invoice.totalAmount.toStringAsFixed(2)}\nGenerated by LazerVault',
        subject: '$title - ${invoice.title}',
      );

      // Clean up temp file after a delay
      Future.delayed(Duration(seconds: 5), () {
        if (file.existsSync()) {
          file.delete();
        }
      });

    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to share QR code: ${e.toString().replaceFirst('Exception: ', '')}'),
          backgroundColor: const Color(0xFFEF4444),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
} 