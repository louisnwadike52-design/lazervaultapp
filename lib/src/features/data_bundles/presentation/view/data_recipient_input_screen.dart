import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../domain/entities/data_plan_entity.dart';

class DataRecipientInputScreen extends StatefulWidget {
  const DataRecipientInputScreen({super.key});

  @override
  State<DataRecipientInputScreen> createState() =>
      _DataRecipientInputScreenState();
}

class _DataRecipientInputScreenState extends State<DataRecipientInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  CountryLocale _selectedDialCountry = CountryLocales.all.first; // Nigeria default
  String? _validationError;

  /// Nigerian mobile prefixes per carrier, keyed by the backend network
  /// code passed via route args from the data-bundles home screen. Uses
  /// the leading-0-stripped form (first 3 digits without the 0) so the
  /// lookup works uniformly whether the user typed `0803…` or `803…`.
  /// Kept inline here rather than in a shared file because airtime/data
  /// are the only two flows that need it and the lists diverge slowly —
  /// centralising would invite staleness in the other flow's mapping.
  static const Map<String, Set<String>> _networkPrefixes = {
    'mtn-data': {
      '703', '704', '706', '707', '801', '803', '806', '810',
      '813', '814', '816', '903', '906', '913', '916',
    },
    'airtel-data': {
      '701', '708', '802', '808', '812', '901', '902', '904',
      '907', '912',
    },
    'glo-data': {
      '705', '805', '807', '811', '815', '905', '915',
    },
    'etisalat-data': {
      '809', '817', '818', '908', '909',
    },
  };

  /// All valid NG mobile prefixes across every operator we support. If the
  /// typed prefix isn't in ANY of these it's definitively not a Nigerian
  /// mobile (or a new prefix we haven't catalogued yet) — in the second
  /// case the provider's validator will reject it with a clearer message
  /// than a generic "wrong network" bounce, so we let it through.
  static final Set<String> _allKnownNigerianPrefixes = {
    for (final prefixes in _networkPrefixes.values) ...prefixes,
  };

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  /// Digits-only, leading-0-stripped form of the current input. Accepts
  /// `0803…` (11 digits) and `803…` (10 digits) interchangeably, so the
  /// validation reads one shape everywhere downstream.
  String _normalizedPhone() {
    final digits = _phoneController.text.trim().replaceAll(RegExp(r'[^\d]'), '');
    return digits.startsWith('0') ? digits.substring(1) : digits;
  }

  /// Build full E.164 phone number with country dial code.
  String _buildFullPhone() {
    return '${_selectedDialCountry.dialCode}${_normalizedPhone()}';
  }

  /// True when [phone] belongs to the carrier identified by [network].
  /// Conservative on two axes so the client never blocks a legitimate
  /// purchase behind a stale whitelist:
  ///
  ///   1. Unknown network key — caller passed something we don't
  ///      recognise (new route code, test harness). Pass-through.
  ///   2. Unknown prefix — the typed prefix isn't in ANY of the known
  ///      Nigerian mobile lists. Could be a new prefix the NCC assigned
  ///      after we last updated `_networkPrefixes`, or a sandbox test
  ///      number. Pass-through so the provider (Reloadly/VTpass/
  ///      Flutterwave) can reject it with their own, more accurate
  ///      message. Catching "wrong network" locally only matters when
  ///      we're *sure* it's the wrong network.
  ///
  /// Phone must be already normalised (leading 0 stripped).
  bool _prefixMatchesNetwork(String phone, String network) {
    final allowed = _networkPrefixes[network];
    if (allowed == null || phone.length < 3) return true;
    final prefix = phone.substring(0, 3);
    if (allowed.contains(prefix)) return true;
    if (!_allKnownNigerianPrefixes.contains(prefix)) return true;
    return false;
  }

  /// Network code → display name for the cross-network error prompt.
  /// Falls back to the code itself if absent, so an unseen network still
  /// gets a coherent message.
  String _networkDisplayFor(String network) {
    switch (network) {
      case 'mtn-data':
        return 'MTN';
      case 'airtel-data':
        return 'Airtel';
      case 'glo-data':
        return 'Glo';
      case 'etisalat-data':
        return '9mobile';
      default:
        return network;
    }
  }

  /// Central validator — returns an error string or null. Shared by
  /// `onChanged` (soft validation) and `onContinue` (hard gate) so the
  /// two code paths can't diverge.
  String? _validatePhone(String normalized, String network) {
    if (normalized.isEmpty) return 'Phone number is required';
    if (normalized.length < 10) return 'Phone number must be 10 digits';
    if (normalized.length > 10) {
      // Defensive: LengthLimitingTextInputFormatter caps at 11 digits
      // with the leading 0, so post-strip we expect exactly 10. Anything
      // longer is malformed input (e.g. user pasted with country code).
      return 'Phone number must be 10 digits';
    }
    if (!_prefixMatchesNetwork(normalized, network)) {
      return "This number isn't on ${_networkDisplayFor(network)}. "
          'Go back and reselect the correct network.';
    }
    return null;
  }

  void _onPhoneChanged(String value) {
    final args = Get.arguments as Map<String, dynamic>;
    final network = args['network'] as String;
    final normalized = _normalizedPhone();
    final error = _validatePhone(normalized, network);
    if (error != _validationError) {
      setState(() => _validationError = error);
    }
  }

  void _onContinue() {
    final args = Get.arguments as Map<String, dynamic>;
    final network = args['network'] as String;
    final normalized = _normalizedPhone();
    final error = _validatePhone(normalized, network);
    if (error != null) {
      setState(() => _validationError = error);
      return;
    }

    final plan = args['plan'] as DataPlanEntity;
    final networkName = args['networkName'] as String;
    final networkColorValue = args['networkColor'] as int;

    Get.toNamed(
      AppRoutes.dataBundlesPaymentConfirmation,
      arguments: {
        'plan': plan,
        'network': network,
        'networkName': networkName,
        'networkColor': networkColorValue,
        'phoneNumber': _buildFullPhone(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final networkName = args['networkName'] as String;
    final networkColorValue = args['networkColor'] as int;
    final networkColor = Color(networkColorValue);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'Phone Number',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // Network info card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFF2D2D2D),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: networkColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.cell_tower,
                        color: networkColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            networkName,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Enter the phone number to receive data',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),

              // Phone number input form
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(
                        color: _validationError != null
                            ? const Color(0xFFEF4444)
                            : const Color(0xFF2D2D2D),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Country code prefix (display only - Nigeria)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xFF2D2D2D),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _selectedDialCountry.flag,
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                _selectedDialCountry.dialCode,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Phone number input
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            onChanged: _onPhoneChanged,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: '801 234 5678',
                              hintStyle: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                                fontSize: 16.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 16.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_validationError != null) ...[
                    SizedBox(height: 6.h),
                    Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text(
                        _validationError!,
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4E03D0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
