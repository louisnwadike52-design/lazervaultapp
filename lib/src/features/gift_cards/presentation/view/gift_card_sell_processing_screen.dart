import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/types/app_routes.dart';
import '../../../account_cards_summary/services/balance_websocket_service.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';

/// Sell-side analog of [GiftCardPurchaseProcessingScreen]. Stays
/// mounted while the sale row sits at `pending` (async-sell waiting
/// for the consumer to call Prestmit) or `reviewing` (Prestmit has
/// the trade, awaiting their webhook). Listens on the balance
/// WebSocket for a `giftcard_sale` event matching the awaited
/// reference and refetches the row on terminal events.
///
/// No polling timers — the WebSocket is the source of truth. Pull-to-
/// refresh is the manual fallback when the WS isn't available.
class GiftCardSellProcessingScreen extends StatefulWidget {
  final GiftCardSale initialSale;

  const GiftCardSellProcessingScreen({
    super.key,
    required this.initialSale,
  });

  @override
  State<GiftCardSellProcessingScreen> createState() =>
      _GiftCardSellProcessingScreenState();
}

class _GiftCardSellProcessingScreenState
    extends State<GiftCardSellProcessingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  bool _hasError = false;
  String _errorTitle = '';
  String _errorMessage = '';
  IconData _errorIcon = Icons.error_outline;
  Color _errorIconColor = const Color(0xFFEF4444);

  StreamSubscription<BalanceUpdateEvent>? _balanceSub;
  String? _awaitingReference;
  String? _awaitingSaleId;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _awaitingReference = widget.initialSale.reference;
    _awaitingSaleId = widget.initialSale.id;
    _ensureBalanceSubscription();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _balanceSub?.cancel();
    super.dispose();
  }

  void _ensureBalanceSubscription() {
    if (_balanceSub != null) return;
    try {
      final wsService = GetIt.I<BalanceWebSocketService>();
      _balanceSub = wsService.balanceUpdates.listen(_handleBalanceEvent);
    } catch (_) {
      // BalanceWebSocketService not registered. Pull-to-refresh on
      // My Sales is the fallback. The cubit's awaiting state stays
      // mounted indefinitely; the user can also navigate away.
    }
  }

  void _handleBalanceEvent(BalanceUpdateEvent event) {
    if (!mounted) return;
    final ref = _awaitingReference;
    final id = _awaitingSaleId;
    if (ref == null || id == null) return;
    if (event.eventType != 'giftcard_sale') return;
    if (event.reference != ref) return;
    // Terminal event matched — refetch by id; cubit will emit
    // GiftCardSellPaid (success), SellRejected, or
    // SellEscalatedToManualReview, or stay in
    // GiftCardSellAwaitingProvider on a race.
    context.read<GiftCardCubit>().refreshSaleDetails(id);
  }

  void _setErrorState(GiftCardState state) {
    setState(() {
      _hasError = true;
      if (state is SellRejected) {
        _errorTitle = 'Provider rejected your trade';
        _errorMessage = state.reason;
        _errorIcon = Icons.cancel_outlined;
        _errorIconColor = const Color(0xFFEF4444);
      } else if (state is SellEscalatedToManualReview) {
        _errorTitle = 'Switched to manual review';
        _errorMessage = 'Our team will take it from here. You will get a notification once your card is paid out.';
        _errorIcon = Icons.support_agent_outlined;
        _errorIconColor = const Color(0xFFFB923C);
      } else if (state is SellError) {
        _errorTitle = 'Something went wrong';
        _errorMessage = state.message;
      } else {
        _errorTitle = 'Something went wrong';
        _errorMessage = 'Please try again later.';
      }
    });
    _animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: BlocListener<GiftCardCubit, GiftCardState>(
          listener: (context, state) {
            if (state is GiftCardSellPaid) {
              _animationController.stop();
              // Route to My Sales (or a sale detail screen if you
              // build one). Using the existing My Sales screen keeps
              // this aligned with the present sell-side UX.
              Get.offAllNamed(AppRoutes.mySales);
            } else if (state is GiftCardSellAwaitingProvider) {
              _awaitingReference = state.reference;
              _awaitingSaleId = state.sale.id;
            } else if (state is SellRejected ||
                state is SellEscalatedToManualReview ||
                state is SellError) {
              _setErrorState(state);
            }
          },
          child: BlocBuilder<GiftCardCubit, GiftCardState>(
            builder: (context, state) {
              if (_hasError) return _buildErrorView();
              return _buildAwaitingView();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAwaitingView() {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          final id = _awaitingSaleId;
          if (id != null) {
            await context.read<GiftCardCubit>().refreshSaleDetails(id);
          }
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          children: [
            SizedBox(height: 80.h),
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, _) {
                  return Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1F1F1F),
                      border: Border.all(
                        color: const Color(0xFF3B82F6).withValues(
                          alpha: 0.3 + 0.7 * _animationController.value,
                        ),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.hourglass_empty,
                      color: Color(0xFF3B82F6),
                      size: 36,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'Submitting your card…',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Our provider is verifying your gift card. This usually takes a few minutes; you can leave this screen and we will notify you when it is paid out.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 32.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailRow('Card', widget.initialSale.cardType),
                  SizedBox(height: 8.h),
                  _detailRow(
                    'Face value',
                    '${widget.initialSale.denomination.toStringAsFixed(2)} ${widget.initialSale.currency}',
                  ),
                  SizedBox(height: 8.h),
                  _detailRow(
                    'Reference',
                    widget.initialSale.reference,
                    monospaced: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            TextButton(
              onPressed: () => Get.offAllNamed(AppRoutes.mySales),
              child: Text(
                'Check status in My Sales',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {bool monospaced = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: (monospaced ? GoogleFonts.jetBrainsMono : GoogleFonts.inter)(
              color: Colors.white,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: _errorIconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _errorIcon,
                color: _errorIconColor,
                size: 32.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              _errorTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.mySales),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              ),
              child: const Text('View My Sales'),
            ),
          ],
        ),
      ),
    );
  }
}
