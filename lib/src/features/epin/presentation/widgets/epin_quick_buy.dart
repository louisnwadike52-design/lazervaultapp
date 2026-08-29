import 'package:lazervault/core/utils/ng_network_prefixes.dart';
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

import '../cubit/epin_cubit.dart';
import '../cubit/epin_state.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

/// Single-page recharge-PIN (ePIN) purchase — streamlined "one page, very fast"
/// flow. Pick network → pick a denomination → set quantity → phone → inline
/// confirmation → the shared TX-PIN sheet ALSO runs the purchase → PIN-order
/// receipt. No network / denomination / confirm / processing screens. Reuses
/// [EPinCubit] unchanged, so the admin provider-attempt audit is preserved.
class EPinQuickBuy extends StatefulWidget {
  const EPinQuickBuy({super.key});

  @override
  State<EPinQuickBuy> createState() => _EPinQuickBuyState();
}

class _EPinQuickBuyState extends State<EPinQuickBuy> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _currency = 'NGN';

  final _phoneController = TextEditingController();

  List<EPinNetwork> _networks = const [];
  EPinNetwork? _network;
  EPinDenomination? _denomination;
  int _quantity = 1;
  bool _submitting = false;

  /// True once the user has tapped a network themselves.
  ///
  /// Auto-detection then stops touching the selection. Someone printing MTN
  /// pins from their Airtel line is doing that deliberately, and having the
  /// tiles jump back every time they correct a digit would be maddening.
  bool _networkChosenByUser = false;
  StreamSubscription<EPinState>? _sub;

  double get _total => (_denomination?.amount ?? 0) * _quantity;

  @override
  void initState() {
    super.initState();
    _sub = context.read<EPinCubit>().stream.listen((s) {
      if (s is EPinNetworksLoaded && mounted) {
        setState(() => _networks = s.networks);
        // The catalogue can land AFTER the async phone prefill, in which case
        // the first detection ran against an empty list and gave up. Retry now
        // that there is something to match against.
        _autoSelectNetworkFromPhone();
      }
    });
    // The home screen already loads the catalogue and only mounts this widget
    // once state is EPinNetworksLoaded — seed from the CURRENT state instead of
    // re-calling loadNetworks() (which re-emits Loading, tears this widget down
    // via the home's gating BlocBuilder, and remounts → infinite flicker loop).
    final current = context.read<EPinCubit>().state;
    if (current is EPinNetworksLoaded) {
      _networks = current.networks;
    }
    // Re-detect as the number changes, so correcting a digit or pasting a
    // different line moves the selection with it instead of leaving the
    // previous network silently attached to a number it does not belong to.
    _phoneController.addListener(_autoSelectNetworkFromPhone);
    _prefillPhone();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _phoneController.removeListener(_autoSelectNetworkFromPhone);
    _phoneController.dispose();
    super.dispose();
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
        _autoSelectNetworkFromPhone();
      }
    } catch (_) {/* best-effort */}
  }

  /// Pick the network the prefilled number belongs to, and with it the
  /// denominations that network actually sells.
  ///
  /// The catalogue ships denominations ON each network, so selecting one is
  /// what surfaces its amounts — there is no separate fetch to wait for. A
  /// logged-in user printing pins for their own line should not have to tell
  /// us which network they are on when the number already says so.
  ///
  /// Reads the shared NCC prefix table rather than a local copy: airtime once
  /// kept its own and drifted, so 0703/0706/0707 and 0701/0708 silently
  /// stopped resolving. One table, every flow.
  void _autoSelectNetworkFromPhone() {
    if (_networkChosenByUser || _networks.isEmpty) return;
    final ticker = NgNetworkPrefixes.detect(_phoneController.text.trim());
    if (ticker == null) return;
    final match = _networkForTicker(ticker);
    if (match == null || match.code == _network?.code) return;
    setState(() {
      _network = match;
      // The previous denomination belonged to the previous network — clearing
      // it stops a stale amount riding into the order.
      _denomination = null;
      _quantity = 1;
    });
  }

  /// Bridges the detector's backend ticker to this catalogue's network code.
  ///
  /// The two vocabularies genuinely differ: the detector returns "etisalat"
  /// (the backend's ticker) while the ePIN catalogue calls the same network
  /// "9MOBILE". Matching on equality alone would leave 9mobile numbers
  /// undetected while every other network worked — the kind of gap that only
  /// shows up for a fraction of users.
  EPinNetwork? _networkForTicker(String ticker) {
    const aliases = <String, List<String>>{
      'mtn': ['mtn'],
      'glo': ['glo', 'globacom'],
      'airtel': ['airtel'],
      'etisalat': ['9mobile', 'etisalat', '9 mobile'],
    };
    final wanted = aliases[ticker.toLowerCase()] ?? [ticker.toLowerCase()];
    for (final n in _networks) {
      if (!n.isActive) continue;
      final code = n.code.trim().toLowerCase();
      final name = n.name.trim().toLowerCase();
      if (wanted.contains(code) || wanted.contains(name)) return n;
    }
    return null;
  }

  void _selectNetwork(EPinNetwork n) {
    setState(() {
      _networkChosenByUser = true;
      _network = n;
      _denomination = null;
      _quantity = 1;
    });
  }

  bool get _phoneValid =>
      RegExp(r'^0\d{10}$').hasMatch(_phoneController.text.trim());
  bool get _ready =>
      _network != null && _denomination != null && _quantity > 0 && _phoneValid;

  // ── Purchase (runs INSIDE the TX-PIN sheet's processing beat) ──────────────
  Future<void> _pay() async {
    if (!_ready || _submitting) return;
    FocusScope.of(context).unfocus();
    final cubit = context.read<EPinCubit>();
    final n = _network!;
    final denom = _denomination!;
    final phone = _phoneController.text.trim();
    final accountId = serviceLocator<AccountManager>().activeAccountId ?? '';
    final txnId = 'epin_${DateTime.now().millisecondsSinceEpoch}_$phone';

    EPinOrder? result;
    setState(() => _submitting = true);
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'epin_purchase',
        amount: _total,
        currency: _currency,
        title: 'Confirm purchase',
        message:
            'Buy $_quantity × ${n.name} ${denom.label} — $_currency ${_total.toStringAsFixed(0)}',
        showProcessingPhase: true,
        successMessage: 'Purchase request sent',
        onPinValidated: (token) async {
          final completer = Completer<EPinOrder>();
          late final StreamSubscription<EPinState> sub;
          sub = cubit.stream.listen((state) {
            if (completer.isCompleted) return;
            if (state is EPinPurchaseSuccess) {
              completer.complete(state.order);
            } else if (state is EPinPurchaseFailed) {
              completer.completeError(state.message);
            }
          });
          try {
            cubit.purchase(
              network: n.code,
              denomination: denom.amount,
              quantity: _quantity,
              sourceAccountId: accountId,
              phoneNumber: phone,
              transactionId: txnId,
              verificationToken: token,
              idempotencyKey: txnId,
            );
            result = await completer.future.timeout(const Duration(seconds: 90));
          } finally {
            await sub.cancel();
          }
        },
      );

      if (!mounted) return;
      if (ok && result != null) {
        Get.toNamed(AppRoutes.epinReceipt, arguments: {
          'order': result,
        });
      }
    } catch (_) {
      // Failure surfaces on the PIN sheet's failed beat.
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  // ── UI ─────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Network'),
        SizedBox(height: 8.h),
        _networkChips(),
        if (_network != null) ...[
          SizedBox(height: 20.h),
          _label('Denomination'),
          SizedBox(height: 8.h),
          _denominationChips(),
          SizedBox(height: 20.h),
          _label('Quantity'),
          SizedBox(height: 8.h),
          _quantityStepper(),
        ],
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

  Widget _networkChips() {
    if (_networks.isEmpty) {
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Loading networks…',
            style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
      ]);
    }
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: _networks.map((n) {
        final selected = _network?.code == n.code;
        return GestureDetector(
          onTap: () => _selectNetwork(n),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: selected ? _accent : _card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: selected ? _accent : _border),
            ),
            child: Text(n.name,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ),
        );
      }).toList(),
    );
  }

  Widget _denominationChips() {
    final denoms = _network?.denominations ?? const <EPinDenomination>[];
    if (denoms.isEmpty) {
      return Text('No denominations available',
          style: GoogleFonts.inter(color: _muted, fontSize: 12.sp));
    }
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: denoms.map((d) {
        final selected = _denomination?.variation == d.variation;
        return GestureDetector(
          onTap: () => setState(() => _denomination = d),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: selected ? _accent : _card,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: selected ? _accent : _border),
            ),
            child: Text(d.label.isNotEmpty ? d.label : '₦${d.amount.toStringAsFixed(0)}',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ),
        );
      }).toList(),
    );
  }

  Widget _quantityStepper() {
    Widget btn(IconData icon, VoidCallback? onTap) => GestureDetector(
          onTap: onTap,
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: _border),
            ),
            child: Icon(icon,
                color: onTap == null ? _muted : Colors.white, size: 20.sp),
          ),
        );
    return Row(children: [
      btn(Icons.remove, _quantity > 1 ? () => setState(() => _quantity--) : null),
      SizedBox(width: 16.w),
      Text('$_quantity',
          style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700)),
      SizedBox(width: 16.w),
      btn(Icons.add, _quantity < 50 ? () => setState(() => _quantity++) : null),
    ]);
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
        _row('Network', _network!.name),
        SizedBox(height: 10.h),
        _row('Denomination',
            _denomination!.label.isNotEmpty
                ? _denomination!.label
                : '₦${_denomination!.amount.toStringAsFixed(0)}'),
        SizedBox(height: 10.h),
        _row('Quantity', '$_quantity'),
        SizedBox(height: 10.h),
        Divider(color: _border, height: 1),
        SizedBox(height: 10.h),
        _row('You pay', '₦${_total.toStringAsFixed(0)}',
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
                _denomination != null
                    ? 'Buy ₦${_total.toStringAsFixed(0)}'
                    : 'Buy recharge PINs',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
