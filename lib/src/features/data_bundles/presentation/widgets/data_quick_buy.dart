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

import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/utils/ng_network_prefixes.dart';
import 'package:lazervault/core/widgets/bill_auto_recharge_create_sheet.dart';
import 'package:lazervault/core/widgets/network_logo.dart';
import 'package:lazervault/core/widgets/save_beneficiary_controls.dart';
import 'package:lazervault/src/features/bills/presentation/widgets/bill_list_picker_sheet.dart';

import '../widgets/rollover_preference_sheet.dart'
    show RolloverPreference, RolloverMode;
import '../cubit/data_bundles_cubit.dart';
import '../cubit/data_bundles_state.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../../utils/data_plan_validity.dart';
import '../../domain/entities/data_purchase_entity.dart';
import '../../domain/entities/data_beneficiary.dart';
import '../../data/datasources/data_beneficiary_remote_datasource.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

/// Single-page data-bundle purchase — the streamlined "one page, very fast"
/// flow (mirror of AirtimeQuickBuy). Phone prefilled from profile → network
/// AUTO-DETECTED from it → the available plans open in a STYLED bottom sheet →
/// inline confirmation → the shared TX-PIN sheet ALSO runs the purchase → the
/// receipt (which shows sync=complete / async=initiated). No network-select /
/// review / processing screens. Reuses [DataBundlesCubit.getDataPlans] +
/// [DataBundlesCubit.buyData] unchanged, so the admin provider-attempt audit +
/// sync/async reconciliation are preserved. The saved-contacts / auto-renew /
/// reminders flows stay reachable from the quick-action tiles above.
class DataQuickBuy extends StatefulWidget {
  const DataQuickBuy({super.key});

  @override
  State<DataQuickBuy> createState() => _DataQuickBuyState();
}

class _DataQuickBuyState extends State<DataQuickBuy> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _currency = 'NGN';

  static const Map<String, (String, int)> _netMeta = {
    'mtn-data': ('MTN', 0xFFFFCC00),
    'airtel-data': ('Airtel', 0xFFE40000),
    'glo-data': ('Glo', 0xFF00A651),
    'etisalat-data': ('9mobile', 0xFF006F45),
  };

  final _phoneController = TextEditingController();

  String? _networkCode;
  // True when the user picked the network from the manual pills (prefix couldn't
  // be auto-detected) — changes the row label from "auto-detected" to "selected".
  bool _networkManual = false;
  // Live plan-fetch state so the picker sheet updates itself as plans arrive /
  // fail, instead of freezing on the snapshot it opened with. `_fetchingPlans`
  // scopes a generic cubit error to THIS fetch (the cubit is shared with the
  // payment/history flows, which use their own states).
  final ValueNotifier<BillListFetchState<DataPlanEntity>> _planState =
      ValueNotifier(const BillListFetchState<DataPlanEntity>.idle());
  bool _fetchingPlans = false;
  DataPlanEntity? _plan;
  bool _saveContact = false;
  String? _saveNickname;
  bool _submitting = false;
  Timer? _detectDebounce;
  StreamSubscription<DataBundlesState>? _planSub;

  // ── Saved-contact dedup — loaded once, matched against the typed number so
  // an already-saved recipient shows a passive "already saved" row instead of
  // inviting a duplicate.
  List<DataBeneficiary> _beneficiaries = const [];
  DataBeneficiary? _existingBeneficiary;

  // ── Inline auto-renew — captured from BillAutoRechargeCreateSheet.
  // Threaded into the receipt args as a recurring-schedule RolloverPreference
  // (same shape the old confirmation screen used); the receipt fires the real
  // createAutoRecharge post-success. A saved beneficiary is required, so
  // enabling this forces the save-contact flag on.
  bool _autoEnabled = false;
  String? _autoSummary;
  RolloverPreference? _rolloverPref;

  @override
  void initState() {
    super.initState();
    // Capture plans as they load (the cubit is shared, so filter to the plans
    // state only — payment states are handled inline in _pay's completer).
    _planSub = context.read<DataBundlesCubit>().stream.listen((s) {
      if (!mounted) return;
      if (s is DataPlansLoaded) {
        _fetchingPlans = false;
        _planState.value = BillListFetchState.loaded(s.plans);
        setState(() {});
      } else if (s is DataBundlesError && _fetchingPlans) {
        // A generic error while a plans fetch is in flight = the fetch failed;
        // surface a retry in the sheet instead of a permanent empty/spinner.
        _fetchingPlans = false;
        _planState.value =
            BillListFetchState.failed(sanitizeUserFacingError(s.message));
      }
    });
    _phoneController.addListener(_onPhoneChanged);
    _prefillFromProfile();
    _loadSavedContacts();
  }

  /// Best-effort read of the user's saved data contacts so we can flag an
  /// already-saved recipient and avoid a duplicate save.
  Future<void> _loadSavedContacts() async {
    try {
      final list = await serviceLocator<DataBeneficiaryRemoteDataSource>()
          .getBeneficiaries();
      if (!mounted) return;
      setState(() => _beneficiaries = list);
      _recomputeExistingBeneficiary();
    } catch (_) {/* best-effort — dedup just won't pre-flag */}
  }

  /// Match the typed number (digits-only) against saved contacts.
  void _recomputeExistingBeneficiary() {
    final typed = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    DataBeneficiary? found;
    if (typed.isNotEmpty) {
      for (final b in _beneficiaries) {
        if (b.phoneNumber.replaceAll(RegExp(r'[^\d]'), '') == typed) {
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
    _detectDebounce?.cancel();
    _planSub?.cancel();
    _planState.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _prefillFromProfile() async {
    // A hand-off (reminder "top up", repeat purchase, beneficiary pick) may
    // navigate here with the recipient's number — that wins over the user's
    // own profile number.
    final args = Get.arguments;
    if (args is Map) {
      final v = args['phoneNumber'];
      final argPhone = _toLocalNg(v is String ? v : '');
      if (argPhone.isNotEmpty && _phoneController.text.isEmpty) {
        _phoneController.text = argPhone; // listener triggers detection
        return;
      }
    }
    try {
      final raw =
          await serviceLocator<FlutterSecureStorage>().read(key: 'stored_phone');
      final local = _toLocalNg(raw ?? '');
      if (local.isNotEmpty && mounted && _phoneController.text.isEmpty) {
        _phoneController.text = local;
      }
    } catch (_) {/* best-effort */}
  }

  String _toLocalNg(String input) {
    var d = input.replaceAll(RegExp(r'[^\d]'), '');
    if (d.startsWith('234')) d = d.substring(3);
    if (d.startsWith('0')) d = d.substring(1);
    return d.isEmpty ? '' : '0$d';
  }

  void _onPhoneChanged() {
    _recomputeExistingBeneficiary();
    _detectDebounce?.cancel();
    _detectDebounce = Timer(const Duration(milliseconds: 350), _detectAndLoad);
  }

  String? _detectNetworkCode(String phone) {
    // Shared canonical NCC prefix map (same source airtime uses), mapped to
    // the backend's data network code ("mtn" → "mtn-data").
    final ticker = NgNetworkPrefixes.detect(phone);
    return ticker == null ? null : '$ticker-data';
  }

  void _detectAndLoad() {
    final code = _detectNetworkCode(_phoneController.text.trim());
    // Keep a manual pick while the prefix stays undetectable — don't yank the
    // user's chosen network out from under them as they finish typing.
    if (code == null && _networkManual && _networkCode != null) return;
    if (code == _networkCode) return;
    setState(() {
      _networkCode = code;
      _networkManual = false; // auto-detection (or clear) supersedes a manual pick
      _plan = null; // network changed → drop the stale plan
    });
    if (code != null) {
      _fetchingPlans = true;
      _planState.value = const BillListFetchState<DataPlanEntity>.loading();
      context.read<DataBundlesCubit>().getDataPlans(network: code);
    } else {
      _fetchingPlans = false;
      _planState.value = const BillListFetchState<DataPlanEntity>.idle();
    }
  }

  /// The user tapped a network pill because the prefix couldn't be detected.
  void _selectNetworkManually(String code) {
    if (code == _networkCode) return;
    setState(() {
      _networkCode = code;
      _networkManual = true;
      _plan = null;
    });
    _fetchingPlans = true;
    _planState.value = const BillListFetchState<DataPlanEntity>.loading();
    context.read<DataBundlesCubit>().getDataPlans(network: code);
  }

  void _reloadPlans() {
    final code = _networkCode;
    if (code == null) return;
    _fetchingPlans = true;
    _planState.value = const BillListFetchState<DataPlanEntity>.loading();
    context.read<DataBundlesCubit>().getDataPlans(network: code);
  }

  bool get _phoneValid =>
      RegExp(r'^0\d{10}$').hasMatch(_phoneController.text.trim());
  bool get _ready => _phoneValid && _networkCode != null && _plan != null;

  String get _netName => _netMeta[_networkCode]?.$1 ?? 'Network';
  Color get _netColor => Color(_netMeta[_networkCode]?.$2 ?? 0xFF4E03D0);
  // `#RRGGBB` for the brand color, for NetworkLogo's fallback tile.
  String get _netHex =>
      '#${(_netMeta[_networkCode]?.$2 ?? 0xFF4E03D0).toRadixString(16).padLeft(8, '0').substring(2)}';

  // ── Styled plan bottom sheet ────────────────────────────────────────────────
  Future<void> _openPlanSheet() async {
    if (_networkCode == null) return;
    final picked = await showModalBottomSheet<DataPlanEntity>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BillListPickerSheet<DataPlanEntity>(
        title: '$_netName data plans',
        icon: Icons.sim_card,
        accent: _netColor,
        listenable: _planState,
        labelOf: (p) => p.name,
        trailingOf: (p) => '₦${p.price.toStringAsFixed(0)}',
        emptyLabel: 'No plans available for $_netName',
        onRetry: _reloadPlans,
        // Daily / Weekly / Monthly filter pills (parsed from the plan name).
        filters: [
          for (final d in DataPlanDuration.values)
            (label: d.label, test: (DataPlanEntity p) => matchesDuration(p, d)),
        ],
      ),
    );
    if (picked != null && mounted) setState(() => _plan = picked);
  }

  // ── Purchase (runs INSIDE the TX-PIN sheet's processing beat) ──────────────
  Future<void> _pay() async {
    if (!_ready || _submitting) return;
    FocusScope.of(context).unfocus();
    final cubit = context.read<DataBundlesCubit>();
    final plan = _plan!;
    final phone = _phoneController.text.trim();
    final code = _networkCode!;
    final txnId =
        'data_${DateTime.now().millisecondsSinceEpoch}_${phone.replaceAll(RegExp(r'[^\d]'), '')}';

    DataPurchaseEntity? result;
    setState(() => _submitting = true);
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'data_purchase',
        amount: plan.price,
        currency: _currency,
        title: 'Confirm data',
        message:
            'Buy ${plan.name} for $phone ($_netName) — $_currency ${plan.price.toStringAsFixed(0)}',
        showProcessingPhase: true,
        successMessage: 'Data request sent',
        onPinValidated: (token) async {
          final completer = Completer<DataPurchaseEntity>();
          late final StreamSubscription<DataBundlesState> sub;
          sub = cubit.stream.listen((state) {
            if (completer.isCompleted) return;
            if (state is DataBundlesPaymentSuccess) {
              completer.complete(state.purchase);
            } else if (state is DataBundlesPaymentFailed) {
              completer.completeError(state.message);
            }
          });
          try {
            cubit.buyData(
              phoneNumber: phone,
              network: code,
              variationId: plan.variationId,
              amount: plan.price,
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
        Get.toNamed(AppRoutes.dataBundlesPaymentReceipt, arguments: {
          'purchase': result,
          'networkName': _netName,
          'planName': plan.name,
          'network': code,
          // Auto-renew needs a saved beneficiary to attach to, so force the
          // save on when a schedule was requested and it isn't already saved.
          'saveBeneficiary': (_saveContact && !alreadySaved) || wantsAuto,
          if (_saveNickname != null) 'nickname': _saveNickname,
          // Already-saved recipient: hand the receipt the existing id so it
          // skips the duplicate save and still wires the auto-renew schedule.
          if (alreadySaved) 'existingBeneficiaryId': _existingBeneficiary!.id,
          'phoneNumber': phone,
          // Auto-renew hand-off — the receipt fires the real createAutoRecharge
          // once the purchase lands completed, for the recurring-schedule mode.
          if (wantsAuto) ...{
            'plan': plan,
            'rolloverPreference': _rolloverPref,
          },
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
    final plan = _plan;
    if (plan == null) return;
    final phone = _phoneController.text.trim();
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '$_netName · $phone',
      title: 'Auto-renew schedule',
      ctaLabel: 'Save schedule',
      successMessage: 'Schedule saved',
      // The recurring charge always buys the selected plan, so the amount
      // is the plan price (the receipt uses plan.price downstream).
      initialAmount: plan.price,
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
          _saveContact = true; // recurring schedule needs a saved beneficiary
          // RolloverPreference uses dayOfWeek 0-6 (Sun..Sat); the sheet emits
          // 1-7 (Mon..Sun) → map Sun(7)→0, Mon..Sat(1..6) stay.
          _rolloverPref = RolloverPreference(
            mode: RolloverMode.recurringSchedule,
            frequency: frequency,
            dayOfWeek: dayOfWeek % 7,
            dayOfMonth: dayOfMonth,
            executionHour: executionHour,
          );
          _autoSummary = _summarize(
            amount: plan.price,
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
                Text(on ? _autoSummary! : 'Buy this plan on a schedule',
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
    // Reflect the paying wallet so the flow reads complete (kept lightweight).
    serviceLocator<AccountManager>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label('Phone number'),
        SizedBox(height: 8.h),
        _phoneField(),
        SizedBox(height: 8.h),
        _networkRow(),
        SizedBox(height: 20.h),
        _label('Data plan'),
        SizedBox(height: 8.h),
        _planSelector(),
        if (_ready) ...[
          SizedBox(height: 20.h),
          _confirmationCard(),
          SizedBox(height: 12.h),
          _autoRechargeCard(),
        ],
        SizedBox(height: 14.h),
        _saveContactToggle(),
        SizedBox(height: 16.h),
        _payButton(),
      ],
    );
  }

  Widget _label(String t) => Text(t,
      style: GoogleFonts.inter(
          color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600));

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

  Widget _networkRow() {
    if (_networkCode == null) {
      if (!_phoneValid) {
        return _phoneController.text.isNotEmpty
            ? Text('Enter a valid 11-digit number',
                style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C), fontSize: 12.sp))
            : const SizedBox.shrink();
      }
      // Valid number but the prefix isn't a known network → let the user pick.
      return _networkPills();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _netColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: _netColor.withValues(alpha: 0.4)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        NetworkLogo(
          networkType: _networkCode ?? '',
          shortName: _netName,
          name: _netName,
          primaryColorHex: _netHex,
          size: 22,
          borderRadius: 6,
        ),
        SizedBox(width: 8.w),
        Text(_netName,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600)),
        SizedBox(width: 6.w),
        Text(_networkManual ? '· selected' : '· auto-detected',
            style: GoogleFonts.inter(color: _muted, fontSize: 11.sp)),
      ]),
    );
  }

  /// Tappable network chips shown when the phone prefix isn't a known network,
  /// so the user is never stuck with the plan selector + pay button disabled.
  Widget _networkPills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("We couldn't detect the network — pick one:",
            style: GoogleFonts.inter(
                color: const Color(0xFFFB923C), fontSize: 12.sp)),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _netMeta.keys.map(_networkPill).toList(),
        ),
      ],
    );
  }

  Widget _networkPill(String code) {
    final meta = _netMeta[code]!;
    final name = meta.$1;
    final color = Color(meta.$2);
    final hex =
        '#${meta.$2.toRadixString(16).padLeft(8, '0').substring(2)}';
    final selected = _networkCode == code;
    return GestureDetector(
      onTap: () => _selectNetworkManually(code),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: selected ? 0.22 : 0.10),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: color.withValues(alpha: selected ? 0.9 : 0.35),
              width: selected ? 1.5 : 1),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          NetworkLogo(
              networkType: code,
              shortName: name,
              name: name,
              primaryColorHex: hex,
              size: 20,
              borderRadius: 6),
          SizedBox(width: 6.w),
          Text(name,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }

  Widget _planSelector() {
    final enabled = _networkCode != null;
    return GestureDetector(
      onTap: enabled ? _openPlanSheet : null,
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
              _plan?.name ??
                  (enabled ? 'Select a data plan' : 'Enter a number first'),
              style: GoogleFonts.inter(
                color: _plan != null ? Colors.white : const Color(0xFF6B7280),
                fontSize: 15.sp,
                fontWeight: _plan != null ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          if (_plan != null)
            Text('₦${_plan!.price.toStringAsFixed(0)}',
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

  Widget _confirmationCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _border),
      ),
      child: Column(children: [
        _row('Recipient', _phoneController.text.trim()),
        SizedBox(height: 10.h),
        _row('Network', _netName),
        SizedBox(height: 10.h),
        _row('Plan', _plan!.name),
        SizedBox(height: 10.h),
        Divider(color: _border, height: 1),
        SizedBox(height: 10.h),
        _row('You pay', '₦${_plan!.price.toStringAsFixed(0)}',
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

  /// Save-as-contact control. Renders a passive "already saved" row when the
  /// number is already saved (no duplicate); otherwise a switch that opens a
  /// nickname dialog on ON. The save runs post-purchase on the receipt.
  Widget _saveContactToggle() {
    if (_existingBeneficiary != null) {
      final b = _existingBeneficiary!;
      return SavedBeneficiaryInfoRow(
        title: 'Contact already saved',
        subtitle: 'Saved as "${b.nickname ?? b.phoneNumber}"',
      );
    }
    return SaveBeneficiaryToggleRow(
      accent: _accent,
      title: 'Save as contact',
      subtitle: _saveContact && (_saveNickname?.isNotEmpty ?? false)
          ? 'Nickname: ${_saveNickname!}'
          : 'Quick top-up this number next time',
      value: _saveContact,
      onChanged: _onToggleSaveContact,
    );
  }

  Future<void> _onToggleSaveContact(bool value) async {
    if (!value) {
      setState(() {
        _saveContact = false;
        _saveNickname = null;
      });
      return;
    }
    final nickname = await promptBeneficiaryNickname(
      context,
      accent: _accent,
      title: 'Save this contact',
      prompt: 'Give this number a nickname so you can find it fast next time.',
      hint: 'e.g. Mum, Brother, Office',
      initial: _saveNickname ?? '',
    );
    if (nickname == null || nickname.trim().isEmpty) {
      if (mounted) setState(() => _saveContact = false);
      return;
    }
    setState(() {
      _saveContact = true;
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
                _plan != null
                    ? 'Buy ${_plan!.name}'
                    : 'Buy data',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
