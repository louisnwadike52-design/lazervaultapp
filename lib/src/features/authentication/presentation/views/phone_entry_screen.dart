import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/login_flow_resolver.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/account_locked_modal.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_passcode_state.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/phone_flow_scaffold.dart';
import 'package:lazervault/src/features/authentication/presentation/widgets/device_phone_hint.dart';
import 'package:lazervault/src/features/widgets/locked_country_phone_input.dart';

/// Step 1 of the phone+passcode signup: enter a phone number (country picker +
/// national number) and request an SMS OTP.
class PhoneEntryScreen extends StatefulWidget {
  const PhoneEntryScreen({super.key});

  @override
  State<PhoneEntryScreen> createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends State<PhoneEntryScreen> {
  String _countryCode = 'NG';
  String _e164Phone = '';
  // Prefilled national number (dial code stripped) from the device hint picker;
  // drives the phone field's initialValue via the widget key.
  String? _prefillNational;

  /// Opens the OS number-picker (SIM numbers on this device), then prefills the
  /// field so the user can review/edit before continuing.
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
      _e164Phone = dp.e164;
    });
  }

  void _onContinue() {
    if (_e164Phone.isEmpty) {
      showAppSnackbar(
          'Phone required', 'Please enter your phone number to continue.',
          type: AppSnackbarType.error);
      return;
    }
    // Client-side validation against the selected country (length + mobile
    // prefix) so a wrong number — too short/long OR a right-length but invalid
    // value like "1234567890" — is caught before the OTP round-trip.
    final country = CountryConfigs.getByCode(_countryCode);
    if (country != null) {
      final dial = country.dialingCode.replaceAll('+', '');
      var nsn = _e164Phone.replaceAll(RegExp(r'[^\d]'), '');
      if (nsn.startsWith(dial)) nsn = nsn.substring(dial.length);
      final err = country.validateNationalNumber(nsn);
      if (err != null) {
        showAppSnackbar('Invalid number', err, type: AppSnackbarType.error);
        return;
      }
    }
    context
        .read<PhonePasscodeCubit>()
        .requestPhoneOtp(phone: _e164Phone, countryCode: _countryCode);
  }

  /// Themed bottom sheet to change the country (the only place country is
  /// chosen — there's no separate country step). Lists signup-available
  /// countries; selecting one re-keys the phone field.
  void _openCountryPicker(List<CountryConfig> countries) {
    final available = countries.where((c) => c.isAvailableForSignup).toList();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select country',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ...available.map((c) {
                final selected = c.code == _countryCode;
                return ListTile(
                  leading: Text(c.flag, style: TextStyle(fontSize: 22.sp)),
                  title: Text(
                    c.name,
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ),
                  trailing: Text(
                    c.dialingCode,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.grey.shade400,
                    ),
                  ),
                  selected: selected,
                  onTap: () {
                    setState(() => _countryCode = c.code);
                    Navigator.of(sheetCtx).pop();
                  },
                );
              }),
              SizedBox(height: 8.h),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeCountries = CountryConfigs.activeCountries;

    return BlocConsumer<PhonePasscodeCubit, PhonePasscodeState>(
      listener: (context, state) {
        if (state is PhoneOtpSent) {
          Get.toNamed(AppRoutes.phoneOtp);
        } else if (state is PhonePasscodeFailure) {
          if (state.alreadyRegistered) {
            // This number already has an account → point them at login.
            showAppSnackbar('Account exists', state.message,
                type: AppSnackbarType.error,
                duration: const Duration(seconds: 5),
                mainButton: TextButton(
                  onPressed: () async {
                    // Account exists on the server but isn't cached on THIS
                    // device (fresh phone-signup entry) → full phone+passcode
                    // login, not the passcode lock (needs a cached identity).
                    // resolveLoginRoute honours a returning user too.
                    Get.toNamed(await LoginFlowResolver.resolveLoginRoute());
                  },
                  child: const Text('Log in',
                      style: TextStyle(color: Colors.white)),
                ));
          } else {
            showAppSnackbar('Error', state.message,
                type: AppSnackbarType.error);
          }
        }
      },
      builder: (context, state) {
        final isLoading = state is PhonePasscodeLoading;
        return PhoneFlowScaffold(
          title: 'Hi there 👋',
          subtitle:
              'Welcome to Lazervault, let\'s get started! Enter your phone '
              'number and we\'ll send a 6-digit code to verify it\'s you.',
          step: 1,
          totalSteps: 5,
          // First slide → no back button; the floating "Log in" footer is the
          // way out (to the canonical passcode login).
          showBack: false,
          primaryLabel: 'Continue',
          isLoading: isLoading,
          onPrimary: isLoading ? null : _onContinue,
          // Floats on the purple bottom curve (white text). Only on this first
          // slide. Existing users (incl. email/password) reach login from here.
          footer: TextButton(
            onPressed: isLoading
                ? null
                : () async {
                    // Existing users (incl. email/password) reach login here on
                    // a FRESH device → full login for the mode, not the passcode
                    // lock. resolveLoginRoute also handles a cached returning user.
                    Get.toNamed(await LoginFlowResolver.resolveLoginRoute());
                  },
            child: Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white.withValues(alpha: 0.85),
                ),
                children: [
                  TextSpan(
                    text: 'Log in',
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
          // First screen is intentionally minimal — just the phone number.
          // The country (flag + dial code) is the tappable prefix on the field
          // itself, so there is no separate country step. Re-key on country
          // change so the prefix + length formatter pick up the new selection.
          children: [
            SizedBox(height: 8.h),
            LockedCountryPhoneInput(
              // Re-key on country OR prefill change so the field picks up the
              // new initialValue from the device-hint picker.
              key: ValueKey('$_countryCode-${_prefillNational ?? ''}'),
              countryCode: _countryCode,
              initialValue: _prefillNational,
              hintText: 'Phone number',
              onChanged: (e164) => _e164Phone = e164,
              onCountryTap: () => _openCountryPicker(activeCountries),
            ),
            if (DevicePhoneHint.isSupported) ...[
              SizedBox(height: 8.h),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: isLoading ? null : _useDevicePhone,
                  style: TextButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  // Dark on the light phone step — white was invisible against
                  // the light curved-background body.
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
      },
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    // A phone-mode self-lock / emergency lock lands the user here — reflect it
    // proactively with a live countdown instead of only on a failed attempt.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => maybeShowSelfLockOnLaunch(context));
  }
}
