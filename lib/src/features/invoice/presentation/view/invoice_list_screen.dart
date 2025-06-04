import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lazervault/core/types/app_routes.dart';

import '../../domain/entities/invoice_entity.dart';
import '../../services/invoice_pdf_service.dart';
import '../../data/models/pagination_model.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import '../widgets/invoice_card.dart';
import '../widgets/invoice_statistics_card.dart';
import '../widgets/invoice_filter_chip.dart';
import 'create_invoice_screen.dart';
import 'invoice_details_screen.dart';

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
    
    // Load initial data with pagination
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InvoiceCubit>().loadInvoices();
    });
  }

  @override
  void dispose() {
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
                color: Colors.grey[900],
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
                  'Invoices',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Manage your invoices and payment requests',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showOptionsMenu(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
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
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[800]!),
            ),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search invoices...',
                hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          context.read<InvoiceCubit>().loadInvoices();
                        },
                        icon: Icon(Icons.close, color: Colors.grey[500]),
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
                )).toList(),
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
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6366F1)),
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
            color: Colors.grey[600],
          ),
          SizedBox(height: 16.h),
          Text(
            'No invoices found',
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Create your first invoice to get started',
            style: GoogleFonts.inter(
              color: Colors.grey[500],
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () => _navigateToCreate(),
            icon: const Icon(Icons.add),
            label: const Text('Create Invoice'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
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
            color: Colors.red[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'Something went wrong',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => context.read<InvoiceCubit>().loadInvoices(),
            child: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: () => _navigateToCreate(),
      backgroundColor: const Color(0xFF6366F1),
      foregroundColor: Colors.white,
      icon: const Icon(Icons.add),
      label: Text(
        'Create',
        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
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
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.refresh, color: Colors.white),
              title: Text(
                'Refresh',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                context.read<InvoiceCubit>().loadInvoices();
              },
            ),
            ListTile(
              leading: const Icon(Icons.download, color: Colors.white),
              title: Text(
                'Export Data',
                style: GoogleFonts.inter(color: Colors.white),
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
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            if (invoice.canBeEdited) ...[
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.white),
                title: Text('Edit', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(AppRoutes.createInvoice, arguments: invoice);
                },
              ),
              ListTile(
                leading: const Icon(Icons.send, color: Colors.white),
                title: Text('Send', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  context.read<InvoiceCubit>().sendInvoice(invoice.id);
                },
              ),
            ],
            if (invoice.status == InvoiceStatus.pending || invoice.isOverdue) ...[
              ListTile(
                leading: const Icon(Icons.refresh, color: Colors.blue),
                title: Text('Resend', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  context.read<InvoiceCubit>().sendInvoice(invoice.id);
                },
              ),
            ],
            if (invoice.canBePaid) ...[
              ListTile(
                leading: const Icon(Icons.payment, color: Colors.green),
                title: Text('Mark as Paid', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _showMarkAsPaidDialog(invoice);
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white),
              title: Text('Share', style: GoogleFonts.inter(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                context.read<InvoiceCubit>().shareInvoice(invoice.id, []);
              },
            ),
            if (invoice.status != InvoiceStatus.paid) ...[
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.orange),
                title: Text('Cancel', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  context.read<InvoiceCubit>().cancelInvoice(invoice.id);
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text('Delete', style: GoogleFonts.inter(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(invoice);
              },
            ),
            ListTile(
              leading: const Icon(Icons.visibility, color: Colors.white),
              title: Text('View Details', style: GoogleFonts.inter(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(AppRoutes.invoiceDetails, arguments: invoice.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.download, color: Colors.green),
              title: Text('Download PDF', style: GoogleFonts.inter(color: Colors.white)),
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
              value: selectedMethod,
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