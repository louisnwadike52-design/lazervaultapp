import 'dart:async';
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
import '../widgets/a2c_step_indicator.dart';

class A2COTPScreen extends StatefulWidget {
  const A2COTPScreen({super.key});

  @override
  State<A2COTPScreen> createState() => _A2COTPScreenState();
}

class _A2COTPScreenState extends State<A2COTPScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  String? phoneNumber;
  String? network;
  double? amount;
  NetworkRate? rate;
  double? estimatedCash;
  String? sessionId;
  String? _sourceAccountId;
  bool _isVerifying = false;
  bool _canResend = false;
  int _resendCountdown = 60;
  Timer? _resendTimer;
  bool _hasValidArguments = false;

  // OTP expiry tracking (5 minute expiry)
  static const int _otpExpirySeconds = 300; // 5 minutes
  int _expiryCountdown = _otpExpirySeconds;
  Timer? _expiryTimer;
  bool _isOTPExpired = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    if (_hasValidArguments) {
      _startResendCountdown();
      _startExpiryCountdown();
    }
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) {
      _hasValidArguments = false;
      return;
    }

    phoneNumber = args['phoneNumber'] as String?;
    network = args['network'] as String?;
    amount = args['amount'] as double?;
    rate = args['rate'] as NetworkRate?;
    estimatedCash = args['estimatedCash'] as double?;
    sessionId = args['sessionId'] as String?;
    _sourceAccountId = args['sourceAccountId'] as String?;

    // sessionId, phoneNumber, and network are required for OTP verification
    _hasValidArguments = sessionId != null &&
        sessionId!.isNotEmpty &&
        phoneNumber != null &&
        phoneNumber!.isNotEmpty &&
        network != null &&
        network!.isNotEmpty &&
        amount != null;
  }

  void _startResendCountdown() {
    _canResend = false;
    _resendCountdown = 60;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _resendCountdown--;
        if (_resendCountdown <= 0) {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _startExpiryCountdown() {
    _isOTPExpired = false;
    _expiryCountdown = _otpExpirySeconds;
    _expiryTimer?.cancel();
    _expiryTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _expiryCountdown--;
        if (_expiryCountdown <= 0) {
          _isOTPExpired = true;
          timer.cancel();
        }
      });
    });
  }

  String get _formattedExpiry {
    final minutes = _expiryCountdown ~/ 60;
    final seconds = _expiryCountdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _clearOTPFields() {
    for (final controller in _otpControllers) {
      controller.clear();
    }
    if (_focusNodes.isNotEmpty) {
      _focusNodes[0].requestFocus();
    }
  }

  void _resendOTP() {
    if (!_canResend || !mounted || phoneNumber == null || network == null) return;

    // Clear OTP input fields on resend
    _clearOTPFields();
    setState(() => _isVerifying = false);

    context.read<AirtimeToCashCubit>().requestOTP(phoneNumber!, network!);
    _startResendCountdown();
    _startExpiryCountdown(); // Reset expiry on new OTP
  }

  String get _otpValue =>
      _otpControllers.map((c) => c.text).join();

  void _onOTPComplete() {
    final otp = _otpValue;
    if (otp.length != 6) return;
    if (_isVerifying) return;

    // Prevent submission of expired OTP
    if (_isOTPExpired) {
      Get.snackbar(
        'OTP Expired',
        'Your OTP has expired. Please request a new one.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (sessionId == null || sessionId!.isEmpty) {
      Get.snackbar(
        'Error',
        'Session expired. Please go back and try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    setState(() => _isVerifying = true);
    context.read<AirtimeToCashCubit>().verifyOTP(
          otp,
          sessionId!,
          phoneNumber!,
          network!,
        );
  }

  void _handleOTPVerified(AirtimeToCashOTPVerified state) async {
    if (phoneNumber == null || amount == null) {
      Get.snackbar(
        'Error',
        'Missing required information. Please start over.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      Get.until((route) => route.settings.name == AppRoutes.airtimeToCash);
      return;
    }

    // Validate sessionToken and sessionId before proceeding
    if (state.sessionToken.isEmpty || state.sessionId.isEmpty) {
      Get.snackbar(
        'Session Error',
        'Invalid session received from server. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      setState(() => _isVerifying = false);
      // Go back to review screen to retry
      Get.back();
      return;
    }

    // Navigate to PIN input screen after successful OTP verification
    // The PIN input screen will collect the SIM Transfer PIN required by Automation API
    Get.offNamed(AppRoutes.airtimeToCashPinInput, arguments: {
      'phoneNumber': phoneNumber,
      'network': network,
      'amount': amount,
      'rate': rate,
      'estimatedCash': estimatedCash,
      'sessionToken': state.sessionToken,
      'sessionId': state.sessionId,
      'sourceAccountId': _sourceAccountId,
    });
  }

  void _handleResendSuccess(AirtimeToCashOTPSent state) {
    // Update sessionId with the new one from resend
    setState(() {
      sessionId = state.sessionId;
    });
    Get.snackbar(
      'OTP Sent',
      state.message,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    _expiryTimer?.cancel();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Null safety: if required arguments are missing, show error
    if (!_hasValidArguments) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: const Color(0xFFEF4444),
                    size: 48.sp,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Session Error',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Required verification details are missing. Please go back and try again.',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return BlocListener<AirtimeToCashCubit, AirtimeToCashState>(
      listener: (context, state) {
        if (state is AirtimeToCashOTPVerified) {
          _handleOTPVerified(state);
        } else if (state is AirtimeToCashOTPSent) {
          // Resend successful — update session
          _handleResendSuccess(state);
        } else if (state is AirtimeToCashError) {
          setState(() => _isVerifying = false);
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const A2CStepIndicator(
                currentStep: 3,
                totalSteps: 5,
                stepLabels: ['Network', 'Details', 'Review', 'Verify', 'PIN'],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 40.h),
                      _buildOTPIcon(),
                      SizedBox(height: 24.h),
                      _buildOTPTitle(),
                      SizedBox(height: 16.h),
                      _buildExpiryIndicator(),
                      SizedBox(height: 32.h),
                      _buildOTPInput(),
                      SizedBox(height: 24.h),
                      _buildResendButton(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
              _buildVerifyButton(),
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
                color: const Color(0xFF1F1F1F),
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
                  'Verify Phone',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'OTP from provider sent to your phone',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.until((route) => route.settings.name == AppRoutes.airtimeToCash || route.isFirst),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.close,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOTPIcon() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.sms_outlined,
        color: const Color(0xFF3B82F6),
        size: 36.sp,
      ),
    );
  }

  Widget _buildOTPTitle() {
    return Column(
      children: [
        Text(
          'Verify your phone',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Enter the OTP sent to ${phoneNumber ?? ''} by the provider',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildExpiryIndicator() {
    final isWarning = _expiryCountdown <= 60 && !_isOTPExpired;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: _isOTPExpired
            ? const Color(0xFFEF4444).withValues(alpha: 0.15)
            : isWarning
                ? const Color(0xFFFB923C).withValues(alpha: 0.15)
                : const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _isOTPExpired ? Icons.timer_off : Icons.timer_outlined,
            size: 16.sp,
            color: _isOTPExpired
                ? const Color(0xFFEF4444)
                : isWarning
                    ? const Color(0xFFFB923C)
                    : const Color(0xFF9CA3AF),
          ),
          SizedBox(width: 6.w),
          Text(
            _isOTPExpired ? 'OTP expired' : 'Expires in $_formattedExpiry',
            style: TextStyle(
              fontSize: 13.sp,
              color: _isOTPExpired
                  ? const Color(0xFFEF4444)
                  : isWarning
                      ? const Color(0xFFFB923C)
                      : const Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOTPInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        return Container(
          width: 48.w,
          height: 56.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            enabled: !_isOTPExpired,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: _isOTPExpired ? const Color(0xFF9CA3AF) : Colors.white,
            ),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFF2D2D2D),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFF2D2D2D),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFF3B82F6),
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                ),
              ),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                _focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              }
              if (_otpValue.length == 6) {
                _onOTPComplete();
              }
            },
          ),
        );
      }),
    );
  }

  Widget _buildResendButton() {
    return GestureDetector(
      onTap: _canResend ? _resendOTP : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Didn't receive the code? ",
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          Text(
            _canResend
                ? 'Resend OTP'
                : 'Resend in ${_resendCountdown}s',
            style: TextStyle(
              fontSize: 14.sp,
              color: _canResend
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFF9CA3AF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton() {
    final isDisabled = _isVerifying || _otpValue.length != 6 || _isOTPExpired;

    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: isDisabled ? null : _onOTPComplete,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            foregroundColor: Colors.white,
            disabledBackgroundColor:
                const Color(0xFF3B82F6).withValues(alpha: 0.3),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          child: _isVerifying
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Verifying...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Text(
                  _isOTPExpired ? 'OTP Expired - Resend' : 'Verify OTP',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
