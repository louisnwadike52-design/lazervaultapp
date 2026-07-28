import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../cubit/betting_cubit.dart';
import '../cubit/betting_state.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

/// Single-page betting-wallet funding — streamlined "one page, very fast" flow
/// (mirror of WaterQuickBuy). Pick platform (Bet9ja/SportyBet/…) → enter the
/// account/user ID → the account AUTO-VERIFIES → amount inline → inline
/// confirmation → the shared TX-PIN sheet ALSO runs the funding → receipt. No
/// account-input / confirm / processing screens. Reuses [BettingCubit]
/// unchanged, so the admin provider-attempt audit + reconciliation are kept.
class BettingQuickBuy extends StatefulWidget {
  const BettingQuickBuy({super.key});

  @override
  State<BettingQuickBuy> createState() => _BettingQuickBuyState();
}

class _BettingQuickBuyState extends State<BettingQuickBuy>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _currency = 'NGN';
  static const _quickAmounts = <int>[500, 1000, 2000, 5000, 10000];

  final _accountController = TextEditingController();
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();

  List<BettingPlatform> _platforms = const [];
  BettingPlatform? _platform;
  BettingAccountVerification? _verification;
  bool _verifying = false;
  String? _verifyError;
  double? _amount;
  bool _submitting = false;
  Timer? _debounce;
  StreamSubscription<BettingState>? _sub;

  @override
  void initState() {
    super.initState();
    _sub = context.read<BettingCubit>().stream.listen(_onState);
    // The home screen already loads the catalogue and only mounts this widget
    // once state is BettingPlatformsLoaded — seed from the CURRENT state instead
    // of re-calling loadPlatforms() (which re-emits Loading, tears this widget
    // down via the home's gating BlocBuilder, and remounts → infinite flicker).
    final current = context.read<BettingCubit>().state;
    if (current is BettingPlatformsLoaded) {
      _platforms = current.platforms;
    }
    _accountController.addListener(_onAccountChanged);
    _prefillPhone();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _sub?.cancel();
    _accountController.dispose();
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onState(BettingState s) {
    if (!mounted) return;
    if (s is BettingPlatformsLoaded) {
      setState(() => _platforms = s.platforms);
    } else if (s is BettingAccountVerifying) {
      setState(() => _verifying = true);
    } else if (s is BettingAccountVerified) {
      setState(() {
        _verification = s.verification.valid ? s.verification : null;
        _verifyError = s.verification.valid ? null : 'Account not found';
        _verifying = false;
      });
    } else if (s is BettingAccountVerifyError) {
      setState(() {
        _verification = null;
        _verifyError = s.message;
        _verifying = false;
      });
    }
  }

  Future<void> _prefillPhone() async {
    try {
      final raw =
          await serviceLocator<FlutterSecureStorage>().read(key: 'stored_phone');
      var d = (raw ?? '').replaceAll(RegExp(r'[^\d]'), '');
      if (d.startsWith('234')) d = d.substring(3);
      if (d.startsWith('0')) d = d.substring(1);
      if (d.isNotEmpty && mounted && _phoneController.text.isEmpty) {
        _phoneController.text = '0$d';
      }
    } catch (_) {/* best-effort */}
  }

  void _selectPlatform(BettingPlatform p) {
    setState(() {
      _platform = p;
      _verification = null;
      _verifyError = null;
    });
    if (_accountController.text.trim().length >= 4) _verify();
  }

  void _onAccountChanged() {
    _debounce?.cancel();
    if (_verification != null || _verifyError != null) {
      setState(() {
        _verification = null;
        _verifyError = null;
      });
    }
    if (_platform == null || _accountController.text.trim().length < 4) return;
    _debounce = Timer(const Duration(milliseconds: 500), _verify);
  }

  void _verify() {
    final p = _platform;
    if (p == null) return;
    context.read<BettingCubit>().verifyAccount(
          platform: p.code,
          accountUserid: _accountController.text.trim(),
        );
  }

  bool get _amountValid {
    final a = _amount ?? 0;
    if (a <= 0) return false;
    final p = _platform;
    if (p != null) {
      if (p.minAmount > 0 && a < p.minAmount) return false;
      if (p.maxAmount > 0 && a > p.maxAmount) return false;
    }
    return true;
  }

  bool get _phoneValid =>
      RegExp(r'^0\d{10}$').hasMatch(_phoneController.text.trim());
  bool get _ready =>
      _platform != null && _verification != null && _amountValid && _phoneValid;

  void _selectAmount(int v) {
    setState(() {
      _amount = v.toDouble();
      _amountController.text = v.toString();
    });
  }

  // ── Purchase (runs INSIDE the TX-PIN sheet's processing beat) ──────────────
  Future<void> _pay() async {
    if (!_ready || _submitting) return;
    FocusScope.of(context).unfocus();
    final cubit = context.read<BettingCubit>();
    final p = _platform!;
    final v = _verification!;
    final amount = _amount!;
    final account = _accountController.text.trim();
    final phone = _phoneController.text.trim();
    final accountId = serviceLocator<AccountManager>().activeAccountId ?? '';
    final txnId = 'betting_${DateTime.now().millisecondsSinceEpoch}_$account';

    BettingFundingResult? result;
    setState(() => _submitting = true);
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'betting_funding',
        amount: amount,
        currency: _currency,
        title: 'Confirm funding',
        message:
            'Fund ${p.name} account $account (${v.accountName}) with $_currency ${amount.toStringAsFixed(0)}',
        showProcessingPhase: true,
        successMessage: 'Funding request sent',
        onPinValidated: (token) async {
          final completer = Completer<BettingFundingResult>();
          late final StreamSubscription<BettingState> sub;
          sub = cubit.stream.listen((state) {
            if (completer.isCompleted) return;
            if (state is BettingFundingSuccess) {
              completer.complete(state.result);
            } else if (state is BettingFundingFailed) {
              completer.completeError(state.message);
            }
          });
          try {
            cubit.fund(
              platform: p.code,
              accountUserid: account,
              accountName: v.accountName,
              amount: amount,
              sourceAccountId: accountId,
              phoneNumber: phone,
              transactionId: txnId,
              verificationToken: token,
              idempotencyKey: txnId,
              saveBeneficiary: false,
            );
            result = await completer.future.timeout(const Duration(seconds: 90));
          } finally {
            await sub.cancel();
          }
        },
      );

      if (!mounted) return;
      if (ok && result != null) {
        Get.toNamed(AppRoutes.bettingReceipt, arguments: {
          'result': result,
        });
      }
    } catch (_) {
      // Failure surfaces on the PIN sheet's failed beat.
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  /// Prefill from a saved betting account (select-don't-type). Self-contained
  /// so the shortcut works inside the streamlined flow: match the saved
  /// platform against the loaded list, drop in the account id, and re-verify so
  /// the account name shows.
  Future<void> _openSaved() async {
    final selected = await Get.toNamed(AppRoutes.bettingBeneficiaries,
        arguments: {'pickMode': true});
    if (selected is! BettingBeneficiary || !mounted) return;
    BettingPlatform? match;
    for (final p in _platforms) {
      if (p.code == selected.platform) {
        match = p;
        break;
      }
    }
    setState(() {
      _platform = match;
      _accountController.text = selected.accountUserid;
      _verification = null;
      _verifyError = match == null
          ? '${selected.platform} isn\'t available right now — pick a platform'
          : null;
    });
    if (match != null) _verify();
  }

  Widget _savedAccountButton() {
    return GestureDetector(
      onTap: _openSaved,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border),
        ),
        child: Row(children: [
          Icon(Icons.bookmark_border, color: _accent, size: 18.sp),
          SizedBox(width: 10.w),
          Text('Use a saved account',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w500)),
          const Spacer(),
          Icon(Icons.chevron_right, color: _muted, size: 18.sp),
        ]),
      ),
    );
  }

  // ── UI ─────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _savedAccountButton(),
        SizedBox(height: 20.h),
        _label('Platform'),
        SizedBox(height: 8.h),
        _platformChips(),
        SizedBox(height: 20.h),
        _label('Account / user ID'),
        SizedBox(height: 8.h),
        _accountField(),
        SizedBox(height: 8.h),
        _accountStatusRow(),
        SizedBox(height: 20.h),
        _label('Amount'),
        SizedBox(height: 8.h),
        _amountChips(),
        SizedBox(height: 10.h),
        _amountField(),
        SizedBox(height: 20.h),
        _label('Phone number (for receipt)'),
        SizedBox(height: 8.h),
        _phoneField(),
        if (_ready) ...[
          SizedBox(height: 20.h),
          _confirmationCard(),
        ],
        SizedBox(height: 16.h),
        _payButton(),
      ],
    );
  }

  Widget _label(String t) => Text(t,
      style: GoogleFonts.inter(
          color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600));

  Widget _platformChips() {
    if (_platforms.isEmpty) {
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Loading platforms…',
            style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
      ]);
    }
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: _platforms.map((p) {
        final selected = _platform?.code == p.code;
        return GestureDetector(
          onTap: () => _selectPlatform(p),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: selected ? _accent : _card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: selected ? _accent : _border),
            ),
            child: Text(p.name,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ),
        );
      }).toList(),
    );
  }

  Widget _accountField() {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border),
      ),
      child: TextField(
        controller: _accountController,
        keyboardType: TextInputType.text,
        inputFormatters: [LengthLimitingTextInputFormatter(24)],
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: _platform == null
              ? 'Select a platform first'
              : 'Enter account / user ID',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
          prefixIcon: Icon(Icons.sports_soccer, color: _muted, size: 20.sp),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        ),
      ),
    );
  }

  Widget _accountStatusRow() {
    if (_verifying) {
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Verifying account…',
            style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
      ]);
    }
    if (_verifyError != null) {
      return Text(_verifyError!,
          style: GoogleFonts.inter(
              color: const Color(0xFFEF4444), fontSize: 12.sp));
    }
    final v = _verification;
    if (v == null) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.35)),
      ),
      child: Row(children: [
        Icon(Icons.verified, color: const Color(0xFF10B981), size: 16.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(v.accountName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }

  Widget _amountChips() {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: _quickAmounts.map((v) {
        final selected = _amount == v.toDouble();
        return GestureDetector(
          onTap: () => _selectAmount(v),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: selected ? _accent : _card,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: selected ? _accent : _border),
            ),
            child: Text('₦$v',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ),
        );
      }).toList(),
    );
  }

  Widget _amountField() {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border),
      ),
      child: TextField(
        controller: _amountController,
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (v) => setState(() => _amount = double.tryParse(v.trim())),
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: 'Enter amount',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
          prefixText: '₦ ',
          prefixStyle: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        ),
      ),
    );
  }

  // Non-editable country dial code shown beside the phone field (NG = +234).
  Widget _dialCodePrefix() => Padding(
        padding: EdgeInsets.only(left: 14.w, right: 10.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🇳🇬', style: TextStyle(fontSize: 15.sp)),
            SizedBox(width: 6.w),
            Text('+234',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(width: 10.w),
            Container(width: 1, height: 20.h, color: _border),
          ],
        ),
      );

  Widget _phoneField() {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border),
      ),
      child: TextField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: '0803 000 0000',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
          prefixIcon: _dialCodePrefix(),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        ),
      ),
    );
  }

  Widget _confirmationCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _border),
      ),
      child: Column(children: [
        _row('Account name', _verification!.accountName),
        SizedBox(height: 10.h),
        _row('Platform', _platform!.name),
        SizedBox(height: 10.h),
        Divider(color: _border, height: 1),
        SizedBox(height: 10.h),
        _row('You pay', '₦${_amount!.toStringAsFixed(0)}',
            valueColor: const Color(0xFF10B981), bold: true),
      ]),
    );
  }

  Widget _row(String label, String value, {Color? valueColor, bool bold = false}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
      Flexible(
        child: Text(value,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
                color: valueColor ?? Colors.white,
                fontSize: bold ? 16.sp : 13.5.sp,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w600)),
      ),
    ]);
  }

  Widget _payButton() {
    final enabled = _ready && !_submitting;
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: enabled ? _pay : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _accent,
          disabledBackgroundColor: _accent.withValues(alpha: 0.35),
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white.withValues(alpha: 0.6),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        ),
        child: _submitting
            ? SizedBox(width: 20.w, height: 20.w, child: LazerVaultLoader.small())
            : Text(
                _amount != null && _amount! > 0
                    ? 'Fund ₦${_amount!.toStringAsFixed(0)}'
                    : 'Fund account',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
