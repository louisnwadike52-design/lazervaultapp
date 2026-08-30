import 'dart:convert';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/fcy_account_service.dart';

/// Foreign-currency account activation — the onboarding surface for a USD /
/// GBP / EUR virtual account (Fincra individual accounts, async approval).
///
/// The form collects EXACTLY what Fincra's documented FCY contract requires:
/// personal profile, residential address, financial profile, a government-ID
/// document (details + upload) and an address proof (utility bill or bank
/// statement upload). Nothing is invented client-side; the backend
/// re-validates for completeness and returns precise missing-field messages.
///
/// States:
///   none     → the form.
///   creating → "being processed" view (approval is a compliance review).
///   active   → the issued account details incl. routing (IBAN/sort/SWIFT).
///   failed   → explanation + the form again for resubmission.
class FCYActivationScreen extends StatefulWidget {
  const FCYActivationScreen({super.key});

  @override
  State<FCYActivationScreen> createState() => _FCYActivationScreenState();
}

class _FCYActivationScreenState extends State<FCYActivationScreen> {
  final _service = FCYAccountService();
  final _formKey = GlobalKey<FormState>();

  static const _accent = Color(0xFF4E03D0);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);

  late final String _currency;

  FCYStatus? _status;
  bool _loading = true;
  bool _submitting = false;
  String? _error;

  // ── Form controllers ──────────────────────────────────────────────────
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _otherName = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _birthDate = TextEditingController();
  final _nationality = TextEditingController(text: 'NG');

  final _street = TextEditingController();
  final _houseNumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _zip = TextEditingController();
  final _countryOfResidence = TextEditingController(text: 'NG');

  final _occupation = TextEditingController();
  String _employmentStatus = 'Employed';
  String _sourceOfIncome = 'Salary';
  final _incomeLower = TextEditingController();
  final _incomeUpper = TextEditingController();
  final _monthlyTxCount = TextEditingController();
  final _monthlyTxVolume = TextEditingController();
  final _taxCountry = TextEditingController();
  final _taxNumber = TextEditingController();

  String _docType = 'passport';
  final _docNumber = TextEditingController();
  final _docIssuedCountry = TextEditingController(text: 'NG');
  final _docIssuedDate = TextEditingController();
  final _docExpiryDate = TextEditingController();

  // Issuance is a human-timescale compliance process at Fincra — the backend
  // polls every 10 minutes. Without a client poll the "being set up" screen is
  // a dead end: the account can go live and the user only finds out by leaving
  // and re-entering. Runs ONLY while status is 'creating' and stops the moment
  // it is terminal, so an idle screen costs nothing.
  Timer? _statusPoll;

  String? _idDocUrl;
  String? _addressProofUrl;
  bool _uploadingId = false;
  bool _uploadingProof = false;

  static const _employmentOptions = [
    'Employed', 'Self-employed', 'Business', 'Student', 'Retired', 'Unemployed',
  ];
  static const _incomeSources = [
    'Salary', 'Business', 'Investments', 'Savings', 'Pension', 'Family support',
  ];
  // Fincra's accepted ID types are PER CURRENCY (docs/fcy-required-information,
  // confirmed on the FCY request page): an International Passport works for
  // every currency, but Driver Licence and National ID are accepted for EUR
  // accounts only. Offering them for USD/GBP/CAD would let a user complete the
  // whole form and then fail Fincra compliance days later.
  List<String> get _docTypes => _currency == 'EUR'
      ? const ['passport', 'national_id', 'drivers_license']
      : const ['passport'];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    _currency = (args is Map ? (args['currency'] as String?) : null)
            ?.trim()
            .toUpperCase() ??
        'USD';
    _load();
  }

  @override
  void dispose() {
    for (final c in [
      _firstName, _lastName, _otherName, _email, _phone, _birthDate,
      _nationality, _street, _houseNumber, _city, _state, _zip,
      _countryOfResidence, _occupation, _incomeLower, _incomeUpper,
      _monthlyTxCount, _monthlyTxVolume, _taxCountry, _taxNumber,
      _docNumber, _docIssuedCountry, _docIssuedDate, _docExpiryDate,
    ]) {
      c.dispose();
    }
    _statusPoll?.cancel();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final st = await _service.status(_currency);
      if (!mounted) return;
      setState(() {
        _status = st;
        _loading = false;
      });
      _syncStatusPoll();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  /// Starts polling while the request is pending, stops otherwise.
  /// Idempotent — safe to call after every status read.
  void _syncStatusPoll() {
    final pending = _status?.status == 'creating';
    if (!pending) {
      _statusPoll?.cancel();
      _statusPoll = null;
      return;
    }
    if (_statusPoll != null) return; // already polling
    _statusPoll = Timer.periodic(const Duration(seconds: 20), (_) {
      if (!mounted) return;
      _refreshStatusSilently();
    });
  }

  /// Re-reads status WITHOUT the full-screen spinner, so a poll never flashes
  /// the pending view. A transient failure is ignored: the next tick retries,
  /// and replacing "being set up" with an error would be a worse lie than
  /// simply waiting.
  Future<void> _refreshStatusSilently() async {
    try {
      final st = await _service.status(_currency);
      if (!mounted) return;
      final becameTerminal = st.status != 'creating';
      setState(() => _status = st);
      if (becameTerminal) _syncStatusPoll();
    } catch (_) {/* keep waiting; next tick retries */}
  }

  Future<void> _uploadId() async {
    setState(() => _uploadingId = true);
    try {
      final url = await _service.pickAndUploadDocument();
      if (url != null && mounted) setState(() => _idDocUrl = url);
    } catch (e) {
      _snack(e.toString());
    } finally {
      if (mounted) setState(() => _uploadingId = false);
    }
  }

  Future<void> _uploadProof() async {
    setState(() => _uploadingProof = true);
    try {
      final url = await _service.pickAndUploadDocument();
      if (url != null && mounted) setState(() => _addressProofUrl = url);
    } catch (e) {
      _snack(e.toString());
    } finally {
      if (mounted) setState(() => _uploadingProof = false);
    }
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: const Color(0xFFEF4444),
    ));
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_idDocUrl == null) {
      _snack('Please upload your government-issued ID document.');
      return;
    }
    if (_addressProofUrl == null) {
      _snack('Please upload a utility bill or bank statement (within 3 months).');
      return;
    }
    setState(() => _submitting = true);
    try {
      final message = await _service.submit({
        'currency': _currency,
        'meansOfId': [_idDocUrl],
        'utilityBill': _addressProofUrl,
        'firstName': _firstName.text.trim(),
        'lastName': _lastName.text.trim(),
        'otherName': _otherName.text.trim(),
        'email': _email.text.trim(),
        'phone': _phone.text.trim(),
        'birthDate': _birthDate.text.trim(),
        'nationality': _nationality.text.trim().toUpperCase(),
        'address': {
          'street': _street.text.trim(),
          'number': _houseNumber.text.trim(),
          'city': _city.text.trim(),
          'state': _state.text.trim(),
          'zip': _zip.text.trim(),
          'countryOfResidence': _countryOfResidence.text.trim().toUpperCase(),
        },
        'occupation': _occupation.text.trim(),
        'employmentStatus': _employmentStatus,
        'sourceOfIncome': _sourceOfIncome,
        'accountDesignation': 'Personal use',
        'incomeBandLower': _incomeLower.text.trim(),
        'incomeBandUpper': _incomeUpper.text.trim(),
        'monthlyTransactionCount': _monthlyTxCount.text.trim(),
        'monthlyTransactionVolume': _monthlyTxVolume.text.trim(),
        'taxCountry': _taxCountry.text.trim().toUpperCase(),
        'taxNumber': _taxNumber.text.trim(),
        'document': {
          'type': _docType,
          'number': _docNumber.text.trim(),
          'issuedCountryCode': _docIssuedCountry.text.trim().toUpperCase(),
          'issuedBy': 'government',
          'issuedDate': _docIssuedDate.text.trim(),
          'expirationDate': _docExpiryDate.text.trim(),
        },
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF10B981),
      ));
      await _load();
    } catch (e) {
      _snack(e.toString());
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        title: Text('$_currency account',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: SafeArea(child: _body()),
    );
  }

  Widget _body() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _messageView(Icons.cloud_off, _error!, retry: true);
    }
    switch (_status?.status) {
      case 'active':
        return _activeView();
      case 'creating':
        return _messageView(
          Icons.hourglass_top_rounded,
          _status?.message.isNotEmpty == true
              ? _status!.message
              : 'Your $_currency account is being set up. We\'ll show your details here as soon as it\'s ready.',
        );
      case 'failed':
        return _formView(
            banner:
                'We couldn\'t complete your previous request. Please review your details and documents, then submit again.');
      default:
        return _formView();
    }
  }

  Widget _messageView(IconData icon, String message, {bool retry = false}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: _muted, size: 52.sp),
            SizedBox(height: 18.h),
            Text(message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: const Color(0xFFB6B9C6),
                    fontSize: 14.5.sp,
                    height: 1.6)),
            SizedBox(height: 20.h),
            if (retry)
              ElevatedButton(
                onPressed: _load,
                style: ElevatedButton.styleFrom(backgroundColor: _accent),
                child: Text('Retry',
                    style: GoogleFonts.inter(color: Colors.white)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _activeView() {
    final st = _status!;
    Map<String, dynamic> routing = const {};
    try {
      final decoded = jsonDecode(st.routingDetailsJson);
      if (decoded is Map<String, dynamic>) routing = decoded;
    } catch (_) {}
    return ListView(
      padding: EdgeInsets.all(20.w),
      children: [
        Container(
          padding: EdgeInsets.all(18.w),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: _border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your $_currency account is active',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 14.h),
              _detailRow('Account number', st.accountNumber),
              if (st.accountName.isNotEmpty)
                _detailRow('Account name', st.accountName),
              if (st.bankName.isNotEmpty) _detailRow('Bank', st.bankName),
              for (final e in routing.entries)
                if ('${e.value}'.trim().isNotEmpty)
                  _detailRow(_labelize(e.key), '${e.value}'),
            ],
          ),
        ),
      ],
    );
  }

  static String _labelize(String key) {
    final spaced = key
        .replaceAllMapped(
            RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
        .replaceAll('_', ' ');
    return spaced.isEmpty
        ? key
        : spaced[0].toUpperCase() + spaced.substring(1);
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130.w,
            child: Text(label,
                style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
          ),
          Expanded(
            child: SelectableText(value,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // ── The form ──────────────────────────────────────────────────────────

  Widget _formView({String? banner}) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 32.h),
        children: [
          if (banner != null) ...[
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(banner,
                  style: GoogleFonts.inter(
                      color: const Color(0xFFFBBF24), fontSize: 13.sp)),
            ),
            SizedBox(height: 14.h),
          ],
          Text(
            'Get a $_currency account in your own name to receive '
            'international payments. Approval is a compliance review, so '
            'every detail below must match your documents exactly.',
            style: GoogleFonts.inter(
                color: _muted, fontSize: 13.sp, height: 1.55),
          ),
          _section('Personal details'),
          _field(_firstName, 'First name'),
          _field(_lastName, 'Last name'),
          _field(_otherName, 'Other name (optional)', optional: true),
          _field(_email, 'Email', keyboard: TextInputType.emailAddress),
          _field(_phone, 'Phone number', keyboard: TextInputType.phone),
          _field(_birthDate, 'Date of birth (YYYY-MM-DD)',
              hint: '1990-05-21', validator: _dateValidator),
          _field(_nationality, 'Nationality (2-letter code)', hint: 'NG',
              validator: _countryValidator),
          _section('Residential address'),
          _field(_street, 'Street'),
          _field(_houseNumber, 'House number'),
          _field(_city, 'City'),
          _field(_state, 'State'),
          _field(_zip, 'Postal / ZIP code'),
          _field(_countryOfResidence, 'Country of residence (2-letter code)',
              hint: 'NG', validator: _countryValidator),
          _section('Financial profile'),
          _field(_occupation, 'Occupation'),
          _dropdown('Employment status', _employmentOptions, _employmentStatus,
              (v) => setState(() => _employmentStatus = v)),
          _dropdown('Source of income', _incomeSources, _sourceOfIncome,
              (v) => setState(() => _sourceOfIncome = v)),
          Row(children: [
            Expanded(
                child: _field(_incomeLower, 'Monthly income from ($_currency)',
                    keyboard: TextInputType.number)),
            SizedBox(width: 10.w),
            Expanded(
                child: _field(_incomeUpper, 'to ($_currency)',
                    keyboard: TextInputType.number)),
          ]),
          _field(_monthlyTxCount, 'Expected transactions per month',
              keyboard: TextInputType.number),
          _field(_monthlyTxVolume,
              'Expected monthly volume ($_currency)',
              keyboard: TextInputType.number),
          // Product constraints Fincra applies to personal FCY accounts —
          // shown up front so nobody discovers them after a deposit bounces.
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(
              _currency == 'CAD'
                  ? 'Personal account. Deposits arrive via Interac e-Transfer.'
                  : 'Personal account, capped at 10,000 $_currency per month.',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.sp),
            ),
          ),
          if (_currency == 'USD') ...[
            _field(_taxCountry, 'Tax country (2-letter code)', hint: 'NG',
                validator: _countryValidator),
            _field(_taxNumber, 'Tax number (TIN)'),
          ],
          _section('Identity document'),
          _dropdown('Document type', _docTypes, _docType,
              (v) => setState(() => _docType = v)),
          _field(_docNumber, 'Document number'),
          _field(_docIssuedCountry, 'Issuing country (2-letter code)',
              hint: 'NG', validator: _countryValidator),
          _field(_docIssuedDate, 'Issued date (YYYY-MM-DD)',
              validator: _dateValidator),
          _field(_docExpiryDate, 'Expiry date (YYYY-MM-DD)',
              validator: _dateValidator),
          _section('Documents'),
          _uploadTile(
            title: 'Government-issued ID',
            subtitle:
                'Passport, national ID or driver\'s licence (photo or PDF)',
            uploaded: _idDocUrl != null,
            uploading: _uploadingId,
            onTap: _uploadId,
          ),
          SizedBox(height: 10.h),
          _uploadTile(
            title: 'Proof of address',
            subtitle:
                'Utility bill or bank statement from the last 3 months, matching the address above',
            uploaded: _addressProofUrl != null,
            uploading: _uploadingProof,
            onTap: _uploadProof,
          ),
          SizedBox(height: 26.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitting ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)),
              ),
              child: _submitting
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : Text('Submit for review',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title) => Padding(
        padding: EdgeInsets.only(top: 22.h, bottom: 10.h),
        child: Text(title,
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700)),
      );

  static String? _requiredValidator(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  static String? _dateValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    return RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(v.trim())
        ? null
        : 'Use YYYY-MM-DD';
  }

  static String? _countryValidator(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    return RegExp(r'^[A-Za-z]{2}$').hasMatch(v.trim())
        ? null
        : '2-letter code';
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    String? hint,
    TextInputType? keyboard,
    bool optional = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: optional ? null : (validator ?? _requiredValidator),
        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: GoogleFonts.inter(color: _muted, fontSize: 13.sp),
          hintStyle:
              GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 13.sp),
          filled: true,
          fillColor: _card,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: _border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: _border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: _accent),
          ),
        ),
      ),
    );
  }

  Widget _dropdown(String label, List<String> options, String value,
      ValueChanged<String> onChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        dropdownColor: _card,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.inter(color: _muted, fontSize: 13.sp),
          filled: true,
          fillColor: _card,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: _border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: _border),
          ),
        ),
        items: [
          for (final o in options)
            DropdownMenuItem(
                value: o,
                child: Text(o.replaceAll('_', ' '),
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 14.sp))),
        ],
        onChanged: (v) {
          if (v != null) onChanged(v);
        },
      ),
    );
  }

  Widget _uploadTile({
    required String title,
    required String subtitle,
    required bool uploaded,
    required bool uploading,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: uploading ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
              color: uploaded ? const Color(0xFF10B981) : _border),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (uploaded ? const Color(0xFF10B981) : _accent)
                    .withValues(alpha: 0.15),
              ),
              child: uploading
                  ? Padding(
                      padding: EdgeInsets.all(10.w),
                      child: const CircularProgressIndicator(strokeWidth: 2))
                  : Icon(
                      uploaded
                          ? Icons.check_circle_outline
                          : Icons.upload_file_outlined,
                      color: uploaded
                          ? const Color(0xFF10B981)
                          : const Color(0xFF9B6DFF),
                      size: 22.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 3.h),
                  Text(uploaded ? 'Uploaded — tap to replace' : subtitle,
                      style: GoogleFonts.inter(
                          color: uploaded ? const Color(0xFF10B981) : _muted,
                          fontSize: 12.sp,
                          height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
