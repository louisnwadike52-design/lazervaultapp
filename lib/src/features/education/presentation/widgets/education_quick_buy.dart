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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/widgets/save_beneficiary_controls.dart';
import 'package:lazervault/src/features/bills/presentation/widgets/bill_list_picker_sheet.dart';

import '../cubit/education_cubit.dart';
import '../cubit/education_state.dart';
import '../../domain/entities/education_beneficiary.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../../domain/entities/education_purchase_entity.dart';
import '../../data/datasources/education_beneficiary_remote_datasource.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';

/// Single-page education-PIN purchase — streamlined "one page, very fast" flow.
/// Each [EducationProviderEntity] IS a purchasable PIN product (WAEC result
/// checker, JAMB UTME PIN, …). Pick a product in a STYLED bottom sheet → set
/// quantity → (JAMB only: profile/billers code) → phone → inline confirmation →
/// the shared TX-PIN sheet ALSO runs the purchase → PIN-result receipt. No
/// product / confirm / processing screens. Reuses [EducationCubit] unchanged.
class EducationQuickBuy extends StatefulWidget {
  const EducationQuickBuy({super.key});

  @override
  State<EducationQuickBuy> createState() => _EducationQuickBuyState();
}

class _EducationQuickBuyState extends State<EducationQuickBuy>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _currency = 'NGN';

  final _phoneController = TextEditingController();
  final _billersController = TextEditingController();

  // Live product-fetch state so the picker sheet updates itself as products
  // arrive / fail, instead of freezing on the snapshot it opened with.
  // `_fetchingProducts` scopes a generic cubit error to THIS fetch (the cubit
  // is shared with the purchase flow).
  final ValueNotifier<BillListFetchState<EducationProviderEntity>> _productState =
      ValueNotifier(const BillListFetchState<EducationProviderEntity>.idle());
  bool _fetchingProducts = false;
  EducationProviderEntity? _product;
  int _quantity = 1;
  bool _submitting = false;
  StreamSubscription<EducationState>? _sub;

  // ── Save-candidate dedup — saved candidates loaded once, matched against the
  // typed phone (used AS the candidate number) + selected provider so an
  // already-saved candidate shows a passive "already saved" row instead of
  // inviting a duplicate. The actual save runs post-purchase on the receipt.
  bool _saveCandidate = false;
  String? _saveNickname;
  List<EducationBeneficiary> _beneficiaries = const [];
  EducationBeneficiary? _existingBeneficiary;

  bool get _isJamb => _product?.serviceId.toLowerCase() == 'jamb';
  double get _total => (_product?.amount ?? 0) * _quantity;

  @override
  void initState() {
    super.initState();
    _sub = context.read<EducationCubit>().stream.listen((s) {
      if (!mounted) return;
      if (s is EducationProvidersLoaded) {
        _fetchingProducts = false;
        _productState.value = BillListFetchState.loaded(s.providers);
        setState(() {});
      } else if (s is EducationError && _fetchingProducts) {
        // A generic error while a products fetch is in flight = the fetch
        // failed; surface a retry in the sheet instead of a stuck spinner.
        _fetchingProducts = false;
        _productState.value =
            BillListFetchState.failed(sanitizeUserFacingError(s.message));
      }
    });
    _phoneController.addListener(_recomputeExistingBeneficiary);
    _reloadProducts();
    _prefillPhone();
    _loadSavedBeneficiaries();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _productState.dispose();
    _phoneController.dispose();
    _billersController.dispose();
    super.dispose();
  }

  /// Best-effort read of the user's saved candidates so we can flag an
  /// already-saved candidate and avoid a duplicate save.
  Future<void> _loadSavedBeneficiaries() async {
    try {
      final list = await serviceLocator<EducationBeneficiaryRemoteDataSource>()
          .getBeneficiaries();
      if (!mounted) return;
      setState(() => _beneficiaries = list);
      _recomputeExistingBeneficiary();
    } catch (_) {/* best-effort — dedup just won't pre-flag */}
  }

  /// Match the typed phone (digits-only, used AS the candidate number) against
  /// saved candidates. When a product is selected we additionally require the
  /// provider code to match so a candidate saved under WAEC doesn't suppress
  /// the save toggle for a JAMB purchase on the same number.
  void _recomputeExistingBeneficiary() {
    final typed = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    final currentCode = _product?.serviceId.toUpperCase();
    EducationBeneficiary? found;
    if (typed.isNotEmpty) {
      for (final b in _beneficiaries) {
        if (b.candidateNumber.replaceAll(RegExp(r'[^\d]'), '') != typed) {
          continue;
        }
        if (currentCode != null &&
            currentCode.isNotEmpty &&
            b.providerCode.toUpperCase() != currentCode) {
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

  bool get _phoneValid =>
      RegExp(r'^0\d{10}$').hasMatch(_phoneController.text.trim());
  bool get _ready =>
      _product != null &&
      _phoneValid &&
      _quantity > 0 &&
      (!_isJamb || _billersController.text.trim().isNotEmpty);

  void _reloadProducts() {
    _fetchingProducts = true;
    _productState.value =
        const BillListFetchState<EducationProviderEntity>.loading();
    context.read<EducationCubit>().getProviders();
  }

  Future<void> _openProductSheet() async {
    final picked = await showModalBottomSheet<EducationProviderEntity>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BillListPickerSheet<EducationProviderEntity>(
        title: 'Select exam / PIN',
        icon: Icons.school,
        accent: _accent,
        listenable: _productState,
        labelOf: (p) => p.name,
        trailingOf: (p) => '₦${p.amount.toStringAsFixed(0)}',
        subtitleOf: (p) => p.description,
        emptyLabel: 'No products available',
        onRetry: _reloadProducts,
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        _product = picked;
        _quantity = 1;
      });
      // Provider changed → the provider-scoped dedup may now (un)match.
      _recomputeExistingBeneficiary();
    }
  }

  // ── Purchase (runs INSIDE the TX-PIN sheet's processing beat) ──────────────
  Future<void> _pay() async {
    if (!_ready || _submitting) return;
    FocusScope.of(context).unfocus();
    final cubit = context.read<EducationCubit>();
    final product = _product!;
    final phone = _phoneController.text.trim();
    final billers = _billersController.text.trim();
    final txnId = 'education_${DateTime.now().millisecondsSinceEpoch}_$phone';

    EducationPurchaseEntity? result;
    setState(() => _submitting = true);
    try {
      final ok = await validateTransactionPin(
        context: context,
        transactionId: txnId,
        transactionType: 'education_purchase',
        amount: _total,
        currency: _currency,
        title: 'Confirm purchase',
        message:
            'Buy $_quantity × ${product.name} — $_currency ${_total.toStringAsFixed(0)}',
        showProcessingPhase: true,
        successMessage: 'Purchase request sent',
        onPinValidated: (token) async {
          final completer = Completer<EducationPurchaseEntity>();
          late final StreamSubscription<EducationState> sub;
          sub = cubit.stream.listen((state) {
            if (completer.isCompleted) return;
            if (state is EducationPurchaseSuccess) {
              completer.complete(state.purchase);
            } else if (state is EducationPurchaseFailed) {
              completer.completeError(state.message);
            }
          });
          try {
            cubit.purchasePin(
              serviceId: product.serviceId,
              variationCode: product.variationCode,
              quantity: _quantity,
              phone: phone,
              transactionId: txnId,
              verificationToken: token,
              idempotencyKey: txnId,
              billersCode: billers,
            );
            result = await completer.future.timeout(const Duration(seconds: 90));
          } finally {
            await sub.cancel();
          }
        },
      );

      if (!mounted) return;
      if (ok && result != null) {
        final alreadySaved = _existingBeneficiary != null;
        Get.toNamed(AppRoutes.educationPinResult, arguments: {
          'purchase': result,
          // Pass the selected product so the receipt shows the provider
          // name (e.g. "WAEC result checker") rather than the raw billType.
          'provider': product,
          // Save-candidate hand-off — the receipt runs the real
          // saveBeneficiary once the purchase lands completed. Suppressed
          // when the candidate is already saved (no duplicate).
          'saveCandidate': _saveCandidate && !alreadySaved,
          if (_saveNickname != null) 'candidateNickname': _saveNickname,
          'phone': phone,
          // Already-saved candidate: hand the receipt the existing id so it
          // skips the duplicate save.
          if (alreadySaved) 'existingBeneficiaryId': _existingBeneficiary!.id,
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
        _label('Exam / PIN type'),
        SizedBox(height: 8.h),
        _productSelector(),
        if (_product != null) ...[
          SizedBox(height: 20.h),
          _label('Quantity'),
          SizedBox(height: 8.h),
          _quantityStepper(),
        ],
        if (_isJamb) ...[
          SizedBox(height: 20.h),
          _label('JAMB profile / billers code'),
          SizedBox(height: 8.h),
          _billersField(),
        ],
        SizedBox(height: 20.h),
        _label('Phone number (for PIN & receipt)'),
        SizedBox(height: 8.h),
        _phoneField(),
        if (_ready) ...[
          SizedBox(height: 20.h),
          _confirmationCard(),
        ],
        SizedBox(height: 14.h),
        _saveCandidateToggle(),
        SizedBox(height: 16.h),
        _payButton(),
      ],
    );
  }

  /// Save-candidate control. Renders a passive "already saved" row when the
  /// number is already a saved candidate (no duplicate); otherwise a switch
  /// that opens a nickname dialog on ON. The save runs post-purchase on the
  /// receipt.
  Widget _saveCandidateToggle() {
    if (_existingBeneficiary != null) {
      final b = _existingBeneficiary!;
      return SavedBeneficiaryInfoRow(
        title: 'Candidate already saved',
        subtitle: 'Saved as "${b.nickname ?? b.candidateNumber}"',
      );
    }
    return SaveBeneficiaryToggleRow(
      accent: _accent,
      title: 'Save this candidate',
      subtitle: _saveCandidate && (_saveNickname?.isNotEmpty ?? false)
          ? 'Nickname: ${_saveNickname!}'
          : 'Save it as a beneficiary for faster payments next time',
      value: _saveCandidate,
      onChanged: _onToggleSaveCandidate,
    );
  }

  Future<void> _onToggleSaveCandidate(bool value) async {
    if (!value) {
      setState(() {
        _saveCandidate = false;
        _saveNickname = null;
      });
      return;
    }
    final nickname = await promptBeneficiaryNickname(
      context,
      accent: _accent,
      title: 'Save this candidate',
      prompt:
          'Give this candidate a nickname so you can find it fast next time.',
      hint: 'e.g. My JAMB, Son, Daughter',
      initial: _saveNickname ?? '',
    );
    if (nickname == null || nickname.trim().isEmpty) {
      if (mounted) setState(() => _saveCandidate = false);
      return;
    }
    setState(() {
      _saveCandidate = true;
      _saveNickname = nickname.trim();
    });
  }

  Widget _label(String t) => Text(t,
      style: GoogleFonts.inter(
          color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600));

  Widget _productSelector() {
    return GestureDetector(
      onTap: _openProductSheet,
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
              _product?.name ?? 'Select exam / PIN type',
              style: GoogleFonts.inter(
                color: _product != null ? Colors.white : const Color(0xFF6B7280),
                fontSize: 15.sp,
                fontWeight: _product != null ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          if (_product != null)
            Text('₦${_product!.amount.toStringAsFixed(0)}',
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
      btn(Icons.add, _quantity < 20 ? () => setState(() => _quantity++) : null),
    ]);
  }

  Widget _billersField() => _boxed(
        controller: _billersController,
        hint: 'Enter JAMB profile code',
        icon: Icons.badge_outlined,
        // JAMB profile codes are short (~10 chars) — cap the field so a
        // fat-finger paste can't submit an over-long, invalid code.
        formatters: [LengthLimitingTextInputFormatter(20)],
        onChanged: (_) => setState(() {}),
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

  Widget _boxed({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboard,
    List<TextInputFormatter>? formatters,
    ValueChanged<String>? onChanged,
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
          prefixIcon: Icon(icon, color: _muted, size: 20.sp),
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
        _row('Item', _product!.name),
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
                _product != null
                    ? 'Pay ₦${_total.toStringAsFixed(0)}'
                    : 'Buy PIN',
                style: GoogleFonts.inter(
                    fontSize: 15.sp, fontWeight: FontWeight.w700)),
      ),
    );
  }
}
