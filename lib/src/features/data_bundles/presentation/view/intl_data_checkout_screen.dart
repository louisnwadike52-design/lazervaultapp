import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../domain/entities/intl_data_bundle.dart';
import '../../domain/entities/intl_data_operator.dart';

/// Per-country phone number spec: dial code, national-significant-number
/// length (or min/max range), and whether a leading `0` is conventionally
/// typed. Reused by [IntlDataCheckoutScreen] for phone validation.
class IntlDataCountry {
  final String code;
  final String name;
  final String dial;
  final String flag;
  final int nsnMin;
  final int nsnMax;
  final bool leadingZeroAllowed;
  const IntlDataCountry(
    this.code,
    this.name,
    this.dial,
    this.flag, {
    required this.nsnMin,
    required this.nsnMax,
    required this.leadingZeroAllowed,
  });

  /// Master list of Reloadly-supported markets for data bundles with
  /// accurate per-country NSN (national significant number) lengths and
  /// trunk-zero conventions. Validation is handled locally before we
  /// ever call the backend / Reloadly /topups API — any phone outside
  /// [nsnMin, nsnMax] would be rejected upstream anyway, so we catch it
  /// client-side to give users an instant error instead of a round-trip.
  ///
  /// Lengths sourced from ITU E.164 national-number specs and Reloadly's
  /// published supported-country catalogue (mobile MSISDN ranges).
  /// `leadingZeroAllowed` mirrors each country's domestic dialling
  /// convention — when true, users can type `0xxx…` and validation
  /// strips the trunk zero before length-checking (see
  /// [_IntlDataCheckoutScreenState._normalisedNsn]).
  static const List<IntlDataCountry> all = [
    // West Africa
    IntlDataCountry('NG', 'Nigeria', '+234', '\u{1F1F3}\u{1F1EC}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('GH', 'Ghana', '+233', '\u{1F1EC}\u{1F1ED}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('CI', 'Cote d\'Ivoire', '+225', '\u{1F1E8}\u{1F1EE}', nsnMin: 8, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('SN', 'Senegal', '+221', '\u{1F1F8}\u{1F1F3}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('CM', 'Cameroon', '+237', '\u{1F1E8}\u{1F1F2}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    // East Africa
    IntlDataCountry('KE', 'Kenya', '+254', '\u{1F1F0}\u{1F1EA}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('TZ', 'Tanzania', '+255', '\u{1F1F9}\u{1F1FF}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('UG', 'Uganda', '+256', '\u{1F1FA}\u{1F1EC}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('RW', 'Rwanda', '+250', '\u{1F1F7}\u{1F1FC}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('ET', 'Ethiopia', '+251', '\u{1F1EA}\u{1F1F9}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    // North & Southern Africa
    IntlDataCountry('EG', 'Egypt', '+20', '\u{1F1EA}\u{1F1EC}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('MA', 'Morocco', '+212', '\u{1F1F2}\u{1F1E6}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('ZA', 'South Africa', '+27', '\u{1F1FF}\u{1F1E6}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    // Americas
    IntlDataCountry('US', 'United States', '+1', '\u{1F1FA}\u{1F1F8}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('CA', 'Canada', '+1', '\u{1F1E8}\u{1F1E6}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('MX', 'Mexico', '+52', '\u{1F1F2}\u{1F1FD}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('BR', 'Brazil', '+55', '\u{1F1E7}\u{1F1F7}', nsnMin: 10, nsnMax: 11, leadingZeroAllowed: false),
    IntlDataCountry('AR', 'Argentina', '+54', '\u{1F1E6}\u{1F1F7}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    // Europe
    IntlDataCountry('GB', 'United Kingdom', '+44', '\u{1F1EC}\u{1F1E7}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('DE', 'Germany', '+49', '\u{1F1E9}\u{1F1EA}', nsnMin: 10, nsnMax: 11, leadingZeroAllowed: true),
    IntlDataCountry('FR', 'France', '+33', '\u{1F1EB}\u{1F1F7}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('ES', 'Spain', '+34', '\u{1F1EA}\u{1F1F8}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('IT', 'Italy', '+39', '\u{1F1EE}\u{1F1F9}', nsnMin: 9, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('NL', 'Netherlands', '+31', '\u{1F1F3}\u{1F1F1}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('PL', 'Poland', '+48', '\u{1F1F5}\u{1F1F1}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('PT', 'Portugal', '+351', '\u{1F1F5}\u{1F1F9}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: false),
    IntlDataCountry('TR', 'Turkey', '+90', '\u{1F1F9}\u{1F1F7}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    // Middle East
    IntlDataCountry('AE', 'United Arab Emirates', '+971', '\u{1F1E6}\u{1F1EA}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('SA', 'Saudi Arabia', '+966', '\u{1F1F8}\u{1F1E6}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    // Asia
    IntlDataCountry('IN', 'India', '+91', '\u{1F1EE}\u{1F1F3}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: false),
    IntlDataCountry('PK', 'Pakistan', '+92', '\u{1F1F5}\u{1F1F0}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('BD', 'Bangladesh', '+880', '\u{1F1E7}\u{1F1E9}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('PH', 'Philippines', '+63', '\u{1F1F5}\u{1F1ED}', nsnMin: 10, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('ID', 'Indonesia', '+62', '\u{1F1EE}\u{1F1E9}', nsnMin: 9, nsnMax: 12, leadingZeroAllowed: true),
    IntlDataCountry('MY', 'Malaysia', '+60', '\u{1F1F2}\u{1F1FE}', nsnMin: 9, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('TH', 'Thailand', '+66', '\u{1F1F9}\u{1F1ED}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('VN', 'Vietnam', '+84', '\u{1F1FB}\u{1F1F3}', nsnMin: 9, nsnMax: 10, leadingZeroAllowed: true),
    IntlDataCountry('CN', 'China', '+86', '\u{1F1E8}\u{1F1F3}', nsnMin: 11, nsnMax: 11, leadingZeroAllowed: false),
    // Oceania
    IntlDataCountry('AU', 'Australia', '+61', '\u{1F1E6}\u{1F1FA}', nsnMin: 9, nsnMax: 9, leadingZeroAllowed: true),
    IntlDataCountry('NZ', 'New Zealand', '+64', '\u{1F1F3}\u{1F1FF}', nsnMin: 8, nsnMax: 10, leadingZeroAllowed: true),
  ];

  /// Lookup by ISO-2 code.
  static IntlDataCountry? byCode(String code) {
    for (final c in all) {
      if (c.code == code) return c;
    }
    return null;
  }
}

/// Screen 2 of the international data purchase flow.
/// Shows a review card for the selected bundle + recipient phone input
/// with per-country validation + "Confirm & Pay" CTA that opens the
/// TransactionPin bottom sheet.
class IntlDataCheckoutScreen extends StatefulWidget {
  const IntlDataCheckoutScreen({super.key});

  @override
  State<IntlDataCheckoutScreen> createState() =>
      _IntlDataCheckoutScreenState();
}

class _IntlDataCheckoutScreenState extends State<IntlDataCheckoutScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _primary = Color(0xFF4E03D0);
  static const Color _text2 = Color(0xFF9CA3AF);

  final _phoneController = TextEditingController();
  final LocaleManager _localeManager = GetIt.I<LocaleManager>();

  late final IntlDataCountry _country;
  late final IntlDataOperator _operator;
  late final IntlDataBundle _bundle;

  /// User's active locale currency (e.g. NGN). Mirrors intl airtime pattern.
  String get _activeCurrency => _localeManager.currentCurrency;

  /// Effective FX rate — prefer the bundle's own snapshot (most
  /// accurate at list time); fall back to the operator's rate.
  double get _fxRate => _bundle.fxRate > 0 ? _bundle.fxRate : _operator.fxRate;

  /// Active-locale-currency amount computed from dest amount * FX rate.
  /// When FX is missing we do NOT fall back to Reloadly's sender wallet
  /// amount (which would be GBP/USD, wrong units for the user) — the
  /// caller should block continue instead.
  double get _senderAmount =>
      _fxRate > 0 ? _bundle.localAmount * _fxRate : 0;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _country = args['country'] as IntlDataCountry;
    _operator = args['operator'] as IntlDataOperator;
    _bundle = args['bundle'] as IntlDataBundle;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // ---- Phone validation (moved from intl_data_purchase_screen) ----

  /// Normalises raw digits to an NSN without leading zero. Returns null
  /// when the length is wrong or a leading zero was entered in a country
  /// that doesn't use it.
  String? _normalisedNsn(String raw) {
    var digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return null;
    if (digits.startsWith('0')) {
      if (!_country.leadingZeroAllowed) return null;
      digits = digits.substring(1);
    }
    if (digits.length < _country.nsnMin || digits.length > _country.nsnMax) {
      return null;
    }
    return digits;
  }

  /// Provider-ready E.164 number WITHOUT the `+` prefix.
  String? _phoneForProvider() {
    final nsn = _normalisedNsn(_phoneController.text);
    if (nsn == null) return null;
    final dial = _country.dial.replaceFirst('+', '');
    return '$dial$nsn';
  }

  // ---- Build ----

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildReviewCard(),
                    SizedBox(height: 24.h),
                    _sectionHeader('Recipient Phone'),
                    SizedBox(height: 10.h),
                    _recipientInput(),
                    SizedBox(height: 20.h),
                    _confirmButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Confirm Data Bundle',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String s) => Text(
        s,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      );

  Widget _buildReviewCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: _primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(_country.flag, style: TextStyle(fontSize: 22.sp)),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  _operator.operatorName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          const Divider(color: Color(0xFF2D2D2D)),
          SizedBox(height: 10.h),
          _row('Country', _country.name),
          _row('Bundle', _bundle.description),
          _row(
            'Recipient gets',
            '${_bundle.destCurrencyCode} ${_bundle.localAmount.toStringAsFixed(2)}',
          ),
          _row(
            'You pay',
            _fxRate > 0
                ? '$_activeCurrency ${_senderAmount.toStringAsFixed(2)}'
                : 'Rate unavailable',
            highlight: true,
          ),
          if (_fxRate > 0 &&
              _bundle.destCurrencyCode.toUpperCase() !=
                  _activeCurrency.toUpperCase())
            _row(
              'Exchange rate',
              '1 ${_bundle.destCurrencyCode} = ${_fxRate.toStringAsFixed(4)} $_activeCurrency',
            ),
        ],
      ),
    );
  }

  Widget _row(String k, String v, {bool highlight = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(k, style: TextStyle(color: _text2, fontSize: 12.sp)),
          Flexible(
            child: Text(
              v,
              style: TextStyle(
                color: highlight ? _primary : Colors.white,
                fontSize: 13.sp,
                fontWeight: highlight ? FontWeight.w700 : FontWeight.w600,
              ),
              textAlign: TextAlign.end,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipientInput() {
    final hint =
        '${_country.nsnMin}${_country.nsnMax != _country.nsnMin ? "-${_country.nsnMax}" : ""} digits';
    final error = _phoneController.text.isEmpty
        ? null
        : (_normalisedNsn(_phoneController.text) == null
            ? 'Invalid ${_country.name} number'
            : null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: _card,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _primary.withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_country.flag, style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 6.w),
                  Text(
                    _country.dial,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  // `nsnMax + 1` covers a single trunk-0 prefix when the
                  // country conventionally uses one (GH, GB, ZA, etc.);
                  // validation strips the zero before the length check.
                  LengthLimitingTextInputFormatter(
                    _country.leadingZeroAllowed
                        ? _country.nsnMax + 1
                        : _country.nsnMax,
                  ),
                ],
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: _text2, fontSize: 13.sp),
                  filled: true,
                  fillColor: _card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                ),
              ),
            ),
          ],
        ),
        if (error != null) ...[
          SizedBox(height: 6.h),
          Text(
            error,
            style: TextStyle(
              color: const Color(0xFFEF4444),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ] else if (_normalisedNsn(_phoneController.text) != null) ...[
          SizedBox(height: 6.h),
          Text(
            'Will send to ${_country.dial}${_normalisedNsn(_phoneController.text)!}',
            style: TextStyle(
              color: const Color(0xFF10B981),
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _confirmButton() {
    final phoneValid = _normalisedNsn(_phoneController.text) != null;
    // Block continue when FX is missing — we must never charge the
    // user's wallet based on Reloadly's sender currency amount.
    final fxReady = _fxRate > 0 && _senderAmount > 0;
    final enabled = phoneValid && fxReady;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? _startBuyFlow : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: Colors.white,
          // Faded primary (not `_card`) when disabled so the button
          // doesn't read as an "empty dark rectangle" below the phone
          // input. Text stays white so the "Confirm & Pay" label is
          // always visible — matches the data confirm screen pattern.
          disabledBackgroundColor: _primary.withValues(alpha: 0.35),
          disabledForegroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r)),
        ),
        child: Text(
          'Confirm & Pay',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _startBuyFlow() async {
    final providerPhone = _phoneForProvider();
    if (providerPhone == null) {
      Get.snackbar('Invalid number',
          'Please enter a valid ${_country.name} phone number.',
          backgroundColor: const Color(0xFFEF4444), colorText: Colors.white);
      return;
    }

    final txId = 'IDATA-${DateTime.now().millisecondsSinceEpoch}';
    String? verificationToken;
    final ok = await validateTransactionPin(
      context: context,
      transactionId: txId,
      transactionType: 'intl_data_purchase',
      amount: _senderAmount,
      currency: _activeCurrency,
      title: 'Confirm International Data',
      message:
          'Send ${_bundle.destCurrencyCode} ${_bundle.localAmount.toStringAsFixed(2)} '
          'data bundle to $providerPhone',
      showProcessingPhase: false,
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );
    if (!ok || verificationToken == null) return;
    if (!mounted) return;

    // Navigate to the processing screen with all needed params.
    Get.toNamed(
      AppRoutes.intlDataProcessing,
      arguments: {
        'country': _country,
        'operator': _operator,
        'bundle': _bundle,
        'providerPhone': providerPhone,
        'transactionId': txId,
        'verificationToken': verificationToken!,
        'senderCurrency': _activeCurrency,
        'senderAmount': _senderAmount,
      },
    );
  }
}
