import 'package:flutter/material.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/account_locked_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/services/server_status_service.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/passcode_dots.dart';
import 'package:lazervault/core/widgets/passcode_keypad.dart';
import 'package:lazervault/core/widgets/shake_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/presentation/views/two_factor_verification_screen.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_state.dart';
import 'package:lazervault/src/features/authentication/presentation/views/login_otp_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/device_phone_hint.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/widgets/smart_identifier_input.dart';

/// "Switch User" for the phone+passcode flow: log in as a DIFFERENT phone user
/// than the one cached on the passcode lock screen. Collects a phone number,
/// then a 6-digit passcode, and authenticates via
/// [PhonePasscodeCubit.loginWithPhonePasscode] (LoginWithPhonePasscode RPC).
/// On success the cubit persists the new session + stored user details, so the
/// NEXT passcode-lock screen greets the switched-to user.
class PhonePasscodeLoginScreen extends StatefulWidget {
  const PhonePasscodeLoginScreen({super.key});

  @override
  State<PhonePasscodeLoginScreen> createState() =>
      _PhonePasscodeLoginScreenState();
}

class _PhonePasscodeLoginScreenState extends State<PhonePasscodeLoginScreen> {
  static const int _length = 6;

  @override
  void initState() {
    super.initState();
    // Reflect an armed self-lock / emergency lock proactively (countdown modal).
    WidgetsBinding.instance
        .addPostFrameCallback((_) => maybeShowSelfLockOnLaunch(context));
  }

  final GlobalKey<ShakeWidgetState> _shakeKey = GlobalKey<ShakeWidgetState>();

  bool _passcodePhase = false;
  String _countryCode = 'NG';
  String? _prefillNational;

  // Login accepts a phone, an email OR a username + passcode (all three are
  // captured/unique at signup). A single smart field auto-detects which the
  // user typed; the resolved identifier (E.164 phone, lowercased email, or
  // normalized username) + its type are held here and sent to
  // LoginWithPhonePasscode, whose resolveLoginUser resolves the same three
  // shapes (email by '@', phone by digits, otherwise username).
  String _identifier = '';
  LoginIdentifierType _identifierType = LoginIdentifierType.phone;
  String? _identifierError;

  bool get _isPhoneIdentifier => _identifierType == LoginIdentifierType.phone;

  /// Copy for "no account matches what you typed", naming the kind of
  /// identifier it was and echoing the value back.
  ///
  /// The echo is the point. "We don't recognise that email" leaves the user
  /// staring at a field they believe is correct; "We don't recognise
  /// onhapraiz@gmail.com" puts the transposed letters in front of them. It also
  /// stays deliberately vague about WHY there is no match — it never implies
  /// whether some other spelling would have existed.
  String _unknownIdentifierMessage() {
    final value = _identifier.trim();
    switch (_identifierType) {
      case LoginIdentifierType.email:
        return "We don't recognise $value. Check the spelling and try again.";
      case LoginIdentifierType.username:
        final handle = value.startsWith('@') ? value : '@$value';
        return "We don't recognise $handle. Check the spelling and try again.";
      case LoginIdentifierType.phone:
        return "We don't recognise $value. Check the number and try again.";
    }
  }

  void _onIdentifierChanged(String identifier, LoginIdentifierType type) {
    final needsRepaint = type != _identifierType || _identifierError != null;
    _identifier = identifier;
    _identifierType = type;
    if (needsRepaint && mounted) {
      // Deferred so it's safe even when this fires from the field's
      // didUpdateWidget during the parent's build (country/prefill change).
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _identifierError = null);
      });
    }
  }

  /// Opens the OS number-picker (SIM numbers) and prefills the field as a phone.
  Future<void> _useDevicePhone() async {
    final dp = await DevicePhoneHint.request(preferredCountry: _countryCode);
    if (!mounted) return;
    if (dp == null) {
      showAppSnackbar('No number found',
          "We couldn't read a number from this device — enter it manually.",
          type: AppSnackbarType.info);
      return;
    }
    setState(() {
      _countryCode = dp.countryCode;
      _prefillNational = dp.national;
      _identifier = dp.e164;
      _identifierType = LoginIdentifierType.phone;
    });
  }

  String _entered = '';
  bool _submitting = false;

  void _onContinue() {
    if (_identifier.trim().isEmpty) {
      setState(() => _identifierError =
          'Enter your phone, email or username to continue.');
      return;
    }
    switch (_identifierType) {
      case LoginIdentifierType.email:
        if (!isEmailIdentifier(_identifier)) {
          setState(() => _identifierError = 'Enter a valid email address.');
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
        // Length/format check for the selected country's national number.
        final country = CountryConfigs.getByCode(_countryCode);
        if (country != null) {
          final dial = country.dialingCode.replaceAll('+', '');
          var nsn = _identifier.replaceAll(RegExp(r'[^\d]'), '');
          if (nsn.startsWith(dial)) nsn = nsn.substring(dial.length);
          if (nsn.length != country.nationalNumberLength) {
            setState(() => _identifierError =
                'Enter a valid ${country.name} phone number.');
            return;
          }
        }
        break;
    }
    setState(() {
      _passcodePhase = true;
      _entered = '';
      _identifierError = null;
    });
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
                    setState(() => _countryCode = c.code);
                    Navigator.of(sheetCtx).pop();
                  },
                )),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
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
    // `phone` carries the identifier — an email or an E.164 phone; the backend
    // detects which by the '@' and looks the account up accordingly.
    context
        .read<PhonePasscodeCubit>()
        .loginWithPhonePasscode(phone: _identifier, passcode: _entered);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhonePasscodeCubit, PhonePasscodeState>(
      listener: (context, state) {
        if (state is PhoneLoginTwoFactorRequired) {
          // 2FA enabled: collect the 2FA code (self-contained screen + cubit).
          Get.to(() => BlocProvider.value(
                value: serviceLocator<AuthenticationCubit>(),
                child: TwoFactorVerificationScreen(
                  twoFactorToken: state.twoFactorToken,
                  method: state.method,
                ),
              ));
          return;
        }
        if (state is PhoneLoginStepUpRequired) {
          // Risk-based step-up: collect the OTP (self-contained screen routes to
          // the dashboard on success).
          Get.to(() => LoginOtpScreen(
                stepUpToken: state.stepUpToken,
                method: state.method,
                destination: state.destination,
              ));
          return;
        }
        if (state is PhoneLoginSuccess) {
          // Sync the app-wide cubit so the dashboard/profile see the switched
          // user; the cubit already persisted the new stored_phone/name cache.
          context.read<AuthenticationCubit>().hydrateProfile(state.profile);
          context.read<ProfileCubit>().getUserProfile();
          Get.offAllNamed(AppRoutes.dashboard);
        } else if (state is PhonePasscodeFailure) {
          setState(() => _entered = '');
          // Self-lock / failed-login lockout → blocking countdown modal.
          final lockUntil = parseAccountLockUntil(state.message);
          if (lockUntil != null) {
            showAccountLockedModal(context, lockUntil,
                selfLock: isSelfLock(state.message),
                fraudFreeze: isFraudFreeze(state.message));
          } else {
            Haptics.error();
            _shakeKey.currentState?.shake();
            final m = state.message.toLowerCase();
            // The number has no phone+passcode account (either unregistered or an
            // email/password account with no passcode) — steer the user to create
            // one instead of letting them retry a passcode that can't exist.
            final noPasscodeAccount = m.contains('passcode not set') ||
                m.contains('no passcode') ||
                m.contains('not found') ||
                m.contains('no account') ||
                m.contains('does not exist');
            // NOBODY matched the identifier — a typo'd email/number, not a bad
            // passcode. auth-service returns exactly "invalid credentials" when
            // the user lookup finds nothing, and a genuinely wrong passcode
            // returns "Incorrect passcode. N attempt(s) remaining" instead, so
            // this string identifies the case precisely.
            //
            // It used to fall through to the generic branch, which showed
            // "Login failed" ON THE PASSCODE SCREEN — so a transposed letter in
            // an email read as "my correct passcode was rejected", with the
            // real mistake two screens back and never mentioned. Observed on
            // prod: "onhapraiz@" for "onahpraiz@", reported as a passcode bug.
            //
            // This reveals nothing new: the server already answers these two
            // cases differently, so an attacker probing the API learns exactly
            // what they did before. Only the UI routing changes.
            final unknownIdentifier = isUnknownIdentifierFailure(state.message);
            // A connectivity/edge failure is NOT a bad passcode — don't say
            // "Login failed" (which reads as wrong PIN). If it's a server-side
            // outage the maintenance modal owns the messaging, so poke the gate
            // to re-probe: it confirms with a real health check + device-online
            // check, so a genuine outage surfaces "we're working on our servers"
            // while the user's own offline/slow network stays this snackbar.
            final looksNetwork = isNetworkError(state.message) ||
                m.contains('network error') ||
                m.contains('check your connection');
            if (looksNetwork) {
              ServerHealthNotifier.instance.pokeRecheck();
              showAppSnackbar(
                'Connection problem',
                "We couldn't reach our servers. Please try again in a moment.",
                type: AppSnackbarType.error,
              );
            } else if (unknownIdentifier) {
              // Back to the identifier step with the error UNDER THE FIELD that
              // was actually wrong, echoing what was typed — a transposition is
              // invisible in prose but obvious next to the box you typed it in.
              setState(() {
                _passcodePhase = false;
                _identifierError = _unknownIdentifierMessage();
              });
            } else if (noPasscodeAccount) {
              setState(() => _passcodePhase = false); // back to the phone step
              showAppSnackbar(
                'No passcode account',
                "This number doesn't have a passcode account yet. Sign up instead.",
                type: AppSnackbarType.error,
                duration: const Duration(seconds: 5),
                mainButton: TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.signupEntry),
                  child: const Text('Sign up',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              );
            } else {
              showAppSnackbar('Login failed', state.message,
                  type: AppSnackbarType.error);
            }
          }
        }
      },
      builder: (context, state) {
        _submitting = state is PhonePasscodeLoading;
        return _passcodePhase ? _buildPasscodePhase() : _buildPhonePhase();
      },
    );
  }

  Widget _buildPhonePhase() {
    return PhoneFlowScaffold(
      title: 'Log in',
      subtitle: 'Enter your phone, email or username, then your passcode.',
      showHeadingLogo: false,
      primaryLabel: 'Continue',
      isLoading: _submitting,
      onPrimary: _submitting ? null : _onContinue,
      footer: _buildSignUpFooter(),
      children: [
        SizedBox(height: 8.h),
        // One smart field: auto-detects phone vs email and adapts inline.
        SmartIdentifierInput(
          key: ValueKey('$_countryCode-${_prefillNational ?? ''}'),
          countryCode: _countryCode,
          initialPhoneNational: _prefillNational,
          onCountryTap: _openCountryPicker,
          onChanged: _onIdentifierChanged,
          onSubmitted: (_) => _submitting ? null : _onContinue(),
          errorText: _identifierError,
        ),
        // The SIM shortcut only makes sense while entering a phone.
        if (DevicePhoneHint.isSupported && _isPhoneIdentifier) ...[
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _submitting ? null : _useDevicePhone,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: Icon(Icons.smartphone,
                  size: 18.sp, color: const Color(0xFF4834D4)),
              label: Text(
                'Use the number on this device',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4834D4),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// "Don't have an account? Sign up" — always available on the switch-user phone
  /// step so a number without a passcode account has a clear path to sign up.
  /// The footer floats over the bottom purple wave, so the text must be WHITE
  /// (black/purple was invisible against the purple background).
  Widget _buildSignUpFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        ),
        SizedBox(width: 4.w),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed:
              _submitting ? null : () => Get.toNamed(AppRoutes.signupEntry),
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasscodePhase() {
    return PhoneFlowScaffold(
      darkBackground: true,
      title: 'Enter your passcode',
      subtitle: 'For $_identifier',
      // Back from the passcode step returns to the login's phone step — NOT a
      // route pop (which would land on whatever pushed this login, i.e. the
      // signup phone screen). Covers both the app-bar back button and the
      // Android system back gesture.
      onBack: () => setState(() {
        _passcodePhase = false;
        _entered = '';
      }),
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
        SizedBox(height: 8.h),
        // Recovery path — reset the passcode via SMS OTP. Without this the
        // fresh-login passcode step is a dead end for a forgotten passcode.
        Center(
          child: TextButton(
            onPressed: _submitting
                ? null
                : () => Get.toNamed(AppRoutes.forgotPasscodePhone),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Forgot your passcode?',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
