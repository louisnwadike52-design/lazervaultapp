import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/widgets/biller_logo.dart';
import 'package:lazervault/core/widgets/bill_auto_recharge_create_sheet.dart';
import 'package:lazervault/core/widgets/save_beneficiary_controls.dart';

import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/features/bills/presentation/widgets/bill_list_picker_sheet.dart';
import '../widgets/internet_rollover_preference_sheet.dart'
    show InternetRolloverPreference;

import '../cubit/internet_bill_cubit.dart';
import '../cubit/internet_bill_state.dart';
import '../../domain/entities/internet_provider_entity.dart';
import '../../domain/entities/internet_package_entity.dart';
import '../../domain/entities/internet_payment_entity.dart';
import '../../domain/entities/internet_account_validation_entity.dart';
import '../../domain/entities/internet_beneficiary.dart';
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

/// Single-page internet-subscription purchase — streamlined "one page, very
/// fast" flow (mirror of CableTVQuickBuy). Pick provider (Smile/Spectranet/…) →
/// enter account/customer number → the customer AUTO-VALIDATES + packages load →
/// pick a plan in a STYLED bottom sheet → inline confirmation → the shared
/// TX-PIN sheet ALSO runs the payment → receipt. No account-input / package /
/// confirm / processing screens. Reuses [InternetBillCubit] unchanged, so the
/// admin provider-attempt audit + sync/async reconciliation are preserved.
class InternetQuickBuy extends StatefulWidget {
  const InternetQuickBuy({super.key});

  @override
  State<InternetQuickBuy> createState() => _InternetQuickBuyState();
}

class _InternetQuickBuyState extends State<InternetQuickBuy>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _currency = 'NGN';

  final _accountController = TextEditingController();
  // Amount for VARIABLE-price plans (backend flags them amount==0, e.g.
  // Spectranet/Swift recharge): the user picks the denomination; the backend
  // enforces Flutterwave's live min/max pre-charge and refunds out-of-bounds.
  final _amountController = TextEditingController();

  List<InternetProviderEntity> _providers = const [];
  // Set when the initial provider fetch fails so the chips row can offer an
  // inline retry instead of spinning on "Loading providers…" forever.
  String? _providersError;
  InternetProviderEntity? _provider;
  InternetAccountValidationEntity? _validation;
  bool _validating = false;
  String? _validateError;
  // Live package-fetch state so the picker sheet updates itself as packages
  // arrive / fail, instead of freezing on the snapshot it opened with.
  // `_fetchingPackages` scopes a generic cubit error to THIS fetch (the cubit
  // is shared with the validation/payment flows).
  final ValueNotifier<BillListFetchState<InternetPackageEntity>> _packageState =
      ValueNotifier(const BillListFetchState<InternetPackageEntity>.idle());
  bool _fetchingPackages = false;
  InternetPackageEntity? _package;
  bool _submitting = false;
  Timer? _debounce;
  StreamSubscription<InternetBillState>? _sub;

  // ── Save-beneficiary — post-purchase the receipt upserts the ISP account.
  // Loaded once so an already-saved account shows a passive "already saved" row
  // instead of inviting a duplicate save.
  bool _saveBeneficiary = false;
  String? _saveNickname;
  List<InternetBeneficiary> _beneficiaries = const [];
  InternetBeneficiary? _existingBeneficiary;

  // ── Inline auto-renew — captured from BillAutoRechargeCreateSheet.
  // Threaded into the receipt args (same shape the old confirmation screen
  // used); the receipt fires the real createAutoRecharge post-success,
  // upserting the account beneficiary the schedule attaches to.
  bool _autoEnabled = false;
  String? _autoSummary;
  InternetRolloverPreference? _rolloverPref;

  @override
  void initState() {
    super.initState();
    _sub = context.read<InternetBillCubit>().stream.listen(_onState);
    context.read<InternetBillCubit>().getProviders();
    _accountController.addListener(_onAccountChanged);
    _loadSavedBeneficiaries();
  }

  /// Best-effort read of the user's saved ISP accounts so we can flag an
  /// already-saved account and avoid a duplicate save.
  Future<void> _loadSavedBeneficiaries() async {
    try {
      final list = await serviceLocator<InternetBeneficiaryRemoteDataSource>()
          .getBeneficiaries();
      if (!mounted) return;
      setState(() => _beneficiaries = list);
      _recomputeExistingBeneficiary();
    } catch (_) {/* best-effort — dedup just won't pre-flag */}
  }

  /// Match the typed account (digits-only) against saved beneficiaries. When a
  /// provider is selected, also require the provider code to match so the same
  /// account number under a different ISP isn't treated as a duplicate.
  void _recomputeExistingBeneficiary() {
    final typed = _accountController.text.replaceAll(RegExp(r'[^\d]'), '');
    final code = _provider != null ? _providerCodeFor(_provider!.serviceId) : null;
    InternetBeneficiary? found;
    if (typed.isNotEmpty) {
      for (final b in _beneficiaries) {
        if (b.accountNumber.replaceAll(RegExp(r'[^\d]'), '') == typed &&
            (code == null || b.providerCode == code)) {
          found = b;
          break;
        }
      }
    }
    if (found?.id != _existingBeneficiary?.id) {
      setState(() => _existingBeneficiary = found);
    }
  }

  /// Provider service id → canonical provider code (matches the receipt's
  /// mapping so the saved beneficiary's `providerCode` lines up for dedup).
  String _providerCodeFor(String serviceId) {
    switch (serviceId.toLowerCase()) {
      case 'smile-direct':
      case 'smile':
        return 'SMILE';
      case 'spectranet':
        return 'SPECTRANET';
      case 'ipnx':
      case 'ipnx1515':
        return 'IPNX';
      case 'swift4g':
      case 'swift':
        return 'SWIFT';
      default:
        return serviceId.toUpperCase();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _sub?.cancel();
    _packageState.dispose();
    _accountController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onState(InternetBillState s) {
    if (!mounted) return;
    if (s is InternetBillProvidersLoaded) {
      setState(() {
        _providers = s.providers;
        _providersError = null;
      });
    } else if (s is InternetAccountValidating) {
      setState(() => _validating = true);
    } else if (s is InternetAccountValidated) {
      setState(() {
        _validation = s.validation.isValid ? s.validation : null;
        _validateError = s.validation.isValid ? null : 'Account not found';
        _validating = false;
      });
    } else if (s is InternetAccountValidationFailed) {
      setState(() {
        _validation = null;
        _validateError = s.message;
        _validating = false;
      });
    } else if (s is InternetPackagesLoaded) {
      _fetchingPackages = false;
      _packageState.value = BillListFetchState.loaded(s.packages);
      setState(() {});
    } else if (s is InternetBillError && _fetchingPackages) {
      // A generic error while a packages fetch is in flight = the fetch failed;
      // surface a retry in the sheet instead of a permanent empty/spinner.
      _fetchingPackages = false;
      _packageState.value =
          BillListFetchState.failed(sanitizeUserFacingError(s.message));
    } else if (s is InternetBillError && _providers.isEmpty) {
      // Providers never loaded — surface an inline retry instead of leaving
      // the chips row spinning on "Loading providers…" forever.
      setState(() => _providersError = sanitizeUserFacingError(s.message));
    }
  }

  void _reloadProviders() {
    setState(() => _providersError = null);
    context.read<InternetBillCubit>().getProviders();
  }

  void _selectProvider(InternetProviderEntity p) {
    setState(() {
      _provider = p;
      _validation = null;
      _validateError = null;
      _package = null;
    });
    _fetchingPackages = true;
    _packageState.value =
        const BillListFetchState<InternetPackageEntity>.loading();
    context.read<InternetBillCubit>().getPackages(providerId: p.serviceId);
    _recomputeExistingBeneficiary();
    if (_accountController.text.trim().length >= 6) _validateAccount();
  }

  void _reloadPackages() {
    final p = _provider;
    if (p == null) return;
    _fetchingPackages = true;
    _packageState.value =
        const BillListFetchState<InternetPackageEntity>.loading();
    context.read<InternetBillCubit>().getPackages(providerId: p.serviceId);
  }

  void _onAccountChanged() {
    _recomputeExistingBeneficiary();
    _debounce?.cancel();
    if (_validation != null || _validateError != null) {
      setState(() {
        _validation = null;
        _validateError = null;
      });
    }
    if (_provider == null || _accountController.text.trim().length < 6) return;
    _debounce = Timer(const Duration(milliseconds: 500), _validateAccount);
  }

  void _validateAccount() {
    final p = _provider;
    if (p == null) return;
    context.read<InternetBillCubit>().validateAccount(
          providerId: p.serviceId,
          accountNumber: _accountController.text.trim(),
        );
  }

  /// Variable-price plan: the backend lists it with amount 0 (Flutterwave
  /// catalogue "any amount" item) — the user supplies the amount.
  bool get _isVariablePackage => _package != null && _package!.amount <= 0;

  double get _enteredAmount =>
      double.tryParse(
          _amountController.text.replaceAll(',', '').trim()) ??
      0;

  /// The amount this purchase will charge: the package's fixed price, or the
  /// user-entered amount for a variable-price plan.
  double get _effectiveAmount =>
      _isVariablePackage ? _enteredAmount : (_package?.amount ?? 0);

  bool get _ready =>
      _provider != null &&
      _validation != null &&
      _package != null &&
      _effectiveAmount > 0;

  Future<void> _openPackageSheet() async {
    if (_provider == null) return;
    final picked = await showModalBottomSheet<InternetPackageEntity>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BillListPickerSheet<InternetPackageEntity>(
        title: '${_provider!.name} plans',
        icon: Icons.wifi,
        accent: _accent,
        listenable: _packageState,
        labelOf: (p) => p.name,
        trailingOf: (p) =>
            p.amount > 0 ? '₦${p.amount.toStringAsFixed(0)}' : 'Enter amount',
        subtitleOf: (p) => p.validity,
        emptyLabel: 'No plans available',
        onRetry: _reloadPackages,
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        _package = picked;
        // A fixed-price pick invalidates any variable amount typed earlier.
        if (picked.amount > 0) _amountController.clear();
      });
    }
  }

  // ── Purchase (runs INSIDE the TX-PIN sheet's processing beat) ──────────────
  Future<void> _pay() async {
    if (!_ready || _submitting) return;
    FocusScope.of(context).unfocus();
    final cubit = context.read<InternetBillCubit>();
    final p = _provider!;
    final pkg = _package!;
    final account = _accountController.text.trim();
    final txnId = 'internet_${DateTime.now().millisecondsSinceEpoch}_$account';

    final payAmount = _effectiveAmount;
    InternetPaymentEntity? result;
    setState(() => _submitting = true);
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'internet_purchase',
        amount: payAmount,
        currency: _currency,
        title: 'Confirm subscription',
        message:
            'Pay $_currency ${payAmount.toStringAsFixed(0)} for ${pkg.name} on ${p.name} (${_validation!.customerName})',
        showProcessingPhase: true,
        successMessage: 'Subscription request sent',
        onPinValidated: (token) async {
          final completer = Completer<InternetPaymentEntity>();
          late final StreamSubscription<InternetBillState> sub;
          sub = cubit.stream.listen((state) {
            if (completer.isCompleted) return;
            if (state is InternetBillPaymentSuccess) {
              completer.complete(state.payment);
            } else if (state is InternetBillPaymentFailed) {
              completer.completeError(state.message);
            }
          });
          try {
            cubit.payBill(
              providerId: p.serviceId,
              customerNumber: account,
              serviceType: p.serviceId,
              packageId: pkg.id,
              amount: payAmount,
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
        final wantsAuto = _autoEnabled && _rolloverPref != null;
        final alreadySaved = _existingBeneficiary != null;
        Get.toNamed(AppRoutes.internetPaymentReceipt, arguments: {
          'payment': result,
          // provider / package / account are forwarded WHENEVER a save or an
          // auto-renew is requested — the receipt needs them to upsert the
          // account beneficiary the (optional) schedule attaches to.
          'provider': p,
          'package': pkg,
          'accountNumber': account,
          // Auto-renew needs a saved beneficiary to attach to, so force the
          // save on when a schedule was requested and it isn't already saved.
          'saveBeneficiary': (_saveBeneficiary && !alreadySaved) || wantsAuto,
          if (_saveNickname != null) 'beneficiaryNickname': _saveNickname,
          // Already-saved account: hand the receipt the existing id so it
          // skips the duplicate save and still wires the auto-renew schedule.
          if (alreadySaved) 'existingBeneficiaryId': _existingBeneficiary!.id,
          // Auto-renew hand-off — the receipt fires the real createAutoRecharge
          // once the payment lands.
          'autoRenewEnabled': wantsAuto,
          if (wantsAuto) 'rolloverPref': _rolloverPref,
        });
      }
    } catch (_) {
      // Failure surfaces on the PIN sheet's failed beat.
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  // ── Inline auto-renew ────────────────────────────────────────────────────────
  Future<void> _onToggleAuto(bool value) async {
    if (!value) {
      setState(() {
        _autoEnabled = false;
        _autoSummary = null;
        _rolloverPref = null;
      });
      return;
    }
    await _openAutoRechargeSheet();
  }

  Future<void> _openAutoRechargeSheet() async {
    final p = _provider;
    final pkg = _package;
    if (p == null || pkg == null) return;
    final account = _accountController.text.trim();
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '${p.name} · acct $account',
      title: 'Auto-renew schedule',
      ctaLabel: 'Save schedule',
      successMessage: 'Schedule saved',
      // Variable-price plans have amount 0 — seed the schedule with the
      // amount the user actually entered so an auto-renew is never created
      // for ₦0.
      initialAmount: _effectiveAmount,
      onSubmit: ({
        required double amount,
        required String frequency,
        required int dayOfWeek,
        required int dayOfMonth,
        required int executionHour,
        required int executionMinute,
      }) async {
        if (!mounted) return;
        setState(() {
          _autoEnabled = true;
          // InternetRolloverPreference uses dayOfWeek 0-6 (Sun..Sat); the
          // sheet emits 1-7 (Mon..Sun) → map Sun(7)→0, Mon..Sat(1..6) stay.
          _rolloverPref = InternetRolloverPreference(
            frequency: frequency,
            dayOfWeek: dayOfWeek % 7,
            dayOfMonth: dayOfMonth,
            executionHour: executionHour,
            executionMinute: executionMinute,
          );
          _autoSummary = _summarize(
            amount: amount,
            frequency: frequency,
            dayOfWeek: dayOfWeek,
            dayOfMonth: dayOfMonth,
            hour: executionHour,
            minute: executionMinute,
          );
        });
      },
    );
  }

  String _summarize({
    required double amount,
    required String frequency,
    required int dayOfWeek,
    required int dayOfMonth,
    required int hour,
    required int minute,
  }) {
    String when;
    switch (frequency) {
      case 'weekly':
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        when = 'Every ${days[(dayOfWeek - 1).clamp(0, 6)]}';
        break;
      case 'monthly':
        when = 'Day $dayOfMonth monthly';
        break;
      default:
        when = 'Every day';
    }
    final t =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    return '$when at $t · ₦${amount.toStringAsFixed(0)}';
  }

  Widget _autoRechargeCard() {
    final on = _autoEnabled && _rolloverPref != null;
    return GestureDetector(
      onTap: on ? _openAutoRechargeSheet : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _border),
        ),
        child: Row(children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: _accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.autorenew, color: _accent, size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Auto-renew',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text(on ? _autoSummary! : 'Renew this plan on a schedule',
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.sp)),
              ],
            ),
          ),
          Switch.adaptive(
            value: _autoEnabled,
            onChanged: _onToggleAuto,
            activeThumbColor: _accent,
          ),
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
        _label('Provider'),
        SizedBox(height: 8.h),
        _providerChips(),
        SizedBox(height: 20.h),
        _label('Account / customer number'),
        SizedBox(height: 8.h),
        _accountField(),
        SizedBox(height: 8.h),
        _accountStatusRow(),
        SizedBox(height: 20.h),
        _label('Plan'),
        SizedBox(height: 8.h),
        _packageSelector(),
        if (_isVariablePackage) ...[
          SizedBox(height: 20.h),
          _label('Amount'),
          SizedBox(height: 8.h),
          _variableAmountField(),
        ],
        if (_ready) ...[
          SizedBox(height: 20.h),
          _confirmationCard(),
          SizedBox(height: 12.h),
          _autoRechargeCard(),
        ],
        SizedBox(height: 14.h),
        _saveBeneficiaryToggle(),
        SizedBox(height: 16.h),
        _payButton(),
      ],
    );
  }

  Widget _label(String t) => Text(t,
      style: GoogleFonts.inter(
          color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600));

  Widget _providerChips() {
    if (_providers.isEmpty && _providersError != null) {
      return Row(children: [
        Icon(Icons.error_outline,
            color: const Color(0xFFEF4444), size: 16.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text("Couldn't load providers",
              style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
        ),
        TextButton(
          onPressed: _reloadProviders,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text('Retry',
              style: GoogleFonts.inter(
                  color: _accent, fontSize: 13.sp, fontWeight: FontWeight.w600)),
        ),
      ]);
    }
    if (_providers.isEmpty) {
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Loading providers…',
            style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
      ]);
    }
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: _providers.map((p) {
        final selected = _provider?.id == p.id;
        return GestureDetector(
          onTap: () => _selectProvider(p),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: selected ? _accent : _card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: selected ? _accent : _border),
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              BillerLogo(
                  code: p.serviceId,
                  name: p.name,
                  logoUrl: p.logoUrl,
                  size: 22,
                  borderRadius: 6),
              SizedBox(width: 8.w),
              Text(p.name,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600)),
            ]),
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
          hintText: _provider == null
              ? 'Select a provider first'
              : 'Enter account / customer number',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
          prefixIcon: Icon(Icons.router, color: _muted, size: 20.sp),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        ),
      ),
    );
  }

  Widget _accountStatusRow() {
    if (_validating) {
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Verifying account…',
            style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
      ]);
    }
    if (_validateError != null) {
      return Text(_validateError!,
          style: GoogleFonts.inter(
              color: const Color(0xFFEF4444), fontSize: 12.sp));
    }
    final v = _validation;
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
          child: Text(v.customerName,
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

  Widget _packageSelector() {
    final enabled = _provider != null;
    return GestureDetector(
      onTap: enabled ? _openPackageSheet : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: _border),
        ),
        child: Row(children: [
          Expanded(
            child: Text(
              _package?.name ??
                  (enabled ? 'Select a plan' : 'Select a provider first'),
              style: GoogleFonts.inter(
                color: _package != null ? Colors.white : const Color(0xFF6B7280),
                fontSize: 15.sp,
                fontWeight: _package != null ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          if (_package != null)
            Text(
                _package!.amount > 0
                    ? '₦${_package!.amount.toStringAsFixed(0)}'
                    : 'Your amount',
                style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700)),
          SizedBox(width: 6.w),
          Icon(Icons.keyboard_arrow_down, color: _muted, size: 22.sp),
        ]),
      ),
    );
  }

  /// Amount entry for VARIABLE-price plans (Spectranet/Swift recharge). The
  /// backend re-checks Flutterwave's live min/max pre-charge, so an
  /// out-of-range amount fails with a clear message and a full refund.
  Widget _variableAmountField() {
    return TextField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: false),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (_) => setState(() {}),
      style: GoogleFonts.inter(
          color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: 'Enter recharge amount',
        hintStyle:
            GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp),
        prefixText: '₦ ',
        prefixStyle: GoogleFonts.inter(
            color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w600),
        filled: true,
        fillColor: _card,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: _border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: _border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: const BorderSide(color: _accent),
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
        _row('Customer', _validation!.customerName),
        SizedBox(height: 10.h),
        _row('Provider', _provider!.name),
        SizedBox(height: 10.h),
        _row('Plan', _package!.name),
        SizedBox(height: 10.h),
        Divider(color: _border, height: 1),
        SizedBox(height: 10.h),
        _row('You pay', '₦${_effectiveAmount.toStringAsFixed(0)}',
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

  /// Save-as-beneficiary control. Renders a passive "already saved" row when
  /// the account is already saved (no duplicate); otherwise a switch that opens
  /// a nickname dialog on ON. The save runs post-purchase on the receipt.
  Widget _saveBeneficiaryToggle() {
    if (_existingBeneficiary != null) {
      final b = _existingBeneficiary!;
      return SavedBeneficiaryInfoRow(
        title: 'Account already saved',
        subtitle: 'Saved as "${b.nickname ?? b.accountNumber}"',
      );
    }
    return SaveBeneficiaryToggleRow(
      accent: _accent,
      title: 'Save this account',
      subtitle: _saveBeneficiary && (_saveNickname?.isNotEmpty ?? false)
          ? 'Nickname: ${_saveNickname!}'
          : 'Save it as a beneficiary for faster payments next time',
      value: _saveBeneficiary,
      onChanged: _onToggleSaveBeneficiary,
    );
  }

  Future<void> _onToggleSaveBeneficiary(bool value) async {
    if (!value) {
      setState(() {
        _saveBeneficiary = false;
        _saveNickname = null;
      });
      return;
    }
    final nickname = await promptBeneficiaryNickname(
      context,
      accent: _accent,
      title: 'Save this account',
      prompt: 'Give this account a nickname so you can find it fast next time.',
      hint: 'e.g. Home, Office, Shop',
      initial: _saveNickname ?? '',
    );
    if (nickname == null || nickname.trim().isEmpty) {
      if (mounted) setState(() => _saveBeneficiary = false);
      return;
    }
    setState(() {
      _saveBeneficiary = true;
      _saveNickname = nickname.trim();
    });
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
                _package != null && _effectiveAmount > 0
                    ? 'Pay ₦${_effectiveAmount.toStringAsFixed(0)}'
                    : 'Pay subscription',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
