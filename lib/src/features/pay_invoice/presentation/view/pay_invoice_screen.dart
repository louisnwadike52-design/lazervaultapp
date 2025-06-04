import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' hide Transition;
import 'package:get/get.dart' as GetX;

import '../../domain/entities/tagged_invoice_entity.dart';
import '../cubit/pay_invoice_cubit.dart';
import '../cubit/pay_invoice_state.dart';
import 'widgets/invoice_payment_card.dart';
import 'payment_method_selection_screen.dart';
import 'invoice_details_screen.dart';

class PayInvoiceScreen extends StatefulWidget {
  const PayInvoiceScreen({super.key});

  @override
  State<PayInvoiceScreen> createState() => _PayInvoiceScreenState();
}

class _PayInvoiceScreenState extends State<PayInvoiceScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    
    // Load initial data
    context.read<PayInvoiceCubit>().loadTaggedInvoices();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildTabBar(),
            Expanded(
              child: BlocConsumer<PayInvoiceCubit, PayInvoiceState>(
                listener: (context, state) {
                  if (state is PayInvoiceError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: const Color(0xFFEF4444),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 150.h,
                          right: 20.w,
                          left: 20.w,
                        ),
                      ),
                    );
                  } else if (state is PayInvoicePaymentSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: const Color(0xFF10B981),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 150.h,
                          right: 20.w,
                          left: 20.w,
                        ),
                      ),
                    );
                  } else if (state is PayInvoicePaymentFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: const Color(0xFFEF4444),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 150.h,
                          right: 20.w,
                          left: 20.w,
                        ),
                      ),
                    );
                  } else if (state is PayInvoiceOperationSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: const Color(0xFF10B981),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height - 150.h,
                          right: 20.w,
                          left: 20.w,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _buildInvoiceList(state, PaymentStatus.pending),
                      _buildInvoiceList(state, PaymentStatus.completed),
                      _buildOverdueInvoices(state),
                      _buildAllInvoices(state),
                    ],
                  );
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
                  'Pay Invoice',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Review and pay your invoices',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          _buildNotificationBadge(),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge() {
    return BlocBuilder<PayInvoiceCubit, PayInvoiceState>(
      builder: (context, state) {
        int overdueCount = 0;
        if (state is PayInvoicesLoaded) {
          overdueCount = state.invoices.where((invoice) => 
            invoice.isOverdue && invoice.paymentStatus != PaymentStatus.completed
          ).length;
        }

        return Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              if (overdueCount > 0)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        overdueCount > 9 ? '9+' : overdueCount.toString(),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: const Color(0xFF9CA3AF),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                if (value.isEmpty) {
                  context.read<PayInvoiceCubit>().loadTaggedInvoices();
                } else {
                  context.read<PayInvoiceCubit>().searchInvoices(value);
                }
              },
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search invoices...',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
                context.read<PayInvoiceCubit>().loadTaggedInvoices();
              },
              child: Icon(
                Icons.clear,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        onTap: (index) {
          switch (index) {
            case 0:
              context.read<PayInvoiceCubit>().loadInvoicesByStatus(PaymentStatus.pending);
              break;
            case 1:
              context.read<PayInvoiceCubit>().loadInvoicesByStatus(PaymentStatus.completed);
              break;
            case 2:
              context.read<PayInvoiceCubit>().loadOverdueInvoices();
              break;
            case 3:
              context.read<PayInvoiceCubit>().loadTaggedInvoices();
              break;
          }
        },
        indicator: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF6366F1),
              const Color(0xFF8B5CF6),
              const Color(0xFF3B82F6),
            ],
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(4.w),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: 'Pending'),
          Tab(text: 'Paid'),
          Tab(text: 'Overdue'),
          Tab(text: 'All'),
        ],
      ),
    );
  }

  Widget _buildInvoiceList(PayInvoiceState state, PaymentStatus statusFilter) {
    if (state is PayInvoiceLoading) {
      return _buildLoadingState();
    }

    if (state is PayInvoicesLoaded) {
      final filteredInvoices = state.invoices
          .where((invoice) => invoice.paymentStatus == statusFilter)
          .toList();

      if (filteredInvoices.isEmpty) {
        return _buildEmptyState(statusFilter);
      }

      return RefreshIndicator(
        onRefresh: () => context.read<PayInvoiceCubit>().refresh(),
        backgroundColor: const Color(0xFF1F1F1F),
        color: const Color(0xFF6366F1),
        child: ListView.builder(
          padding: EdgeInsets.all(20.w),
          itemCount: filteredInvoices.length,
          itemBuilder: (context, index) {
            final invoice = filteredInvoices[index];
            return InvoicePaymentCard(
              invoice: invoice,
              onTap: () => _showInvoiceDetails(invoice),
              onPay: statusFilter == PaymentStatus.pending 
                  ? () => _showPaymentSheet(invoice) 
                  : null,
            );
          },
        ),
      );
    }

    return _buildEmptyState(statusFilter);
  }

  Widget _buildOverdueInvoices(PayInvoiceState state) {
    if (state is PayInvoiceLoading) {
      return _buildLoadingState();
    }

    if (state is PayInvoicesLoaded) {
      final overdueInvoices = state.invoices
          .where((invoice) => invoice.isOverdue && 
                             invoice.paymentStatus != PaymentStatus.completed)
          .toList();

      if (overdueInvoices.isEmpty) {
        return _buildEmptyState(null, isOverdue: true);
      }

      return RefreshIndicator(
        onRefresh: () => context.read<PayInvoiceCubit>().refresh(),
        backgroundColor: const Color(0xFF1F1F1F),
        color: const Color(0xFF6366F1),
        child: ListView.builder(
          padding: EdgeInsets.all(20.w),
          itemCount: overdueInvoices.length,
          itemBuilder: (context, index) {
            final invoice = overdueInvoices[index];
            return InvoicePaymentCard(
              invoice: invoice,
              onTap: () => _showInvoiceDetails(invoice),
              onPay: () => _showPaymentSheet(invoice),
              isOverdue: true,
            );
          },
        ),
      );
    }

    return _buildEmptyState(null, isOverdue: true);
  }

  Widget _buildAllInvoices(PayInvoiceState state) {
    if (state is PayInvoiceLoading) {
      return _buildLoadingState();
    }

    if (state is PayInvoicesLoaded) {
      if (state.invoices.isEmpty) {
        return _buildEmptyState(null);
      }

      return RefreshIndicator(
        onRefresh: () => context.read<PayInvoiceCubit>().refresh(),
        backgroundColor: const Color(0xFF1F1F1F),
        color: const Color(0xFF6366F1),
        child: ListView.builder(
          padding: EdgeInsets.all(20.w),
          itemCount: state.invoices.length,
          itemBuilder: (context, index) {
            final invoice = state.invoices[index];
            return InvoicePaymentCard(
              invoice: invoice,
              onTap: () => _showInvoiceDetails(invoice),
              onPay: invoice.paymentStatus == PaymentStatus.pending 
                  ? () => _showPaymentSheet(invoice) 
                  : null,
              isOverdue: invoice.isOverdue && 
                        invoice.paymentStatus != PaymentStatus.completed,
            );
          },
        ),
      );
    }

    return _buildEmptyState(null);
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF6366F1)),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading invoices...',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(PaymentStatus? status, {bool isOverdue = false}) {
    String title;
    String subtitle;
    IconData icon;

    if (isOverdue) {
      title = 'No overdue invoices';
      subtitle = 'Great! You\'re all caught up with your payments';
      icon = Icons.check_circle_outline;
    } else if (status == PaymentStatus.pending) {
      title = 'No pending invoices';
      subtitle = 'All your invoices have been paid';
      icon = Icons.receipt_long_outlined;
    } else if (status == PaymentStatus.completed) {
      title = 'No paid invoices';
      subtitle = 'Your payment history will appear here';
      icon = Icons.payment_outlined;
    } else {
      title = 'No invoices found';
      subtitle = 'Tagged invoices will appear here when sent to you';
      icon = Icons.inbox_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(
              icon,
              size: 40.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showInvoiceDetails(TaggedInvoice invoice) {
    HapticFeedback.lightImpact();
    
    Get.to(
      () => InvoiceDetailsScreen(invoice: invoice),
      transition: GetX.Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _showPaymentSheet(TaggedInvoice invoice) {
    HapticFeedback.lightImpact();
    
    // Navigate to payment method selection screen
    Get.to(
      () => PaymentMethodSelectionScreen(invoice: invoice),
      transition: GetX.Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }
} 