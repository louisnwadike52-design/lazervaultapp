import 'package:flutter/material.dart';
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

class PurchaseGiftCardScreen extends StatefulWidget {
  final GiftCardBrand brand;
  /// When set, the screen renders in "repeat purchase" mode:
  /// the amount is pre-selected and locked (denomination pills +
  /// custom-amount input both hidden), and the buy CTA is active
  /// the moment the screen mounts. Used by MyGiftCards' bottom-sheet
  /// "Repeat" action.
  final double? lockedAmount;

  const PurchaseGiftCardScreen({
    super.key,
    required this.brand,
    this.lockedAmount,
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

  @override
  void initState() {
    super.initState();
    if (_isLockedAmount) {
      _selectedAmount = widget.lockedAmount;
      _amountController.text = widget.lockedAmount!.toStringAsFixed(0);
    }
  }

  List<double> get _denominations {
    if (widget.brand.fixedDenominations.isNotEmpty) {
      return widget.brand.fixedDenominations.map((d) => d.price).toList();
    }
    // Range-based: generate smart suggestions within min/max
    if (widget.brand.minAmount > 0 && widget.brand.maxAmount > 0) {
      return _generateRangeDenominations(widget.brand.minAmount, widget.brand.maxAmount);
    }
    return [25, 50, 100, 250, 500];
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
      widget.brand.fixedDenominations.isEmpty &&
      widget.brand.minAmount > 0 &&
      widget.brand.maxAmount > 0;

  // Custom amount is allowed only when Reloadly classifies the brand
  // as RANGE. acceptsCustomAmount prefers the explicit
  // denominationType field and falls back to the legacy heuristic for
  // brands seeded before the field was wired through.
  bool get _hasCustomAmount => widget.brand.acceptsCustomAmount;

  // FX ratio for converting between sender (locale) and recipient
  // (card) currency on this brand. Derived from the live minSender/
  // minRecipient pair Reloadly returns; null when the brand is
  // single-currency or doesn't expose sender pricing.
  double? get _fxRecipientPerSender {
    if (widget.brand.minSenderAmount <= 0 || widget.brand.minAmount <= 0) {
      return null;
    }
    return widget.brand.minAmount / widget.brand.minSenderAmount;
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
      widget.brand.isMultiCurrency && _fxRecipientPerSender != null;

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
          '${widget.brand.minAmount.toStringAsFixed(0)} – '
          '${widget.brand.maxAmount.toStringAsFixed(0)}';
    }
    double minS = widget.brand.minSenderAmount;
    double maxS = widget.brand.maxSenderAmount;
    if (minS <= 0 || maxS <= 0) {
      // Derive from FX: sender = recipient / (recipient/sender).
      final fx = _fxRecipientPerSender;
      if (fx != null && fx > 0) {
        if (minS <= 0) minS = widget.brand.minAmount / fx;
        if (maxS <= 0) maxS = widget.brand.maxAmount / fx;
      }
    }
    if (minS <= 0 || maxS <= 0) {
      return 'Allowed: $_recipientCurrency '
          '${widget.brand.minAmount.toStringAsFixed(0)} – '
          '${widget.brand.maxAmount.toStringAsFixed(0)}';
    }
    return 'Allowed: $_senderCurrency '
        '${_formatAmount(minS)} – ${_formatAmount(maxS)}';
  }

  /// For range-based products, calculate the local currency price using backend-provided fee config.
  /// Uses: (recipientAmount * fxRate) + margin% + flatFee
  /// The FX rate is derived from backend's minSenderAmount/minAmount (real Reloadly rate + fees).
  /// At purchase time, the backend recalculates with live rates — this is display-only.
  double? _estimateSenderAmount(double recipientAmount) {
    if (!_isRangeBased) return null;
    if (widget.brand.minAmount <= 0 || widget.brand.minSenderAmount <= 0) return null;
    // The ratio already includes margin + flat fee (baked in by the backend retail pricing)
    final rateWithFees = widget.brand.minSenderAmount / widget.brand.minAmount;
    return recipientAmount * rateWithFees;
  }

  @override
  void dispose() {
    _amountController.dispose();
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
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      _buildBrandCard(),
                      SizedBox(height: 16.h),
                      _buildAmountSelection(),
                      SizedBox(height: 16.h),
                      _buildPriceSummary(),
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
      ),
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
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16.sp),
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
                imageUrl: widget.brand.logoUrl,
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
                  widget.brand.name,
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
                  widget.brand.description,
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
          if (widget.brand.discountPercentage > 0) ...[
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                '${widget.brand.discountPercentage.toStringAsFixed(0)}% OFF',
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
  String get _senderCurrency =>
      widget.brand.senderCurrencyCode.isNotEmpty ? widget.brand.senderCurrencyCode : 'NGN';

  /// Get the recipient currency label for display
  String get _recipientCurrency =>
      widget.brand.currencyCode.isNotEmpty ? widget.brand.currencyCode : 'NGN';

  /// Get the sender (payment) amount for the currently selected denomination
  double? get _currentSenderAmount {
    if (_selectedAmount == null) return null;
    // Try fixed denomination lookup first
    final fixed = widget.brand.getSenderAmountForDenomination(_selectedAmount!);
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
            if (widget.brand.senderDenominations.isNotEmpty &&
                idx < widget.brand.senderDenominations.length) {
              senderPrice = widget.brand.senderDenominations[idx];
            } else if (_isRangeBased) {
              senderPrice = _estimateSenderAmount(amount);
            }
            return GestureDetector(
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
                    if (senderPrice != null && _senderCurrency != _recipientCurrency) ...[
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
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                        color: const Color(0xFF3D3D3D)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Muted label so the switch reads as a
                      // secondary affordance — it's an option,
                      // not a primary CTA.
                      Icon(Icons.swap_horiz_rounded,
                          size: 14.sp,
                          color: const Color(0xFF9CA3AF)),
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
              color: _hasCustomAmount
                  ? Colors.white
                  : const Color(0xFF6B7280),
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
              prefixIconConstraints:
                  BoxConstraints(minWidth: 0, minHeight: 0),
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
              if (widget.brand.minAmount > 0 &&
                  recipient < widget.brand.minAmount) {
                return 'Minimum is $_recipientCurrency ${widget.brand.minAmount.toStringAsFixed(0)}';
              }
              if (widget.brand.maxAmount > 0 &&
                  recipient > widget.brand.maxAmount) {
                return 'Maximum is $_recipientCurrency ${widget.brand.maxAmount.toStringAsFixed(0)}';
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
        if (widget.brand.minAmount > 0 && widget.brand.maxAmount > 0) ...[
          SizedBox(height: 6.h),
          Text(
            _hasCustomAmount ? _allowedRangeText() : 'Listed amounts only — custom entry disabled by Reloadly',
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
    final hasSenderPrice = senderAmountNullable != null && _senderCurrency != _recipientCurrency;
    final total = senderAmountNullable ?? amount;

    // Fee breakdown: flat service fee only (no percentage markup)
    final flatFee = widget.brand.senderFee;
    double subtotal = 0;
    if (hasSenderPrice && total > 0 && flatFee > 0) {
      subtotal = total - flatFee;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            ),
          ],
          if (widget.brand.discountPercentage > 0) ...[
            SizedBox(height: 6.h),
            _buildPriceRow(
              'Discount',
              '-${widget.brand.discountPercentage.toStringAsFixed(widget.brand.discountPercentage % 1 == 0 ? 0 : 2)}%',
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

  Widget _buildPriceRow(String label, String amount, {bool isDiscount = false, bool isTotal = false}) {
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
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isDiscount
                ? const Color(0xFF10B981)
                : Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseButton() {
    final isValid = _selectedAmount != null && _selectedAmount! > 0;
    final senderAmt = _currentSenderAmount;
    final isMultiCur = widget.brand.isMultiCurrency && senderAmt != null;
    final displayCurrency = isMultiCur ? _senderCurrency : _recipientCurrency;
    final displayAmount = isMultiCur ? senderAmt : (_selectedAmount ?? 0.0);

    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: isValid && !_isPurchasing ? _purchaseGiftCard : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 13.h),
          decoration: BoxDecoration(
            gradient: isValid
                ? const LinearGradient(
                    colors: [InvoiceThemeColors.primaryPurple, Color(0xFF6366F1)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                : null,
            color: isValid ? null : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Center(
            child: _isPurchasing
                ? SizedBox(
                    height: 22.h,
                    width: 22.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Purchase Gift Card',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isValid ? Colors.white : const Color(0xFF6B7280),
                        ),
                      ),
                      if (isValid && displayAmount > 0) ...[
                        SizedBox(height: 2.h),
                        Text(
                          '$displayCurrency ${_formatAmount(displayAmount)}',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: isValid ? Colors.white.withValues(alpha: 0.8) : const Color(0xFF6B7280),
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

  bool _isPurchasing = false;

  void _purchaseGiftCard() async {
    if (_selectedAmount == null || _selectedAmount! <= 0) return;
    if (_formKey.currentState!.validate() || widget.brand.fixedDenominations.isNotEmpty) {
      final amount = _selectedAmount!;
      final transactionId = 'giftcard_${DateTime.now().millisecondsSinceEpoch}_${widget.brand.id}';
      // For PIN confirmation, show the payment amount in sender currency
      final senderAmt = _currentSenderAmount;
      final isMultiCur = widget.brand.isMultiCurrency && senderAmt != null;
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
      final confirmMessage = isMultiCur
          ? 'Purchase ${widget.brand.name} $_recipientCurrency ${_formatAmount(amount)} gift card for about $_senderCurrency ${_formatAmount(senderAmt)}.\n\n$priceNotice'
          : 'Confirm purchase of $displayCurrency ${_formatAmount(displayAmount)} ${widget.brand.name} gift card.\n\n$priceNotice';

      String? verificationToken;

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
          brand: widget.brand,
          amount: amount,
          transactionId: transactionId,
          verificationToken: verificationToken!,
          productId: widget.brand.productId > 0 ? widget.brand.productId : null,
          countryCode: widget.brand.countryCode.isNotEmpty ? widget.brand.countryCode : null,
          providerName: widget.brand.providerName.isNotEmpty ? widget.brand.providerName : null,
          senderAmount: senderAmt,
          senderCurrency: _senderCurrency,
        ),
      );
    }
  }
}
