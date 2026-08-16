import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/passcode_dots.dart';
import 'package:lazervault/core/widgets/passcode_keypad.dart';
import 'package:lazervault/core/widgets/shake_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';

/// "Use Email Instead" — the passwordless analog of the email+password sign-in,
/// for phone+passcode (passwordless) accounts logging in on a device that has no
/// stored account (or a different account than the one shown on the passcode
/// lock). Collects an email, then a 6-digit passcode, and authenticates via
/// [AuthenticationCubit.loginWithPasscode] (LoginWithPasscode RPC) — no password.
class EmailPasscodeLoginScreen extends StatefulWidget {
  const EmailPasscodeLoginScreen({super.key});

  @override
  State<EmailPasscodeLoginScreen> createState() =>
      _EmailPasscodeLoginScreenState();
}

class _EmailPasscodeLoginScreenState extends State<EmailPasscodeLoginScreen> {
  static const int _length = 6;

  final _email = TextEditingController();
  final GlobalKey<ShakeWidgetState> _shakeKey = GlobalKey<ShakeWidgetState>();

  bool _passcodePhase = false;
  String _entered = '';
  String? _emailError;
  bool _submitting = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  // Shared, robust email check (same validator the smart-identifier login uses)
  // so a malformed address is caught HERE, before the passcode step — never
  // advance to the keypad on an invalid email.
  bool _isValidEmail(String email) => isEmailIdentifier(email);

  void _onEmailContinue() {
    final email = _email.text.trim();
    if (email.isEmpty || !_isValidEmail(email)) {
      setState(() => _emailError = 'Please enter a valid email address.');
      return;
    }
    setState(() {
      _emailError = null;
      _passcodePhase = true;
      _entered = '';
    });
  }

  void _onDigit(String d) {
    if (_submitting || _entered.length >= _length) return;
    setState(() => _entered += d);
    if (_entered.length == _length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _submit());
    }
  }

  void _onBackspace() {
    if (_submitting || _entered.isEmpty) return;
    setState(() => _entered = _entered.substring(0, _entered.length - 1));
  }

  void _submit() {
    if (_entered.length != _length) return;
    context.read<AuthenticationCubit>().loginWithPasscode(
          email: _email.text.trim(),
          passcode: _entered,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          context.read<ProfileCubit>().getUserProfile();
          Get.offAllNamed(AppRoutes.dashboard);
        } else if (state is AuthenticationError) {
          Haptics.error();
          _shakeKey.currentState?.shake();
          final m = state.message.toLowerCase();
          // An unknown email / no-passcode account is NOT a wrong passcode —
          // don't trap the user on the keypad. Bounce back to the email step so
          // they can fix the address (mirrors the phone+passcode switch-user flow).
          final unknownAccount = m.contains('not found') ||
              m.contains('no account') ||
              m.contains('does not exist') ||
              m.contains('no passcode') ||
              m.contains('passcode not set');
          setState(() {
            _entered = '';
            if (unknownAccount) {
              _passcodePhase = false;
              _emailError = 'We don’t recognise this email. Check it and try again.';
            }
          });
          if (!unknownAccount) {
            Get.snackbar('Login failed', state.message,
                snackPosition: SnackPosition.TOP);
          }
        }
      },
      builder: (context, state) {
        _submitting = state is AuthenticationLoading;
        return _passcodePhase ? _buildPasscodePhase() : _buildEmailPhase();
      },
    );
  }

  Widget _buildEmailPhase() {
    return PhoneFlowScaffold(
      title: 'Log in with email',
      subtitle: 'Enter your email, then your passcode.',
      primaryLabel: 'Continue',
      isLoading: _submitting,
      onPrimary: _submitting ? null : _onEmailContinue,
      children: [
        SizedBox(height: 8.h),
        BuildFormField(
          name: 'email',
          placeholder: 'Email',
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          enableSuggestions: false,
          prefixIcon: const Icon(Icons.email_outlined, color: Colors.black45),
          onChanged: (_) {
            if (_emailError != null) setState(() => _emailError = null);
          },
        ),
        if (_emailError != null) ...[
          SizedBox(height: 12.h),
          Text(
            _emailError!,
            style: TextStyle(
              color: const Color(0xFFEF4444),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPasscodePhase() {
    return PhoneFlowScaffold(
      darkBackground: true,
      title: 'Enter your passcode',
      subtitle: 'For ${_email.text.trim()}',
      children: [
        SizedBox(height: 20.h),
        ShakeWidget(
          key: _shakeKey,
          child: PasscodeDots(
            length: _length,
            filled: _entered.length,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withValues(alpha: 0.35),
          ),
        ),
        SizedBox(height: 40.h),
        PasscodeKeypad(
          onDigit: _onDigit,
          onBackspace: _onBackspace,
          disabled: _submitting,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
