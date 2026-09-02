import 'package:flutter/material.dart';
import 'package:lazervault/src/features/gift_cards/presentation/widgets/giftcard_background.dart';
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
import 'widgets/sell_rejection_reasons_sheet.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'gift_card_sale_receipt_screen.dart';

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

  // Tabs are keyed to the USER-FACING statuses that userDisplayStatus can
  // actually produce: pending / paid / refunded / rejected.
  //
  // "Approved" was previously a tab and could never match anything —
  // userDisplayStatus deliberately collapses approved/settling/
  // pending_settlement into "pending", because the seller only cares whether
  // they have the money yet. Tapping it showed a full list anyway (nothing
  // filtered at all), which hid the emptiness. "Refunded" replaces it: that
  // state IS reachable and had no tab.
  static const _tabs = ['All', 'In Review', 'Paid', 'Refunded', 'Rejected'];

  /// Maps a tab label to the userDisplayStatus it selects. 'All' filters
  /// nothing.
  static const _tabStatus = <String, String>{
    'In Review': 'pending',
    'Paid': 'paid',
    'Refunded': 'refunded',
    'Rejected': 'rejected',
  };

  /// Sales for the selected tab. The tabs used to be decorative: every one of
  /// them rendered the unfiltered list, so a seller could not narrow to
  /// rejected or paid sales at all.
  List<GiftCardSale> _salesForSelectedTab(List<GiftCardSale> sales) {
    final label = _tabs[_tabController.index];
    final want = _tabStatus[label];
    if (want == null) return sales;
    return sales.where((s) => s.userDisplayStatus == want).toList();
  }
  // The list is always fetched UNFILTERED and narrowed client-side by
  // _salesForSelectedTab.
  //
  // The server filter this replaces passed raw lifecycle strings
  // ('pending_review', 'approved') that the backend does not actually use —
  // real rows carry 'reviewing', 'settled', 'pending_settlement' and so on —
  // so those tabs queried for statuses no row ever had. It also could not
  // express "In Review", which spans several internal states that
  // userDisplayStatus deliberately collapses into one user-facing label.
  // Filtering on the same derived status the badge shows keeps the tab, the
  // badge and the row in agreement by construction.

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    final cubit = context.read<GiftCardCubit>();
    cubit.loadMySales();
    // A sale stores the PROVIDER's subcategory id ("220") as its card type, so
    // without the catalogue this screen can only title rows with that number.
    // The catalogue is cached and cheap; load it when it is not already there
    // so rows read "Turkey iTunes" instead.
    if (cubit.cachedSellableCards.isEmpty) {
      // buildWhen deliberately ignores catalogue states (they would flash the
      // empty view over a populated list), so the arrival has to rebuild this
      // screen explicitly or the titles stay as raw ids until the next refresh.
      cubit.loadSellableCards().then((_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    // Re-render for the new filter. No refetch: the list is already loaded
    // unfiltered, and re-querying per tab is what made the tabs feel broken
    // (each one replaced the list with an identically unfiltered result).
    if (!_tabController.indexIsChanging && mounted) setState(() {});
  }

  Future<void> _onRefresh() async {
    await context.read<GiftCardCubit>().loadMySales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGiftCardBgTop,
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
          tabs: _tabs
              .map((t) => Tab(
                    key: Key(
                        'mysales_tab_${t.toLowerCase().replaceAll(' ', '_')}'),
                    text: t,
                  ))
              .toList(),
        ),
      ),
      body: GiftCardBackground(child: BlocBuilder<GiftCardCubit, GiftCardState>(
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
              child: LazerVaultLoader.small(),
            );
          }

          if (state is MySalesLoaded) {
            final visible = _salesForSelectedTab(state.sales);
            if (visible.isEmpty) return _buildEmptyState();
            return _buildSalesList(visible);
          }

          if (state is MySalesEmpty) {
            return _buildEmptyState();
          }

          if (state is GiftCardNetworkError) {
            return _buildErrorState(state.message);
          }

          return _buildEmptyState();
        },
      )),
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

  /// Resolves a human brand name for a sale.
  ///
  /// `sale.cardType` is the PROVIDER's subcategory id ("220"), which is what
  /// the row rendered as its title — a bare number that means nothing to the
  /// person who sold the card. The sellable catalogue maps that id to a display
  /// name, so it is used when loaded; otherwise the id is shown rather than a
  /// fabricated name.
  String _saleBrandName(GiftCardSale sale) {
    final cards = context.read<GiftCardCubit>().cachedSellableCards;
    for (final c in cards) {
      if (c.cardType == sale.cardType) {
        if (c.displayName.trim().isNotEmpty) return c.displayName.trim();
        break;
      }
    }
    final raw = sale.cardType.replaceAll('_', ' ').trim();
    return raw.isEmpty ? 'Gift card' : raw;
  }

  /// Face value with its currency, or bare when the currency is unknown.
  /// Never prints a leading space or an invented code.
  String _saleFaceLabel(GiftCardSale sale) {
    final amount = sale.denomination.toStringAsFixed(0);
    final ccy = sale.currency.trim().toUpperCase();
    return ccy.isEmpty ? amount : '$ccy $amount';
  }

  Widget _buildSaleCard(GiftCardSale sale) {
    // Show what the seller actually gets: the settled amount once it exists,
    // the estimate until then. Quoting the estimate after payout would
    // contradict the wallet.
    final payout =
        sale.actualPayout > 0 ? sale.actualPayout : sale.expectedPayout;
    final isSettled = sale.actualPayout > 0;
    final brand = _saleBrandName(sale);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: Key('mysales_item_${sale.id}'),
          // Opens the RECEIPT. The old details sheet had no share and no
          // download, so a seller could never produce anything for a sale —
          // the exact artefact they need when querying a rejection or proving
          // a payout. The sheet stays on long-press for its in-place refresh.
          onTap: () => Get.toNamed(
            AppRoutes.giftCardSaleReceipt,
            arguments: GiftCardSaleReceiptArgs(sale: sale),
          ),
          onLongPress: () => _showSaleDetails(sale),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: InvoiceThemeColors.primaryPurpleLight
                        .withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.sell_rounded,
                      size: 19.sp,
                      color: InvoiceThemeColors.primaryPurpleLight),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              brand,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          _buildStatusBadge(sale),
                        ],
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        _saleFaceLabel(sale),
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.5.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isSettled ? 'Paid out' : 'Estimated payout',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF6B7280),
                                    fontSize: 11.sp,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'NGN ${payout.toStringAsFixed(2)}',
                                  key: Key('mysales_payout_${sale.id}'),
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF10B981),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            _formatDate(sale.createdAt),
                            style: GoogleFonts.inter(
                              color: const Color(0xFF6B7280),
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.chevron_right_rounded,
                              size: 18.sp, color: const Color(0xFF6B7280)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                      _buildStatusBadge(displaySale),
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
                  // Provider's own sale id, distinct from our internal reference,
                  // so support can cross-check with the provider when needed.
                  if (displaySale.providerSaleId.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    _buildSaleDetailRow('Provider Sale ID', displaySale.providerSaleId),
                  ],
                  // Settlement status (pending/verified/failed) — the payout's
                  // money-movement state, separate from the sale's review status.
                  if (displaySale.settlementStatus.isNotEmpty &&
                      displaySale.settlementStatus.toLowerCase() != 'pending') ...[
                    SizedBox(height: 10.h),
                    _buildSaleDetailRow('Settlement',
                        displaySale.settlementStatus.toUpperCase()),
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
                          SizedBox(height: 10.h),
                          GestureDetector(
                            onTap: () => showSellRejectionReasonsSheet(context,
                                highlightReason: displaySale.rejectionReason),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.help_outline,
                                    color: const Color(0xFFEF4444), size: 15.sp),
                                SizedBox(width: 6.w),
                                Text(
                                  'Why was this rejected?',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFEF4444),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (state is GiftCardLoading) ...[
                    SizedBox(height: 16.h),
                    const Center(
                      child: LazerVaultLoader.small(),
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
      context.read<GiftCardCubit>().loadMySales();
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

  /// Colour is per-outcome; the TEXT comes from GiftCardSale.userStatusLabel so
  /// the badge and the receipt can never disagree about the same sale.
  Widget _buildStatusBadge(GiftCardSale sale) {
    final label = sale.userStatusLabel;
    final Color color = switch (sale.userDisplayStatus) {
      'paid' => const Color(0xFF10B981),
      'rejected' => const Color(0xFFEF4444),
      'refunded' => const Color(0xFFF59E0B),
      _ => const Color(0xFFF59E0B),
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        key: Key('mysales_status_${sale.id}'),
        style: GoogleFonts.inter(
          color: color,
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
          'No paid sales yet',
          'Sales that have been paid into your wallet appear here.',
          Icons.payments_outlined,
        ),
      3 => (
          'No refunded sales',
          'Sales reversed after payout appear here.',
          Icons.undo_rounded,
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
      final date = DateTime.parse(isoDate).toLocal();
      return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoDate;
    }
  }
}
