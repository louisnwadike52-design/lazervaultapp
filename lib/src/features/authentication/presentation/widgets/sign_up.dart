import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final LocalAuthentication auth = LocalAuthentication();
  late PageController _pageController;
  bool isPasswordObscured = true;
  late ResponsiveController _responsiveController;

  // ── Phone-number capture (lives at the bottom of page 2) ──────────────
  // Country defaults to the user's signup country (set on page 0). The
  // chip opens a bottomsheet picker so the user can swap country. We
  // also offer a SIM-hint prefill via the platform Google-account picker
  // (Android only; iOS has no equivalent API).
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  CountryLocale _phoneCountry = const CountryLocale(
    countryCode: 'NG',
    countryName: 'Nigeria',
    languageCode: 'en',
    locale: 'en-NG',
    flag: '🇳🇬',
    dialCode: '+234',
    currency: 'NGN',
  );
  bool _hintAutoTried = false;
  // Inline phone-validation error shown beneath the input. Populated by
  // _validatePhoneNsn() on each keystroke so the user gets per-country
  // length feedback without waiting for Continue to fire.
  String? _phoneError;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _responsiveController = ResponsiveController(context);
    // Initialize the sign-up process in the cubit after the frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthenticationCubit>().startSignUp();
        _syncPhoneCountryFromSignup();
      }
    });
    _phoneFocusNode.addListener(_onPhoneFocusChanged);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _phoneController.dispose();
    _phoneFocusNode.removeListener(_onPhoneFocusChanged);
    _phoneFocusNode.dispose();
    // Optionally reset the cubit state if navigating away definitively
    // context.read<AuthenticationCubit>().cancelSignUp(); // Or handle in routing
    super.dispose();
  }

  // ── Phone helpers ─────────────────────────────────────────────────────

  /// Seed the phone country from the registration country selected on
  /// page 0. Falls back to NG if the auth cubit hasn't set one yet.
  void _syncPhoneCountryFromSignup() {
    final state = context.read<AuthenticationCubit>().state;
    if (state is SignUpInProgress && state.countryCode.isNotEmpty) {
      final c = CountryLocales.findByCountryCode(state.countryCode);
      if (c != null && mounted) {
        setState(() => _phoneCountry = c);
      }
    }
  }

  /// First time the user focuses the phone field, silently try to fetch a
  /// SIM/Google-account hint. The user can also trigger it via the CTA
  /// button below the field at any time. We only auto-fetch once so we
  /// don't badger the user on every focus.
  void _onPhoneFocusChanged() {
    if (!_phoneFocusNode.hasFocus) return;
    if (_hintAutoTried) return;
    _hintAutoTried = true;
    _requestSimHint(silent: true);
  }

  /// Show the platform Google-account number picker (Android only). When
  /// the user picks a number we adopt the country from its dial code AND
  /// fill the input with the national-significant number — they can
  /// still edit it before submitting.
  ///
  /// `silent=true` is the auto-on-focus call: we don't surface "no hint
  /// available" messages. `silent=false` is the explicit CTA tap, where
  /// we DO want to tell the user when it fails so they know to type.
  Future<void> _requestSimHint({required bool silent}) async {
    if (!Platform.isAndroid) {
      if (!silent) {
        Get.snackbar(
          'Unavailable',
          'SIM-based phone fill is only supported on Android.',
          snackPosition: SnackPosition.TOP,
        );
      }
      return;
    }
    try {
      final hint = await SmsAutoFill().hint;
      if (!mounted || hint == null || hint.isEmpty) {
        if (!silent) {
          Get.snackbar(
            'No number found',
            'No phone number is associated with this device.',
            snackPosition: SnackPosition.TOP,
          );
        }
        return;
      }
      // Skip the well-known Android emulator dummy (+1555xxxxxxx) — it
      // would mislead a user who picked Nigeria.
      final cleanHint = hint.replaceAll(RegExp(r'[^\d+]'), '');
      if (cleanHint.startsWith('+1555')) {
        if (!silent) {
          Get.snackbar(
            'Test number ignored',
            'The emulator returned a placeholder number — please type yours.',
            snackPosition: SnackPosition.TOP,
          );
        }
        return;
      }
      final country = _countryFromE164(cleanHint);
      setState(() {
        if (country != null) {
          _phoneCountry = country;
          _phoneController.text = cleanHint.substring(country.dialCode.length);
        } else {
          // Unknown dial code → fill raw, user picks country manually.
          _phoneController.text = cleanHint;
        }
        _phoneError = _validatePhoneNsn();
      });
      // Push the value into the cubit so signup submits with this phone.
      context
          .read<AuthenticationCubit>()
          .signUpPhoneNumberChanged(_buildE164Phone());
    } catch (_) {
      if (!silent) {
        Get.snackbar(
          'Couldn\'t read SIM',
          'Try typing your number manually.',
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  CountryLocale? _countryFromE164(String e164) {
    if (!e164.startsWith('+')) return null;
    final candidates = List<CountryLocale>.from(CountryLocales.all)
      ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
    for (final c in candidates) {
      if (e164.startsWith(c.dialCode)) return c;
    }
    return null;
  }

  String _digitsOnly(String raw) => raw.replaceAll(RegExp(r'\D'), '');

  /// Canonicalise the raw input into an NSN (national-significant
  /// number) for the selected country. We strip a single leading "0"
  /// trunk prefix ONLY when the raw input is exactly `max NSN + 1`
  /// digits AND starts with 0 — that's the unambiguous "0 + NSN"
  /// pattern (e.g. NG `08012345678` → `8012345678`). For shorter
  /// inputs we leave the leading 0 alone since it might be part of
  /// the actual NSN; the length validator below will surface a clear
  /// error if it's wrong.
  String _canonicalNsn() {
    final raw = _digitsOnly(_phoneController.text);
    final range = _nsnLengthByCountry[_phoneCountry.countryCode];
    if (range != null) {
      final (_, max) = range;
      if (raw.length == max + 1 && raw.startsWith('0')) {
        return raw.substring(1);
      }
    }
    return raw;
  }

  /// Build the E.164 phone (dial code + canonical NSN) from current state.
  String _buildE164Phone() {
    final nsn = _canonicalNsn();
    return nsn.isEmpty ? '' : '${_phoneCountry.dialCode}$nsn';
  }

  /// Expected NSN length per country (ITU-T E.164). Same table used on
  /// the now-defunct AddPhoneNumber screen — kept here so submit-time
  /// validation gives a precise "should be N digits" error instead of a
  /// generic backend failure later.
  static const Map<String, (int min, int max)> _nsnLengthByCountry = {
    'NG': (10, 10),
    'GH': (9, 9),
    'KE': (9, 9),
    'ZA': (9, 9),
    'GB': (10, 10),
    'US': (10, 10),
    'CA': (10, 10),
    'IN': (10, 10),
    'EG': (10, 10),
    'TZ': (9, 9),
    'UG': (9, 9),
    'RW': (9, 9),
    'CI': (10, 10),
    'SN': (9, 9),
    'CM': (9, 9),
  };

  /// Max raw-input length we'll accept in the phone TextField for the
  /// currently-selected country. We allow ONE extra digit beyond the
  /// country's max NSN length so users can type the optional trunk "0"
  /// (e.g. `08012345678` for Nigeria) without being cut off — that
  /// leading zero is stripped before submission. Fallback to 14 when
  /// the country isn't in the table so we never hard-block unknown
  /// regions.
  int get _maxPhoneInputLength {
    final range = _nsnLengthByCountry[_phoneCountry.countryCode];
    if (range == null) return 14;
    return range.$2 + 1; // +1 for the optional leading "0"
  }

  /// Accepts the user's raw entry for the selected country.
  ///
  /// Rule (applies uniformly to all 6 supported locales — NG/GH/KE/ZA/
  /// GB/US): the typed digit count must equal the country's NSN length
  /// OR NSN length + 1 (where the extra digit is an optional leading
  /// "0" trunk prefix). Examples for Nigeria (NSN = 10):
  ///   • `8012345678`  (10 digits, no trunk)        → valid
  ///   • `08012345678` (11 digits, leading 0 trunk) → valid
  ///   • Anything else (e.g. 9, 12+, or `0` plus 9 NSN digits) → invalid
  ///
  /// Error messages reference both valid forms so the user knows exactly
  /// what to fix.
  String? _validatePhoneNsn() {
    final raw = _digitsOnly(_phoneController.text);
    if (raw.isEmpty) return 'Phone number is required';
    final range = _nsnLengthByCountry[_phoneCountry.countryCode];
    if (range == null) {
      // Unknown country — fall back to a permissive 7..14 range that
      // covers every E.164 NSN length we'll realistically see.
      if (raw.length < 7 || raw.length > 14) {
        return 'Please enter a valid phone number for ${_phoneCountry.countryName}.';
      }
      return null;
    }
    final (min, max) = range;
    // Allowed raw lengths: the NSN length itself OR one more (for the
    // optional leading "0" trunk). When max+1 is allowed, it MUST start
    // with 0 — a 12-digit Nigerian number that doesn't start with 0 is
    // not a "trunk + NSN" pattern; it's just too long.
    final isNsnOnly = raw.length >= min && raw.length <= max;
    final isTrunkAndNsn = raw.length == max + 1 && raw.startsWith('0');
    if (!isNsnOnly && !isTrunkAndNsn) {
      final nsnExpected = (min == max) ? '$min' : '$min–$max';
      // US/CA don't use a leading trunk 0 (NANP) — don't suggest one.
      const nanpCountries = {'US', 'CA'};
      if (nanpCountries.contains(_phoneCountry.countryCode)) {
        return 'Phone number for ${_phoneCountry.countryName} should be $nsnExpected digits.';
      }
      return 'Phone number for ${_phoneCountry.countryName} should be $nsnExpected digits (or ${max + 1} with a leading 0).';
    }
    return null;
  }

  /// Continue-button pre-flight. On signup page 2 we run the per-country
  /// length check BEFORE handing off to the cubit so an invalid phone
  /// (too short, too long, leading-zero quirks) is caught right here
  /// with an inline error rather than failing later at the backend.
  void _onContinuePressed() {
    final cubit = context.read<AuthenticationCubit>();
    final state = cubit.state;
    if (state is SignUpInProgress && state.currentPage == 2) {
      final err = _validatePhoneNsn();
      if (err != null) {
        Haptics.error();
        setState(() => _phoneError = err);
        return;
      }
    }
    cubit.signUpNextPage();
  }

  void _openPhoneCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => _PhoneCountryPickerSheet(
        selectedCode: _phoneCountry.countryCode,
        onSelect: (c) {
          setState(() {
            _phoneCountry = c;
            // Country changed → clear the NSN so the user doesn't submit
            // an NG number under a UK dial code by accident.
            _phoneController.clear();
            _phoneError = null;
          });
          // Push the (now-empty) phone state through so the cubit knows
          // we no longer have a phone until the user re-types.
          context
              .read<AuthenticationCubit>()
              .signUpPhoneNumberChanged('');
          Navigator.of(context).pop();
        },
      ),
    );
  }

  /// **Date Picker Function - Uses native date picker for each platform**
  Future<void> _showDatePicker() async {
    final currentContext = context;
    // Read state only if it's SignUpInProgress
    DateTime initialPickerDate = DateTime(2000, 1, 1);
    final currentState = currentContext.read<AuthenticationCubit>().state;
    if (currentState is SignUpInProgress) {
       initialPickerDate = currentState.selectedDate ?? initialPickerDate;
    }

    DateTime? pickedDate;

    // Use platform-specific date picker
    if (Theme.of(currentContext).platform == TargetPlatform.iOS) {
      // iOS native picker
      await showCupertinoModalPopup<void>(
        context: currentContext,
        builder: (BuildContext context) {
          DateTime tempPickedDate = initialPickerDate;
          return Container(
            height: 250.h,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        pickedDate = tempPickedDate;
                        Navigator.of(context).pop();
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialPickerDate,
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      tempPickedDate = newDate;
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Android/Material native picker
      pickedDate = await showDatePicker(
        context: currentContext,
        initialDate: initialPickerDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
    }

    if (pickedDate != null && currentContext.mounted) {
      // Call the cubit method to update the date
      currentContext.read<AuthenticationCubit>().signUpDateOfBirthChanged(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tap-outside-fields dismisses the keyboard. Wraps the full body so
    // taps on any inert surface (background, divider, padding, etc.) unfocus
    // the active text field. `behavior: opaque` so taps on transparent
    // areas still register.
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        // Use object destructuring within the listener
        switch (state) {
          // Removed duplicate error snackbar - cubit already shows errors via _showErrorSnackbar
           case SignUpInProgress(currentPage: final pageNum): // Destructure page number
             // Handle page changes triggered by cubit state update
             if (_pageController.hasClients && _pageController.page?.round() != pageNum) {
                  _pageController.animateToPage(
                      pageNum,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                  );
             }
             break;
          case AuthenticationError(message: final msg): // Destructure error message
            Get.snackbar(
              'Error',
              msg,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
              margin: EdgeInsets.all(15.w),
              borderRadius: 10.r,
            );
            // IMPORTANT: Ensure the Cubit emits SignUpInProgress state with previous
            // fullName, selectedDate, and phoneNumber after this error to prevent fields clearing.
            break;
          case AuthenticationSuccess():
            // This case is typically for login, not signup
            // Signup uses UserCreated state
            break;
          case UserCreated(): // Handle successful user creation
            // Navigate to PRIMARY credential OTP screen only
            // Secondary verification will be shown after primary is complete
            final cubit = context.read<AuthenticationCubit>();
            final signupState = cubit.state;

            String? phoneNumber;
            String? email;
            PrimaryContactType primaryType = PrimaryContactType.email;

            // Get data from SignUpInProgress state if available
            if (signupState is SignUpInProgress) {
              phoneNumber = signupState.phoneNumber;
              email = signupState.email;
              primaryType = signupState.primaryContactType;
            } else if (cubit.currentProfile != null) {
              // Fallback to profile data
              phoneNumber = cubit.currentProfile!.user.phoneNumber;
              email = cubit.currentProfile!.user.email;
            }

            // Determine if secondary verification is needed
            final hasSecondaryPhone = phoneNumber != null && phoneNumber.isNotEmpty;
            final hasSecondaryEmail = email != null && email.isNotEmpty;

            // Navigate based on PRIMARY contact type
            // Note: No "Account Created" snackbar here since email is sent after ID verification
            if (primaryType == PrimaryContactType.phone) {
              // Navigate to phone OTP (required) - pass secondary email info
              Get.offAllNamed(AppRoutes.phoneVerification, arguments: {
                'phoneNumber': phoneNumber,
                'codeSent': true,
                'expiresIn': 600,
                'isRequired': true,
                'secondaryEmail': hasSecondaryEmail ? email : null,
              });
            } else {
              // Default to email verification (email is primary)
              // Navigate to email OTP (required) - pass secondary phone info
              Get.offAllNamed(AppRoutes.emailVerification, arguments: {
                'email': email,
                'codeSent': true,
                'isRequired': true,
                'secondaryPhone': hasSecondaryPhone ? phoneNumber : null,
              });
            }
            break;
          default:
             // Handle other states or do nothing
             break;
        }
      },
      // Use BlocBuilder to react to state changes for UI rendering
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
           // Destructure state values for UI
           final (
             :currentPage,
             :isLoading,
             :initialEmail,
             :firstName,
             :lastName,
             :selectedDate,
             :phoneNumber,
             :countryCode,
             :countryName,
           ) = switch (state) {
              SignUpInProgress p => (
                  currentPage: p.currentPage,
                  isLoading: p.isLoading,
                  initialEmail: p.email,
                  firstName: p.firstName,
                  lastName: p.lastName,
                  selectedDate: p.selectedDate,
                  phoneNumber: p.phoneNumber,
                  countryCode: p.countryCode,
                  countryName: p.countryName,
              ),
              _ => (
                  currentPage: 0,
                  isLoading: false,
                  initialEmail: null,
                  firstName: null,
                  lastName: null,
                  selectedDate: null,
                  phoneNumber: null,
                  countryCode: 'NG',
                  countryName: 'Nigeria',
              )
           };

          final bool displayLoading = isLoading;

          return Column(
            children: [
              // --- Back Button ---
              Visibility(
                visible: currentPage > 0,
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0.h),
                  child: Row(children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      // Ensure cubit handles going back correctly
                      onPressed: () => context.read<AuthenticationCubit>().signUpPreviousPage(),
                    ),
                  ]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: _responsiveController.screenHeight * (currentPage > 0 ? 0.04 : 0.15)),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: UniversalImageLoader(
                              imagePath: AppData.appLogo,
                              height: 70.0.h,
                              width: 70.0.w),
                        ),
                        Text("Hi there 👋",
                              style: TextStyle(
                                  fontSize: 18.0.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          SizedBox(height: 8.0.h),
                          Text("Welcome to Lazervault, let's get started!",
                              style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54)),
                          SizedBox(height: 20.0.h),
                        // Page content: 0 country, 1 credentials, 2 personal info
                        if (currentPage == 0)
                          _buildCountrySelectionPage(context, countryCode: countryCode, countryName: countryName, isLoading: displayLoading)
                        else if (currentPage == 1)
                          _buildEmailPasswordPage(context, initialEmail: initialEmail, isLoading: displayLoading)
                        else if (currentPage == 2)
                          _buildPersonalInfoPage(context, initialFirstName: firstName, initialLastName: lastName, selectedDate: selectedDate, initialPhoneNumber: phoneNumber, isLoading: displayLoading),
                        SizedBox(height: 24.0.h),
                      ],
                    ),
                  ),
                ),
              ),
              // ── Sticky themed bottom action panel ───────────────────
              // Holds Continue + "Already have an account? Sign In" in a
              // single brand-purple gradient surface that sits flush at the
              // bottom; the form above scrolls under it.
              //
              // Page 1 (email/password) already exposes its OWN Continue
              // button under the social row, which is the canonical action
              // for that step. To avoid a duplicate, we suppress the sticky
              // Continue on page 1 — pages 0 (country select) and 2
              // (personal info) still need it as their only action button.
              // The "Already have an account?" link stays on every page.
              Container(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_brandPurple, _brandPurpleDeep],
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (currentPage != 1) ...[
                      SizedBox(
                        width: double.infinity,
                        height: 52.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: _brandPurple,
                            disabledBackgroundColor:
                                Colors.white.withValues(alpha: 0.55),
                            disabledForegroundColor:
                                _brandPurple.withValues(alpha: 0.5),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.r),
                            ),
                          ),
                          onPressed: (displayLoading ||
                                  (currentPage == 0 && countryCode.isEmpty))
                              ? null
                              : _onContinuePressed,
                          child: displayLoading
                              ? LazerVaultLoader(size: 22)
                              : Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () =>
                              Get.toNamed(AppRoutes.emailSignIn),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      ),
    );
  }

  // Helper method for Country Selection Page (Page 0)
  Widget _buildCountrySelectionPage(BuildContext context, {required String countryCode, required String countryName, required bool isLoading}) {
    // Get active countries from CountryConfigs
    final activeCountries = CountryConfigs.activeCountries;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Your Country",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "We'll customize your experience based on your location.",
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 24.h),

        // Supported Countries from CountryConfigs
        ...activeCountries.map((config) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _buildCountryOption(
              context,
              countryCode: config.code,
              countryName: config.name,
              currencyCode: config.currency,
              flag: config.flag,
              isSelected: countryCode == config.code,
              isSupported: config.isAvailableForSignup,
              isBeta: config.isBeta,
            ),
          );
        }),

        SizedBox(height: 16.h),
        // Continue button moved to the sticky themed bottom panel (shared by
        // all 3 pages). Page-0 disable-on-no-country logic lives there too.
      ],
    );
  }

  // Helper to build country option card
  Widget _buildCountryOption(
    BuildContext context, {
    required String countryCode,
    required String countryName,
    required String currencyCode,
    required String flag,
    required bool isSelected,
    required bool isSupported,
    bool isBeta = false,
  }) {
    return GestureDetector(
      onTap: isSupported
          ? () => context.read<AuthenticationCubit>().signUpCountryChanged(countryCode, countryName, currencyCode)
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? _brandPurple.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? _brandPurple : (isSupported ? Colors.grey.shade300 : Colors.grey.shade200),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 28.sp)),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    countryName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isSupported ? Colors.black87 : Colors.grey,
                    ),
                  ),
                  Text(
                    currencyCode,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isSupported ? Colors.black54 : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: _brandPurple, size: 24.sp)
            else if (isBeta)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _brandOrange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Beta",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _brandOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            else if (!isSupported)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Soon",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper method for Email/Password Page (Page 1)
  Widget _buildEmailPasswordPage(BuildContext context, {String? initialEmail, required bool isLoading}) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final password = state is SignUpInProgress ? state.password : '';
        final confirmPassword = state is SignUpInProgress ? state.confirmPassword : '';
        final primaryContactType = state is SignUpInProgress ? state.primaryContactType : PrimaryContactType.none;
        final email = state is SignUpInProgress ? state.email : '';
        final phoneNumber = state is SignUpInProgress ? state.phoneNumber : '';

        // Password validation checks
        final hasMinLength = password.length >= 8;
        final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
        final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
        final hasDigit = RegExp(r'[0-9]').hasMatch(password);
        final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\\/;`~]').hasMatch(password);
        final passwordsMatch = password.isNotEmpty && confirmPassword.isNotEmpty && password == confirmPassword;

        // All five rules satisfied — the password is good. Once this is
        // true we collapse the rules list down to a single "Strong
        // password ✓" line. While the user is still building their
        // password (at least one rule failing) we keep the chips visible
        // so they can see what's left to satisfy.
        final passwordFullyValid = hasMinLength &&
            hasUppercase &&
            hasLowercase &&
            hasDigit &&
            hasSpecialChar;

        // Show indicators only if user has started typing
        final showPasswordIndicators = password.isNotEmpty;
        final showConfirmPasswordIndicator = confirmPassword.isNotEmpty;

        // Get current value for unified field (email or phone)
        final currentContactValue = primaryContactType == PrimaryContactType.phone
            ? phoneNumber
            : (email.isNotEmpty ? email : initialEmail ?? '');

        // Determine icon based on detected type
        final contactIcon = primaryContactType == PrimaryContactType.phone
            ? Icons.phone
            : (primaryContactType == PrimaryContactType.email ? Icons.email : Icons.person_outline);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Unified Email or Phone Number field
            BuildFormField(
              name: "emailOrPhone",
              placeholder: "Email or Phone Number",
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(contactIcon, color: Colors.black45),
              initialValue: currentContactValue,
              onChanged: (value) => context.read<AuthenticationCubit>().signUpEmailOrPhoneChanged(value),
            ),
            // Show hint about detected type
            if (primaryContactType != PrimaryContactType.none) ...[
              SizedBox(height: 4.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: Text(
                  primaryContactType == PrimaryContactType.phone
                      ? 'Detected: Phone number'
                      : 'Detected: Email address',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
            SizedBox(height: 8.0.h),
            BuildFormField(
              name: "password",
              placeholder: "Password",
              obscureText: true,
              prefixIcon: const Icon(Icons.lock, color: Colors.black45),
              onChanged: (value) => context.read<AuthenticationCubit>().signUpPasswordChanged(value),
            ),
            // Password strength meter + requirement chips — same style as
            // reset-password screen so the user gets identical feedback in
            // both flows. Strength bar + chips fade in only while typing.
            if (showPasswordIndicators) ...[
              SizedBox(height: 8.h),
              Builder(builder: (context) {
                final label = _passwordStrengthLabel(
                  hasMin: hasMinLength,
                  hasUpper: hasUppercase,
                  hasLower: hasLowercase,
                  hasDigit: hasDigit,
                  hasSpecial: hasSpecialChar,
                );
                final color = _passwordStrengthColor(
                  hasMin: hasMinLength,
                  hasUpper: hasUppercase,
                  hasLower: hasLowercase,
                  hasDigit: hasDigit,
                  hasSpecial: hasSpecialChar,
                );
                final fraction = _passwordStrengthFraction(label);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        'Password Strength: ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ]),
                    SizedBox(height: 4.h),
                    // Animated strength bar — width tweens as the user types.
                    Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                      child: AnimatedFractionallySizedBox(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                        widthFactor: fraction,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Once all five rules pass, the chip grid is replaced
                    // by a single confirmation line. While any rule is
                    // failing we still surface the unmet ones so the
                    // user can see what to fix.
                    if (passwordFullyValid)
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 16.sp,
                            color: const Color(0xFF10B981),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Strong password',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF10B981),
                            ),
                          ),
                        ],
                      )
                    else
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 4.h,
                        children: [
                          _buildRequirementItem('At least 8 characters', hasMinLength),
                          _buildRequirementItem('One uppercase letter', hasUppercase),
                          _buildRequirementItem('One lowercase letter', hasLowercase),
                          _buildRequirementItem('One number', hasDigit),
                          _buildRequirementItem('One special character', hasSpecialChar),
                        ],
                      ),
                  ],
                );
              }),
            ],
            SizedBox(height: 8.0.h),
            BuildFormField(
              name: "confirmPassword",
              placeholder: "Confirm password",
              obscureText: true,
              prefixIcon: const Icon(Icons.lock, color: Colors.black45),
              onChanged: (value) => context.read<AuthenticationCubit>().signUpConfirmPasswordChanged(value),
            ),
            // Confirm password match indicator
            if (showConfirmPasswordIndicator && !passwordsMatch) ...[
              SizedBox(height: 4.0.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                child: Row(
                  children: [
                    Icon(Icons.close, size: 14.sp, color: Colors.red),
                    SizedBox(width: 4.w),
                    Text(
                      'Passwords do not match',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 24.0.h),
            // OR divider — explicitly centered (the underlying asset image
            // can read off-centre if its intrinsic width doesn't match the
            // parent's full width).
            Center(
              child: UniversalImageLoader(imagePath: AppData.orDivider),
            ),
            SizedBox(height: 16.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialLoginButton(AppData.googleLogo),
                SizedBox(width: 10.w),
                _socialLoginButton(AppData.appleLogo),
              ],
            ),
            // More breathing room between the social row and the action
            // button below so the eye lands cleanly on the primary CTA.
            SizedBox(height: 36.0.h),
            // In-page Continue button — sits under the social icons so the
            // user finishes this page with a clear primary CTA. The sticky
            // bottom panel intentionally suppresses its own Continue on
            // this page (no duplicate). Pill-rounded edges (28.r) to match
            // the brand's softer button language.
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: isLoading ? null : _onContinuePressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _brandPurple,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: _brandPurple.withValues(alpha: 0.4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
                child: isLoading
                    ? LazerVaultLoader(size: 22)
                    : Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 12.0.h),
          ],
        );
      },
    );
  }

  // ── Brand palette ──────────────────────────────────────────────────────
  static const Color _brandPurple = Color(0xFF4834D4);
  static const Color _brandPurpleDeep = Color(0xFF2D2B6B);
  static const Color _brandOrange = Color(0xFFFB923C);

  // ── Password strength helpers (mirror reset-password page styling) ────
  String _passwordStrengthLabel({
    required bool hasMin,
    required bool hasUpper,
    required bool hasLower,
    required bool hasDigit,
    required bool hasSpecial,
  }) {
    final score = [hasMin, hasUpper, hasLower, hasDigit, hasSpecial]
        .where((e) => e)
        .length;
    if (score <= 2) return 'Weak';
    if (score == 3) return 'Fair';
    if (score == 4) return 'Good';
    return 'Strong';
  }

  Color _passwordStrengthColor({
    required bool hasMin,
    required bool hasUpper,
    required bool hasLower,
    required bool hasDigit,
    required bool hasSpecial,
  }) {
    final score = [hasMin, hasUpper, hasLower, hasDigit, hasSpecial]
        .where((e) => e)
        .length;
    if (score <= 2) return Colors.red;
    if (score == 3) return _brandOrange;
    if (score == 4) return Colors.lightGreen;
    return Colors.green;
  }

  double _passwordStrengthFraction(String label) {
    switch (label) {
      case 'Weak':
        return 0.25;
      case 'Fair':
        return 0.5;
      case 'Good':
        return 0.75;
      default:
        return 1.0;
    }
  }

  /// Chip-style requirement, same look as the reset-password page.
  Widget _buildRequirementItem(String text, bool satisfied) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          satisfied ? Icons.check_circle : Icons.circle_outlined,
          size: 14.w,
          color: satisfied ? Colors.green : Colors.grey.withValues(alpha: 0.5),
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 11.sp,
            color: satisfied
                ? Colors.black87
                : Colors.black54.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  // Helper method for Personal Info Page (Page 2). The phone field used to
  // live here but was extracted to a dedicated post-email-verify screen so
  // users can pick a phone number country independent of their registration
  // locale. `initialPhoneNumber` stays in the signature for compat with the
  // BlocBuilder destructure above — it isn't used here.
  Widget _buildPersonalInfoPage(BuildContext context, {String? initialFirstName, String? initialLastName, DateTime? selectedDate, String? initialPhoneNumber, required bool isLoading}) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final primaryContactType = state is SignUpInProgress ? state.primaryContactType : PrimaryContactType.none;
        final email = state is SignUpInProgress ? state.email : '';

        // Page 2 spacing model: ~16.h between visually-distinct fields,
        // smaller 6.h gap between a field and its inline helper text, then
        // a slightly larger 22.h before a new "section" (e.g. DOB after the
        // identity fields, then contact). Section sub-headers split the
        // form into Identity / Contact so the page doesn't feel like a wall.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Identity section ─────────────────────────────────────
            BuildFormField(
              name: "firstname",
              placeholder: "First Name",
              prefixIcon: const Icon(Icons.person_outline, color: Colors.black45),
              initialValue: initialFirstName,
              onChanged: (value) => context.read<AuthenticationCubit>().signUpFirstNameChanged(value),
            ),
            SizedBox(height: 10.0.h),
            BuildFormField(
              name: "lastname",
              placeholder: "Last Name",
              prefixIcon: const Icon(Icons.person_outline, color: Colors.black45),
              initialValue: initialLastName,
              onChanged: (value) => context.read<AuthenticationCubit>().signUpLastNameChanged(value),
            ),
            SizedBox(height: 10.0.h),
            // Username / LazerTag field
            BuildFormField(
              name: "username",
              placeholder: "Username / LazerTag (optional)",
              prefixIcon: const Icon(Icons.alternate_email, color: Colors.black45),
              maxLength: 30,
              autocorrect: false,
              enableSuggestions: false,
              onChanged: (value) => context.read<AuthenticationCubit>().signUpUsernameChanged(value),
              validator: (value) {
                if (value != null && value.trim().isNotEmpty) {
                  final clean = value.trim().replaceAll(RegExp(r'^@'), '');
                  if (clean.length < 3) {
                    return 'Username must be at least 3 characters';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(clean)) {
                    return 'Only letters, numbers, and underscores';
                  }
                }
                return null;
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0.w, top: 6.0.h),
              child: Text(
                'If left blank we generate one for you from your name.',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            SizedBox(height: 10.0.h),
            // Referral code field with on-blur validation
            Focus(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  context.read<AuthenticationCubit>().validateReferralCodeOnBlur();
                }
              },
              child: Builder(
                builder: (context) {
                  final s = context.read<AuthenticationCubit>().state;
                  final isValidating = s is SignUpInProgress && s.isReferralCodeValidating;
                  final isValid = s is SignUpInProgress ? s.isReferralCodeValid : null;
                  final hasCode = s is SignUpInProgress && s.referralCode.trim().isNotEmpty;

                  Widget? suffixIcon;
                  if (isValidating) {
                    suffixIcon = LazerVaultLoader.small();
                  } else if (hasCode && isValid == true) {
                    suffixIcon = const Icon(Icons.check_circle, color: Color(0xFF10B981));
                  } else if (hasCode && isValid == false) {
                    suffixIcon = const Icon(Icons.cancel, color: Color(0xFFEF4444));
                  }

                  return BuildFormField(
                    name: "referralCode",
                    placeholder: "Referral Code (optional)",
                    prefixIcon: const Icon(Icons.card_giftcard, color: Colors.black45),
                    suffixIcon: suffixIcon,
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (value) => context.read<AuthenticationCubit>().signUpReferralCodeChanged(value.toUpperCase()),
                  );
                },
              ),
            ),
            if (state is SignUpInProgress &&
                (state as SignUpInProgress).referralCode.trim().isNotEmpty &&
                (state as SignUpInProgress).isReferralCodeValid != null)
              Padding(
                padding: EdgeInsets.only(left: 16.0.w, top: 6.0.h),
                child: Text(
                  (state as SignUpInProgress).isReferralCodeValid!
                      ? 'Valid referral code!'
                      : 'Invalid referral code',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: (state as SignUpInProgress).isReferralCodeValid!
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                  ),
                ),
              ),
            SizedBox(height: 12.0.h),

            // ── Date of birth + contact section ─────────────────────
            // DOB field
            GestureDetector(
              onTap: _showDatePicker,
              child: AbsorbPointer(
                child: BuildFormField(
                  name: "dob",
                  initialValue: selectedDate == null
                      ? null
                      : DateFormat('dd MMM yyyy').format(selectedDate),
                  placeholder: "Select Date of Birth",
                  prefixIcon:
                      const Icon(Icons.calendar_today, color: Colors.black45),
                  readOnly: true,
                ),
              ),
            ),
            SizedBox(height: 14.0.h),

            // Secondary contact: when the user gave their PHONE on page 1, we
            // still ask for an optional email here (used for password reset
            // delivery + account recovery).
            if (primaryContactType == PrimaryContactType.phone) ...[
              BuildFormField(
                name: "email",
                placeholder: "Email (Optional)",
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email, color: Colors.black45),
                initialValue: email,
                onChanged: (value) => context.read<AuthenticationCubit>().signUpEmailChanged(value),
              ),
              SizedBox(height: 14.0.h),
            ],

            // ── Phone number ──────────────────────────────────────────
            // Country chip + national number + SIM-hint CTA. Tapping
            // the chip opens a bottomsheet picker. Tapping "Use phone
            // from this device" surfaces the Google-account number
            // picker on Android (silent no-op on iOS / unavailable
            // platforms). Length is validated per selected country at
            // submit time; leading "0" trunk is stripped automatically.
            _buildPhoneSection(context),
            SizedBox(height: 16.0.h),
            // Continue button moved to the sticky themed bottom panel.
          ],
        );
      },
    );
  }

  Widget _buildPhoneSection(BuildContext context) {
    // Visual contract matches BuildFormField — same #F0F0F0 fill, same
    // 24.r corner radius, no border, identical hint typography. Country
    // chip + phone input live on one IntrinsicHeight row so their
    // heights are always identical (no fixed magic numbers to drift).
    const fillColor = Color(0xFFF0F0F0);
    final radius = BorderRadius.circular(24.0.r);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Country chip — auto-sized to content, vertically
              // stretched to match the TextField next to it. Plain
              // Container so the fill matches BuildFormField exactly
              // (no Material 3 surface-tint overlay that was tinting
              // this slightly darker than the input beside it).
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _openPhoneCountryPicker,
                child: Container(
                  decoration: BoxDecoration(
                    color: fillColor,
                    borderRadius: radius,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _phoneCountry.flag,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _phoneCountry.dialCode,
                        style: GoogleFonts.inter(
                          color: Colors.black87,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down,
                          size: 20.sp, color: Colors.black54),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              // National-number field. Same fill + radius + hint as
              // BuildFormField so it reads as part of the same form.
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  // Hard cap on raw input: country max NSN length + 1
                  // (for the optional leading "0"). Combined with the
                  // digits-only filter this stops users from typing
                  // past the valid length for their selected country.
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(_maxPhoneInputLength),
                  ],
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.sp,
                  ),
                  onChanged: (_) {
                    setState(() {
                      _phoneError = _validatePhoneNsn();
                    });
                    context
                        .read<AuthenticationCubit>()
                        .signUpPhoneNumberChanged(_buildE164Phone());
                  },
                  decoration: InputDecoration(
                    hintText: 'Phone number',
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey.shade600,
                    ),
                    filled: true,
                    fillColor: fillColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.0.w,
                      vertical: 12.0.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: radius,
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: radius,
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: radius,
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Inline phone-validation feedback. Surfaces "should be N digits"
        // type messages from _validatePhoneNsn the moment the input goes
        // out of range, so the user fixes it before tapping Continue.
        if (_phoneError != null) ...[
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Text(
              _phoneError!,
              style: TextStyle(
                color: const Color(0xFFEF4444),
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        // SIM-hint CTA — explicit "Use phone from this device" button.
        // Auto-fires once on first focus too; this button lets the user
        // re-trigger if they declined initially or want to swap.
        if (Platform.isAndroid) ...[
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => _requestSimHint(silent: false),
              style: TextButton.styleFrom(
                foregroundColor: _brandPurple,
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: Icon(Icons.sim_card_outlined, size: 16.sp),
              label: Text(
                'Use phone from this device',
                style: TextStyle(
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ── Phone country picker bottomsheet ────────────────────────────────
  // Inline widget so phone capture on signup page 2 doesn't need to
  // import the (now-deleted) AddPhoneNumber screen. Lists every entry
  // from CountryLocales.all with a flag, name, and dial code.

  Widget _socialLoginButton(String imagePath) {
    return InkWell(
      onTap: () {
        print("Social login tapped for: $imagePath");
        Get.snackbar(
          'Social Login',
          'Social login not yet implemented.',
          snackPosition: SnackPosition.TOP,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          border: Border.all(color: Colors.black, width: 1.2),
        ),
        child: UniversalImageLoader(
          imagePath: imagePath,
          height: 24.0.h,
          width: 24.0.w,
        ),
      ),
    );
  }
}

/// Country picker bottomsheet for the phone field on signup page 2.
/// Lists every entry from `CountryLocales.all` with flag + name + dial
/// code, with a search box at the top. The previously-selected country
/// is highlighted. Selecting closes the sheet via `onSelect`.
class _PhoneCountryPickerSheet extends StatefulWidget {
  final String selectedCode;
  final void Function(CountryLocale) onSelect;

  const _PhoneCountryPickerSheet({
    required this.selectedCode,
    required this.onSelect,
  });

  @override
  State<_PhoneCountryPickerSheet> createState() => _PhoneCountryPickerSheetState();
}

class _PhoneCountryPickerSheetState extends State<_PhoneCountryPickerSheet> {
  static const Color _brandPurple = Color(0xFF4834D4);
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final all = CountryLocales.all;
    final filtered = _query.isEmpty
        ? all
        : all.where((c) {
            final q = _query.toLowerCase();
            return c.countryName.toLowerCase().contains(q) ||
                c.dialCode.contains(q) ||
                c.countryCode.toLowerCase().contains(q);
          }).toList();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Drag-handle
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: TextField(
                autofocus: false,
                style: const TextStyle(color: Colors.white),
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: 'Search country or dial code',
                  hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5)),
                  prefixIcon: Icon(Icons.search,
                      color: Colors.white.withValues(alpha: 0.5)),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.06),
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final c = filtered[i];
                  final isSelected = c.countryCode == widget.selectedCode;
                  return InkWell(
                    onTap: () => widget.onSelect(c),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 12.h),
                      child: Row(
                        children: [
                          Text(c.flag, style: TextStyle(fontSize: 22.sp)),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              c.countryName,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            c.dialCode,
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          if (isSelected)
                            Icon(Icons.check, color: _brandPurple, size: 18.sp),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
