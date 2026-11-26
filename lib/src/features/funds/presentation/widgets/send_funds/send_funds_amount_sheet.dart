import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/confirm_crypto_payment.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/transfer_state.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/recurring_transfer_config.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/schedule_repeat_sheet.dart';
import 'package:lazervault/src/features/widgets/category_selection.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/insufficient_funds_sheet.dart';
import 'package:lazervault/src/features/funds/domain/min_balance_policy.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/min_balance_sheet.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/crypto_pay/domain/pay_source.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/crypto_pay_unavailable_dialog.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/pay_with_crypto_selector.dart';
import 'package:lazervault/src/features/crypto_pay/presentation/pay_with_crypto_sheet.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/send_funds/grant_restriction_notice.dart';
part 'send_funds_amount_sheet_widgets.dart';

/// Short-flow amount entry — a bottom sheet that collects the transfer amount
/// (major units typed; returned in MINOR units) and shows a live fee from
/// [TransferCubit.getTransferFee]. Returns the amount in minor units via
/// `Navigator.pop<int>`, or `null` if cancelled.
///
/// The long flow keeps its full screen; this is the streamlined modal used when
/// the admin enables the short send-funds flow.
class SendFundsAmountSheet extends StatefulWidget {
  final String recipientName;
  final String bankName;
  final String currency; // ISO code, e.g. "NGN"
  final String transferType; // "internal" | "external"
  final String? destinationBankCode;
  final double availableBalanceMajor;

  /// The source wallet's UNSPENT ONBOARDING GRANT, in major units.
  ///
  /// Not a floor and not a hold — it is money we gave the customer that may be
  /// spent on the platform but never paid out. It is here so the sheet can
  /// LABEL it beside the balance before an amount is typed, which is the one
  /// part of the restriction the customer previously could not see.
  ///
  /// Defaults to 0, so a caller that does not know (or a wallet with no grant,
  /// which is almost all of them) renders nothing extra.
  final double restrictedBalanceMajor;

  /// The source wallet's account type, when the caller knows it.
  ///
  /// Used only to pick a PER-WALLET minimum-balance floor. Optional and
  /// null-safe: without it the GLOBAL floor applies client-side, and the
  /// server — which always knows the type — still enforces the per-wallet
  /// figure. So the worst case is a user reaching the server's refusal
  /// instead of this sheet, never a transfer that should have been blocked
  /// going through.
  final String? sourceAccountType;

  /// Short label for the source account being debited (the dashboard's active
  /// swiped account) — just the account name/type, e.g. "Personal" (no number
  /// or mask). Shown compactly beside the recipient in the header, with the
  /// balance beneath it.
  final String sourceAccountLabel;

  /// The screen's TransferCubit (provided above the sheet). Reused for the
  /// live fee quote so we don't construct a second instance.
  final TransferCubit transferCubit;

  const SendFundsAmountSheet({
    super.key,
    required this.recipientName,
    required this.bankName,
    required this.currency,
    required this.transferType,
    required this.transferCubit,
    required this.availableBalanceMajor,
    this.restrictedBalanceMajor = 0,
    this.sourceAccountType,
    required this.sourceAccountLabel,
    this.destinationBankCode,
    this.initialAmountMinor,
  });

  /// Optional pre-filled amount in MINOR units (e.g. from a scanned amount-QR).
  /// Converted to the major-unit display value on open.
  final int? initialAmountMinor;

  // Matches the SelectRecipients sheet theme (white surface, purple accent).
  static const Color _bg = Colors.white;
  static const Color _card = Color(0xFFF3F4F6);
  static const Color _purple = Color.fromARGB(255, 78, 3, 208);
  static const Color _textPrimary = Color(0xFF111827);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _error = Color(0xFFEF4444);

  @override
  State<SendFundsAmountSheet> createState() => _SendFundsAmountSheetState();
}

class _SendFundsAmountSheetState extends State<SendFundsAmountSheet> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _narrationController = TextEditingController();
  final FocusNode _amountFocus = FocusNode();
  Timer? _feeDebounce;
  String? _error;

  @override
  void initState() {
    super.initState();
    // Pre-fill from a scanned amount-QR. Stored/entered value is MAJOR units;
    // convert the incoming MINOR units and drop a trailing ".00" for whole
    // amounts so it reads cleanly.
    final minor = widget.initialAmountMinor;
    if (minor != null && minor > 0) {
      final major = minor / 100.0;
      _controller.text = major == major.roundToDouble()
          ? major.toStringAsFixed(0)
          : major.toStringAsFixed(2);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _onChanged();
      });
    }
  }

  // Optional extras (parity with the long flow). Schedule and recurring are
  // mutually exclusive — setting one clears the other.
  DateTime? _scheduledAt;

  /// True while Continue is doing work the customer cannot see.
  ///
  /// Paying with crypto re-prices the coin over the network before any sheet
  /// appears, so there was a visible pause with the button still live: a
  /// second tap started a second pricing call and could stack a second
  /// confirmation sheet on the first. The flag drives both the button's
  /// spinner and its null onPressed, so the control says what it is doing and
  /// cannot be tapped again while it does it.
  bool _continuing = false;

  ServiceCategory? _category;
  RecurringTransferConfig? _recurring;

  /// PAY WITH CRYPTO: how this transfer will be funded.
  ///
  /// Always starts on the wallet. Selling crypto is a decision, and one taken
  /// for the LAST transfer must never carry into this one.
  PaySource _paySource = PaySource.wallet;

  Future<void> _pickCategory() async {
    // Release the autofocused amount field BEFORE opening the child sheet — the
    // lingering keyboard otherwise sat on top of the category sheet so it read as
    // a black overlay with "nothing happening". (Same fix as _pickScheduleRepeat.)
    FocusScope.of(context).unfocus();
    final picked = await CategorySelectionBottomSheet.show(
      context,
      serviceName: 'transfer',
      categories: ServiceCategory.commonTransferCategories,
      selectedCategory: _category,
    );
    if (picked != null && mounted) {
      setState(() {
        _category = picked;
        // A payment is described EITHER by a category OR by the user's own
        // words, never both. Two descriptions for one payment is not a richer
        // record — it is an ambiguous one, and downstream (receipt, recipient
        // narration, budgeting) each surface would have to pick a winner on
        // its own and they would not agree.
        _narrationController.clear();
      });
    }
  }

  /// One entry point for BOTH one-off scheduling and recurring — opens the
  /// combined [ScheduleRepeatSheet]. Keeps the amount sheet uncluttered (a single
  /// CTA row instead of two separate controls) and enforces mutual exclusivity.
  Future<void> _pickScheduleRepeat() async {
    // Release the autofocused amount field BEFORE opening the child sheet, so its
    // keyboard doesn't linger and cover the schedule sheet's Done button.
    FocusScope.of(context).unfocus();
    final result = await ScheduleRepeatSheet.show(
      context,
      scheduledAt: _scheduledAt,
      recurring: _recurring,
    );
    if (result == null || !mounted) return; // dismissed → keep current

    // PAY WITH CRYPTO CANNOT BE SCHEDULED OR REPEATED, and this is the order
    // the control cannot prevent: the customer picked a coin first and is
    // only now choosing to send it later. Hiding the selector is no help once
    // it has been used, so the clash is said out loud and resolved.
    final choseLater = result.scheduledAt != null || result.recurring != null;
    if (choseLater && _paySource.isCrypto) {
      final useWallet = await CryptoPayUnavailableDialog.show(
        context,
        conflict: result.recurring != null
            ? CryptoPayConflict.recurring
            : CryptoPayConflict.scheduled,
        assetLabel: _paySource.label,
      );
      if (!mounted) return;
      if (!useWallet) {
        // They would rather keep paying with crypto, so the schedule is the
        // thing that is dropped.
        return;
      }
      setState(() => _paySource = PaySource.wallet);
    }

    setState(() {
      _scheduledAt = result.scheduledAt;
      _recurring = result.recurring;
    });
  }

  /// Summary shown on the schedule/repeat CTA.
  String get _scheduleRepeatValue {
    if (_recurring != null) return _recurring!.summary;
    if (_scheduledAt != null) return _formatSchedule(_scheduledAt!);
    return 'Send now';
  }

  /// The quick amounts, and they are ONE ROW.
  ///
  /// A small one leads because the commonest real transfer is not a round
  /// thousand — airtime money, a share of a bill, paying someone back — and
  /// starting at ₦1,000 made the shortcuts useless for exactly those.
  ///
  /// FIVE IS THE CEILING HERE. They are laid out in a Row (spaceBetween, each
  /// Flexible), so a sixth cannot wrap to a second line — it would shrink the
  /// others until "₦10,000" ellipsised into "₦10,0…", which is worse than not
  /// offering it. Add one only by removing one.
  static const List<int> _quickAmounts = [200, 1000, 2000, 5000, 10000];

  String get _symbol {
    switch (widget.currency.toUpperCase()) {
      case 'NGN':
        return '₦';
      case 'USD':
        return '\$';
      case 'GBP':
        return '£';
      case 'EUR':
        return '€';
      case 'GHS':
        return 'GH₵';
      case 'KES':
        return 'KSh';
      case 'ZAR':
        return 'R';
      default:
        return '${widget.currency} ';
    }
  }

  /// Amount in minor units from the major-unit text, or 0 if invalid.
  int get _amountMinor {
    final v = double.tryParse(_controller.text.trim());
    if (v == null || v <= 0) return 0;
    return (v * 100).round();
  }

  void _onChanged() {
    setState(() => _error = null);
    _feeDebounce?.cancel();
    final minor = _amountMinor;
    if (minor <= 0) return;
    // Internal transfers are free; still quote so the receipt total is right.
    _feeDebounce = Timer(const Duration(milliseconds: 350), () {
      widget.transferCubit.getTransferFee(
        amountMinorUnits: minor,
        currency: widget.currency,
        transferType:
            widget.transferType == 'internal' ? 'internal' : 'domestic',
        destinationBankCode: widget.destinationBankCode,
      );
    });
  }

  String _formatSchedule(DateTime d) {
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final hh = d.hour.toString().padLeft(2, '0');
    final mn = d.minute.toString().padLeft(2, '0');
    return '$dd/$mm $hh:$mn';
  }

  Widget _optionTile({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: SendFundsAmountSheet._purple),
            SizedBox(width: 10.w),
            // Label takes the middle (exactly like the Repeat row's Expanded
            // column) so the pill CTA is pushed flush to the right edge —
            // matching the Repeat switch's alignment. Previously the label was
            // followed by a Spacer + a flex:1 Flexible pill, which split the free
            // space and left the pill short of the right edge.
            Expanded(
              child: Text(label,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: SendFundsAmountSheet._textPrimary)),
            ),
            SizedBox(width: 8.w),
            // Compact pill CTA pinned to the right edge (last child ⇒ its right
            // edge is the row's right edge, same as the Switch below).
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 170.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: SendFundsAmountSheet._purple.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                      color:
                          SendFundsAmountSheet._purple.withValues(alpha: 0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(value,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: SendFundsAmountSheet._purple)),
                    ),
                    SizedBox(width: 2.w),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        size: 16.sp, color: SendFundsAmountSheet._purple),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _continue() async {
    // Re-entrancy guard as well as a visual one: a tap that arrives in
    // the same frame as the rebuild would otherwise still get through.
    if (_continuing) return;
    setState(() => _continuing = true);
    try {
      await _continueInner();
    } finally {
      // The sheet pops itself on success, so this may run unmounted.
      if (mounted) setState(() => _continuing = false);
    }
  }

  Future<void> _continueInner() async {
    final minor = _amountMinor;
    if (minor <= 0) {
      setState(() => _error = 'Enter a valid amount');
      return;
    }
    final lastFee = widget.transferCubit.lastFeeLoaded;
    final feeMinor = lastFee?.fee ?? 0;

    // PAYING WITH CRYPTO IS CHECKED HERE, BEFORE THE WALLET CHECK BELOW.
    //
    // Order matters: when a coin is funding the payment, "your wallet is
    // short" is the wrong thing to say — the wallet is not what is paying,
    // and the customer would be sent to top it up for no reason. The crypto
    // path answers for itself and returns.
    //
    // Selling crypto is irreversible, so the question is asked while it is
    // still cheap. The server re-checks all of it; this only means the
    // customer is not told from a refusal AFTER the PIN.
    if (_paySource.isCrypto) {
      // SHARED WITH EVERY OTHER SERVICE THAT TAKES CRYPTO. This used to be a
      // private helper here, so send funds was the only flow that showed the
      // customer anything before the PIN — airtime, data, electricity, cable
      // TV, internet and water went straight to the pad and learned from a
      // refusal afterwards.
      final chosen = await confirmCryptoPayment(
        context,
        source: _paySource,
        totalMinor: minor + feeMinor,
        walletMinor: (widget.availableBalanceMajor * 100).round(),
      );
      if (chosen == null || !mounted) return;
      // The customer may have switched coins inside the sheet; carry that
      // choice forward rather than paying with the one they rejected.
      if (chosen != _paySource) setState(() => _paySource = chosen);
      _finish(minor, feeMinor);
      return;
    }

    // Include the fee in the balance check when a matching quote is loaded
    // (best-effort; the backend hold is the authoritative guard).
    if ((minor + feeMinor) / 100.0 > widget.availableBalanceMajor) {
      // A sheet, not a red line under the field.
      //
      // This is a REFUSAL, not a validation hint: the figures matter (amount,
      // fee, total, balance), the user cannot act on it from here, and "Add
      // money" is an instruction with somewhere to go. The long flow has
      // always said it this way; the short flow set six words in red and
      // offered nothing. Same helper now, so the two cannot drift.
      showInsufficientFunds(
        context,
        currencySymbol: _symbol,
        amountMajor: minor / 100.0,
        feeMajor: feeMinor / 100.0,
        availableMajor: widget.availableBalanceMajor,
        // CRYPTO, OFFERED WHERE IT IS ACTUALLY WANTED. Being told the wallet
        // is short is the moment this matters, and until now the only way to
        // reach it was to dismiss this sheet and find the selector further up
        // the form. Hidden when the gate is off — see showInsufficientFunds.
        //
        // NOT offered on a scheduled or repeating send, for the money reason
        // the selector itself carries: the conversion runs when the transfer
        // is authorised, so pairing it with a later payment would sell the
        // customer's coin today to pay someone next month.
        email: _authEmail,
        userId: _authUserId,
        onPayWithCrypto: (_scheduledAt == null && _recurring == null)
            ? _chooseCryptoSource
            : null,
      );
      // The inline line is still set, so the field stays visibly in an error
      // state behind the sheet and after it is dismissed.
      setState(() => _error = feeMinor > 0
          ? 'Amount + fee exceeds your available balance'
          : 'Amount exceeds your available balance');
      return;
    }

    // MINIMUM RETAINED BALANCE — checked AFTER "do they have enough at all".
    //
    // Order matters. If the wallet cannot cover the transfer, that is the
    // truthful refusal and the floor is beside the point; telling someone to
    // keep ₦1,500 when they only have ₦400 explains the wrong thing. So the
    // harder stop goes first and this only speaks when the transfer WOULD
    // otherwise have succeeded.
    //
    // Resolved from settings already on the device (FeatureFlags), so no
    // request happens while the user is typing and nothing blocks the frame.
    // The server re-checks and is authoritative — this exists so the user
    // learns it here, with the figures, rather than at the PIN sheet.
    final availableMinor = (widget.availableBalanceMajor * 100).round();
    // Scope lives in _retainedBalancePolicy, which is off entirely for an
    // internal send — so there is no external gate to keep in step here.
    final minBalance = _retainedBalancePolicy;
    if (minBalance.blocks(
      availableMinor: availableMinor,
      spendMinor: minor + feeMinor,
    )) {
      showMinBalanceRefusal(
        context,
        currencySymbol: _symbol,
        policy: minBalance,
        availableMinor: availableMinor,
        feeMinor: feeMinor,
        // Offer the largest amount that WOULD go through, and set the field to
        // it, so the user's next tap succeeds instead of returning them here.
        onSendMax: () {
          final max = minBalance.maxSendableMinor(
            availableMinor: availableMinor,
            feeMinor: feeMinor,
          );
          if (max > 0 && mounted) {
            // Written the same way the initial amount is, so the field reads
            // "975" rather than "975.00" on a whole figure.
            final major = max / 100.0;
            _controller.text = major == major.roundToDouble()
                ? major.toStringAsFixed(0)
                : major.toStringAsFixed(2);
            _onChanged();
            setState(() => _error = null);
          }
        },
      );
      // The field stays visibly in an error state behind and after the sheet,
      // matching how the insufficient-funds refusal above behaves. The line
      // names whichever rule actually bound — calling a bonus restriction a
      // "minimum balance" contradicts the sheet the user just read.
      setState(() => _error = minBalance.grantRestricted
          ? 'More than your own money — your bonus stays on Lazervault'
          : 'Your wallet must keep a minimum balance');
      return;
    }
    _finish(minor, feeMinor);
  }

  /// The single exit from this sheet.
  ///
  /// Extracted so the crypto branch and the wallet branch cannot drift: both
  /// have to return the SAME result shape, and a second `Navigator.pop` with
  /// its own argument list is how one of them comes to drop the category or
  /// the chosen coin.
  void _finish(int minor, int feeMinor) {
    // Pass the raw note. Turning a category into narration is
    // ServiceCategory.buildTransferNarration's job — it is shared with the
    // long flow, so doing it here too would give the two flows two different
    // answers the day either one changed.
    final note = _narrationController.text.trim();
    Navigator.of(context).pop(SendFundsAmountResult(
      amountMinor: minor,
      note: note.isEmpty ? null : note,
      scheduledAt: _scheduledAt,
      category: _category,
      recurring: _recurring,
      // Null unless the customer chose a coin — the ordinary path is
      // unchanged.
      fundingAsset: _paySource.asset,
    ));
  }

  String? get _authEmail =>
      context.read<AuthenticationCubit>().currentProfile?.user.email;

  String? get _authUserId =>
      context.read<AuthenticationCubit>().currentProfile?.user.id;

  /// Opens the asset sheet and, if a coin is chosen, switches the source.
  ///
  /// The SAME call the selector makes, so the two entry points cannot end up
  /// doing different things — and a dismissed sheet still changes nothing,
  /// which matters because leaving the source on "Crypto" with no asset would
  /// send a request that cannot be priced.
  Future<void> _chooseCryptoSource() async {
    final picked = await PayWithCryptoSheet.open(
      context,
      amountMinor: _amountMinor,
      walletBalanceMinor: (widget.availableBalanceMajor * 100).round(),
      current: _paySource.isCrypto ? _paySource.asset : null,
    );
    if (picked == null || !mounted) return;
    setState(() {
      _paySource = picked;
      // The inline error described a wallet that cannot cover this. It can
      // now be covered another way, so leaving the field red would contradict
      // the choice the customer just made.
      _error = null;
    });
  }

  /// True when this send is a payout to another bank.
  ///
  /// The single place the scope of BOTH retained-balance rules is decided, so
  /// the blocking check and the label cannot end up disagreeing about it.
  bool get _isExternalPayout => widget.transferType == 'external';

  /// The retained-balance policy for this send: the operator's floor with the
  /// customer's unspent onboarding grant folded in, greater of the two
  /// binding.
  ///
  /// EXTERNAL PAYOUTS ONLY — BOTH RULES.
  ///
  /// The floor is external-only because it exists to keep a balance on the
  /// platform, so a Lazervault-to-Lazervault send is what it encourages rather
  /// than something to stop.
  ///
  /// THE GRANT IS EXTERNAL-ONLY TOO, which is easy to get backwards: parts of
  /// accounts-service describe an internal send as taking the money off the
  /// platform in one hop. That reasoning was SUPERSEDED on 1 Nov 2026 by the
  /// release latch — the restriction now lifts once the balance has fallen to
  /// a threshold, the test is the BALANCE not the service, and internal sends
  /// count as on-platform use like any other. Gating them would leave a
  /// customer who only ever transfers permanently unable to withdraw their own
  /// deposits, which is the trap the latch exists to prevent. The server has
  /// no grant check on the internal rail (TransferBalance) at all, so a client
  /// gate here would refuse a send the backend allows — the worse half of the
  /// bug, because the user never reaches the server to find out.
  ///
  /// Returns a policy that `blocks` always answers false for on an internal
  /// send, so no call site needs a gate of its own.
  MinBalancePolicy get _retainedBalancePolicy {
    if (!_isExternalPayout) return const MinBalancePolicy(enforced: false);
    return MinBalancePolicy.resolve(accountType: widget.sourceAccountType)
        .withRestricted((widget.restrictedBalanceMajor * 100).round());
  }

  @override
  void dispose() {
    _feeDebounce?.cancel();
    _controller.dispose();
    _narrationController.dispose();
    _amountFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final bottomInset = media.viewInsets.bottom;
    // Cap the sheet to the space above the keyboard and let the content scroll,
    // so a tall sheet (amount + quick amounts + fee + extras + CTA) stays
    // anchored above the keyboard instead of clipping off the top of the screen
    // when the keyboard opens.
    final maxSheetHeight =
        media.size.height - media.padding.top - bottomInset - 24.h;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxSheetHeight),
        // Tap any empty area of the sheet to dismiss the keyboard so the pinned
        // Continue footer is reachable (sheet is isDismissible:false + the amount
        // field autofocuses, so this is the only way to drop the keyboard).
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: const BoxDecoration(
              color: SendFundsAmountSheet._bg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fixed header — always visible; never scrolls off the top so the
                // recipient/source stays pinned regardless of the keyboard.
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag handle centered, with a close (X) at the top-right. The
                      // sheet is non-dismissible by tapping outside, so the X is the
                      // explicit way out (e.g. on an insufficient-balance state).
                      Row(
                        children: [
                          SizedBox(width: 22.sp),
                          Expanded(
                            child: Center(
                              child: Container(
                                width: 40.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            behavior: HitTestBehavior.opaque,
                            child: Icon(
                              Icons.close_rounded,
                              size: 22.sp,
                              color: SendFundsAmountSheet._textSecondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // Header — recipient (avatar + name + bank) on the left, source
                      // account ("From <name>" + balance) compactly on the right. The
                      // source no longer has its own card/number/mask — just the type
                      // and balance, so the sheet stays uncluttered.
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 22.r,
                            backgroundColor: SendFundsAmountSheet._purple
                                .withValues(alpha: 0.12),
                            child: Text(
                              widget.recipientName.isNotEmpty
                                  ? widget.recipientName[0].toUpperCase()
                                  : '?',
                              style: GoogleFonts.inter(
                                color: SendFundsAmountSheet._purple,
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.recipientName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: SendFundsAmountSheet._textPrimary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  widget.bankName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: SendFundsAmountSheet._textSecondary,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('From',
                                  style: GoogleFonts.inter(
                                      color:
                                          SendFundsAmountSheet._textSecondary,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 1.h),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 120.w),
                                child: Text(
                                  widget.sourceAccountLabel,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.inter(
                                    color: SendFundsAmountSheet._textPrimary,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                '$_symbol${widget.availableBalanceMajor.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  color: SendFundsAmountSheet._textSecondary,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Scrollable middle — amount, quick pills, note, fee, category and
                // the schedule CTA. Scrolls only if the keyboard makes it tight;
                // the header above and Continue below stay pinned.
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // THE BONUS LABEL, above the amount field.
                        //
                        // Here rather than in the header, where the balance
                        // itself lives: that column is right-aligned and
                        // capped at 120.w for the account name, and two lines
                        // of explanation do not fit beside it. This is the
                        // first thing in the scrollable body, so it is read
                        // immediately before the figure it qualifies.
                        //
                        // EXTERNAL ONLY, like the check itself. On an
                        // internal send the whole balance really is sendable,
                        // so "₦1,000 free to transfer" would be false — and
                        // naming the bonus at all on that flow would advertise
                        // the send-to-a-friend route the operator has accepted
                        // but has no reason to signpost.
                        ...() {
                          final notice = grantRestrictionNotice(
                            context: context,
                            policy: _retainedBalancePolicy,
                            availableMinor:
                                (widget.availableBalanceMajor * 100).round(),
                            currencySymbol: _symbol,
                          );
                          return notice == null
                              ? const <Widget>[]
                              : <Widget>[notice, SizedBox(height: 14.h)];
                        }(),
                        Text('Amount',
                            style: GoogleFonts.inter(
                                color: SendFundsAmountSheet._textSecondary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 8.h),
                        // Centered hero amount — symbol prefix + large value. A tap
                        // anywhere in the box focuses the field (not just the tiny "0").
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => _amountFocus.requestFocus(),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            decoration: BoxDecoration(
                              color: SendFundsAmountSheet._purple
                                  .withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: _error != null
                                    ? SendFundsAmountSheet._error
                                    : SendFundsAmountSheet._purple
                                        .withValues(alpha: 0.25),
                                width: 1.5,
                              ),
                            ),
                            // Symbol + value scale together as ONE centered group. A wide
                            // amount shrinks to fit the box (scaleDown) instead of clipping,
                            // so long values are never truncated and always get full room.
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Text(
                                      _symbol,
                                      style: GoogleFonts.inter(
                                        color:
                                            SendFundsAmountSheet._textSecondary,
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  IntrinsicWidth(
                                    child: TextField(
                                      controller: _controller,
                                      focusNode: _amountFocus,
                                      onChanged: (_) => _onChanged(),
                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d*\.?\d{0,2}')),
                                      ],
                                      style: GoogleFonts.inter(
                                        color:
                                            SendFundsAmountSheet._textPrimary,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.w800,
                                        height: 1.0,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: '0',
                                        hintStyle: GoogleFonts.inter(
                                          color: Colors.grey.shade300,
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.w800,
                                          height: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (_error != null) ...[
                          SizedBox(height: 8.h),
                          Text(_error!,
                              style: GoogleFonts.inter(
                                  color: SendFundsAmountSheet._error,
                                  fontSize: 12.sp)),
                        ],
                        SizedBox(height: 10.h),
                        // SMALLER PILLS, AND TIGHTER.
                        //
                        // The sheet now carries a third option row (Pay with)
                        // and still has to fit with the number pad up. These
                        // are a convenience, not the input — the field above
                        // is — so they are the right thing to give the space
                        // back. At 16/9 padding and 13sp the four of them
                        // crowded the row on a narrow phone and pushed
                        // everything below the fold.
                        // SPREAD ACROSS THE ROW, not bunched to one side.
                        //
                        // A Wrap lays its children out from the start of the
                        // line and centres the LINE, so four pills narrower
                        // than the sheet sat as one short centred block with
                        // the slack split in two — reading as left-tilted
                        // against the full-width field above and the
                        // full-width button below.
                        //
                        // spaceBetween puts the slack BETWEEN them, so the
                        // first and last align with the edges of everything
                        // else on the sheet. Each pill stays Flexible so a
                        // narrow phone shrinks them instead of overflowing —
                        // which is what a plain Row would do, and the reason
                        // the Wrap was there in the first place.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _quickAmounts.map((a) {
                            return Flexible(
                              child: GestureDetector(
                                onTap: () {
                                  _controller.text = a.toString();
                                  _onChanged();
                                },
                                child: Container(
                                  // Tighter than four pills needed: five of
                                  // them share one row and must not shrink
                                  // into ellipses on a narrow phone.
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 6.5.h),
                                  decoration: BoxDecoration(
                                    color: SendFundsAmountSheet._purple
                                        .withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: SendFundsAmountSheet._purple
                                            .withValues(alpha: 0.25)),
                                  ),
                                  child: Text(
                                    '$_symbol${_grouped(a)}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      color: SendFundsAmountSheet._purple,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 10.h),
                        // Narration / note (optional) — below the amount, before category.
                        TextField(
                          controller: _narrationController,
                          textInputAction: TextInputAction.done,
                          textCapitalization: TextCapitalization.sentences,
                          maxLength: 100,
                          // The mirror of _pickCategory: typing your own words
                          // drops the category, so only one description of the
                          // payment ever survives. setState only when the
                          // category is actually set, so ordinary typing does
                          // not rebuild the sheet on every keystroke.
                          onChanged: (v) {
                            if (_category != null && v.trim().isNotEmpty) {
                              setState(() => _category = null);
                            }
                          },
                          style: GoogleFonts.inter(
                            color: SendFundsAmountSheet._textPrimary,
                            fontSize: 13.sp,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: '',
                            hintText: 'Or type your own narration…',
                            hintStyle: GoogleFonts.inter(
                                color: SendFundsAmountSheet._textSecondary,
                                fontSize: 13.sp),
                            prefixIcon: Icon(Icons.notes_rounded,
                                size: 18.sp,
                                color: SendFundsAmountSheet._textSecondary),
                            filled: true,
                            fillColor: SendFundsAmountSheet._card,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: SendFundsAmountSheet._purple
                                      .withValues(alpha: 0.4)),
                            ),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        // Live fee — internal is free; external quotes via the cubit.
                        BlocBuilder<TransferCubit, TransferState>(
                          bloc: widget.transferCubit,
                          buildWhen: (_, s) =>
                              s is TransferFeeLoaded ||
                              s is TransferFeeLoading ||
                              s is TransferFeeError,
                          builder: (context, state) {
                            if (state is TransferFeeLoaded) {
                              final fee = state.fee / 100.0;
                              final total = state.totalAmount / 100.0;
                              return _feeRow(
                                'Fee: $_symbol${fee.toStringAsFixed(2)}',
                                'Total: $_symbol${total.toStringAsFixed(2)}',
                              );
                            }
                            if (state is TransferFeeLoading) {
                              return Text('Calculating fee…',
                                  style: GoogleFonts.inter(
                                      color:
                                          SendFundsAmountSheet._textSecondary,
                                      fontSize: 12.sp));
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        // THE RULE STAYS; THE AIR AROUND IT DOES NOT.
                        //
                        // `Divider(height: 26.h)` reserves 26dp of ROW and
                        // paints a 1dp line in the middle of it, so the line
                        // arrived with ~12dp of empty space above and below —
                        // which is what left Category floating a long way
                        // from the narration field. The divider is useful: it
                        // separates the amount block from the options below.
                        // Only the gap was wrong, so the height comes down to
                        // the line plus a hairline of breathing room.
                        Divider(
                            color: SendFundsAmountSheet._card, height: 14.h),
                        // Optional extras — parity with the long flow.
                        _optionTile(
                          icon: Icons.category_outlined,
                          label: 'Category',
                          value: _category?.displayName ?? 'Optional',
                          onTap: _pickCategory,
                        ),
                        // One CTA for BOTH scheduling and recurring — opens the combined
                        // ScheduleRepeatSheet. Replaces the old inline Schedule tile +
                        // Repeat switch so the sheet stays clean.
                        // PAY WITH CRYPTO. Directly above Schedule/repeat
                        // because the two cannot both apply: the conversion
                        // runs when the transfer is authorised, and a
                        // schedule or repeat pays later. Hidden once either
                        // is set, and the reverse order is caught in
                        // _pickScheduleRepeat.
                        //
                        // NO EXTRA PADDING. The selector is now a row of the
                        // same shape as the two `_optionTile`s around it and
                        // carries its own 10.h, so a wrapper here would make
                        // the middle row of three sit lower than its
                        // neighbours — the uneven spacing that was reported.
                        if (_scheduledAt == null && _recurring == null)
                          PayWithCryptoSelector(
                            onDarkSurface: false,
                            value: _paySource,
                            amountMinor: _amountMinor,
                            email: context
                                .read<AuthenticationCubit>()
                                .currentProfile
                                ?.user
                                .email,
                            userId: context
                                .read<AuthenticationCubit>()
                                .currentProfile
                                ?.user
                                .id,
                            onChanged: (src) =>
                                setState(() => _paySource = src),
                          ),
                        _optionTile(
                          icon: _recurring != null
                              ? Icons.repeat_rounded
                              : Icons.schedule_rounded,
                          label: 'Schedule / repeat',
                          value: _scheduleRepeatValue,
                          onTap: _pickScheduleRepeat,
                        ),
                      ],
                    ),
                  ),
                ),
                // Fixed footer — Continue is always visible and reachable, even
                // with the keyboard up and a tall middle.
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 20.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      // Null while busy: that is what actually stops a second
                      // tap. The spinner only explains why.
                      onPressed: _continuing ? null : _continue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SendFundsAmountSheet._purple,
                        // The disabled default is a pale grey that reads as
                        // "this button is broken". Holding the brand colour
                        // keeps it recognisably the same control, just busy.
                        disabledBackgroundColor:
                            SendFundsAmountSheet._purple.withValues(alpha: 0.7),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: _continuing
                          // Sized to the text it replaces so the footer does
                          // not jump when the state flips.
                          ? SizedBox(
                              height: 20.sp,
                              width: 20.sp,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Continue',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Thousands separator for the quick-amount chips (e.g. 5000 → "5,000").
  String _grouped(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  Widget _feeRow(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left,
            style: GoogleFonts.inter(
                color: SendFundsAmountSheet._textSecondary, fontSize: 12.sp)),
        Text(right,
            style: GoogleFonts.inter(
                color: SendFundsAmountSheet._textPrimary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}
