import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import '../cubit/tagged_invoice_cubit.dart';
import '../cubit/tagged_invoice_state.dart';
import '../widgets/invoice_voice_agent_button.dart';
import '../widgets/invoice_shimmer.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/services/locale_manager.dart';

class InvoiceHomeScreen extends StatefulWidget {
  const InvoiceHomeScreen({super.key});

  @override
  State<InvoiceHomeScreen> createState() => _InvoiceHomeScreenState();
}

class _InvoiceHomeScreenState extends State<InvoiceHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

  static const _filters = ['All', 'Pending', 'Paid', 'Overdue', 'Cancelled'];

  String get _currencySymbol {
    final currency = GetIt.I<LocaleManager>().currentCurrency;
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'ZAR':
        return 'R';
      case 'CAD':
        return 'C\$';
      case 'AUD':
        return 'A\$';
      case 'INR':
        return '\u20B9';
      case 'JPY':
        return '\u00A5';
      case 'USD':
      default:
        return '\$';
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _initializeData();
  }

  void _initializeData() {
    // Set user ID on InvoiceCubit from auth state so it can load invoices
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<InvoiceCubit>().setUserId(authState.profile.userId);
    }
    // Load received tab data
    context.read<TaggedInvoiceCubit>().loadIncomingInvoices();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    setState(() => _selectedFilter = 'All');
  }

  void _onFilterSelected(String filter) {
    setState(() => _selectedFilter = filter);
    if (_tabController.index == 0) {
      // Received tab
      context.read<TaggedInvoiceCubit>().loadIncomingInvoices();
    } else {
      // Sent tab
      final statusFilter = filter == 'All' ? null : [filter.toLowerCase()];
      context.read<InvoiceCubit>().loadInvoices(statusFilter: statusFilter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.createInvoice),
        backgroundColor: InvoiceThemeColors.primaryPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildStatsRow(context),
            SizedBox(height: 16.h),
            _buildTabBar(),
            _buildFilterChips(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildReceivedTab(),
                  _buildCreatedTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
            child: Text(
              'Invoices',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textWhite,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          MicroserviceChatIcon(
            serviceName: 'Invoices',
            sourceContext: 'invoices',
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF8B5CF6),
          ),
          SizedBox(width: 8.w),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, authState) {
              final accessToken = authState is AuthenticationSuccess
                  ? authState.profile.session.accessToken
                  : null;
              return GestureDetector(
                onTap: () {
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
                  ),
                  child: Icon(Icons.mic, color: Colors.white, size: 20.sp),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, invoiceState) {
        return BlocBuilder<TaggedInvoiceCubit, TaggedInvoiceState>(
          builder: (context, taggedState) {
            // Show shimmer if either cubit is loading
            final isLoading = invoiceState is InvoiceLoading ||
                taggedState is TaggedInvoiceLoading ||
                (invoiceState is InvoiceInitial && taggedState is TaggedInvoiceInitial);
            if (isLoading) {
              return const InvoiceStatsShimmer();
            }

            double totalAmount = 0;
            double overdueAmount = 0;
            int pendingCount = 0;
            int paidCount = 0;

            if (invoiceState is InvoicesLoaded) {
              final stats = invoiceState.statistics ?? {};
              totalAmount += (stats['total_amount'] ?? 0.0) as double;
              overdueAmount += invoiceState.invoices
                  .where((inv) => inv.isOverdue)
                  .fold<double>(0.0, (sum, inv) => sum + inv.amount);
              pendingCount += (stats['pending_invoices'] ?? 0) as int;
              paidCount += (stats['paid_invoices'] ?? 0) as int;
            }

            if (taggedState is IncomingTaggedInvoicesLoaded) {
              totalAmount += taggedState.statistics.totalAmount;
              overdueAmount += taggedState.statistics.overdueAmount;
              pendingCount += taggedState.statistics.pendingInvoices;
              paidCount += taggedState.statistics.paidInvoices;
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      label: 'Total',
                      value: '$_currencySymbol${(totalAmount / 100).toStringAsFixed(0)}',
                      color: InvoiceThemeColors.primaryPurple,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildStatCard(
                      label: 'Overdue',
                      value: '$_currencySymbol${(overdueAmount / 100).toStringAsFixed(0)}',
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildStatCard(
                      label: 'Pending',
                      value: pendingCount.toString(),
                      color: const Color(0xFFFB923C),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildStatCard(
                      label: 'Paid',
                      value: paidCount.toString(),
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: GoogleFonts.inter(
              color: InvoiceThemeColors.textGray400,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.secondaryBackground,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: InvoiceThemeColors.primaryPurple,
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: InvoiceThemeColors.textGray400,
        labelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Received'),
          Tab(text: 'Created'),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => _onFilterSelected(filter),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? InvoiceThemeColors.primaryPurple
                      : InvoiceThemeColors.secondaryBackground,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  filter,
                  style: GoogleFonts.inter(
                    color: isSelected ? Colors.white : InvoiceThemeColors.textGray400,
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReceivedTab() {
    return BlocBuilder<TaggedInvoiceCubit, TaggedInvoiceState>(
      builder: (context, state) {
        if (state is TaggedInvoiceLoading) {
          return const InvoiceListShimmer();
        }
        if (state is TaggedInvoiceError) {
          return _buildErrorState(
            _friendlyErrorMessage(state.message),
            () => context.read<TaggedInvoiceCubit>().loadIncomingInvoices(),
          );
        }
        if (state is IncomingTaggedInvoicesLoaded) {
          final invoices = _filterTaggedInvoices(state.invoices);
          if (invoices.isEmpty && _selectedFilter != 'All') {
            return _buildEmptyState(
              'No ${_selectedFilter.toLowerCase()} invoices',
              'Try a different filter or check back later',
              icon: Icons.filter_list,
            );
          }
          if (invoices.isEmpty) {
            return _buildEmptyState(
              'No received invoices',
              'Invoices sent to you will appear here.\nAsk someone to tag you on an invoice!',
              icon: Icons.inbox_outlined,
            );
          }
          return RefreshIndicator(
            onRefresh: () => context.read<TaggedInvoiceCubit>().refreshIncoming(),
            color: InvoiceThemeColors.primaryPurple,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                return _buildTaggedInvoiceItem(invoice);
              },
            ),
          );
        }
        // Initial state - trigger load
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!context.read<TaggedInvoiceCubit>().isClosed) {
            context.read<TaggedInvoiceCubit>().loadIncomingInvoices();
          }
        });
        return const InvoiceListShimmer();
      },
    );
  }

  Widget _buildCreatedTab() {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        if (state is InvoiceLoading) {
          return const InvoiceListShimmer();
        }
        if (state is InvoiceError) {
          return _buildErrorState(
            _friendlyErrorMessage(state.message),
            () => context.read<InvoiceCubit>().loadInvoices(),
          );
        }
        if (state is InvoicesLoaded) {
          final invoices = _filterInvoices(state.invoices);
          if (invoices.isEmpty && _selectedFilter != 'All') {
            return _buildEmptyState(
              'No ${_selectedFilter.toLowerCase()} invoices',
              'Try a different filter or check back later',
              icon: Icons.filter_list,
            );
          }
          if (invoices.isEmpty) {
            return _buildEmptyState(
              'No created invoices',
              'Create your first invoice by tapping the + button below.',
              icon: Icons.description_outlined,
            );
          }
          return RefreshIndicator(
            onRefresh: () => context.read<InvoiceCubit>().loadInvoices(),
            color: InvoiceThemeColors.primaryPurple,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: invoices.length,
              itemBuilder: (context, index) {
                final invoice = invoices[index];
                return _buildSentInvoiceItem(invoice);
              },
            ),
          );
        }
        // Initial/form state - show shimmer while loading
        return const InvoiceListShimmer();
      },
    );
  }

  List<dynamic> _filterTaggedInvoices(List<dynamic> invoices) {
    if (_selectedFilter == 'All') return invoices;
    return invoices.where((inv) {
      final status = inv.statusText.toLowerCase();
      return status == _selectedFilter.toLowerCase();
    }).toList();
  }

  List<dynamic> _filterInvoices(List<dynamic> invoices) {
    if (_selectedFilter == 'All') return invoices;
    return invoices.where((inv) {
      final status = inv.statusDisplayName.toLowerCase();
      return status == _selectedFilter.toLowerCase();
    }).toList();
  }

  Widget _buildTaggedInvoiceItem(dynamic invoice) {
    final isPaid = invoice.isPaid;
    final isOverdue = invoice.isOverdue;
    final statusColor = isPaid
        ? const Color(0xFF10B981)
        : isOverdue
            ? const Color(0xFFEF4444)
            : const Color(0xFFFB923C);

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.invoiceDetails, arguments: invoice.invoiceId),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                isPaid ? Icons.check_circle : isOverdue ? Icons.warning : Icons.pending,
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
                    invoice.title,
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textWhite,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${invoice.displayName} ${invoice.invoice?.dueDate != null ? " \u2022 Due ${_formatDate(invoice.invoice!.dueDate!)}" : ""}',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray400,
                      fontSize: 12.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$_currencySymbol${(invoice.amount / 100).toStringAsFixed(2)}',
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
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    invoice.statusText,
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

  Widget _buildSentInvoiceItem(dynamic invoice) {
    final isPaid = invoice.status.name == 'paid';
    final isOverdue = invoice.isOverdue;
    final statusColor = isPaid
        ? const Color(0xFF10B981)
        : isOverdue
            ? const Color(0xFFEF4444)
            : const Color(0xFFFB923C);

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.invoiceDetails, arguments: invoice.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                isPaid ? Icons.check_circle : isOverdue ? Icons.warning : Icons.pending,
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
                    invoice.title,
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textWhite,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${invoice.toName ?? "Unknown"} ${invoice.dueDate != null ? " \u2022 Due ${_formatDate(invoice.dueDate!)}" : ""}',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.textGray400,
                      fontSize: 12.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$_currencySymbol${(invoice.amount / 100).toStringAsFixed(2)}',
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
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    invoice.statusDisplayName,
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

  Widget _buildErrorState(String message, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Icon(Icons.cloud_off_rounded, size: 32.sp, color: const Color(0xFFEF4444)),
            ),
            SizedBox(height: 20.h),
            Text(
              'Something went wrong',
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
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: 140.w,
              height: 44.h,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh, size: 18.sp),
                label: Text('Try Again', style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: InvoiceThemeColors.primaryPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle, {IconData icon = Icons.receipt_outlined}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(36.r),
              ),
              child: Icon(icon, size: 36.sp, color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.5)),
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray400,
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Convert raw gRPC/backend error messages to user-friendly text
  String _friendlyErrorMessage(String rawMessage) {
    final lower = rawMessage.toLowerCase();
    if (lower.contains('unavailable') || lower.contains('connection')) {
      return 'Unable to reach the server. Check your connection and try again.';
    }
    if (lower.contains('unauthenticated') || lower.contains('auth') || lower.contains('token')) {
      return 'Your session has expired. Please log in again.';
    }
    if (lower.contains('timeout') || lower.contains('deadline')) {
      return 'Request timed out. Please try again.';
    }
    if (lower.contains('unknown service') || lower.contains('unimplemented')) {
      return 'This feature is temporarily unavailable. Please try again later.';
    }
    if (lower.contains('permission') || lower.contains('denied')) {
      return 'You don\'t have permission to view these invoices.';
    }
    // Generic fallback - don't expose raw errors
    return 'Failed to load invoices. Please try again.';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 0) {
      return '${-difference.inDays}d left';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
