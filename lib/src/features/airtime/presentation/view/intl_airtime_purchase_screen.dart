import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/intl_airtime_country.dart';
import '../../domain/entities/intl_airtime_operator.dart';
import '../cubit/intl_airtime_cubit.dart';
import '../cubit/intl_airtime_state.dart';
import '../widgets/airtime_shimmer.dart';
import '../widgets/intl_operator_bottom_sheet.dart';

/// Consolidated international airtime purchase screen.
///
/// Replaces the old 3-screen flow (operator selection → recipient input →
/// amount selection) with a single screen that mirrors the domestic
/// [AirtimePurchaseScreen] pattern:
///   1. Enter phone (auto-detects operator as the user types).
///   2. Pick amount (fixed grid or range).
///   3. Continue to review.
///
/// Country-aware phone validation uses [_phoneDigitRanges] — min/max digits
/// expected per ISO country code (excluding the dial code prefix).
/// FX rate display follows the gift-card pricing pattern: show recipient
/// amount in destination currency + total in sender currency + rate caption.
class IntlAirtimePurchaseScreen extends StatefulWidget {
  const IntlAirtimePurchaseScreen({super.key});

  @override
  State<IntlAirtimePurchaseScreen> createState() =>
      _IntlAirtimePurchaseScreenState();
}

class _IntlAirtimePurchaseScreenState extends State<IntlAirtimePurchaseScreen> {
  // (minDigits, maxDigits) excluding the dial code. Covers the 20 countries
  // populated in `intl_airtime_countries`. Unknown countries fall back to
  // [_defaultRange].
  static const Map<String, List<int>> _phoneDigitRanges = {
    'US': [10, 10],
    'CA': [10, 10],
    'GB': [10, 10],
    'DE': [10, 11],
    'FR': [9, 9],
    'AU': [9, 9],
    'BR': [10, 11],
    'MX': [10, 10],
    'IN': [10, 10],
    'KE': [9, 9],
    'GH': [9, 9],
    'ZA': [9, 9],
    'EG': [10, 10],
    'ET': [9, 9],
    'NG': [10, 10],
    'TZ': [9, 9],
    'UG': [9, 9],
    'RW': [9, 9],
    'SN': [9, 9],
    'CI': [8, 10],
    'CM': [9, 9],
  };
  static const List<int> _defaultRange = [7, 15];

  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final LocaleManager _localeManager = GetIt.I<LocaleManager>();

  IntlAirtimeCountry? _country;
  bool _countryResolutionFailed = false;
  bool _isRepeat = false;
  bool _phoneLocked = false;
  String? _repeatOperatorName;
  String? _repeatReloadlyOperatorId;

  List<IntlAirtimeOperator> _operators = const [];
  IntlAirtimeOperator? _selectedOperator;
  bool _operatorAutoDetected = false;

  /// Selected fixed denomination in **destination** currency (what the user taps).
  double _selectedDestFixed = 0;
  /// Corresponding sender-currency amount for the selected fixed denomination.
  double _selectedSenderFixed = 0;
  String? _phoneError;
  String? _amountError;
  Timer? _debounce;

  /// User's active currency from LocaleManager (e.g. NGN for en-NG).
  /// This is what the user actually pays in, and what their wallet balance is denominated in.
  String get _activeCurrency => _localeManager.currentCurrency;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _country = args['country'] as IntlAirtimeCountry?;
    _phoneController.addListener(_onPhoneChanged);
    _amountController.addListener(_onAmountChanged);

    _isRepeat = args['isRepeat'] as bool? ?? false;
    _repeatOperatorName = args['operatorName']?.toString();
    _repeatReloadlyOperatorId = args['reloadlyOperatorId']?.toString();
    // Prefill from a Repeat-Purchase hand-off (history → repeat). We only
    // get a `countryCode` string in that path, so resolve to a full
    // IntlAirtimeCountry by loading the catalog and matching on code.
    final prefillPhone = args['phoneNumber']?.toString();
    if (prefillPhone != null && prefillPhone.isNotEmpty) {
      // Strip dial code when we know it so the local entry field stays tidy.
      var local = prefillPhone;
      if (local.startsWith('+')) local = local.substring(1);
      if (_country != null) {
        final dial = _country!.dialCode.replaceAll('+', '');
        if (local.startsWith(dial)) local = local.substring(dial.length);
      }
      _phoneController.text = local;
      if (_isRepeat) _phoneLocked = true;
    }
    final prefillAmount = args['amount'];
    if (prefillAmount is num && prefillAmount > 0) {
      _amountController.text = prefillAmount.toStringAsFixed(0);
    }

    if (_country != null) {
      context.read<IntlAirtimeCubit>().loadOperators(
            _country!.countryCode,
            _country!,
          );
    } else {
      final countryCode = args['countryCode']?.toString();
      if (countryCode == null || countryCode.isEmpty) {
        _countryResolutionFailed = true;
      } else {
        // Kick off country catalog load; the BlocListener hydrates _country
        // once the list arrives (see listener below for
        // IntlAirtimeCountriesLoaded).
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          context.read<IntlAirtimeCubit>().loadCountries();
        });
      }
    }
  }

  void _hydrateFromCountriesLoaded(
    List<IntlAirtimeCountry> countries,
  ) {
    if (_country != null) return;
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final code = args['countryCode']?.toString().toUpperCase();
    if (code == null || code.isEmpty) {
      setState(() => _countryResolutionFailed = true);
      return;
    }
    final match = countries.firstWhere(
      (c) => c.countryCode.toUpperCase() == code,
      orElse: () => IntlAirtimeCountry(
        id: '',
        countryCode: code,
        countryName: code,
        dialCode: '',
        currencyCode: '',
        currencySymbol: '',
        flagEmoji: '',
        isActive: true,
      ),
    );
    // No-match case (id stays empty) means the catalog response simply
    // doesn't include this country — keep the failure state so the user
    // sees the back button. A missing dialCode by itself is no longer a
    // hard failure: the operator/reloadly id from the original tx is
    // sufficient to repeat the purchase, and the user can type the local
    // number without a dial-code prefix.
    if (match.id.isEmpty) {
      setState(() => _countryResolutionFailed = true);
      return;
    }
    setState(() => _country = match);
    context.read<IntlAirtimeCubit>().loadOperators(match.countryCode, match);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _phoneController.removeListener(_onPhoneChanged);
    _amountController.removeListener(_onAmountChanged);
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Phone + operator detection
  // ---------------------------------------------------------------------------

  List<int> get _digitRange =>
      _phoneDigitRanges[_country!.countryCode.toUpperCase()] ?? _defaultRange;

  String get _localDigits =>
      _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');

  String get _fullPhone {
    final dial = _country!.dialCode.replaceAll('+', '');
    var local = _localDigits;
    if (local.startsWith('0')) local = local.substring(1);
    return '+$dial$local';
  }

  String? _phoneValidationError() {
    var digits = _localDigits;
    final range = _digitRange;
    if (digits.isEmpty) return 'Enter a phone number';

    // Drop a single leading 0 (trunk prefix) before length-checking.
    if (digits.startsWith('0')) digits = digits.substring(1);

    if (digits.length < range[0]) {
      return 'Too short for ${_country!.countryName} '
          '(need ${range[0]}${range[0] == range[1] ? '' : '-${range[1]}'} digits)';
    }
    if (digits.length > range[1]) {
      return 'Too long for ${_country!.countryName} '
          '(max ${range[1]} digits)';
    }
    // Reject obvious junk numbers that would just burn a provider call:
    // all-same digit (0000000000, 1111111111…) or a strict ascending run
    // (0123456789, 123456789…). Real MSISDNs never look like this and
    // Reloadly always rejects them with INVALID_RECIPIENT_PHONE.
    final first = digits[0];
    if (digits.split('').every((c) => c == first)) {
      return 'That doesn\'t look like a real phone number';
    }
    var sequential = true;
    for (var i = 1; i < digits.length; i++) {
      if (digits.codeUnitAt(i) - digits.codeUnitAt(i - 1) != 1) {
        sequential = false;
        break;
      }
    }
    if (sequential) {
      return 'That doesn\'t look like a real phone number';
    }
    return null;
  }

  void _onPhoneChanged() {
    final err = _phoneError;
    if (err != null) setState(() => _phoneError = null);

    _debounce?.cancel();
    // Match validation: strip a single trunk-0 before length-checking so
    // auto-detect fires for both `024xxxxxxx` and `24xxxxxxx` in countries
    // that use a trunk prefix (GH, GB, ZA, etc.).
    var digits = _localDigits;
    if (digits.startsWith('0')) digits = digits.substring(1);
    if (digits.length >= _digitRange[0] && digits.length <= _digitRange[1]) {
      _debounce = Timer(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        context
            .read<IntlAirtimeCubit>()
            .autoDetectOperator(_fullPhone, _country!.countryCode);
      });
    } else {
      // Phone edited back to invalid — clear auto-detect flag so the manual
      // operator picker becomes authoritative again.
      if (_operatorAutoDetected) {
        setState(() => _operatorAutoDetected = false);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Amount
  // ---------------------------------------------------------------------------

  void _onAmountChanged() {
    if (_amountError != null) setState(() => _amountError = null);
    setState(() {}); // re-render FX summary
  }

  /// The amount the user typed — in the **destination** (target country) currency.
  /// e.g. the user types KES when buying airtime for a Kenyan number.
  double get _enteredDestAmount =>
      double.tryParse(_amountController.text.replaceAll(',', '')) ?? 0;

  /// Derived sender-currency amount (what the user's wallet gets debited).
  /// fxRate is sender-per-dest (e.g. ~12 NGN per 1 KES), so sender = dest * fxRate.
  double get _derivedSenderAmount {
    final op = _selectedOperator;
    if (op == null || op.fxRate <= 0) return 0;
    return _enteredDestAmount * op.fxRate;
  }

  bool get _isFixed => _selectedOperator?.isFixed ?? false;

  // ---------------------------------------------------------------------------
  // Continue → review
  // ---------------------------------------------------------------------------

  bool _validate() {
    final phoneErr = _phoneValidationError();
    if (phoneErr != null) {
      setState(() => _phoneError = phoneErr);
      return false;
    }
    final op = _selectedOperator;
    if (op == null) {
      setState(() => _phoneError = 'Could not determine network. Pick one below.');
      return false;
    }

    if (_isFixed) {
      if (_selectedDestFixed <= 0) {
        setState(() => _amountError = 'Pick a denomination');
        return false;
      }
    } else {
      // Validate against destination-currency bounds (localMin/localMax).
      // Fall back to sender min/max divided by rate if the operator didn't
      // expose local bounds.
      final destAmt = _enteredDestAmount;
      if (destAmt <= 0) {
        setState(() => _amountError = 'Enter an amount');
        return false;
      }
      final hasLocal =
          op.localMinAmount > 0 || op.localMaxAmount > 0;
      final minDest = hasLocal
          ? op.localMinAmount
          : (op.fxRate > 0 ? op.minAmount / op.fxRate : op.minAmount);
      final maxDest = hasLocal
          ? op.localMaxAmount
          : (op.fxRate > 0 ? op.maxAmount / op.fxRate : op.maxAmount);
      if (minDest > 0 && destAmt < minDest) {
        setState(() => _amountError =
            'Minimum is ${op.destCurrencyCode} ${minDest.toStringAsFixed(0)}');
        return false;
      }
      if (maxDest > 0 && destAmt > maxDest) {
        setState(() => _amountError =
            'Maximum is ${op.destCurrencyCode} ${maxDest.toStringAsFixed(0)}');
        return false;
      }
    }

    setState(() {
      _phoneError = null;
      _amountError = null;
    });
    return true;
  }

  void _continue() {
    if (!_validate()) return;
    final op = _selectedOperator!;
    final destAmt = _isFixed ? _selectedDestFixed : _enteredDestAmount;
    final senderAmt = _isFixed ? _selectedSenderFixed : _derivedSenderAmount;

    Get.toNamed(
      AppRoutes.intlAirtimeReview,
      arguments: {
        'country': _country,
        'operator': op,
        'phoneNumber': _fullPhone,
        'amount': senderAmt, // what the wallet gets debited in active currency
        'senderCurrency': _activeCurrency,
        'destAmount': destAmt,
        'fxRate': op.fxRate,
        'useLocalAmount': true,
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntlAirtimeCubit, IntlAirtimeState>(
      listener: (context, state) {
        if (state is IntlAirtimeCountriesLoaded) {
          _hydrateFromCountriesLoaded(state.countries);
        } else if (state is IntlAirtimeOperatorsLoaded && _isRepeat &&
            _selectedOperator == null) {
          // Repeat path: auto-select the operator we previously used so the
          // grid pre-locks on it and the amount becomes the only editable
          // field.
          IntlAirtimeOperator? match;
          for (final op in state.operators) {
            final byId = _repeatReloadlyOperatorId != null &&
                _repeatReloadlyOperatorId!.isNotEmpty &&
                op.reloadlyOperatorId == _repeatReloadlyOperatorId;
            final byName = _repeatOperatorName != null &&
                _repeatOperatorName!.isNotEmpty &&
                op.operatorName.toLowerCase() ==
                    _repeatOperatorName!.toLowerCase();
            if (byId || byName) {
              match = op;
              break;
            }
          }
          setState(() {
            _operators = state.operators;
            _selectedOperator = match ?? state.operators.first;
            _operatorAutoDetected = true; // lock the grid for repeat
          });
        } else if (state is IntlAirtimeOperatorsLoaded) {
          setState(() {
            _operators = state.operators;
            // Default-select the first operator if we don't yet have one —
            // auto-detect will override as soon as the phone is long enough.
            if (_selectedOperator == null && state.operators.isNotEmpty) {
              _selectedOperator = state.operators.first;
            }
          });
        } else if (state is IntlAirtimeOperatorDetected) {
          setState(() {
            _selectedOperator = state.operator;
            _operatorAutoDetected = true;
            _selectedDestFixed = 0;
            _selectedSenderFixed = 0;
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        // Always render an AppBar so the back arrow is reachable even
        // when country resolution is in flight or has failed — users
        // who landed here from a stale Repeat handoff need a way out.
        appBar: _country == null
            ? AppBar(
                backgroundColor: const Color(0xFF0A0A0A),
                elevation: 0,
                leading: GestureDetector(
                  onTap: Get.back,
                  child:
                      const Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
                title: Text(
                  'International Airtime',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700),
                ),
                centerTitle: true,
              )
            : _buildAppBar(),
        body: _country == null
            ? _buildCountryResolutionPlaceholder()
            : SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              _buildCountryHeader(),
              SizedBox(height: 20.h),
              _sectionLabel('Recipient Phone Number'),
              SizedBox(height: 8.h),
              _buildPhoneInput(),
              if (_phoneError != null) ...[
                SizedBox(height: 6.h),
                Text(
                  _phoneError!,
                  style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp),
                ),
              ],
              SizedBox(height: 20.h),
              _sectionLabel('Network'),
              SizedBox(height: 8.h),
              _buildOperatorPicker(),
              if (_selectedOperator != null) ...[
                SizedBox(height: 24.h),
                _sectionLabel(_isFixed ? 'Choose Denomination' : 'Amount'),
                SizedBox(height: 8.h),
                if (_isFixed) _buildFixedGrid() else _buildRangeInput(),
                if (_amountError != null) ...[
                  SizedBox(height: 6.h),
                  Text(
                    _amountError!,
                    style: TextStyle(
                        color: const Color(0xFFEF4444), fontSize: 12.sp),
                  ),
                ],
                if (!_isFixed) ...[
                  SizedBox(height: 14.h),
                  _buildQuickAmounts(),
                ],
                SizedBox(height: 20.h),
                _buildFxSummary(),
              ],
              SizedBox(height: 28.h),
              _buildContinueButton(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountryResolutionPlaceholder() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_countryResolutionFailed) ...[
              Icon(Icons.error_outline,
                  size: 48.sp, color: const Color(0xFFEF4444)),
              SizedBox(height: 16.h),
              Text(
                "Couldn't load that country",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Pick a country to continue with your international top-up.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 13.sp),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => Get.offNamed(
                    AppRoutes.intlAirtimeCountrySelection),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  padding: EdgeInsets.symmetric(
                      horizontal: 28.w, vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Pick a country',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ] else ...[
              const CircularProgressIndicator(color: Color(0xFF4E03D0)),
              SizedBox(height: 16.h),
              Text(
                'Loading country…',
                style: TextStyle(
                    color: const Color(0xFF9CA3AF), fontSize: 13.sp),
              ),
            ],
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'International Airtime',
          style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      );

  Widget _sectionLabel(String text) => Text(
        text,
        style: TextStyle(
          color: const Color(0xFF9CA3AF),
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      );

  Widget _buildCountryHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Text(
            _country!.flagEmoji.isNotEmpty ? _country!.flagEmoji : '🌍',
            style: TextStyle(fontSize: 30.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _country!.countryName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${_country!.dialCode} · ${_country!.currencyCode}',
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: _phoneError != null
              ? const Color(0xFFEF4444)
              : const Color(0xFF2D2D2D),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(color: Color(0xFF2D2D2D))),
            ),
            child: Text(
              _country!.dialCode.isNotEmpty ? _country!.dialCode : '+?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              readOnly: _phoneLocked,
              enabled: !_phoneLocked,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                // Cap at NSN max + 1 so users can type the trunk-0 prefix
                // their country conventionally uses (e.g. GH `024xxxxxxx`,
                // GB `07xxxxxxxxx`). Validation strips the leading 0 before
                // the length check, so the effective NSN budget stays max.
                LengthLimitingTextInputFormatter(_digitRange[1] + 1),
              ],
              style: TextStyle(
                  color: _phoneLocked
                      ? Colors.white.withValues(alpha: 0.65)
                      : Colors.white,
                  fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                suffixIcon: _phoneLocked
                    ? Icon(Icons.lock,
                        size: 16.sp,
                        color: Colors.white.withValues(alpha: 0.5))
                    : null,
              ),
            ),
          ),
          BlocBuilder<IntlAirtimeCubit, IntlAirtimeState>(
            builder: (context, state) {
              if (state is IntlAirtimeLoading) {
                return Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF4E03D0),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOperatorPicker() {
    if (_operators.isEmpty) {
      return Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          'Loading networks…',
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
        ),
      );
    }

    final op = _selectedOperator;
    return GestureDetector(
      onTap: () async {
        final selected = await IntlOperatorBottomSheet.show(
          context: context,
          operators: _operators,
          selectedOperator: op,
          autoDetectedOperator: _operatorAutoDetected ? op : null,
        );
        if (selected != null) {
          setState(() {
            _selectedOperator = selected;
            _operatorAutoDetected = false;
            _selectedDestFixed = 0;
            _selectedSenderFixed = 0;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _operatorAutoDetected
                ? const Color(0xFF10B981).withValues(alpha: 0.5)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            if (op != null && op.logoUrl.isNotEmpty)
              Image.network(
                op.logoUrl,
                width: 28.w,
                height: 28.w,
                errorBuilder: (_, __, ___) => Icon(Icons.signal_cellular_alt,
                    color: const Color(0xFF9CA3AF), size: 22.sp),
              )
            else
              Icon(Icons.signal_cellular_alt,
                  color: const Color(0xFF9CA3AF), size: 22.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                op?.operatorName ?? 'Select Network',
                style: TextStyle(
                  color: op != null ? Colors.white : const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: const Color(0xFF9CA3AF), size: 20.sp),
            SizedBox(width: 4.w),
            if (_operatorAutoDetected)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'Auto',
                  style: TextStyle(
                    color: const Color(0xFF10B981),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRangeInput() {
    final op = _selectedOperator!;
    final hasLocal = op.localMinAmount > 0 || op.localMaxAmount > 0;
    final minDest = hasLocal
        ? op.localMinAmount
        : (op.fxRate > 0 ? op.minAmount / op.fxRate : op.minAmount);
    final maxDest = hasLocal
        ? op.localMaxAmount
        : (op.fxRate > 0 ? op.maxAmount / op.fxRate : op.maxAmount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _amountError != null
                  ? const Color(0xFFEF4444)
                  : const Color(0xFF2D2D2D),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text(
                  // Input is in **target country** currency (e.g. KES for Kenya).
                  op.destCurrencyCode,
                  style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
                  ],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: TextStyle(
                        color: const Color(0xFF2D2D2D), fontSize: 20.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (minDest > 0 || maxDest > 0)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              'Min: ${op.destCurrencyCode} ${minDest.toStringAsFixed(0)}'
              '  –  '
              'Max: ${op.destCurrencyCode} ${maxDest.toStringAsFixed(0)}',
              style: TextStyle(
                  color: const Color(0xFF9CA3AF), fontSize: 11.sp),
            ),
          ),
      ],
    );
  }

  /// Quick-pick denominations in the **target** country currency.
  /// Derived strictly from the operator's min/max as returned by the provider
  /// API — no hardcoded fallback. Quick picks are CLAMPED between localMin
  /// and localMax so the user cannot tap a value the operator would reject.
  /// Returns empty when the operator didn't expose usable bounds — the UI
  /// renders the amount input alone and leaves validation to the provider.
  List<double> _quickDestAmounts() {
    final op = _selectedOperator;
    if (op == null) return const [];
    final bool hasLocal = op.localMinAmount > 0 || op.localMaxAmount > 0;
    // Derive destination-currency bounds. Fallback path is sender/fx — we
    // only attempt that when fxRate is real (> 0); otherwise we have no
    // basis for suggestions and return empty.
    final double minDest = hasLocal
        ? op.localMinAmount.toDouble()
        : (op.fxRate > 0 ? op.minAmount / op.fxRate : 0);
    final double maxDest = hasLocal
        ? op.localMaxAmount.toDouble()
        : (op.fxRate > 0 ? op.maxAmount / op.fxRate : 0);
    if (minDest <= 0) return const [];

    // Build candidate multipliers from min. 2x / 5x / 10x covers a sensible
    // spread for airtime top-up (small → medium → top-up-for-the-month).
    // Filter so every pick sits inside [minDest, maxDest] when maxDest is
    // known — the provider rejects above-max, the UI must not offer it.
    final double base = minDest.ceilToDouble();
    final candidates = <double>[base, base * 2, base * 5, base * 10];
    if (maxDest <= 0) return candidates;
    return candidates.where((a) => a >= minDest && a <= maxDest).toList();
  }

  Widget _buildQuickAmounts() {
    final op = _selectedOperator;
    if (op == null) return const SizedBox.shrink();
    final picks = _quickDestAmounts();
    return Wrap(
      spacing: 10.w,
      runSpacing: 8.h,
      children: picks.map((amt) {
        final active = _enteredDestAmount == amt;
        return GestureDetector(
          onTap: () {
            _amountController.text = amt.toStringAsFixed(0);
            _amountController.selection = TextSelection.fromPosition(
              TextPosition(offset: _amountController.text.length),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: active
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF2D2D2D),
              ),
            ),
            child: Text(
              '${op.destCurrencyCode} ${amt.toStringAsFixed(0)}',
              style: TextStyle(
                color: active ? const Color(0xFF4E03D0) : Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFixedGrid() {
    final op = _selectedOperator!;
    // `parsedFixedAmounts` = sender-currency denominations returned by provider.
    // `parsedLocalFixedAmounts` = matching target-currency face values.
    // If the provider returned empty lists for a FIXED operator we render an
    // explicit error instead of guessing — fabricated denominations would
    // fail at the provider and confuse the user. Reloadly's catalog IS the
    // source of truth for fixed operators.
    final senderList = op.parsedFixedAmounts;
    final destList = op.parsedLocalFixedAmounts;

    if (senderList.isEmpty && destList.isEmpty) {
      return Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFEF4444), width: 1),
        ),
        child: Text(
          'No denominations currently available for this operator. '
          'Try a different operator or contact support.',
          style: TextStyle(color: const Color(0xFFEF4444), fontSize: 13.sp),
        ),
      );
    }

    // Drive the grid off whichever list is populated. Prefer destList (target)
    // so denominations render in the face-value currency the user expects.
    final len = destList.isNotEmpty ? destList.length : senderList.length;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 2.2,
      ),
      itemCount: len,
      itemBuilder: (_, i) {
        final dest = i < destList.length ? destList[i] : 0.0;
        final sender = i < senderList.length
            ? senderList[i]
            : (op.fxRate > 0 ? dest * op.fxRate : 0.0);
        final selected = _selectedDestFixed == dest && dest > 0;
        return GestureDetector(
          onTap: () => setState(() {
            _selectedDestFixed = dest;
            _selectedSenderFixed = sender;
            _amountError = null;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFF4E03D0).withValues(alpha: 0.15)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: selected
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF2D2D2D),
                width: selected ? 1.5 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // Primary: target currency face value (what recipient gets).
                  '${op.destCurrencyCode} ${dest.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFF4E03D0)
                        : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (sender > 0) ...[
                  SizedBox(height: 2.h),
                  Text(
                    // Secondary: active-wallet-currency cost.
                    '$_activeCurrency ${sender.toStringAsFixed(0)}',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF), fontSize: 11.sp),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  /// FX summary — target-currency face value on top ("Recipient Gets"),
  /// active-currency cost on the bottom ("You Pay"). Exchange rate expressed
  /// as "1 <target> ≈ <rate> <active>" so the user sees the quote relative to
  /// their own wallet currency.
  Widget _buildFxSummary() {
    final op = _selectedOperator;
    if (op == null) return const SizedBox.shrink();

    final activeCur = _activeCurrency;
    final destCur = op.destCurrencyCode;
    final destAmt = _isFixed ? _selectedDestFixed : _enteredDestAmount;
    final senderAmt = _isFixed ? _selectedSenderFixed : _derivedSenderAmount;

    if (destAmt <= 0) return const SizedBox.shrink();
    final hasFx = op.fxRate > 0 && activeCur != destCur && senderAmt > 0;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Summary',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 12.h),
          _priceRow(
            'Recipient Gets',
            '$destCur ${_fmt(destAmt)}',
          ),
          if (hasFx) ...[
            SizedBox(height: 8.h),
            _priceRow(
              'Exchange Rate',
              '1 $destCur ≈ ${op.fxRate.toStringAsFixed(2)} $activeCur',
            ),
          ],
          SizedBox(height: 10.h),
          Divider(color: const Color(0xFF2D2D2D), height: 1),
          SizedBox(height: 10.h),
          _priceRow(
            'You Pay',
            '$activeCur ${_fmt(senderAmt)}',
            isTotal: true,
          ),
          if (hasFx) ...[
            SizedBox(height: 4.h),
            Text(
              'Paying in $activeCur from your wallet for a $destCur ${_fmt(destAmt)} top-up',
              style: TextStyle(
                  color: const Color(0xFF6B7280), fontSize: 11.sp),
            ),
          ],
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
            color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 13.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _fmt(double v) {
    if (v >= 100) return v.toStringAsFixed(0);
    return v.toStringAsFixed(2);
  }

  Widget _buildContinueButton() => SizedBox(
        width: double.infinity,
        height: 54.h,
        child: ElevatedButton(
          onPressed: _continue,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4E03D0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r)),
          ),
          child: Text(
            'Review',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700),
          ),
        ),
      );
}
