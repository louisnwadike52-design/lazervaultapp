import 'dart:async';

import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/network/network_timeouts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/src/features/authentication/domain/entities/phone_change_request_result.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:lazervault/src/features/authentication/domain/sms_policy.dart';
import 'package:lazervault/src/features/widgets/locked_country_phone_input.dart';
import 'package:lazervault/src/features/widgets/resend_code_button.dart';
import 'package:lazervault/src/features/widgets/verification_code_input.dart';
import 'package:lazervault/src/features/widgets/verification_decorations.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';
import 'package:lazervault/core/widgets/otp_expiry_countdown.dart';

/// Change the signed-in user's phone number to a brand-new one.
///
/// Two steps: (1) enter the new number → an SMS OTP is sent to it; (2) enter
/// the OTP → the change is applied server-side (auth-service
/// RequestPhoneChange / VerifyPhoneChange). The number is only updated after
/// verification, and the backend rejects a number already in use.
///
/// ENTIRELY SMS-DEPENDENT, so it is gated on [SmsPolicy.canChangePhoneNumber].
/// The gate is HERE rather than at the four call sites that open this screen
/// (kyc_profile_fix, kyc_update_details, edit_profile_dialog and my_account) —
/// gating each of those would leave the next one added unguarded, which is how
/// a check comes to cover eight of nine paths.
///
/// # WHAT THIS REPLACES, AND WHY EACH PIECE CHANGED
///
/// The previous version was a bare dark-grey form that shared nothing with the
/// rest of the product:
///
///   * **A free-text phone field with no country.** It sent whatever was typed
///     and NO country code. `canonicalizeE164` on the server only normalises
///     when it is given a country it knows, so with an empty one it returned
///     the string untouched and `isValidE164` then refused anything without a
///     leading "+". Typing `08031234567` — the way a Nigerian number is
///     written everywhere else — failed with "invalid phone number format",
///     and nothing on screen suggested the "+234" form was required. It now
///     uses [LockedCountryPhoneInput], which already limits length to the
///     country's `nationalNumberLength` (+1 so the trunk "0" can be typed),
///     strips that "0", and validates the mobile prefix. The country goes to
///     the server, so with-or-without the 0 and with-or-without the dial code
///     all canonicalise.
///   * **A plain 6-box TextField.** Now [VerificationCodeInput], so paste and
///     SMS autofill work and the sixth digit submits — the same behaviour as
///     every other OTP screen in the app.
///   * **No resend and no countdown.** The RPC has always returned
///     `expires_in` and `resend_after_seconds`; the repository discarded both.
///     A customer whose code did not arrive had one option: leave.
///   * **The wrong theme.** Dark `#0A0A0A` panels and a `#3B82F6` blue, in a
///     product whose verification screens are white with the `#4834D4` brand.
class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({super.key});

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

enum _Step { enterPhone, enterOtp }

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {
  static const _brand = Color(0xFF4834D4);
  static const _ink = Color(0xFF1F2937);
  static const _muted = Color(0xFF6B7280);
  static const _danger = Color(0xFFDC2626);

  final _auth = serviceLocator<IAuthRepository>();

  _Step _step = _Step.enterPhone;
  bool _busy = false;

  String _countryCode = 'NG';
  String _e164Phone = '';
  String _submittedPhone = '';
  int _resendSeconds = 0;

  /// THE CODE'S OWN LIFETIME, as the server reported minting it.
  ///
  /// PhoneChangeRequestResult has carried `expiresInSeconds` since the
  /// repository stopped discarding it, and this screen still showed only the
  /// resend cooldown — so the header note above, which names "no resend and no
  /// countdown" as the defect, was only half true afterwards. Zero means the
  /// server named no window, and nothing is drawn.
  int _codeExpirySeconds = 0;

  /// Inline, beside the field that caused it. A snackbar for a validation
  /// failure disappears while the user is still reading the field it refers
  /// to; this stays until they fix it.
  String? _error;

  /// Forces a fresh [VerificationCodeInput] after a resend or a rejected code,
  /// so the boxes clear instead of holding digits the server already refused.
  int _codeResetKey = 0;

  @override
  Widget build(BuildContext context) {
    // Back on the OTP step returns to the number, it does not leave.
    //
    // A customer who mistypes one digit of their number has to be able to go
    // back and fix it. With a plain pop they lost the whole flow and had to
    // find it again in Settings — and the pending code stayed live, so the
    // next attempt collided with the 60s cooldown for a number they had
    // already abandoned.
    return PopScope(
      canPop: _step == _Step.enterPhone,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _step == _Step.enterOtp) _backToPhoneStep();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: IconButton(
                        onPressed: _busy
                            ? null
                            : () => _step == _Step.enterOtp
                                ? _backToPhoneStep()
                                : Get.back(),
                        icon: const Icon(Icons.arrow_back, color: _ink),
                        tooltip: 'Back',
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  const VerificationBadgeIcon(
                      icon: Icons.phone_android_rounded),
                  SizedBox(height: 24.h),
                  if (_step == _Step.enterPhone)
                    ..._phoneStep()
                  else
                    ..._otpStep(),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- step 1

  List<Widget> _phoneStep() {
    final canSend = SmsPolicy.canChangePhoneNumber;
    return [
      Text(
        'Change your number',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: _ink,
        ),
      ),
      SizedBox(height: 8.h),
      Text(
        canSend
            ? "We'll text a 6-digit code to the new number to confirm it's yours."
            : SmsPolicy.unavailableReason,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 15.sp,
          height: 1.5,
          color: canSend ? _muted : const Color(0xFFB45309),
        ),
      ),
      SizedBox(height: 32.h),
      LockedCountryPhoneInput(
        // Re-key on country so the field re-reads nationalNumberLength and
        // re-applies its length limit when the country changes.
        key: ValueKey(_countryCode),
        countryCode: _countryCode,
        labelText: 'New phone number',
        enabled: canSend && !_busy,
        onCountryTap: (canSend && !_busy) ? _openCountryPicker : null,
        onChanged: (e164) {
          _e164Phone = e164;
          if (_error != null) setState(() => _error = null);
        },
      ),
      if (_error != null) ...[
        SizedBox(height: 12.h),
        _errorBanner(_error!),
      ],
      SizedBox(height: 24.h),
      _primaryButton(
        _busy ? 'Sending…' : 'Send code',
        (_busy || !canSend) ? null : _requestChange,
      ),
    ];
  }

  void _openCountryPicker() {
    final available = CountryConfigs.activeCountries
        .where((c) => c.isAvailableForSignup)
        .toList();
    showAppBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select country',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
              ),
            ),
            ...available.map((c) {
              final selected = c.code == _countryCode;
              return ListTile(
                leading: Text(c.flag, style: TextStyle(fontSize: 22.sp)),
                title: Text(c.name,
                    style: GoogleFonts.inter(fontSize: 15.sp, color: _ink)),
                trailing: Text(
                  c.dialingCode,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: selected ? _brand : _muted,
                  ),
                ),
                selected: selected,
                onTap: () {
                  setState(() {
                    _countryCode = c.code;
                    _e164Phone = '';
                    _error = null;
                  });
                  Navigator.of(sheetCtx).pop();
                },
              );
            }),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- step 2

  List<Widget> _otpStep() {
    return [
      Text(
        'Verify your new number',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: _ink,
        ),
      ),
      SizedBox(height: 8.h),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            height: 1.5,
            color: _muted,
          ),
          children: [
            const TextSpan(text: 'Enter the 6-digit code sent to\n'),
            TextSpan(
              text: _submittedPhone,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: _ink,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 32.h),
      VerificationCodeInput(
        key: ValueKey('change-phone-code-$_codeResetKey'),
        // THE SIXTH DIGIT SUBMITS. A customer who has typed six digits has
        // already said what they came to say; a separate confirm tap is a
        // step with nothing in it, and every other OTP screen here submits.
        onCompleted: (code) {
          if (!_busy) _verifyChange(code);
        },
        onChanged: (_) {
          if (_error != null) setState(() => _error = null);
        },
      ),
      if (_error != null) ...[
        SizedBox(height: 16.h),
        _errorBanner(_error!),
      ],
      SizedBox(height: 20.h),
      // THE CODE'S OWN CLOCK, which is not the resend cooldown below it. Keyed
      // on the same per-send counter the boxes use, so a resend restarts it
      // even when the new window is the same number as the old one.
      Center(
        child: OtpExpiryCountdown(
          key: ValueKey('change-phone-expiry-$_codeResetKey'),
          seconds: _codeExpirySeconds,
          color: _muted,
        ),
      ),
      SizedBox(height: 16.h),
      ResendCodeButton(
        // Seeded from the SERVER's resend_after_seconds, so the button offers
        // a resend exactly when the server will accept one.
        initialSeconds: _resendSeconds,
        prompt: "Didn't get the code?",
        showSmsDndHelp: true,
        onResend: _resendCode,
      ),
      SizedBox(height: 8.h),
      TextButton(
        onPressed: _busy ? null : _backToPhoneStep,
        child: Text(
          'Use a different number',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: _brand,
          ),
        ),
      ),
    ];
  }

  // ------------------------------------------------------------- behaviour

  void _backToPhoneStep() {
    setState(() {
      _step = _Step.enterPhone;
      _error = null;
      _codeResetKey++;
    });
  }

  /// Validates locally before spending a round trip AND an SMS.
  ///
  /// The server would refuse these too, but it answers in its own words after
  /// a network hop, and one of those words used to be "invalid phone number
  /// format: must be E.164" — which tells a customer nothing they can act on.
  String? _localPhoneProblem() {
    if (_e164Phone.trim().isEmpty) return 'Enter your new phone number.';
    final country = CountryConfigs.getByCode(_countryCode);
    if (country == null) return null;
    final dial = country.dialingCode.replaceAll('+', '');
    var nsn = _e164Phone.replaceAll(RegExp(r'[^\d]'), '');
    if (nsn.startsWith(dial)) nsn = nsn.substring(dial.length);
    return country.validateNationalNumber(nsn);
  }

  Future<void> _requestChange() async {
    // THE CHOKE POINT. Every entry point lands here, so one check covers them
    // all. Without it the request is made, the backend queues an OTP to a
    // provider that cannot send it, and the user sits on step 2 entering codes
    // that were never generated.
    if (!SmsPolicy.canChangePhoneNumber) {
      setState(() => _error = SmsPolicy.unavailableReason);
      return;
    }
    final problem = _localPhoneProblem();
    if (problem != null) {
      setState(() => _error = problem);
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    // BOUNDED, OR "Sending…" NEVER COMES BACK.
    //
    // `_busy` disables the button, the country picker and the back control,
    // and it is cleared only after this await returns — so a request that
    // never answers left a live screen with every control dead and the button
    // reading "Sending…" forever. That is the same unresponsive-screen report
    // the KYC detail editors were fixed for on 2026-11-24, and this screen is
    // reachable from the same place (openKycProfileFix routes a phone refusal
    // straight here).
    //
    // `interactive` is the app's single answer for "they tapped something and
    // are watching"; a second number here would drift from it.
    final Either<Failure, PhoneChangeRequestResult> res;
    try {
      res = await _auth
          .requestPhoneChange(
            newPhone: _e164Phone,
            countryCode: _countryCode,
          )
          .timeout(NetworkTimeouts.interactive);
    } on TimeoutException {
      if (!mounted) return;
      // NOT WORDED AS A REFUSAL, and the step is NOT advanced: a code may have
      // been sent, but sending them to the OTP step on a guess is how a
      // customer types into a screen that will reject everything.
      setState(() {
        _busy = false;
        _error = 'Your network is slow, so we could not confirm the code was '
            'sent. Check your connection and try again.';
      });
      return;
    }
    if (!mounted) return;
    setState(() => _busy = false);

    res.fold(
      (f) => setState(() => _error = f.message),
      (ok) {
        setState(() {
          _submittedPhone = _e164Phone;
          _step = _Step.enterOtp;
          _resendSeconds = ok.resendAfterSeconds;
          _codeExpirySeconds = ok.expiresInSeconds;
          _codeResetKey++;
        });
      },
    );
  }

  /// Returns the new cooldown for [ResendCodeButton], or null if it should
  /// keep the one it has.
  Future<int?> _resendCode() async {
    if (!SmsPolicy.canChangePhoneNumber) {
      setState(() => _error = SmsPolicy.unavailableReason);
      return null;
    }
    // Bounded like the other two. This one has no `_busy` of its own — the
    // ResendCodeButton owns its countdown — so an unbounded hang simply never
    // answers and the button stays mid-press with nothing said.
    final Either<Failure, PhoneChangeRequestResult> res;
    try {
      res = await _auth
          .requestPhoneChange(
            newPhone: _submittedPhone,
            countryCode: _countryCode,
          )
          .timeout(NetworkTimeouts.interactive);
    } on TimeoutException {
      if (!mounted) return null;
      setState(() => _error = 'Your network is slow, so we could not confirm '
          'the new code was sent. Check your connection and try again.');
      // Null keeps the cooldown the button already has, so a timeout cannot
      // hand the customer an unlimited resend.
      return null;
    }
    if (!mounted) return null;
    return res.fold(
      (f) {
        setState(() => _error = f.message);
        return null;
      },
      (ok) {
        // A NEW code invalidates the previous one server-side, so the boxes
        // are cleared: leaving the old digits visible invites the customer to
        // submit a code that is already dead.
        setState(() {
          _error = null;
          _codeResetKey++;
          _resendSeconds = ok.resendAfterSeconds;
          _codeExpirySeconds = ok.expiresInSeconds;
        });
        showAppSnackbar('Code sent', ok.message, type: AppSnackbarType.success);
        return ok.resendAfterSeconds;
      },
    );
  }

  Future<void> _verifyChange(String code) async {
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    final Either<Failure, String> res;
    try {
      res = await _auth
          .verifyPhoneChange(
            newPhone: _submittedPhone,
            code: code,
            countryCode: _countryCode,
          )
          .timeout(NetworkTimeouts.interactive);
    } on TimeoutException {
      if (!mounted) return;
      // THE BOXES ARE NOT CLEARED HERE, unlike a rejection. The code may still
      // be valid — it is the answer that did not arrive — so wiping it would
      // make the customer retype a number that was right, against a code that
      // expires.
      setState(() {
        _busy = false;
        _error = 'Your network is slow, so we could not confirm that code. '
            'Check your connection and try again.';
      });
      return;
    }
    if (!mounted) return;
    setState(() => _busy = false);

    res.fold(
      (f) => setState(() {
        _error = f.message;
        // Clear the boxes so the next attempt starts from empty. A full field
        // swallows keystrokes and paints no caret, which reads as a dead
        // screen rather than a rejected code.
        _codeResetKey++;
      }),
      (phone) {
        showAppSnackbar('Phone updated', 'Your number is now $phone',
            type: AppSnackbarType.success);
        // The callers (kyc_profile_fix, kyc_update_details,
        // edit_profile_dialog, my_account) all await this result and refresh
        // from it, so the applied number is what goes back — not the one that
        // was typed.
        Get.back(result: phone);
      },
    );
  }

  // ------------------------------------------------------------------ chrome

  Widget _errorBanner(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, size: 18.sp, color: _danger),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                height: 1.4,
                color: const Color(0xFF991B1B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _primaryButton(String label, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _brand,
          disabledBackgroundColor: const Color(0xFFD1D5DB),
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
