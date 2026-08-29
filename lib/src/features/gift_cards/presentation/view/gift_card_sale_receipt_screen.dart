import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/receipt_download.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../services/gift_card_sale_pdf_service.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../../account_cards_summary/services/balance_websocket_service.dart';
import '../widgets/giftcard_background.dart';

/// Receipt for a gift card SALE.
///
/// The sell flow previously ended on the My Sales LIST, and a sale's details
/// lived in a bottom sheet with no share or download. So the one moment a
/// customer most wants something to keep — money owed to them, or a rejection
/// they need to query — produced no artefact at all. The purchase side has had
/// a full receipt for a while; this brings the sell side level.
///
/// Rendered for EVERY terminal outcome, not just paid. A rejected seller needs
/// the reason, the reference and the provider's own id far more than a paid one
/// needs a confirmation, and giving them a receipt only on success is exactly
/// backwards.
/// Route argument bundle. The screen accepts a bare [GiftCardSale] too; this
/// exists because a rejection reason can arrive on the STATE rather than on the
/// row (the backend may not have persisted it yet at the moment we navigate),
/// and losing it would leave the customer looking at "Rejected" with no reason
/// — the one thing they actually need.
class GiftCardSaleReceiptArgs {
  final GiftCardSale sale;
  final String? reasonOverride;

  const GiftCardSaleReceiptArgs({required this.sale, this.reasonOverride});
}

class GiftCardSaleReceiptScreen extends StatefulWidget {
  final GiftCardSale sale;

  /// Used only when the sale row carries no reason of its own.
  final String? reasonOverride;

  const GiftCardSaleReceiptScreen({
    super.key,
    required this.sale,
    this.reasonOverride,
  });

  @override
  State<GiftCardSaleReceiptScreen> createState() => _GiftCardSaleReceiptScreenState();
}

class _GiftCardSaleReceiptScreenState extends State<GiftCardSaleReceiptScreen> {
  bool _isSharing = false;
  bool _isDownloading = false;

  /// The receipt is LIVE, not a snapshot.
  ///
  /// A sale is frequently still `pending`/`reviewing` when the customer lands
  /// here — Prestmit adjudicates asynchronously — so rendering the object we
  /// were navigated with would freeze the status at whatever it was in that
  /// instant and never move again. Three things keep it current: a fetch on
  /// open, the giftcard_sale WebSocket, and pull-to-refresh as the manual
  /// fallback when the socket is down.
  late GiftCardSale _sale;
  String? _reasonOverride;
  StreamSubscription<BalanceUpdateEvent>? _balanceSub;

  GiftCardSale get sale => _sale;

  @override
  void initState() {
    super.initState();
    _sale = widget.sale;
    _reasonOverride = widget.reasonOverride;

    try {
      final ws = GetIt.I<BalanceWebSocketService>();
      _balanceSub = ws.balanceUpdates.listen(_handleBalanceEvent);
    } catch (_) {
      // Socket not registered — pull-to-refresh remains the manual path.
    }

    // Always re-read on open: the row we were handed may already be stale by
    // the time this frame builds.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<GiftCardCubit>().refreshSaleDetails(_sale.id);
    });
  }

  @override
  void dispose() {
    _balanceSub?.cancel();
    super.dispose();
  }

  /// Only reacts to THIS sale. The socket carries every balance event for the
  /// user, so an unfiltered listener would refetch on unrelated activity.
  void _handleBalanceEvent(BalanceUpdateEvent event) {
    if (!mounted) return;
    if (event.eventType != 'giftcard_sale') return;
    final ref = _sale.reference;
    if (ref.isEmpty || event.reference != ref) return;
    context.read<GiftCardCubit>().refreshSaleDetails(_sale.id);
  }

  /// Adopts a fresher row from the cubit.
  ///
  /// Once the backend has written a reason, it supersedes the one we were
  /// navigated with — the row is authoritative and the override only ever
  /// filled a gap.
  void _adopt(GiftCardSale fresh, {String? reason}) {
    if (!mounted) return;
    setState(() {
      _sale = fresh;
      if (reason != null && reason.trim().isNotEmpty) _reasonOverride = reason;
    });
  }

  /// Row first, state second. The row is authoritative once the backend has
  /// written it; the override only fills a gap.
  String get _reason {
    final own = sale.rejectionReason.trim();
    if (own.isNotEmpty) return own;
    return (_reasonOverride ?? '').trim();
  }

  bool get _settled => sale.actualPayout > 0;
  double get _payout => _settled ? sale.actualPayout : sale.expectedPayout;

  bool get _isGood {
    final s = sale.status.toLowerCase();
    return s == 'paid' || s == 'settled' || s == 'approved';
  }

  bool get _isBad {
    final s = sale.status.toLowerCase();
    return s == 'rejected' || s == 'failed';
  }

  Color get _accent {
    if (_isGood) return const Color(0xFF10B981);
    if (_isBad) return const Color(0xFFEF4444);
    return const Color(0xFFF59E0B);
  }

  IconData get _icon {
    if (_isGood) return Icons.check_rounded;
    if (_isBad) return Icons.close_rounded;
    return Icons.hourglass_top_rounded;
  }

  String get _statusLabel {
    switch (sale.status.toLowerCase()) {
      case 'paid':
      case 'settled':
        return 'Paid';
      case 'approved':
        return 'Approved';
      case 'rejected':
        return 'Rejected';
      case 'failed':
        return 'Failed';
      case 'refunded':
        return 'Refunded';
      case 'refund_pending':
        return 'Refund in progress';
      case 'refund_failed':
        return 'Refund failed';
      case 'pending_settlement':
        return 'Pending wallet credit';
      case 'pending':
        return 'Submitted';
      case 'pending_review':
      case 'reviewing':
        return 'Under review';
      default:
        final s = sale.status.replaceAll('_', ' ');
        return s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
    }
  }

  /// What the headline number MEANS changes with outcome. Labelling a quote as
  /// "Amount paid" on a rejected sale would be a lie in the largest text on
  /// the screen.
  String get _amountLabel {
    if (_isBad) return 'Would have paid';
    return _settled ? 'Amount paid' : 'Expected payout';
  }

  String _money(double v) => v
      .toStringAsFixed(2)
      .replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+\.)'), (m) => '${m[1]},');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B14),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
        ),
        // Mark + wordmark, matching the transfer receipt so a screenshot from
        // either flow carries the same identity.
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    errorBuilder: (_, __, ___) => Icon(Icons.shield_outlined,
                        color: const Color(0xFF3B82F6), size: 16.sp),
                  ),
                ),
                SizedBox(width: 7.w),
                Text(
                  'Lazervault',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GiftCardBackground(
        child: SafeArea(
          // Adopts whatever the cubit last resolved for this sale. The same
          // four states the sell processing screen handles arrive here too,
          // because a sale can settle while the customer is looking at it.
          child: BlocListener<GiftCardCubit, GiftCardState>(
            listenWhen: (_, s) =>
                s is GiftCardSellPaid ||
                s is SellRejected ||
                s is SellEscalatedToManualReview ||
                s is GiftCardSellAwaitingProvider,
            listener: (context, state) {
              if (state is GiftCardSellPaid) {
                if (state.sale.id == _sale.id) _adopt(state.sale);
              } else if (state is SellRejected) {
                if (state.sale.id == _sale.id) {
                  _adopt(state.sale, reason: state.reason);
                }
              } else if (state is SellEscalatedToManualReview) {
                if (state.sale.id == _sale.id) _adopt(state.sale);
              } else if (state is GiftCardSellAwaitingProvider) {
                if (state.sale.id == _sale.id) _adopt(state.sale);
              }
            },
            child: Column(
              children: [
                Expanded(
                  // Pull-to-refresh is the manual path when the socket is
                  // down or an event was missed. AlwaysScrollable so the
                  // gesture works even when the content fits the screen.
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await context
                          .read<GiftCardCubit>()
                          .refreshSaleDetails(_sale.id);
                    },
                    color: Colors.white,
                    backgroundColor: const Color(0xFF1F1F1F),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 16.h),
                      child: Column(
                        children: [
                          _buildHero(),
                          SizedBox(height: 20.h),
                          _buildDetails(),
                          if (_reason.isNotEmpty) ...[
                            SizedBox(height: 16.h),
                            _buildReason(),
                          ],
                          SizedBox(height: 16.h),
                          _buildFooterNote(),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHero() {
    return Column(
      children: [
        Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _accent.withValues(alpha: 0.12),
            border: Border.all(color: _accent.withValues(alpha: 0.35)),
          ),
          child: Icon(_icon, color: _accent, size: 30.sp),
        ),
        SizedBox(height: 14.h),
        Text(
          _amountLabel,
          style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF8E8E93)),
        ),
        SizedBox(height: 4.h),
        Text(
          'NGN ${_money(_payout)}',
          style: GoogleFonts.inter(
            fontSize: 30.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: _accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: _accent.withValues(alpha: 0.32)),
          ),
          child: Text(
            _statusLabel,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: _accent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    final rows = <List<String>>[
      ['Card', sale.cardType],
      ['Face value', '${sale.currency} ${_money(sale.denomination)}'],
      if (sale.ratePercentage > 0)
        [
          'Rate',
          // The rate is naira per ONE unit of the card's face currency. When
          // that currency is unknown the row rendered a dangling "NGN 4.00 /"
          // with nothing after the slash — say "per unit" instead of trailing
          // off. (Sales submitted before the catalogue published a currency
          // for Prestmit's OTHERS bucket carry an empty one.)
          sale.currency.trim().isEmpty
              ? 'NGN ${_money(sale.ratePercentage)} per unit'
              : 'NGN ${_money(sale.ratePercentage)} / ${sale.currency.trim()}',
        ],
      ['Reference', sale.reference],
      if (sale.providerSaleId.isNotEmpty) ['Provider ref', sale.providerSaleId],
      if (sale.providerName.isNotEmpty) ['Processed by', sale.providerName],
      if (sale.submittedAt.isNotEmpty) ['Submitted', sale.submittedAt],
      if (sale.reviewedAt.isNotEmpty) ['Reviewed', sale.reviewedAt],
      if (sale.paidAt.isNotEmpty) ['Paid', sale.paidAt],
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
            child: Text(
              'SALE DETAILS',
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: const Color(0xFF8E8E93),
              ),
            ),
          ),
          ...rows.map((r) => _detailRow(r[0], r[1])),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110.w,
            child: Text(
              label,
              style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF8E8E93)),
            ),
          ),
          Expanded(
            child: GestureDetector(
              // References are the thing a customer is asked for by support,
              // so they must be copyable rather than transcribed by eye.
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: value));
                HapticFeedback.selectionClick();
                Get.snackbar('Copied', '$label copied',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.all(16.w),
                    backgroundColor: const Color(0xFF1F1F1F),
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2));
              },
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReason() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEF4444).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why this sale did not go through',
            style: GoogleFonts.inter(
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFEF4444),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            _reason,
            style: GoogleFonts.inter(
              fontSize: 12.5.sp,
              height: 1.55,
              color: const Color(0xFFB6B9C6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterNote() {
    // Only shown while the outcome is still open, so a settled receipt is not
    // cluttered with a promise that no longer applies.
    if (_isGood || _isBad) return const SizedBox.shrink();
    return Text(
      'We will notify you as soon as this sale is reviewed. You can close this '
      'screen; the outcome appears in My Sales.',
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontSize: 11.5.sp,
        height: 1.5,
        color: const Color(0xFF6B7280),
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _actionButton(
                  icon: _isDownloading ? null : Icons.download_outlined,
                  label: _isDownloading ? 'Saving...' : 'Download',
                  isLoading: _isDownloading,
                  onTap: _isDownloading ? null : _download,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _actionButton(
                  icon: _isSharing ? null : Icons.ios_share,
                  label: _isSharing ? 'Sharing...' : 'Share',
                  isLoading: _isSharing,
                  onTap: _isSharing ? null : _share,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          TextButton(
            onPressed: () => Get.offAllNamed(AppRoutes.mySales),
            child: Text(
              'View all sales',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    IconData? icon,
    required String label,
    required VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              LazerVaultLoader(size: 16)
            else if (icon != null)
              Icon(icon, size: 17.sp, color: Colors.white),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _share() async {
    setState(() => _isSharing = true);
    try {
      await GiftCardSalePdfService.shareSaleReceipt(sale: sale);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Share failed: $e')));
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _download() async {
    setState(() => _isDownloading = true);
    try {
      await GiftCardSalePdfService.downloadSaleReceipt(sale: sale);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(ReceiptDownload.successBody)));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Download failed: $e')));
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }
}
