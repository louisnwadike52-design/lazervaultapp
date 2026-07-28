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
  static const _background = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _primary = Color(0xFF3B82F6);
  static const _errorColor = Color(0xFFEF4444);

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final code = _controller.text.trim();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the 6-digit code')),
      );
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<AuthenticationCubit>().verifyLoginOtp(
          stepUpToken: widget.stepUpToken,
          code: code,
        );
  }

  /// Show a verification failure. A connectivity/edge failure is NOT a wrong
  /// code, so it reads as a connection problem (and pokes the health gate to
  /// re-probe) rather than surfacing raw transport text. Wrong/expired-code
  /// messages pass through unchanged.
  void _showFailure(BuildContext context, String message) {
    final m = message.toLowerCase();
    final looksNetwork = isNetworkError(message) ||
        m.contains('network error') ||
        m.contains('check your connection');
    if (looksNetwork) {
      ServerHealthNotifier.instance.pokeRecheck();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(looksNetwork
            ? "Connection problem — couldn't reach our servers. Please try again in a moment."
            : message),
      ),
    );
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
        title: const Text('Verify it\'s you', style: TextStyle(color: Colors.white)),
      ),
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccess) {
            // Session saved by the cubit; load the profile and route to the
            // dashboard (clears the login + OTP screens off the stack).
            try {
              context.read<ProfileCubit>().getUserProfile();
            } catch (_) {/* ProfileCubit not in scope — dashboard will load it */}
            Get.offAllNamed(AppRoutes.dashboard);
          } else if (state is AuthenticationError) {
            _showFailure(context, state.message);
          } else if (state is AuthenticationFailure) {
            _showFailure(context, state.message);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const Icon(Icons.shield_outlined, color: _primary, size: 40),
                const SizedBox(height: 16),
                const Text(
                  'New sign-in detected',
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'For your security, we sent a 6-digit code to your $channel '
                  '(${widget.destination}). Enter it to continue.',
                  style: const TextStyle(color: _textSecondary, fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 28),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      letterSpacing: 8,
                      fontWeight: FontWeight.w600),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '••••••',
                    hintStyle: const TextStyle(color: _textSecondary, letterSpacing: 8),
                    filled: true,
                    fillColor: _card,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: _divider),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: _primary),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                    final loading = state is AuthenticationLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: loading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          disabledBackgroundColor: _primary.withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: loading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('Verify & continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text('Use a different account',
                        style: TextStyle(color: _textSecondary)),
                  ),
                ),
                const Spacer(),
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
}
