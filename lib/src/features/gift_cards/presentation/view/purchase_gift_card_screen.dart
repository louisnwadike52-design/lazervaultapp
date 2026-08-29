import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' show Left;
import 'package:lazervault/src/features/gift_cards/presentation/widgets/giftcard_background.dart';
import 'widgets/pre_order_notice.dart';
import 'package:lazervault/src/features/gift_cards/presentation/view/widgets/rich_card_text.dart';
import 'package:flutter/services.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import '../../../../../core/services/account_manager.dart';
import '../../../../../core/services/injection_container.dart';
import '../../domain/repositories/i_gift_card_repository.dart';
import 'widgets/buy_funding_check.dart';
import 'package:lazervault/core/errors/failure.dart';

class PurchaseGiftCardScreen extends StatefulWidget {
  final GiftCardBrand brand;

  /// When set, the screen renders in "repeat purchase" mode:
  /// the amount is pre-selected and locked (denomination pills +
  /// custom-amount input both hidden), and the buy CTA is active
  /// the moment the screen mounts. Used by MyGiftCards' bottom-sheet
  /// "Repeat" action.
  final double? lockedAmount;

  /// Provider that issued the card being repeated.
  ///
  /// When set the screen reads its amounts from THIS provider and the purchase
  /// executes on it, whatever rail is active. [brand]'s product ref belongs to
  /// this provider and means something different on the other one.
  final String? pinnedProvider;

  const PurchaseGiftCardScreen({
    super.key,
    required this.brand,
    this.lockedAmount,
    this.pinnedProvider,
  });

  @override
  State<PurchaseGiftCardScreen> createState() => _PurchaseGiftCardScreenState();
}

class _PurchaseGiftCardScreenState extends State<PurchaseGiftCardScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double? _selectedAmount;
  // True = user is typing in sender (locale) currency. False (default)
  // = user is typing in recipient/card currency. The sender FX rate is
  // derived from minSenderAmount/minAmount and applied symmetrically.
  bool _entryInSenderCurrency = false;

  // Repeat-purchase mode: when widget.lockedAmount is non-null, the
  // amount is fixed (no pills, no custom input). Pre-selected on
  // mount so the buy CTA is immediately active.
  bool get _isLockedAmount => widget.lockedAmount != null;

  // ---- Live provider refresh -------------------------------------------
  //
  // The catalogue tile this screen was opened from is a cached, shared page.
  // Denominations and prices belong to whichever buy provider was active when
  // it was built, and both the provider and its availability can change before
  // the user picks an amount. So the screen re-reads THIS product from the
  // ACTIVE provider on mount and renders that answer instead.
  //
  // While the refresh is in flight the tile's own data is shown (so the screen
  // never flashes empty) but the buy CTA stays disabled — an amount is only
  // offered for purchase once a provider has confirmed it will sell it.
  GiftCardBrand? _liveBrand;
  String _liveProvider = '';
  bool _liveLoading = true;
  String _liveUnavailable = '';
  bool _liveRefreshFailed = false;

  /// The brand the screen renders and prices from: the provider's live answer
  /// once it arrives, otherwise the tile that was tapped.
  GiftCardBrand get _brand => _liveBrand ?? widget.brand;

  StreamSubscription<AccountCardsSummaryState>? _balanceSub;

  @override
  void initState() {
    super.initState();
    _refreshFromProvider();
    // The funding gate reads the account summaries. context.read does not
    // subscribe, so without this the gate would keep comparing against the
    // balance as it was when the screen opened — and a purchase made
    // elsewhere in the app (or a push-driven balance update) would leave it
    // showing an affordable card the wallet can no longer fund.
    try {
      final cubit = context.read<AccountCardsSummaryCubit>();
      _balanceSub = cubit.stream.listen((_) {
        if (mounted) setState(() {});
      });
    } catch (_) {/* gate simply stays non-reactive; it still fails open */}
    if (_isLockedAmount) {
      _selectedAmount = widget.lockedAmount;
      _amountController.text = widget.lockedAmount!.toStringAsFixed(0);
    }
  }

  List<double> get _denominations {
    if (_brand.fixedDenominations.isNotEmpty) {
      return _brand.fixedDenominations.map((d) => d.price).toList();
    }
    // Range brands: the provider sells ANY amount between min and max, so
    // these are genuine suggestions inside a range it published, not invented
    // amounts. The custom field remains the authority.
    if (_brand.minAmount > 0 && _brand.maxAmount > 0) {
      return _generateRangeDenominations(_brand.minAmount, _brand.maxAmount);
    }
    // Nothing the provider gave us. There used to be a [25, 50, 100, 250, 500]
    // fallback here; those amounts belonged to no product. A purchase of one
    // reached the provider and came back "amount 100.00 is not a valid
    // denomination for this product" after the user had already entered their
    // PIN. If the provider publishes no denominations there is nothing to
    // offer, and the screen says so instead of guessing.
    return const [];
  }

  /// Re-reads this product from the ACTIVE buy provider.
  ///
  /// Fails OPEN on a transport/lookup error: an unreachable provider means the
  /// answer is unknown, not that the card is withdrawn, and the buy saga
  /// revalidates against the provider anyway. It fails CLOSED only on an
  /// explicit "not available", which is a definite answer worth blocking on.
  Future<void> _refreshFromProvider() async {
    final ref = widget.brand.productId > 0
        ? widget.brand.productId.toString()
        : widget.brand.id;
    if (ref.isEmpty) {
      if (mounted) setState(() => _liveLoading = false);
      return;
    }

    // Bounded. The CTA stays disabled while this is in flight, so a provider
    // that never answers would otherwise leave the user on a screen they can
    // never buy from. On timeout we fall through to the "could not refresh"
    // path, which allows the purchase and lets the saga revalidate.
    final result = await GetIt.I<IGiftCardRepository>()
        .getGiftCardBrandLive(
          productRef: ref,
          countryCode: widget.brand.countryCode.isNotEmpty
              ? widget.brand.countryCode
              : null,
          // Repeat: read from the ISSUING provider. Reading from the active
          // one would price this ref against a rail where it means another
          // product.
          providerName: widget.pinnedProvider,
        )
        .timeout(
          const Duration(seconds: 20),
          onTimeout: () => Left(
            APIFailure(message: 'Refresh timed out', statusCode: 504),
          ),
        );
    if (!mounted) return;

    result.fold(
      (failure) => setState(() {
        _liveLoading = false;
        _liveRefreshFailed = true;
      }),
      (live) => setState(() {
        _liveLoading = false;
        _liveProvider = live.providerName;
        if (!live.available || live.brand == null) {
          _liveUnavailable = live.reason.isNotEmpty
              ? live.reason
              : 'This gift card is not available right now.';
          return;
        }
        _liveBrand = live.brand;
        // A repeat locks the original amount. If the issuing provider no
        // longer sells that denomination, saying so here is the whole point of
        // the live read — otherwise the locked CTA sends it straight to a
        // provider that will refuse it.
        final relisted = live.brand!;
        if (_isLockedAmount &&
            _selectedAmount != null &&
            relisted.fixedDenominations.isNotEmpty &&
            !relisted.fixedDenominations
                .any((d) => (d.price - _selectedAmount!).abs() < 0.0001)) {
          _liveUnavailable =
              'This card is no longer sold at that amount. Pick a different '
              'amount from the catalogue.';
          return;
        }
        // A denomination selected from the stale tile may not exist on the
        // provider's live list. Drop it rather than carry it into the PIN
        // sheet; the user reselects from amounts that are real.
        final live_ = live.brand!;
        if (_selectedAmount != null && live_.fixedDenominations.isNotEmpty) {
          final stillOffered = live_.fixedDenominations
              .any((d) => (d.price - _selectedAmount!).abs() < 0.0001);
          if (!stillOffered && !_isLockedAmount) {
            _selectedAmount = null;
            _amountController.clear();
          }
        }
      }),
    );
  }

  /// Whether the wallet can fund the amount currently selected.
  ///
  /// The buy saga holds EXACTLY the retail price shown here, so this is an
  /// exact comparison rather than an estimate, and it runs before the PIN
  /// sheet instead of after it.
  GiftCardFundingCheck get _funding {
    final senderAmt = _currentSenderAmount;
    final isMultiCur = _brand.isMultiCurrency && senderAmt != null;
    final chargeCurrency = isMultiCur ? _senderCurrency : _recipientCurrency;
    final chargeAmount = isMultiCur ? senderAmt : _selectedAmount;

    return GiftCardFundingCheck.evaluate(
      chargeAmount: chargeAmount,
      chargeCurrency: chargeCurrency,
      account: _activeAccount,
    );
  }

  /// The dashboard's active account, matched the same way the other service
  /// flows match it (id or spending id). Null when the summaries have not
  /// loaded, which the funding check treats as "cannot tell" and lets pass.
  AccountSummaryEntity? get _activeAccount {
    final activeId = serviceLocator<AccountManager>().activeAccountId;
    if (activeId == null || activeId.isEmpty) return null;
    // The cubit is provided app-wide, but a lookup failure must not take down
    // a purchase screen. No account means "cannot tell", and the check fails
    // open, so the worst case is the backend refusing later as it does today.
    final AccountCardsSummaryState state;
    try {
      state = context.read<AccountCardsSummaryCubit>().state;
    } catch (_) {
      return null;
    }
    // Balances arrive on two states: the loaded list, and the push-driven
    // balance update the dashboard emits after a debit. Read both so the gate
    // is never comparing against a figure the dashboard has already replaced.
    final List<AccountSummaryEntity> summaries;
    if (state is AccountCardsSummaryLoaded) {
      summaries = state.accountSummaries;
    } else if (state is AccountBalanceUpdated) {
      summaries = state.accountSummaries;
    } else {
      return null;
    }
    for (final a in summaries) {
      if (a.id.toString() == activeId || a.spendingAccountId == activeId) {
        return a;
      }
    }
    return null;
  }

  List<double> _generateRangeDenominations(double min, double max) {
    final suggestions = <double>[];
    // Start from min, add mid-points up to max
    suggestions.add(min);
    final mid = ((min + max) / 2).roundToDouble();
    if (mid > min && mid < max) suggestions.add(mid);
    if (max > min) suggestions.add(max.floorToDouble());
    // Add a couple round numbers in between if range is wide
    for (final round in [25.0, 50.0, 75.0, 100.0, 150.0, 200.0]) {
      if (round > min && round < max && !suggestions.contains(round)) {
        suggestions.add(round);
      }
    }
    suggestions.sort();
    return suggestions.take(6).toList();
  }

  bool get _isRangeBased =>
      _brand.fixedDenominations.isEmpty &&
      _brand.minAmount > 0 &&
      _brand.maxAmount > 0;

  // Custom amount is allowed only when Reloadly classifies the brand
  // as RANGE. acceptsCustomAmount prefers the explicit
  // denominationType field and falls back to the legacy heuristic for
  // brands seeded before the field was wired through.
  bool get _hasCustomAmount => _brand.acceptsCustomAmount;

  // FX ratio for converting between sender (locale) and recipient
  // (card) currency on this brand. Derived from the live minSender/
  // minRecipient pair Reloadly returns; null when the brand is
  // single-currency or doesn't expose sender pricing.
  double? get _fxRecipientPerSender {
    if (_brand.minSenderAmount <= 0 || _brand.minAmount <= 0) {
      return null;
    }
    return _brand.minAmount / _brand.minSenderAmount;
  }

  // The currency the prefix icon + hint should reflect. Toggled by the
  // switch CTA next to the input.
  String get _activeEntryCurrency =>
      _entryInSenderCurrency ? _senderCurrency : _recipientCurrency;
  String get _otherEntryCurrency =>
      _entryInSenderCurrency ? _recipientCurrency : _senderCurrency;
  // True only when both currencies are populated and distinct, AND we
  // have FX data to translate between them. Without that, switching is
  // meaningless.
  bool get _canSwitchCurrency =>
      _brand.isMultiCurrency && _fxRecipientPerSender != null;

  // Translate the typed value into the recipient (card-face) amount
  // that the saga + validator expect. When entry is already in
  // recipient currency, this is identity.
  double? _typedToRecipient(String raw) {
    final v = double.tryParse(raw.replaceAll(',', ''));
    if (v == null) return null;
    if (!_entryInSenderCurrency) return v;
    final fx = _fxRecipientPerSender;
    if (fx == null) return v;
    return v * fx;
  }

  // Render the allowed-range hint in the active entry currency.
  // Sender mode: prefer Reloadly's authoritative minSenderAmount /
  // maxSenderAmount when available; fall back to the FX-derived
  // bounds when missing (defensive — should always be populated for
  // multi-currency brands).
  String _allowedRangeText() {
    if (!_entryInSenderCurrency) {
      return 'Allowed: $_recipientCurrency '
          '${_brand.minAmount.toStringAsFixed(0)} – '
          '${_brand.maxAmount.toStringAsFixed(0)}';
    }
    double minS = _brand.minSenderAmount;
    double maxS = _brand.maxSenderAmount;
    if (minS <= 0 || maxS <= 0) {
      // Derive from FX: sender = recipient / (recipient/sender).
      final fx = _fxRecipientPerSender;
      if (fx != null && fx > 0) {
        if (minS <= 0) minS = _brand.minAmount / fx;
        if (maxS <= 0) maxS = _brand.maxAmount / fx;
      }
    }
    if (minS <= 0 || maxS <= 0) {
      return 'Allowed: $_recipientCurrency '
          '${_brand.minAmount.toStringAsFixed(0)} – '
          '${_brand.maxAmount.toStringAsFixed(0)}';
    }
    return 'Allowed: $_senderCurrency '
        '${_formatAmount(minS)} – ${_formatAmount(maxS)}';
  }

  /// For range-based products, estimate the local-currency price from the two
  /// priced anchors the backend sends.
  ///
  /// minSenderAmount / maxSenderAmount are RETAIL: the backend applies the
  /// same fee and rounding the buy saga will charge, so the fee is carried
  /// inside these numbers rather than shown as a separate line.
  ///
  /// Interpolating between both anchors rather than scaling off the minimum
  /// matters whenever the fee has a flat component or a floor. Retail is
  /// `face x rate + fee`, so a single ratio taken at the minimum folds the
  /// whole flat leg into the slope and then re-applies it in proportion,
  /// overstating every larger amount. Two anchors recover the slope and the
  /// constant separately and cancel that error.
  ///
  /// Display-only either way: the backend reprices at live rates at purchase
  /// time and the confirmation screen shows the authoritative figure.
  double? _estimateSenderAmount(double recipientAmount) {
    if (!_isRangeBased) return null;
    if (_brand.minAmount <= 0 || _brand.minSenderAmount <= 0) {
      return null;
    }

    final minAmt = _brand.minAmount;
    final maxAmt = _brand.maxAmount;
    final minSender = _brand.minSenderAmount;
    final maxSender = _brand.maxSenderAmount;

    if (maxAmt > minAmt && maxSender > 0) {
      final slope = (maxSender - minSender) / (maxAmt - minAmt);
      final intercept = minSender - (slope * minAmt);
      final estimate = (recipientAmount * slope) + intercept;
      if (estimate > 0) return estimate;
    }

    // Single usable anchor: fall back to scaling off the minimum. Exact when
    // the fee is percentage-only, slightly high when a flat leg is present.
    return recipientAmount * (minSender / minAmt);
  }

  @override
  void dispose() {
    _balanceSub?.cancel();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGiftCardBgTop,
      // Opaque tap-outside-to-dismiss: the global translucent dismiss in
      // main.dart only fires on truly empty space, so on this dense form the
      // keyboard could linger when tapping an opaque card/padding area. An
      // opaque wrapper here catches every body tap (children still win their
      // own taps first), and onDrag dismisses on scroll.
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: GiftCardBackground(
              child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          _buildBrandCard(),
                          if (_brand.preOrder) ...[
                            SizedBox(height: 12.h),
                            const PreOrderNotice(),
                          ],
                          SizedBox(height: 16.h),
                          _buildAmountSelection(),
                          SizedBox(height: 16.h),
                          _buildPriceSummary(),
                          _buildAvailabilityNotice(),
                          GiftCardFundingNotice(check: _funding),
                          SizedBox(height: 18.h),
                          _buildPurchaseButton(),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(19.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 16.sp),
            ),
          ),
          Expanded(
            child: Text(
              'Purchase Gift Card',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 38.w),
        ],
      ),
    );
  }

  Widget _buildBrandCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: _brand.logoUrl,
                fit: BoxFit.contain,
                placeholder: (context, url) => Icon(
                  Icons.image_rounded,
                  color: Colors.grey.shade400,
                  size: 22.sp,
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.card_giftcard_rounded,
                  color: Colors.grey.shade400,
                  size: 22.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _brand.name,
                  style: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  plainFromRichText(_brand.description),
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (_brand.discountPercentage > 0) ...[
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                '${_brand.discountPercentage.toStringAsFixed(0)}% OFF',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF10B981),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Get the sender currency label for display
  String get _senderCurrency => _brand.senderCurrencyCode.isNotEmpty
      ? _brand.senderCurrencyCode
      : 'NGN';

  /// Get the recipient currency label for display
  String get _recipientCurrency =>
      _brand.currencyCode.isNotEmpty ? _brand.currencyCode : 'NGN';

  /// Get the sender (payment) amount for the currently selected denomination
  double? get _currentSenderAmount {
    if (_selectedAmount == null) return null;
    // Try fixed denomination lookup first
    final fixed = _brand.getSenderAmountForDenomination(_selectedAmount!);
    if (fixed != null) return fixed;
    // For range-based products, estimate using min ratio
    return _estimateSenderAmount(_selectedAmount!);
  }

  Widget _buildAmountSelection() {
    // Repeat-purchase mode: render a single locked summary instead
    // of pills + custom input. Mirrors the "you're buying X" pattern
    // — user can't change the amount, just confirm and tap Buy.
    if (_isLockedAmount) {
      final senderPrice = _currentSenderAmount;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.primaryPurple,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$_recipientCurrency ${_selectedAmount!.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (senderPrice != null &&
                    _senderCurrency != _recipientCurrency) ...[
                  SizedBox(height: 4.h),
                  Text(
                    '$_senderCurrency ${_formatAmount(senderPrice)}',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.lock_rounded,
                  size: 12.sp, color: const Color(0xFF6B7280)),
              SizedBox(width: 4.w),
              Text(
                'Repeat purchase — amount locked to your previous order',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Amount',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _denominations.asMap().entries.map((entry) {
            final idx = entry.key;
            final amount = entry.value;
            final isSelected = _selectedAmount == amount;
            // Always show local currency price below the card value
            // For fixed denominations: use the matching senderDenominations entry
            // For range-based: estimate using min sender/recipient ratio
            double? senderPrice;
            if (_brand.senderDenominations.isNotEmpty &&
                idx < _brand.senderDenominations.length) {
              senderPrice = _brand.senderDenominations[idx];
            } else if (_isRangeBased) {
              senderPrice = _estimateSenderAmount(amount);
            }
            return GestureDetector(
              key: Key('giftcard_denom_pill_$idx'),
              onTap: () {
                setState(() {
                  _selectedAmount = amount;
                  _amountController.text = amount.toStringAsFixed(0);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? InvoiceThemeColors.primaryPurple
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected
                        ? InvoiceThemeColors.primaryPurple
                        : const Color(0xFF2D2D2D),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$_recipientCurrency ${amount.toStringAsFixed(0)}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (senderPrice != null &&
                        _senderCurrency != _recipientCurrency) ...[
                      SizedBox(height: 2.h),
                      Text(
                        '$_senderCurrency ${_formatAmount(senderPrice)}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.8)
                              : const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        // Custom amount block — always rendered so the user knows the
        // input exists, but DISABLED when the brand is FIXED-only
        // (Reloadly denominationType=FIXED). Per-brand:
        //   • RANGE → editable; min/max validation
        //   • FIXED → disabled; helper text directs the user to pills
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              child: Text(
                _hasCustomAmount
                    ? 'Or enter custom amount'
                    : 'This card only accepts the listed amounts',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
            // Currency switch CTA — only shown when the brand is
            // multi-currency and we have FX to convert between
            // recipient (card face) and sender (locale) values.
            if (_hasCustomAmount && _canSwitchCurrency)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _entryInSenderCurrency = !_entryInSenderCurrency;
                    _amountController.clear();
                    _selectedAmount = null;
                  });
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFF3D3D3D)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Muted label so the switch reads as a
                      // secondary affordance — it's an option,
                      // not a primary CTA.
                      Icon(Icons.swap_horiz_rounded,
                          size: 14.sp, color: const Color(0xFF9CA3AF)),
                      SizedBox(width: 4.w),
                      Text(
                        'Switch to $_otherEntryCurrency',
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: _hasCustomAmount
                ? const Color(0xFF1F1F1F)
                : const Color(0xFF141414),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: TextFormField(
            controller: _amountController,
            enabled: _hasCustomAmount,
            keyboardType: const TextInputType.numberWithOptions(decimal: false),
            // Hard-clip pasted/IME input to digits only (keyboardType alone
            // is a hint, not a guarantee — clipboard can still inject text).
            // Length cap of 8 digits = up to 99,999,999 in entry units,
            // which exceeds every Reloadly maxRecipientDenomination we've
            // seen and prevents UI overflow / overflow exceptions.
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(8),
            ],
            style: GoogleFonts.inter(
              color: _hasCustomAmount ? Colors.white : const Color(0xFF6B7280),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            onChanged: (value) {
              if (value.isEmpty) return;
              setState(() {
                _selectedAmount = _typedToRecipient(value);
              });
            },
            decoration: InputDecoration(
              hintText: _hasCustomAmount
                  ? 'Enter amount in $_activeEntryCurrency'
                  : 'Pick one of the amounts above',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 16.sp,
              ),
              // Currency code chip in the prefix slot — replaces the
              // hardcoded Icons.attach_money_rounded ($) so the icon
              // matches the destination currency rather than always
              // showing USD.
              prefixIcon: Container(
                margin: EdgeInsets.only(left: 12.w, right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Center(
                  widthFactor: 1,
                  child: Text(
                    _activeEntryCurrency,
                    style: GoogleFonts.inter(
                      color: _hasCustomAmount
                          ? Colors.white
                          : const Color(0xFF6B7280),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
            ),
            validator: (value) {
              // Validation only fires when the field is enabled —
              // disabled (FIXED-only) brands rely solely on the pills.
              if (!_hasCustomAmount) return null;
              if (value == null || value.isEmpty) {
                return 'Please enter an amount';
              }
              final recipient = _typedToRecipient(value);
              if (recipient == null || recipient <= 0) {
                return 'Please enter a valid amount';
              }
              if (_brand.minAmount > 0 &&
                  recipient < _brand.minAmount) {
                return 'Minimum is $_recipientCurrency ${_brand.minAmount.toStringAsFixed(0)}';
              }
              if (_brand.maxAmount > 0 &&
                  recipient > _brand.maxAmount) {
                return 'Maximum is $_recipientCurrency ${_brand.maxAmount.toStringAsFixed(0)}';
              }
              return null;
            },
          ),
        ),
        // Allowed range — always shown so the user knows the bounds
        // even on FIXED brands (helps explain why custom is locked).
        // Range reflects the active entry currency: when the user
        // toggled to sender, we show min/max in sender units derived
        // from Reloadly's minSenderAmount/maxSenderAmount (the same
        // numbers that drive the price summary's FX rate row).
        if (_brand.minAmount > 0 && _brand.maxAmount > 0) ...[
          SizedBox(height: 6.h),
          Text(
            _hasCustomAmount
                ? _allowedRangeText()
                : 'Listed amounts only — custom entry disabled by Reloadly',
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ],
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      return amount.toStringAsFixed(0).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (match) => '${match[1]},',
          );
    }
    return amount.toStringAsFixed(2);
  }

  Widget _buildPriceSummary() {
    final amount = _selectedAmount ?? 0;
    final senderAmountNullable = _currentSenderAmount;
    final hasSenderPrice =
        senderAmountNullable != null && _senderCurrency != _recipientCurrency;
    final total = senderAmountNullable ?? amount;

    // Fee breakdown: flat service fee only (no percentage markup)
    final flatFee = _brand.senderFee;
    double subtotal = 0;
    if (hasSenderPrice && total > 0 && flatFee > 0) {
      subtotal = total - flatFee;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      // Swap-style accent panel (mirrors the crypto swap summary card): a faint
      // purple wash over the dark surface so the price breakdown reads as the
      // key review surface, not a flat block.
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0x1A4E03D0), Color(0xFF1F1F1F)],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card-face currency (code + symbol). Surfaces the destination
          // country's currency on the review so the buyer sees exactly
          // which currency the card is denominated in (e.g. "$ USD",
          // "£ GBP") before paying in their locale currency (NGN).
          _buildPriceRow(
            'Card currency',
            '${_buyCurrencySymbolFor(_recipientCurrency)} $_recipientCurrency',
            valueKey: const Key('buy_face_currency'),
          ),
          SizedBox(height: 6.h),
          // Card face value
          _buildPriceRow(
            'Gift Card Value',
            '$_recipientCurrency ${_formatAmount(amount)}',
          ),
          if (hasSenderPrice && subtotal > 0 && flatFee > 0) ...[
            SizedBox(height: 6.h),
            _buildPriceRow(
              'Subtotal',
              '$_senderCurrency ${_formatAmount(subtotal)}',
            ),
            SizedBox(height: 6.h),
            _buildPriceRow(
              'Service Fee',
              '$_senderCurrency ${_formatAmount(flatFee)}',
            ),
          ],
          // Effective rate: total / face value. Includes everything baked
          // into the user's price — Reloadly wholesale + platform margin +
          // any fees — not the raw inter-bank FX. Labelled "Effective rate"
          // (not "FX rate") so the user isn't misled into thinking they're
          // seeing a market quote.
          if (hasSenderPrice && amount > 0 && total > 0) ...[
            SizedBox(height: 6.h),
            _buildPriceRow(
              'Effective rate',
              '1 $_recipientCurrency = ${_formatAmount(total / amount)} $_senderCurrency',
              valueKey: const Key('buy_fx_rate'),
            ),
          ],
          if (_brand.discountPercentage > 0) ...[
            SizedBox(height: 6.h),
            _buildPriceRow(
              'Discount',
              '-${_brand.discountPercentage.toStringAsFixed(_brand.discountPercentage % 1 == 0 ? 0 : 2)}%',
              isDiscount: true,
            ),
          ],
          SizedBox(height: 8.h),
          Divider(color: const Color(0xFF2D2D2D), height: 1),
          SizedBox(height: 8.h),
          _buildPriceRow(
            'Total',
            hasSenderPrice
                ? '$_senderCurrency ${_formatAmount(total)}'
                : '$_recipientCurrency ${_formatAmount(amount)}',
            isTotal: true,
          ),
          SizedBox(height: 6.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline,
                size: 12.sp,
                color: const Color(0xFF6B7280),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Final price is set at purchase. Live FX may shift the total slightly.',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    height: 1.3,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount,
      {bool isDiscount = false, bool isTotal = false, Key? valueKey}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 15.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          amount,
          key: valueKey,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isDiscount ? const Color(0xFF10B981) : Colors.white,
          ),
        ),
      ],
    );
  }

  // Currency-symbol map for the card-face currency line (mirrors the
  // sell screen's _currencySymbolFor). Lets the buy price summary surface
  // the destination country's currency code AND symbol on the review.
  static const Map<String, String> _kBuyCurrencySymbols = {
    'NGN': '₦', // ₦
    'USD': '\$',
    'GBP': '£', // £
    'EUR': '€', // €
    'CAD': 'C\$',
    'AUD': 'A\$',
    'JPY': '¥', // ¥
    'ZAR': 'R',
    'GHS': 'GH₵', // GH₵
    'KES': 'KSh',
  };

  String _buyCurrencySymbolFor(String code) =>
      _kBuyCurrencySymbols[code.toUpperCase()] ?? code.toUpperCase();

  /// Why the buy CTA is disabled, or null when it is enabled.
  ///
  /// Every reason is resolved BEFORE the transaction-PIN sheet. The old flow
  /// went straight from this button to the PIN, so a card the provider had
  /// withdrawn, or a purchase the wallet could not fund, was only refused
  /// after the user had authenticated it.
  String? get _blockReason {
    if (_liveUnavailable.isNotEmpty) return 'Unavailable';
    if (_liveLoading) return 'Checking availability';
    if (_selectedAmount == null || _selectedAmount! <= 0) return 'Buy Gift Card';
    final funding = _funding;
    if (funding.isInsufficient) return 'Insufficient balance';
    if (funding.isUnusable) return 'Account unavailable';
    return null;
  }

  Widget _buildPurchaseButton() {
    final blocked = _blockReason;
    final isValid = blocked == null;
    final senderAmt = _currentSenderAmount;
    final isMultiCur = _brand.isMultiCurrency && senderAmt != null;
    final displayCurrency = isMultiCur ? _senderCurrency : _recipientCurrency;
    final displayAmount = isMultiCur ? senderAmt : (_selectedAmount ?? 0.0);

    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        key: const Key('purchase_giftcard_button'),
        onTap: isValid && !_isPurchasing ? _purchaseGiftCard : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 13.h),
          decoration: BoxDecoration(
            gradient: isValid
                ? const LinearGradient(
                    colors: [
                      InvoiceThemeColors.primaryPurple,
                      Color(0xFF6366F1)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: isValid ? null : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: _isPurchasing
                ? LazerVaultLoader(size: 22)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        blocked ?? 'Purchase Gift Card',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              isValid ? Colors.white : const Color(0xFF6B7280),
                        ),
                      ),
                      if (isValid && displayAmount > 0) ...[
                        SizedBox(height: 2.h),
                        Text(
                          '$displayCurrency ${_formatAmount(displayAmount)}',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: isValid
                                ? Colors.white.withValues(alpha: 0.8)
                                : const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  /// Renders the provider's own verdict on this product: a refusal, or the
  /// brief moment while the live read is still in flight.
  Widget _buildAvailabilityNotice() {
    if (_liveUnavailable.isNotEmpty) {
      return Container(
        key: const Key('giftcard_unavailable_notice'),
        margin: EdgeInsets.only(top: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(14.r),
          border:
              Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.32)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline,
                color: const Color(0xFFEF4444), size: 18.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Not available right now',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFEF4444),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _liveUnavailable,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      height: 1.5,
                      color: const Color(0xFFB6B9C6),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      'Browse other cards',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // The provider published no denominations at all. Previously the screen
    // invented [25, 50, 100, 250, 500] here, which is how an amount that
    // belonged to no product reached the buy saga.
    if (!_liveLoading && _denominations.isEmpty && !_hasCustomAmount) {
      return Container(
        key: const Key('giftcard_no_denominations_notice'),
        margin: EdgeInsets.only(top: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(14.r),
          border:
              Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.32)),
        ),
        child: Text(
          'Our supplier has not published any amounts for this card right now. '
          'Please try another card.',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            height: 1.5,
            color: const Color(0xFFB6B9C6),
          ),
        ),
      );
    }

    // The live read did not complete. Not a refusal — the answer is simply
    // unknown, so the purchase is still allowed (the buy saga revalidates
    // against the provider) but the user is told the amounts on screen are the
    // catalogue's rather than a fresh quote.
    if (_liveRefreshFailed) {
      return Container(
        key: const Key('giftcard_stale_notice'),
        margin: EdgeInsets.only(top: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        ),
        child: Text(
          'We could not refresh prices just now, so these are the last known '
          'amounts. The final price is confirmed at purchase.',
          style: GoogleFonts.inter(
            fontSize: 11.5.sp,
            height: 1.5,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  bool _isPurchasing = false;

  void _purchaseGiftCard() async {
    if (_selectedAmount == null || _selectedAmount! <= 0) return;
    // Defence in depth. The CTA is already disabled for each of these, but the
    // sheet must be unreachable by any path — this is the last point before a
    // PIN prompt implies to the user that the purchase is going ahead.
    if (_blockReason != null) return;
    if (_formKey.currentState!.validate() ||
        _brand.fixedDenominations.isNotEmpty) {
      final amount = _selectedAmount!;
      final transactionId =
          'giftcard_${DateTime.now().millisecondsSinceEpoch}_${_brand.id}';
      // For PIN confirmation, show the payment amount in sender currency
      final senderAmt = _currentSenderAmount;
      final isMultiCur = _brand.isMultiCurrency && senderAmt != null;
      final displayCurrency = isMultiCur ? _senderCurrency : _recipientCurrency;
      final displayAmount = isMultiCur ? senderAmt : amount;
      // Final price is recomputed at execution time using the
      // provider's live rate (Reloadly). The amount shown here is
      // an estimate; if the rate moves between confirm and execute,
      // the actual charge tracks the latest rate (account may go
      // into a small overdraft if the rate climbs past the held
      // buffer).
      final priceNotice =
          'Final price is calculated at the time of purchase using the provider\'s latest rate.';
      // Pre-order cards are not fulfilled instantly. The PIN sheet is the last
      // moment before money moves, so the caveat is repeated here even though
      // the purchase screen already showed it: this is the point of consent.
      final deliveryNotice = _brand.preOrder
          ? '\n\nDelivery is not instant. This card is a pre-order, so you pay '
              'now and the code is delivered once the supplier releases it.'
          : '';
      final confirmMessage = isMultiCur
          ? 'Purchase ${_brand.name} $_recipientCurrency ${_formatAmount(amount)} gift card for about $_senderCurrency ${_formatAmount(senderAmt)}.\n\n$priceNotice$deliveryNotice'
          : 'Confirm purchase of $displayCurrency ${_formatAmount(displayAmount)} ${_brand.name} gift card.\n\n$priceNotice$deliveryNotice';

      String? verificationToken;

      // Dismiss the amount-field keyboard before the PIN sheet slides up so it
      // never lingers behind the modal.
      FocusScope.of(context).unfocus();

      final success = await validateTransactionPin(
        context: context,
        transactionId: transactionId,
        transactionType: 'gift_card_purchase',
        amount: displayAmount,
        currency: displayCurrency,
        title: 'Confirm Gift Card Purchase',
        message: confirmMessage,
        // Gift card purchase: provider call happens on the dedicated
        // gift_card_purchase_processing screen *after* this modal closes,
        // so the modal should stop at "PIN verified" rather than animating
        // a "processing" phase whose timing has nothing to do with the
        // actual Reloadly call.
        showProcessingPhase: false,
        onPinValidated: (token) async {
          verificationToken = token;
        },
      );

      if (!success || verificationToken == null) return;
      if (!mounted) return;

      setState(() => _isPurchasing = true);
      // Always pass senderAmount + senderCurrency explicitly — the
      // backend used to fall back to a hardcoded "NGN" when the
      // currency was null, which was wrong for any non-NGN account.
      // The brand's senderCurrencyCode comes from Reloadly's product
      // response and reflects the currency the user-facing price is
      // already denominated in (per-locale localised by Reloadly), so
      // it's the SAME source as the listing display in this screen.
      Get.offNamed(
        AppRoutes.giftCardPurchaseProcessing,
        arguments: GiftCardPurchaseArgs(
          // The LIVE brand, not the catalogue tile. Denominations and prices
          // belong to the provider that answered a moment ago; the tile may
          // have been built under the other provider entirely.
          brand: _brand,
          amount: amount,
          transactionId: transactionId,
          verificationToken: verificationToken!,
          productId: _brand.productId > 0 ? _brand.productId : null,
          countryCode:
              _brand.countryCode.isNotEmpty ? _brand.countryCode : null,
          // Provider the amount was quoted by, preferring the live answer.
          // Sending the tile's provider here would ask one rail to honour a
          // denomination list the other rail published.
          providerName: widget.pinnedProvider?.isNotEmpty == true
              ? widget.pinnedProvider
              : (_liveProvider.isNotEmpty
                  ? _liveProvider
                  : (_brand.providerName.isNotEmpty
                      ? _brand.providerName
                      : null)),
          // Only a repeat pins. A fresh buy must stay subject to the
          // active-provider consistency check.
          pinProvider: widget.pinnedProvider?.isNotEmpty == true,
          senderAmount: senderAmt,
          senderCurrency: _senderCurrency,
        ),
      );
    }
  }
}
