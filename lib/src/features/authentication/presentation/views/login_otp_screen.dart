import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/server_status_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';

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
  // Dark surface + brand accent. #4E03D0 fails contrast on #0A0A0A, so we use the
  // codebase's dark-mode brand substitute #A78BFA (see invoice_theme_colors).
  static const _background = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _accent = Color(0xFFA78BFA); // brand #4E03D0 → dark-safe tint
  static const _errorColor = Color(0xFFEF4444);

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
      backgroundColor: _card,
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
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Verify it\'s you',
            style: TextStyle(color: Colors.white)),
      ),
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const Icon(Icons.shield_outlined, color: _accent, size: 40),
                const SizedBox(height: 16),
                const Text(
                  'New sign-in detected',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'For your security, we sent a 6-digit code to your $channel '
                  '(${widget.destination}). Enter it to continue.',
                  style: const TextStyle(
                      color: _textSecondary, fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 28),
                _buildBoxes(),
                const SizedBox(height: 12),
                _buildStatusRow(),
                const SizedBox(height: 20),
                _buildVerifyButton(),
                const SizedBox(height: 8),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text('Use a different account',
                        style: TextStyle(color: _textSecondary)),
                  ),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Icon(Icons.error_outline, color: _errorColor, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Didn't request this? Don't share the code — close the app and change your password.",
                        style: TextStyle(color: _textSecondary, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBoxes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_boxes, (i) {
        return SizedBox(
          width: 48,
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
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (v) => _onDigitChanged(i, v),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: _card,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: _errorText != null ? _errorColor : _divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: _errorText != null ? _errorColor : _accent,
                      width: 1.5),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _divider),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStatusRow() {
    if (_errorText != null) {
      return Row(
        children: [
          const Icon(Icons.error_outline, color: _errorColor, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Text(_errorText!,
                style: const TextStyle(color: _errorColor, fontSize: 13)),
          ),
        ],
      );
    }
    if (_expired) {
      return Row(
        children: [
          const Text('Code expired.',
              style: TextStyle(color: _errorColor, fontSize: 13)),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: _requestNewCode,
            child: const Text('Get a new code',
                style: TextStyle(
                    color: _accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      );
    }
    return Row(
      children: [
        const Icon(Icons.timer_outlined, color: _textSecondary, size: 15),
        const SizedBox(width: 6),
        Text('Code expires in $_countdownLabel',
            style: const TextStyle(color: _textSecondary, fontSize: 13)),
        const Spacer(),
        GestureDetector(
          onTap: _requestNewCode,
          child: const Text('Resend',
              style: TextStyle(
                  color: _accent, fontSize: 13, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: (_submitting || _expired) ? null : _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: _accent,
          disabledBackgroundColor: _accent.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _submitting
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              )
            : Text(_expired ? 'Code expired' : 'Verify & continue',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
      ),
    );
  }
}
