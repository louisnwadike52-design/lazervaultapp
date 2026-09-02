import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/server_status_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';

/// Adaptive step-up login OTP screen. Shown when ANY login flow (email/password,
/// email/passcode, or phone+passcode incl. switch-user) reports that the risk
/// engine requires a one-time code (new device / location). Mode-agnostic: it
/// owns a fresh [AuthenticationCubit] so verifying never re-fires the originating
/// login screen's listener, and on success it loads the profile + routes to the
/// dashboard itself (a step-up user is an existing user who already has a
/// passcode/PIN, so the dashboard is the correct destination).
///
/// Navigation contract (matches 2FA):
///  * launched via `Get.to` (push) so the originating login screen stays beneath;
///  * BACK ("Use a different account") = `maybePop` back to that login screen —
///    never a dead-end;
///  * SUCCESS = `Get.offAllNamed(dashboard)` — clears login + OTP off the stack.
class LoginOtpScreen extends StatelessWidget {
  final String stepUpToken;
  final String method; // "email" | "sms"
  final String destination; // masked

  const LoginOtpScreen({
    super.key,
    required this.stepUpToken,
    required this.method,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationCubit>(
      create: (_) => serviceLocator<AuthenticationCubit>(),
      child: _LoginOtpView(
        stepUpToken: stepUpToken,
        method: method,
        destination: destination,
      ),
    );
  }
}

class _LoginOtpView extends StatefulWidget {
  final String stepUpToken;
  final String method;
  final String destination;

  const _LoginOtpView({
    required this.stepUpToken,
    required this.method,
    required this.destination,
  });

  @override
  State<_LoginOtpView> createState() => _LoginOtpViewState();
}

class _LoginOtpViewState extends State<_LoginOtpView> {
  // This screen sits INSIDE the phone-login flow — it is the step immediately
  // after "Log in" — so it wears that flow's chrome (PhoneFlowScaffold: curved
  // background, back button, title/subtitle, pill CTA) rather than the dark
  // one-off palette it used to carry. Colours below mirror PhoneFlowScaffold's
  // light body so the two screens read as one journey.
  static const _brandPurple = Color(0xFF4834D4);
  static const _ink = Color(0xFF262626);
  static const _textSecondary = Color(0xFF6B7280);
  static const _field = Color(0xFFF3F4F6); // filled input on the light body
  static const _divider = Color(0xFFE5E7EB);
  static const _errorColor = Color(0xFFDC2626); // AA on a light background

  // Server-side OTP TTL is 10 minutes (auth-service loginOTPTTL). Mirror it so the
  // user sees an accurate countdown and we can flip to an "expired" state that
  // prompts a fresh sign-in rather than letting them keep submitting a dead code.
  static const int _ttlSeconds = 10 * 60;

  static const int _boxes = 6;
  final List<TextEditingController> _controllers =
      List.generate(_boxes, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(_boxes, (_) => FocusNode());

  Timer? _ticker;
  int _remaining = _ttlSeconds;
  bool _submitting = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _startTicker();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTicker() {
    _ticker?.cancel();
    _remaining = _ttlSeconds;
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_remaining <= 0) {
        t.cancel();
        return;
      }
      setState(() => _remaining -= 1);
    });
  }

  bool get _expired => _remaining <= 0;

  String get _code => _controllers.map((c) => c.text).join();

  String get _countdownLabel {
    final m = (_remaining ~/ 60).toString();
    final s = (_remaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _onDigitChanged(int index, String value) {
    if (_errorText != null) setState(() => _errorText = null);

    // Paste / autofill of the whole code into one box: distribute across boxes.
    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
      for (var i = 0; i < _boxes; i++) {
        _controllers[i].text = i < digits.length ? digits[i] : '';
      }
      final next = digits.length >= _boxes ? _boxes - 1 : digits.length;
      _focusNodes[next].requestFocus();
      if (digits.length >= _boxes) _submit();
      return;
    }

    if (value.isNotEmpty && index < _boxes - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isNotEmpty && index == _boxes - 1) {
      // Last digit entered — auto-submit after a beat so the UI settles.
      FocusScope.of(context).unfocus();
      Future.delayed(const Duration(milliseconds: 120), () {
        if (mounted && _code.length == _boxes) _submit();
      });
    }
  }

  void _onBackspace(int index) {
    // Empty box + backspace → hop to the previous box and clear it, so the user
    // can correct digits fluidly.
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  void _clearBoxes({bool refocus = true}) {
    for (final c in _controllers) {
      c.clear();
    }
    if (refocus) _focusNodes[0].requestFocus();
  }

  void _submit() {
    if (_submitting) return;
    final code = _code;
    if (code.length != _boxes) {
      setState(() => _errorText = 'Enter the $_boxes-digit code');
      return;
    }
    if (_expired) {
      setState(() => _errorText = 'This code has expired. Request a new one.');
      return;
    }
    setState(() {
      _submitting = true;
      _errorText = null;
    });
    FocusScope.of(context).unfocus();
    context.read<AuthenticationCubit>().verifyLoginOtp(
          stepUpToken: widget.stepUpToken,
          code: code,
        );
  }

  /// A step-up code can only be re-minted by re-authenticating (the risk engine
  /// issues a fresh code per login attempt — there is no standalone resend RPC,
  /// which also keeps a stolen step-up token from being replayed for new codes).
  /// So "send a new code" pops back to the still-mounted login screen where the
  /// user re-enters their passcode/password and a new challenge is issued.
  void _requestNewCode() {
    Get.snackbar(
      'Get a new code',
      'Sign in again to have a fresh code sent to your ${widget.method == 'sms' ? 'phone' : 'email'}.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: _ink,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 3),
    );
    Navigator.of(context).maybePop();
  }

  /// A connectivity/edge failure is NOT a wrong code — surface it as a connection
  /// problem (and poke the health gate) rather than raw transport text. Wrong /
  /// expired-code messages pass through as an inline error under the boxes.
  void _handleFailure(String message) {
    final m = message.toLowerCase();
    final looksNetwork = isNetworkError(message) ||
        m.contains('network error') ||
        m.contains('check your connection');
    if (looksNetwork) {
      ServerHealthNotifier.instance.pokeRecheck();
      setState(() {
        _submitting = false;
        _errorText =
            "Connection problem — couldn't reach our servers. Try again.";
      });
      return;
    }
    setState(() {
      _submitting = false;
      _errorText = message.isNotEmpty ? message : 'That code is incorrect.';
    });
    _clearBoxes();
  }

  @override
  Widget build(BuildContext context) {
    final channel = widget.method == 'sms' ? 'SMS' : 'email';
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          _ticker?.cancel();
          try {
            context.read<ProfileCubit>().getUserProfile();
          } catch (_) {/* dashboard loads it */}
          Get.offAllNamed(AppRoutes.dashboard);
        } else if (state is AuthenticationError) {
          _handleFailure(state.message);
        } else if (state is AuthenticationFailure) {
          _handleFailure(state.message);
        }
      },
      child: PhoneFlowScaffold(
        title: 'Verify it\'s you',
        subtitle: 'We sent a 6-digit code to your $channel '
            '(${widget.destination}). Enter it to continue.',
        showHeadingLogo: false,
        primaryLabel: _expired ? 'Code expired' : 'Verify & continue',
        onPrimary: (_submitting || _expired) ? null : _submit,
        isLoading: _submitting,
        secondaryAction: Center(
          child: TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: Text(
              'Use a different account',
              style: TextStyle(
                  color: _textSecondary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        children: [
          _buildWhyBanner(),
          SizedBox(height: 24.h),
          _buildBoxes(),
          SizedBox(height: 14.h),
          _buildStatusRow(),
          SizedBox(height: 28.h),
          _buildSecurityNote(),
        ],
      ),
    );
  }

  /// Why the user is seeing this at all. It used to be a bare shield glyph over
  /// a heading; saying "new device" is what actually reassures someone who did
  /// just sign in somewhere new — and warns someone who didn't.
  Widget _buildWhyBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: _brandPurple.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _brandPurple.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.shield_outlined, color: _brandPurple, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'New sign-in detected on this device.',
              style: TextStyle(
                color: _ink,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: _textSecondary, size: 15.sp),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            "Didn't request this? Don't share the code — close the app and "
            'change your password.',
            style: TextStyle(
                color: _textSecondary, fontSize: 12.sp, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _buildBoxes() {
    // The boxes were a fixed 48px each inside a spaceBetween Row, so on a narrow
    // screen the sixth one ran off the edge — the code was literally not fully
    // enterable. Sizing them from the ACTUAL available width makes the row fit
    // any device and stay evenly spaced.
    return LayoutBuilder(
      builder: (context, constraints) {
        final gutter = 8.w;
        final boxWidth =
            (constraints.maxWidth - gutter * (_boxes - 1)) / _boxes;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_boxes, (i) {
            return SizedBox(
              width: boxWidth,
              child: KeyboardListener(
            focusNode: FocusNode(skipTraversal: true),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace) {
                _onBackspace(i);
              }
            },
                child: TextField(
                  controller: _controllers[i],
                  focusNode: _focusNodes[i],
                  enabled: !_expired && !_submitting,
                  autofocus: i == 0,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: i == 0 ? _boxes : 1, // box 0 accepts a full paste
                  style: TextStyle(
                      color: _ink,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (v) => _onDigitChanged(i, v),
                  decoration: InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: _field,
                    // Symmetric padding only — the width now comes from the
                    // LayoutBuilder, so horizontal padding here would fight it.
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide(
                          color: _errorText != null ? _errorColor : _divider),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: BorderSide(
                          color:
                              _errorText != null ? _errorColor : _brandPurple,
                          width: 1.6),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      borderSide: const BorderSide(color: _divider),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  /// One line under the boxes carrying whichever of the three states applies:
  /// an inline error, the expired state, or the countdown + resend. Kept to a
  /// single row so the boxes and the CTA never shift position between states.
  Widget _buildStatusRow() {
    if (_errorText != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: _errorColor, size: 15.sp),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(_errorText!,
                style: TextStyle(color: _errorColor, fontSize: 12.5.sp)),
          ),
        ],
      );
    }
    if (_expired) {
      return Row(
        children: [
          Icon(Icons.timer_off_outlined, color: _errorColor, size: 15.sp),
          SizedBox(width: 6.w),
          Text('Code expired.',
              style: TextStyle(color: _errorColor, fontSize: 12.5.sp)),
          const Spacer(),
          _linkButton('Get a new code', _requestNewCode),
        ],
      );
    }
    return Row(
      children: [
        Icon(Icons.timer_outlined, color: _textSecondary, size: 15.sp),
        SizedBox(width: 6.w),
        Text('Expires in $_countdownLabel',
            style: TextStyle(color: _textSecondary, fontSize: 12.5.sp)),
        const Spacer(),
        _linkButton('Resend', _requestNewCode),
      ],
    );
  }

  /// A tap target that reads as a link. The old bare GestureDetector on a 13px
  /// label gave a target well under the 44px minimum and sat right against the
  /// screen edge, which is how "Resend" ended up clipped.
  Widget _linkButton(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        child: Text(
          label,
          style: TextStyle(
              color: _brandPurple,
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
