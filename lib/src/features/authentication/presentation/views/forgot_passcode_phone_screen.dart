import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utilities/passcode_policy.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/passcode_dots.dart';
import 'package:lazervault/core/widgets/passcode_keypad.dart';
import 'package:lazervault/core/widgets/shake_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/passcode_reset_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/passcode_reset_state.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/widgets/smart_identifier_input.dart';
import 'package:lazervault/src/features/widgets/resend_code_button.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/src/features/widgets/verification_decorations.dart';

/// "Forgot your passcode?" for phone+passcode (passwordless) accounts. Three
/// phases on one screen: confirm phone → enter SMS OTP → set a new passcode.
/// The new passcode is submitted together with the OTP (the backend verifies +
/// sets in a single ResetPasscodeWithOTP call).
class ForgotPasscodePhoneScreen extends StatefulWidget {
  const ForgotPasscodePhoneScreen({super.key});

  @override
  State<ForgotPasscodePhoneScreen> createState() =>
      _ForgotPasscodePhoneScreenState();
}

enum _Phase { phone, otp, passcode }

class _ForgotPasscodePhoneScreenState extends State<ForgotPasscodePhoneScreen> {
  static const int _length = 6;
  final _secureStorage = serviceLocator<FlutterSecureStorage>();

  _Phase _phase = _Phase.phone;

  String _countryCode = 'NG';
  String? _initialNsn;

  // Recover with the phone, email OR username registered at signup — a single
  // smart field auto-detects which (mirrors the login screen). The reset OTP is
  // ALWAYS SMS-delivered to the account's phone (the backend resolves an email
  // or username to that phone), so email/username are just alternate ways to
  // identify the account.
  String _identifier = '';
  LoginIdentifierType _identifierType = LoginIdentifierType.phone;
  String? _identifierError;

  bool get _isPhoneIdentifier => _identifierType == LoginIdentifierType.phone;

  void _onIdentifierChanged(String identifier, LoginIdentifierType type) {
    final needsRepaint =
        type != _identifierType || _identifierError != null;
    _identifier = identifier;
    _identifierType = type;
    if (needsRepaint && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _identifierError = null);
      });
    }
  }

  // OTP phase
  String _code = '';
  int _resendInitial = 0;
  int _resendKey = 0;
  int _otpResetKey = 0;

  // Passcode phase
  final GlobalKey<ShakeWidgetState> _shakeKey = GlobalKey<ShakeWidgetState>();
  String _entered = '';
  String _firstEntry = '';
  bool _confirmMode = false;
  String? _passcodeError;

  @override
  void initState() {
    super.initState();
    _prefillPhone();
  }

  Future<void> _prefillPhone() async {
    final stored = await _secureStorage.read(key: 'stored_phone');
    if (stored == null || stored.isEmpty || !mounted) return;
    // Match the stored E.164 against a known dialing code to split country +
    // national number, so the field pre-fills correctly.
    for (final c in CountryConfigs.activeCountries) {
      final dial = c.dialingCode.replaceAll('+', '');
      final digits = stored.replaceAll(RegExp(r'[^\d]'), '');
      if (digits.startsWith(dial)) {
        setState(() {
          _countryCode = c.code;
          _initialNsn = digits.substring(dial.length);
          _identifier = stored;
        });
        return;
      }
    }
    setState(() => _identifier = stored);
  }

  // ── Phone phase ────────────────────────────────────────────────────────
  void _onSendCode() {
    if (_identifier.trim().isEmpty) {
      setState(() => _identifierError =
          'Enter your phone, email or username to continue.');
      return;
    }
    switch (_identifierType) {
      case LoginIdentifierType.email:
        if (!isEmailIdentifier(_identifier)) {
          setState(() =>
              _identifierError = 'Enter a valid email address.');
          return;
        }
        break;
      case LoginIdentifierType.username:
        if (!isUsernameIdentifier(_identifier)) {
          setState(() => _identifierError =
              'Usernames are 3–30 letters, numbers or underscores.');
          return;
        }
        break;
      case LoginIdentifierType.phone:
        final country = CountryConfigs.getByCode(_countryCode);
        if (country != null) {
          final dial = country.dialingCode.replaceAll('+', '');
          var nsn = _identifier.replaceAll(RegExp(r'[^\d]'), '');
          if (nsn.startsWith(dial)) nsn = nsn.substring(dial.length);
          final err = country.validateNationalNumber(nsn);
          if (err != null) {
            setState(() => _identifierError = err);
            return;
          }
        }
        break;
    }
    // The identifier (phone E.164, email or username) is passed through; the
    // backend resolves an email/username to the account's phone and
    // SMS-delivers the OTP there.
    context
        .read<PasscodeResetCubit>()
        .requestReset(phone: _identifier, countryCode: _countryCode);
  }

  void _openCountryPicker() {
    final available =
        CountryConfigs.activeCountries.where((c) => c.isAvailableForSignup);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...available.map((c) => ListTile(
                  leading: Text(c.flag, style: TextStyle(fontSize: 22.sp)),
                  title: Text(c.name,
                      style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                  trailing: Text(c.dialingCode,
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                  onTap: () {
                    setState(() {
                      _countryCode = c.code;
                      _initialNsn = null;
                    });
                    Navigator.of(sheetCtx).pop();
                  },
                )),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }


  void _onOtpContinue() {
    if (_code.length != _length) {
      showAppSnackbar('Incomplete', 'Enter the 6-digit code.',
          type: AppSnackbarType.error);
      return;
    }
    // Validate the code with the backend BEFORE advancing. The listener moves to
    // the new-passcode step only on PasscodeResetCodeVerified; an invalid or
    // expired code surfaces an error and never proceeds.
    context.read<PasscodeResetCubit>().verifyCode(_code);
  }

  // ── Passcode phase ─────────────────────────────────────────────────────
  void _onDigit(String d) {
    if (_entered.length >= _length) return;
    setState(() {
      _entered += d;
      _passcodeError = null;
    });
    if (_entered.length == _length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _onPasscodeComplete());
    }
  }

  void _onBackspace() {
    if (_entered.isEmpty) return;
    setState(() {
      _entered = _entered.substring(0, _entered.length - 1);
      _passcodeError = null;
    });
  }

  void _onPasscodeComplete() {
    if (!_confirmMode) {
      // Reject trivially guessable passcodes on the first entry, before confirm.
      if (isWeakNumericCode(_entered)) {
        Haptics.error();
        _shakeKey.currentState?.shake();
        setState(() {
          _passcodeError =
              'Choose a less predictable passcode (avoid 111111 or 123456).';
          _entered = '';
        });
        return;
      }
      setState(() {
        _firstEntry = _entered;
        _entered = '';
        _confirmMode = true;
      });
      return;
    }
    if (_entered != _firstEntry) {
      Haptics.error();
      _shakeKey.currentState?.shake();
      setState(() {
        _passcodeError = 'Passcodes do not match. Try again.';
        _entered = '';
        _firstEntry = '';
        _confirmMode = false;
      });
      return;
    }
    context.read<PasscodeResetCubit>().submitNewPasscode(_firstEntry);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasscodeResetCubit, PasscodeResetState>(
      listener: (context, state) {
        if (state is PasscodeResetOtpSent) {
          setState(() {
            _phase = _Phase.otp;
            _code = '';
            _otpResetKey++;
            _resendInitial = state.resendAfterSeconds;
            _resendKey++;
          });
        } else if (state is PasscodeResetCodeVerified) {
          // Code confirmed by the backend — now let the user set a new passcode.
          setState(() {
            _phase = _Phase.passcode;
            _entered = '';
            _firstEntry = '';
            _confirmMode = false;
            _passcodeError = null;
          });
        } else if (state is PasscodeResetSuccess) {
          showAppSnackbar('Passcode reset',
              'Your passcode was reset. Please log in with your new passcode.',
              type: AppSnackbarType.success);
          Get.offAllNamed(AppRoutes.passcodeLogin);
        } else if (state is PasscodeResetFailure) {
          if (state.restartFlow) {
            // Bad/expired code — go back to the OTP step to re-enter.
            setState(() {
              _phase = _Phase.otp;
              _code = '';
              _entered = '';
              _firstEntry = '';
              _confirmMode = false;
              _otpResetKey++;
            });
          }
          showAppSnackbar('Error', state.message, type: AppSnackbarType.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is PasscodeResetLoading;
        switch (_phase) {
          case _Phase.phone:
            return _buildPhonePhase(isLoading);
          case _Phase.otp:
            return _buildOtpPhase(isLoading);
          case _Phase.passcode:
            return _buildPasscodePhase();
        }
      },
    );
  }

  Widget _buildPhonePhase(bool isLoading) {
    return PhoneFlowScaffold(
      title: 'Reset your passcode',
      subtitle: _isPhoneIdentifier
          ? 'We\'ll send a 6-digit code to your phone to confirm it\'s you.'
          : 'We\'ll text a 6-digit code to the phone on your account to confirm it\'s you.',
      showHeadingLogo: false,
      primaryLabel: 'Send code',
      isLoading: isLoading,
      onPrimary: isLoading ? null : _onSendCode,
      children: [
        SizedBox(height: 8.h),
        // One smart field: auto-detects phone vs email and adapts inline.
        SmartIdentifierInput(
          key: ValueKey('$_countryCode-${_initialNsn ?? ''}'),
          countryCode: _countryCode,
          initialPhoneNational: _initialNsn,
          onCountryTap: _openCountryPicker,
          onChanged: _onIdentifierChanged,
          onSubmitted: (_) => isLoading ? null : _onSendCode(),
          errorText: _identifierError,
        ),
      ],
    );
  }

  Widget _buildOtpPhase(bool isLoading) {
    return PhoneFlowScaffold(
      title: 'Verify your number',
      subtitle: _isPhoneIdentifier
          ? 'Enter the 6-digit code we sent to ${context.read<PasscodeResetCubit>().phone}.'
          : 'Enter the 6-digit code we sent by SMS to the phone on your account.',
      primaryLabel: 'Continue',
      isLoading: isLoading,
      onPrimary: isLoading ? null : _onOtpContinue,
      children: [
        SizedBox(height: 8.h),
        const Center(child: VerificationBadgeIcon(icon: Icons.sms_outlined)),
        SizedBox(height: 28.h),
        VerificationCodeInput(
          key: ValueKey(_otpResetKey),
          onChanged: (code) => _code = code,
          onCompleted: (code) {
            _code = code;
            if (!isLoading) _onOtpContinue();
          },
        ),
        SizedBox(height: 28.h),
        Center(
          child: ResendCodeButton(
            key: ValueKey('reset-resend-$_resendKey'),
            initialSeconds: _resendInitial,
            onResend: () async {
              context.read<PasscodeResetCubit>().resendOtp();
              return 60;
            },
          ),
        ),
        SizedBox(height: 28.h),
        SecureVerificationNote(
          message: _isPhoneIdentifier
              ? 'We sent a 6-digit code via SMS to verify your phone number. Standard message rates may apply.'
              : 'We sent a 6-digit code by SMS to the phone on your account. Standard message rates may apply.',
        ),
      ],
    );
  }

  Widget _buildPasscodePhase() {
    return PhoneFlowScaffold(
      darkBackground: true,
      title: _confirmMode ? 'Confirm new passcode' : 'Create a new passcode',
      subtitle: _confirmMode
          ? 'Enter your new passcode again to confirm.'
          : 'Set a new 6-digit passcode for quick, secure login.',
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
        if (_passcodeError != null) ...[
          SizedBox(height: 14.h),
          Text(
            _passcodeError!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFFFCA5A5),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        SizedBox(height: 40.h),
        PasscodeKeypad(
          onDigit: _onDigit,
          onBackspace: _onBackspace,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
