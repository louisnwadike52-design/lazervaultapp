import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../domain/entities/network_rate.dart';
import '../cubit/airtime_to_cash_cubit.dart';
import '../cubit/airtime_to_cash_state.dart';

/// AirtimeToCash.com (OTP) airtime-to-cash input screen.
/// Flow: Generate OTP → Verify OTP → Login with Session → Check Quota → Transfer
class AutomationAirtimeToCashScreen extends StatefulWidget {
  const AutomationAirtimeToCashScreen({super.key});

  @override
  State<AutomationAirtimeToCashScreen> createState() =>
      _AutomationAirtimeToCashScreenState();
}

class _AutomationAirtimeToCashScreenState
    extends State<AutomationAirtimeToCashScreen>
    with TransactionPinMixin<AutomationAirtimeToCashScreen> {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _otpController = TextEditingController();
  final _simPinController = TextEditingController();
  final _phoneFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _otpFocusNode = FocusNode();
  final _simPinFocusNode = FocusNode();

  String? _selectedNetwork;
  bool _phoneValid = false;
  String? _detectedNetwork;
  double? _amount;
  String? _sessionId;
  bool _otpSent = false;
  bool _otpVerified = false;

  // Per-network rates + limits are loaded from the backend
  // (GetAirtimeToCashRates → provider GetRates) on screen init and kept
  // in these instance maps. NO values are hardcoded here — if the RPC
  // has not yet returned, UI fields render disabled and amount validation
  // returns false until the rates arrive.
  Map<String, double> _networkRates = const {};
  Map<String, Map<String, double>> _networkLimits = const {};
  // Per-network automation fee from the provider's tariffInfo. Currently
  // surfaced only for logging/future UI copy; kept in state so it stays
  // in lockstep with rates when they're refreshed.
  // ignore: unused_field
  Map<String, double> _networkFees = const {};

  static const _networkOrder = ['mtn', 'airtel', 'glo', '9mobile'];

  static const _quickAmounts = [100.0, 500.0, 1000.0, 2000.0, 5000.0];

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
    // Pull per-network rates + limits from the backend so neither the UI
    // nor validation rely on hardcoded values.
    context.read<AirtimeToCashCubit>().loadRates();
  }

  void _applyLoadedRates(List<NetworkRate> rates) {
    if (!mounted) return;
    final nextRates = <String, double>{};
    final nextLimits = <String, Map<String, double>>{};
    final nextFees = <String, double>{};
    for (final r in rates) {
      final key = r.network.toLowerCase();
      nextRates[key] = r.conversionRate;
      nextLimits[key] = {'min': r.minAmount, 'max': r.maxAmount};
      nextFees[key] = r.automationFee;
    }
    setState(() {
      _networkRates = nextRates;
      _networkLimits = nextLimits;
      _networkFees = nextFees;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    _otpController.dispose();
    _simPinController.dispose();
    _phoneFocusNode.dispose();
    _amountFocusNode.dispose();
    _otpFocusNode.dispose();
    _simPinFocusNode.dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    if (!mounted) return;
    final phone = _phoneController.text;
    final valid = phone.length == 11 && phone.startsWith('0');
    if (valid != _phoneValid) {
      setState(() => _phoneValid = valid);
    }

    if (phone.length >= 4) {
      final detected = _detectNetworkFromPrefix(phone);
      if (detected != _detectedNetwork) {
        setState(() => _detectedNetwork = detected);
        if (detected != null) {
          setState(() => _selectedNetwork = detected);
        }
      }
    } else if (_detectedNetwork != null) {
      setState(() => _detectedNetwork = null);
    }
  }

  String? _detectNetworkFromPrefix(String phone) {
    if (phone.length < 4) return null;
    final p = phone.substring(0, 4);
    const mtn = [
      '0803', '0806', '0810', '0813', '0814', '0816', '0903',
      '0906', '0913', '0916', '0703', '0706'
    ];
    const airtel = [
      '0802', '0808', '0812', '0701', '0708', '0901',
      '0902', '0904', '0907', '0912'
    ];
    const glo = ['0805', '0807', '0811', '0815', '0905', '0915', '0705'];
    const mobile9 = ['0809', '0817', '0818', '0908', '0909'];
    if (mtn.contains(p)) return 'mtn';
    if (airtel.contains(p)) return 'airtel';
    if (glo.contains(p)) return 'glo';
    if (mobile9.contains(p)) return '9mobile';
    return null;
  }

  // Non-MTN on automation is blocked at the provider ("Please Enter
  // Valid MTN Number") — gate the OTP CTA so users don't hit it after
  // waiting for SMS. The advisory banner above explains why.
  bool get _canSendOTP =>
      _phoneValid &&
      _selectedNetwork != null &&
      !_isNetworkUnsupportedOnAutomation;

  bool get _canVerifyOTP => _otpSent && _otpController.text.length == 6;

  bool get _isSimPinValid => _simPinController.text.length == 4;

  bool get _canProceed =>
      _otpVerified &&
      _amount != null &&
      _selectedNetwork != null &&
      _isSimPinValid;

  // Per-network shortcode for setting/recovering the SIM transfer PIN.
  // These USSD codes are published by each NG MNO; sourced from each
  // operator's official self-service docs.
  static const Map<String, String> _simPinShortCodes = {
    'mtn': '*600#',
    'airtel': '*432#',
    'glo': '*100*4#',
    '9mobile': '*247#',
  };

  String _simPinHelperFor(String? network) {
    if (network == null) {
      return 'Your 4-digit SIM transfer PIN. Tap "How to find this" if you don\u2019t have one yet.';
    }
    final code = _simPinShortCodes[network] ?? '*600#';
    return 'Your 4-digit SIM transfer PIN. Dial $code on your ${_networkLabel(network)} line if you don\u2019t have one set.';
  }

  bool get _isAmountValid {
    if (_amount == null || _selectedNetwork == null) return false;
    final limits = _networkLimits[_selectedNetwork!];
    if (limits == null) return false;
    return _amount! >= limits['min']! && _amount! <= limits['max']!;
  }

  // Inline validation message for the amount field — null when the amount
  // is valid/empty, a specific reason when outside the provider's range.
  // Drives the red helper line under the TextField so users know what
  // to type before they tap Continue.
  String? get _amountErrorMessage {
    if (_amount == null || _selectedNetwork == null) return null;
    final limits = _networkLimits[_selectedNetwork!];
    if (limits == null) {
      return 'Loading limits for ${_networkLabel(_selectedNetwork!)}\u2026';
    }
    final min = limits['min']!;
    final max = limits['max']!;
    if (_amount! < min) {
      return 'Minimum for ${_networkLabel(_selectedNetwork!)} is \u20A6${min.toStringAsFixed(0)}';
    }
    if (_amount! > max) {
      return 'Maximum for ${_networkLabel(_selectedNetwork!)} is \u20A6${max.toStringAsFixed(0)}';
    }
    return null;
  }

  // airtimetocash.com's automation API rejects non-MTN numbers on our
  // current bearer with "Please Enter Valid MTN Number" even though
  // their docs claim multi-network support. Surface that to the user
  // proactively instead of letting them hit the error after OTP send.
  // Removing this advisory is a one-line change once the provider
  // enables AIRTEL/GLO/9MOBILE on our account.
  bool get _isNetworkUnsupportedOnAutomation =>
      _selectedNetwork != null && _selectedNetwork != 'mtn';

  double get _estimatedCash {
    if (_amount == null || _selectedNetwork == null) return 0;
    final rate = _networkRates[_selectedNetwork!] ?? 0.7;
    return _amount! * rate;
  }

  void _sendOTP() {
    if (!_canSendOTP) return;
    final phone = _phoneController.text.trim();
    final network = _selectedNetwork!;

    context.read<AirtimeToCashCubit>().generateAutomationOTP(
      phoneNumber: phone,
      network: network,
    );
  }

  void _verifyOTP() {
    if (!_canVerifyOTP) return;
    // airtimetocash.com mints the sessionId on /verify/otp — there isn't
    // one yet at this point. The only precondition is _otpSent (the user
    // tapped Send OTP and we got a 2000 from /generate/otp).
    if (!_otpSent) {
      Get.snackbar(
        'No active OTP',
        'Please tap "Send OTP" first to receive a verification code.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
      return;
    }
    final phone = _phoneController.text.trim();
    final network = _selectedNetwork!;
    final otp = _otpController.text.trim();

    context.read<AirtimeToCashCubit>().verifyAutomationOTP(
      phoneNumber: phone,
      network: network,
      otp: otp,
      sessionId: _sessionId ?? '',
    );
  }

  void _checkQuotaAndProceed() {
    if (!_canProceed || !_isAmountValid) return;
    final phone = _phoneController.text.trim();
    final network = _selectedNetwork!;
    final amount = _amount!;

    context.read<AirtimeToCashCubit>().checkAutomationQuota(
      phoneNumber: phone,
      network: network,
      amount: amount,
      sessionId: _sessionId!,
    );
  }

  Future<void> _openTransactionPinSheet() async {
    final phone = _phoneController.text.trim();
    final network = _selectedNetwork!;
    final amount = _amount!;
    final sessionId = _sessionId!;
    final simPin = _simPinController.text;
    final rate = _networkRates[network] ?? 0.7;
    final transactionId =
        'A2C-AUTO-${DateTime.now().millisecondsSinceEpoch}';

    // Collect the verification token inside the PIN callback but do NOT
    // navigate there. If we push a new route while the modal is still on
    // top, the mixin's subsequent `rootNavigator.pop()` pops THAT route
    // (the processing screen), not the modal — leaving the PIN sheet
    // visible and the processing screen dismissed mid-flight. Letting
    // `validateTransactionPin` finish, pop the sheet itself, then
    // navigating here keeps route order correct.
    String? verificationToken;
    final pinValidated = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'airtime_to_cash',
      amount: amount,
      currency: 'NGN',
      currencySymbol: '₦',
      title: 'Confirm Airtime to Cash',
      message:
          'Enter your transaction PIN to convert ₦${amount.toStringAsFixed(0)} airtime to cash',
      showProcessingPhase: false,
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!pinValidated || verificationToken == null) return;
    if (!mounted) return;

    Get.toNamed(AppRoutes.airtimeToCashProcessing, arguments: {
      'phoneNumber': phone,
      'network': network,
      'amount': amount,
      'sessionId': sessionId,
      'providerRate': rate,
      'verificationToken': verificationToken,
      'transactionId': transactionId,
      'method': 'automation',
      // SIM transfer PIN — required by airtimetocash.com
      // /api/v1/transfer/airtime; without it the provider rejects with
      // "The pin field is required." (provider error code 0).
      'pin': simPin,
    });
  }

  Color _networkColor(String network) {
    switch (network.toLowerCase()) {
      case 'mtn':
        return const Color(0xFFFFCC00);
      case 'airtel':
        return const Color(0xFFEF4444);
      case 'glo':
        return const Color(0xFF4E03D0);
      case '9mobile':
        return const Color(0xFF00A651);
      default:
        return const Color(0xFF4E03D0);
    }
  }

  String _networkLabel(String network) {
    switch (network.toLowerCase()) {
      case 'mtn':
        return 'MTN';
      case 'airtel':
        return 'Airtel';
      case 'glo':
        return 'Glo';
      case '9mobile':
        return '9Mobile';
      default:
        return network.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AirtimeToCashCubit, AirtimeToCashState>(
      listener: (context, state) {
        if (state is AirtimeToCashRatesLoaded) {
          _applyLoadedRates(state.rates);
        } else if (state is AirtimeToCashOTPSent) {
          setState(() {
            _otpSent = true;
            _sessionId = state.sessionId;
          });
          Get.snackbar(
            'OTP Sent',
            'Enter the 6-digit code sent to your phone',
            backgroundColor: const Color(0xFF4E03D0),
            colorText: Colors.white,
          );
        } else if (state is AirtimeToCashOTPVerified) {
          setState(() {
            _otpVerified = true;
            _sessionId = state.sessionId;
          });
          Get.snackbar(
            'Phone Verified',
            'You can now proceed with the conversion',
            backgroundColor: const Color(0xFF4E03D0),
            colorText: Colors.white,
          );
        } else if (state is AirtimeToCashQuotaChecked) {
          if (state.available) {
            // Quota available — instead of collecting a SIM transfer PIN, we
            // authorize the wallet debit with the user's LazerVault
            // transaction PIN bottom sheet. On success, jump straight to the
            // processing screen with the verification token so the backend
            // can validate + execute the automation conversion.
            _openTransactionPinSheet();
          } else {
            Get.snackbar(
              'Service Unavailable',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              duration: const Duration(seconds: 4),
            );
          }
        } else if (state is AirtimeToCashError) {
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      _buildAutomationBanner(),
                      SizedBox(height: 20.h),
                      _buildNetworkSelection(),
                      if (_isNetworkUnsupportedOnAutomation) ...[
                        SizedBox(height: 12.h),
                        _buildMtnOnlyAdvisory(),
                      ],
                      SizedBox(height: 20.h),
                      _buildPhoneInput(),
                      if (!_otpVerified) ...[
                        SizedBox(height: 16.h),
                        _buildOTPSection(),
                      ],
                      if (_otpVerified) ...[
                        SizedBox(height: 16.h),
                        _buildAmountInput(),
                        SizedBox(height: 12.h),
                        _buildQuickAmounts(),
                        SizedBox(height: 16.h),
                        _buildSimPinInput(),
                        SizedBox(height: 16.h),
                        if (_amount != null && _selectedNetwork != null)
                          _buildConversionPreview(),
                      ],
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
              _buildBottomButton(),
            ],
          ),
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
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Airtime to Cash',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'We\u2019ll send a 6-digit OTP to your phone via SMS',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationBanner() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4E03D0), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.sms, color: Colors.white, size: 22.sp),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Instant with OTP',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Verify your phone with SMS OTP. Fast and secure.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMtnOnlyAdvisory() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFFB923C).withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16.sp, color: const Color(0xFFFB923C)),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Instant OTP flow currently supports MTN only. For ${_networkLabel(_selectedNetwork!)}, '
              'please use the "Transfer to Number" option on the previous screen.',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.85),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Network',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: _networkOrder.map((network) {
            final isSelected = _selectedNetwork == network;
            final color = _networkColor(network);
            final rate = _networkRates[network] ?? 0.7;
            final limits = _networkLimits[network];
            final locked = _detectedNetwork != null;
            final dimmed = locked && !isSelected;
            return Expanded(
              child: GestureDetector(
                onTap: locked
                    ? () {
                        // Auto-detection from the phone number always wins —
                        // a manual tap that disagrees would silently set us up
                        // to top up the wrong carrier. Snap back to the
                        // detected one and tell the user why.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xFF1F1F1F),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'Network locked to ${_networkLabel(_detectedNetwork!)} based on the phone number. Edit the number to change.',
                              style: TextStyle(color: Colors.white, fontSize: 12.sp),
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        if (_selectedNetwork != _detectedNetwork) {
                          setState(() => _selectedNetwork = _detectedNetwork);
                        }
                      }
                    : () => setState(() => _selectedNetwork = network),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: network != '9mobile' ? 8.w : 0),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? color.withValues(alpha: 0.2)
                        : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected ? color : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  foregroundDecoration: dimmed
                      ? BoxDecoration(
                          color: const Color(0xFF0A0A0A).withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(12.r),
                        )
                      : null,
                  child: Column(
                    children: [
                      Text(
                        _networkLabel(network),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? color : Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${(rate * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color(0xFF4E03D0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (limits != null && isSelected)
                        Text(
                          '₦${limits['min']?.toStringAsFixed(0)}-₦${limits['max']?.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Phone Number',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextField(
            controller: _phoneController,
            focusNode: _phoneFocusNode,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            enabled: !_otpVerified,
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
            decoration: InputDecoration(
              hintText: '08012345678',
              hintStyle: TextStyle(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                fontSize: 16.sp,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                child: Text(
                  '+234',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(),
              suffixIcon: _otpVerified
                  ? Icon(Icons.verified, color: const Color(0xFF4E03D0), size: 20.sp)
                  : _phoneValid
                      ? Icon(Icons.check_circle, color: const Color(0xFF4E03D0), size: 20.sp)
                      : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
        if (_detectedNetwork != null && !_otpVerified) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: _networkColor(_detectedNetwork!).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: const Color(0xFF4E03D0), size: 14.sp),
                SizedBox(width: 6.w),
                Text(
                  'Detected: ${_networkLabel(_detectedNetwork!)}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF4E03D0),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildOTPSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_otpSent) ...[
          Text(
            'Verify Phone Number',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            // The Send OTP action lives on the sticky bottom button to avoid
            // two CTAs on the same page. Keep this copy as the instruction.
            'Tap "Send OTP" below to receive a verification code via SMS.',
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
        if (_otpSent && !_otpVerified) ...[
          Text(
            'Enter OTP',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: TextField(
              controller: _otpController,
              focusNode: _otpFocusNode,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              // Re-render so _canVerifyOTP (which checks
              // _otpController.text.length == 6) flips and the Verify OTP
              // button enables as soon as the 6th digit is entered.
              onChanged: (_) => setState(() {}),
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
              decoration: InputDecoration(
                hintText: '000000',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 20.sp,
                  letterSpacing: 4,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: BlocBuilder<AirtimeToCashCubit, AirtimeToCashState>(
                  builder: (context, state) {
                    final isLoading = state is AirtimeToCashOTPVerifying;
                    return ElevatedButton(
                      onPressed: isLoading ? null : (_canVerifyOTP ? _verifyOTP : null),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _canVerifyOTP
                            ? const Color(0xFF4E03D0)
                            : const Color(0xFF1F1F1F),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 18.w,
                              height: 18.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              'Verify OTP',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: _canVerifyOTP
                                    ? Colors.white
                                    : const Color(0xFF9CA3AF),
                              ),
                            ),
                    );
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: _sendOTP,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF9CA3AF),
                    side: const BorderSide(color: Color(0xFF2D2D2D)),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Resend',
                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildAmountInput() {
    final limits = _networkLimits[_selectedNetwork];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Airtime Amount',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextField(
            controller: _amountController,
            focusNode: _amountFocusNode,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: (v) {
              setState(() {
                _amount = v.isNotEmpty ? double.tryParse(v) : null;
              });
            },
            style: TextStyle(
              fontSize: 22.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                child: Text(
                  '₦',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            ),
          ),
        ),
        if (limits != null) ...[
          SizedBox(height: 6.h),
          Text(
            'Min: ₦${limits['min']?.toStringAsFixed(0)}  •  Max: ₦${limits['max']?.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.white.withValues(alpha: 0.45),
            ),
          ),
        ],
        // Inline validation error — shown only when the user has typed an
        // amount AND it's outside the active provider's min/max. Uses red
        // accent so it's unmistakable next to the neutral limits hint.
        if (_amountErrorMessage != null) ...[
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.error_outline, size: 12.sp, color: const Color(0xFFEF4444)),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  _amountErrorMessage!,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFFEF4444),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildSimPinInput() {
    final helper = _simPinHelperFor(_selectedNetwork);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'SIM Transfer PIN',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: _showSimPinDetailsDialog,
              child: Row(
                children: [
                  Icon(Icons.help_outline, size: 14.sp, color: const Color(0xFF4E03D0)),
                  SizedBox(width: 4.w),
                  Text(
                    'How to find this',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4E03D0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _isSimPinValid
                  ? const Color(0xFF10B981).withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: TextField(
            controller: _simPinController,
            focusNode: _simPinFocusNode,
            keyboardType: TextInputType.number,
            obscureText: true,
            maxLength: 4,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 12,
            ),
            decoration: InputDecoration(
              counterText: '',
              hintText: '••••',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.25),
                letterSpacing: 12,
                fontSize: 22.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          helper,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withValues(alpha: 0.55),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  void _showSimPinDetailsDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: const Color(0xFF4E03D0), size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Set your SIM Transfer PIN',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  'Each Nigerian network has a separate USSD code for managing your SIM transfer PIN. '
                  'You\u2019ll need this 4-digit PIN before we can convert your airtime.',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 16.h),
                ..._simPinShortCodes.entries.map((e) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0A0A),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 80.w,
                            child: Text(
                              _networkLabel(e.key),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: _networkColor(e.key),
                              ),
                            ),
                          ),
                          Text(
                            'Dial ',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                          Text(
                            e.value,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: 8.h),
                Text(
                  'If you\u2019ve never set one, dial the code for your network and follow the prompts to create a 4-digit PIN. '
                  'Lost it? Same code → "Reset PIN".',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withValues(alpha: 0.5),
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: Text(
                      'Got it',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF4E03D0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickAmounts() {
    final limits = _networkLimits[_selectedNetwork];
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _quickAmounts.map((amt) {
        final inRange = limits == null ||
            (amt >= (limits['min'] ?? 50) && amt <= (limits['max'] ?? 20000));
        final isSelected = _amount == amt;
        return GestureDetector(
          onTap: inRange
              ? () {
                  setState(() => _amount = amt);
                  _amountController.text = amt.toStringAsFixed(0);
                }
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF4E03D0) : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '₦${amt.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : inRange
                        ? Colors.white.withValues(alpha: 0.8)
                        : const Color(0xFF9CA3AF).withValues(alpha: 0.4),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildConversionPreview() {
    final cash = _estimatedCash;
    final valid = _isAmountValid;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: valid
              ? const Color(0xFF4E03D0).withValues(alpha: 0.3)
              : const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('You send',
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
              Text('₦${_amount!.toStringAsFixed(0)}',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rate',
                  style: TextStyle(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
              Text(
                '${((_networkRates[_selectedNetwork!] ?? 0.7) * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4E03D0)),
              ),
            ],
          ),
          Divider(color: Colors.white.withValues(alpha: 0.08), height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('You get (estimated)',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              Text(
                '₦${cash.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF4E03D0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return BlocBuilder<AirtimeToCashCubit, AirtimeToCashState>(
      builder: (context, state) {
        // While the user is in the OTP-verify step, hide the sticky bottom
        // button entirely — the inline Verify OTP + Resend pair (above the
        // OTP input) is the single source of action for that phase. Keeping
        // a second Verify OTP at the bottom doubled up the CTA and made the
        // screen feel cluttered.
        if (_otpSent && !_otpVerified) {
          return const SizedBox.shrink();
        }

        String buttonText = 'Send OTP';
        VoidCallback? onPressed;
        bool isLoading = false;

        if (!_otpSent) {
          buttonText = 'Send OTP';
          onPressed = _canSendOTP ? _sendOTP : null;
          isLoading = state is AirtimeToCashOTPRequesting;
        } else {
          buttonText = 'Check Availability';
          onPressed = _canProceed && _isAmountValid ? _checkQuotaAndProceed : null;
          isLoading = state is AirtimeToCashCheckingQuota;
        }

        return Container(
          padding: EdgeInsets.all(20.w),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: onPressed != null
                    ? const Color(0xFF4E03D0)
                    : const Color(0xFF1F1F1F),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: onPressed != null ? Colors.white : const Color(0xFF9CA3AF),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
