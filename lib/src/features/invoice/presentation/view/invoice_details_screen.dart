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
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../widgets/invoice_shimmer.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final String invoiceId;
  final bool isFromReceivedTab;

  const InvoiceDetailsScreen({
    super.key,
    required this.invoiceId,
    this.isFromReceivedTab = true,
  });

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  Invoice? _currentInvoice;

  String get _currencySymbol {
    final code = _currentInvoice?.currency ?? 'NGN';
    switch (code.toUpperCase()) {
      case 'NGN': return '₦';
      case 'GBP': return '£';
      case 'EUR': return '€';
      case 'ZAR': return 'R';
      case 'CAD': return 'C\$';
      case 'AUD': return 'A\$';
      case 'INR': return '₹';
      case 'JPY': return '¥';
      case 'USD': return '\$';
      default: return '₦';
    }
  }

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
      backgroundColor: InvoiceThemeColors.primaryBackground,
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
              return const InvoiceDetailShimmer();
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
                if (!widget.isFromReceivedTab && invoice.taggedUsers != null && invoice.taggedUsers!.isNotEmpty) ...[
                  SizedBox(height: 24.h),
                  _buildTaggedUsersSection(invoice),
                ],
                if (!widget.isFromReceivedTab && invoice.isPartiallyPaid && invoice.taggedUsers != null && invoice.taggedUsers!.isNotEmpty) ...[
                  SizedBox(height: 24.h),
                  _buildPaymentProgressSection(invoice),
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
                color: InvoiceThemeColors.secondaryBackground,
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
                    color: const Color(0xFF9CA3AF),
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
        backgroundColor = Colors.grey.withValues(alpha: 0.2);
        textColor = Colors.grey;
        break;
      case InvoiceStatus.pending:
        backgroundColor = Colors.orange.withValues(alpha: 0.2);
        textColor = Colors.orange;
        break;
      case InvoiceStatus.paid:
        backgroundColor = Colors.green.withValues(alpha: 0.2);
        textColor = Colors.green;
        break;
      case InvoiceStatus.partiallyPaid:
        backgroundColor = const Color(0xFFF59E0B).withValues(alpha: 0.2);
        textColor = const Color(0xFFF59E0B);
        break;
      case InvoiceStatus.expired:
      case InvoiceStatus.cancelled:
        backgroundColor = Colors.red.withValues(alpha: 0.2);
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
        color: InvoiceThemeColors.secondaryBackground,
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
                '$_currencySymbol${invoice.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
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
        color: InvoiceThemeColors.secondaryBackground,
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
              color: const Color(0xFF9CA3AF),
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
        color: InvoiceThemeColors.secondaryBackground,
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
          ...items.map((item) => _buildItemCard(item)),
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
                      color: const Color(0xFF9CA3AF),
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
                      'Unit: $_currencySymbol${item.unitPrice.toStringAsFixed(2)}',
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
            '$_currencySymbol${item.totalPrice.toStringAsFixed(2)}',
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
        color: InvoiceThemeColors.secondaryBackground,
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
          Divider(color: const Color(0xFF6B7280), height: 24.h),
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
            '$_currencySymbol${amount.abs().toStringAsFixed(2)}',
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
    // Determine if current user is the sender
    final authState = context.read<AuthenticationCubit>().state;
    final currentUserId = authState is AuthenticationAuthenticated ? authState.profile.userId : null;
    final isSender = currentUserId != null && invoice.fromUserId == currentUserId;

    return Column(
      children: [
        // SENT & PENDING: Show Send Reminder, Cancel, Edit
        if (isSender && invoice.status == InvoiceStatus.pending) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _sendReminder(invoice),
              icon: const Icon(Icons.notifications_active),
              label: const Text('Send Reminder'),
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.warningOrange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _cancelInvoice(invoice),
                  icon: Icon(Icons.cancel_outlined, color: InvoiceThemeColors.errorRed),
                  label: Text('Cancel', style: TextStyle(color: InvoiceThemeColors.errorRed)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: InvoiceThemeColors.errorRed),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
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
          ),
          SizedBox(height: 12.h),
        ],

        // PAID: Show payment confirmation + receipt button
        if (invoice.status == InvoiceStatus.paid) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.successGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: InvoiceThemeColors.successGreen, size: 24.sp),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice Paid',
                      style: GoogleFonts.inter(
                        color: InvoiceThemeColors.successGreen,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (invoice.paidAt != null)
                      Text(
                        'Paid on ${invoice.paidAt!.day}/${invoice.paidAt!.month}/${invoice.paidAt!.year}',
                        style: GoogleFonts.inter(
                          color: InvoiceThemeColors.successGreen.withValues(alpha: 0.7),
                          fontSize: 12.sp,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed(
                AppRoutes.invoicePaymentReceipt,
                arguments: {
                  'invoice_id': invoice.id,
                  'amount': invoice.totalAmount,
                  'currency': invoice.currency,
                  'transaction_id': invoice.paymentReference ?? '',
                  'message': 'Invoice paid',
                },
              ),
              icon: const Icon(Icons.receipt_long),
              label: const Text('View Payment Receipt'),
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.successGreen,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],

        // PARTIALLY PAID: Show partial payment info + send reminder to unpaid
        if (invoice.status == InvoiceStatus.partiallyPaid) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.pie_chart, color: const Color(0xFFF59E0B), size: 24.sp),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Partially Paid',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFF59E0B),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${invoice.paidUsersCount} of ${invoice.taggedUsers?.length ?? 0} users paid',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.7),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          if (isSender) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _sendReminder(invoice),
                icon: const Icon(Icons.notifications_active),
                label: const Text('Send Reminder to Unpaid'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF59E0B),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed(
                AppRoutes.invoicePaymentReceipt,
                arguments: {
                  'invoice_id': invoice.id,
                  'amount': invoice.paidAmount,
                  'total_amount': invoice.totalAmount,
                  'currency': invoice.currency,
                  'transaction_id': invoice.paymentReference ?? '',
                  'message': 'Partial payment - ${invoice.paidUsersCount} of ${invoice.taggedUsers?.length ?? 0} users paid',
                  'is_partial': true,
                },
              ),
              icon: const Icon(Icons.receipt_long),
              label: const Text('View Partial Payment Receipt'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.8),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],

        // CANCELLED: Show cancelled info
        if (invoice.status == InvoiceStatus.cancelled) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.errorRed.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: InvoiceThemeColors.errorRed.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cancel, color: InvoiceThemeColors.errorRed, size: 24.sp),
                SizedBox(width: 12.w),
                Text(
                  'Invoice Cancelled',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.errorRed,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
        ],

        // Pay + Preview side-by-side when Pay is shown (only for received tab), Preview full-width otherwise
        if (!isSender && invoice.status == InvoiceStatus.pending && widget.isFromReceivedTab) ...[
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [InvoiceThemeColors.primaryPurple, InvoiceThemeColors.gradientPurple],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () => _payInvoice(invoice),
                    icon: Icon(Icons.payment, size: 20.sp),
                    label: Text('Pay $_currencySymbol${invoice.totalAmount.toStringAsFixed(2)}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _viewPreview(invoice),
                  icon: const Icon(Icons.preview),
                  label: const Text('Preview'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
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
        ] else ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _viewPreview(invoice),
              icon: const Icon(Icons.preview),
              label: const Text('Preview Invoice'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
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
    );
  }

  Widget _buildPaymentProgressSection(Invoice invoice) {
    final users = invoice.taggedUsers!;
    final total = users.length;
    final paid = invoice.paidUsersCount;
    final progress = total > 0 ? paid / total : 0.0;
    final paidUsers = users.where((u) => u.status == 'paid').toList();
    final unpaidUsers = users.where((u) => u.status != 'paid').toList();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.pie_chart, color: const Color(0xFFF59E0B), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Payment Progress',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Progress bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$_currencySymbol${invoice.paidAmount.toStringAsFixed(2)} of $_currencySymbol${invoice.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(color: const Color(0xFFF59E0B), fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: GoogleFonts.inter(color: const Color(0xFFF59E0B), fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.15),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
              minHeight: 8.h,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            '$paid of $total users paid',
            style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 12.sp),
          ),
          SizedBox(height: 16.h),
          // Paid users
          if (paidUsers.isNotEmpty) ...[
            Text(
              'Paid',
              style: GoogleFonts.inter(color: const Color(0xFF10B981), fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            ...paidUsers.map((user) => Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 14.sp),
                  SizedBox(width: 8.w),
                  Text(user.displayName, style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
                  if (user.paidAt != null) ...[
                    const Spacer(),
                    Text(_formatSheetDate(user.paidAt!), style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 11.sp)),
                  ],
                ],
              ),
            )),
            SizedBox(height: 12.h),
          ],
          // Unpaid users
          if (unpaidUsers.isNotEmpty) ...[
            Text(
              'Unpaid',
              style: GoogleFonts.inter(color: const Color(0xFFFB923C), fontSize: 13.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            ...unpaidUsers.map((user) => Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(Icons.pending, color: const Color(0xFFFB923C), size: 14.sp),
                  SizedBox(width: 8.w),
                  Text(user.displayName, style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
                  const Spacer(),
                  Text(user.status == 'viewed' ? 'Viewed' : 'Pending', style: GoogleFonts.inter(color: Colors.grey[500], fontSize: 11.sp)),
                ],
              ),
            )),
          ],
        ],
      ),
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
                      '$_currencySymbol${invoice.totalAmount.toStringAsFixed(2)}',
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
                    color: const Color(0xFF3B82F6),
                    size: 18.sp,
                  ),
                  label: Text(
                    'Share QR',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF3B82F6)),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: const Text('Close'),
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
                color: InvoiceThemeColors.secondaryBackground,
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildTaggedUsersSection(Invoice invoice) {
    final users = invoice.taggedUsers!;
    final paidUsers = users.where((u) => u.status == 'paid').toList();
    final unpaidUsers = users.where((u) => u.status != 'paid').toList();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people, color: InvoiceThemeColors.primaryPurple, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Tagged Users (${users.length})',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              // Summary chips
              if (paidUsers.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    '${paidUsers.length} paid',
                    style: GoogleFonts.inter(color: const Color(0xFF10B981), fontSize: 11.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              if (paidUsers.isNotEmpty && unpaidUsers.isNotEmpty)
                SizedBox(width: 6.w),
              if (unpaidUsers.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    '${unpaidUsers.length} pending',
                    style: GoogleFonts.inter(color: const Color(0xFFFB923C), fontSize: 11.sp, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),
          // User list with bright colors
          ...users.take(4).map((user) => _buildTaggedUserTile(user)),
          if (users.length > 4) ...[
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () => _showTaggedUsersDetailSheet(invoice),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'View all ${users.length} users',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.primaryPurple,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTaggedUserTile(TaggedUserInfo user) {
    final isPaid = user.status == 'paid';
    final isViewed = user.status == 'viewed';
    final statusColor = isPaid
        ? const Color(0xFF10B981)
        : isViewed
            ? const Color(0xFFFB923C)
            : const Color(0xFF9CA3AF);
    final statusLabel = isPaid ? 'Paid' : isViewed ? 'Viewed' : 'Pending';
    final displayName = user.displayName.isNotEmpty
        ? user.displayName
        : user.username.isNotEmpty
            ? user.username
            : 'User';
    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 18.r,
            backgroundColor: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
            backgroundImage: user.profilePicture != null ? NetworkImage(user.profilePicture!) : null,
            child: user.profilePicture == null
                ? Text(
                    initial,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFD8B4FE),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          // Name and username
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (user.username.isNotEmpty && user.username != displayName) ...[
                  SizedBox(height: 2.h),
                  Text(
                    '@${user.username}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFA78BFA),
                      fontSize: 12.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          // Status badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPaid ? Icons.check_circle : isViewed ? Icons.visibility : Icons.schedule,
                  color: statusColor,
                  size: 12.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  statusLabel,
                  style: GoogleFonts.inter(
                    color: statusColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showTaggedUsersDetailSheet(Invoice invoice) {
    final users = invoice.taggedUsers!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.65),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Icon(Icons.people, color: InvoiceThemeColors.primaryPurple, size: 20.sp),
                  SizedBox(width: 10.w),
                  Text(
                    'Tagged Users (${users.length})',
                    style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.close, color: const Color(0xFF6B7280), size: 20.sp),
                  ),
                ],
              ),
            ),
            Divider(color: const Color(0xFFE5E7EB), height: 1),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return _buildLightTaggedUserTile(user);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLightTaggedUserTile(TaggedUserInfo user) {
    final statusColor = user.status == 'paid'
        ? const Color(0xFF10B981)
        : user.status == 'viewed'
            ? const Color(0xFFFB923C)
            : const Color(0xFF6B7280);
    final statusLabel = user.status == 'paid' ? 'Paid' : user.status == 'viewed' ? 'Viewed' : 'Pending';
    final typeColor = user.isPlatformUser
        ? InvoiceThemeColors.primaryPurple
        : user.tagType == 'email'
            ? const Color(0xFF3B82F6)
            : const Color(0xFF10B981);

    return GestureDetector(
      onTap: user.isPlatformUser ? () => _showUserProfileModal(user) : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: typeColor.withValues(alpha: 0.1),
                  backgroundImage: user.profilePicture != null ? NetworkImage(user.profilePicture!) : null,
                  child: user.profilePicture == null
                      ? user.isPlatformUser
                          ? Text(
                              user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
                              style: GoogleFonts.inter(color: typeColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
                            )
                          : Icon(
                              user.tagType == 'email' ? Icons.email_outlined : Icons.sms_outlined,
                              color: typeColor,
                              size: 18.sp,
                            )
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              user.displayName,
                              style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 14.sp, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (user.isPlatformUser) ...[
                            SizedBox(width: 4.w),
                            Icon(Icons.open_in_new, color: InvoiceThemeColors.primaryPurple, size: 12.sp),
                          ],
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: typeColor.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              user.tagMethodLabel,
                              style: GoogleFonts.inter(color: typeColor, fontSize: 10.sp, fontWeight: FontWeight.w600),
                            ),
                          ),
                          if (user.username.isNotEmpty) ...[
                            SizedBox(width: 6.w),
                            Flexible(
                              child: Text('@${user.username}', style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12.sp), overflow: TextOverflow.ellipsis),
                            ),
                          ],
                          if (user.tagValue != null && user.tagValue!.isNotEmpty) ...[
                            SizedBox(width: 6.w),
                            Flexible(
                              child: Text(user.tagValue!, style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12.sp), overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(statusLabel, style: GoogleFonts.inter(color: statusColor, fontSize: 11.sp, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            if (user.taggedAt != null) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  SizedBox(width: 52.w),
                  Icon(Icons.schedule, color: const Color(0xFF9CA3AF), size: 12.sp),
                  SizedBox(width: 4.w),
                  Text('Tagged ${_formatSheetDate(user.taggedAt!)}', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                  if (user.paidAt != null) ...[
                    SizedBox(width: 12.w),
                    Icon(Icons.check_circle_outline, color: const Color(0xFF10B981), size: 12.sp),
                    SizedBox(width: 4.w),
                    Text('Paid ${_formatSheetDate(user.paidAt!)}', style: GoogleFonts.inter(color: const Color(0xFF10B981), fontSize: 11.sp)),
                  ] else if (user.viewedAt != null) ...[
                    SizedBox(width: 12.w),
                    Icon(Icons.visibility_outlined, color: const Color(0xFFFB923C), size: 12.sp),
                    SizedBox(width: 4.w),
                    Text('Viewed ${_formatSheetDate(user.viewedAt!)}', style: GoogleFonts.inter(color: const Color(0xFFFB923C), fontSize: 11.sp)),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showUserProfileModal(TaggedUserInfo user) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
                backgroundImage: user.profilePicture != null ? NetworkImage(user.profilePicture!) : null,
                child: user.profilePicture == null
                    ? Text(
                        user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
                        style: GoogleFonts.inter(color: InvoiceThemeColors.primaryPurple, fontSize: 32.sp, fontWeight: FontWeight.w700),
                      )
                    : null,
              ),
              SizedBox(height: 16.h),
              Text(
                user.displayName,
                style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 20.sp, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              if (user.username.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  '@${user.username}',
                  style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
              ],
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, color: InvoiceThemeColors.primaryPurple, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text('LazerVault User', style: GoogleFonts.inter(color: InvoiceThemeColors.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              if (user.status == 'paid' && user.paidAt != null) ...[
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 14.sp),
                      SizedBox(width: 4.w),
                      Text('Paid ${_formatSheetDate(user.paidAt!)}', style: GoogleFonts.inter(color: const Color(0xFF10B981), fontSize: 12.sp, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ] else ...[
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFB923C).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.pending, color: const Color(0xFFFB923C), size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(user.status == 'viewed' ? 'Viewed' : 'Pending', style: GoogleFonts.inter(color: const Color(0xFFFB923C), fontSize: 12.sp, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: InvoiceThemeColors.primaryPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text('Close', style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatSheetDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _viewPreview(Invoice invoice) {
    Get.toNamed(AppRoutes.invoicePreview, arguments: {
      'invoice': invoice,
      'showTaggedUsers': !widget.isFromReceivedTab,
    });
  }

  void _editInvoice(Invoice invoice) {
    // Navigate to edit screen
    // Get.to(() => CreateInvoiceScreen(editingInvoice: invoice));
  }

  void _payInvoice(Invoice invoice) {
    Get.toNamed(AppRoutes.invoiceItemPayment, arguments: invoice);
  }

  void _sendReminder(Invoice invoice) {
    context.read<InvoiceCubit>().sendInvoice(invoice.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Reminder sent'),
        backgroundColor: InvoiceThemeColors.successGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  void _cancelInvoice(Invoice invoice) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: InvoiceThemeColors.secondaryBackground,
        title: Text('Cancel Invoice', style: GoogleFonts.inter(color: Colors.white)),
        content: Text(
          'Are you sure you want to cancel this invoice? This action cannot be undone.',
          style: GoogleFonts.inter(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('No', style: GoogleFonts.inter(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<InvoiceCubit>().cancelInvoice(invoice.id);
              Get.back();
            },
            child: Text('Cancel Invoice', style: GoogleFonts.inter(color: InvoiceThemeColors.errorRed)),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantDetails(Invoice invoice) {
    return Column(
      children: [
        // From (invoice creator / payer details)
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: InvoiceThemeColors.secondaryBackground,
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
                      color: InvoiceThemeColors.successGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      color: InvoiceThemeColors.successGreen,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'From',
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
        SizedBox(height: 16.h),
        // To (recipient details)
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: InvoiceThemeColors.secondaryBackground,
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
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      color: const Color(0xFF3B82F6),
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'To',
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
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
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
                    color: const Color(0xFFFB923C).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.notes_rounded,
                    color: const Color(0xFFFB923C),
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Notes',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: Text(
                invoice.notes!,
                style: GoogleFonts.inter(
                  color: Colors.grey[300],
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
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
          backgroundColor: const Color(0xFF3B82F6),
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
      await SharePlus.instance.share(ShareParams(
        files: [XFile(file.path)],
        text: '$title - ${invoice.title}\nAmount: $_currencySymbol${invoice.totalAmount.toStringAsFixed(2)}',
        subject: '$title - ${invoice.title}',
      ));

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
          backgroundColor: InvoiceThemeColors.errorRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
} 