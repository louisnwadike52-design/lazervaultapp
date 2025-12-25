import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/invoice/domain/entities/tagged_invoice_entity.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/tagged_invoice_cubit.dart';
import 'package:lazervault/src/features/invoice/presentation/cubit/tagged_invoice_state.dart';
import 'package:lazervault/src/generated/common.pbenum.dart';
import 'package:lazervault/core/types/app_routes.dart';

class OutgoingTaggedInvoicesScreen extends StatefulWidget {
  const OutgoingTaggedInvoicesScreen({Key? key}) : super(key: key);

  @override
  State<OutgoingTaggedInvoicesScreen> createState() =>
      _OutgoingTaggedInvoicesScreenState();
}

class _OutgoingTaggedInvoicesScreenState
    extends State<OutgoingTaggedInvoicesScreen> {
  InvoicePaymentStatus? _currentFilter;

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  void _loadInvoices() {
    context.read<TaggedInvoiceCubit>().loadOutgoingInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.createInvoice),
        backgroundColor: const Color(0xFF3B82F6),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'New Invoice',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            BlocBuilder<TaggedInvoiceCubit, TaggedInvoiceState>(
              builder: (context, state) {
                if (state is OutgoingTaggedInvoicesLoaded) {
                  return _buildStatisticsCard(state.statistics);
                }
                return const SizedBox.shrink();
              },
            ),
            _buildFilterTabs(),
            Expanded(
              child: BlocBuilder<TaggedInvoiceCubit, TaggedInvoiceState>(
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

                  if (state is OutgoingTaggedInvoicesLoaded) {
                    if (state.invoices.isEmpty) {
                      return _buildEmptyState();
                    }
                    return _buildInvoicesList(state);
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
                  'My Invoices',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Invoices you created and tagged',
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
          colors: [Color(0xFF10B981), Color(0xFF059669)],
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
                'Total Receivable',
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '${statistics.totalInvoices} invoices',
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
                statistics.formattedTotal('USD'),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  _buildMiniStat(
                      '${statistics.pendingInvoices}', 'Pending', Colors.amber),
                  SizedBox(width: 16.w),
                  _buildMiniStat(
                      '${statistics.paidInvoices}', 'Paid', Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String value, String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            color: color,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            color: color.withOpacity(0.8),
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
          _buildFilterChip(
              'Paid', InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_COMPLETED),
          SizedBox(width: 12.w),
          _buildFilterChip('Overdue',
              InvoicePaymentStatus.INVOICE_PAYMENT_STATUS_OVERDUE),
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
        context.read<TaggedInvoiceCubit>().filterOutgoingByStatus(filter);
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
            Icons.receipt_outlined,
            size: 80.sp,
            color: const Color(0xFF6B7280),
          ),
          SizedBox(height: 24.h),
          Text(
            'No Invoices Yet',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Create your first invoice and tag users to request payment.\nTap the + button below to get started.',
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

  Widget _buildInvoicesList(OutgoingTaggedInvoicesLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TaggedInvoiceCubit>().refreshOutgoing();
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

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isOverdue
              ? const Color(0xFFEF4444)
              : isPending
                  ? const Color(0xFFEAB308)
                  : const Color(0xFF10B981),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Tagged to who + status badge
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF374151),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'To: ${invoice.displayName}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (invoice.displayUsername.isNotEmpty)
                      Text(
                        '@${invoice.displayUsername}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              ),
              _buildStatusBadge(invoice),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: const Color(0xFF374151), height: 1),
          SizedBox(height: 16.h),
          // Invoice details
          Text(
            invoice.title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (invoice.description.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              invoice.description,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          SizedBox(height: 16.h),
          // Amount and action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    invoice.formattedAmount,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (isPending)
                    OutlinedButton(
                      onPressed: () {
                        // TODO: Send reminder functionality
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3B82F6),
                        side: const BorderSide(color: Color(0xFF3B82F6)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.notifications_outlined, size: 16.sp),
                          SizedBox(width: 6.w),
                          Text(
                            'Remind',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(width: 8.w),
                  IconButton(
                    onPressed: () {
                      // TODO: Share invoice
                    },
                    icon: Icon(
                      Icons.share_outlined,
                      color: const Color(0xFF9CA3AF),
                      size: 20.sp,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(0xFF374151),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (invoice.invoice?.dueDate != null) ...[
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14.sp,
                  color: isOverdue
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF9CA3AF),
                ),
                SizedBox(width: 6.w),
                Text(
                  'Due: ${_formatDate(invoice.invoice!.dueDate!)}',
                  style: GoogleFonts.inter(
                    color: isOverdue
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
      backgroundColor = const Color(0xFFEAB308).withOpacity(0.2);
      textColor = const Color(0xFFEAB308);
      text = 'PENDING';
    } else if (invoice.isPaid) {
      backgroundColor = const Color(0xFF10B981).withOpacity(0.2);
      textColor = const Color(0xFF10B981);
      text = 'PAID';
    } else {
      backgroundColor = const Color(0xFF6B7280).withOpacity(0.2);
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
