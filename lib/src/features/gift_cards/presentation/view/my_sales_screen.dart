import 'package:flutter/material.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import 'widgets/gift_card_error_widget.dart';

class MySalesScreen extends StatefulWidget {
  const MySalesScreen({super.key});

  @override
  State<MySalesScreen> createState() => _MySalesScreenState();
}

class _MySalesScreenState extends State<MySalesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // True while a Sale Details bottom sheet is in front of the list.
  // The sheet calls cubit.getSellStatus, which transiently emits
  // GiftCardLoading → SellStatusLoaded; without this guard the list's
  // BlocBuilder rebuilds against those non-list states and flashes
  // "No sales yet" (the fall-through branch). Suppressing rebuilds
  // while the sheet is open keeps the list stable underneath.
  bool _sheetOpen = false;

  static const _tabs = ['All', 'In Review', 'Approved', 'Paid', 'Rejected'];
  static const _statusFilters = [null, 'pending_review', 'approved', 'paid', 'rejected'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    context.read<GiftCardCubit>().loadMySales();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      context.read<GiftCardCubit>().loadMySales(
        status: _statusFilters[_tabController.index],
      );
    }
  }

  Future<void> _onRefresh() async {
    await context.read<GiftCardCubit>().loadMySales(
      status: _statusFilters[_tabController.index],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offNamed(
            AppRoutes.giftCards,
            arguments: const {'initialTab': 'sell'},
          ),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
        ),
        title: Text(
          'My Sales',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: InvoiceThemeColors.primaryPurple,
          unselectedLabelColor: const Color(0xFF9CA3AF),
          indicatorColor: InvoiceThemeColors.primaryPurple,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500),
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: BlocBuilder<GiftCardCubit, GiftCardState>(
        // Only react to states that actually describe the list. Sale-
        // detail lookups (GiftCardLoading → SellStatusLoaded) and any
        // sheet-scoped errors are owned by the bottom sheet's own
        // BlocConsumer; letting them through here would flash the
        // empty / loading view on top of a populated list.
        buildWhen: (prev, curr) {
          if (_sheetOpen) return false;
          return curr is GiftCardInitial ||
              curr is GiftCardLoading ||
              curr is MySalesLoaded ||
              curr is MySalesEmpty ||
              curr is GiftCardNetworkError;
        },
        builder: (context, state) {
          if (state is GiftCardLoading) {
            return const Center(
              child: CircularProgressIndicator(color: InvoiceThemeColors.primaryPurple),
            );
          }

          if (state is MySalesLoaded) {
            return _buildSalesList(state.sales);
          }

          if (state is MySalesEmpty) {
            return _buildEmptyState();
          }

          if (state is GiftCardNetworkError) {
            return _buildErrorState(state.message);
          }

          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildSalesList(List<GiftCardSale> sales) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: InvoiceThemeColors.primaryPurple,
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: sales.length,
        itemBuilder: (context, index) => _buildSaleCard(sales[index]),
      ),
    );
  }

  Widget _buildSaleCard(GiftCardSale sale) {
    return GestureDetector(
      onTap: () => _showSaleDetails(sale),
      child: Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sale.cardType.replaceAll('_', ' ').toUpperCase(),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildStatusBadge(sale.userDisplayStatus),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Denomination',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${sale.currency} ${sale.denomination.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rate',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${sale.ratePercentage.toStringAsFixed(0)}%',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Payout',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _formatCurrency(sale.expectedPayout),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (sale.submittedAt.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              _formatDate(sale.submittedAt),
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 11.sp,
              ),
            ),
          ],
        ],
      ),
    ),
    );
  }

  void _showSaleDetails(GiftCardSale sale) {
    // Suppress list rebuilds for the lifetime of the sheet — the
    // getSellStatus call below transitions the cubit through
    // GiftCardLoading and SellStatusLoaded, neither of which the
    // list view can render meaningfully.
    setState(() => _sheetOpen = true);

    // Refresh status from backend (bottom sheet's BlocConsumer will
    // pick up SellStatusLoaded and re-render the displaySale).
    context.read<GiftCardCubit>().getSellStatus(sale.id);

    Get.bottomSheet(
      BlocProvider.value(
        value: context.read<GiftCardCubit>(),
        child: BlocConsumer<GiftCardCubit, GiftCardState>(
          listener: (context, state) {
            if (state is SellError) {
              Get.snackbar(
                'Error',
                friendlyGiftCardError(state.message),
                snackPosition: SnackPosition.TOP,
                backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
                colorText: Colors.white,
                borderRadius: 12.r,
                margin: EdgeInsets.all(16.w),
              );
            }
          },
          builder: (context, state) {
            final displaySale = (state is SellStatusLoaded) ? state.sale : sale;
            return Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      margin: EdgeInsets.only(bottom: 20.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sale Details',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      _buildStatusBadge(displaySale.userDisplayStatus),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildSaleDetailRow('Card Type', displaySale.cardType.replaceAll('_', ' ').toUpperCase()),
                  SizedBox(height: 10.h),
                  _buildSaleDetailRow('Card Number', displaySale.cardNumber.isNotEmpty ? '****${displaySale.cardNumber.substring(displaySale.cardNumber.length > 4 ? displaySale.cardNumber.length - 4 : 0)}' : 'N/A'),
                  SizedBox(height: 10.h),
                  _buildSaleDetailRow('Denomination', '${displaySale.currency} ${displaySale.denomination.toStringAsFixed(0)}'),
                  SizedBox(height: 10.h),
                  _buildSaleDetailRow('Rate', '${displaySale.ratePercentage.toStringAsFixed(0)}%'),
                  SizedBox(height: 10.h),
                  _buildSaleDetailRow('Expected Payout', _formatCurrency(displaySale.expectedPayout)),
                  if (displaySale.actualPayout > 0) ...[
                    SizedBox(height: 10.h),
                    _buildSaleDetailRow('Actual Payout', _formatCurrency(displaySale.actualPayout)),
                  ],
                  if (displaySale.reference.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    _buildSaleDetailRow('Reference', displaySale.reference),
                  ],
                  if (displaySale.providerName.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    _buildSaleDetailRow('Provider', displaySale.providerName),
                  ],
                  SizedBox(height: 10.h),
                  _buildSaleDetailRow('Submitted', _formatDate(displaySale.submittedAt)),
                  if (displaySale.paidAt.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    _buildSaleDetailRow('Paid', _formatDate(displaySale.paidAt)),
                  ],
                  if (displaySale.isRejected && displaySale.rejectionReason.isNotEmpty) ...[
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reason for rejection',
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFEF4444),
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            displaySale.rejectionReason,
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              color: Colors.white,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (state is GiftCardLoading) ...[
                    SizedBox(height: 16.h),
                    const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: InvoiceThemeColors.primaryPurple,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: InvoiceThemeColors.primaryPurple,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Close',
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(() {
      // Re-arm list rebuilds and re-fetch the current tab so any
      // status change observed in the sheet (e.g. paid → settled)
      // is reflected in the row when the user returns.
      if (!mounted) return;
      setState(() => _sheetOpen = false);
      context.read<GiftCardCubit>().loadMySales(
            status: _statusFilters[_tabController.index],
          );
    });
  }

  Widget _buildSaleDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case 'pending':
        bgColor = const Color(0xFFFB923C).withValues(alpha: 0.15);
        textColor = const Color(0xFFFB923C);
        label = 'Pending';
        break;
      case 'pending_review':
        bgColor = const Color(0xFF8B5CF6).withValues(alpha: 0.15);
        textColor = const Color(0xFF8B5CF6);
        label = 'In Review';
        break;
      case 'reviewing':
        bgColor = InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15);
        textColor = InvoiceThemeColors.primaryPurple;
        label = 'Reviewing';
        break;
      case 'approved':
        bgColor = const Color(0xFF10B981).withValues(alpha: 0.15);
        textColor = const Color(0xFF10B981);
        label = 'Approved';
        break;
      case 'rejected':
        bgColor = const Color(0xFFEF4444).withValues(alpha: 0.15);
        textColor = const Color(0xFFEF4444);
        label = 'Rejected';
        break;
      case 'paid':
        bgColor = const Color(0xFF10B981).withValues(alpha: 0.15);
        textColor = const Color(0xFF10B981);
        label = 'Paid';
        break;
      case 'settled':
        bgColor = const Color(0xFF10B981).withValues(alpha: 0.15);
        textColor = const Color(0xFF10B981);
        label = 'Settled';
        break;
      case 'pending_settlement':
        // Provider confirmed but the wallet credit hasn't landed yet.
        // Yellow (not green) so the user understands this is NOT
        // terminal-paid — the settlement-retry worker is still trying
        // to credit them. Distinct from the green "Paid" badge to
        // prevent the trust hazard of showing 'paid' before the user
        // can spend the money.
        bgColor = const Color(0xFFFBBF24).withValues(alpha: 0.15);
        textColor = const Color(0xFFFBBF24);
        label = 'Pending wallet credit';
        break;
      case 'failed':
      case 'cancelled': // legacy alias pre giftcards-service migration 013
        bgColor = const Color(0xFFEF4444).withValues(alpha: 0.15);
        textColor = const Color(0xFFEF4444);
        label = 'Failed';
        break;
      case 'manual_review':
      case 'escalated': // legacy alias pre giftcards-service migration 013
        bgColor = const Color(0xFFFB923C).withValues(alpha: 0.15);
        textColor = const Color(0xFFFB923C);
        label = 'Manual review';
        break;
      default:
        bgColor = const Color(0xFF6B7280).withValues(alpha: 0.15);
        textColor = const Color(0xFF6B7280);
        label = status;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: textColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    // Tab-aware empty state. Each tab corresponds to a status filter
    // (see _statusFilters); when MySalesEmpty fires we want to tell
    // the user *why* this tab is empty rather than always showing
    // the same "No sales yet" copy. The "All" tab is the only one
    // where we know they've never sold; the others mean "nothing of
    // THIS status" and may have entries in other tabs.
    final tabIdx = _tabController.index;
    final isAllTab = tabIdx == 0;
    final (title, subtitle, icon) = switch (tabIdx) {
      0 => (
          'No sales yet',
          "Sold gift cards will appear here once you submit one.",
          Icons.sell_outlined,
        ),
      1 => (
          'Nothing in review',
          'Sales waiting for admin review will show up here.',
          Icons.hourglass_empty_rounded,
        ),
      2 => (
          'No approved sales',
          'Sales that admin has approved (awaiting payout) appear here.',
          Icons.check_circle_outline,
        ),
      3 => (
          'No paid sales yet',
          'Sales that have been paid into your wallet appear here.',
          Icons.payments_outlined,
        ),
      4 => (
          'No rejected sales',
          'Sales rejected at review time appear here. Empty is good news!',
          Icons.block_outlined,
        ),
      _ => (
          'No sales yet',
          'Your sold gift cards will appear here.',
          Icons.sell_outlined,
        ),
    };
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(36.r),
                  ),
                  child: Icon(icon, size: 32.sp, color: const Color(0xFF6B7280)),
                ),
                SizedBox(height: 16.h),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                ),
                if (!isAllTab) ...[
                  SizedBox(height: 16.h),
                  TextButton.icon(
                    onPressed: () => _tabController.animateTo(0),
                    icon: const Icon(Icons.list_rounded, size: 16),
                    label: const Text('See all sales'),
                    style: TextButton.styleFrom(
                      foregroundColor: InvoiceThemeColors.primaryPurple,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return GiftCardErrorWidget.fromRaw(
      rawMessage: message,
      onRetry: _onRefresh,
    );
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000) {
      return 'NGN ${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      )}';
    }
    return 'NGN ${amount.toStringAsFixed(2)}';
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoDate;
    }
  }
}
