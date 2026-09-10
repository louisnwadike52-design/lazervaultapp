import 'package:flutter/material.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

import '../../domain/entities/escrow_deal_entity.dart';
import '../../domain/entities/escrow_offer_entity.dart';
import '../cubit/escrow_cubit.dart';
import '../view/escrow_theme.dart';

/// Bottom sheet that funds an agreed offer: styled "Fund from" tile
/// (auto-selected to the dashboard-ACTIVE account), fee breakdown, PIN, fund.
///
/// Returns the funded [EscrowDealEntity], or null when dismissed/failed.
///
/// Account rules (product decision 2026-09-07):
///  - ANY account in the offer's currency may fund; the DEFAULT is whichever
///    account was active on the dashboard when Escrow Pay was opened
///    (AccountManager stores its spendingAccountId), then primary, then first.
///  - Selection and the wire value are the account's `spendingAccountId` —
///    for a family account the group `id` is NOT debitable, which was a live
///    bug in the old create flow's dropdown.
Future<EscrowDealEntity?> showEscrowOfferFundSheet(
  BuildContext context, {
  required EscrowOfferEntity offer,
}) {
  return showModalBottomSheet<EscrowDealEntity>(
    context: context,
    isScrollControlled: true,
    backgroundColor: EscrowTheme.card,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
    builder: (ctx) => BlocProvider.value(
      value: context.read<EscrowCubit>(),
      child: _EscrowOfferFundSheet(offer: offer),
    ),
  );
}

class _EscrowOfferFundSheet extends StatefulWidget {
  final EscrowOfferEntity offer;
  const _EscrowOfferFundSheet({required this.offer});

  @override
  State<_EscrowOfferFundSheet> createState() => _EscrowOfferFundSheetState();
}

class _EscrowOfferFundSheetState extends State<_EscrowOfferFundSheet>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  AccountSummaryEntity? _selected;
  bool _accountAutoSelected = false;
  EscrowFeeQuote? _quote;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<AccountCardsSummaryCubit>();
      if (cubit.state is! AccountCardsSummaryLoaded) {
        final userId = context.read<AuthenticationCubit>().userId;
        if (userId != null) cubit.fetchAccountSummaries(userId: userId);
      } else {
        _preSelectAccount(cubit.state as AccountCardsSummaryLoaded);
      }
      _loadQuote();
    });
  }

  Future<void> _loadQuote() async {
    final q = await context.read<EscrowCubit>().quoteFee(
          widget.offer.amount,
          currency: widget.offer.currency,
          // Price on THIS offer's agreed split. Without it the sheet quoted the
          // global default, so a seller who volunteered to cover the whole fee
          // still had a fee line added to the buyer's total here — a number the
          // buyer was never charged, and the exact opposite of the promo the
          // listing advertises.
          offerId: widget.offer.id,
        );
    if (mounted && q != null) setState(() => _quote = q);
  }

  List<AccountSummaryEntity> _eligible(List<AccountSummaryEntity> all) => all
      .where((a) => a.currency.toUpperCase() == widget.offer.currency.toUpperCase())
      .toList();

  /// Default = the dashboard-ACTIVE account (AccountManager holds its
  /// spendingAccountId), then primary, then first. Latched so a later rebuild
  /// never stomps a manual pick (cable-TV precedent).
  void _preSelectAccount(AccountCardsSummaryLoaded state) {
    if (_accountAutoSelected) return;
    final accounts = _eligible(state.accountSummaries);
    if (accounts.isEmpty) return;
    final activeId = GetIt.I<AccountManager>().activeAccountId;
    final active = activeId == null
        ? null
        : accounts
            .where((a) => a.spendingAccountId == activeId || a.id == activeId)
            .firstOrNull;
    final primary = accounts.where((a) => a.isPrimary).firstOrNull;
    setState(() {
      _selected = active ?? primary ?? accounts.first;
      _accountAutoSelected = true;
    });
  }

  String _money(double v) =>
      '${widget.offer.currency} ${NumberFormat('#,##0.00').format(v)}';

  double get _payable => _quote?.buyerTotal ?? widget.offer.amount;
  bool get _hasEnough =>
      _selected != null && _selected!.availableBalance >= _payable;

  Future<void> _fund() async {
    // Re-entrancy guard set BEFORE the first await: a double-tap here would
    // otherwise open two PIN sheets → two fund RPCs (the contactless-payment
    // confirmation screen documents this double-debit risk; same pattern).
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    final cubit = context.read<EscrowCubit>();
    final acct = _selected;
    if (acct == null) {
      setState(() => _isProcessing = false);
      return;
    }
    try {
      HapticFeedback.mediumImpact();
      final txnId = 'ESCROW-${const Uuid().v4().substring(0, 8)}';
      final idem = const Uuid().v4();
      String? token;
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'escrow_fund',
        amount: _payable,
        currency: widget.offer.currency,
        title: 'Fund escrow',
        message:
            'Lock ${_money(_payable)} in escrow for "${widget.offer.title}"',
        showProcessingPhase: false,
        onPinValidated: (t) async => token = t,
      );
      if (!ok || token == null) return;

      final deal = await cubit.fundOffer(
        offerId: widget.offer.id,
        buyerAccountId: acct.spendingAccountId,
        transactionId: txnId,
        verificationToken: token!,
        idempotencyKey: idem,
      );
      if (deal != null && mounted) Navigator.of(context).pop(deal);
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<void> _pickAccount(List<AccountSummaryEntity> accounts) async {
    final picked = await showModalBottomSheet<AccountSummaryEntity>(
      context: context,
      backgroundColor: EscrowTheme.card,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18.r))),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Text('Fund from',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 6.h),
            for (final a in accounts)
              ListTile(
                leading: Icon(Icons.account_balance_wallet_outlined,
                    color: EscrowTheme.primary, size: 22.sp),
                title: Text(
                    '${a.accountType}${a.accountNumberLast4.isNotEmpty ? ' •• ${a.accountNumberLast4}' : ''}',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 14.sp)),
                subtitle: Text(
                    '${currency_formatter.CurrencySymbols.formatAmountWithCurrency(a.availableBalance, a.currency)} available',
                    style: GoogleFonts.inter(
                        color: a.availableBalance >= _payable
                            ? EscrowTheme.textSecondary
                            : EscrowTheme.error,
                        fontSize: 12.sp)),
                trailing: a.spendingAccountId == _selected?.spendingAccountId
                    ? Icon(Icons.check_circle,
                        color: EscrowTheme.primary, size: 20.sp)
                    : null,
                onTap: () => Navigator.pop(ctx, a),
              ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
    if (picked != null && mounted) setState(() => _selected = picked);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      listener: (context, state) {
        if (state is AccountCardsSummaryLoaded) _preSelectAccount(state);
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.lock_outline, color: EscrowTheme.primary, size: 22.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text('Buy securely with escrow',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ]),
            SizedBox(height: 6.h),
            Text(
                'We hold your money until you confirm delivery of "${widget.offer.title}".',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 12.5.sp)),
            SizedBox(height: 16.h),
            _label('Fund from'),
            _fundFromTile(),
            SizedBox(height: 14.h),
            _feeBreakdown(),
            SizedBox(height: 18.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    (_selected == null || !_hasEnough || _isProcessing)
                        ? null
                        : _fund,
                style: ElevatedButton.styleFrom(
                  backgroundColor: EscrowTheme.primary,
                  disabledBackgroundColor:
                      EscrowTheme.primary.withValues(alpha: 0.35),
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: _isProcessing
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : Text('Pay ${_money(_payable)} into escrow',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(t,
            style: GoogleFonts.inter(
                color: EscrowTheme.textSecondary,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600)),
      );

  /// The styled fund-from tile — the create-flow's `_sellerPicker` idiom
  /// (card fill, accent border once resolved, icon + two-line + trailing
  /// action), replacing the old bare DropdownButton.
  Widget _fundFromTile() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        final accounts = state is AccountCardsSummaryLoaded
            ? _eligible(state.accountSummaries)
            : const <AccountSummaryEntity>[];
        final a = _selected;
        return InkWell(
          onTap: accounts.isEmpty ? null : () => _pickAccount(accounts),
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: EscrowTheme.bg,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: a == null ? EscrowTheme.border : EscrowTheme.primary),
            ),
            child: Row(
              children: [
                Icon(Icons.account_balance_wallet_outlined,
                    color: EscrowTheme.primary, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: a == null
                      ? Text(
                          accounts.isEmpty
                              ? 'Loading your accounts…'
                              : 'Choose an account',
                          style: GoogleFonts.inter(
                              color: EscrowTheme.textSecondary,
                              fontSize: 13.5.sp))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${a.accountType}${a.accountNumberLast4.isNotEmpty ? ' •• ${a.accountNumberLast4}' : ''}',
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 2.h),
                            Text(
                                '${currency_formatter.CurrencySymbols.formatAmountWithCurrency(a.availableBalance, a.currency)} available',
                                style: GoogleFonts.inter(
                                    color: _hasEnough
                                        ? EscrowTheme.textSecondary
                                        : EscrowTheme.error,
                                    fontSize: 12.sp)),
                            if (!_hasEnough) ...[
                              SizedBox(height: 4.h),
                              Text('Not enough for this purchase',
                                  style: GoogleFonts.inter(
                                      color: EscrowTheme.error,
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ],
                        ),
                ),
                Icon(Icons.swap_horiz_rounded,
                    color: EscrowTheme.textSecondary, size: 18.sp),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _feeBreakdown() {
    final q = _quote;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: EscrowTheme.bg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: EscrowTheme.border),
      ),
      child: Column(
        children: [
          _row('Item price', _money(widget.offer.amount)),
          if (q != null && q.fee > 0 && q.buyerTotal > widget.offer.amount)
            _row('Escrow fee', _money(q.buyerTotal - widget.offer.amount)),
          Divider(color: EscrowTheme.border, height: 16.h),
          _row('You pay', _money(_payable), bold: true),
        ],
      ),
    );
  }

  Widget _row(String l, String v, {bool bold = false}) => Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(l,
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 12.5.sp)),
            Text(v,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: bold ? 14.sp : 12.5.sp,
                    fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
          ],
        ),
      );
}
