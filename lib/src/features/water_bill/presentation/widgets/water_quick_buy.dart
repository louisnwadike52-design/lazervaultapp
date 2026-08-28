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
import 'package:lazervault/core/widgets/bill_auto_recharge_create_sheet.dart';
import 'package:lazervault/core/widgets/save_beneficiary_controls.dart';

import '../cubit/water_bill_cubit.dart';
import '../cubit/water_bill_state.dart';
import '../../domain/entities/water_provider_entity.dart';
import '../../domain/entities/water_payment_entity.dart';
import '../../domain/entities/water_beneficiary.dart';
import '../../domain/entities/customer_validation_result.dart';
import '../../data/datasources/water_beneficiary_remote_datasource.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

/// Single-page water-bill payment — streamlined "one page, very fast" flow
/// (mirror of ElectricityQuickBuy + provider chips). Pick provider (water
/// board) → enter customer number → the customer AUTO-VALIDATES → amount inline
/// → inline confirmation → the shared TX-PIN sheet ALSO runs the payment →
/// receipt. No customer-input / confirm / processing screens. Reuses
/// [WaterBillCubit] unchanged, so the admin provider-attempt audit + sync/async
/// reconciliation are preserved.
class WaterQuickBuy extends StatefulWidget {
  const WaterQuickBuy({super.key});

  @override
  State<WaterQuickBuy> createState() => _WaterQuickBuyState();
}

class _WaterQuickBuyState extends State<WaterQuickBuy> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _currency = 'NGN';
  static const _quickAmounts = <int>[1000, 2000, 5000, 10000, 20000];

  final _customerController = TextEditingController();
  final _amountController = TextEditingController();

  List<WaterProviderEntity> _providers = const [];
  // Non-null when the initial provider fetch failed — drives an inline
  // single-shot retry instead of an infinite "Loading water boards…" spinner.
  String? _providersError;
  WaterProviderEntity? _provider;
  CustomerValidationResult? _validation;
  bool _validating = false;
  String? _validateError;
  double? _amount;
  bool _submitting = false;
  Timer? _debounce;
  StreamSubscription<WaterBillState>? _sub;

  // ── Save-beneficiary dedup — loaded once, matched against the typed account
  // so an already-saved account shows a passive "already saved" row instead of
  // inviting a duplicate. Save runs post-payment on the receipt.
  bool _saveBeneficiary = false;
  String? _saveNickname;
  List<WaterBeneficiary> _beneficiaries = const [];
  WaterBeneficiary? _existingBeneficiary;

  // ── Inline auto-pay (recurring) — captured from BillAutoRechargeCreateSheet.
  // Threaded (flat) into the receipt args; the receipt fires the real
  // createAutoRecharge post-success (it upserts the beneficiary itself).
  bool _autoEnabled = false;
  String? _autoSummary;
  double? _rolloverAmount;
  String? _rolloverFrequency;
  int? _rolloverDayOfWeek;
  int? _rolloverDayOfMonth;
  int? _rolloverExecutionHour;
  int? _rolloverExecutionMinute;

  @override
  void initState() {
    super.initState();
    _sub = context.read<WaterBillCubit>().stream.listen(_onState);
    context.read<WaterBillCubit>().getProviders();
    _customerController.addListener(_onCustomerChanged);
    _loadSavedBeneficiaries();
  }

  /// Best-effort read of the user's saved water accounts so we can flag an
  /// already-saved account and avoid a duplicate save.
  Future<void> _loadSavedBeneficiaries() async {
    try {
      final list = await serviceLocator<WaterBeneficiaryRemoteDataSource>()
          .getBeneficiaries();
      if (!mounted) return;
      setState(() => _beneficiaries = list);
      _recomputeExistingBeneficiary();
    } catch (_) {/* best-effort — dedup just won't pre-flag */}
  }

  /// Match the typed account (digits-only) against saved accounts. When a
  /// water board is selected, also require the provider to match so the same
  /// account under a different board isn't mistaken for a duplicate.
  void _recomputeExistingBeneficiary() {
    final typed = _customerController.text.replaceAll(RegExp(r'[^\d]'), '');
    final providerCode = _provider?.providerCode ?? '';
    WaterBeneficiary? found;
    if (typed.isNotEmpty) {
      for (final b in _beneficiaries) {
        if (b.accountNumber.replaceAll(RegExp(r'[^\d]'), '') != typed) continue;
        if (providerCode.isNotEmpty &&
            b.providerCode.toUpperCase() != providerCode.toUpperCase()) {
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
    _customerController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _onState(WaterBillState s) {
    if (!mounted) return;
    if (s is ProvidersLoaded) {
      setState(() {
        _providers = s.providers;
        _providersError = null;
      });
    } else if (s is WaterBillError && _providers.isEmpty) {
      // Provider fetch failed on load — surface an inline retry rather than
      // spinning forever. (Payment-time errors are handled in the completer.)
      setState(() => _providersError = s.message);
    } else if (s is CustomerValidating) {
      setState(() => _validating = true);
    } else if (s is CustomerValidated) {
      setState(() {
        _validation = s.validationResult.isValid ? s.validationResult : null;
        _validateError = s.validationResult.isValid ? null : 'Customer not found';
        _validating = false;
      });
    } else if (s is CustomerValidationFailed) {
      setState(() {
        _validation = null;
        _validateError = s.message;
        _validating = false;
      });
    }
  }

  void _selectProvider(WaterProviderEntity p) {
    setState(() {
      _provider = p;
      _validation = null;
      _validateError = null;
      // A different provider has its own min/max bounds, so an armed
      // auto-pay amount may no longer be valid — clear it.
      _clearPendingAutoPay();
    });
    _recomputeExistingBeneficiary();
    if (_customerController.text.trim().length >= 4) _validateCustomer();
  }

  void _onCustomerChanged() {
    _recomputeExistingBeneficiary();
    _debounce?.cancel();
    if (_validation != null || _validateError != null) {
      setState(() {
        _validation = null;
        _validateError = null;
      });
    }
    if (_provider == null || _customerController.text.trim().length < 4) return;
    _debounce = Timer(const Duration(milliseconds: 500), _validateCustomer);
  }

  void _validateCustomer() {
    final p = _provider;
    if (p == null) return;
    context.read<WaterBillCubit>().validateCustomer(
          providerCode: p.providerCode,
          customerNumber: _customerController.text.trim(),
        );
  }

  bool get _amountValid {
    final a = _amount ?? 0;
    if (a <= 0) return false;
    final p = _provider;
    if (p != null) {
      if (p.minAmount > 0 && a < p.minAmount) return false;
      if (p.maxAmount > 0 && a > p.maxAmount) return false;
    }
    return true;
  }

  bool get _ready => _provider != null && _validation != null && _amountValid;

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
    final cubit = context.read<WaterBillCubit>();
    final p = _provider!;
    final amount = _amount!;
    final customer = _customerController.text.trim();
    final accountId = serviceLocator<AccountManager>().activeAccountId ?? '';
    final txnId = 'water_${DateTime.now().millisecondsSinceEpoch}_$customer';

    WaterPaymentEntity? result;
    setState(() => _submitting = true);
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'water_purchase',
        amount: amount,
        currency: _currency,
        title: 'Confirm water bill',
        message:
            'Pay $_currency ${amount.toStringAsFixed(0)} to ${p.providerName} for ${_validation!.customerName}',
        showProcessingPhase: true,
        successMessage: 'Water bill request sent',
        onPinValidated: (token) async {
          final completer = Completer<WaterPaymentEntity>();
          late final StreamSubscription<WaterBillState> sub;
          sub = cubit.stream.listen((state) {
            if (completer.isCompleted) return;
            if (state is PaymentSuccess) {
              completer.complete(state.payment);
            } else if (state is PaymentVerified) {
              // Webhook-pending / verified-but-not-yet-completed is a VALID
              // in-flight payment — route to the receipt (which renders the
              // "Payment Processing" state + reconciles), never a false fail.
              completer.complete(state.payment);
            } else if (state is PaymentProcessing && state.progress == 0.6) {
              // Terminal "still processing" emitted by verifyPayment after the
              // provider call (progress 0.6). The intermediate progress ticks
              // use 0.1/0.3/0.5/0.8, so this uniquely marks the settled state.
              completer.complete(state.payment);
            } else if (state is PaymentFailed) {
              completer.completeError('Payment failed. Please try again.');
            } else if (state is WaterBillError) {
              completer.completeError(state.message);
            }
          });
          try {
            cubit.initiatePayment(
              providerCode: p.providerCode,
              customerNumber: customer,
              amount: amount,
              currency: _currency,
              accountId: accountId,
              transactionId: txnId,
              verificationToken: token,
            );
            result = await completer.future.timeout(const Duration(seconds: 90));
          } finally {
            await sub.cancel();
          }
        },
      );

      if (!mounted) return;
      if (ok && result != null) {
        final wantsAuto = _autoEnabled && _rolloverAmount != null;
        final alreadySaved = _existingBeneficiary != null;
        Get.toNamed(AppRoutes.waterBillPaymentReceipt, arguments: {
          'payment': result,
          // Auto-pay needs a saved beneficiary to attach to, so force the save
          // on when a schedule was requested and it isn't already saved.
          'saveBeneficiary': (_saveBeneficiary && !alreadySaved) || wantsAuto,
          if (_saveNickname != null) 'beneficiaryNickname': _saveNickname,
          // Already-saved account: hand the receipt the existing id so it
          // skips the duplicate save and still wires the auto-pay schedule.
          if (alreadySaved) 'existingBeneficiaryId': _existingBeneficiary!.id,
          // Auto-pay hand-off — the receipt fires the real createAutoRecharge
          // once the payment lands completed (upserting the beneficiary).
          'autoPayEnabled': wantsAuto,
          if (wantsAuto) ...{
            'rolloverAmount': _rolloverAmount,
            'rolloverFrequency': _rolloverFrequency,
            'rolloverDayOfWeek': _rolloverDayOfWeek,
            'rolloverDayOfMonth': _rolloverDayOfMonth,
            'rolloverExecutionHour': _rolloverExecutionHour,
            'rolloverExecutionMinute': _rolloverExecutionMinute,
          },
        });
      }
    } catch (_) {
      // Failure surfaces on the PIN sheet's failed beat.
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  // ── Inline auto-pay ────────────────────────────────────────────────────────

  /// What the auto-pay schedule itself needs: just a provider (the amount and
  /// cadence are captured inside the sheet). Deliberately NOT [_ready], which
  /// also demands the customer-validation RPC — gating on that hid this card
  /// entirely while "Save this account" stayed visible, so the feature looked
  /// like it didn't exist. The pay path still enforces [_ready].
  bool get _canScheduleAutoPay => _provider != null;

  /// Drops an un-submitted auto-pay selection. Safe inside `setState`.
  void _clearPendingAutoPay() {
    _autoEnabled = false;
    _autoSummary = null;
    _rolloverAmount = null;
    _rolloverFrequency = null;
    _rolloverDayOfWeek = null;
    _rolloverDayOfMonth = null;
    _rolloverExecutionHour = null;
    _rolloverExecutionMinute = null;
  }

  Future<void> _onToggleAuto(bool value) async {
    if (!value) {
      setState(_clearPendingAutoPay);
      return;
    }
    await _openAutoRechargeSheet();
  }

  Future<void> _openAutoRechargeSheet() async {
    final p = _provider;
    if (p == null) return;
    final customer = _customerController.text.trim();
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '${p.providerName} · $customer',
      title: 'Auto-pay schedule',
      ctaLabel: 'Save schedule',
      successMessage: 'Schedule saved',
      initialAmount: _amount,
      minAmount: p.minAmount > 0 ? p.minAmount : 50,
      maxAmount: p.maxAmount > 0 ? p.maxAmount : null,
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
          _rolloverAmount = amount;
          _rolloverFrequency = frequency;
          _rolloverDayOfWeek = dayOfWeek;
          _rolloverDayOfMonth = dayOfMonth;
          _rolloverExecutionHour = executionHour;
          _rolloverExecutionMinute = executionMinute;
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
    final on = _autoEnabled && _rolloverAmount != null;
    final canSchedule = _canScheduleAutoPay;
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
                  Text('Auto-pay',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(
                    on
                        ? (_autoSummary ?? 'Pay this bill on a schedule')
                        : canSchedule
                            ? 'Pay this bill on a schedule'
                            : 'Pick a provider to set up auto-pay',
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
        _label('Water board'),
        SizedBox(height: 8.h),
        _providerChips(),
        SizedBox(height: 20.h),
        _label('Customer / account number'),
        SizedBox(height: 8.h),
        _customerField(),
        SizedBox(height: 8.h),
        _customerStatusRow(),
        SizedBox(height: 20.h),
        _label('Amount'),
        SizedBox(height: 8.h),
        _amountChips(),
        SizedBox(height: 10.h),
        _amountField(),
        if (_ready) ...[
          SizedBox(height: 20.h),
          _confirmationCard(),
        ],
        // Auto-pay sits OUTSIDE the `_ready` gate so it is discoverable
        // without waiting on the customer-validation RPC
        // (see [_canScheduleAutoPay]).
        SizedBox(height: 12.h),
        _autoRechargeCard(),
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
    if (_providers.isEmpty) {
      if (_providersError != null) {
        return Row(children: [
          Icon(Icons.error_outline, color: _muted, size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text("Couldn't load water boards",
                style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
          ),
          TextButton(
            onPressed: () {
              setState(() => _providersError = null);
              context.read<WaterBillCubit>().getProviders();
            },
            child: Text('Retry',
                style: GoogleFonts.inter(
                    color: _accent, fontSize: 12.sp, fontWeight: FontWeight.w600)),
          ),
        ]);
      }
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Loading water boards…',
            style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
      ]);
    }
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: _providers.map((p) {
        final selected = _provider?.providerCode == p.providerCode;
        return GestureDetector(
          onTap: () => _selectProvider(p),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: selected ? _accent : _card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: selected ? _accent : _border),
            ),
            child: Text(p.providerName,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600)),
          ),
        );
      }).toList(),
    );
  }

  Widget _customerField() {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border),
      ),
      child: TextField(
        controller: _customerController,
        keyboardType: TextInputType.text,
        inputFormatters: [LengthLimitingTextInputFormatter(24)],
        style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        decoration: InputDecoration(
          hintText: _provider == null
              ? 'Select a water board first'
              : 'Enter customer / account number',
          hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280)),
          prefixIcon: Icon(Icons.water_drop, color: _muted, size: 20.sp),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        ),
      ),
    );
  }

  Widget _customerStatusRow() {
    if (_validating) {
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Verifying customer…',
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
        _row('Water board', _provider!.providerName),
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

  /// Save-as-beneficiary control. Renders a passive "already saved" row when
  /// the account is already saved (no duplicate); otherwise a switch that
  /// opens a nickname dialog on ON. The save runs post-payment on the receipt.
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
      hint: 'e.g. Home, Shop, Mum',
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
                _amount != null && _amount! > 0
                    ? 'Pay ₦${_amount!.toStringAsFixed(0)}'
                    : 'Pay water bill',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
