import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';
import '../../services/invoice_pdf_service.dart';
import '../../services/invoice_qr_service.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../contacts/data/repositories/contact_sync_repository.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../profile/cubit/profile_cubit.dart';

String _getCurrencySymbolFromCode(String code) {
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

class InvoicePreviewScreen extends StatefulWidget {
  final Invoice invoice;
  final bool showTaggedUsers;

  const InvoicePreviewScreen({
    super.key,
    required this.invoice,
    this.showTaggedUsers = true,
  });

  @override
  State<InvoicePreviewScreen> createState() => _InvoicePreviewScreenState();
}

class _InvoicePreviewScreenState extends State<InvoicePreviewScreen> {
  late Invoice invoice;

  @override
  void initState() {
    super.initState();
    invoice = widget.invoice;
  }

  Future<void> _refreshInvoice() async {
    try {
      final repo = serviceLocator<InvoiceRepository>();
      final updated = await repo.getInvoiceById(invoice.id);
      if (updated != null && mounted) {
        setState(() {
          invoice = updated;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _buildInvoicePreview(),
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.secondaryBackground,
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
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
                  'Invoice Preview',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Review and download your invoice',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Builder(builder: (context) {
            final statusColor = invoice.isPartiallyPaid
                ? const Color(0xFFF59E0B)
                : invoice.status == InvoiceStatus.paid
                    ? InvoiceThemeColors.successGreen
                    : invoice.status == InvoiceStatus.pending
                        ? const Color(0xFFFB923C)
                        : invoice.status == InvoiceStatus.cancelled || invoice.status == InvoiceStatus.expired
                            ? const Color(0xFFEF4444)
                            : InvoiceThemeColors.successGreen;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: statusColor),
              ),
              child: Text(
                invoice.statusDisplayName,
                style: GoogleFonts.inter(
                  color: statusColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInvoicePreview() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 4),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInvoiceHeader(),
          SizedBox(height: 32.h),
          _buildParticipantsInfo(),
          SizedBox(height: 32.h),
          _buildInvoiceDetails(),
          SizedBox(height: 32.h),
          _buildItemsTable(),
          SizedBox(height: 24.h),
          _buildTotalSection(),
          if (invoice.notes?.isNotEmpty == true) ...[
            SizedBox(height: 32.h),
            _buildNotesSection(),
          ],
          if (widget.showTaggedUsers && invoice.isPartiallyPaid && invoice.taggedUsers != null && invoice.taggedUsers!.isNotEmpty) ...[
            SizedBox(height: 32.h),
            _buildPreviewPaymentProgress(),
          ],
        ],
      ),
    );
  }

  Widget _buildPreviewPaymentProgress() {
    final users = invoice.taggedUsers!;
    final total = users.length;
    final paid = invoice.paidUsersCount;
    final progress = total > 0 ? paid / total : 0.0;
    final currencySymbol = _getCurrencySymbolFromCode(invoice.currency);
    final paidUsers = users.where((u) => u.status == 'paid').toList();
    final unpaidUsers = users.where((u) => u.status != 'paid').toList();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.3)),
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
                  color: const Color(0xFF92400E),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$currencySymbol${invoice.paidAmount.toStringAsFixed(2)} of $currencySymbol${invoice.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(color: const Color(0xFF92400E), fontSize: 13.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                '$paid / $total paid',
                style: GoogleFonts.inter(color: const Color(0xFF92400E), fontSize: 13.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
              minHeight: 8.h,
            ),
          ),
          SizedBox(height: 12.h),
          // Paid users
          ...paidUsers.map((user) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: const Color(0xFF10B981), size: 13.sp),
                SizedBox(width: 6.w),
                Text(user.displayName, style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 12.sp)),
              ],
            ),
          )),
          // Unpaid users
          ...unpaidUsers.map((user) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Row(
              children: [
                Icon(Icons.radio_button_unchecked, color: const Color(0xFFFB923C), size: 13.sp),
                SizedBox(width: 6.w),
                Text(user.displayName, style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12.sp)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildInvoiceHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'INVOICE',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.infoBlue,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                invoice.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: const Color(0xFF111827),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (invoice.description.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  invoice.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Invoice #${invoice.id.substring(0, 8).toUpperCase()}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF111827),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Date: ${_formatDate(invoice.createdAt)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (invoice.dueDate != null) ...[
                SizedBox(height: 4.h),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Due: ${_formatDate(invoice.dueDate!)}',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantsInfo() {
    return Builder(
      builder: (context) {
        // Get current user info for "From" section fallback
        String? fromName;
        String? fromEmail;

        try {
          final authCubit = serviceLocator<AuthenticationCubit>();
          final profile = authCubit.currentProfile;
          if (profile != null) {
            final user = profile.user;
            fromName = '${user.firstName} ${user.lastName}';
            fromEmail = user.email;
          }
        } catch (e) {
          fromName = 'Your Business';
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildParticipantCard(
                title: 'From',
                details: invoice.payerDetails,
                fallbackName: fromName ?? 'Your Business',
                fallbackEmail: fromEmail,
                logoUrl: invoice.payerLogoUrl,
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: _buildParticipantCard(
                title: 'To',
                details: invoice.recipientDetails,
                fallbackName: invoice.toName ?? 'Client',
                fallbackEmail: invoice.toEmail,
                logoUrl: invoice.recipientLogoUrl,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildParticipantCard({
    required String title,
    AddressDetails? details,
    String? fallbackName,
    String? fallbackEmail,
    String? logoUrl,
  }) {
    final info = <String>[];
    
    if (details != null) {
      if (details.companyName?.isNotEmpty == true) info.add(details.companyName!);
      if (details.contactName?.isNotEmpty == true) info.add(details.contactName!);
      if (details.email?.isNotEmpty == true) info.add(details.email!);
      if (details.phone?.isNotEmpty == true) info.add(details.phone!);
      if (details.addressLine1?.isNotEmpty == true) info.add(details.addressLine1!);
      if (details.city?.isNotEmpty == true) info.add(details.city!);
      if (details.state?.isNotEmpty == true) info.add(details.state!);
      if (details.postcode?.isNotEmpty == true) info.add(details.postcode!);
      if (details.country?.isNotEmpty == true) info.add(details.country!);
    } else {
      if (fallbackName?.isNotEmpty == true) info.add(fallbackName!);
      if (fallbackEmail?.isNotEmpty == true) info.add(fallbackEmail!);
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          SizedBox(height: 12.h),
          if (logoUrl != null && logoUrl.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                logoUrl,
                width: 40.w,
                height: 40.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            SizedBox(height: 8.h),
          ],
          ...info.map((line) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              line,
              style: GoogleFonts.inter(
                color: const Color(0xFF111827),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          )),
          if (info.isEmpty)
            Text(
              'No information provided',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetails() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildDetailItem('Type', invoice.typeDisplayName),
          ),
          Expanded(
            child: _buildDetailItem('Currency', invoice.currency),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: const Color(0xFF111827),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildItemsTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items',
          style: GoogleFonts.inter(
            color: const Color(0xFF111827),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Description',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Qty',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Rate',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Amount',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              // Items
              ...invoice.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    border: Border(
                      top: index > 0 ? BorderSide(color: const Color(0xFFE5E7EB)) : BorderSide.none,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF111827),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (item.description?.isNotEmpty == true) ...[
                              SizedBox(height: 2.h),
                              Text(
                                item.description!,
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF6B7280),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.quantity.toStringAsFixed(item.quantity.truncateToDouble() == item.quantity ? 0 : 1),
                          style: GoogleFonts.inter(
                            color: const Color(0xFF111827),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${_getCurrencySymbolFromCode(invoice.currency)}${item.unitPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF111827),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${_getCurrencySymbolFromCode(invoice.currency)}${item.totalPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF111827),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotalSection() {
    return Column(
      children: [
        if (invoice.taxAmount != null && invoice.taxAmount! > 0)
          _buildTotalRow('Tax', invoice.taxAmount!),
        if (invoice.discountAmount != null && invoice.discountAmount! > 0)
          _buildTotalRow('Discount', -invoice.discountAmount!),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFFE5E7EB), width: 2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.inter(
                  color: const Color(0xFF111827),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${_getCurrencySymbolFromCode(invoice.currency)}${invoice.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.infoBlue,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, double amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            amount < 0 ? '-${_getCurrencySymbolFromCode(invoice.currency)}${(-amount).toStringAsFixed(2)}' : '${_getCurrencySymbolFromCode(invoice.currency)}${amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: const Color(0xFF111827),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes',
          style: GoogleFonts.inter(
            color: const Color(0xFF111827),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Text(
            invoice.notes!,
            style: GoogleFonts.inter(
              color: const Color(0xFF111827),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
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
        color: InvoiceThemeColors.primaryBackground,
        border: Border(
          top: BorderSide(color: const Color(0xFF2D2D2D)),
        ),
      ),
      child: Column(
        children: [
          // View Payment Receipt CTA for paid invoices
          if (invoice.status == InvoiceStatus.paid && invoice.paymentReference != null)
            Container(
              width: double.infinity,
              height: 48.h,
              margin: EdgeInsets.only(bottom: 12.h),
              child: ElevatedButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.invoicePaymentReceipt, arguments: {
                  'invoice_id': invoice.id,
                  'payment_reference': invoice.paymentReference,
                  'amount': invoice.totalAmount > 0 ? invoice.totalAmount : invoice.amount,
                  'currency': invoice.currency,
                  'status': 'completed',
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.15),
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                icon: Icon(Icons.receipt_long, color: const Color(0xFF10B981), size: 20.sp),
                label: Text(
                  'View Payment Receipt',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          // Tagged users CTA + Tag User button (only for creator view)
          if (widget.showTaggedUsers && invoice.taggedUsers != null && invoice.taggedUsers!.isNotEmpty)
            GestureDetector(
              onTap: () => _showTaggedUsersDetailSheet(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.people, color: Colors.white.withValues(alpha: 0.9), size: 20.sp),
                    SizedBox(width: 10.w),
                    Text(
                      '${invoice.taggedUsers!.length} Tagged User${invoice.taggedUsers!.length == 1 ? '' : 's'}',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'View',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(Icons.chevron_right, color: Colors.white.withValues(alpha: 0.7), size: 18.sp),
                  ],
                ),
              ),
            ),
          if (widget.showTaggedUsers)
          Container(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton.icon(
              onPressed: () => _showTagUserBottomSheet(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(
                Icons.person_add_outlined,
                color: Colors.white.withValues(alpha: 0.9),
                size: 20.sp,
              ),
              label: Text(
                'Tag User for Payment',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.w),
          
          // QR Code, Download, and Share icon-only buttons row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // QR Code button
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEA580C).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: IconButton(
                  onPressed: () => _showQRCode(context, 'invoice'),
                  icon: Icon(
                    Icons.qr_code,
                    color: const Color(0xFFEA580C),
                    size: 22.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // Download button
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: IconButton(
                  onPressed: () => _downloadInvoice(context),
                  icon: Icon(
                    Icons.download_outlined,
                    color: const Color(0xFF8B5CF6),
                    size: 22.sp,
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // Share button
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: IconButton(
                  onPressed: () => _shareInvoice(context),
                  icon: Icon(
                    Icons.share_outlined,
                    color: InvoiceThemeColors.infoBlue,
                    size: 22.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showTaggedUsersDetailSheet(BuildContext context) {
    final users = invoice.taggedUsers!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
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
                    onTap: () => Navigator.pop(ctx),
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
                    onTap: user.isPlatformUser ? () {
                      Navigator.pop(ctx);
                      _showUserProfileModal(context, user);
                    } : null,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 1)),
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
                                        ? Text(user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
                                            style: GoogleFonts.inter(color: typeColor, fontSize: 16.sp, fontWeight: FontWeight.w700))
                                        : Icon(user.tagType == 'email' ? Icons.email_outlined : Icons.sms_outlined, color: typeColor, size: 18.sp)
                                    : null,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(child: Text(user.displayName, style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 14.sp, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
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
                                          decoration: BoxDecoration(color: typeColor.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(4.r)),
                                          child: Text(user.tagMethodLabel, style: GoogleFonts.inter(color: typeColor, fontSize: 10.sp, fontWeight: FontWeight.w600)),
                                        ),
                                        if (user.username.isNotEmpty) ...[
                                          SizedBox(width: 6.w),
                                          Flexible(child: Text('@${user.username}', style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12.sp), overflow: TextOverflow.ellipsis)),
                                        ],
                                        if (user.tagValue != null && user.tagValue!.isNotEmpty) ...[
                                          SizedBox(width: 6.w),
                                          Flexible(child: Text(user.tagValue!, style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12.sp), overflow: TextOverflow.ellipsis)),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8.r)),
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
                                Text(_formatRelativeDate(user.taggedAt!), style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                                if (user.paidAt != null) ...[
                                  SizedBox(width: 12.w),
                                  Icon(Icons.check_circle_outline, color: const Color(0xFF10B981), size: 12.sp),
                                  SizedBox(width: 4.w),
                                  Text('Paid ${_formatRelativeDate(user.paidAt!)}', style: GoogleFonts.inter(color: const Color(0xFF10B981), fontSize: 11.sp)),
                                ] else if (user.viewedAt != null) ...[
                                  SizedBox(width: 12.w),
                                  Icon(Icons.visibility_outlined, color: const Color(0xFFFB923C), size: 12.sp),
                                  SizedBox(width: 4.w),
                                  Text('Viewed ${_formatRelativeDate(user.viewedAt!)}', style: GoogleFonts.inter(color: const Color(0xFFFB923C), fontSize: 11.sp)),
                                ],
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserProfileModal(BuildContext context, TaggedUserInfo user) {
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
                    ? Text(user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
                        style: GoogleFonts.inter(color: InvoiceThemeColors.primaryPurple, fontSize: 32.sp, fontWeight: FontWeight.w700))
                    : null,
              ),
              SizedBox(height: 16.h),
              Text(user.displayName, style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 20.sp, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
              if (user.username.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text('@${user.username}', style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp, fontWeight: FontWeight.w500)),
              ],
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(20.r)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, color: InvoiceThemeColors.primaryPurple, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text('LazerVault User', style: GoogleFonts.inter(color: InvoiceThemeColors.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
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

  String _formatRelativeDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showTagUserBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TagUserBottomSheet(invoice: invoice),
    );
    // Refresh invoice to get updated tagged users
    _refreshInvoice();
  }

  void _downloadInvoice(BuildContext context) async {
    try {
      // Show loading indicator
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
              Text('Generating PDF...'),
            ],
          ),
          backgroundColor: InvoiceThemeColors.infoBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 10),
        ),
      );

      // Generate the PDF file
      final pdfFile = await InvoicePdfService.generateInvoicePdf(invoice);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // Let user pick save location
      final fileName = 'invoice_${invoice.id.substring(0, 8)}.pdf';
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Invoice PDF',
        fileName: fileName,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return; // User cancelled

      // Copy file to chosen location
      final savedFile = File(result);
      await pdfFile.copy(savedFile.path);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice PDF saved successfully'),
          backgroundColor: InvoiceThemeColors.successGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download PDF: ${e.toString().replaceFirst('Exception: ', '')}'),
          backgroundColor: InvoiceThemeColors.errorRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _shareInvoice(BuildContext context) async {
    try {
      // Show loading indicator
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
              Text('Preparing to share...'),
            ],
          ),
          backgroundColor: InvoiceThemeColors.infoBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );

      await InvoicePdfService.shareInvoice(invoice);
      
      // Hide loading indicator
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to share invoice: ${e.toString().replaceFirst('Exception: ', '')}'),
          backgroundColor: InvoiceThemeColors.errorRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showQRCode(BuildContext context, String type) {
    String qrData;
    String title;
    String subtitle;
    Color accentColor = const Color(0xFFEA580C); // Orange color for all QR codes

    switch (type) {
      case 'invoice':
        qrData = InvoiceQrService.generateInvoiceQR(invoice);
        title = 'Invoice QR Code';
        subtitle = 'Scan to view invoice details';
        break;
      case 'payment':
        qrData = InvoiceQrService.generatePaymentQR(invoice);
        title = 'Payment QR Code';
        subtitle = 'Scan to pay invoice';
        break;
      default:
        qrData = InvoiceQrService.generateInvoiceUrl(invoice);
        title = 'Invoice QR Code';
        subtitle = 'Scan to view invoice';
    }

    // Global key to capture QR code widget
    final GlobalKey qrKey = GlobalKey();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: InvoiceThemeColors.secondaryBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      type == 'payment' ? Icons.payment : Icons.qr_code,
                      color: accentColor,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      color: const Color(0xFF9CA3AF),
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              
              // QR Code with RepaintBoundary for sharing
              RepaintBoundary(
                key: qrKey,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      QrImageView(
                        data: qrData,
                        version: QrVersions.auto,
                        size: 200.w,
                        backgroundColor: Colors.white,
                        eyeStyle: QrEyeStyle(color: Colors.black),
                        dataModuleStyle: QrDataModuleStyle(color: Colors.black),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        invoice.title,
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${_getCurrencySymbolFromCode(invoice.currency)}${invoice.totalAmount.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.black87,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              
              // Invoice info
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Invoice',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          invoice.title,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          '${_getCurrencySymbolFromCode(invoice.currency)}${invoice.totalAmount.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            color: accentColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              
              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _shareQRCode(context, qrKey, title),
                      icon: Icon(
                        Icons.share,
                        color: accentColor,
                        size: 18.sp,
                      ),
                      label: Text(
                        'Share QR',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: accentColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: accentColor),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareQRCode(BuildContext context, GlobalKey qrKey, String title) async {
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
          backgroundColor: InvoiceThemeColors.infoBlue,
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
        text: '$title - ${invoice.title}\nAmount: ${_getCurrencySymbolFromCode(invoice.currency)}${invoice.totalAmount.toStringAsFixed(2)}',
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _TagUserBottomSheet extends StatefulWidget {
  final Invoice invoice;

  const _TagUserBottomSheet({required this.invoice});

  @override
  State<_TagUserBottomSheet> createState() => _TagUserBottomSheetState();
}

class _TagUserBottomSheetState extends State<_TagUserBottomSheet>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late TabController _tabController;
  late InvoiceRepository _invoiceRepository;
  late ContactSyncRepository _contactSyncRepository;

  String _searchQuery = '';
  final Set<String> _selectedUserIds = {};
  final Set<String> _selectedEmails = {};
  final Set<String> _selectedPhones = {};
  Set<String> _alreadyTaggedUserIds = {};

  List<InvoiceUser> _searchResults = [];
  List<Map<String, dynamic>> _contacts = [];

  bool _loadingSearch = false;
  bool _loadingContacts = false;
  int _currentTab = 0;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _invoiceRepository = serviceLocator<InvoiceRepository>();
    _contactSyncRepository = serviceLocator<ContactSyncRepository>();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
        if (_currentTab == 2) {
          _requestContactsPermission();
        }
      });
    });

    // Fetch already-tagged user IDs to prevent double-tagging
    _fetchAlreadyTaggedUsers();

    // Add search listener with debounce
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    final query = _searchController.text.trim();
    if (query.length >= 2) {
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        _searchUsers(query);
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  Future<void> _fetchAlreadyTaggedUsers() async {
    try {
      final result = await _invoiceRepository.getInvoiceById(widget.invoice.id);
      if (result != null && result.taggedUsers != null) {
        setState(() {
          _alreadyTaggedUserIds = result.taggedUsers!
              .map((u) => u.userId)
              .where((id) => id.isNotEmpty)
              .toSet();
        });
      }
    } catch (e) {
      // Also try from the widget's invoice if it has tagged users
      if (widget.invoice.taggedUsers != null) {
        setState(() {
          _alreadyTaggedUserIds = widget.invoice.taggedUsers!
              .map((u) => u.userId)
              .where((id) => id.isNotEmpty)
              .toSet();
        });
      }
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSearchTab(),
                _buildManualTab(),
                _buildContactsTab(),
              ],
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      InvoiceThemeColors.infoBlue.withValues(alpha: 0.2),
                      const Color(0xFF1D4ED8).withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                ),
                child: Icon(
                  Icons.group_add,
                  color: InvoiceThemeColors.infoBlue,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tag Users for Payment',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Select multiple users to tag for this invoice',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
          if (_selectedUserIds.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
              child: Text(
                '${_selectedUserIds.length} user${_selectedUserIds.length == 1 ? '' : 's'} selected',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.infoBlue,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
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
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              InvoiceThemeColors.infoBlue,
              const Color(0xFF1D4ED8),
            ],
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(4.w),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search, size: 16.sp),
                SizedBox(width: 6.w),
                Text('Search'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit, size: 16.sp),
                SizedBox(width: 6.w),
                Text('Manual'),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.contacts, size: 16.sp),
                SizedBox(width: 6.w),
                Text('Contacts'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          // Search bar
          Container(
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
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search by name, email, or username...',
                hintStyle: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 16.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: InvoiceThemeColors.infoBlue,
                  size: 20.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          
          // User list
          Expanded(
            child: _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    // Show loading indicator
    if (_loadingSearch) {
      return Center(
        child: CircularProgressIndicator(
          color: InvoiceThemeColors.infoBlue,
        ),
      );
    }

    // Show empty state if no search performed
    if (_searchQuery.isEmpty || _searchQuery.length < 2) {
      return _buildSearchPrompt();
    }

    // Show empty state if no results
    if (_searchResults.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final user = _searchResults[index];
        final isSelected = _selectedUserIds.contains(user.id);

        return _buildUserTile(user, isSelected);
      },
    );
  }

  Widget _buildUserTile(InvoiceUser user, bool isSelected) {
    final isAlreadyTagged = _alreadyTaggedUserIds.contains(user.id);

    return GestureDetector(
      onTap: isAlreadyTagged ? null : () {
        HapticFeedback.lightImpact();
        setState(() {
          if (isSelected) {
            _selectedUserIds.remove(user.id);
          } else {
            _selectedUserIds.add(user.id);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isAlreadyTagged
              ? Colors.white.withValues(alpha: 0.03)
              : isSelected
                  ? InvoiceThemeColors.infoBlue.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            // Avatar with selection indicator
            Stack(
              children: [
                CircleAvatar(
                  radius: 26.r,
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  child: Text(
                    user.name.isNotEmpty ? user.name.substring(0, 1).toUpperCase() : '?',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            InvoiceThemeColors.infoBlue,
                            const Color(0xFF1D4ED8),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ),
                  ),
                if (user.isOnline && !isSelected)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: InvoiceThemeColors.successGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16.w),
            
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          user.name,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (user.isOnline && !isSelected)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: InvoiceThemeColors.successGreen.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],

                          ),
                          child: Text(
                            'Online',
                            style: GoogleFonts.inter(
                              color: InvoiceThemeColors.successGreen,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    user.username,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    user.email,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            
            // Selection indicator or Already Tagged badge
            if (isAlreadyTagged)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Tagged',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? InvoiceThemeColors.infoBlue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16.sp,
                      )
                    : null,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildManualTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add by Phone or Email',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter phone number or email to invite users to pay this invoice',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          
          // Phone input
          _buildInputField(
            controller: _phoneController,
            label: 'Phone Number',
            hint: '+44 7700 900000',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16.h),
          
          // Email input
          _buildInputField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'user@example.com',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 24.h),
          
          // Add button
          Container(
            width: double.infinity,
            height: 52.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  InvoiceThemeColors.infoBlue,
                  const Color(0xFF1D4ED8),
                ],
              ),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: _addManualUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 20.sp,
              ),
              label: Text(
                'Add User',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          
          // Info card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: InvoiceThemeColors.infoBlue,
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Users not on LazerVault will receive an invitation link',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.infoBlue,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          // Header with permission button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Device Contacts',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Import from your phone contacts',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          
          // Contacts list
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4, // Fixed height for contacts list
            child: _loadingContacts
                ? _buildLoadingState()
                : _contacts.isEmpty
                    ? _buildNoContactsState()
                    : _buildContactsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
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
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 16.sp,
              ),
              prefixIcon: Icon(
                icon,
                color: InvoiceThemeColors.infoBlue,
                size: 20.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.search,
              size: 48.sp,
              color: InvoiceThemeColors.infoBlue,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Search for users',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Type at least 2 characters to start searching',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.search_off,
              size: 48.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No users found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try searching with different keywords',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(InvoiceThemeColors.infoBlue),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading contacts...',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoContactsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.contacts_outlined,
              size: 48.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No contacts available',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Grant permission to access your contacts',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return _buildContactTile(contact);
      },
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    final isOnPlatform = contact['isOnPlatform'] == true && contact['userId'] != null;
    final userId = contact['userId']?.toString() ?? '';
    final phone = contact['phone']?.toString() ?? '';
    final email = contact['email']?.toString() ?? '';

    final isSelected = isOnPlatform
        ? _selectedUserIds.contains(userId)
        : _selectedPhones.contains(phone) || _selectedEmails.contains(email);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          if (isOnPlatform) {
            // User is on platform, add/remove from selected user IDs
            if (isSelected) {
              _selectedUserIds.remove(userId);
            } else {
              _selectedUserIds.add(userId);
            }
          } else {
            // User is not on platform, add/remove phone/email for invitation
            if (isSelected) {
              _selectedPhones.remove(phone);
              _selectedEmails.remove(email);
            } else {
              if (phone.isNotEmpty) _selectedPhones.add(phone);
              if (email.isNotEmpty) _selectedEmails.add(email);
            }
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected 
              ? InvoiceThemeColors.infoBlue.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              child: Text(
                (contact['name']?.isNotEmpty == true 
                    ? contact['name'][0].toUpperCase() 
                    : '?'),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
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
                    contact['name'] ?? 'Unknown',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (contact['phone']?.isNotEmpty == true) ...[
                    SizedBox(height: 2.h),
                    Text(
                      contact['phone'] ?? '',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                  if (contact['email']?.isNotEmpty == true) ...[
                    SizedBox(height: 2.h),
                    Text(
                      contact['email'] ?? '',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (!isOnPlatform) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'Invite',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.infoBlue,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? InvoiceThemeColors.infoBlue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _selectedUserIds.isNotEmpty
                        ? [InvoiceThemeColors.infoBlue, const Color(0xFF1D4ED8)]
                        : [Colors.grey.shade700, Colors.grey.shade800],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: _selectedUserIds.isNotEmpty ? [
                    BoxShadow(
                      color: InvoiceThemeColors.infoBlue.withValues(alpha: 0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ] : null,
                ),
                child: ElevatedButton.icon(
                  onPressed: _selectedUserIds.isNotEmpty ? _tagSelectedUsers : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: Icon(
                    Icons.group_add,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  label: Text(
                    () {
                      final totalCount = _selectedUserIds.length + _selectedEmails.length + _selectedPhones.length;
                      if (totalCount == 0) {
                        return 'Select Users';
                      } else {
                        return 'Tag $totalCount User${totalCount == 1 ? '' : 's'}';
                      }
                    }(),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addManualUser() {
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();

    if (phone.isEmpty && email.isEmpty) {
      _showErrorSnackbar('Please enter a phone number or email address');
      return;
    }

    setState(() {
      if (phone.isNotEmpty) {
        _selectedPhones.add(phone);
      }
      if (email.isNotEmpty) {
        _selectedEmails.add(email);
      }
    });

    // Clear inputs
    _phoneController.clear();
    _emailController.clear();

    // Show success
    HapticFeedback.heavyImpact();

    String message = '';
    if (phone.isNotEmpty && email.isNotEmpty) {
      message = 'Email and phone number added';
    } else if (phone.isNotEmpty) {
      message = 'Phone number added';
    } else {
      message = 'Email address added';
    }
    _showSuccessSnackbar(message);
  }

  Future<void> _requestContactsPermission() async {
    final status = await Permission.contacts.request();
    
    if (status.isGranted) {
      _loadContacts();
    } else if (status.isDenied) {
      _showErrorSnackbar('Contacts permission denied');
    } else if (status.isPermanentlyDenied) {
      _showErrorSnackbar('Please enable contacts permission in settings');
    }
  }

  Future<void> _searchUsers(String query) async {
    if (_loadingSearch) return;

    setState(() {
      _loadingSearch = true;
    });

    try {
      final profileCubit = serviceLocator<ProfileCubit>();
      final results = await profileCubit.searchUsers(query, limit: 20);
      setState(() {
        _searchResults = results.map((user) => InvoiceUser(
          id: user.userId,
          name: user.fullName,
          email: user.email,
          username: user.username,
          phone: '',
          isOnline: false,
        )).toList();
      });
    } catch (e) {
      _showErrorSnackbar('Failed to search users');
      setState(() {
        _searchResults = [];
      });
    } finally {
      setState(() {
        _loadingSearch = false;
      });
    }
  }

  Future<void> _loadContacts() async {
    if (_loadingContacts) return;

    setState(() {
      _loadingContacts = true;
    });

    try {
      final permission = await Permission.contacts.status;
      if (permission.isGranted) {
        // Load real contacts from contact sync service
        final syncedContactsResult = await _contactSyncRepository.getSyncedContacts();

        // Convert to display format
        final contactsList = syncedContactsResult.contacts.map((contact) {
          return {
            'id': contact.id,
            'name': contact.name,
            'phone': contact.phoneNumbers.isNotEmpty ? contact.phoneNumbers.first : '',
            'email': contact.emails.isNotEmpty ? contact.emails.first : '',
            'isOnPlatform': contact.isLazervaultUser,
            'userId': contact.lazervaultUserId,
          };
        }).toList();

        setState(() {
          _contacts = contactsList;
        });
      }
    } catch (e) {
      _showErrorSnackbar('Failed to load contacts');
    } finally {
      setState(() {
        _loadingContacts = false;
      });
    }
  }

  Future<void> _tagSelectedUsers() async {
    if (_selectedUserIds.isEmpty && _selectedEmails.isEmpty && _selectedPhones.isEmpty) {
      _showErrorSnackbar('Please select at least one user');
      return;
    }

    try {
      final response = await _invoiceRepository.tagUsersToInvoice(
        widget.invoice.id,
        _selectedUserIds.toList(),
        _selectedEmails.toList(),
        _selectedPhones.toList(),
      );

      if (response.success) {
        Navigator.pop(context);

        // Show detailed success message
        final totalTagged = response.taggedUserIds.length;
        final totalInvited = response.invitedEmails.length + response.invitedPhones.length;

        String message = '';
        if (totalTagged > 0 && totalInvited > 0) {
          message = '$totalTagged user${totalTagged == 1 ? '' : 's'} tagged, $totalInvited invitation${totalInvited == 1 ? '' : 's'} sent';
        } else if (totalTagged > 0) {
          message = '$totalTagged user${totalTagged == 1 ? '' : 's'} tagged for payment';
        } else if (totalInvited > 0) {
          message = '$totalInvited invitation${totalInvited == 1 ? '' : 's'} sent';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Successfully Tagged!',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        message,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            backgroundColor: InvoiceThemeColors.successGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 200.h,
              right: 20.w,
              left: 20.w,
            ),
            duration: Duration(seconds: 4),
          ),
        );

        HapticFeedback.heavyImpact();
      } else {
        _showErrorSnackbar(response.message);
      }
    } catch (e) {
      _showErrorSnackbar('Failed to tag users: ${e.toString()}');
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: InvoiceThemeColors.errorRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: InvoiceThemeColors.successGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
} 