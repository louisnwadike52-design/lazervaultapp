// MyGiftCardsScreen — paginated history of every gift card the user
// has bought. Replaces the prior transactions-icon-on-the-header
// pattern: this screen IS the transaction history. Tapping a row
// opens a bottom sheet with details + Repeat / Receipt actions.
//
// Pagination: scroll-near-bottom triggers loadMoreMyGiftCards on the
// cubit. Each page is 20 rows; the cubit accumulates and de-dupes.
// The list shows a small loader spinner under the last row when more
// is in flight, swaps to plain end-of-list otherwise.
//
// The Transfer tab has been removed — gift cards are now buy-only on
// this surface; transfer flow is dropped end-to-end (Flutter + backend).

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../../../core/types/app_routes.dart';
import 'widgets/gift_card_error_widget.dart';

class MyGiftCardsScreen extends StatefulWidget {
  const MyGiftCardsScreen({super.key});

  @override
  State<MyGiftCardsScreen> createState() => _MyGiftCardsScreenState();
}

class _MyGiftCardsScreenState extends State<MyGiftCardsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  // 0 = Available, 1 = Expired, 2 = All. Transfer tab dropped.
  int _selectedTabIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
    _scrollController.addListener(_onScroll);
    context.read<GiftCardCubit>().loadMyGiftCards();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Trigger pagination ~200px before the bottom so the next page
  // arrives before the user's thumb hits end-of-list.
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      context.read<GiftCardCubit>().loadMoreMyGiftCards();
    }
  }

  Future<void> _onRefresh() async {
    context.read<GiftCardCubit>().loadMyGiftCards();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GiftCardCubit, GiftCardState>(
      listener: (context, state) {
        if (state is RedeemCodeLoaded && state.status == 'available') {
          Get.snackbar(
            'Redeem Code',
            'Code: ${state.redemptionCode}${state.redemptionPin.isNotEmpty ? " · PIN: ${state.redemptionPin}" : ""}',
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
            colorText: Colors.white,
            borderRadius: 12.r,
            margin: EdgeInsets.all(16.w),
            duration: const Duration(seconds: 8),
          );
        } else if (state is GiftCardRedeemError) {
          Get.snackbar(
            'Redeem Failed',
            friendlyGiftCardError(state.message),
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
            colorText: Colors.white,
            borderRadius: 12.r,
            margin: EdgeInsets.all(16.w),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: BlocBuilder<GiftCardCubit, GiftCardState>(
                  buildWhen: (prev, curr) =>
                      curr is GiftCardLoading ||
                      curr is GiftCardError ||
                      curr is GiftCardNetworkError ||
                      curr is GiftCardTimeoutError ||
                      curr is GiftCardServerUnavailable ||
                      curr is MyGiftCardsLoaded ||
                      curr is UserGiftCardsEmpty,
                  builder: (context, state) {
                    if (state is GiftCardLoading) return _buildLoadingView();
                    if (state is GiftCardError) {
                      return _buildErrorView(state.message);
                    }
                    if (state is GiftCardNetworkError) {
                      return _buildErrorView(state.message);
                    }
                    if (state is GiftCardTimeoutError) {
                      return _buildErrorView(
                          'Request timed out. Pull down to retry.');
                    }
                    if (state is GiftCardServerUnavailable) {
                      return _buildErrorView(
                          'Service temporarily unavailable. Pull down to retry.');
                    }
                    if (state is MyGiftCardsLoaded) {
                      return _buildGiftCardList(state);
                    }
                    return _buildEmptyView();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header — title + back button only. The transactions-history icon
  // that used to sit on the right was removed: this screen IS the
  // transaction history.
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
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
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          Expanded(
            child: Text(
              'My Gift Cards',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Spacer to keep the title centred without the right icon.
          SizedBox(width: 44.w),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: InvoiceThemeColors.primaryPurple,
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicatorPadding: EdgeInsets.all(3.w),
        tabs: const [
          Tab(text: 'Available'),
          Tab(text: 'Expired'),
          Tab(text: 'All'),
        ],
      ),
    );
  }

  bool _isExpired(GiftCard card) {
    if (card.status == 'expired') return true;
    if (card.expiryDate.isEmpty) return false;
    try {
      return DateTime.parse(card.expiryDate).isBefore(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  Widget _buildGiftCardList(MyGiftCardsLoaded state) {
    final filtered = state.giftCards.where((card) {
      switch (_selectedTabIndex) {
        case 0:
          return card.status == 'available' && !_isExpired(card);
        case 1:
          return _isExpired(card);
        case 2:
        default:
          return true;
      }
    }).toList();

    if (filtered.isEmpty) return _buildEmptyTabView();

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: InvoiceThemeColors.primaryPurple,
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        physics: const AlwaysScrollableScrollPhysics(),
        // +1 row at the bottom for the load-more sentinel when more
        // pages are available (only on the All tab — the Available
        // and Expired tabs filter the accumulator client-side and
        // would mislead the user with a "loading more" footer that
        // can't actually grow their visible list).
        itemCount: filtered.length +
            (state.hasMore && _selectedTabIndex == 2 ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= filtered.length) {
            return _buildLoadMoreFooter(state.isLoadingMore);
          }
          return _buildGiftCardItem(filtered[index]);
        },
      ),
    );
  }

  Widget _buildLoadMoreFooter(bool isLoadingMore) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: SizedBox(
          width: 22.w,
          height: 22.w,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              isLoadingMore
                  ? InvoiceThemeColors.primaryPurple
                  : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGiftCardItem(GiftCard card) {
    return GestureDetector(
      onTap: () => _showCardActionsSheet(card),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            _brandLogo(card),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.brandName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _humanDate(card.purchaseDate),
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${card.currency} ${card.originalAmount.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                _statusChip(card),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _brandLogo(GiftCard card) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: card.logoUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: card.logoUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Icon(
                  Icons.card_giftcard,
                  size: 22.sp,
                  color: const Color(0xFF6B7280),
                ),
              )
            : Icon(Icons.card_giftcard,
                size: 22.sp, color: const Color(0xFF6B7280)),
      ),
    );
  }

  Widget _statusChip(GiftCard card) {
    final tone = _statusTone(card);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: tone.bg,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _displayStatus(card).toUpperCase(),
        style: GoogleFonts.inter(
          color: tone.fg,
          fontSize: 9.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  String _displayStatus(GiftCard card) {
    if (_isExpired(card)) return 'expired';
    return card.status;
  }

  _Tone _statusTone(GiftCard card) {
    final s = _displayStatus(card).toLowerCase();
    switch (s) {
      case 'available':
        return const _Tone(bg: Color(0x2010B981), fg: Color(0xFF10B981));
      case 'expired':
        return const _Tone(bg: Color(0x20FB923C), fg: Color(0xFFFB923C));
      case 'redeemed':
        return const _Tone(bg: Color(0x206B7280), fg: Color(0xFF9CA3AF));
      // Legacy alias (pre giftcards-service migration 013) —
      // 'transferred' is no longer a write path but old rows
      // still surface this status, so we keep it parseable.
      case 'transferred':
        return const _Tone(bg: Color(0x206B7280), fg: Color(0xFF9CA3AF));
      case 'reversed': // legacy alias pre giftcards-service migration 013
      case 'refunded':
      case 'failed':
        return const _Tone(bg: Color(0x20EF4444), fg: Color(0xFFEF4444));
      case 'pending_verification': // legacy alias pre giftcards-service migration 013
      case 'pending':
      case 'processing':
        return const _Tone(bg: Color(0x20F59E0B), fg: Color(0xFFF59E0B));
      default:
        return const _Tone(bg: Color(0x206B7280), fg: Color(0xFF9CA3AF));
    }
  }

  String _humanDate(String raw) {
    if (raw.isEmpty) return '—';
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    return DateFormat('MMM d, yyyy').format(parsed);
  }

  // ── Bottom sheet ────────────────────────────────────────────────────
  // Shows a compact preview of the card (logo, brand, amount, status,
  // dates, redemption code/PIN if present) plus two CTAs:
  //  • Repeat — navigate back to the buy flow with the same brand
  //    pre-selected so the user can re-purchase quickly.
  //  • View receipt — opens the full receipt detail screen.
  void _showCardActionsSheet(GiftCard card) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D3D3D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              // Header: brand logo + brand + amount/status
              Row(
                children: [
                  _brandLogo(card),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.brandName,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        _statusChip(card),
                      ],
                    ),
                  ),
                  Text(
                    '${card.currency} ${card.originalAmount.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.primaryPurple,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              const Divider(color: Color(0xFF2D2D2D), height: 1),
              SizedBox(height: 12.h),
              // Compact key/value rows
              if (card.purchaseDate.isNotEmpty)
                _kv('Purchased', _humanDate(card.purchaseDate)),
              if (card.expiryDate.isNotEmpty)
                _kv('Expires', _humanDate(card.expiryDate)),
              if (card.isMultiCurrency && card.senderAmount > 0)
                _kv('You paid',
                    '${card.senderCurrency} ${card.senderAmount.toStringAsFixed(2)}'),
              if ((card.providerTransactionId ?? '').isNotEmpty)
                _kv('Reference', card.providerTransactionId!),
              SizedBox(height: 20.h),
              // CTAs
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(sheetCtx).pop();
                        _onRepeat(card);
                      },
                      icon: Icon(Icons.repeat_rounded, size: 18.sp),
                      label: Text(
                        'Repeat',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: BorderSide(
                            color: InvoiceThemeColors.primaryPurple),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(sheetCtx).pop();
                        Get.toNamed(AppRoutes.giftCardDetails,
                            arguments: card);
                      },
                      icon: Icon(Icons.receipt_long_rounded, size: 18.sp),
                      label: Text(
                        'View receipt',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: InvoiceThemeColors.primaryPurple,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Repeat = re-enter the buy flow scoped to the same brand. We don't
  // have the full GiftCardBrand entity on a GiftCard row (only id,
  // name, logo, productId, currency), so the cleanest UX is to drop
  // the user back at the brands browser. They'll see their last
  // selected country pre-applied and can pick the brand directly —
  // no risk of routing through a stale brand snapshot.
  void _onRepeat(GiftCard card) {
    Get.toNamed(AppRoutes.giftCards);
  }

  Widget _kv(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Empty / loading / error views ───────────────────────────────────
  Widget _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            InvoiceThemeColors.primaryPurple),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_giftcard,
                size: 56.sp, color: const Color(0xFF6B7280)),
            SizedBox(height: 12.h),
            Text(
              'No gift cards yet',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Tap below to buy your first gift card.',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => Get.toNamed(AppRoutes.giftCards),
              icon: const Icon(Icons.shopping_bag_outlined, size: 18),
              label: Text(
                'Buy gift card',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.primaryPurple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: 20.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyTabView() {
    final label = _selectedTabIndex == 0
        ? 'No available gift cards'
        : _selectedTabIndex == 1
            ? 'Nothing has expired'
            : 'No gift cards yet';
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined,
                size: 48.sp, color: const Color(0xFF6B7280)),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: GiftCardErrorWidget(
          message: friendlyGiftCardError(message),
          onRetry: _onRefresh,
        ),
      ),
    );
  }
}

class _Tone {
  final Color bg;
  final Color fg;
  const _Tone({required this.bg, required this.fg});
}
