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
import 'package:lazervault/core/widgets/biller_logo.dart';
import 'package:lazervault/core/widgets/bill_auto_recharge_create_sheet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/widgets/save_beneficiary_controls.dart';
import 'package:lazervault/src/features/bills/presentation/widgets/bill_list_picker_sheet.dart';
import '../widgets/cable_tv_rollover_preference_sheet.dart'
    show CableTVRolloverPreference;

import '../cubit/cable_tv_cubit.dart';
import '../cubit/cable_tv_state.dart';
import '../../domain/entities/cable_tv_provider_entity.dart';
import '../../domain/entities/tv_package_entity.dart';
import '../../domain/entities/cable_tv_payment_entity.dart';
import '../../domain/entities/cable_tv_beneficiary.dart';
import '../../domain/entities/smart_card_validation_entity.dart';
import '../../data/datasources/cable_tv_beneficiary_remote_datasource.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

/// Single-page cable-TV subscription — the streamlined "one page, very fast"
/// flow (mirror of ElectricityQuickBuy). Pick provider (DSTV/GOtv/Startimes) →
/// enter smart-card → the customer AUTO-VALIDATES + the bouquets load → pick a
/// package in a STYLED bottom sheet → inline confirmation → the shared TX-PIN
/// sheet ALSO runs the payment → receipt. No smart-card-input / package-select /
/// confirm / processing screens. Reuses [CableTVCubit] unchanged, so the admin
/// provider-attempt audit + sync/async reconciliation are preserved. The
/// Beneficiaries / Auto-Recharge / Reminders flows stay on the tiles.
class CableTVQuickBuy extends StatefulWidget {
  const CableTVQuickBuy({super.key});

  @override
  State<CableTVQuickBuy> createState() => _CableTVQuickBuyState();
}

class _CableTVQuickBuyState extends State<CableTVQuickBuy>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _currency = 'NGN';

  final _cardController = TextEditingController();
  final _phoneController = TextEditingController();

  List<CableTVProviderEntity> _providers = const [];
  // Set when the initial provider fetch fails so the chips row can offer an
  // inline retry instead of spinning on "Loading providers…" forever.
  String? _providersError;
  CableTVProviderEntity? _provider;
  SmartCardValidationEntity? _validation;
  bool _validating = false;
  String? _validateError;
  // Live package-fetch state so the picker sheet updates itself as packages
  // arrive / fail, instead of freezing on the snapshot it opened with.
  // `_fetchingPackages` scopes a generic cubit error to THIS fetch (the cubit
  // is shared with the validation/payment/history flows).
  final ValueNotifier<BillListFetchState<TVPackageEntity>> _packageState =
      ValueNotifier(const BillListFetchState<TVPackageEntity>.idle());
  bool _fetchingPackages = false;
  TVPackageEntity? _package;
  bool _submitting = false;
  Timer? _debounce;
  StreamSubscription<CableTVState>? _sub;

  // ── Inline auto-renew — captured from BillAutoRechargeCreateSheet.
  // Threaded into the receipt args (same shape the old confirmation screen
  // used); the receipt fires the real createAutoRecharge post-success,
  // upserting the smart-card beneficiary the schedule attaches to.
  bool _autoEnabled = false;
  String? _autoSummary;
  CableTVRolloverPreference? _rolloverPref;

  // ── Save-beneficiary dedup — loaded once, matched against the typed smart
  // card so an already-saved card shows a passive "already saved" row instead
  // of inviting a duplicate. The save itself runs post-payment on the receipt.
  bool _saveBeneficiary = false;
  String? _saveNickname;
  List<CableTVBeneficiary> _beneficiaries = const [];
  CableTVBeneficiary? _existingBeneficiary;

  @override
  void initState() {
    super.initState();
    _sub = context.read<CableTVCubit>().stream.listen(_onState);
    context.read<CableTVCubit>().getProviders();
    _cardController.addListener(_onCardChanged);
    _prefillPhone();
    _loadSavedBeneficiaries();
  }

  /// Best-effort read of the user's saved smart cards so we can flag an
  /// already-saved card and avoid a duplicate save.
  Future<void> _loadSavedBeneficiaries() async {
    try {
      final list = await serviceLocator<CableTVBeneficiaryRemoteDataSource>()
          .getBeneficiaries();
      if (!mounted) return;
      setState(() => _beneficiaries = list);
      _recomputeExistingBeneficiary();
    } catch (_) {/* best-effort — dedup just won't pre-flag */}
  }

  /// Match the typed smart card (digits-only) against saved cards. When the
  /// provider is known, scope the match to that provider so the same card on a
  /// different provider isn't treated as already saved.
  void _recomputeExistingBeneficiary() {
    final typed = _cardController.text.replaceAll(RegExp(r'[^\d]'), '');
    final providerCode = _provider?.serviceId.toLowerCase() ?? '';
    CableTVBeneficiary? found;
    if (typed.isNotEmpty) {
      for (final b in _beneficiaries) {
        if (b.smartCardNumber.replaceAll(RegExp(r'[^\d]'), '') != typed) {
          continue;
        }
        if (providerCode.isNotEmpty &&
            b.providerCode.toLowerCase() != providerCode) {
          continue;
        }
        found = b;
        break;
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
    _packageState.dispose();
    _cardController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onState(CableTVState s) {
    if (!mounted) return;
    if (s is CableTVProvidersLoaded) {
      setState(() {
        _providers = s.providers;
        _providersError = null;
      });
    } else if (s is SmartCardValidating) {
      setState(() => _validating = true);
    } else if (s is SmartCardValidated) {
      setState(() {
        _validation = s.validation.isValid ? s.validation : null;
        _validateError = s.validation.isValid ? null : 'Smart card not found';
        _validating = false;
      });
    } else if (s is SmartCardValidationFailed) {
      setState(() {
        _validation = null;
        _validateError = s.message;
        _validating = false;
      });
    } else if (s is TVPackagesLoaded) {
      _fetchingPackages = false;
      _packageState.value = BillListFetchState.loaded(s.packages);
      setState(() {});
    } else if (s is CableTVError && _fetchingPackages) {
      // A generic error while a packages fetch is in flight = the fetch failed;
      // surface a retry in the sheet instead of a permanent empty/spinner.
      _fetchingPackages = false;
      _packageState.value =
          BillListFetchState.failed(sanitizeUserFacingError(s.message));
    } else if (s is CableTVError && _providers.isEmpty) {
      // Providers never loaded — surface an inline retry instead of leaving
      // the chips row spinning on "Loading providers…" forever.
      setState(() => _providersError = sanitizeUserFacingError(s.message));
    }
  }

  void _reloadProviders() {
    setState(() => _providersError = null);
    context.read<CableTVCubit>().getProviders();
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

  void _selectProvider(CableTVProviderEntity p) {
    setState(() {
      _provider = p;
      _validation = null;
      _validateError = null;
      _package = null;
      // Changing provider invalidates the package the schedule was priced
      // from, so drop any pending auto-renew instead of carrying it over.
      _clearPendingAutoRenew();
    });
    _fetchingPackages = true;
    _packageState.value = const BillListFetchState<TVPackageEntity>.loading();
    context.read<CableTVCubit>().getPackages(providerId: p.id);
    _recomputeExistingBeneficiary();
    if (_cardController.text.trim().length >= 8) _validateCard();
  }

  void _reloadPackages() {
    final p = _provider;
    if (p == null) return;
    _fetchingPackages = true;
    _packageState.value = const BillListFetchState<TVPackageEntity>.loading();
    context.read<CableTVCubit>().getPackages(providerId: p.id);
  }

  void _onCardChanged() {
    _debounce?.cancel();
    _recomputeExistingBeneficiary();
    if (_validation != null || _validateError != null) {
      setState(() {
        _validation = null;
        _validateError = null;
      });
    }
    if (_provider == null || _cardController.text.trim().length < 8) return;
    _debounce = Timer(const Duration(milliseconds: 500), _validateCard);
  }

  void _validateCard() {
    final p = _provider;
    if (p == null) return;
    context.read<CableTVCubit>().validateSmartCard(
          providerId: p.id,
          smartCardNumber: _cardController.text.trim(),
        );
  }

  bool get _phoneValid =>
      RegExp(r'^0\d{10}$').hasMatch(_phoneController.text.trim());
  bool get _ready =>
      _provider != null && _validation != null && _package != null && _phoneValid;

  Future<void> _openPackageSheet() async {
    if (_provider == null) return;
    final picked = await showModalBottomSheet<TVPackageEntity>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BillListPickerSheet<TVPackageEntity>(
        title: '${_provider!.name} packages',
        icon: Icons.tv,
        accent: _accent,
        listenable: _packageState,
        labelOf: (p) => p.name,
        trailingOf: (p) => '₦${p.amount.toStringAsFixed(0)}',
        subtitleOf: (p) => p.validity,
        emptyLabel: 'No packages available',
        onRetry: _reloadPackages,
      ),
    );
    if (picked != null && mounted) {
      final changed = picked.id != _package?.id;
      setState(() {
        _package = picked;
        // A different package has a different price, so an already-armed
        // auto-renew must not inherit the previous package's amount.
        if (changed) _clearPendingAutoRenew();
      });
    }
  }

  // ── Purchase (runs INSIDE the TX-PIN sheet's processing beat) ──────────────
  Future<void> _pay() async {
    if (!_ready || _submitting) return;
    FocusScope.of(context).unfocus();
    final cubit = context.read<CableTVCubit>();
    final p = _provider!;
    final pkg = _package!;
    final card = _cardController.text.trim();
    final phone = _phoneController.text.trim();
    serviceLocator<AccountManager>();
    final txnId =
        'cabletv_${DateTime.now().millisecondsSinceEpoch}_$card';

    CableTVPaymentEntity? result;
    setState(() => _submitting = true);
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'cable_tv_purchase',
        amount: pkg.amount,
        currency: _currency,
        title: 'Confirm subscription',
        message:
            'Pay $_currency ${pkg.amount.toStringAsFixed(0)} for ${pkg.name} on ${p.name} (${_validation!.customerName})',
        showProcessingPhase: true,
        successMessage: 'Subscription request sent',
        onPinValidated: (token) async {
          final completer = Completer<CableTVPaymentEntity>();
          late final StreamSubscription<CableTVState> sub;
          sub = cubit.stream.listen((state) {
            if (completer.isCompleted) return;
            if (state is CableTVPaymentSuccess) {
              completer.complete(state.payment);
            } else if (state is CableTVPaymentFailed) {
              completer.completeError(state.message);
            }
          });
          try {
            cubit.paySubscription(
              providerId: p.id,
              smartCardNumber: card,
              variationCode: pkg.variationCode,
              amount: pkg.amount,
              phone: phone,
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
        Get.toNamed(AppRoutes.cableTVPaymentReceipt, arguments: {
          'payment': result,
          // Provider / package / smart-card are needed by BOTH the save-
          // beneficiary and the auto-renew hooks on the receipt, so forward
          // them whenever either is requested (not only for auto-renew).
          'provider': p,
          'package': pkg,
          'smartCardNumber': card,
          // Auto-renew needs a saved beneficiary to attach to, so force the
          // save on when a schedule was requested and it isn't already saved.
          'saveBeneficiary': (_saveBeneficiary && _existingBeneficiary == null) ||
              wantsAuto,
          if (_saveNickname != null) 'beneficiaryNickname': _saveNickname,
          // Already-saved card: hand the receipt the existing id so it skips
          // the duplicate save and still wires the auto-renew schedule.
          if (_existingBeneficiary != null)
            'existingBeneficiaryId': _existingBeneficiary!.id,
          // Auto-renew hand-off — the receipt fires the real
          // createAutoRecharge once the payment lands, upserting the
          // smart-card beneficiary the schedule attaches to.
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

  /// What the auto-renew schedule itself needs: a provider and a package to
  /// price it from. Deliberately NOT [_ready] — that also demands the
  /// smart-card validation RPC, which used to hide this card entirely while
  /// "Save this smart card" was visible, so the feature looked absent. The
  /// pay path still enforces [_ready], so nothing can be charged unvalidated.
  bool get _canScheduleAutoRenew => _provider != null && _package != null;

  /// Drops an un-submitted auto-renew selection. Safe inside `setState`.
  void _clearPendingAutoRenew() {
    _autoEnabled = false;
    _autoSummary = null;
    _rolloverPref = null;
  }

  Future<void> _onToggleAuto(bool value) async {
    if (!value) {
      setState(_clearPendingAutoRenew);
      return;
    }
    await _openAutoRechargeSheet();
  }

  Future<void> _openAutoRechargeSheet() async {
    final p = _provider;
    final pkg = _package;
    if (p == null || pkg == null) return;
    final card = _cardController.text.trim();
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '${p.name} · card $card',
      title: 'Auto-renew schedule',
      ctaLabel: 'Save schedule',
      successMessage: 'Schedule saved',
      initialAmount: pkg.amount,
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
          // CableTVRolloverPreference uses dayOfWeek 0-6 (Sun..Sat); the
          // sheet emits 1-7 (Mon..Sun) → map Sun(7)→0, Mon..Sat(1..6) stay.
          _rolloverPref = CableTVRolloverPreference(
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
    final canSchedule = _canScheduleAutoRenew;
    return Opacity(
      opacity: canSchedule ? 1 : 0.5,
      child: GestureDetector(
        onTap: (on && canSchedule) ? _openAutoRechargeSheet : null,
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
                  Text(
                    on
                        ? (_autoSummary ??
                            'Renew this subscription on a schedule')
                        : canSchedule
                            ? 'Renew this subscription on a schedule'
                            : 'Pick a package to set up auto-renew',
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: _autoEnabled,
              onChanged: canSchedule ? _onToggleAuto : null,
              activeThumbColor: const Color(0xFFA78BFA),
            ),
          ]),
        ),
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
        _label('Smart card / IUC number'),
        SizedBox(height: 8.h),
        _cardField(),
        SizedBox(height: 8.h),
        _cardStatusRow(),
        SizedBox(height: 20.h),
        _label('Package'),
        SizedBox(height: 8.h),
        _packageSelector(),
        SizedBox(height: 20.h),
        _label('Phone number (for receipt)'),
        SizedBox(height: 8.h),
        _phoneField(),
        if (_ready) ...[
          SizedBox(height: 20.h),
          _confirmationCard(),
        ],
        // Auto-renew sits OUTSIDE the `_ready` gate so it is discoverable as
        // soon as a package is picked, rather than waiting on the smart-card
        // validation RPC (see [_canScheduleAutoRenew]).
        SizedBox(height: 12.h),
        _autoRechargeCard(),
        SizedBox(height: 14.h),
        _saveBeneficiaryControl(),
        SizedBox(height: 16.h),
        _payButton(),
      ],
    );
  }

  /// Save-as-beneficiary control. Renders a passive "already saved" row when
  /// the smart card is already saved (no duplicate); otherwise a switch that
  /// opens a nickname dialog on ON. The save runs post-payment on the receipt.
  Widget _saveBeneficiaryControl() {
    if (_existingBeneficiary != null) {
      final b = _existingBeneficiary!;
      return SavedBeneficiaryInfoRow(
        title: 'Smart card already saved',
        subtitle: 'Saved as "${b.nickname ?? b.smartCardNumber}"',
      );
    }
    return SaveBeneficiaryToggleRow(
      accent: _accent,
      title: 'Save this smart card',
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
      title: 'Save this smart card',
      prompt: 'Give this smart card a nickname so you can find it fast next time.',
      hint: 'e.g. Home, Mum, Office',
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

  Widget _cardField() {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border),
      ),
      child: TextField(
        controller: _cardController,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(16),
        ],
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: _provider == null
              ? 'Select a provider first'
              : 'Enter smart card / IUC number',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
          prefixIcon: Icon(Icons.tv, color: _muted, size: 20.sp),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        ),
      ),
    );
  }

  Widget _cardStatusRow() {
    if (_validating) {
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Verifying card…',
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
                  (enabled ? 'Select a package' : 'Select a provider first'),
              style: GoogleFonts.inter(
                color: _package != null ? Colors.white : const Color(0xFF6B7280),
                fontSize: 15.sp,
                fontWeight: _package != null ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          if (_package != null)
            Text('₦${_package!.amount.toStringAsFixed(0)}',
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
        _row('Customer', _validation!.customerName),
        SizedBox(height: 10.h),
        _row('Provider', _provider!.name),
        SizedBox(height: 10.h),
        _row('Package', _package!.name),
        SizedBox(height: 10.h),
        Divider(color: _border, height: 1),
        SizedBox(height: 10.h),
        _row('You pay', '₦${_package!.amount.toStringAsFixed(0)}',
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
                _package != null
                    ? 'Pay ₦${_package!.amount.toStringAsFixed(0)}'
                    : 'Pay subscription',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
