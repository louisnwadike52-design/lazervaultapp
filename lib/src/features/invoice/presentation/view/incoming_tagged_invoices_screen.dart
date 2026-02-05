import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/invoice/domain/entities/tagged_invoice_entity.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/tagged_invoice_cubit.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/tagged_invoice_state.dart';
import 'package:lazervault/src/generated/common.pbenum.dart';
import 'package:lazervault/src/features/invoice/presentation/widgets/pay_tagged_invoice_dialog.dart';

class IncomingTaggedInvoicesScreen extends StatefulWidget {
  const IncomingTaggedInvoicesScreen({super.key});

  @override
  State<IncomingTaggedInvoicesScreen> createState() =>
      _IncomingTaggedInvoicesScreenState();
}

class _IncomingTaggedInvoicesScreenState
    extends State<IncomingTaggedInvoicesScreen> {
  InvoicePaymentStatus? _currentFilter;

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  void _loadInvoices() {
    context.read<TaggedInvoiceCubit>().loadIncomingInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            BlocBuilder<TaggedInvoiceCubit, TaggedInvoiceState>(
              builder: (context, state) {
                if (state is IncomingTaggedInvoicesLoaded) {
                  return _buildStatisticsCard(state.statistics);
                }
                return const SizedBox.shrink();
              },
            ),
            _buildFilterTabs(),
            Expanded(
              child: BlocConsumer<TaggedInvoiceCubit, TaggedInvoiceState>(
                listener: (context, state) {
                  if (state is TaggedInvoicePaymentSuccess) {
                    _showPaymentSuccess(state);
                  } else if (state is TaggedInvoiceError) {
                    _showError(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is TaggedInvoiceLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xFF3B82F6),
                        ),
                      ),
                    );
                  }

                  if (state is IncomingTaggedInvoicesLoaded) {
                    if (state.invoices.isEmpty) {
                      return _buildEmptyState();
                    }
                    return _buildInvoicesList(state);
                  }

                  if (state is TaggedInvoicePaymentProcessing) {
                    return _buildProcessingState(state.message);
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
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
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
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
                  'Invoices to Pay',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Invoices you\'ve been tagged to pay',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsCard(TaggedInvoiceStatistics statistics) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total to Pay',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${statistics.pendingInvoices} pending',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                statistics.formattedPending('USD'),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (statistics.overdueInvoices > 0)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${statistics.overdueInvoices} overdue',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      height: 44.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('All', null),
          SizedBox(width: 12.w),
          _buildFilterChip(
              'Pending', InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_PENDING),
          SizedBox(width: 12.w),
          _buildFilterChip('Overdue',
              InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_OVERDUE),
          SizedBox(width: 12.w),
          _buildFilterChip(
              'Paid', InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_COMPLETED),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, InvoicePaymentStatus? filter) {
    final isSelected = _currentFilter == filter;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentFilter = filter;
        });
        context.read<TaggedInvoiceCubit>().filterIncomingByStatus(filter);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF3B82F6)
                : const Color(0xFF374151),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80.sp,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(height: 24.h),
          Text(
            'No Invoices to Pay',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'You haven\'t been tagged to any invoices yet.\nWhen someone tags you to pay an invoice, it will appear here.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoicesList(IncomingTaggedInvoicesLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TaggedInvoiceCubit>().refreshIncoming();
      },
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color(0xFF3B82F6),
      child: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: state.invoices.length,
        itemBuilder: (context, index) {
          return _buildInvoiceCard(state.invoices[index]);
        },
      ),
    );
  }

  Widget _buildInvoiceCard(TaggedInvoice invoice) {
    final isPending = invoice.isPending;
    final isOverdue = invoice.isOverdue;

    final statusColor = isOverdue
        ? const Color(0xFFEF4444)
        : isPending
            ? const Color(0xFF3B82F6)
            : const Color(0xFF10B981);
    final creatorName = invoice.displayName;
    final receiverName = invoice.invoice?.toName ?? 'You';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: title + status badge + amount
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  invoice.isPaid ? Icons.check_circle : isOverdue ? Icons.warning_rounded : Icons.receipt_long,
                  color: statusColor,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      invoice.title,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    _buildStatusBadge(invoice),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    invoice.formattedAmount,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (invoice.description.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Text(
              invoice.description,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          SizedBox(height: 14.h),
          Divider(color: const Color(0xFF2D2D2D), height: 1),
          SizedBox(height: 14.h),
          // Creator & Receiver row
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.arrow_upward_rounded, color: const Color(0xFFEF4444), size: 14.sp),
                    SizedBox(width: 4.w),
                    Text('From: ', style: GoogleFonts.inter(color: const Color(0xFF909090), fontSize: 12.sp, fontWeight: FontWeight.w500)),
                    Flexible(
                      child: Text(
                        creatorName,
                        style: GoogleFonts.inter(color: const Color(0xFFD0D0D0), fontSize: 12.sp, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Row(
                  children: [
                    Icon(Icons.arrow_downward_rounded, color: const Color(0xFF10B981), size: 14.sp),
                    SizedBox(width: 4.w),
                    Text('To: ', style: GoogleFonts.inter(color: const Color(0xFF909090), fontSize: 12.sp, fontWeight: FontWeight.w500)),
                    Flexible(
                      child: Text(
                        receiverName,
                        style: GoogleFonts.inter(color: const Color(0xFFD0D0D0), fontSize: 12.sp, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Due date row
          if (invoice.invoice?.dueDate != null) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 13.sp,
                  color: isOverdue ? const Color(0xFFEF4444) : const Color(0xFF909090),
                ),
                SizedBox(width: 4.w),
                Text(
                  'Due ${_formatDate(invoice.invoice!.dueDate!)}',
                  style: GoogleFonts.inter(
                    color: isOverdue ? const Color(0xFFEF4444) : const Color(0xFFB0B0B0),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
          // Quick Pay button
          if (isPending) ...[
            SizedBox(height: 14.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showPaymentDialog(invoice),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.payment, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Quick Pay',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(TaggedInvoice invoice) {
    Color backgroundColor;
    Color textColor;
    String text;

    if (invoice.isOverdue) {
      backgroundColor = const Color(0xFFEF4444);
      textColor = Colors.white;
      text = 'OVERDUE';
    } else if (invoice.isPending) {
      backgroundColor = const Color(0xFF3B82F6).withValues(alpha: 0.2);
      textColor = const Color(0xFF3B82F6);
      text = 'PENDING';
    } else if (invoice.isPaid) {
      backgroundColor = const Color(0xFF10B981).withValues(alpha: 0.2);
      textColor = const Color(0xFF10B981);
      text = 'PAID';
    } else {
      backgroundColor = const Color(0xFF6B7280).withValues(alpha: 0.2);
      textColor = const Color(0xFF6B7280);
      text = invoice.statusText.toUpperCase();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildProcessingState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color(0xFF3B82F6),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog(TaggedInvoice invoice) {
    showDialog(
      context: context,
      builder: (context) => PayTaggedInvoiceDialog(invoice: invoice),
    );
  }

  void _showPaymentSuccess(TaggedInvoicePaymentSuccess state) {
    // Snackbar removed - user is navigated to receipt page which shows payment details
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference < 0) {
      return '${difference.abs()} days ago';
    } else if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
