import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/transaction_pin/cubit/pin_management_cubit.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

class PinManagementScreen extends StatefulWidget {
  const PinManagementScreen({super.key});

  @override
  State<PinManagementScreen> createState() => _PinManagementScreenState();
}

class _PinManagementScreenState extends State<PinManagementScreen> {
  static const Color _purpleAccent = Color(0xFF4E03D0);
  static const int _pinLength = 4;
  static const int _otpLength = 6;

  late final PinManagementCubit _cubit;

  int _currentStep = 0;

  // PIN entry controllers
  final _currentPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  // OTP controllers
  final List<TextEditingController> _otpControllers =
      List.generate(_otpLength, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
      List.generate(_otpLength, (_) => FocusNode());

  // State
  bool _hasPin = false;
  List<OTPChannelInfo> _channels = [];
  String _recommendedChannel = '';
  String _selectedChannel = '';
  String _maskedDestination = '';
  int _cooldownSeconds = 0;
  Timer? _cooldownTimer;

  // Stored PIN values for OTP verification step
  String _storedCurrentPin = '';
  String _storedNewPin = '';
  String _storedConfirmPin = '';

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator<PinManagementCubit>();
    _cubit.initialize();
  }

  @override
  void dispose() {
    _currentPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final n in _otpFocusNodes) {
      n.dispose();
    }
    _cooldownTimer?.cancel();
    super.dispose();
  }

  String get _operationType => _hasPin ? 'change' : 'create';

  void _onContinueFromPinEntry() {
    final newPin = _newPinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();
    final currentPin = _currentPinController.text.trim();

    if (_hasPin && currentPin.length != _pinLength) {
      _showError('Please enter your current 4-digit PIN.');
      return;
    }
    if (newPin.length != _pinLength) {
      _showError('Please enter a 4-digit PIN.');
      return;
    }
    if (confirmPin.length != _pinLength) {
      _showError('Please confirm your PIN.');
      return;
    }
    if (newPin != confirmPin) {
      _showError('PINs do not match. Please try again.');
      return;
    }

    _storedCurrentPin = currentPin;
    _storedNewPin = newPin;
    _storedConfirmPin = confirmPin;

    setState(() {
      _currentStep = 2;
    });
  }

  void _onSendCode() {
    if (_selectedChannel.isEmpty) {
      _showError('Please select a verification channel.');
      return;
    }
    _cubit.sendOTP(
      operationType: _operationType,
      channel: _selectedChannel,
    );
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.length == 1 && index < _otpLength - 1) {
      _otpFocusNodes[index + 1].requestFocus();
    }

    // Check if all digits filled
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == _otpLength) {
      _cubit.verifyOTPAndExecute(
        otpCode: otp,
        operationType: _operationType,
        currentPin: _hasPin ? _storedCurrentPin : null,
        newPin: _storedNewPin,
        confirmNewPin: _storedConfirmPin,
      );
    }
  }

  void _onOtpKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _otpControllers[index].text.isEmpty &&
        index > 0) {
      _otpControllers[index - 1].clear();
      _otpFocusNodes[index - 1].requestFocus();
    }
  }

  void _startCooldownTimer(int seconds) {
    _cooldownSeconds = seconds;
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _cooldownSeconds--;
        if (_cooldownSeconds <= 0) {
          timer.cancel();
        }
      });
    });
  }

  void _resendCode() {
    _clearOtpFields();
    _cubit.sendOTP(
      operationType: _operationType,
      channel: _selectedChannel,
    );
  }

  void _clearOtpFields() {
    for (final c in _otpControllers) {
      c.clear();
    }
    if (_otpFocusNodes.isNotEmpty) {
      _otpFocusNodes[0].requestFocus();
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessAndNavigateBack(String message) {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<PinManagementCubit, PinManagementState>(
        listener: (context, state) {
          if (state is PinManagementReady) {
            setState(() {
              _hasPin = state.hasPin;
              _channels = state.channels;
              _recommendedChannel = state.recommendedChannel;
              _selectedChannel = state.recommendedChannel;
              _currentStep = 1;
            });
          } else if (state is PinManagementOTPSent) {
            setState(() {
              _maskedDestination = state.maskedDestination;
              _currentStep = 3;
            });
            _startCooldownTimer(state.cooldownSeconds);
          } else if (state is PinManagementSuccess) {
            setState(() {
              _currentStep = 4;
            });
            final msg = state.operationType == 'create'
                ? 'PIN Created Successfully'
                : 'PIN Changed Successfully';
            _showSuccessAndNavigateBack(msg);
          } else if (state is PinManagementError) {
            String msg = state.message;
            if (state.remainingAttempts != null) {
              msg += ' (${state.remainingAttempts} attempts remaining)';
            }
            _showError(msg);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Get.back(),
              ),
              title: Text(
                'Transaction PIN',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildCurrentStep(state),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentStep(PinManagementState state) {
    switch (_currentStep) {
      case 0:
        return _buildLoadingStep();
      case 1:
        return _buildPinEntryStep();
      case 2:
        return _buildChannelSelectionStep(state);
      case 3:
        return _buildOtpVerificationStep(state);
      case 4:
        return _buildSuccessStep();
      default:
        return _buildLoadingStep();
    }
  }

  // ── Step 0: Loading ──

  Widget _buildLoadingStep() {
    return const Center(
      key: ValueKey('loading'),
      child: CircularProgressIndicator(color: _purpleAccent),
    );
  }

  // ── Step 1: PIN Entry ──

  Widget _buildPinEntryStep() {
    final title = _hasPin
        ? 'Change Your Transaction PIN'
        : 'Create Your Transaction PIN';
    final subtitle = _hasPin
        ? 'Enter your current and new PIN'
        : 'Set a 4-digit PIN to secure your transactions';

    return SingleChildScrollView(
      key: const ValueKey('pin_entry'),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 32.h),
          if (_hasPin) ...[
            _buildPinField(
              label: 'Current PIN',
              controller: _currentPinController,
            ),
            SizedBox(height: 20.h),
          ],
          _buildPinField(
            label: 'New PIN',
            controller: _newPinController,
          ),
          SizedBox(height: 20.h),
          _buildPinField(
            label: 'Confirm New PIN',
            controller: _confirmPinController,
          ),
          SizedBox(height: 40.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: _onContinueFromPinEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: _purpleAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPinField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: _pinLength,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 8.w,
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: '----',
            hintStyle: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade300,
              letterSpacing: 8.w,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: _purpleAccent, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  // ── Step 2: Channel Selection ──

  Widget _buildChannelSelectionStep(PinManagementState state) {
    final isLoading = state is PinManagementLoading;

    return SingleChildScrollView(
      key: const ValueKey('channel_selection'),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verify Your Identity',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Choose how to receive your verification code',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 24.h),
          ..._channels.where((ch) => ch.isAvailable).map((channel) {
            final isSelected = _selectedChannel == channel.type;
            final isRecommended = _recommendedChannel == channel.type;
            final icon =
                channel.type == 'email' ? Icons.email_outlined : Icons.sms_outlined;

            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedChannel = channel.type;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? _purpleAccent.withValues(alpha: 0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected ? _purpleAccent : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _purpleAccent.withValues(alpha: 0.1)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected ? _purpleAccent : Colors.grey.shade600,
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  channel.type == 'email' ? 'Email' : 'SMS',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                if (isRecommended) ...[
                                  SizedBox(width: 8.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _purpleAccent.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      'Recommended',
                                      style: GoogleFonts.inter(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: _purpleAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              channel.maskedDestination,
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: _purpleAccent,
                          size: 24.sp,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: isLoading ? null : _onSendCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: _purpleAccent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: _purpleAccent.withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      'Send Code',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Step 3: OTP Verification ──

  Widget _buildOtpVerificationStep(PinManagementState state) {
    final isLoading = state is PinManagementLoading;
    final channelIcon =
        _selectedChannel == 'email' ? Icons.email_outlined : Icons.sms_outlined;

    return SingleChildScrollView(
      key: const ValueKey('otp_verification'),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: _purpleAccent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              channelIcon,
              color: _purpleAccent,
              size: 32.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Enter Verification Code',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'We sent a 6-digit code to $_maskedDestination',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          // OTP fields
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_otpLength, (index) {
              return Container(
                width: 46.w,
                height: 52.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                child: KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (event) => _onOtpKeyEvent(index, event),
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _otpFocusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    enabled: !isLoading,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide:
                            const BorderSide(color: _purpleAccent, width: 2),
                      ),
                    ),
                    onChanged: (value) => _onOtpDigitChanged(index, value),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 24.h),
          if (isLoading)
            const CircularProgressIndicator(color: _purpleAccent)
          else if (_cooldownSeconds > 0)
            Text(
              'Resend code in ${_cooldownSeconds}s',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            )
          else
            TextButton(
              onPressed: _resendCode,
              child: Text(
                'Resend Code',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: _purpleAccent,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Step 4: Success ──

  Widget _buildSuccessStep() {
    final message = _hasPin
        ? 'PIN Changed Successfully'
        : 'PIN Created Successfully';

    return Center(
      key: const ValueKey('success'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.green,
              size: 40.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
