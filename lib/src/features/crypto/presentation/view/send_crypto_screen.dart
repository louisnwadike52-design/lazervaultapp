import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_config_cubit.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_cubit.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_state.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_withdraw_cubit.dart';
import 'package:lazervault/src/features/crypto/domain/entities/crypto_entity.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

// SendCryptoScreen (PR6) — single-screen send flow:
//   1. Pick asset (from user's holdings).
//   2. Pick network from the holding's `networks` list.
//   3. Enter recipient (address or LazerVault user_id for internal).
//   4. Enter amount + optional note/narration/destination tag.
//   5. PIN bottom sheet via TransactionPinMixin.
//   6. Submit → CryptoWithdrawCubit → receipt sheet.
//
// Server is the security boundary; client-side gating is purely UX (e.g. min
// order from CryptoConfigCubit). Network list comes from the holding's
// per-asset metadata, never hardcoded.

class SendCryptoScreen extends StatefulWidget {
  final CryptoHolding? preselectedHolding;

  const SendCryptoScreen({super.key, this.preselectedHolding});

  @override
  State<SendCryptoScreen> createState() => _SendCryptoScreenState();
}

class _SendCryptoScreenState extends State<SendCryptoScreen>
    with TransactionPinMixin {
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _narrationController = TextEditingController();
  final _destinationTagController = TextEditingController();
  final _networkController = TextEditingController();

  CryptoHolding? _selected;
  bool _isInternal = false;
  bool _isSubmitting = false;

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    _selected = widget.preselectedHolding;
    // Quidax-as-source-of-truth: refresh holdings from the backend
    // (which itself overlays Quidax-live balances) on every mount,
    // so a deposit that landed on the user's Quidax sub-account from
    // an external wallet shows up here immediately. Without this the
    // screen could read a stale CryptoCubit snapshot from the last
    // landing-page load and miss assets the user can legitimately
    // send.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // ignore: use_build_context_synchronously
      context.read<CryptoCubit>().refreshHoldingsLive();
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _narrationController.dispose();
    _destinationTagController.dispose();
    _networkController.dispose();
    super.dispose();
  }

  // Network metadata lives in PR7's `quidax_asset_networks` table — until
  // that lands, the network is a free-text input on the form.

  int _toMinor(double major) {
    try {
      return GetIt.I<CryptoConfigCubit>().config.toMinorUnits(
            major,
            _selected?.cryptoSymbol ?? 'usdt',
          );
    } catch (_) {
      // Conservative fallback when cubit isn't registered (tests).
      return (major * math.pow(10, 8)).round();
    }
  }

  Future<void> _onSend() async {
    if (_selected == null || _isSubmitting) return;
    final amount = double.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      _toast('Enter a valid amount');
      return;
    }
    final recipient = _addressController.text.trim();
    if (recipient.isEmpty) {
      _toast(_isInternal
          ? 'Enter a Lazervault user id or email'
          : 'Enter a destination address');
      return;
    }

    final accountId = _resolveAccountId();
    if (accountId == null) {
      _toast('No active account. Add one to continue.');
      return;
    }

    setState(() => _isSubmitting = true);

    final intentId =
        'WD-${DateTime.now().millisecondsSinceEpoch}-${_selected!.cryptoSymbol}';
    final cubit = context.read<CryptoWithdrawCubit>();

    // PIN bottom-sheet. onPinValidated callback runs the saga. The mixin
    // keeps the sheet open through the processing phase; we explicitly
    // disable the built-in processing phase (showProcessingPhase: false) so
    // the bloc listener can show our own receipt sheet on terminal state.
    await validateTransactionPin(
      context: context,
      transactionId: intentId,
      transactionType: 'crypto_send',
      amount: amount,
      currency: _selected!.cryptoSymbol.toUpperCase(),
      title: 'Confirm Send',
      message: 'Send ${amount.toStringAsFixed(6)} ${_selected!.cryptoSymbol.toUpperCase()}',
      showProcessingPhase: false,
      onPinValidated: (_) async {
        if (!mounted) return;
        await cubit.submit(
          accountId: accountId,
          recipientType: _isInternal ? 'internal' : 'coin_address',
          currency: _selected!.cryptoSymbol,
          amountMinor: _toMinor(amount),
          fundUid: recipient,
          network: _isInternal ? '' : _networkController.text.trim(),
          destinationTag: _destinationTagController.text.trim(),
          transactionNote: _noteController.text.trim(),
          narration: _narrationController.text.trim(),
        );
      },
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);
  }

  String? _resolveAccountId() {
    try {
      return GetIt.I<AccountManager>().activeAccountId;
    } catch (_) {
      return null;
    }
  }

  void _toast(String msg) {
    Get.snackbar('Send', msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xCCEF4444),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: Text('Send Crypto',
            style: GoogleFonts.inter(
                color: Colors.white, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<CryptoWithdrawCubit, CryptoWithdrawState>(
        listener: _onWithdrawState,
        builder: (context, state) {
          // Read the user's holdings from the CryptoCubit (passed in by
          // the route's BlocProvider.value). If the user has no
          // spendable balance, render an empty-state instead of the
          // form — gives them a path forward (Buy / Receive) rather
          // than a dead-end input they can't fill out.
          final cryptoState = context.watch<CryptoCubit>().state;
          final hasSpendable = cryptoState is CryptosLoaded &&
              cryptoState.holdings.any((h) => h.quantity > 0);
          if (!hasSpendable) {
            return _buildEmptyState();
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: ListView(
                children: [
                  _buildAssetTile(),
                  SizedBox(height: 12.h),
                  _buildRecipientToggle(),
                  SizedBox(height: 12.h),
                  if (!_isInternal) _buildNetworkSelector(),
                  if (!_isInternal) SizedBox(height: 12.h),
                  _buildField(
                    _addressController,
                    _isInternal
                        ? 'Recipient Lazervault user id or email'
                        : 'Destination address',
                  ),
                  SizedBox(height: 12.h),
                  _buildField(_amountController, 'Amount',
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*$')),
                      ]),
                  if (!_isInternal) ...[
                    SizedBox(height: 12.h),
                    _buildField(_destinationTagController,
                        'Destination tag (optional)'),
                  ],
                  SizedBox(height: 12.h),
                  _buildField(_noteController, 'Transaction note (optional)'),
                  SizedBox(height: 12.h),
                  _buildField(_narrationController, 'Narration (optional)'),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: state is CryptoWithdrawSubmitting || _isSubmitting
                        ? null
                        : _onSend,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: state is CryptoWithdrawSubmitting || _isSubmitting
                        ? LazerVaultLoader.tiny()
                        : Text('Send',
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onWithdrawState(BuildContext context, CryptoWithdrawState state) {
    switch (state) {
      case CryptoWithdrawProcessing(:final reference):
      case CryptoWithdrawCompleted(:final reference):
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: const Color(0xFF1F1F1F),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (_) => _ReceiptSheet(state: state, reference: reference),
        );
        break;
      case CryptoWithdrawFailed(:final reason):
        Get.snackbar('Send failed', reason,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color(0xCCEF4444),
            colorText: const Color(0xFFFFFFFF),
            duration: const Duration(seconds: 4));
        break;
      default:
        break;
    }
  }

  /// Empty-state render when the user has zero spendable holdings.
  /// Replaces the prior crypto-screen snackbar dead-end with an
  /// actionable screen: explains the situation, then routes the user
  /// to Buy or Receive (the two paths that produce a spendable
  /// balance). Mirrors the empty-state UX the giftcards screens already
  /// use for new users.
  Widget _buildEmptyState() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 72.sp,
              color: Colors.white.withValues(alpha: 0.35),
            ),
            SizedBox(height: 24.h),
            Text(
              'No crypto to send yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'To send crypto, you first need a balance to send from. '
              'Buy crypto with your wallet or receive it from an external address.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.toNamed(AppRoutes.buyCrypto);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(
                'Buy crypto',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp),
              ),
            ),
            SizedBox(height: 12.h),
            OutlinedButton(
              onPressed: () {
                // Receive is reached via the crypto landing's
                // wallets/receive section. Bouncing back to the
                // landing puts the user in the right place to find
                // it without inventing a parallel deep-link route.
                Get.back();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF3B82F6)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(
                'Receive crypto',
                style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetTile() {
    final h = _selected;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r)),
      child: Row(children: [
        Expanded(
          child: Text(
            h == null
                ? 'No asset selected'
                : '${h.cryptoSymbol.toUpperCase()} · Balance ${h.quantity.toStringAsFixed(6)}',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
          ),
        ),
        // Picker not yet wired — preselected via constructor. PR7 polish.
      ]),
    );
  }

  Widget _buildRecipientToggle() {
    return Row(children: [
      Expanded(
        child: ChoiceChip(
          label: const Text('External address'),
          selected: !_isInternal,
          onSelected: (s) => setState(() => _isInternal = !s),
        ),
      ),
      SizedBox(width: 8.w),
      Expanded(
        child: ChoiceChip(
          label: const Text('Lazervault user'),
          selected: _isInternal,
          onSelected: (s) => setState(() => _isInternal = s),
        ),
      ),
    ]);
  }

  Widget _buildNetworkSelector() {
    // PR7 replaces this with a dropdown sourced from `quidax_asset_networks`.
    // For now: free text input (e.g. trc20, erc20, bep20). Empty = Quidax's
    // default network for the asset.
    return _buildField(
      _networkController,
      'Network (e.g. trc20, erc20, bep20)',
    );
  }

  Widget _buildField(TextEditingController c, String label,
      {TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters}) {
    return TextField(
      controller: c,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        hintText: label,
        hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
    );
  }
}

class _ReceiptSheet extends StatelessWidget {
  final CryptoWithdrawState state;
  final String reference;
  const _ReceiptSheet({required this.state, required this.reference});

  @override
  Widget build(BuildContext context) {
    final isDone = state is CryptoWithdrawCompleted;
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.timelapse,
            size: 56.sp,
            color: isDone ? const Color(0xFF10B981) : const Color(0xFFFB923C),
          ),
          SizedBox(height: 12.h),
          Text(
            isDone ? 'Send complete' : 'Send processing',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8.h),
          Text(
            isDone
                ? 'Quidax confirmed your withdrawal.'
                : 'Your send is in flight. You\'ll get a notification when it lands on-chain.',
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          SelectableText(reference,
              style: GoogleFonts.robotoMono(
                  color: Colors.white60, fontSize: 12.sp)),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r))),
              child: Text('Done',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
