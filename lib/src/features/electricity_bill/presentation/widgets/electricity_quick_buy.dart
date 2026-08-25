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
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/widgets/biller_logo.dart';
import 'package:lazervault/core/widgets/bill_auto_recharge_create_sheet.dart';
import 'package:lazervault/core/widgets/save_beneficiary_controls.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/src/features/bills/presentation/widgets/bill_list_picker_sheet.dart';
import '../widgets/electricity_rollover_preference_sheet.dart'
    show ElectricityRolloverPreference;

import '../cubit/electricity_bill_cubit.dart';
import '../cubit/electricity_bill_state.dart';
import '../../domain/entities/bill_payment_entity.dart' show MeterType;
import '../../domain/entities/beneficiary_entity.dart';
import '../../domain/entities/provider_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart'
    show SmartMeterValidationResult;
import '../../utils/meter_validation.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

/// Single-page electricity purchase — the streamlined "one page, very fast"
/// flow (mirror of AirtimeQuickBuy). Enter the meter number → the disco +
/// customer name AUTO-RESOLVE via [ElectricityBillCubit.smartValidateMeter]
/// (no separate disco picker) → amount inline → inline confirmation → the
/// shared TX-PIN sheet ALSO runs the purchase → receipt (which shows the
/// prepaid token / sync=complete / async=initiated). No meter-input / confirm /
/// processing screens. Reuses [ElectricityBillCubit.initiatePaymentWithToken]
/// unchanged, so the admin provider-attempt audit + sync/async reconciliation
/// are preserved. Beneficiaries / auto-recharge / reminders stay on the tiles.
class ElectricityQuickBuy extends StatefulWidget {
  const ElectricityQuickBuy({super.key, this.initialMeterNumber});

  /// Pre-fills the meter field (e.g. from a "Pay Now" tap on a reminder
  /// linked to a saved meter) so the user doesn't have to retype it. Setting
  /// this on the controller re-uses the existing debounce + smart-validate
  /// path — no separate validation call needed.
  final String? initialMeterNumber;

  @override
  State<ElectricityQuickBuy> createState() => _ElectricityQuickBuyState();
}

class _ElectricityQuickBuyState extends State<ElectricityQuickBuy>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _currency = 'NGN';
  static const _quickAmounts = <int>[1000, 2000, 5000, 10000, 20000];

  final _meterController = TextEditingController();
  final _amountController = TextEditingController();
  final _phoneController = TextEditingController();

  SmartMeterValidationResult? _meter;
  bool _validating = false;
  String? _validateError;
  double? _amount;
  bool _submitting = false;
  Timer? _debounce;
  StreamSubscription<ElectricityBillState>? _sub;

  // ── Inline auto-recharge — captured from BillAutoRechargeCreateSheet.
  // Threaded into the receipt args (same shape the old confirmation screen
  // used); the receipt fires the real createAutoRecharge post-success,
  // resolving the beneficiary from the saved meter list.
  bool _autoEnabled = false;
  String? _autoSummary;
  ElectricityRolloverPreference? _autoPref;

  // ── Save-meter toggle — explicit "save this meter as a beneficiary" in the
  // streamlined flow (the receipt otherwise only saves silently when
  // auto-recharge is on). Turning it ON opens a nickname dialog; the save runs
  // post-purchase via the existing SaveBeneficiary RPC with that nickname.
  bool _saveMeter = false;
  String? _saveNickname;

  // ── Saved-meter dedup — loaded once, matched against the typed meter so an
  // already-saved meter shows a passive "already saved" row instead of the
  // toggle (a meter can't be saved as a beneficiary twice).
  List<BillBeneficiaryEntity> _beneficiaries = const [];
  BillBeneficiaryEntity? _existingBeneficiary;

  // ── Manual disco fallback ──────────────────────────────────────────────────
  // When the meter number can't auto-resolve its disco (smartValidate failed),
  // the user picks the disco themselves and we validate against it directly.
  final ValueNotifier<BillListFetchState<ElectricityProviderEntity>>
      _discoState =
      ValueNotifier(const BillListFetchState<ElectricityProviderEntity>.idle());
  List<ElectricityProviderEntity> _providers = const [];
  // True while a getProviders() fetch is in flight FOR THE DISCO PICKER. Scopes
  // the shared ElectricityBillError to this fetch so a payment-path error never
  // hijacks the disco picker into a failed state (and, conversely, so a
  // providers-load failure resolves the picker's spinner into a retry).
  bool _fetchingProviders = false;
  ElectricityProviderEntity? _manualDisco;
  MeterType _manualType = MeterType.prepaid;
  // True once a manual (provider-scoped) validation ran but the provider
  // couldn't confirm the customer name — we let the user proceed anyway
  // (many prepaid meters accept payment without a name lookup).
  bool _manualUnverified = false;
  bool get _manualMode => _manualDisco != null;

  @override
  void initState() {
    super.initState();
    _sub = context.read<ElectricityBillCubit>().stream.listen((s) {
      if (!mounted) return;
      if (s is SmartMeterValidated) {
        setState(() {
          _meter = s.result.isValid ? s.result : null;
          _validateError = s.result.isValid ? null : s.result.message;
          _validating = false;
        });
        // Provider now resolved — re-run the dedup probe with the disco scoped.
        _recomputeExistingBeneficiary();
      } else if (s is SmartMeterValidationFailed) {
        // Auto-detect couldn't resolve the disco — fall back to manual pick.
        setState(() {
          _meter = null;
          _validateError = s.message;
          _validating = false;
        });
      } else if (s is SmartMeterValidating) {
        setState(() => _validating = true);
      } else if (s is MeterValidating) {
        setState(() => _validating = true);
      } else if (s is MeterValidated) {
        // Manual (provider-scoped) validation resolved the customer — promote it
        // into the same `_meter` shape the rest of the flow uses.
        final v = s.validationResult;
        final disco = _manualDisco;
        setState(() {
          _validating = false;
          _manualUnverified = false;
          _meter = SmartMeterValidationResult(
            isValid: true,
            customerName: v.customerName,
            customerAddress: v.customerAddress,
            meterType: (v.meterType == MeterType.postpaid)
                ? 'postpaid'
                : 'prepaid',
            meterNumber: v.meterNumber,
            providerCode: s.providerCode,
            providerName: disco?.providerName ?? '',
            message: null,
            minAmount: disco?.minAmount ?? 0,
            maxAmount: disco?.maxAmount ?? 0,
            serviceFee: disco?.serviceFee ?? 0,
            fromCache: false,
          );
        });
        _recomputeExistingBeneficiary();
      } else if (s is MeterValidationFailed) {
        // Provider couldn't confirm the name — allow proceeding on the manual
        // disco (prepaid meters often can't be name-verified).
        setState(() {
          _validating = false;
          _manualUnverified = _manualMode;
          if (!_manualMode) _validateError = s.message;
        });
      } else if (s is ProvidersLoaded) {
        _fetchingProviders = false;
        _providers = s.providers.where((p) => p.isActive).toList();
        _discoState.value = BillListFetchState.loaded(_providers);
      } else if (s is ElectricityBillError && _fetchingProviders) {
        // A getProviders() fetch failed (e.g. offline). Resolve the disco
        // picker's spinner into a retry instead of spinning forever. Guarded by
        // _fetchingProviders so a payment-path error is never mis-routed here.
        _fetchingProviders = false;
        _discoState.value =
            BillListFetchState.failed(sanitizeUserFacingError(s.message));
      }
    });
    _meterController.addListener(_onMeterChanged);
    final initialMeter = widget.initialMeterNumber?.trim();
    if (initialMeter != null && initialMeter.isNotEmpty) {
      _meterController.text = initialMeter;
    }
    _prefillPhone();
    // Preload discos so the manual picker is instant if it's needed (cached).
    _fetchingProviders = true;
    context.read<ElectricityBillCubit>().getProviders();
    _loadSavedMeters();
  }

  /// Best-effort read of the user's saved meters so we can flag an
  /// already-saved meter and avoid a duplicate save.
  Future<void> _loadSavedMeters() async {
    try {
      final res =
          await context.read<ElectricityBillCubit>().repository.getBeneficiaries();
      if (!mounted) return;
      res.fold((_) {}, (list) {
        setState(() => _beneficiaries = list);
        _recomputeExistingBeneficiary();
      });
    } catch (_) {/* best-effort — dedup just won't pre-flag */}
  }

  /// Match the typed meter (digits-only) against saved meters. When the disco
  /// is known, also require the provider code to match so two discos sharing a
  /// meter number aren't conflated.
  void _recomputeExistingBeneficiary() {
    final typed =
        _effMeterNumber.replaceAll(RegExp(r'[^\d]'), '');
    final code = _effProviderCode;
    BillBeneficiaryEntity? found;
    if (typed.isNotEmpty) {
      for (final b in _beneficiaries) {
        final sameMeter =
            b.meterNumber.replaceAll(RegExp(r'[^\d]'), '') == typed;
        final sameProvider = code.isEmpty || b.providerCode == code;
        if (sameMeter && sameProvider) {
          found = b;
          break;
        }
      }
    }
    if (found?.id != _existingBeneficiary?.id) {
      setState(() => _existingBeneficiary = found);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _sub?.cancel();
    _discoState.dispose();
    _meterController.dispose();
    _amountController.dispose();
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
      }
    } catch (_) {/* best-effort */}
  }

  void _onMeterChanged() {
    _debounce?.cancel();
    final meter = _meterController.text.trim();
    if (_meter != null ||
        _validateError != null ||
        _manualDisco != null ||
        _manualUnverified) {
      setState(() {
        _meter = null;
        _validateError = null;
        _manualDisco = null;
        _manualUnverified = false;
      });
    }
    _recomputeExistingBeneficiary();
    if (meter.length < 10) return;
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ElectricityBillCubit>().smartValidateMeter(meterNumber: meter);
    });
  }

  // When a disco is picked manually, validate the meter against THAT provider.
  void _validateManual() {
    final disco = _manualDisco;
    final meter = _meterController.text.trim();
    if (disco == null || meter.length < 10) return;
    setState(() {
      _validating = true;
      _manualUnverified = false;
      _validateError = null;
    });
    context.read<ElectricityBillCubit>().validateMeter(
          providerCode: disco.providerCode,
          meterNumber: meter,
          meterType: _manualType,
        );
  }

  bool get _amountValid {
    final a = _amount ?? 0;
    if (a <= 0) return false;
    final m = _meter;
    if (m != null) {
      if (m.minAmount > 0 && a < m.minAmount) return false;
      if (m.maxAmount > 0 && a > m.maxAmount) return false;
    }
    return true;
  }

  bool get _phoneValid =>
      RegExp(r'^0\d{10}$').hasMatch(_phoneController.text.trim());

  // A payable target exists when the meter was verified (auto OR manual), or the
  // user picked a disco manually and chose to proceed without name verification.
  bool get _hasTarget =>
      _meter != null || (_manualMode && _manualUnverified);
  bool get _ready => _hasTarget && _amountValid && _phoneValid;

  MeterType get _meterType => _meter != null
      ? ((_meter!.meterType.toLowerCase() == 'postpaid')
          ? MeterType.postpaid
          : MeterType.prepaid)
      : _manualType;

  // Effective payment target — resolves from the verified `_meter` when present,
  // else from the manually-picked disco (unverified proceed path).
  String get _effProviderCode =>
      _meter?.providerCode ?? _manualDisco?.providerCode ?? '';
  String get _effProviderName =>
      _meter?.providerName ?? _manualDisco?.providerName ?? '';
  String get _effMeterNumber =>
      _meter?.meterNumber ?? _meterController.text.trim();

  // Provider DB id (distinct from the provider CODE) for the effective disco —
  // required to save a beneficiary. Matches the loaded provider list by code,
  // falling back to the manually-picked disco. Empty when unresolved, in which
  // case auto-recharge degrades gracefully to the "save on next purchase" notice.
  String _resolveBeneficiaryProviderId(String providerCode) {
    for (final p in _providers) {
      if (p.providerCode == providerCode) return p.id;
    }
    return _manualDisco?.id ?? '';
  }

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
    final cubit = context.read<ElectricityBillCubit>();
    final amount = _amount!;
    final phone = _phoneController.text.trim();
    final providerCode = _effProviderCode;
    final providerName = _effProviderName;
    final meterNumber = _effMeterNumber;
    final customerName = _meter?.customerName ?? '';
    final meterTypeStr =
        _meterType == MeterType.postpaid ? 'postpaid' : 'prepaid';
    // Provider DB id (needed to save a beneficiary) resolved from the loaded
    // provider list — threaded so auto-recharge can silently upsert a
    // beneficiary for a brand-new meter (the streamlined flow has no explicit
    // "save beneficiary" step).
    final beneficiaryProviderId = _resolveBeneficiaryProviderId(providerCode);
    final accountId = serviceLocator<AccountManager>().activeAccountId ?? '';
    final txnId =
        'electricity_${DateTime.now().millisecondsSinceEpoch}_$meterNumber';

    Object? result;
    setState(() => _submitting = true);
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'electricity_purchase',
        amount: amount,
        currency: _currency,
        title: 'Confirm electricity',
        message:
            'Pay $_currency ${amount.toStringAsFixed(0)} to $providerName for meter $meterNumber',
        showProcessingPhase: true,
        successMessage: 'Electricity request sent',
        onPinValidated: (token) async {
          final completer = Completer<Object>();
          late final StreamSubscription<ElectricityBillState> sub;
          sub = cubit.stream.listen((state) {
            if (completer.isCompleted) return;
            if (state is PaymentSuccess) {
              completer.complete(state.payment as Object);
            } else if (state is AsyncPaymentPending) {
              completer.complete(state.payment as Object);
            } else if (state is ElectricityBillError) {
              completer.completeError(state.message);
            }
          });
          try {
            cubit.initiatePaymentWithToken(
              providerCode: providerCode,
              meterNumber: meterNumber,
              meterType: _meterType,
              amount: amount,
              currency: _currency,
              accountId: accountId,
              phoneNumber: phone,
              transactionId: txnId,
              verificationToken: token,
            );
            result = await completer.future.timeout(const Duration(seconds: 90));
          } finally {
            await sub.cancel();
          }
        },
      );

      // Explicit "Save this meter" — persist the beneficiary via the existing
      // SaveBeneficiary RPC (no PIN) with the nickname the user entered. Skipped
      // when the meter is already saved (dedup). Best-effort: a failure (incl. a
      // duplicate the probe missed) must never block the receipt. Auto-recharge's
      // own save path on the receipt is independent and still runs when enabled.
      if (ok &&
          result != null &&
          _saveMeter &&
          _existingBeneficiary == null &&
          beneficiaryProviderId.isNotEmpty) {
        final nickname = (_saveNickname?.isNotEmpty ?? false)
            ? _saveNickname!
            : (customerName.isNotEmpty ? customerName : meterNumber);
        try {
          await cubit.repository.saveBeneficiary(
            providerId: beneficiaryProviderId,
            meterNumber: meterNumber,
            meterType: _meterType,
            customerName: customerName,
            phoneNumber: phone,
            nickname: nickname,
            providerCode: providerCode,
            providerName: providerName,
          );
        } catch (_) {/* best-effort — duplicate/already-saved is fine */}
      }

      if (!mounted) return;
      if (ok && result != null) {
        final wantsAuto = _autoEnabled && _autoPref != null;
        Get.toNamed(AppRoutes.electricityBillReceipt, arguments: {
          'payment': result,
          // Auto-recharge hand-off — the receipt fires the real
          // createAutoRecharge once the payment lands completed, resolving
          // the beneficiary from the saved meter list for this disco.
          'autoRechargeEnabled': wantsAuto,
          if (wantsAuto) 'autoRechargePref': _autoPref,
          // Beneficiary-save hand-off: a brand-new meter has no saved
          // beneficiary, but auto-recharge needs one to attach to. Thread the
          // data the receipt needs to silently upsert one (mirrors the cable-TV
          // receipt). The resolved provider DB id lets the save succeed even
          // when the payment row carries an empty providerId.
          if (wantsAuto && beneficiaryProviderId.isNotEmpty) ...{
            'beneficiaryProviderId': beneficiaryProviderId,
            'beneficiaryMeterType': meterTypeStr,
            'beneficiaryCustomerName': customerName,
            'beneficiaryNickname':
                customerName.isNotEmpty ? customerName : meterNumber,
            'beneficiaryProviderCode': providerCode,
            'beneficiaryProviderName': providerName,
            'beneficiaryPhone': phone,
          },
        });
      }
    } catch (_) {
      // Failure surfaces on the PIN sheet's failed beat.
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  // ── Inline auto-recharge ─────────────────────────────────────────────────────
  Future<void> _onToggleAuto(bool value) async {
    if (!value) {
      setState(() {
        _autoEnabled = false;
        _autoSummary = null;
        _autoPref = null;
      });
      return;
    }
    await _openAutoRechargeSheet();
  }

  Future<void> _openAutoRechargeSheet() async {
    if (!_hasTarget) return;
    final m = _meter;
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '$_effProviderName · meter $_effMeterNumber',
      title: 'Auto-recharge schedule',
      ctaLabel: 'Save schedule',
      successMessage: 'Schedule saved',
      initialAmount: _amount,
      minAmount: (m != null && m.minAmount > 0) ? m.minAmount : 50,
      maxAmount: (m != null && m.maxAmount > 0) ? m.maxAmount : null,
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
          // ElectricityRolloverPreference uses dayOfWeek 1-7 (Mon..Sun) —
          // the same convention BillAutoRechargeCreateSheet emits.
          _autoPref = ElectricityRolloverPreference(
            frequency: frequency,
            dayOfWeek: dayOfWeek,
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

  /// Save-meter control. When the meter is already saved it renders a passive
  /// "already saved" row (no duplicate). Otherwise a switch that opens a
  /// nickname dialog on ON; the save runs post-purchase with that nickname.
  Widget _saveMeterCard() {
    if (_existingBeneficiary != null) {
      final b = _existingBeneficiary!;
      return SavedBeneficiaryInfoRow(
        title: 'Meter already saved',
        subtitle: 'Saved as "${b.displayName}"',
      );
    }
    return SaveBeneficiaryToggleRow(
      accent: _accent,
      icon: Icons.bookmark_add_outlined,
      title: 'Save this meter',
      subtitle: _saveMeter && (_saveNickname?.isNotEmpty ?? false)
          ? 'Nickname: ${_saveNickname!}'
          : 'Save it as a beneficiary for faster payments next time',
      value: _saveMeter,
      onChanged: _onToggleSaveMeter,
    );
  }

  Future<void> _onToggleSaveMeter(bool value) async {
    if (!value) {
      setState(() {
        _saveMeter = false;
        _saveNickname = null;
      });
      return;
    }
    final customer = _meter?.customerName ?? '';
    final nickname = await promptBeneficiaryNickname(
      context,
      accent: _accent,
      title: 'Save this meter',
      prompt: 'Give this meter a nickname so you can find it fast next time.',
      hint: 'e.g. Home, Shop, Mum',
      initial: _saveNickname ?? customer,
    );
    if (nickname == null || nickname.trim().isEmpty) {
      if (mounted) setState(() => _saveMeter = false);
      return;
    }
    setState(() {
      _saveMeter = true;
      _saveNickname = nickname.trim();
    });
  }

  Widget _autoRechargeCard() {
    final on = _autoEnabled && _autoPref != null;
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
                Text('Auto-recharge',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text(on ? _autoSummary! : 'Top up this meter on a schedule',
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.sp)),
              ],
            ),
          ),
          Switch.adaptive(
            value: _autoEnabled,
            onChanged: _onToggleAuto,
            activeThumbColor: const Color(0xFFA78BFA),
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
        _label('Meter number'),
        SizedBox(height: 8.h),
        _meterField(),
        SizedBox(height: 8.h),
        _meterStatusRow(),
        SizedBox(height: 20.h),
        _label('Amount'),
        SizedBox(height: 8.h),
        _amountChips(),
        SizedBox(height: 10.h),
        _amountField(),
        SizedBox(height: 20.h),
        _label('Phone number (for token & receipt)'),
        SizedBox(height: 8.h),
        _phoneField(),
        if (_ready) ...[
          SizedBox(height: 20.h),
          _confirmationCard(),
          SizedBox(height: 12.h),
          _saveMeterCard(),
          SizedBox(height: 12.h),
          _autoRechargeCard(),
        ],
        SizedBox(height: 16.h),
        _payButton(),
      ],
    );
  }

  Widget _label(String t) => Text(t,
      style: GoogleFonts.inter(
          color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600));

  Widget _meterField() => _boxedField(
        controller: _meterController,
        hint: 'Enter meter number',
        icon: Icons.electric_meter,
        keyboard: TextInputType.number,
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(kMeterNumberMaxLen),
        ],
      );

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

  Widget _phoneField() => _boxedField(
        controller: _phoneController,
        hint: '0803 000 0000',
        icon: Icons.phone_iphone,
        keyboard: TextInputType.phone,
        formatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        leading: _dialCodePrefix(),
      );

  Widget _boxedField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboard,
    List<TextInputFormatter>? formatters,
    ValueChanged<String>? onChanged,
    String? prefixText,
    Widget? leading,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        inputFormatters: formatters,
        onChanged: onChanged,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
          prefixIcon: leading ?? Icon(icon, color: _muted, size: 20.sp),
          prefixIconConstraints: leading != null
              ? const BoxConstraints(minWidth: 0, minHeight: 0)
              : null,
          prefixText: prefixText,
          prefixStyle: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        ),
      ),
    );
  }

  Widget _meterStatusRow() {
    if (_validating) {
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Verifying meter…',
            style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
      ]);
    }
    final m = _meter;
    if (m != null) return _verifiedCard(m);
    if (_validateError != null || _manualMode) return _manualFallback();
    return const SizedBox.shrink();
  }

  Widget _verifiedCard(SmartMeterValidationResult m) {
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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(m.customerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 2.h),
            Text('${m.providerName} · ${_meterType.name}',
                style: GoogleFonts.inter(color: _muted, fontSize: 11.5.sp)),
          ]),
        ),
      ]),
    );
  }

  // Shown when the meter couldn't auto-resolve its disco: pick it manually.
  Widget _manualFallback() {
    final disco = _manualDisco;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (_validateError != null && disco == null) ...[
        Row(children: [
          Icon(Icons.info_outline,
              color: const Color(0xFFFB923C), size: 15.sp),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
                "We couldn't detect your disco automatically. Select it below.",
                style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C), fontSize: 12.sp)),
          ),
        ]),
        SizedBox(height: 10.h),
      ],
      GestureDetector(
        onTap: _openDiscoPicker,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: _border),
          ),
          child: Row(children: [
            if (disco != null)
              BillerLogo(
                  code: disco.providerCode,
                  name: disco.providerName,
                  logoUrl: disco.logoUrl,
                  brandColorHex: '#FBBF24',
                  size: 28,
                  borderRadius: 8)
            else
              Icon(Icons.bolt, color: _muted, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(disco?.providerName ?? 'Select your disco',
                  style: GoogleFonts.inter(
                      color: disco != null ? Colors.white : _muted,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500)),
            ),
            Icon(Icons.expand_more, color: _muted, size: 20.sp),
          ]),
        ),
      ),
      if (disco != null) ...[
        SizedBox(height: 12.h),
        _typeToggle(disco),
      ],
      if (_manualUnverified) ...[
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFB923C).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
            border:
                Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.35)),
          ),
          child: Row(children: [
            Icon(Icons.warning_amber_rounded,
                color: const Color(0xFFFB923C), size: 16.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                  "We couldn't confirm the customer name for this meter. "
                  'Double-check the meter number — you can still continue.',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontSize: 12.sp)),
            ),
          ]),
        ),
      ],
    ]);
  }

  Widget _typeToggle(ElectricityProviderEntity disco) {
    final options = <MeterType>[
      if (disco.supportsPrepaid) MeterType.prepaid,
      if (disco.supportsPostpaid) MeterType.postpaid,
    ];
    if (options.length <= 1) return const SizedBox.shrink();
    return Row(
      children: options.map((t) {
        final sel = _manualType == t;
        return Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: GestureDetector(
            onTap: () {
              if (_manualType == t) return;
              setState(() => _manualType = t);
              _validateManual();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: sel ? _accent : _card,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: sel ? _accent : _border),
              ),
              child: Text(t == MeterType.postpaid ? 'Postpaid' : 'Prepaid',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _openDiscoPicker() async {
    if (_providers.isEmpty) {
      _fetchingProviders = true;
      _discoState.value =
          const BillListFetchState<ElectricityProviderEntity>.loading();
      context.read<ElectricityBillCubit>().getProviders();
    } else {
      _discoState.value = BillListFetchState.loaded(_providers);
    }
    final picked = await showModalBottomSheet<ElectricityProviderEntity>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BillListPickerSheet<ElectricityProviderEntity>(
        title: 'Select your disco',
        icon: Icons.bolt,
        accent: _accent,
        listenable: _discoState,
        labelOf: (p) => p.providerName,
        trailingOf: (_) => '',
        leadingOf: (p) => BillerLogo(
            code: p.providerCode,
            name: p.providerName,
            logoUrl: p.logoUrl,
            brandColorHex: '#FBBF24',
            size: 34),
        emptyLabel: 'No discos available right now',
        onRetry: () {
          _fetchingProviders = true;
          _discoState.value =
              const BillListFetchState<ElectricityProviderEntity>.loading();
          context.read<ElectricityBillCubit>().getProviders();
        },
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        _manualDisco = picked;
        _meter = null;
        _manualUnverified = false;
        _manualType =
            picked.supportsPrepaid ? MeterType.prepaid : MeterType.postpaid;
      });
      _validateManual();
    }
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

  Widget _amountField() => _boxedField(
        controller: _amountController,
        hint: 'Enter amount',
        icon: Icons.bolt,
        keyboard: const TextInputType.numberWithOptions(decimal: false),
        formatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (v) => setState(() => _amount = double.tryParse(v.trim())),
      );

  Widget _confirmationCard() {
    final customer = _meter?.customerName ?? '';
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _border),
      ),
      child: Column(children: [
        _row('Customer', customer.isNotEmpty ? customer : 'Not verified'),
        SizedBox(height: 10.h),
        _row('Disco', _effProviderName),
        SizedBox(height: 10.h),
        _row('Meter', '$_effMeterNumber · ${_meterType.name}'),
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
                    ? 'Pay ₦${_amount!.toStringAsFixed(0)}'
                    : 'Pay electricity',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
