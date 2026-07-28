import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utilities/passcode_policy.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/transaction_pin/cubit/pin_management_cubit.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class ForgotPinScreen extends StatefulWidget {
  const ForgotPinScreen({super.key});

  @override
  State<ForgotPinScreen> createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends State<ForgotPinScreen> {
  static const Color _purpleAccent = Color(0xFF4E03D0);

  late PinManagementCubit _cubit;

  // Step tracking: 0=loading, 1=channel select, 2=otp, 3=new pin, 4=success
  int _currentStep = 0;

  // Step 1 state
  String _selectedChannel = '';

  // Step 2 state
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());
  String _maskedDestination = '';
  String _channelUsed = '';
  int _cooldownSeconds = 0;
  Timer? _cooldownTimer;

  // Step 3 state
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  String _storedOtpCode = '';

  // Step 4 state
  Timer? _autoNavTimer;

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator<PinManagementCubit>();
    _cubit.initialize();
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    _newPinController.dispose();
    _confirmPinController.dispose();
    _cooldownTimer?.cancel();
    _autoNavTimer?.cancel();
    super.dispose();
  }

  String _getOtpCode() {
    return _otpControllers.map((c) => c.text).join();
  }

  void _clearOtpFields() {
    for (final c in _otpControllers) {
      c.clear();
    }
  }

  void _startCooldown(int seconds) {
    _cooldownTimer?.cancel();
    setState(() {
      _cooldownSeconds = seconds;
    });
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

  void _onSendCode() {
    if (_selectedChannel.isEmpty) return;
    _cubit.sendOTP(operationType: 'reset', channel: _selectedChannel);
  }

  void _onResendCode() {
    if (_cooldownSeconds > 0) return;
    _clearOtpFields();
    _cubit.sendOTP(operationType: 'reset', channel: _channelUsed);
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }

    final code = _getOtpCode();
    if (code.length == 6) {
      setState(() {
        _storedOtpCode = code;
        _currentStep = 3;
      });
    }
  }

  void _onResetPin() {
    final newPin = _newPinController.text;
    final confirmPin = _confirmPinController.text;

    if (newPin.length != 4 || confirmPin.length != 4) {
      _showSnackbar('Please enter a 4-digit PIN');
      return;
    }
    if (newPin != confirmPin) {
      _showSnackbar('PINs do not match');
      return;
    }
    // Reject trivially guessable PINs up front — same policy the PIN keypad and
    // the backend enforce — so a weak PIN never consumes the one-time code.
    if (isWeakNumericCode(newPin)) {
      _showSnackbar('Choose a less predictable PIN (avoid 1111 or 1234).');
      return;
    }

    _cubit.completeForgotPin(
      otpCode: _storedOtpCode,
      newPin: newPin,
      confirmNewPin: confirmPin,
    );
  }

  void _showSnackbar(String message, {bool isError = true}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
    );
  }

  void _handleStateChange(PinManagementState state) {
    if (state is PinManagementReady) {
      // A user can verify via email/SMS OR an enrolled authenticator app, so
      // only block when NONE of those paths is available.
      final hasAvailableChannels =
          state.channels.any((ch) => ch.isAvailable) || _isAuthenticatorEnrolled();
      if (!hasAvailableChannels) {
        // No verification path at all - show error
        setState(() {
          _currentStep = 5; // Error step
        });
        _showSnackbar('No verification method available. Add a verified email or phone number, or set up an authenticator app in Settings.', isError: false);
        return;
      }
      setState(() {
        _currentStep = 1;
        if (state.recommendedChannel.isNotEmpty) {
          _selectedChannel = state.recommendedChannel;
        }
      });
    } else if (state is PinManagementOTPSent) {
      setState(() {
        _currentStep = 2;
        _maskedDestination = state.maskedDestination;
        _channelUsed = state.channel;
      });
      _startCooldown(state.cooldownSeconds);
      _otpFocusNodes[0].requestFocus();
    } else if (state is PinManagementSuccess) {
      setState(() {
        _currentStep = 4;
      });
      _autoNavTimer = Timer(const Duration(seconds: 2), () {
        if (mounted) {
          _showSnackbar('Your transaction PIN has been reset', isError: false);
          // Return `true` so a caller that pushed us (e.g. the Change-PIN
          // screen's "Forgot PIN?" hand-off) knows the reset succeeded and can
          // close itself — the user already has a fresh, working PIN.
          Get.back(result: true);
        }
      });
    } else if (state is PinManagementError) {
      // If we're still on loading step (initialization failed), show error screen
      if (_currentStep == 0) {
        setState(() {
          _currentStep = 5; // Error step
        });
      } else {
        String msg = state.message;
        if (state.remainingAttempts != null) {
          msg += ' (${state.remainingAttempts} attempts remaining)';
        }
        // A verification failure surfaces at the final submit (step 3, new PIN).
        // The bad/expired code lives on step 2, so drop back there with cleared
        // fields — otherwise the user is stranded on the new-PIN step re-typing a
        // PIN while the dead code silently fails every time. (New-PIN format is
        // validated client-side before submit, so errors here are code-related.)
        if (_currentStep >= 3) {
          _clearOtpFields();
          setState(() {
            _storedOtpCode = '';
            _currentStep = 2;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _otpFocusNodes[0].requestFocus();
          });
        }
        _showSnackbar(msg);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<PinManagementCubit, PinManagementState>(
        listener: (context, state) => _handleStateChange(state),
        builder: (context, state) {
          final bool isLoading = state is PinManagementLoading;

          // Block back-nav while an OTP send / verify / reset is in flight — a
          // mid-request pop would dispose the screen with the request still
          // running (and could double-pop against the success auto-nav).
          return PopScope(
            canPop: !isLoading,
            child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black, size: 24.sp),
                onPressed: isLoading ? null : () => Get.back(),
              ),
              title: Text(
                'Forgot PIN',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: _buildStepContent(state),
                  ),
                  if (isLoading)
                    Container(
                      color: Colors.white.withValues(alpha: 0.7),
                      child: const Center(
                        child: LazerVaultLoader.small(),
                      ),
                    ),
                ],
              ),
            ),
          ),
          );
        },
      ),
    );
  }

  Widget _buildStepContent(PinManagementState state) {
    switch (_currentStep) {
      case 0:
        return _buildLoadingStep();
      case 1:
        return _buildChannelSelectionStep(state);
      case 2:
        return _buildOtpStep();
      case 3:
        return _buildNewPinStep(state);
      case 4:
        return _buildSuccessStep();
      case 5:
        return _buildErrorStep(state);
      default:
        return const SizedBox.shrink();
    }
  }

  // ── Step 0: Loading ──

  Widget _buildLoadingStep() {
    return Padding(
      padding: EdgeInsets.only(top: 120.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const LazerVaultLoader.small(),
            SizedBox(height: 16.h),
            Text(
              'Checking your verification options…',
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Step 1: Channel Selection ──

  Widget _buildChannelSelectionStep(PinManagementState state) {
    List<OTPChannelInfo> channels = [];
    if (state is PinManagementReady) {
      channels = state.channels;
    }

    return Column(
      children: [
        SizedBox(height: 32.h),
        // Shield icon
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange.shade50,
          ),
          child: Icon(
            Icons.shield_outlined,
            color: Colors.orange.shade700,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Reset Your Transaction PIN',
          style: GoogleFonts.inter(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        // Info card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: _purpleAccent.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _purpleAccent.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: _purpleAccent, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  "We'll send a verification code to confirm your identity before resetting your PIN",
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 28.h),
        // Channel cards
        ...channels.where((ch) => ch.isAvailable).map((channel) {
          final isSelected = _selectedChannel == channel.type;
          final isRecommended =
              state is PinManagementReady && state.recommendedChannel == channel.type;

          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildChannelCard(
              channel: channel,
              isSelected: isSelected,
              isRecommended: isRecommended,
            ),
          );
        }),
        // Authenticator app — always offered. If the user hasn't set one up we
        // open a modal that routes them to Settings to enable it.
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _buildAuthenticatorCard(),
        ),
        SizedBox(height: 32.h),
        // Send Code button
        SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton(
            onPressed: _selectedChannel.isEmpty ? null : _onSendCode,
            style: ElevatedButton.styleFrom(
              backgroundColor: _purpleAccent,
              disabledBackgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              // Nothing is "sent" for an authenticator — the code already lives
              // in the user's app — so label the action honestly.
              _selectedChannel == 'authenticator' ? 'Continue' : 'Send Code',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildChannelCard({
    required OTPChannelInfo channel,
    required bool isSelected,
    required bool isRecommended,
  }) {
    final isEmail = channel.type.toLowerCase() == 'email';

    return GestureDetector(
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
              ? _purpleAccent.withValues(alpha: 0.06)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? _purpleAccent : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? _purpleAccent.withValues(alpha: 0.12)
                    : Colors.grey.shade100,
              ),
              child: Icon(
                isEmail ? Icons.email_outlined : Icons.sms_outlined,
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
                        isEmail ? 'Email' : 'SMS',
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
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Recommended',
                            style: GoogleFonts.inter(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    channel.maskedDestination,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? _purpleAccent : Colors.grey.shade400,
                  width: isSelected ? 6 : 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isAuthenticatorEnrolled() {
    final user = context.read<AuthenticationCubit>().currentProfile?.user;
    if (user == null || !user.twoFactorEnabled) return false;
    final m = (user.twoFactorMethod ?? '').toLowerCase();
    return m == 'authenticator' || m == 'totp' || m == 'app';
  }

  Future<void> _onAuthenticatorTap() async {
    if (_isAuthenticatorEnrolled()) {
      setState(() => _selectedChannel = 'authenticator');
      return;
    }
    // Not enrolled — offer to set it up. The modal may route to the 2FA settings
    // screen and come back; re-evaluate enrollment on return so the card (and
    // selection) reflect a just-completed setup without leaving this screen.
    await _showAuthenticatorSetupModal();
    if (!mounted) return;
    setState(() {
      if (_isAuthenticatorEnrolled()) _selectedChannel = 'authenticator';
    });
  }

  Widget _buildAuthenticatorCard() {
    final isSelected = _selectedChannel == 'authenticator';
    final enrolled = _isAuthenticatorEnrolled();
    return GestureDetector(
      onTap: _onAuthenticatorTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? _purpleAccent.withValues(alpha: 0.06)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? _purpleAccent : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? _purpleAccent.withValues(alpha: 0.12)
                    : Colors.grey.shade100,
              ),
              child: Icon(Icons.shield_moon_outlined,
                  color: isSelected ? _purpleAccent : Colors.grey.shade600,
                  size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Authenticator app',
                      style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black)),
                  SizedBox(height: 2.h),
                  Text(
                    enrolled
                        ? 'Use a code from your authenticator'
                        : 'Not set up — tap to enable',
                    style: GoogleFonts.inter(
                        fontSize: 13.sp, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            enrolled
                ? Container(
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? _purpleAccent : Colors.grey.shade400,
                        width: isSelected ? 6 : 1.5,
                      ),
                    ),
                  )
                : Icon(Icons.chevron_right,
                    color: Colors.grey.shade400, size: 22.sp),
          ],
        ),
      ),
    );
  }

  Future<void> _showAuthenticatorSetupModal() async {
    final goSetup = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.fromLTRB(
            24.w, 16.h, 24.w, 24.h + MediaQuery.of(sheetCtx).padding.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _purpleAccent.withValues(alpha: 0.1),
              ),
              child: Icon(Icons.shield_moon_outlined,
                  color: _purpleAccent, size: 28.sp),
            ),
            SizedBox(height: 16.h),
            Text('Set up an authenticator app',
                style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            SizedBox(height: 8.h),
            Text(
              "You haven't set up an authenticator app yet. Enable it in "
              "Settings to verify with a time-based code (Google Authenticator, "
              "Authy, etc.).",
              style: GoogleFonts.inter(
                  fontSize: 14.sp, color: Colors.grey.shade600, height: 1.5),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () => Navigator.of(sheetCtx).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _purpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text('Set up in Settings',
                    style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
            SizedBox(height: 8.h),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(sheetCtx).pop(false),
                child: Text('Maybe later',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, color: Colors.grey.shade600)),
              ),
            ),
          ],
        ),
      ),
    );

    // Navigate to 2FA settings only AFTER the sheet has closed, and await the
    // round-trip so the caller (_onAuthenticatorTap) can re-check enrollment
    // when the user returns.
    if (goSetup == true && mounted) {
      await Get.toNamed(AppRoutes.twoFactorSettings);
    }
  }

  // ── Step 2: OTP Verification ──

  Widget _buildOtpStep() {
    final channel = _channelUsed.toLowerCase();
    final isEmail = channel == 'email';
    final isAuthenticator = channel == 'authenticator';

    final IconData headerIcon = isAuthenticator
        ? Icons.shield_moon_outlined
        : (isEmail ? Icons.email_outlined : Icons.sms_outlined);
    final String headerTitle =
        isAuthenticator ? 'Enter Authenticator Code' : 'Enter Verification Code';
    final String headerSubtitle = isAuthenticator
        ? 'Enter the current 6-digit code from your authenticator app'
        : 'We sent a 6-digit code to $_maskedDestination';

    return Column(
      children: [
        SizedBox(height: 32.h),
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _purpleAccent.withValues(alpha: 0.08),
          ),
          child: Icon(
            headerIcon,
            color: _purpleAccent,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          headerTitle,
          style: GoogleFonts.inter(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          headerSubtitle,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 36.h),
        // OTP fields
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return Container(
              width: 46.w,
              height: 54.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              child: TextField(
                controller: _otpControllers[index],
                focusNode: _otpFocusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: GoogleFonts.inter(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: _purpleAccent, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) => _onOtpChanged(index, value),
              ),
            );
          }),
        ),
        SizedBox(height: 28.h),
        // Resend row — only for email/SMS. A time-based authenticator code has
        // no "resend" (the app rotates it every 30s), so we hide it and instead
        // remind the user that the code refreshes.
        if (isAuthenticator)
          Text(
            'The code refreshes every 30 seconds in your app.',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive a code? ",
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              GestureDetector(
                onTap: _cooldownSeconds > 0 ? null : _onResendCode,
                child: Text(
                  _cooldownSeconds > 0
                      ? 'Resend in ${_cooldownSeconds}s'
                      : 'Resend Code',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: _cooldownSeconds > 0 ? Colors.grey : _purpleAccent,
                  ),
                ),
              ),
            ],
          ),
        SizedBox(height: 24.h),
      ],
    );
  }

  // ── Step 3: New PIN Entry ──

  Widget _buildNewPinStep(PinManagementState state) {
    final isLoading = state is PinManagementLoading;

    return Column(
      children: [
        SizedBox(height: 32.h),
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _purpleAccent.withValues(alpha: 0.08),
          ),
          child: Icon(
            Icons.lock_reset_outlined,
            color: _purpleAccent,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Create Your New PIN',
          style: GoogleFonts.inter(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          'Enter a new 4-digit PIN',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 36.h),
        // New PIN field
        TextField(
          controller: _newPinController,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 4,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 12,
          ),
          decoration: InputDecoration(
            counterText: '',
            labelText: 'New PIN',
            labelStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: _purpleAccent, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 16.h),
        // Confirm PIN field
        TextField(
          controller: _confirmPinController,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 4,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 12,
          ),
          decoration: InputDecoration(
            counterText: '',
            labelText: 'Confirm PIN',
            labelStyle: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: _purpleAccent, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 32.h),
        // Reset PIN button
        SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton(
            onPressed: isLoading ? null : _onResetPin,
            style: ElevatedButton.styleFrom(
              backgroundColor: _purpleAccent,
              disabledBackgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? LazerVaultLoader.small()
                : Text(
                    'Reset PIN',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  // ── Step 4: Success ──

  Widget _buildSuccessStep() {
    return Column(
      children: [
        SizedBox(height: 80.h),
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.shade50,
          ),
          child: Icon(
            Icons.check_circle,
            color: Colors.green.shade600,
            size: 60.sp,
          ),
        ),
        SizedBox(height: 32.h),
        Text(
          'PIN Reset Successfully',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          'You can now use your new PIN for transactions',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 48.h),
      ],
    );
  }

  // ── Step 5: Error ──

  Widget _buildErrorStep(PinManagementState state) {
    String errorMessage = 'Unable to initialize PIN reset. Please try again.';
    if (state is PinManagementError) {
      errorMessage = state.message;
    }

    return Column(
      children: [
        SizedBox(height: 80.h),
        Container(
          width: 100.w,
          height: 100.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.shade50,
          ),
          child: Icon(
            Icons.error_outline,
            color: Colors.red.shade600,
            size: 60.sp,
          ),
        ),
        SizedBox(height: 32.h),
        Text(
          'PIN Reset Unavailable',
          style: GoogleFonts.inter(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            errorMessage,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 32.h),
        SizedBox(
          width: double.infinity,
          height: 52.h,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: _purpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'Go Back',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Contact support if you need help resetting your PIN',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.grey.shade500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
