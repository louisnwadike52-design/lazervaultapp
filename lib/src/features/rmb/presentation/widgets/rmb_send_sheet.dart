import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide Address;
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/generated/rmb.pb.dart';
import 'package:lazervault/src/features/rmb/cubit/rmb_cubit.dart';
import 'package:lazervault/src/features/rmb/data/rmb_qr_extractor.dart';
import 'package:lazervault/src/features/rmb/presentation/rmb_ui.dart';
import 'package:lazervault/src/features/rmb/rmb_error.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
part 'rmb_send_sheet_widgets.dart';


/// Opens the short RMB send flow for [rail] as a bottom sheet: one step for
/// the recipient + amount, one step to review, then the transaction PIN.
Future<void> showRmbSendSheet(
  BuildContext context, {
  required RmbRail rail,
  required RmbCubit cubit,
  Transfer? repeatFrom,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: cubit,
      child: RmbSendSheet(rail: rail, repeatFrom: repeatFrom),
    ),
  );
}

class RmbSendSheet extends StatefulWidget {
  final RmbRail rail;

  /// When set, the form is prefilled from a previous transfer ("Repeat
  /// transaction"): recipient + purpose are copied and the amount is prefilled
  /// but stays editable. Rail comes from [rail] (caller passes repeatFrom.rail).
  final Transfer? repeatFrom;

  const RmbSendSheet({super.key, required this.rail, this.repeatFrom});

  @override
  State<RmbSendSheet> createState() => _RmbSendSheetState();
}

class _RmbSendSheetState extends State<RmbSendSheet> with TransactionPinMixin {
  final _uuid = const Uuid();
  late final String _idempotencyKey = _uuid.v4();

  final _ctrls = <String, TextEditingController>{};
  TextEditingController _c(String k) =>
      _ctrls.putIfAbsent(k, () => TextEditingController());

  Timer? _quoteDebounce;
  final _pageController = PageController();
  int _page = 0; // 0 = amount & rate, 1 = recipient & pay

  String _acctIdType = 'MOBILE';
  String _relationship = 'SELF';
  String _idType = 'ID_CARD';
  String _purpose = 'FAMILY_SUPPORT';

  /// Which script the receiver-name helper/hints guide toward: 'pinyin'
  /// (romanised, DEFAULT — easiest to type and Klasha accepts it) or 'cn'
  /// (Chinese Hanzi). Klasha accepts EITHER for every rail, so this only steers
  /// the UX copy — validation stays permissive both ways. ONE toggle (in the
  /// name row) governs EVERY name field across ALL rails: receiver surname/given
  /// (Alipay, WeChat, UnionPay, bank), UnionPay card-holder name, bank account
  /// name.
  String _nameScript = 'pinyin';

  /// Short suffix appended to every receiver-name field label so they all read
  /// consistently with the active 中文/Pinyin toggle.
  String get _nameHint => _nameScript == 'cn' ? '中文' : 'Pinyin';
  Bank? _bank;
  bool _saveBeneficiary = true;

  /// Non-null while the form mirrors a saved beneficiary untouched — the
  /// transfer then references it by id instead of re-sending the details.
  Beneficiary? _saved;
  List<Beneficiary> _savedList = const [];
  bool _savedLoading = true;

  QuoteResponse? _quote;
  bool _quoting = false;
  bool _submitting = false;

  /// True while a scanned/uploaded QR image is being decoded.
  bool _extracting = false;

  /// Wallet rails default to scanning the recipient's code; this flips to true
  /// for manual phone/email entry (and auto-flips after a successful scan so the
  /// filled value is visible).
  bool _manualEntry = false;

  RmbRail get _rail => widget.rail;
  bool get _isWallet => _rail == RmbRail.ALIPAY || _rail == RmbRail.WECHAT;
  RmbCubit get _cubit => context.read<RmbCubit>();

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    try {
      await _cubit.ensureConfig();
      final list = await _cubit.beneficiaries(_rail);
      if (mounted) {
        setState(() {
          _savedList = list;
          _savedLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _savedLoading = false);
    } finally {
      // Prefill runs even if the saved-beneficiary fetch failed — the repeat
      // snapshot doesn't need the saved list (only the id-reselect does, which
      // gracefully falls back to the snapshot fields when the list is empty).
      if (mounted && widget.repeatFrom != null) {
        _applyRepeat(widget.repeatFrom!);
      }
    }
  }

  /// Prefill the form from a previous transfer for "Repeat transaction".
  /// Amount is prefilled but stays editable; recipient + purpose are copied.
  /// If the original saved beneficiary still exists we reselect it (full
  /// recipient detail); otherwise we best-effort split the display name.
  void _applyRepeat(Transfer t) {
    // Amount (editable) — whole numbers show without decimals; guard against a
    // zero/blank amount so the field starts empty (the user must enter one).
    final major = t.destAmountMinor.toInt() / 100.0;
    if (major > 0) {
      _c('amount').text = major == major.roundToDouble()
          ? major.toStringAsFixed(0)
          : major.toStringAsFixed(2);
    }
    // Clamp the copied purpose to what THIS rail accepts (non-UnionPay rails
    // only allow FAMILY_SUPPORT and don't show a selector, so an out-of-set
    // value would be sent unseen / rejected server-side).
    if (t.purpose.isNotEmpty && _purposes.contains(t.purpose)) {
      _purpose = t.purpose;
    } else if (_purposes.isNotEmpty) {
      _purpose = _purposes.first;
    }
    // Don't silently re-save the recipient on a repeat — it either already
    // exists (saved) or was intentionally one-off. The user can still opt in.
    _saveBeneficiary = false;

    Beneficiary? match;
    if (t.beneficiaryId.isNotEmpty) {
      for (final b in _savedList) {
        if (b.id == t.beneficiaryId) {
          match = b;
          break;
        }
      }
    }
    if (match != null) {
      _applySaved(match); // full recipient detail (calls setState)
    } else if (t.receiverFirstName.isNotEmpty ||
        t.receiverLastName.isNotEmpty ||
        t.accountNumber.isNotEmpty) {
      // One-off / deleted beneficiary — prefill the fields from the transfer's
      // beneficiary snapshot (backend enrichment) so the recipient is fully
      // prefilled + editable. Card number is intentionally NOT prefilled from
      // history (PAN security) — the user re-enters it for UnionPay.
      _c('firstName').text = t.receiverFirstName;
      _c('lastName').text = t.receiverLastName;
      _c('accountNumber').text = t.accountNumber;
      _c('cardHolder').text = t.cardHolderName;
      _c('accountName').text = t.accountName;
      _c('mobile').text = t.receiverMobile;
      _c('idNumber').text = t.receiverIdNumber;
      if (t.accountIdType.isNotEmpty) _acctIdType = t.accountIdType;
      if (t.receiverRelationship.isNotEmpty) {
        _relationship = t.receiverRelationship;
      }
      if (t.receiverIdType.isNotEmpty) _idType = t.receiverIdType;
      if (t.bankCode.isNotEmpty) {
        _bank = Bank(code: t.bankCode, name: t.bankName);
      }
    } else if (t.beneficiaryName.trim().isNotEmpty) {
      // Last resort (no snapshot): split the display name (surname first).
      final parts = t.beneficiaryName.trim().split(RegExp(r'\s+'));
      if (parts.length >= 2) {
        _c('lastName').text = parts.first;
        _c('firstName').text = parts.sublist(1).join(' ');
      } else {
        _c('lastName').text = t.beneficiaryName.trim();
      }
    }
    // If the prefilled name is in Hanzi, flip the script toggle so the helper
    // copy matches what's shown (validation accepts either regardless).
    if (_hasCJK('${_c('firstName').text}${_c('lastName').text}')) {
      _nameScript = 'cn';
    }
    setState(() {});
    _onAmountChanged(); // debounced quote for the prefilled amount
  }

  @override
  void dispose() {
    for (final c in _ctrls.values) {
      c.dispose();
    }
    _quoteDebounce?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    FocusScope.of(context).unfocus();
    setState(() => _page = page);
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 260), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    // Keep sheet + keyboard within the screen: shrink by the keyboard inset
    // (never below 40% so the focused field stays visible and scrollable).
    final height = (media.size.height * 0.92 - media.viewInsets.bottom)
        .clamp(media.size.height * 0.4, media.size.height * 0.92);
    return Padding(
      padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
      // Tap anywhere outside a field to dismiss the keyboard (opaque so taps on
      // empty sheet space are caught, but child buttons/fields still win).
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          height: height,
          decoration: BoxDecoration(
            color: RmbUi.bg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            border: Border.all(color: RmbUi.border),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: RmbUi.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              _header(),
              _progress(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [_step1(), _step2()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Header: back (step 2) / rail chip, title + step, X top-right ──────
  Widget _header() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 12.w, 4.h),
      child: Row(
        children: [
          if (_page > 0)
            GestureDetector(
              onTap: () => _goTo(0),
              child: _headerButton(Icons.arrow_back),
            )
          else
            Container(
              height: 38.w,
              width: 38.w,
              decoration: BoxDecoration(
                color: RmbUi.railColor(_rail).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(8.w),
              child: RmbUi.railGlyph(_rail, size: 20.sp),
            ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Send with ${RmbUi.railLabel(_rail)}',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 2.h),
                Text(
                    _page == 0
                        ? 'Step 1 of 2 · Amount & rate'
                        : 'Step 2 of 2 · Recipient & pay',
                    style:
                        TextStyle(color: RmbUi.textSecondary, fontSize: 11.sp)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: _headerButton(Icons.close_rounded),
          ),
        ],
      ),
    );
  }

  Widget _headerButton(IconData icon) => Container(
        height: 34.w,
        width: 34.w,
        decoration: BoxDecoration(
          color: RmbUi.card,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: RmbUi.border),
        ),
        child: Icon(icon, color: Colors.white, size: 18.sp),
      );

  Widget _progress() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: List.generate(2, (i) {
            final active = i <= _page;
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                height: 4.h,
                decoration: BoxDecoration(
                  color: active ? RmbUi.railColor(_rail) : RmbUi.border,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            );
          }),
        ),
      );

  // ── Step 1: amount → rate → rate tiers → Continue ─────────────────────
  Widget _step1() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Amount to send'),
          _amountCard(),
          _reveal(_amountValid, _rateSection),
          _rateTiersCard(),
          SizedBox(height: 20.h),
          _primaryButton(
            _quoting ? 'Getting rate…' : 'Continue',
            (_quoting || !_amountValid || _quote == null)
                ? null
                : () => _goTo(1),
          ),
        ],
      ),
    );
  }

  // ── Step 2: recipient → name → pay ────────────────────────────────────
  Widget _step2() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _accountSection(),
          _reveal(_accountStarted && _saved == null, _nameSection),
          _reveal(_readyToPay, _finishSection),
        ],
      ),
    );
  }

  /// Standard reveal wrapper so sections unfold in order without layout jank.
  /// The [builder] runs only when shown, so a hidden section that reads
  /// `_quote!` (e.g. the pay button) never builds before its data exists.
  Widget _reveal(bool show, Widget Function() builder) => AnimatedSize(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        alignment: Alignment.topCenter,
        child: show ? builder() : const SizedBox(width: double.infinity),
      );

  bool get _amountValid => (double.tryParse(_c('amount').text.trim()) ?? 0) > 0;

  /// The current rail's status from provider config (min/max limits, enabled).
  RailStatus? get _railStatus {
    final rails = _cubit.config?.rails;
    if (rails == null) return null;
    for (final r in rails) {
      if (r.rail == _rail) return r;
    }
    return null;
  }

  /// Inline min/max validation from config (fen), so the user learns the limit
  /// before a doomed quote round-trip. Null when the amount is within range.
  String? get _amountLimitError {
    final major = double.tryParse(_c('amount').text.trim());
    if (major == null || major <= 0) return null;
    final rs = _railStatus;
    if (rs == null) return null;
    final minor = (major * 100).round();
    final min = rs.minAmountMinor.toInt();
    final max = rs.maxAmountMinor.toInt();
    if (min > 0 && minor < min) {
      return 'Minimum is ¥${(min / 100).toStringAsFixed(0)} for this method';
    }
    if (max > 0 && minor > max) {
      return 'Maximum is ¥${(max / 100).toStringAsFixed(0)} for this method';
    }
    return null;
  }

  bool get _walletAccountFilled => _c('accountNumber').text.trim().isNotEmpty;

  /// The recipient's account is started, so the name section can appear.
  bool get _accountStarted {
    if (_isWallet) return _walletAccountFilled;
    if (_rail == RmbRail.UNIONPAY) {
      return _c('cardNumber').text.trim().isNotEmpty;
    }
    return _c('accountName').text.trim().isNotEmpty ||
        _c('accountNumber').text.trim().isNotEmpty;
  }

  bool get _readyToPay =>
      _amountValid && !_quoting && _quote != null && _recipientReady;

  // 2 — Rate section (live quote breakdown + funding source) ─────────────
  Widget _rateSection() {
    // A non-NGN active account can't fund an RMB payout, so no quote is fetched.
    // Explain that inline instead of showing a perpetual "getting rate" spinner.
    // Same treatment for an out-of-range amount (min/max from config).
    final guard = _sourceCurrencyGuard() ?? _amountLimitError;
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: guard != null
          ? Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: RmbUi.card,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: RmbUi.error.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: RmbUi.error, size: 18.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(guard,
                        style: TextStyle(
                            color: RmbUi.textSecondary, fontSize: 12.5.sp)),
                  ),
                ],
              ),
            )
          : _quoting || _quote == null
          ? Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: RmbUi.card,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: RmbUi.border),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 16.w,
                    width: 16.w,
                    child: const CircularProgressIndicator(
                        color: RmbUi.accent, strokeWidth: 2),
                  ),
                  SizedBox(width: 12.w),
                  Text('Getting today’s rate…',
                      style: TextStyle(
                          color: RmbUi.textSecondary, fontSize: 13.sp)),
                ],
              ),
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: RmbUi.card,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: RmbUi.border),
                  ),
                  // No separate fee lines — the rate is all-in, so a payout
                  // reads as fee-free. Bigger sends get a better rate (tiers).
                  // No fee lines — the rate is all-in.
                  child: Column(
                    children: [
                      _row(
                          'Rate', '₦${_quote!.fxRate.toStringAsFixed(2)} / ¥1'),
                      _row('Recipient gets',
                          RmbUi.cny(_quote!.destAmountMinor.toInt())),
                      // A transaction fee shows ONLY when it's not folded into
                      // the rate (admin "separate" mode → ourFeeMinor > 0).
                      if (_quote!.ourFeeMinor.toInt() > 0)
                        _row('Transaction fee',
                            RmbUi.ngn(_quote!.ourFeeMinor.toInt())),
                      Divider(color: RmbUi.border, height: 20.h),
                      _row('You pay', RmbUi.ngn(_quote!.totalMinor.toInt()),
                          bold: true),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // Rate tiers — shown inline on step 1 (no CTA). Bands, spreads and rates all
  // come from the backend config (system_settings), nothing hardcoded here.
  Widget _rateTiersCard() {
    final tiers = _cubit.config?.rateTiers ?? const [];
    // Need at least the rates computed (ngnPerCny > 0) to draw the chart.
    final usable = tiers.where((t) => t.ngnPerCny > 0).toList();
    if (usable.length < 2) return const SizedBox.shrink();
    final rates = usable.map((t) => t.ngnPerCny).toList();
    final best = rates.reduce((a, b) => a < b ? a : b);
    final worst = rates.reduce((a, b) => a > b ? a : b);
    final span = (worst - best).abs();
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: RmbUi.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: RmbUi.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rate tiers',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 2.h),
            Text('The more you send, the better the rate.',
                style: TextStyle(color: RmbUi.label, fontSize: 11.sp)),
            SizedBox(height: 14.h),
            ...List.generate(usable.length, (i) {
              final rate = rates[i];
              final isBest = rate == best;
              final frac =
                  span == 0 ? 1.0 : 0.45 + 0.55 * ((worst - rate) / span);
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(_tierLabel(usable, i),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600)),
                        if (isBest) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: RmbUi.success.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text('Best',
                                style: TextStyle(
                                    color: RmbUi.success, fontSize: 9.sp)),
                          ),
                        ],
                        const Spacer(),
                        Text('₦${rate.toStringAsFixed(2)} / ¥1',
                            style: TextStyle(
                                color: isBest ? RmbUi.success : Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.r),
                      child: LinearProgressIndicator(
                        value: frac.clamp(0.0, 1.0),
                        minHeight: 5.h,
                        backgroundColor: RmbUi.bg,
                        valueColor: AlwaysStoppedAnimation(
                            isBest ? RmbUi.success : RmbUi.railColor(_rail)),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Band label derived from the backend thresholds (no hardcoded ranges).
  String _tierLabel(List<RateTier> tiers, int i) {
    final lower = tiers[i].minCnyMinor.toInt();
    if (i == tiers.length - 1) {
      return lower <= 0 ? 'Any amount' : '¥${_yuan(lower)} and above';
    }
    final upper = tiers[i + 1].minCnyMinor.toInt();
    if (i == 0 && lower <= 0) return 'Under ¥${_yuan(upper)}';
    return '¥${_yuan(lower)} – ¥${_yuan(upper)}';
  }

  // Whole-yuan with thousands separators (thresholds are whole ¥).
  String _yuan(int fen) {
    final s = (fen ~/ 100).toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  // 3 — Account section (saved chips + scan/manual or rail fields) ───────
  Widget _accountSection() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Who are you paying?'),
          if (_savedLoading)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: SizedBox(
                height: 18.w,
                width: 18.w,
                child: const CircularProgressIndicator(
                    color: RmbUi.accent, strokeWidth: 2),
              ),
            )
          else if (_savedList.isNotEmpty && _saved == null) ...[
            SizedBox(
              height: 76.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _savedList.length,
                separatorBuilder: (_, __) => SizedBox(width: 10.w),
                itemBuilder: (_, i) => _savedChip(_savedList[i]),
              ),
            ),
            SizedBox(height: 14.h),
          ],
          if (_saved != null)
            _selectedRecipientCard()
          else if (_isWallet) ...[
            _walletModeToggle(),
            SizedBox(height: 12.h),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              alignment: Alignment.topCenter,
              child: _manualEntry
                  ? Column(
                      key: const ValueKey('manual'),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _walletAccountFields(),
                    )
                  : SizedBox(
                      key: const ValueKey('scan'),
                      width: double.infinity,
                      child: _scanEntryCard(),
                    ),
            ),
          ] else if (_rail == RmbRail.UNIONPAY) ...[
            ..._unionPayFields(),
          ] else ...[
            ..._bankFields(),
          ],
        ],
      ),
    );
  }

  // 4 — Name section (name + rail-specific identity/relationship/purpose) ─
  Widget _nameSection() {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameRow(),
          if (_isWallet) ..._walletExtraFields(),
          if (_rail == RmbRail.UNIONPAY) ...[
            _label('Purpose of payment'),
            _purposeSelector(),
          ],
        ],
      ),
    );
  }

  // 5 — Finish section (save toggle + Pay) ──────────────────────────────
  Widget _finishSection() {
    return Padding(
      padding: EdgeInsets.only(top: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_saved == null)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Save this recipient for next time',
                        style: TextStyle(
                            color: RmbUi.textSecondary, fontSize: 13.sp)),
                  ),
                  Switch(
                    value: _saveBeneficiary,
                    activeThumbColor: RmbUi.accent,
                    onChanged: (v) => setState(() => _saveBeneficiary = v),
                  ),
                ],
              ),
            ),
          _primaryButton(
            _submitting
                ? 'Processing…'
                : 'Pay ${RmbUi.ngn(_quote!.totalMinor.toInt())}',
            _submitting ? null : _confirm,
          ),
        ],
      ),
    );
  }

  /// Segmented switch between scanning a code and typing the account. Sits at
  /// the top of the wallet flow so only one input surface shows at a time.
  Widget _walletModeToggle() => _segmented(
        options: const ['scan', 'manual'],
        labels: const ['Scan or upload', 'Enter manually'],
        value: _manualEntry ? 'manual' : 'scan',
        onChanged: (v) => setState(() => _manualEntry = v == 'manual'),
      );

  Widget _nameRow() {
    final cn = _nameScript == 'cn';
    // Surname (姓) on the left, given name (名) on the right — the order Chinese
    // names are written and read. Keys stay firstName=given / lastName=surname
    // so the Klasha payload (receiverFirstName/receiverLastName) is unchanged.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Receiver name'),
        _nameScriptSwitch(),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
                child: _field(
                    'lastName', cn ? 'Surname · 姓' : 'Surname (e.g. Zhang)',
                    onEdited: true, validator: _nameError)),
            SizedBox(width: 10.w),
            Expanded(
                child: _field('firstName',
                    cn ? 'Given name · 名' : 'Given name (e.g. Wei)',
                    onEdited: true, validator: _nameError)),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.h, top: 2.h),
          child: Text(
              cn
                  ? 'Enter the name in Chinese characters (中文), e.g. 张 伟 — or switch to Pinyin. Type it exactly as it appears on the supplier’s invoice or wallet.'
                  : 'Enter the name in Pinyin/English, e.g. Zhang Wei — exactly as it appears on the supplier’s invoice or wallet. Chinese characters also work.',
              style: TextStyle(color: RmbUi.label, fontSize: 11.sp)),
        ),
      ],
    );
  }

  // Explicit "Name language" toggle — Pinyin ⇄ 中文. Rendered as its own
  // labeled, full-width control (icon + caption + a swap arrow) so users clearly
  // see the receiver name can be entered either way; both are accepted by the
  // payout provider.
  Widget _nameScriptSwitch() {
    Widget chip(String option, String label) {
      final sel = _nameScript == option;
      return Expanded(
        child: GestureDetector(
          onTap: () => setState(() => _nameScript = option),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 9.h),
            decoration: BoxDecoration(
              color: sel ? RmbUi.railColor(_rail) : Colors.transparent,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: sel ? Colors.white : RmbUi.textSecondary,
                    fontSize: 13.sp,
                    fontWeight: sel ? FontWeight.w700 : FontWeight.w500)),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: 4.h),
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
      decoration: BoxDecoration(
        color: RmbUi.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: RmbUi.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.translate, size: 15.sp, color: RmbUi.railColor(_rail)),
              SizedBox(width: 6.w),
              Text('Name language',
                  style: TextStyle(
                      color: RmbUi.textSecondary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: RmbUi.bg,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: RmbUi.border),
            ),
            child: Row(
              children: [
                chip('pinyin', 'Pinyin'),
                GestureDetector(
                  onTap: () => setState(() =>
                      _nameScript = _nameScript == 'cn' ? 'pinyin' : 'cn'),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Icon(Icons.swap_horiz,
                        size: 18.sp, color: RmbUi.textSecondary),
                  ),
                ),
                chip('cn', '中文'),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Text('Tap to switch · both are accepted',
              style: TextStyle(color: RmbUi.label, fontSize: 11.sp)),
        ],
      ),
    );
  }

  // Auto-quote as the amount changes (debounced) so the rate section shows
  // without a "get rate" tap.
  void _onAmountChanged() {
    _quoteDebounce?.cancel();
    setState(() => _quote = null);
    final major = double.tryParse(_c('amount').text.trim());
    if (major == null || major <= 0) return;
    if (_amountLimitError != null) return; // out of range — don't quote
    _quoteDebounce = Timer(const Duration(milliseconds: 650), _fetchQuote);
  }

  int _quoteSeq = 0;

  Future<void> _fetchQuote() async {
    if (_sourceCurrencyGuard() != null) return; // surfaced at pay time
    final major = double.tryParse(_c('amount').text.trim());
    if (major == null || major <= 0) return;
    // Sequence guard: a slow earlier response must not overwrite a newer quote.
    final seq = ++_quoteSeq;
    setState(() => _quoting = true);
    try {
      final q = await _cubit.quote(_rail, (major * 100).round());
      if (mounted && seq == _quoteSeq) setState(() => _quote = q);
    } catch (e) {
      if (mounted && seq == _quoteSeq) {
        setState(() => _quote = null);
        _snack(rmbFriendlyError(e));
      }
    } finally {
      if (mounted && seq == _quoteSeq) setState(() => _quoting = false);
    }
  }

  /// Compact card shown once a saved recipient is chosen — keeps the flow short
  /// and offers a one-tap way back to full entry.
  Widget _selectedRecipientCard() {
    final b = _saved!;
    final name = b.displayName.isNotEmpty
        ? b.displayName
        : '${b.receiverLastName} ${b.receiverFirstName}'.trim();
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: RmbUi.card,
        borderRadius: BorderRadius.circular(14.r),
        border:
            Border.all(color: RmbUi.railColor(_rail).withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            height: 42.w,
            width: 42.w,
            decoration: BoxDecoration(
              color: RmbUi.railColor(_rail).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            padding: EdgeInsets.all(9.w),
            child: RmbUi.railGlyph(_rail, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name.isEmpty ? 'Recipient' : name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 3.h),
                Text(_savedSubtitle(b),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(color: RmbUi.textSecondary, fontSize: 12.sp)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _saved = null),
            child: Text('Change',
                style: TextStyle(
                    color: RmbUi.railColor(_rail),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  /// Scan / upload the recipient's Alipay/WeChat code, decoded on-device to a
  /// phone number or email that prefills the form.
  Widget _scanEntryCard() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: RmbUi.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: RmbUi.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Point at the recipient’s ${RmbUi.railLabel(_rail)} code, or upload a screenshot.',
              style: TextStyle(color: RmbUi.label, fontSize: 11.sp)),
          SizedBox(height: 12.h),
          if (_extracting)
            Row(
              children: [
                SizedBox(
                  height: 16.w,
                  width: 16.w,
                  child: const CircularProgressIndicator(
                      color: RmbUi.accent, strokeWidth: 2),
                ),
                SizedBox(width: 10.w),
                Text('Reading the code…',
                    style:
                        TextStyle(color: RmbUi.textSecondary, fontSize: 12.sp)),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _scanActionButton(
                      Icons.qr_code_scanner_rounded, 'Scan', _scanLive),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _scanActionButton(Icons.photo_library_rounded,
                      'Upload', _pickAndDecodeFromGallery),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _scanActionButton(IconData icon, String label, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: RmbUi.bg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: RmbUi.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: RmbUi.railColor(_rail), size: 18.sp),
              SizedBox(width: 8.w),
              Text(label,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      );

  bool get _namesFilled =>
      _c('firstName').text.trim().isNotEmpty &&
      _c('lastName').text.trim().isNotEmpty;

  /// The recipient has enough valid detail for us to quote + pay. This is the
  /// "validate before continuing" gate — the Pay button stays disabled until
  /// every applicable field passes its China-specific validator.
  bool get _recipientReady {
    if (!_namesFilled) return false;
    if (!_nameValid(_c('firstName').text.trim()) ||
        !_nameValid(_c('lastName').text.trim())) {
      return false;
    }
    if (_isWallet) {
      return _walletAccountError() == null &&
          _idNumberError(_c('idNumber').text, 'PASSPORT', required: false) ==
              null;
    }
    if (_rail == RmbRail.UNIONPAY) {
      return _cardError(_c('cardNumber').text) == null &&
          _nameValid(_c('cardHolder').text.trim()) &&
          _bank != null;
    }
    return _nameValid(_c('accountName').text.trim()) &&
        _bankAcctError(_c('accountNumber').text) == null &&
        _bank != null &&
        _cnMobileError(_c('mobile').text, required: true) == null &&
        _idNumberError(_c('idNumber').text, _idType, required: true) == null;
  }

  List<Widget> _walletAccountFields() {
    final isEmail = _rail == RmbRail.ALIPAY && _acctIdType == 'EMAIL';
    return [
      if (_rail == RmbRail.ALIPAY) ...[
        _label('Alipay account type'),
        _segmented(
          options: const ['MOBILE', 'EMAIL'],
          labels: const ['Phone number', 'Email'],
          value: _acctIdType,
          onChanged: (v) => setState(() {
            _acctIdType = v;
            _saved = null;
          }),
        ),
        SizedBox(height: 10.h),
      ],
      if (isEmail)
        _field(
          'accountNumber',
          'Alipay email',
          onEdited: true,
          keyboardType: TextInputType.emailAddress,
          validator: _emailError,
        )
      else
        _phoneField(
          'accountNumber',
          label: _rail == RmbRail.WECHAT
              ? 'WeChat-linked phone number'
              : 'Alipay phone number',
        ),
    ];
  }

  List<Widget> _walletExtraFields() => [
        _field('idNumber', 'ID number — passport / national ID (optional)',
            onEdited: true,
            validator: (v) => _idNumberError(v, 'PASSPORT', required: false)),
        _dropdown('Relationship to you', _relationship, _relOptions,
            (v) => setState(() => _relationship = v)),
      ];

  List<Widget> _unionPayFields() => [
        _field('cardNumber', 'UnionPay card number',
            onEdited: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
            ],
            validator: _cardError),
        _field('cardHolder', 'Card holder name · $_nameHint',
            onEdited: true, validator: _nameError),
        _bankPickerField(),
      ];

  List<Widget> _bankFields() => [
        _field('accountName', 'Account name · $_nameHint',
            onEdited: true, validator: _nameError),
        _field('accountNumber', 'Account number',
            onEdited: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(30),
            ],
            validator: _bankAcctError),
        _bankPickerField(),
        _phoneField('mobile', label: 'Receiver mobile'),
        _dropdown(
            'ID type — passport / national ID',
            _idType,
            const ['ID_CARD', 'PASSPORT', 'HONGKONG_MACAO_TAIWAN_PERMIT'],
            (v) => setState(() => _idType = v)),
        _field('idNumber', 'ID number (identity document)',
            onEdited: true,
            validator: (v) => _idNumberError(v, _idType, required: true)),
        _dropdown('Relationship to you', _relationship, _relOptions,
            (v) => setState(() => _relationship = v)),
      ];

  List<String> get _relOptions => _rail == RmbRail.BANK
      ? const [
          'SELF',
          'SPOUSE',
          'PARENTS',
          'SONS_AND_DAUGHTERS',
          'BROTHERS_AND_SISTERS'
        ]
      : const ['SELF', 'SPOUSE', 'PARENTS', 'SONS_AND_DAUGHTERS'];

  Widget _savedChip(Beneficiary b) {
    final selected = _saved?.id == b.id && b.id.isNotEmpty;
    final name = b.displayName.isNotEmpty
        ? b.displayName
        : '${b.receiverLastName} ${b.receiverFirstName}'.trim();
    return GestureDetector(
      onTap: () => _applySaved(b),
      child: Container(
        width: 120.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: RmbUi.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
              color: selected ? RmbUi.railColor(_rail) : RmbUi.border,
              width: selected ? 1.6 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                RmbUi.railGlyph(b.rail, size: 14.sp),
                const Spacer(),
                if (selected)
                  Icon(Icons.check_circle,
                      color: RmbUi.railColor(_rail), size: 15.sp),
              ],
            ),
            SizedBox(height: 6.h),
            Text(name.isEmpty ? 'Recipient' : name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 2.h),
            Text(_savedSubtitle(b),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: RmbUi.textSecondary, fontSize: 10.sp)),
          ],
        ),
      ),
    );
  }

  String _savedSubtitle(Beneficiary b) {
    if (b.accountNumber.isNotEmpty) return b.accountNumber;
    if (b.cardNumber.isNotEmpty && b.cardNumber.length > 4) {
      return '•••• ${b.cardNumber.substring(b.cardNumber.length - 4)}';
    }
    return RmbUi.railLabel(b.rail);
  }

  void _applySaved(Beneficiary b) {
    setState(() {
      _saved = b;
      _c('firstName').text = b.receiverFirstName;
      _c('lastName').text = b.receiverLastName;
      _c('idNumber').text = b.receiverIdNumber;
      _c('accountNumber').text = b.accountNumber;
      _c('cardNumber').text = b.cardNumber;
      _c('cardHolder').text = b.cardHolderName;
      _c('accountName').text = b.accountName;
      _c('mobile').text = b.receiverMobile;
      if (b.accountIdType.isNotEmpty) _acctIdType = b.accountIdType;
      if (b.receiverRelationship.isNotEmpty) {
        _relationship = b.receiverRelationship;
      }
      if (b.receiverIdType.isNotEmpty) _idType = b.receiverIdType;
      if (b.bankCode.isNotEmpty) {
        _bank = Bank(code: b.bankCode, name: b.bankName);
      }
    });
  }

  // ── Scan / upload a QR code → decode client-side → prefill ─────────────
  // The recipient's Alipay/WeChat code is a plain QR, so we decode it on-device
  // with mobile_scanner (no server round-trip) and read a phone/email out of it.

  /// Live camera scan — opens a scanner sheet and decodes the first QR it sees.
  Future<void> _scanLive() async {
    FocusScope.of(context).unfocus();
    final raw = await _RmbQrScanSheet.show(context, rail: _rail);
    if (raw == null || !mounted) return;
    _applyDecoded(raw);
  }

  /// Upload a still image (screenshot / saved code) and decode any QR in it.
  Future<void> _pickAndDecodeFromGallery() async {
    FocusScope.of(context).unfocus();
    final XFile? picked;
    try {
      picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    } catch (_) {
      _snack('Couldn’t open your photos. Check the permission and try again.');
      return;
    }
    if (picked == null || !mounted) return;

    setState(() => _extracting = true);
    final controller = MobileScannerController();
    try {
      final capture = await controller.analyzeImage(picked.path);
      final raw = (capture == null || capture.barcodes.isEmpty)
          ? null
          : capture.barcodes.first.rawValue;
      if (!mounted) return;
      if (raw == null || raw.isEmpty) {
        _snack('No QR code found in that image.');
      } else {
        _applyDecoded(raw);
      }
    } catch (_) {
      _snack('We couldn’t read that image. Please try again.');
    } finally {
      await controller.dispose();
      if (mounted) setState(() => _extracting = false);
    }
  }

  /// Turns a decoded QR string into prefilled fields, or explains why it can't.
  void _applyDecoded(String raw) {
    final result = extractRmbWalletId(raw);
    switch (result) {
      case RmbQrPhone(:final phone):
        setState(() {
          _acctIdType = 'MOBILE';
          // Normalize so a scanned "+86…"/"86…" number matches manual entry and
          // renders correctly under the +86 affix (bare 11-digit form).
          _c('accountNumber').text = _normalizeCnMobile(phone);
          _saved = null;
          _manualEntry = true; // reveal the filled field
        });
        _snack('Filled from the code — check the details before you continue.');
      case RmbQrEmail(:final email):
        if (_rail == RmbRail.WECHAT) {
          _snack(
              'That code holds an email — WeChat Pay needs the linked phone number.');
        } else {
          setState(() {
            _acctIdType = 'EMAIL';
            _c('accountNumber').text = email;
            _saved = null;
            _manualEntry = true; // reveal the filled field
          });
          _snack(
              'Filled from the code — check the details before you continue.');
        }
      case RmbQrReceiveCode():
        _snack(
            'That is a personal ${RmbUi.railLabel(_rail)} code — it doesn’t carry the login. Ask the recipient for the phone number or email they sign in with.');
      case RmbQrUnrecognized():
        _snack('No phone number or email found in that code.');
    }
  }

  // ── Amount card ──────────────────────────────────────────────────────
  Widget _amountCard() {
    final rate = _cubit.config?.indicativeFxRate ?? 0;
    final major = double.tryParse(_c('amount').text.trim());
    final approxNgn =
        (rate > 0 && major != null && major > 0) ? major * rate : null;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: RmbUi.heroGradient,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('They receive',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7), fontSize: 11.sp)),
          Row(
            children: [
              Text('¥',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(width: 6.w),
              Expanded(
                child: TextField(
                  controller: _c('amount'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                  ],
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 26.sp),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (_) => _onAmountChanged(),
                ),
              ),
            ],
          ),
          if (approxNgn != null)
            Text('≈ ₦${approxNgn.toStringAsFixed(2)} · all-in rate below',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12.sp)),
        ],
      ),
    );
  }

  List<String> get _purposes => _rail == RmbRail.UNIONPAY
      ? const [
          'FAMILY_SUPPORT',
          'SALARY',
          'TRAVEL',
          'INSURANCE',
          'SERVICE_CHARGES',
          'PATENT_ROYALTY',
          'OTHER',
        ]
      : const ['FAMILY_SUPPORT'];

  Widget _purposeSelector() {
    final purposes = _purposes;
    if (!purposes.contains(_purpose)) _purpose = purposes.first;
    if (purposes.length == 1) {
      return Chip(
        label: Text(purposes.first.replaceAll('_', ' ').toLowerCase(),
            style: TextStyle(color: Colors.white, fontSize: 12.sp)),
        backgroundColor: RmbUi.accent,
      );
    }
    return Wrap(
      spacing: 8.w,
      children: purposes.map((p) {
        final sel = _purpose == p;
        return ChoiceChip(
          label: Text(p.replaceAll('_', ' ').toLowerCase(),
              style: TextStyle(
                  color: sel ? Colors.white : RmbUi.textSecondary,
                  fontSize: 12.sp)),
          selected: sel,
          selectedColor: RmbUi.accent,
          backgroundColor: RmbUi.card,
          onSelected: (_) => setState(() => _purpose = p),
        );
      }).toList(),
    );
  }

  // ── Confirm → compliance gate → PIN → initiate ───────────────────────
  Future<void> _confirm() async {
    // Maintenance guard — the landing blocks sends during maintenance, but a
    // Repeat opens this sheet directly (bypassing that), so re-check here.
    final cfg = _cubit.config;
    if (cfg != null && cfg.maintenance) {
      _snack(cfg.maintenanceMessage.isNotEmpty
          ? cfg.maintenanceMessage
          : 'RMB transfers are temporarily under maintenance. Please try again later.');
      return;
    }
    final guard = _sourceCurrencyGuard();
    if (guard != null) {
      _snack(guard);
      return;
    }
    final err = _validateInput();
    if (err != null) {
      _snack(err);
      return;
    }
    var q = _quote;
    if (q == null) return;

    // Quotes go stale (~2 min). Refresh silently, show the new numbers, and
    // let the user tap pay again rather than charging on changed figures.
    if (q.hasExpiresAt() && q.expiresAt.toDateTime().isBefore(DateTime.now())) {
      setState(() => _submitting = true);
      try {
        final fresh = await _cubit.quote(_rail, q.destAmountMinor.toInt());
        if (!mounted) return;
        final changed = fresh.totalMinor != q.totalMinor;
        setState(() => _quote = fresh);
        if (changed) {
          _snack(
              'The rate was refreshed — check the new total and tap pay again.');
          return;
        }
        q = fresh;
      } catch (e) {
        _snack(rmbFriendlyError(e));
        return;
      } finally {
        if (mounted) setState(() => _submitting = false);
      }
    }

    final profile = await _cubit.complianceProfile();
    if (!profile.complete) {
      final captured = await _openComplianceSheet(profile);
      if (captured != true) return;
    }

    final accountId = GetIt.I<AccountManager>().activeAccountId;
    if (accountId == null || accountId.isEmpty) {
      _snack('No active account selected');
      return;
    }
    if (!mounted) return;

    final cnyMajor = q.destAmountMinor.toInt() / 100.0;
    InitiateTransferResponse? resp;
    try {
      await validateTransactionPin(
        context: context,
        transactionId: _idempotencyKey,
        transactionType: 'rmb_transfer',
        amount: q.totalMinor.toInt() / 100.0,
        currency: 'NGN',
        title: 'Confirm transfer',
        message:
            'Enter your transaction PIN to send ¥${cnyMajor.toStringAsFixed(2)}',
        showProcessingPhase: true,
        onPinValidated: (token) async {
          resp = await _submit(token, accountId, q!);
        },
      );
    } catch (e) {
      if (mounted) _snack(rmbFriendlyError(e));
      return;
    }
    if (resp != null && mounted) {
      Navigator.of(context).pop();
      final args = {
        'transferId': resp!.transfer.id,
        'fromHistory': false,
      };
      // A "Repeat" is launched from a receipt — REPLACE that receipt so back
      // navigation doesn't walk through a stack of stale receipts. A normal
      // send (from the landing) pushes so back returns to the landing.
      if (widget.repeatFrom != null) {
        Get.offNamed(AppRoutes.rmbReceipt, arguments: args);
      } else {
        Get.toNamed(AppRoutes.rmbReceipt, arguments: args);
      }
    }
  }

  Future<InitiateTransferResponse> _submit(
      String token, String accountId, QuoteResponse q) async {
    if (mounted) setState(() => _submitting = true);
    try {
      final req = InitiateTransferRequest(
        quoteId: q.quoteId,
        purpose: _purpose,
        verificationToken: token,
        idempotencyKey: _idempotencyKey,
        sourceAccountId: accountId,
      );
      final saved = _saved;
      if (saved != null && saved.id.isNotEmpty) {
        req.beneficiaryId = saved.id;
      } else {
        req.beneficiary = _buildBeneficiary();
        req.saveBeneficiary = _saveBeneficiary;
      }
      return await _cubit.initiate(req);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Beneficiary _buildBeneficiary() => Beneficiary(
        rail: _rail,
        // Chinese convention: surname (last) precedes given (first).
        displayName: '${_c('lastName').text} ${_c('firstName').text}'.trim(),
        receiverFirstName: _c('firstName').text.trim(),
        receiverLastName: _c('lastName').text.trim(),
        receiverIdNumber: _c('idNumber').text.trim(),
        accountIdType:
            _isWallet ? (_rail == RmbRail.WECHAT ? 'MOBILE' : _acctIdType) : '',
        accountNumber: _c('accountNumber').text.trim(),
        receiverRelationship:
            (_isWallet || _rail == RmbRail.BANK) ? _relationship : '',
        receiverIdType: _rail == RmbRail.BANK ? _idType : '',
        cardNumber: _c('cardNumber').text.trim(),
        cardHolderName: _c('cardHolder').text.trim(),
        accountName: _c('accountName').text.trim(),
        bankName: _bank?.name ?? '',
        bankCode: _bank?.code ?? '',
        receiverMobile: _c('mobile').text.trim(),
      );

  // ── Validation (mirrors backend + Klasha + China rules) ──────────────
  static final RegExp _cjk = RegExp(r'[㐀-䶿一-鿿豈-﫿]');
  bool _hasCJK(String s) => _cjk.hasMatch(s);

  // A beneficiary name may be Chinese (张伟) OR Pinyin/romanised ("Zhang Wei") —
  // Klasha accepts either and does NOT translate Pinyin to Hanzi. Mirrors the
  // rmb-service validReceiverName gate. Latin form must start with a letter and
  // contain only letters/space/hyphen/apostrophe/period; digits/symbols fail.
  static final RegExp _latinName = RegExp(r"^\p{L}[\p{L} .'-]*$", unicode: true);
  bool _nameValid(String s) {
    final t = s.trim();
    if (t.isEmpty) return false;
    if (_hasCJK(t)) return true;
    return _latinName.hasMatch(t);
  }

  String? _nameError(String v) {
    final t = v.trim();
    if (t.isEmpty) return 'Enter the name (Chinese or Pinyin)';
    if (!_nameValid(t)) return 'Use Chinese characters or Pinyin only';
    return null;
  }

  // China mobile: 11 digits, first digit 1, second 3-9 — no leading zero.
  static final RegExp _cnMobile = RegExp(r'^1[3-9]\d{9}$');
  static final RegExp _emailRe = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
  static final RegExp _cnIdCard = RegExp(r'^\d{17}[0-9Xx]$'); // 18-char resident ID
  static final RegExp _cnIdCardLegacy = RegExp(r'^\d{15}$'); // legacy 15-digit
  static final RegExp _passportRe = RegExp(r'^[A-Za-z0-9]{5,18}$');

  /// Strips a pasted +86 / 0086 / 86 prefix and any leading zero so the field
  /// carries the bare 11-digit number China mobiles actually use.
  String _normalizeCnMobile(String raw) {
    var v = raw.trim().replaceAll(RegExp(r'[\s-]'), '');
    if (v.startsWith('+86')) {
      v = v.substring(3);
    } else if (v.startsWith('0086')) {
      v = v.substring(4);
    } else if (v.startsWith('86') && v.length > 11) {
      v = v.substring(2);
    }
    if (v.startsWith('0')) v = v.replaceFirst(RegExp(r'^0+'), '');
    return v;
  }

  String? _cnMobileError(String raw, {required bool required}) {
    final v = _normalizeCnMobile(raw);
    if (v.isEmpty) return required ? 'Enter the phone number' : null;
    if (!_cnMobile.hasMatch(v)) {
      return 'Enter a valid Chinese mobile — 11 digits starting with 1';
    }
    return null;
  }

  String? _emailError(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return 'Enter the email address';
    if (!_emailRe.hasMatch(v)) return 'That does not look like an email address';
    return null;
  }

  String? _idNumberError(String raw, String idType, {required bool required}) {
    final v = raw.trim();
    if (v.isEmpty) return required ? 'Enter the ID number' : null;
    if (idType == 'ID_CARD') {
      if (!_cnIdCard.hasMatch(v) && !_cnIdCardLegacy.hasMatch(v)) {
        return 'A Chinese ID card is 18 characters (17 digits + check)';
      }
    } else if (!_passportRe.hasMatch(v)) {
      return 'Enter a valid ID / passport number';
    }
    return null;
  }

  String? _cardError(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return 'Enter the UnionPay card number';
    if (!RegExp(r'^\d{12,19}$').hasMatch(v)) {
      return 'A UnionPay card is 12–19 digits';
    }
    return null;
  }

  String? _bankAcctError(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return 'Enter the account number';
    if (!RegExp(r'^\d{6,30}$').hasMatch(v)) return 'Enter a valid account number';
    return null;
  }

  /// The wallet login id (Alipay email vs phone / WeChat phone), validated by
  /// the current account-id type.
  String? _walletAccountError() {
    final raw = _c('accountNumber').text;
    if (_rail == RmbRail.ALIPAY && _acctIdType == 'EMAIL') {
      return _emailError(raw);
    }
    return _cnMobileError(raw, required: true);
  }

  String? _validateInput() {
    final first = _c('firstName').text.trim();
    final last = _c('lastName').text.trim();
    if (first.isEmpty || last.isEmpty) {
      return 'Enter the receiver’s surname and given name';
    }
    // Klasha accepts Chinese characters OR Pinyin (matches the toggle + backend
    // validReceiverName); only reject empty/garbage, not a valid Pinyin name.
    if (!_nameValid(first) || !_nameValid(last)) {
      return 'Enter the receiver name in Chinese characters or Pinyin';
    }
    if (_isWallet) {
      final acctErr = _walletAccountError();
      if (acctErr != null) return acctErr;
      // Receiver ID number is optional for wallet payouts (Klasha C2C WALLET).
      final idErr = _idNumberError(_c('idNumber').text, 'PASSPORT', required: false);
      if (idErr != null) return idErr;
    } else if (_rail == RmbRail.UNIONPAY) {
      final cardErr = _cardError(_c('cardNumber').text);
      if (cardErr != null) return cardErr;
      if (_c('cardHolder').text.trim().isEmpty) {
        return 'Enter the card holder name';
      }
      if (_bank == null) return 'Choose the receiver’s bank';
    } else if (_rail == RmbRail.BANK) {
      final acctName = _c('accountName').text.trim();
      if (acctName.isEmpty) return 'Enter the account name';
      if (!_nameValid(acctName)) {
        return 'Enter the account name in Chinese characters or Pinyin';
      }
      final acctErr = _bankAcctError(_c('accountNumber').text);
      if (acctErr != null) return acctErr;
      if (_bank == null) return 'Choose the receiver’s bank';
      final mobErr = _cnMobileError(_c('mobile').text, required: true);
      if (mobErr != null) return mobErr;
      final idErr = _idNumberError(_c('idNumber').text, _idType, required: true);
      if (idErr != null) return idErr;
    }
    return null;
  }

  String? _sourceCurrencyGuard() {
    final acct = GetIt.I<AccountManager>().activeAccountDetails;
    final cur = (acct?.currency ?? '').trim().toUpperCase();
    if (cur.isNotEmpty && cur != 'NGN') {
      return 'RMB payouts are funded from your Naira (NGN) wallet. Switch to a NGN account to continue.';
    }
    return null;
  }

  // ── Bank picker ──────────────────────────────────────────────────────
  Widget _bankPickerField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: GestureDetector(
        onTap: _openBankPicker,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: RmbUi.card,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: RmbUi.border),
          ),
          child: Row(
            children: [
              Icon(Icons.account_balance_outlined,
                  color: RmbUi.textSecondary, size: 18.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(_bank?.name ?? 'Choose bank',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: _bank == null ? RmbUi.label : Colors.white,
                        fontSize: 14.sp)),
              ),
              Icon(Icons.keyboard_arrow_down_rounded,
                  color: RmbUi.textSecondary, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openBankPicker() async {
    final picked = await showModalBottomSheet<Bank>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RmbBankPickerSheet(rail: _rail, cubit: _cubit),
    );
    if (picked != null && mounted) {
      setState(() {
        _bank = picked;
        _saved = null;
      });
    }
  }

  // ── Compliance capture (one-time sender KYC) ─────────────────────────
  // Guided form: dropdown ID type, tap-to-open 18+ date-of-birth picker,
  // country dropdown for nationality, and required-field validation gating
  // "Save and continue" (mirrors the server complianceComplete gate so a valid
  // submit never bounces).
  Future<bool?> _openComplianceSheet(ComplianceProfile existing) {
    const idTypeOptions = ['PASSPORT', 'ID_CARD', 'DRIVER_LICENSE'];
    const idTypeLabels = {
      'PASSPORT': 'International passport',
      'ID_CARD': 'National ID',
      'DRIVER_LICENSE': "Driver's licence",
    };
    String two(int n) => n.toString().padLeft(2, '0');
    String iso(DateTime d) => '${d.year}-${two(d.month)}-${two(d.day)}';

    // Prefill from any partial/existing profile so a returning user never
    // re-types data they already gave (the gate only opens this when the
    // profile is incomplete).
    final firstName = TextEditingController(text: existing.senderFirstName);
    final lastName = TextEditingController(text: existing.senderLastName);
    final idNumber = TextEditingController(text: existing.senderIdNumber);
    final addr = existing.hasSenderAddress() ? existing.senderAddress : null;
    final city = TextEditingController(text: addr?.city ?? '');
    final stateC = TextEditingController(text: addr?.state ?? '');
    final street = TextEditingController(text: addr?.streetAddress ?? '');
    final postcode = TextEditingController(text: addr?.postcode ?? '');
    final touched = <String>{};
    String idType = idTypeOptions.contains(existing.senderIdType)
        ? existing.senderIdType
        : 'PASSPORT';
    final natCodes = CountryCode.values.map((e) => e.code).toSet();
    String nationality = natCodes.contains(existing.senderNationality)
        ? existing.senderNationality
        : 'NG';
    DateTime? dob;
    final dobMatch =
        RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(existing.senderBirthDate);
    if (dobMatch != null) {
      dob = DateTime(int.parse(dobMatch.group(1)!),
          int.parse(dobMatch.group(2)!), int.parse(dobMatch.group(3)!));
    }

    void disposeCtrls() {
      for (final c in [
        firstName,
        lastName,
        idNumber,
        city,
        stateC,
        street,
        postcode
      ]) {
        c.dispose();
      }
    }

    final future = showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModal) {
          bool filled(TextEditingController c) => c.text.trim().isNotEmpty;
          final complete = filled(firstName) &&
              filled(lastName) &&
              filled(idNumber) &&
              filled(city) &&
              filled(stateC) &&
              dob != null;

          Widget req(String key, TextEditingController c, String hint,
              {bool required = true,
              TextInputType? keyboard,
              List<TextInputFormatter>? formatters}) {
            final err = (required && touched.contains(key) && !filled(c))
                ? 'Required'
                : null;
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Focus(
                onFocusChange: (has) {
                  if (!has) setModal(() => touched.add(key));
                },
                child: TextField(
                  controller: c,
                  keyboardType: keyboard,
                  inputFormatters: formatters,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  onChanged: (_) => setModal(() {}),
                  decoration: _inputDecoration(hint).copyWith(
                    errorText: err,
                    errorStyle: TextStyle(color: RmbUi.error, fontSize: 11.sp),
                  ),
                ),
              ),
            );
          }

          Future<void> pickDob() async {
            final now = DateTime.now();
            final eighteen = DateTime(now.year - 18, now.month, now.day);
            // A prefilled under-18 date would violate the picker's
            // initialDate<=lastDate assert — clamp it.
            final initial =
                (dob != null && !dob!.isAfter(eighteen)) ? dob! : eighteen;
            final picked = await showDatePicker(
              context: ctx,
              initialDate: initial,
              firstDate: DateTime(1900),
              lastDate: eighteen,
              helpText: 'Date of birth (18+)',
              builder: (c, child) => Theme(
                data: Theme.of(c).copyWith(
                  colorScheme: ColorScheme.dark(
                    primary: RmbUi.accent,
                    onPrimary: Colors.white,
                    surface: RmbUi.card,
                    onSurface: Colors.white,
                  ),
                ),
                child: child!,
              ),
            );
            if (picked != null) setModal(() => dob = picked);
          }

          return Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: RmbUi.bg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                border: Border.all(color: RmbUi.border),
              ),
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Sender verification',
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700)),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(ctx, false),
                          child: _headerButton(Icons.close_rounded),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text('Required once by cross-border regulations.',
                        style: TextStyle(
                            color: RmbUi.textSecondary, fontSize: 12.sp)),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                            child: req('firstName', firstName, 'First name')),
                        SizedBox(width: 10.w),
                        Expanded(child: req('lastName', lastName, 'Last name')),
                      ],
                    ),
                    _dropdown('ID type', idType, idTypeOptions,
                        (v) => setModal(() => idType = v),
                        labels: idTypeLabels),
                    req('idNumber', idNumber, 'ID number'),
                    // Date of birth — read-only, tap to open the picker.
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: GestureDetector(
                        onTap: pickDob,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 14.h),
                          decoration: BoxDecoration(
                            color: RmbUi.card,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: RmbUi.border),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                    dob == null
                                        ? 'Date of birth'
                                        : iso(dob!),
                                    style: TextStyle(
                                        color: dob == null
                                            ? RmbUi.label
                                            : Colors.white,
                                        fontSize: 14.sp)),
                              ),
                              Icon(Icons.calendar_today_rounded,
                                  size: 16.sp, color: RmbUi.textSecondary),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _dropdown(
                        'Nationality',
                        nationality,
                        CountryCode.values.map((e) => e.code).toList(),
                        (v) => setModal(() => nationality = v),
                        labels: {
                          for (final cc in CountryCode.values)
                            cc.code: '${cc.flag}  ${cc.name}'
                        }),
                    Row(
                      children: [
                        Expanded(child: req('city', city, 'City')),
                        SizedBox(width: 10.w),
                        Expanded(child: req('state', stateC, 'State')),
                      ],
                    ),
                    req('street', street, 'Street address (optional)',
                        required: false),
                    req('postcode', postcode, 'Postcode (optional)',
                        required: false,
                        keyboard: TextInputType.number,
                        formatters: [FilteringTextInputFormatter.digitsOnly]),
                    SizedBox(height: 4.h),
                    _primaryButton(
                        'Save and continue',
                        complete
                            ? () async {
                                final p = ComplianceProfile(
                                  senderFirstName: firstName.text.trim(),
                                  senderLastName: lastName.text.trim(),
                                  senderIdNumber: idNumber.text.trim(),
                                  senderIdType: idType,
                                  senderNationality: nationality,
                                  senderBirthDate: iso(dob!),
                                  senderAddress: Address(
                                    city: city.text.trim(),
                                    state: stateC.text.trim(),
                                    streetAddress: street.text.trim(),
                                    postcode: postcode.text.trim(),
                                    countryCode: 'NG',
                                  ),
                                );
                                try {
                                  final saved = await _cubit.saveCompliance(p);
                                  if (!saved.complete) {
                                    _snack('Please fill all required fields');
                                    return;
                                  }
                                  if (ctx.mounted) Navigator.pop(ctx, true);
                                } catch (e) {
                                  _snack(rmbFriendlyError(e));
                                }
                              }
                            : null),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    return future.whenComplete(disposeCtrls);
  }

  // ── Shared small widgets ─────────────────────────────────────────────
  Widget _field(
    String key,
    String hint, {
    bool onEdited = false,
    TextInputType? keyboardType,
    Widget? suffix,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String)? validator,
  }) {
    // Inline error appears only once the user has typed something (so an
    // untouched required field doesn't shout before it's been reached).
    final value = _c(key).text;
    final error =
        (validator != null && value.trim().isNotEmpty) ? validator(value) : null;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextField(
        controller: _c(key),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        onChanged: (onEdited || validator != null)
            ? (_) => setState(() {
                  if (onEdited) _saved = null;
                })
            : null,
        decoration: _inputDecoration(hint).copyWith(
          suffixIcon: suffix,
          errorText: error,
          errorStyle: TextStyle(color: RmbUi.error, fontSize: 11.sp),
          errorMaxLines: 2,
        ),
      ),
    );
  }

  /// Phone field with a fixed 🇨🇳 +86 country-code affix. Digits only, capped at
  /// 11, with inline China-mobile validation — never accepts letters.
  Widget _phoneField(String key, {required String label}) {
    final value = _c(key).text;
    final error =
        value.trim().isEmpty ? null : _cnMobileError(value, required: true);
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: RmbUi.card,
              borderRadius: BorderRadius.circular(12.r),
              border:
                  Border.all(color: error != null ? RmbUi.error : RmbUi.border),
            ),
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🇨🇳', style: TextStyle(fontSize: 15.sp)),
                      SizedBox(width: 6.w),
                      Text('+86',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                Container(width: 1, height: 24.h, color: RmbUi.border),
                Expanded(
                  child: TextField(
                    controller: _c(key),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    onChanged: (_) => setState(() => _saved = null),
                    decoration: InputDecoration(
                      hintText: label,
                      hintStyle: TextStyle(color: RmbUi.label, fontSize: 13.sp),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (error != null)
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 4.w),
              child: Text(error,
                  style: TextStyle(color: RmbUi.error, fontSize: 11.sp)),
            ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: RmbUi.label, fontSize: 13.sp),
        filled: true,
        fillColor: RmbUi.card,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: RmbUi.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: RmbUi.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: RmbUi.railColor(_rail)),
        ),
      );

  Widget _segmented({
    required List<String> options,
    required List<String> labels,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: RmbUi.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: RmbUi.border),
      ),
      child: Row(
        children: List.generate(options.length, (i) {
          final sel = value == options[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(options[i]),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 9.h),
                decoration: BoxDecoration(
                  color: sel ? RmbUi.railColor(_rail) : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Text(labels[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: sel ? Colors.white : RmbUi.textSecondary,
                        fontSize: 12.sp,
                        fontWeight: sel ? FontWeight.w600 : FontWeight.w400)),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> options,
      ValueChanged<String> onChanged,
      {Map<String, String>? labels}) {
    // Guard against an out-of-range prefill (a saved/repeated value that isn't
    // valid for the current rail) — DropdownButtonFormField asserts exactly one
    // matching item, so coerce an unknown value to the first option.
    final safeValue =
        options.contains(value) ? value : (options.isNotEmpty ? options.first : value);
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: DropdownButtonFormField<String>(
        // FormFields only honour initialValue on creation — key the widget by
        // value so programmatic prefills (saved recipients) show correctly.
        key: ValueKey('$label:$safeValue'),
        initialValue: safeValue,
        isExpanded: true,
        dropdownColor: RmbUi.card,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: _inputDecoration('').copyWith(
          labelText: label,
          labelStyle: TextStyle(color: RmbUi.label, fontSize: 13.sp),
        ),
        items: options
            .map((o) => DropdownMenuItem(
                value: o,
                child: Text(labels?[o] ?? o.replaceAll('_', ' ').toLowerCase(),
                    style: TextStyle(color: Colors.white, fontSize: 13.sp))))
            .toList(),
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  Widget _label(String t) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(t,
            style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600)),
      );

  Widget _row(String k, String v, {bool bold = false}) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k,
                style: TextStyle(color: RmbUi.textSecondary, fontSize: 13.sp)),
            Text(v,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: bold ? 15.sp : 13.sp,
                    fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
          ],
        ),
      );

  Widget _primaryButton(String label, VoidCallback? onTap) => SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: RmbUi.accent,
            disabledBackgroundColor: RmbUi.accent.withValues(alpha: 0.4),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r)),
          ),
          child: Text(label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700)),
        ),
      );

  void _snack(String m) =>
      Get.snackbar('RMB', m, snackPosition: SnackPosition.BOTTOM);
}
