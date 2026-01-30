import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/invoice_entity.dart';
import '../cubit/invoice_cubit.dart';
import 'tag_recipients_screen.dart';

class InvoiceReceiptScreen extends StatefulWidget {
  final Invoice invoice;

  const InvoiceReceiptScreen({super.key, required this.invoice});

  @override
  State<InvoiceReceiptScreen> createState() => _InvoiceReceiptScreenState();
}

class _InvoiceReceiptScreenState extends State<InvoiceReceiptScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _checkController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkController, curve: Curves.elasticOut),
    );
    _checkController.forward();
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    _buildSuccessIcon(),
                    SizedBox(height: 24.h),
                    _buildReceiptCard(),
                    SizedBox(height: 24.h),
                    _buildActions(),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            _buildBottomActions(),
          ],
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
            onTap: () => Get.offAllNamed(AppRoutes.invoice),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.secondaryBackground,
                borderRadius: BorderRadius.circular(22.r),
              ),
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
              'Invoice Receipt',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 100.w,
        height: 100.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[600]!, Colors.green[400]!],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 50.sp,
        ),
      ),
    );
  }

  Widget _buildReceiptCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Payment Successful',
            style: GoogleFonts.inter(
              color: Colors.green[400],
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            '\$${widget.invoice.totalAmount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 36.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 24.h),
          _buildDetailRow('Invoice', widget.invoice.title),
          _buildDivider(),
          _buildDetailRow(
              'ID', widget.invoice.id.substring(0, 8).toUpperCase()),
          _buildDivider(),
          _buildDetailRow('Type', widget.invoice.typeDisplayName),
          _buildDivider(),
          if (widget.invoice.toName != null) ...[
            _buildDetailRow('To', widget.invoice.toName!),
            _buildDivider(),
          ],
          _buildDetailRow('Status', 'Paid'),
          _buildDivider(),
          _buildDetailRow('Date', _formatDate(DateTime.now())),
          if (widget.invoice.items.isNotEmpty) ...[
            _buildDivider(),
            _buildDetailRow(
                'Items', '${widget.invoice.items.length} item(s)'),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
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
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[800],
      height: 1,
    );
  }

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.download,
            label: 'Download',
            onTap: () {
              Get.snackbar(
                'Download',
                'Invoice PDF download coming soon',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: InvoiceThemeColors.secondaryBackground,
                colorText: Colors.white,
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton(
            icon: Icons.share,
            label: 'Share',
            onTap: () {
              Get.snackbar(
                'Share',
                'Invoice sharing coming soon',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: InvoiceThemeColors.secondaryBackground,
                colorText: Colors.white,
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton(
            icon: Icons.visibility,
            label: 'Preview',
            onTap: () {
              Get.toNamed(AppRoutes.invoicePreview,
                  arguments: widget.invoice);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: InvoiceThemeColors.primaryPurple, size: 24.sp),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
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
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton.icon(
              onPressed: _openTagRecipients,
              icon: Icon(Icons.send, size: 20.sp),
              label: Text(
                'Tag & Send to User',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.primaryPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.invoice),
              child: Text(
                'Back to Invoices',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openTagRecipients() async {
    final result = await Get.to<List<SelectedUser>>(
      () => TagRecipientsScreen(
        onSearch: (query) async {
          try {
            final cubit = context.read<InvoiceCubit>();
            final users = await cubit.repository.searchUsers(query);
            return users;
          } catch (e) {
            return [];
          }
        },
      ),
    );
    if (result != null && result.isNotEmpty) {
      if (mounted) {
        // Tag the invoice to selected users
        try {
          final cubit = context.read<InvoiceCubit>();
          await cubit.repository.tagUsersToInvoice(
            widget.invoice.id,
            result.map((u) => u.userId).toList(),
            [],
            [],
          );
          Get.snackbar(
            'Tagged',
            'Invoice sent to ${result.length} user(s)',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withValues(alpha: 0.8),
            colorText: Colors.white,
          );
        } catch (e) {
          Get.snackbar(
            'Error',
            'Failed to tag users. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withValues(alpha: 0.8),
            colorText: Colors.white,
          );
        }
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
