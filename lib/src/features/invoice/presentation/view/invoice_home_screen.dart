import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import '../cubit/tagged_invoice_cubit.dart';
import '../cubit/tagged_invoice_state.dart';
import '../widgets/invoice_voice_agent_button.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class InvoiceHomeScreen extends StatefulWidget {
  const InvoiceHomeScreen({super.key});

  @override
  State<InvoiceHomeScreen> createState() => _InvoiceHomeScreenState();
}

class _InvoiceHomeScreenState extends State<InvoiceHomeScreen> {
  // Note: Invoice data is pre-loaded in app router, no need to load in initState

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
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMetricsCard(context),
                    SizedBox(height: 24.h),
                    _buildActionButtons(context),
                    SizedBox(height: 32.h),
                    _buildRecentActivity(context),
                  ],
                ),
              ),
            ),
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: InvoiceThemeColors.textWhite,
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
                  'Invoices',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textWhite,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Create, send & track payments',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textGray400,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          // Chat Agent Icon
          MicroserviceChatIcon(
            serviceName: 'Invoices',
            sourceContext: 'invoices',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF8B5CF6),
          ),
          SizedBox(width: 8.w),
          // Voice Agent Button
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, authState) {
              final accessToken = authState is AuthenticationSuccess
                  ? authState.profile.session.accessToken
                  : null;

              return GestureDetector(
                onTap: () {
                  // Show the full voice control widget in a bottom sheet
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      decoration: BoxDecoration(
                        color: InvoiceThemeColors.secondaryBackground,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                      ),
                      child: InvoiceVoiceAgentControl(
                        accessToken: accessToken,
                        onConnected: () {
                          // Refresh invoices when connected
                          context.read<InvoiceCubit>().loadInvoices();
                          context.read<TaggedInvoiceCubit>().loadIncomingInvoices();
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(22.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsCard(BuildContext context) {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, invoiceState) {
        return BlocBuilder<TaggedInvoiceCubit, TaggedInvoiceState>(
          builder: (context, taggedState) {
            // Show loading if either is loading
            if (invoiceState is InvoiceLoading || taggedState is TaggedInvoiceLoading) {
              return _buildLoadingCard();
            }

            // Show error if either has error
            if (invoiceState is InvoiceError) {
              return _buildErrorCard(invoiceState.message);
            }
            if (taggedState is TaggedInvoiceError) {
              return _buildErrorCard(taggedState.message);
            }

            // Combine metrics from both outgoing and incoming invoices
            if (invoiceState is InvoicesLoaded || taggedState is IncomingTaggedInvoicesLoaded) {
              return _buildCombinedMetricsContent(invoiceState, taggedState);
            }

            return _buildEmptyMetricsCard();
          },
        );
      },
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            InvoiceThemeColors.primaryPurple,
            InvoiceThemeColors.gradientPurple,
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(InvoiceThemeColors.textWhite),
        ),
      ),
    );
  }

  Widget _buildCombinedMetricsContent(InvoiceState invoiceState, TaggedInvoiceState taggedState) {
    // Get outgoing invoice stats (invoices you created/sent)
    int sentTotal = 0;
    int sentPaid = 0;
    int sentPending = 0;
    double sentAmount = 0.0;

    if (invoiceState is InvoicesLoaded) {
      final stats = invoiceState.statistics ?? {};
      sentTotal = stats['total_invoices'] ?? 0;
      sentPaid = stats['paid_invoices'] ?? 0;
      sentPending = stats['unpaid_invoices'] ?? 0;
      sentAmount = (stats['total_amount'] ?? 0.0) as double;
    }

    // Get incoming invoice stats (invoices you received)
    int receivedTotal = 0;
    int receivedPaid = 0;
    int receivedPending = 0;
    double receivedAmount = 0.0;

    if (taggedState is IncomingTaggedInvoicesLoaded) {
      receivedTotal = taggedState.invoices.length;
      receivedPaid = taggedState.invoices.where((inv) => inv.paymentStatus == 'completed' || inv.paymentStatus == 'paid').length;
      receivedPending = taggedState.invoices.where((inv) => inv.paymentStatus == 'pending').length;
      receivedAmount = taggedState.invoices.fold<double>(0.0, (sum, inv) => sum + inv.amount);
    }

    // Combine totals
    final totalInvoices = sentTotal + receivedTotal;
    final totalPaid = sentPaid + receivedPaid;
    final totalPending = sentPending + receivedPending;
    final totalAmount = sentAmount + receivedAmount;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            InvoiceThemeColors.primaryPurple,
            InvoiceThemeColors.gradientPurple,
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: InvoiceThemeColors.primaryPurple.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long,
            size: 48.sp,
            color: InvoiceThemeColors.textWhite,
          ),
          SizedBox(height: 16.h),
          Text(
            'Invoice Overview',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textWhite,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Sent & Received',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textWhite.withOpacity(0.8),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 24.h),
          // First row: Received and Sent totals
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem(
                label: 'Received',
                value: receivedTotal.toString(),
                color: const Color(0xFF10B981),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: InvoiceThemeColors.textWhite.withOpacity(0.2),
              ),
              _buildMetricItem(
                label: 'Sent',
                value: sentTotal.toString(),
                color: const Color(0xFFFB923C),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Second row: Paid and Pending totals
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem(
                label: 'Paid',
                value: totalPaid.toString(),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: InvoiceThemeColors.textWhite.withOpacity(0.2),
              ),
              _buildMetricItem(
                label: 'Pending',
                value: totalPending.toString(),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Total Value section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Value',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textWhite.withOpacity(0.8),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '\$${(totalAmount / 100).toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textWhite,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    Color? color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            color: color ?? InvoiceThemeColors.textWhite,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            color: (color ?? InvoiceThemeColors.textWhite).withOpacity(0.8),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 48.sp,
            color: const Color(0xFFEF4444),
          ),
          SizedBox(height: 16.h),
          Text(
            'Failed to Load',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textWhite,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMetricsCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            InvoiceThemeColors.primaryPurple,
            InvoiceThemeColors.gradientPurple,
          ],
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long,
            size: 48.sp,
            color: InvoiceThemeColors.textWhite,
          ),
          SizedBox(height: 16.h),
          Text(
            'Start Invoicing',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textWhite,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create invoices or pay received ones',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textWhite.withOpacity(0.8),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.arrow_downward,
            label: 'Received',
            color: const Color(0xFF10B981),
            onTap: () => Get.toNamed(AppRoutes.incomingTaggedInvoices),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildActionButton(
            icon: Icons.arrow_upward,
            label: 'Sent',
            color: const Color(0xFFFB923C),
            onTap: () => Get.toNamed(AppRoutes.invoiceList),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32.sp,
              color: color,
            ),
            SizedBox(height: 12.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textWhite,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return BlocBuilder<TaggedInvoiceCubit, TaggedInvoiceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Invoices',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textWhite,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (state is IncomingTaggedInvoicesLoaded && state.invoices.isNotEmpty)
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.invoiceList),
                    child: Text(
                      'View All',
                      style: GoogleFonts.inter(
                        color: InvoiceThemeColors.primaryPurple,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.h),

            if (state is TaggedInvoiceLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(32.h),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(InvoiceThemeColors.primaryPurple),
                  ),
                ),
              )
            else if (state is TaggedInvoiceError)
              _buildActivityError(state.message)
            else if (state is IncomingTaggedInvoicesLoaded)
              state.invoices.isEmpty
                  ? _buildEmptyActivity()
                  : Column(
                      children: state.invoices.take(3).map((invoice) {
                        return _buildInvoiceItem(invoice);
                      }).toList(),
                    )
            else
              _buildEmptyActivity(),
          ],
        );
      },
    );
  }

  Widget _buildActivityError(String error) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 48.sp,
            color: const Color(0xFFEF4444),
          ),
          SizedBox(height: 16.h),
          Text(
            'Failed to Load Invoices',
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textWhite,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            error,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              context.read<TaggedInvoiceCubit>().loadIncomingInvoices();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.primaryPurple,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textWhite,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyActivity() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_outlined,
              size: 48.sp,
              color: const Color(0xFF6B7280),
            ),
            SizedBox(height: 16.h),
            Text(
              'No Recent Invoices',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Create your first invoice or check received ones',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray400,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceItem(dynamic invoice) {
    final isPaid = invoice.status.toLowerCase() == 'paid';
    final statusColor = isPaid ? const Color(0xFF10B981) : const Color(0xFFFB923C);

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.invoiceDetails,
        arguments: invoice.id,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: InvoiceThemeColors.borderColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                isPaid ? Icons.check_circle : Icons.pending,
                color: statusColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invoice.recipientName ?? 'Unknown',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textWhite,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    invoice.createdAt != null
                        ? _formatDate(invoice.createdAt!)
                        : 'Date unknown',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray400,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${(invoice.amount / 100).toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textWhite,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    invoice.status.toUpperCase(),
                    style: GoogleFonts.inter(
                      color: statusColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
