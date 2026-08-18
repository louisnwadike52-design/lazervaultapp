import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/passcode_dots.dart';
import 'package:lazervault/core/widgets/passcode_keypad.dart';
import 'package:lazervault/core/widgets/shake_widget.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_state.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/widgets/locked_country_phone_input.dart';

/// Default login for PHONE_PASSCODE accounts: phone number + 6-digit passcode.
/// A discreet "Use another method" link routes to the email/password screen
/// (for accounts that also set an email).
class PhonePasscodeLoginScreen extends StatefulWidget {
  const PhonePasscodeLoginScreen({super.key});

  @override
  State<PhonePasscodeLoginScreen> createState() =>
      _PhonePasscodeLoginScreenState();
}

class _PhonePasscodeLoginScreenState extends State<PhonePasscodeLoginScreen> {
  static const int _length = 6;

  final GlobalKey<ShakeWidgetState> _shakeKey =
      GlobalKey<ShakeWidgetState>();

  String _countryCode = 'NG';
  String _e164Phone = '';
  String? _initialNationalNumber;
  String _passcode = '';
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _prefillFromStoredPhone();
  }

  Future<void> _prefillFromStoredPhone() async {
    try {
      final storedPhone =
          await serviceLocator<FlutterSecureStorage>().read(key: 'stored_phone');
      if (storedPhone != null && storedPhone.isNotEmpty) {
        _e164Phone = storedPhone;
        // Split into dial code (country) + national number for the input.
        final match = CountryLocales.all
            .where((c) => storedPhone.startsWith(c.dialCode))
            .toList()
          ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
        if (match.isNotEmpty) {
          _countryCode = match.first.countryCode;
          _initialNationalNumber =
              storedPhone.substring(match.first.dialCode.length);
        }
      }
    } catch (_) {
      // Best-effort prefill.
    } finally {
      if (mounted) setState(() => _ready = true);
    }
  }

  void _onDigit(String d) {
    if (_passcode.length >= _length) return;
    setState(() => _passcode += d);
    if (_passcode.length == _length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _attemptLogin());
    }
  }

  void _onBackspace() {
    if (_passcode.isEmpty) return;
    setState(() => _passcode = _passcode.substring(0, _passcode.length - 1));
  }

  void _attemptLogin() {
    if (_e164Phone.isEmpty) {
      Get.snackbar('Phone required', 'Please enter your phone number.',
          snackPosition: SnackPosition.TOP);
      setState(() => _passcode = '');
      return;
    }
    if (_passcode.length != _length) return;
    context.read<PhonePasscodeCubit>().loginWithPhonePasscode(
          phone: _e164Phone,
          passcode: _passcode,
        );
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Scaffold(backgroundColor: Colors.black);
    }
    return BlocConsumer<PhonePasscodeCubit, PhonePasscodeState>(
      listener: (context, state) {
        if (state is PhoneLoginSuccess) {
          Get.offAllNamed(AppRoutes.dashboard);
        } else if (state is PhonePasscodeFailure) {
          Haptics.error();
          _shakeKey.currentState?.shake();
          setState(() => _passcode = '');
          Get.snackbar('Login failed', state.message,
              snackPosition: SnackPosition.TOP);
        }
      },
      builder: (context, state) {
        final isLoading = state is PhonePasscodeLoading;
        return PhoneFlowScaffold(
          // Login is a passcode screen → dark login-passcode surface, matching
          // the canonical passcode login and the signup passcode screen.
          darkBackground: true,
          title: 'Welcome back',
          subtitle: 'Sign in with your phone number and passcode.',
          showBack: false,
          children: [
            SizedBox(height: 8.h),
            LockedCountryPhoneInput(
              key: ValueKey(_countryCode),
              countryCode: _countryCode,
              initialValue: _initialNationalNumber,
              hintText: 'Phone number',
              onChanged: (e164) => _e164Phone = e164,
            ),
            SizedBox(height: 32.h),
            Text(
              'Passcode',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            SizedBox(height: 16.h),
            ShakeWidget(
              key: _shakeKey,
              child: PasscodeDots(
                length: _length,
                filled: _passcode.length,
                activeColor: Colors.white,
                inactiveColor: Colors.white.withValues(alpha: 0.35),
              ),
            ),
            SizedBox(height: 28.h),
            AbsorbPointer(
              absorbing: isLoading,
              child: PasscodeKeypad(
                onDigit: _onDigit,
                onBackspace: _onBackspace,
                disabled: isLoading,
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: TextButton(
                onPressed: isLoading
                    ? null
                    : () => Get.toNamed(AppRoutes.emailSignIn),
                child: Text(
                  'Use another method',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
            ),
            // New users land here too (e.g. via the boot route): give them a
            // path into the phone signup flow.
            Center(
              child: TextButton(
                onPressed: isLoading
                    ? null
                    : () => Get.toNamed(AppRoutes.phoneEntry),
                child: Text.rich(
                  TextSpan(
                    text: 'New to LazerVault? ',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                    children: [
                      TextSpan(
                        text: 'Create account',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
