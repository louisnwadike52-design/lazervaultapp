import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';

import '../../domain/entities/invoice_entity.dart';
import '../../services/invoice_pdf_service.dart';
import '../../data/models/pagination_model.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import '../widgets/invoice_card.dart';
import '../widgets/invoice_statistics_card.dart';
import '../widgets/invoice_filter_chip.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  final TextEditingController _searchController = TextEditingController();
  InvoiceStatus? _selectedFilter;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        if (authState is AuthenticationSuccess) {
          // Set user ID in invoice cubit when authenticated
          context.read<InvoiceCubit>().setUserId(authState.profile.user.id);
        }
      },
      builder: (context, authState) {
        // Show loading if not authenticated yet
        if (authState is! AuthenticationSuccess) {
          return _buildAuthLoadingScreen();
        }
        return _buildInvoiceScreen();
      },
    );
  }

  Widget _buildAuthLoadingScreen() {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: InvoiceThemeColors.primaryPurple),
                    SizedBox(height: 16.h),
                    Text(
                      'Loading your invoices...',
                      style: InvoiceTextStyles.body14,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceScreen() {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchAndFilters(),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader() {
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
                color: InvoiceThemeColors.textWhite,
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
                  'Sent Invoices',
                  style: InvoiceTextStyles.header28,
                ),
                Text(
                  'Track invoices you\'ve created',
                  style: InvoiceTextStyles.body14,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showOptionsMenu(),
            icon: Icon(
              Icons.more_vert,
              color: InvoiceThemeColors.textWhite,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: InvoiceThemeColors.secondaryBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: InvoiceThemeColors.borderColor),
            ),
            child: TextField(
              controller: _searchController,
              style: InvoiceTextStyles.body16,
              decoration: InputDecoration(
                hintText: 'Search invoices...',
                hintStyle: GoogleFonts.inter(color: InvoiceThemeColors.textGray500),
                prefixIcon: Icon(Icons.search, color: InvoiceThemeColors.textGray500),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          context.read<InvoiceCubit>().loadInvoices();
                        },
                        icon: Icon(Icons.close, color: InvoiceThemeColors.textGray500),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
              onChanged: (query) {
                if (query.isNotEmpty) {
                  context.read<InvoiceCubit>().searchInvoices(query: query);
                } else {
                  context.read<InvoiceCubit>().loadInvoices();
                }
              },
            ),
          ),
          SizedBox(height: 16.h),
          
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InvoiceFilterChip(
                  label: 'All',
                  isSelected: _selectedFilter == null,
                  onTap: () => _applyFilter(null),
                ),
                SizedBox(width: 8.w),
                ...InvoiceStatus.values.map((status) => Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: InvoiceFilterChip(
                    label: _getStatusDisplayName(status),
                    isSelected: _selectedFilter == status,
                    onTap: () => _applyFilter(status),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return BlocConsumer<InvoiceCubit, InvoiceState>(
      listener: (context, state) {
        if (state is InvoiceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
        
        if (state is InvoiceOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is InvoiceLoading) {
          return Center(
            child: CircularProgressIndicator(color: InvoiceThemeColors.primaryPurple),
          );
        }

        if (state is InvoicesLoaded) {
          return Column(
            children: [
              if (state.statistics != null) _buildStatistics(state.statistics!),
              Expanded(child: _buildInvoiceList(state.invoices)),
            ],
          );
        }

        if (state is InvoiceSearchResults) {
          return _buildSearchResults(state.results, state.query);
        }

        if (state is InvoiceError) {
          return _buildErrorState(state.message);
        }

        return _buildEmptyState();
      },
    );
  }

  Widget _buildStatistics(Map<String, dynamic> stats) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: InvoiceStatisticsCard(statistics: stats),
    );
  }

  Widget _buildInvoiceList(List<Invoice> invoices) {
    if (invoices.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final invoice = invoices[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: InvoiceCard(
            invoice: invoice,
            onTap: () => _navigateToDetails(invoice),
            onMoreTap: () => _showInvoiceOptions(invoice),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(List<Invoice> results, String query) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Row(
            children: [
              Text(
                'Search results for "$query"',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
              const Spacer(),
              Text(
                '${results.length} found',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
        Expanded(child: _buildInvoiceList(results)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 64.sp,
            color: InvoiceThemeColors.textGray600,
          ),
          SizedBox(height: 16.h),
          Text(
            'No invoices found',
            style: InvoiceTextStyles.header20.copyWith(
              color: InvoiceThemeColors.textGray400,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create your first invoice to get started',
            style: InvoiceTextStyles.body14,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () => _navigateToCreate(),
            icon: const Icon(Icons.add),
            label: const Text('Create Invoice'),
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.primaryPurple,
              foregroundColor: InvoiceThemeColors.textWhite,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: InvoiceThemeColors.errorRed,
          ),
          SizedBox(height: 16.h),
          Text(
            'Something went wrong',
            style: InvoiceTextStyles.header20,
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: InvoiceTextStyles.body14,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<InvoiceCubit>().loadInvoices(),
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.primaryPurple,
              foregroundColor: InvoiceThemeColors.textWhite,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: () => _navigateToCreate(),
      backgroundColor: InvoiceThemeColors.primaryPurple,
      foregroundColor: InvoiceThemeColors.textWhite,
      icon: const Icon(Icons.add),
      label: Text(
        'Create',
        style: InvoiceTextStyles.button14,
      ),
    );
  }

  void _applyFilter(InvoiceStatus? status) {
    setState(() {
      _selectedFilter = status;
    });

    if (status == null) {
      context.read<InvoiceCubit>().loadInvoices();
    } else {
      final filter = InvoiceSearchFilter(statuses: [status.name]);
      context.read<InvoiceCubit>().applyFilters(filter);
    }
  }

  void _navigateToCreate() {
    Get.toNamed(AppRoutes.createInvoice);
  }

  void _navigateToDetails(Invoice invoice) {
    Get.toNamed(AppRoutes.invoiceDetails, arguments: invoice.id);
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: InvoiceDecorations.bottomSheetDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: InvoiceThemeColors.textGray600,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            ListTile(
              leading: Icon(Icons.refresh, color: InvoiceThemeColors.primaryPurple),
              title: Text(
                'Refresh',
                style: InvoiceTextStyles.body16,
              ),
              onTap: () {
                Navigator.pop(context);
                context.read<InvoiceCubit>().loadInvoices();
              },
            ),
            ListTile(
              leading: Icon(Icons.download, color: InvoiceThemeColors.primaryPurple),
              title: Text(
                'Export Data',
                style: InvoiceTextStyles.body16,
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement export functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Export feature coming soon')),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  void _showInvoiceOptions(Invoice invoice) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: InvoiceDecorations.bottomSheetDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: InvoiceThemeColors.textGray600,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            if (invoice.canBeEdited) ...[
              ListTile(
                leading: Icon(Icons.edit, color: InvoiceThemeColors.primaryPurple),
                title: Text('Edit', style: InvoiceTextStyles.body16),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(AppRoutes.createInvoice, arguments: invoice);
                },
              ),
              ListTile(
                leading: Icon(Icons.send, color: InvoiceThemeColors.primaryPurple),
                title: Text('Send', style: InvoiceTextStyles.body16),
                onTap: () {
                  Navigator.pop(context);
                  context.read<InvoiceCubit>().sendInvoice(invoice.id);
                },
              ),
            ],
            if (invoice.status == InvoiceStatus.pending || invoice.isOverdue) ...[
              ListTile(
                leading: Icon(Icons.refresh, color: InvoiceThemeColors.infoBlue),
                title: Text('Resend', style: InvoiceTextStyles.body16),
                onTap: () {
                  Navigator.pop(context);
                  context.read<InvoiceCubit>().sendInvoice(invoice.id);
                },
              ),
            ],
            if (invoice.canBePaid) ...[
              ListTile(
                leading: Icon(Icons.payment, color: InvoiceThemeColors.successGreen),
                title: Text('Mark as Paid', style: InvoiceTextStyles.body16),
                onTap: () {
                  Navigator.pop(context);
                  _showMarkAsPaidDialog(invoice);
                },
              ),
            ],
            ListTile(
              leading: Icon(Icons.share, color: InvoiceThemeColors.primaryPurple),
              title: Text('Share', style: InvoiceTextStyles.body16),
              onTap: () {
                Navigator.pop(context);
                context.read<InvoiceCubit>().shareInvoice(invoice.id, []);
              },
            ),
            if (invoice.status != InvoiceStatus.paid) ...[
              ListTile(
                leading: Icon(Icons.cancel, color: InvoiceThemeColors.warningOrange),
                title: Text('Cancel', style: InvoiceTextStyles.body16),
                onTap: () {
                  Navigator.pop(context);
                  context.read<InvoiceCubit>().cancelInvoice(invoice.id);
                },
              ),
            ],
            ListTile(
              leading: Icon(Icons.delete, color: InvoiceThemeColors.errorRed),
              title: Text('Delete', style: InvoiceTextStyles.body16),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(invoice);
              },
            ),
            ListTile(
              leading: Icon(Icons.visibility, color: InvoiceThemeColors.primaryPurple),
              title: Text('View Details', style: InvoiceTextStyles.body16),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(AppRoutes.invoiceDetails, arguments: invoice.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.download, color: InvoiceThemeColors.successGreen),
              title: Text('Download PDF', style: InvoiceTextStyles.body16),
              onTap: () {
                Navigator.pop(context);
                _downloadInvoice(context, invoice);
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  void _showMarkAsPaidDialog(Invoice invoice) {
    PaymentMethod selectedMethod = PaymentMethod.bank_transfer;
    final referenceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Mark as Paid',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<PaymentMethod>(
              initialValue: selectedMethod,
              style: GoogleFonts.inter(color: Colors.white),
              dropdownColor: Colors.grey[800],
              decoration: InputDecoration(
                labelText: 'Payment Method',
                labelStyle: GoogleFonts.inter(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              items: PaymentMethod.values.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(_getPaymentMethodName(method)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) selectedMethod = value;
              },
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: referenceController,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Payment Reference (Optional)',
                labelStyle: GoogleFonts.inter(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<InvoiceCubit>().markAsPaid(
                invoice.id,
                selectedMethod,
                referenceController.text.isEmpty ? null : referenceController.text,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('Mark as Paid'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Invoice invoice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Delete Invoice',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete "${invoice.title}"? This action cannot be undone.',
          style: GoogleFonts.inter(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<InvoiceCubit>().deleteInvoice(invoice.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  String _getStatusDisplayName(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.draft:
        return 'Draft';
      case InvoiceStatus.pending:
        return 'Pending';
      case InvoiceStatus.paid:
        return 'Paid';
      case InvoiceStatus.expired:
        return 'Expired';
      case InvoiceStatus.cancelled:
        return 'Cancelled';
    }
  }

  String _getPaymentMethodName(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.bank_transfer:
        return 'Bank Transfer';
      case PaymentMethod.crypto:
        return 'Cryptocurrency';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.card:
        return 'Credit/Debit Card';
      case PaymentMethod.cash:
        return 'Cash';
    }
  }

  void _downloadInvoice(BuildContext context, Invoice invoice) async {
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
          backgroundColor: const Color(0xFF6366F1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );

      await InvoicePdfService.downloadInvoice(invoice);
      
      // Hide loading and show success
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invoice PDF downloaded successfully!'),
          backgroundColor: const Color(0xFF10B981),
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
          backgroundColor: const Color(0xFFEF4444),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
} 