import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../cubit/create_invoice_cubit.dart';

/// Screen 5: Review & Confirm
///
/// Final review of all invoice details before creation
class InvoiceReviewScreen extends StatefulWidget {
  const InvoiceReviewScreen({super.key});

  @override
  State<InvoiceReviewScreen> createState() => _InvoiceReviewScreenState();
}

class _InvoiceReviewScreenState extends State<InvoiceReviewScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: BlocBuilder<CreateInvoiceCubit, dynamic>(
        builder: (context, state) {
          final cubit = context.read<CreateInvoiceCubit>();

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 32.h),
                _buildBasicInfoCard(cubit),
                SizedBox(height: 16.h),
                _buildRecipientCard(cubit),
                SizedBox(height: 16.h),
                _buildPayerCard(cubit),
                SizedBox(height: 16.h),
                _buildItemsCard(cubit),
                SizedBox(height: 16.h),
                _buildTotalCard(cubit),
                if (cubit.notes.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  _buildNotesCard(cubit),
                ],
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review Invoice',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Please review all details before creating the invoice',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildBasicInfoCard(CreateInvoiceCubit cubit) {
    final dueDate = cubit.dueDate;
    final formattedDate = dueDate != null
        ? DateFormat('MMM dd, yyyy').format(dueDate)
        : 'No due date';

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                size: 24.sp,
                color: const Color(0xFF3B82F6),
              ),
              SizedBox(width: 12.w),
              Text(
                'Invoice Details',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildInfoRow('Type', _getTypeLabel(cubit.invoiceType)),
          SizedBox(height: 12.h),
          _buildInfoRow('Title', cubit.title),
          SizedBox(height: 12.h),
          _buildInfoRow('Description', cubit.description),
          SizedBox(height: 12.h),
          _buildInfoRow('Due Date', formattedDate),
        ],
      ),
    );
  }

  Widget _buildRecipientCard(CreateInvoiceCubit cubit) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 24.sp,
                color: const Color(0xFF3B82F6),
              ),
              SizedBox(width: 12.w),
              Text(
                'Recipient',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (cubit.recipientCompany.isNotEmpty)
            _buildInfoRow('Company', cubit.recipientCompany),
          if (cubit.recipientCompany.isNotEmpty) SizedBox(height: 12.h),
          _buildInfoRow('Contact', cubit.recipientContact),
          SizedBox(height: 12.h),
          _buildInfoRow('Email', cubit.recipientEmail),
          if (cubit.recipientPhone.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildInfoRow('Phone', cubit.recipientPhone),
          ],
          if (cubit.recipientAddress1.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildInfoRow('Address', _formatAddress(
              cubit.recipientAddress1,
              cubit.recipientAddress2,
              cubit.recipientCity,
              cubit.recipientState,
              cubit.recipientPostcode,
              cubit.recipientCountry,
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildPayerCard(CreateInvoiceCubit cubit) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.business,
                size: 24.sp,
                color: const Color(0xFF3B82F6),
              ),
              SizedBox(width: 12.w),
              Text(
                'Payer (You)',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (cubit.payerImage != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.file(
                cubit.payerImage!,
                height: 100.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 12.h),
          ],
          if (cubit.payerCompany.isNotEmpty)
            _buildInfoRow('Company', cubit.payerCompany),
          if (cubit.payerCompany.isNotEmpty) SizedBox(height: 12.h),
          _buildInfoRow('Contact', cubit.payerContact),
          SizedBox(height: 12.h),
          _buildInfoRow('Email', cubit.payerEmail),
          if (cubit.payerPhone.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildInfoRow('Phone', cubit.payerPhone),
          ],
          if (cubit.payerAddress1.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildInfoRow('Address', _formatAddress(
              cubit.payerAddress1,
              cubit.payerAddress2,
              cubit.payerCity,
              cubit.payerState,
              cubit.payerPostcode,
              cubit.payerCountry,
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildItemsCard(CreateInvoiceCubit cubit) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.list_alt,
                size: 24.sp,
                color: const Color(0xFF3B82F6),
              ),
              SizedBox(width: 12.w),
              Text(
                'Items (${cubit.items.length})',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...cubit.items.map((item) {
            final total = item.unitPrice * item.quantity;
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (item.description?.isNotEmpty == true) ...[
                      SizedBox(height: 4.h),
                      Text(
                        item.description!,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.quantity} × \$${item.unitPrice.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTotalCard(CreateInvoiceCubit cubit) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildTotalRow('Subtotal', cubit.subtotal),
          if (cubit.taxAmount > 0) ...[
            SizedBox(height: 12.h),
            _buildTotalRow('Tax', cubit.taxAmount),
          ],
          if (cubit.discountAmount > 0) ...[
            SizedBox(height: 12.h),
            _buildTotalRow('Discount', -cubit.discountAmount),
          ],
          SizedBox(height: 16.h),
          Divider(color: Colors.white.withValues(alpha: 0.3)),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                '\$${cubit.total.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(CreateInvoiceCubit cubit) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note,
                size: 24.sp,
                color: const Color(0xFF3B82F6),
              ),
              SizedBox(width: 12.w),
              Text(
                'Notes',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            cubit.notes,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _getTypeLabel(dynamic type) {
    return type.toString().split('.').last.capitalize();
  }

  String _formatAddress(
    String address1,
    String address2,
    String city,
    String state,
    String postcode,
    String country,
  ) {
    final parts = <String>[];
    if (address1.isNotEmpty) parts.add(address1);
    if (address2.isNotEmpty) parts.add(address2);

    final cityStateParts = <String>[];
    if (city.isNotEmpty) cityStateParts.add(city);
    if (state.isNotEmpty) cityStateParts.add(state);
    if (postcode.isNotEmpty) cityStateParts.add(postcode);

    if (cityStateParts.isNotEmpty) {
      parts.add(cityStateParts.join(', '));
    }

    if (country.isNotEmpty) parts.add(country);

    return parts.join('\n');
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
