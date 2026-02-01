import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../domain/entities/invoice_entity.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import '../cubit/tagged_invoice_cubit.dart';
import '../cubit/tagged_invoice_state.dart';
import '../widgets/invoice_voice_agent_button.dart';
import '../widgets/invoice_shimmer.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';

class InvoiceHomeScreen extends StatefulWidget {
  const InvoiceHomeScreen({super.key});

  @override
  State<InvoiceHomeScreen> createState() => _InvoiceHomeScreenState();
}

class _InvoiceHomeScreenState extends State<InvoiceHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

  static const _receivedFilters = ['All', 'Pending', 'Paid', 'Overdue', 'Cancelled'];
  static const _createdFilters = ['All', 'Pending', 'Paid', 'Partially Paid', 'Overdue', 'Cancelled'];

  List<String> get _filters => _tabController.index == 0 ? _receivedFilters : _createdFilters;

  String get _currencySymbol {
    try {
      final state = context.read<AccountCardsSummaryCubit>().state;
      if (state is AccountCardsSummaryLoaded && state.accountSummaries.isNotEmpty) {
        return _getCurrencySymbol(state.accountSummaries.first.currency);
      }
    } catch (_) {}
    return '\$';
  }

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
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
    // Reload data for the active tab so stats are up-to-date
    if (_tabController.index == 0) {
      context.read<TaggedInvoiceCubit>().loadIncomingInvoices();
    } else {
      context.read<InvoiceCubit>().loadInvoices();
    }
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
        onPressed: () async {
          await Get.toNamed(AppRoutes.createInvoice);
          if (context.mounted) {
            context.read<InvoiceCubit>().loadInvoices();
            context.read<TaggedInvoiceCubit>().loadIncomingInvoices();
          }
        },
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
            onTap: () => Get.offAllNamed(AppRoutes.dashboard),
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
            final isReceivedTab = _tabController.index == 0;

            // Show shimmer only for the active tab's cubit
            final isLoading = isReceivedTab
                ? (taggedState is TaggedInvoiceLoading || taggedState is TaggedInvoiceInitial)
                : (invoiceState is InvoiceLoading || invoiceState is InvoiceInitial);
            if (isLoading) {
              return const InvoiceStatsShimmer();
            }

            double totalAmount = 0;
            double overdueAmount = 0;
            int pendingCount = 0;
            int paidCount = 0;
            int partiallyPaidCount = 0;

            if (!isReceivedTab && invoiceState is InvoicesLoaded) {
              // Compute stats from the actual loaded invoices for the Created tab
              final invoices = invoiceState.invoices;
              totalAmount = invoices.fold<double>(0.0, (sum, inv) => sum + inv.amount);
              overdueAmount = invoices
                  .where((inv) => inv.isOverdue)
                  .fold<double>(0.0, (sum, inv) => sum + inv.amount);
              pendingCount = invoices.where((inv) => inv.status == InvoiceStatus.pending).length;
              paidCount = invoices.where((inv) => inv.status == InvoiceStatus.paid).length;
              partiallyPaidCount = invoices
                  .where((inv) => inv.status == InvoiceStatus.partiallyPaid)
                  .length;
            }

            if (isReceivedTab && taggedState is IncomingTaggedInvoicesLoaded) {
              totalAmount = taggedState.statistics.totalAmount;
              overdueAmount = taggedState.statistics.overdueAmount;
              pendingCount = taggedState.statistics.pendingInvoices;
              paidCount = taggedState.statistics.paidInvoices;
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
                  if (!isReceivedTab) ...[
                    Expanded(
                      child: _buildStatCard(
                        label: 'Partial',
                        value: partiallyPaidCount.toString(),
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                    SizedBox(width: 12.w),
                  ],
                  if (isReceivedTab) ...[
                    Expanded(
                      child: _buildStatCard(
                        label: 'Overdue',
                        value: '$_currencySymbol${(overdueAmount / 100).toStringAsFixed(0)}',
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                    SizedBox(width: 12.w),
                  ],
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

  List<Invoice> _filterInvoices(List<Invoice> invoices) {
    if (_selectedFilter == 'All') return invoices;
    if (_selectedFilter == 'Overdue') {
      return invoices.where((inv) => inv.isOverdue).toList();
    }
    return invoices.where((inv) {
      return inv.statusDisplayName.toLowerCase() == _selectedFilter.toLowerCase();
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

    // For received (incoming) tagged invoices:
    // - "From" = the invoice creator who tagged you
    // - "To" = you (the tagged payer)
    // taggerName may be null since proto doesn't return creator name separately
    // recipientDetails.contactName = creator's own details stored during invoice creation
    final creatorName = invoice.taggerName ??
        invoice.invoice?.recipientDetails?.contactName ??
        'Invoice Sender';
    final receiverName = 'You';

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.invoiceDetails, arguments: {
        'invoiceId': invoice.invoiceId,
        'isFromReceivedTab': true,
      }),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: title + amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    isPaid ? Icons.check_circle : isOverdue ? Icons.warning_rounded : Icons.receipt_long,
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
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r),
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
                ),
                Text(
                  '$_currencySymbol${(invoice.amount / 100).toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textWhite,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: InvoiceThemeColors.dividerColor, height: 1),
            SizedBox(height: 12.h),
            // Creator & Receiver row
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.arrow_upward_rounded, color: InvoiceThemeColors.errorRed, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text('From: ', style: GoogleFonts.inter(color: InvoiceThemeColors.textGray500, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                      Flexible(
                        child: Text(
                          creatorName,
                          style: GoogleFonts.inter(color: InvoiceThemeColors.textGray300, fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                      Icon(Icons.arrow_downward_rounded, color: InvoiceThemeColors.successGreen, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text('To: ', style: GoogleFonts.inter(color: InvoiceThemeColors.textGray500, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                      Flexible(
                        child: Text(
                          receiverName,
                          style: GoogleFonts.inter(color: InvoiceThemeColors.textGray300, fontSize: 12.sp, fontWeight: FontWeight.w600),
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
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(Icons.schedule, color: isOverdue ? InvoiceThemeColors.errorRed : InvoiceThemeColors.textGray500, size: 13.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Due ${_formatDate(invoice.invoice!.dueDate!)}',
                    style: GoogleFonts.inter(
                      color: isOverdue ? InvoiceThemeColors.errorRed : InvoiceThemeColors.textGray400,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
            // Quick Pay button for pending invoices
            if (!isPaid) ...[
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                height: 36.h,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (invoice.invoice != null) {
                      Get.toNamed(AppRoutes.invoiceItemPayment, arguments: invoice.invoice!);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  icon: Icon(Icons.payment, color: Colors.white.withValues(alpha: 0.9), size: 16.sp),
                  label: Text(
                    'Quick Pay',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
            // Tagged users count
            if (invoice.invoice?.taggedUsers != null && invoice.invoice!.taggedUsers!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => _showTaggedUsersSheet(invoice.invoice!),
                child: Row(
                  children: [
                    Icon(Icons.people_outline, color: InvoiceThemeColors.textGray400, size: 14.sp),
                    SizedBox(width: 6.w),
                    Text(
                      '${invoice.invoice!.taggedUsers!.length} tagged user${invoice.invoice!.taggedUsers!.length == 1 ? '' : 's'}',
                      style: GoogleFonts.inter(
                        color: InvoiceThemeColors.primaryPurple,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.chevron_right, color: InvoiceThemeColors.textGray500, size: 14.sp),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSentInvoiceItem(Invoice invoice) {
    final isPaid = invoice.status == InvoiceStatus.paid;
    final isPartiallyPaid = invoice.isPartiallyPaid;
    final isOverdue = invoice.isOverdue;
    final bool isLocked = !invoice.isUnlocked;
    final statusColor = isPaid
        ? const Color(0xFF10B981)
        : isPartiallyPaid
            ? const Color(0xFFF59E0B)
            : isOverdue
                ? const Color(0xFFEF4444)
                : const Color(0xFFFB923C);

    return GestureDetector(
      onTap: () {
        // Locked invoices need service fee payment before viewing details
        if (isLocked) {
          Get.toNamed(AppRoutes.invoicePayment, arguments: invoice);
        } else {
          Get.toNamed(AppRoutes.invoiceDetails, arguments: {
            'invoiceId': invoice.id,
            'isFromReceivedTab': false,
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: title + amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: isLocked
                        ? const Color(0xFFFB923C).withValues(alpha: 0.1)
                        : statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    isLocked
                        ? Icons.lock
                        : isPaid
                            ? Icons.check_circle
                            : isPartiallyPaid
                                ? Icons.pie_chart
                                : isOverdue
                                    ? Icons.warning_rounded
                                    : Icons.receipt_long,
                    color: isLocked ? const Color(0xFFFB923C) : statusColor,
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
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      if (isLocked)
                        Text(
                          'Tap to unlock for ${_currencySymbol}99.99',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFB923C),
                            fontSize: 12.sp,
                          ),
                        )
                      else
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: isLocked
                                ? const Color(0xFFFB923C).withValues(alpha: 0.1)
                                : statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            isLocked ? 'Locked' : invoice.statusDisplayName,
                            style: GoogleFonts.inter(
                              color: isLocked ? const Color(0xFFFB923C) : statusColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Text(
                  '$_currencySymbol${(invoice.amount / 100).toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textWhite,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            if (!isLocked) ...[
              SizedBox(height: 12.h),
              Divider(color: InvoiceThemeColors.dividerColor, height: 1),
              SizedBox(height: 12.h),
              // Creator & Receiver row
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.arrow_upward_rounded, color: InvoiceThemeColors.primaryPurple, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text('From: ', style: GoogleFonts.inter(color: InvoiceThemeColors.textGray500, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        Flexible(
                          child: Text(
                            'You',
                            style: GoogleFonts.inter(color: InvoiceThemeColors.textGray300, fontSize: 12.sp, fontWeight: FontWeight.w600),
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
                        Icon(Icons.arrow_downward_rounded, color: InvoiceThemeColors.successGreen, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text('To: ', style: GoogleFonts.inter(color: InvoiceThemeColors.textGray500, fontSize: 12.sp, fontWeight: FontWeight.w500)),
                        Flexible(
                          child: Text(
                            invoice.payerDetails?.contactName ?? invoice.toName ?? 'Unknown',
                            style: GoogleFonts.inter(color: InvoiceThemeColors.textGray300, fontSize: 12.sp, fontWeight: FontWeight.w600),
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
              if (invoice.dueDate != null) ...[
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.schedule, color: isOverdue ? InvoiceThemeColors.errorRed : InvoiceThemeColors.textGray500, size: 13.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Due ${_formatDate(invoice.dueDate!)}',
                      style: GoogleFonts.inter(
                        color: isOverdue ? InvoiceThemeColors.errorRed : InvoiceThemeColors.textGray400,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ],
            if (isPartiallyPaid && invoice.taggedUsers != null && invoice.taggedUsers!.isNotEmpty) ...[
              SizedBox(height: 10.h),
              _buildPaymentProgressBar(invoice),
            ],
            if (invoice.taggedUsers != null && invoice.taggedUsers!.isNotEmpty)
              _buildTaggedUsersRow(invoice),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentProgressBar(Invoice invoice) {
    final total = invoice.taggedUsers?.length ?? 0;
    final paid = invoice.paidUsersCount;
    final progress = total > 0 ? paid / total : 0.0;

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$paid of $total paid',
                style: GoogleFonts.inter(
                  color: const Color(0xFFF59E0B),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: GoogleFonts.inter(
                  color: const Color(0xFFF59E0B),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFFF59E0B).withValues(alpha: 0.15),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaggedUsersRow(Invoice invoice) {
    final users = invoice.taggedUsers!;
    final maxAvatars = 4;
    final displayUsers = users.length > maxAvatars ? users.sublist(0, maxAvatars) : users;
    final overflow = users.length - maxAvatars;

    // Count statuses and types
    final paidCount = users.where((u) => u.status == 'paid').length;
    final platformCount = users.where((u) => u.isPlatformUser).length;
    final externalCount = users.where((u) => u.isExternalTag).length;

    return GestureDetector(
      onTap: () => _showTaggedUsersSheet(invoice),
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Row(
          children: [
            Icon(Icons.people_outline, color: InvoiceThemeColors.textGray400, size: 14.sp),
            SizedBox(width: 6.w),
            // Overlapping avatars
            SizedBox(
              width: (displayUsers.length * 20.w) + 8.w + (overflow > 0 ? 20.w : 0),
              height: 24.w,
              child: Stack(
                children: [
                  ...displayUsers.asMap().entries.map((entry) {
                    final i = entry.key;
                    final user = entry.value;
                    final typeColor = user.isPlatformUser
                        ? InvoiceThemeColors.primaryPurple
                        : user.tagType == 'email'
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF10B981);
                    return Positioned(
                      left: i * 18.0.w,
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF1F1F1F), width: 2),
                        ),
                        child: Center(
                          child: user.isPlatformUser
                              ? Text(
                                  user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
                                  style: GoogleFonts.inter(color: typeColor, fontSize: 9.sp, fontWeight: FontWeight.w700),
                                )
                              : Icon(
                                  user.tagType == 'email' ? Icons.email_outlined : Icons.sms_outlined,
                                  color: typeColor,
                                  size: 11.sp,
                                ),
                        ),
                      ),
                    );
                  }),
                  if (overflow > 0)
                    Positioned(
                      left: displayUsers.length * 18.0.w,
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFF1F1F1F), width: 2),
                        ),
                        child: Center(
                          child: Text(
                            '+$overflow',
                            style: GoogleFonts.inter(
                              color: InvoiceThemeColors.textGray400,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                '${platformCount > 0 ? '$platformCount platform' : ''}${platformCount > 0 && externalCount > 0 ? ' \u2022 ' : ''}${externalCount > 0 ? '$externalCount external' : ''}${paidCount > 0 ? ' \u2022 $paidCount paid' : ''}',
                style: GoogleFonts.inter(
                  color: InvoiceThemeColors.textGray400,
                  fontSize: 11.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.chevron_right, color: InvoiceThemeColors.textGray400, size: 16.sp),
          ],
        ),
      ),
    );
  }

  void _showTaggedUsersSheet(Invoice invoice) {
    final users = invoice.taggedUsers!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.6),
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
                ],
              ),
            ),
            Divider(color: const Color(0xFFE5E7EB), height: 1),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                itemCount: users.length,
                itemBuilder: (context, index) => _buildLightTaggedUserTile(users[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLightTaggedUserTile(TaggedUserInfo user) {
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
      onTap: user.isPlatformUser ? () => _showUserProfileModal(user) : null,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 1))],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: typeColor.withValues(alpha: 0.12),
                  backgroundImage: user.profilePicture != null ? NetworkImage(user.profilePicture!) : null,
                  child: user.profilePicture == null
                      ? user.isPlatformUser
                          ? Text(user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
                              style: GoogleFonts.inter(color: typeColor, fontSize: 14.sp, fontWeight: FontWeight.w700))
                          : Icon(user.tagType == 'email' ? Icons.email_outlined : Icons.sms_outlined, color: typeColor, size: 16.sp)
                      : null,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.displayName, style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 14.sp, fontWeight: FontWeight.w600)),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(color: typeColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4.r)),
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
                  SizedBox(width: 48.w),
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
  }

  void _showUserProfileModal(TaggedUserInfo user) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.12),
                backgroundImage: user.profilePicture != null ? NetworkImage(user.profilePicture!) : null,
                child: user.profilePicture == null
                    ? Text(
                        user.displayName.isNotEmpty ? user.displayName[0].toUpperCase() : '?',
                        style: GoogleFonts.inter(color: InvoiceThemeColors.primaryPurple, fontSize: 28.sp, fontWeight: FontWeight.w700),
                      )
                    : null,
              ),
              SizedBox(height: 16.h),
              Text(
                user.displayName,
                style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 18.sp, fontWeight: FontWeight.w700),
              ),
              if (user.username.isNotEmpty) ...[
                SizedBox(height: 4.h),
                Text(
                  '@${user.username}',
                  style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp),
                ),
              ],
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'LazerVault User',
                  style: GoogleFonts.inter(color: InvoiceThemeColors.primaryPurple, fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
              ),
              if (user.status.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Text(
                  'Status: ${user.status == 'paid' ? 'Paid' : user.status == 'viewed' ? 'Viewed' : 'Pending'}',
                  style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 13.sp),
                ),
              ],
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFF3F4F6),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text('Close', style: GoogleFonts.inter(color: const Color(0xFF374151), fontSize: 14.sp, fontWeight: FontWeight.w600)),
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
