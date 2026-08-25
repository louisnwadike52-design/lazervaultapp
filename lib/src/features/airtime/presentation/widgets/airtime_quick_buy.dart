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
import 'package:lazervault/core/widgets/network_logo.dart';
import 'package:lazervault/core/widgets/save_beneficiary_controls.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/repositories/airtime_repository.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

/// Single-page airtime purchase — the streamlined "one page, very fast" flow.
///
/// Everything lives here, no step screens: the phone number is prefilled from
/// the user's profile (editable), the network is AUTO-DETECTED from it (and
/// re-detected on every edit), the amount is picked inline, an inline
/// confirmation appears below, and the ONLY interstitial is the shared TX-PIN
/// sheet — which ALSO runs the purchase (its processing beat replaces the old
/// dedicated processing screen). On success we route straight to the receipt,
/// which shows the definitive status (a sync provider → complete, an async
/// one → initiated) and fires the keep-alive save-beneficiary hook.
///
/// Reuses ALL existing backend: [AirtimeCubit.detectNetworkFromPhoneNumber],
/// [AirtimeCubit.loadNetworkProviders], [AirtimeCubit.processPaymentWithToken],
/// and the admin-audited utility-payments purchase path (unchanged) — so the
/// provider-attempt audit trail and sync/async reconciliation are preserved.
class AirtimeQuickBuy extends StatefulWidget {
  const AirtimeQuickBuy({super.key});

  @override
  State<AirtimeQuickBuy> createState() => _AirtimeQuickBuyState();
}

class _AirtimeQuickBuyState extends State<AirtimeQuickBuy>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _country = 'NG';
  static const _currency = 'NGN';
  static const _quickAmounts = <int>[100, 200, 500, 1000, 2000, 5000];

  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();

  NetworkProvider? _network;
  bool _detecting = false;
  // True once a detection attempt has completed for the current number. Lets us
  // distinguish "still detecting" from "couldn't detect" so we only show the
  // manual network pills in the latter case (mirrors the legacy recipient
  // screen's _detectionAttempted gate).
  bool _detectionAttempted = false;
  // Whether the user overrode the (failed) auto-detection by tapping a pill, so
  // we render "selected" instead of "auto-detected".
  bool _networkManual = false;
  // Supported networks for the manual pills — loaded once alongside the cubit.
  List<NetworkProvider> _providers = const [];
  double? _amount;
  bool _saveContact = false;
  String? _saveNickname;
  bool _submitting = false;
  Timer? _detectDebounce;

  // ── Saved-contact dedup — loaded once, matched against the typed number so
  // an already-saved recipient shows a passive "already saved" row instead of
  // inviting a duplicate. Mirrors the airtime review screen's probe.
  List<AirtimeBeneficiary> _beneficiaries = const [];
  AirtimeBeneficiary? _existingBeneficiary;

  // ── Inline auto-recharge — captured from BillAutoRechargeCreateSheet.
  // Threaded into the confirmation route args (same shape the old airtime
  // review screen used); the confirmation screen saves the beneficiary and
  // fires the real createAutoRecharge once the payment lands completed.
  bool _autoEnabled = false;
  String? _autoSummary;
  Map<String, dynamic>? _autoPref;

  /// Network requested by a hand-off (repeat purchase / beneficiary /
  /// network tile). Applied once providers are loaded, and only when
  /// auto-detection hasn't already resolved a network from the number.
  String? _argNetworkCode;

  @override
  void initState() {
    super.initState();
    context.read<AirtimeCubit>().loadNetworkProviders(_country);
    _phoneController.addListener(_onPhoneChanged);
    _prefillFromProfile();
    _loadSavedContacts();
    _loadProviders();
  }

  /// Load the supported networks (for the manual pills shown when the phone
  /// prefix can't be auto-detected). Best-effort — the pills just won't show if
  /// this fails, and auto-detection still works via the cubit.
  Future<void> _loadProviders() async {
    try {
      final list =
          await serviceLocator<AirtimeRepository>().getNetworkProviders(_country);
      if (!mounted) return;
      setState(() => _providers = list.where((p) => p.isActive).toList());
      _applyArgNetwork();
    } catch (_) {/* best-effort */}
  }

  /// Apply a hand-off's requested network once providers are known — only
  /// when nothing is selected yet, so prefix auto-detection still wins for
  /// numbers it can resolve.
  void _applyArgNetwork() {
    final code = _argNetworkCode;
    if (code == null || _network != null || _providers.isEmpty) return;
    final lc = code.toLowerCase();
    for (final p in _providers) {
      if (p.shortName.toLowerCase() == lc ||
          p.name.toLowerCase() == lc ||
          p.id.toLowerCase() == lc) {
        _selectNetworkManually(p);
        _argNetworkCode = null;
        return;
      }
    }
  }

  /// Best-effort read of the user's saved airtime contacts so we can flag an
  /// already-saved recipient. Read directly via the repo (not the payment
  /// cubit) so it never interferes with the purchase stream.
  Future<void> _loadSavedContacts() async {
    try {
      final list = await serviceLocator<AirtimeRepository>()
          .getAirtimeBeneficiaries();
      if (!mounted) return;
      setState(() => _beneficiaries = list);
      _recomputeExistingBeneficiary();
    } catch (_) {/* best-effort — dedup just won't pre-flag */}
  }

  /// Match the typed number (digits-only) against saved contacts.
  void _recomputeExistingBeneficiary() {
    final typed = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    AirtimeBeneficiary? found;
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
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _prefillFromProfile() async {
    // A hand-off (reminder "top up", repeat purchase, beneficiary pick,
    // network tile) may navigate here with the previous transaction's
    // details — phone, amount AND network all prefill so the user only has
    // to confirm. This replaced the separate legacy purchase flow screens.
    final args = Get.arguments;
    if (args is Map) {
      final amt = args['amount'] ?? args['prefillAmount'];
      final amtVal = amt is num
          ? amt.toDouble()
          : double.tryParse(amt?.toString() ?? '');
      if (amtVal != null && amtVal > 0 && _amountController.text.isEmpty) {
        _amountController.text = amtVal == amtVal.roundToDouble()
            ? amtVal.toInt().toString()
            : amtVal.toString();
      }
      final net = args['networkCode'] ?? args['networkType'];
      if (net is String && net.trim().isNotEmpty) {
        _argNetworkCode = net.trim();
        _applyArgNetwork();
      }
      final v = args['phoneNumber'] ?? args['prefillPhone'];
      final argPhone = _toLocalNg(v is String ? v : '');
      if (argPhone.isNotEmpty && _phoneController.text.isEmpty) {
        _phoneController.text = argPhone; // triggers _onPhoneChanged → detect
        return;
      }
    }
    try {
      final raw =
          await serviceLocator<FlutterSecureStorage>().read(key: 'stored_phone');
      final local = _toLocalNg(raw ?? '');
      if (local.isNotEmpty && mounted && _phoneController.text.isEmpty) {
        _phoneController.text = local; // triggers _onPhoneChanged → detect
      }
    } catch (_) {/* best-effort prefill */}
  }

  /// Normalise any stored phone to the local 0-prefixed NG form the number
  /// field + prefix detector expect (`+2348…`/`2348…`/`8…` → `08…`).
  String _toLocalNg(String input) {
    var d = input.replaceAll(RegExp(r'[^\d]'), '');
    if (d.startsWith('234')) d = d.substring(3);
    if (d.startsWith('0')) d = d.substring(1);
    if (d.isEmpty) return '';
    return '0$d';
  }

  void _onPhoneChanged() {
    _recomputeExistingBeneficiary();
    _detectDebounce?.cancel();
    _detectDebounce = Timer(const Duration(milliseconds: 350), _detectNetwork);
  }

  Future<void> _detectNetwork() async {
    final phone = _phoneController.text.trim();
    // A valid NG mobile is 11 digits starting 0 (0803…). Detect only once the
    // number is long enough to carry a prefix; clear the badge otherwise.
    if (phone.length < 4) {
      if (mounted) {
        setState(() {
          _network = null;
          _detectionAttempted = false;
          _networkManual = false;
        });
      }
      return;
    }
    if (mounted) setState(() => _detecting = true);
    NetworkProvider? found;
    try {
      found = await context
          .read<AirtimeCubit>()
          .detectNetworkFromPhoneNumber(phone, _country);
    } catch (_) {/* leave unresolved → user can still edit */}
    if (!mounted) return;
    setState(() {
      // Auto-detection wins; only fall back to a manual pick when it's null.
      _network = found;
      _networkManual = false;
      _detecting = false;
      _detectionAttempted = true;
    });
  }

  /// The user tapped a network pill because auto-detection couldn't resolve one.
  void _selectNetworkManually(NetworkProvider p) {
    setState(() {
      _network = p;
      _networkManual = true;
    });
  }

  bool get _phoneValid {
    final p = _phoneController.text.trim();
    return RegExp(r'^0\d{10}$').hasMatch(p);
  }

  bool get _amountValid {
    final a = _amount ?? 0;
    if (a <= 0) return false;
    final n = _network;
    if (n != null) {
      if (a < n.minAmount) return false;
      if (n.maxAmount > 0 && a > n.maxAmount) return false;
    }
    return true;
  }

  bool get _ready => _phoneValid && _network != null && _amountValid;

  void _selectAmount(int value) {
    setState(() {
      _amount = value.toDouble();
      _amountController.text = value.toString();
    });
  }

  void _onAmountTyped(String v) {
    final parsed = double.tryParse(v.trim());
    setState(() => _amount = parsed);
  }

  // ── Purchase (runs INSIDE the TX-PIN sheet's processing beat) ──────────────
  Future<void> _pay() async {
    if (!_ready || _submitting) return;
    FocusScope.of(context).unfocus();
    final cubit = context.read<AirtimeCubit>();
    final network = _network!;
    final phone = _phoneController.text.trim();
    final amount = _amount!;
    final accountId = serviceLocator<AccountManager>().activeAccountId;
    final txnId =
        'airtime_${DateTime.now().millisecondsSinceEpoch}_${phone.replaceAll(RegExp(r'[^\d]'), '')}';

    AirtimeTransaction? result;
    setState(() => _submitting = true);
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'airtime_purchase',
        amount: amount,
        currency: _currency,
        title: 'Confirm airtime',
        message:
            'Send $_currency ${amount.toStringAsFixed(0)} airtime to $phone (${network.name})',
        showProcessingPhase: true,
        // Non-committal beat: the provider may settle synchronously (delivered)
        // OR asynchronously (queued) — the receipt shows the definitive status.
        successMessage: 'Airtime request sent',
        onPinValidated: (token) async {
          // Drive the real purchase and AWAIT its terminal state so the sheet's
          // processing spinner stays up until it's actually done/failed.
          final completer = Completer<AirtimeTransaction>();
          late final StreamSubscription<AirtimeState> sub;
          sub = cubit.stream.listen((state) {
            if (completer.isCompleted) return;
            if (state is AirtimePaymentSuccess) {
              completer.complete(state.transaction);
            } else if (state is AirtimePaymentFailed) {
              completer.completeError(state.message);
            }
          });
          try {
            cubit.processPaymentWithToken(
              countryCode: _country,
              networkProviderId: network.id,
              phoneNumber: phone,
              amount: amount,
              currency: _currency,
              transactionId: txnId,
              verificationToken: token,
              operatorId: network.operatorId,
              reloadlyOperatorId: network.reloadlyOperatorId,
              sourceAccountId: accountId,
            );
            result = await completer.future.timeout(const Duration(seconds: 90));
          } finally {
            await sub.cancel();
          }
        },
      );

      if (!mounted) return;
      if (ok && result != null) {
        final wantsAuto = _autoEnabled && _autoPref != null;
        final alreadySaved = _existingBeneficiary != null;
        Get.toNamed(AppRoutes.airtimePaymentConfirmation, arguments: {
          'transaction': result,
          // Auto-recharge needs a beneficiary id, which the confirmation
          // screen resolves from the save-as-contact step (or the existing
          // one) — so force the save on when a schedule was requested and the
          // contact isn't already saved.
          'saveAsContact': (_saveContact && !alreadySaved) || wantsAuto,
          if (_saveNickname != null) 'nickname': _saveNickname,
          // Already-saved recipient: hand the confirmation screen the existing
          // id so it skips the duplicate save and still wires auto-recharge.
          if (alreadySaved) 'existingBeneficiaryId': _existingBeneficiary!.id,
          'networkCode': network.shortName,
          'networkName': network.name,
          'enableAutoRecharge': wantsAuto,
          if (wantsAuto) 'autoRechargePref': _autoPref!,
        });
      }
    } catch (_) {
      // A thrown purchase error surfaces on the PIN sheet itself (failed beat);
      // nothing more to show here.
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
    final n = _network;
    if (n == null) return;
    final phone = _phoneController.text.trim();
    await BillAutoRechargeCreateSheet.show(
      context,
      subtitle: '${n.name} · $phone',
      title: 'Auto-recharge schedule',
      ctaLabel: 'Save schedule',
      successMessage: 'Schedule saved',
      initialAmount: _amount,
      minAmount: n.minAmount > 0 ? n.minAmount : 50,
      maxAmount: n.maxAmount > 0 ? n.maxAmount : null,
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
          _autoPref = {
            'amount': amount,
            'frequency': frequency,
            'dayOfWeek': dayOfWeek,
            'dayOfMonth': dayOfMonth,
            'executionHour': executionHour,
            'executionMinute': executionMinute,
          };
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
                Text(on ? _autoSummary! : 'Top up this number on a schedule',
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
        _sectionLabel('Phone number'),
        SizedBox(height: 8.h),
        _phoneField(),
        SizedBox(height: 8.h),
        _networkRow(),
        SizedBox(height: 20.h),
        _sectionLabel('Amount'),
        SizedBox(height: 8.h),
        _amountChips(),
        SizedBox(height: 10.h),
        _amountField(),
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

  Widget _sectionLabel(String text) => Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      );

  // Non-editable country dial code shown beside the phone field. Local (NG)
  // numbers are always +234; the field still holds the local 0-prefixed number
  // (network detection + backend format unchanged).
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
          suffixIcon: _phoneController.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.clear, color: _muted, size: 18.sp),
                  onPressed: () => setState(() {
                    _phoneController.clear();
                    _network = null;
                  }),
                ),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        ),
      ),
    );
  }

  /// Auto-detected network badge — no picker sheet. Shows a spinner while
  /// detecting, the resolved network once found, or a gentle prompt otherwise.
  Widget _networkRow() {
    if (_detecting) {
      return Row(children: [
        SizedBox(width: 14.w, height: 14.w, child: LazerVaultLoader.small()),
        SizedBox(width: 8.w),
        Text('Detecting network…',
            style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
      ]);
    }
    final n = _network;
    if (n == null) {
      if (!_phoneValid) {
        return _phoneController.text.isNotEmpty
            ? Text('Enter a valid 11-digit number',
                style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C), fontSize: 12.sp))
            : const SizedBox.shrink();
      }
      // Valid number, but the prefix couldn't be auto-detected — let the user
      // pick a network instead of being stuck with the pay button disabled.
      if (_detectionAttempted && _providers.isNotEmpty) {
        return _networkPills();
      }
      // Detection failed AND the network list never loaded (offline/first-load
      // error) — offer a single-shot retry so the user isn't silently stuck.
      // We reload the real list (with operatorId) rather than fake a static one.
      if (_detectionAttempted && _providers.isEmpty) {
        return GestureDetector(
          onTap: _loadProviders,
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.refresh, color: const Color(0xFFFB923C), size: 15.sp),
            SizedBox(width: 6.w),
            Flexible(
              child: Text("Couldn't load networks — tap to pick one",
                  style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C), fontSize: 12.sp)),
            ),
          ]),
        );
      }
      return const SizedBox.shrink();
    }
    Color net;
    try {
      net = Color(int.parse(n.primaryColor.replaceFirst('#', '0xFF')));
    } catch (_) {
      net = _accent;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: net.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: net.withValues(alpha: 0.4)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        NetworkLogo(
          networkType: n.type.name,
          operatorId: n.operatorId,
          shortName: n.shortName,
          name: n.name,
          primaryColorHex: n.primaryColor,
          size: 22,
          borderRadius: 6,
        ),
        SizedBox(width: 8.w),
        Text(n.name,
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

  /// Tappable network chips shown when auto-detection can't resolve the number's
  /// network. Reuses the auto-detected chip styling (per-network colour +
  /// NetworkLogo), made selectable.
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
          children: _providers.map(_networkPill).toList(),
        ),
      ],
    );
  }

  Widget _networkPill(NetworkProvider p) {
    Color net;
    try {
      net = Color(int.parse(p.primaryColor.replaceFirst('#', '0xFF')));
    } catch (_) {
      net = _accent;
    }
    final selected = _network?.operatorId == p.operatorId;
    return GestureDetector(
      onTap: () => _selectNetworkManually(p),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: net.withValues(alpha: selected ? 0.22 : 0.10),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: net.withValues(alpha: selected ? 0.9 : 0.35),
              width: selected ? 1.5 : 1),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          NetworkLogo(
            networkType: p.type.name,
            operatorId: p.operatorId,
            shortName: p.shortName,
            name: p.name,
            primaryColorHex: p.primaryColor,
            size: 20,
            borderRadius: 6,
          ),
          SizedBox(width: 6.w),
          Text(p.shortName.isNotEmpty ? p.shortName : p.name,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600)),
        ]),
      ),
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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
        onChanged: _onAmountTyped,
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
    final n = _network!;
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
        _row('Network', n.name),
        SizedBox(height: 10.h),
        Divider(color: _border, height: 1),
        SizedBox(height: 10.h),
        _row('You pay', '₦${_amount!.toStringAsFixed(0)}',
            valueColor: const Color(0xFF10B981), bold: true),
      ]),
    );
  }

  Widget _row(String label, String value, {Color? valueColor, bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
      ],
    );
  }

  /// Save-as-contact control. When the number is already saved it renders a
  /// passive "already saved" row (no duplicate). Otherwise a switch that opens
  /// a nickname dialog on ON; the actual save runs post-purchase on the
  /// confirmation screen with the collected nickname.
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
                _amount != null && _amount! > 0
                    ? 'Buy ₦${_amount!.toStringAsFixed(0)} airtime'
                    : 'Buy airtime',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
