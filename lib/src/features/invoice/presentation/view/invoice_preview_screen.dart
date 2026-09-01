import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/entities/invoice_fee_quote.dart';
import '../../domain/repositories/invoice_repository.dart';
import '../../services/invoice_pdf_service.dart';
import '../../services/invoice_qr_service.dart';
import '../utils/share_origin.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../contacts/data/repositories/contact_sync_repository.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';
part 'invoice_preview_screen_part1.dart';
part 'invoice_preview_screen_part2.dart';


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
  final bool isNewlyCreated;

  const InvoicePreviewScreen({
    super.key,
    required this.invoice,
    this.showTaggedUsers = true,
    this.isNewlyCreated = false,
  });

  @override
  State<InvoicePreviewScreen> createState() => _InvoicePreviewScreenState();
}

class _InvoicePreviewScreenState extends State<InvoicePreviewScreen>
    with TickerProviderStateMixin, TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  late Invoice invoice;
  final TextEditingController _emailController = TextEditingController();
  bool _isSendingEmail = false;
  bool _isProcessingPayment = false;
  String? _selectedAccountId;

  // Service fee resolved by the backend (admin base fee, FX-converted into the
  // active account's currency). No hardcoded amount.
  InvoiceFeeQuote? _feeQuote;
  double get _feeAmount => _feeQuote?.amount ?? 0.0;
  String get _feeCurrencyCode => _feeQuote?.currency ?? invoice.currency;
  String get _feeCurrencySymbol => _getCurrencySymbolFromCode(_feeCurrencyCode);
  String get _feeLabel => _feeQuote == null
      ? 'Pay Service Fee'
      : 'Pay Service Fee ($_feeCurrencySymbol${formatFeeAmount(_feeAmount, _feeCurrencyCode)})';

  // Get the invoice from arguments (handles both direct invoice and wrapped in map)
  Invoice get _invoice {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('invoice')) {
      return args['invoice'] as Invoice;
    }
    return widget.invoice;
  }

  bool get _isNewlyCreated {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('isNewlyCreated')) {
      return args['isNewlyCreated'] as bool;
    }
    return widget.isNewlyCreated;
  }

  @override
  void initState() {
    super.initState();
    invoice = _invoice;
    // Pre-fill email if available
    if (invoice.toEmail != null && invoice.toEmail!.isNotEmpty) {
      _emailController.text = invoice.toEmail!;
    }
    // Set default account
    _fetchAccounts();
    _loadFeeQuote();
  }

  void _fetchAccounts() {
    try {
      final authState = Get.find<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        Get.find<AccountCardsSummaryCubit>().fetchAccountSummaries(
          userId: authState.profile.userId,
        );
      }
    } catch (_) {}
  }

  Future<void> _loadFeeQuote() async {
    try {
      final quote = await serviceLocator<InvoiceRepository>().getServiceFeeQuote();
      if (mounted) setState(() => _feeQuote = quote);
    } catch (_) {}
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
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
      },
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
                details: invoice.recipientDetails,
                fallbackName: fromName ?? 'Your Business',
                fallbackEmail: fromEmail,
                logoUrl: invoice.recipientLogoUrl,
              ),
            ),
            SizedBox(width: 24.w),
            Expanded(
              child: _buildParticipantCard(
                title: 'Bill To',
                details: invoice.payerDetails,
                fallbackName: invoice.toName ?? 'Client',
                fallbackEmail: invoice.toEmail,
                logoUrl: invoice.payerLogoUrl,
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
          // Pay Service Fee CTA for newly created invoices
          if (_isNewlyCreated)
            BlocListener<InvoiceCubit, InvoiceState>(
              listener: (context, state) {
                if (state is InvoiceUnlockSuccess) {
                  setState(() => _isProcessingPayment = false);
                  // Show receipt and remove "newly created" flag
                  Get.offAllNamed(AppRoutes.invoicePaymentReceipt, arguments: {
                    'invoice_id': invoice.id,
                    'payment_reference': state.invoice != null ? 'UNLOCK-${state.invoice!.id.substring(0, 8)}' : 'UNLOCK-${DateTime.now().millisecondsSinceEpoch}',
                    'amount': _feeAmount,
                    'currency': _feeCurrencyCode,
                    'status': 'completed',
                  });
                } else if (state is InvoiceServiceFeePaid) {
                  setState(() => _isProcessingPayment = false);
                  // Show receipt and remove "newly created" flag
                  Get.offAllNamed(AppRoutes.invoicePaymentReceipt, arguments: {
                    'invoice_id': invoice.id,
                    'payment_reference': state.serviceFeeRef,
                    'amount': _feeAmount,
                    'currency': _feeCurrencyCode,
                    'status': 'completed',
                  });
                } else if (state is InvoiceError) {
                  setState(() => _isProcessingPayment = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 56.h,
                margin: EdgeInsets.only(bottom: 12.h),
                child: ElevatedButton.icon(
                  onPressed: _isProcessingPayment ? null : _handleServiceFeePayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    disabledBackgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.6),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  icon: _isProcessingPayment
                      ? LazerVaultLoader.small()
                      : Icon(Icons.lock_outline, color: Colors.white, size: 20.sp),
                  label: Text(
                    _isProcessingPayment
                        ? 'Processing Payment...'
                        : _feeLabel,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          // View Payment Receipt CTA for paid invoices
          if (invoice.status == InvoiceStatus.paid && invoice.paymentReference != null && !_isNewlyCreated)
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
          SizedBox(
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
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: IconButton(
                  onPressed: () => _downloadInvoice(context),
                  icon: Icon(
                    Icons.download_outlined,
                    color: const Color.fromARGB(255, 78, 3, 208),
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
              SizedBox(width: 16.w),

              // Send Email button
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: IconButton(
                  onPressed: () => _showSendEmailBottomSheet(context),
                  icon: Icon(
                    Icons.email_outlined,
                    color: const Color(0xFF10B981),
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
                    Text('Lazervault User', style: GoogleFonts.inter(color: InvoiceThemeColors.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600)),
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
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              LazerVaultLoader.small(),
              SizedBox(width: 16.w),
              const Text('Generating PDF...'),
            ],
          ),
          backgroundColor: InvoiceThemeColors.infoBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 10),
        ),
      );

      final filePath = await InvoicePdfService.downloadInvoice(invoice);

      // Open the saved PDF so the CTA visibly does something on both platforms
      // (on iOS the download dir isn't user-visible; opening lets the user
      // save-to-Files / print / share from the viewer).
      final openResult = await OpenFilex.open(filePath);

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (openResult.type == ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invoice PDF downloaded'),
            backgroundColor: InvoiceThemeColors.successGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        // Saved but no viewer could open it — tell the user where it is.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invoice PDF saved to $filePath'),
            backgroundColor: InvoiceThemeColors.infoBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
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
              LazerVaultLoader.small(),
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

      await InvoicePdfService.shareInvoice(
        invoice,
        sharePositionOrigin: shareOriginFromContext(context),
      );

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

  void _showSendEmailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.email_outlined,
                          color: const Color(0xFF10B981),
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Send Invoice to Email',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF1F2937),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Enter email address to send this invoice',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF6B7280),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5E7EB),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.close,
                            color: const Color(0xFF6B7280),
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Email Address',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF374151),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        hintText: 'Enter email address',
                        hintStyle: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 15.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: const Color(0xFF9CA3AF),
                          size: 20.sp,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                      ),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF1F2937),
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF6B7280),
                            side: BorderSide(color: const Color(0xFFE5E7EB)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isSendingEmail ? null : () => _sendInvoiceToEmail(ctx),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          child: _isSendingEmail
                              ? LazerVaultLoader.small()
                              : Text(
                                  'Send Invoice',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
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
          ],
        ),
      ),
    );
  }

  Future<void> _sendInvoiceToEmail(BuildContext context) async {
    final email = _emailController.text.trim();

    // Email validation
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter an email address'),
          backgroundColor: InvoiceThemeColors.errorRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Basic email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: InvoiceThemeColors.errorRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isSendingEmail = true;
    });

    try {
      // Close bottom sheet
      Get.back();

      // Show loading indicator
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              LazerVaultLoader.small(),
              SizedBox(width: 16.w),
              Text('Sending invoice to $email...'),
            ],
          ),
          backgroundColor: const Color(0xFF10B981),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );

      // Call the invoice repository to send the invoice to email
      final repo = serviceLocator<InvoiceRepository>();
      await repo.sendInvoiceToEmail(invoice.id, email);

      // Hide loading and show success
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice sent successfully to $email'),
          backgroundColor: const Color(0xFF10B981),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send invoice: ${e.toString().replaceFirst('Exception: ', '')}'),
          backgroundColor: InvoiceThemeColors.errorRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSendingEmail = false;
        });
      }
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
              LazerVaultLoader.small(),
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
      final qrCtx = qrKey.currentContext;
      final boundaryObj = qrCtx?.findRenderObject();
      if (boundaryObj is! RenderRepaintBoundary) {
        throw Exception('QR code is not ready yet, please try again');
      }
      final RenderRepaintBoundary boundary = boundaryObj;
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
        // Required by iOS/iPadOS to anchor the share sheet popover.
        sharePositionOrigin: context.mounted ? shareOriginFromContext(context) : null,
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

  Future<void> _handleServiceFeePayment() async {
    // Get the default account for payment
    try {
      final accountState = Get.find<AccountCardsSummaryCubit>().state;
      if (accountState is AccountCardsSummaryLoaded && accountState.accountSummaries.isNotEmpty) {
        _selectedAccountId = accountState.accountSummaries.first.id;
      }
    } catch (_) {
      _showErrorSnackbar('Could not load account information');
      return;
    }

    if (_selectedAccountId == null || _selectedAccountId!.isEmpty) {
      _showErrorSnackbar('No account available for payment');
      return;
    }

    HapticFeedback.mediumImpact();

    // Generate transaction ID
    final transactionId = 'INV-SVC-FEE-${DateTime.now().millisecondsSinceEpoch}';

    // Show PIN bottomsheet and verify
    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'invoice_unlock',
      amount: _feeAmount,
      currency: _feeCurrencyCode,
      title: 'Confirm Service Fee',
      message: 'Confirm invoice unlock fee of $_feeCurrencyCode ${formatFeeAmount(_feeAmount, _feeCurrencyCode)}',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;

    // Set the selected account on AccountManager so x-account-id metadata is sent
    try {
      GetIt.I<AccountManager>().setActiveAccount(_selectedAccountId!);
    } catch (_) {}

    setState(() {
      _isProcessingPayment = true;
    });

    // Process the payment - unlock the invoice by paying service fee
    final cubit = Get.find<InvoiceCubit>();
    await cubit.unlockInvoice(
      invoice.id,
      accountId: _selectedAccountId,
      verificationToken: verificationToken,
      transactionId: transactionId,
    );

    // Reset processing state
    if (mounted) {
      setState(() {
        _isProcessingPayment = false;
      });
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
}