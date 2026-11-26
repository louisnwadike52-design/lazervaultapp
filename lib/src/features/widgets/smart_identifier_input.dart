import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';

/// A single login-identifier field that AUTO-DETECTS whether the user is
/// entering a PHONE number, an EMAIL, or a USERNAME and adapts inline:
///  • phone    → shows a tappable country pill (flag + dial code), builds E.164
///  • email    → swaps the pill for an "@" glyph, passes the lowercased email
///  • username → shows a person glyph, passes the normalized handle
/// A small live badge tells the user which was detected. The resolved
/// identifier (E.164 phone, lowercased email, or normalized username) and its
/// [LoginIdentifierType] are emitted via [onChanged]; the parent validates on
/// submit and the backend resolves the same three shapes. Detection precedence
/// (see [detectLoginIdentifierType]): starts-with-'@' ⇒ username; a mid-string
/// '@' ⇒ email; any letter ⇒ username; pure digits ⇒ phone. So a pure-digit
/// entry stays phone, a leading '@' is a handle, and typing '@' after some
/// letters flips a username into an email.
class SmartIdentifierInput extends StatefulWidget {
  final String countryCode;

  /// National number to prefill (e.g. from the device SIM hint). Setting this
  /// puts the field in phone mode with the number filled.
  final String? initialPhoneNational;

  /// Tapped on the country pill (phone mode only) — parent shows the picker.
  final VoidCallback? onCountryTap;

  /// Emits the resolved identifier (E.164 phone, lowercased email, or
  /// normalized username) and its detected [LoginIdentifierType], on change.
  final void Function(String identifier, LoginIdentifierType type) onChanged;

  final void Function(String value)? onSubmitted;

  /// External validation error (shown under the field).
  final String? errorText;

  /// Whether a USERNAME is an acceptable answer here.
  ///
  /// Login says yes. Passcode RESET says no: a code cannot be delivered to a
  /// handle, so a username-shaped entry is treated as an email being typed
  /// (the signup behaviour) rather than detected as a third kind the flow
  /// cannot honour.
  final bool allowUsername;

  /// Show a NUMBER KEYPAD whenever the field is in phone mode.
  ///
  /// OPT-IN, and it has to be. This widget's whole point elsewhere is a single
  /// box that takes a phone, an email or a handle — and on an empty field
  /// [_type] falls back to [emptyStateType], which is `phone`. Binding the
  /// keyboard to that unconditionally would open the LOGIN screen on a numeric
  /// keypad with no letters on it, so somebody signing in with an email could
  /// not type the first character.
  ///
  /// Pass true only where the surface has already committed to a channel and
  /// offers another way to change it — the passcode-reset screen has
  /// "Use my phone / Use my email" chips above the field, and those rebuild it
  /// (a bumped key), which is what makes the keyboard actually swap rather
  /// than keep the connection it was focused with.
  final bool phoneKeypadOnly;

  /// Show the value but refuse edits.
  ///
  /// For RECOVERY, where the account is already known from this device and
  /// retyping it is only an opportunity to typo into somebody else's. The
  /// surface must still offer a way out — see the note on
  /// forgot_passcode_phone_screen's "Not you?": a field locked with NO escape
  /// strands anyone whose device carries a different person's identity, or
  /// none at all, and recovery is the last path they have.
  ///
  /// Read-only rather than disabled: a disabled field greys its own text, so
  /// the number the user is being asked to confirm becomes the hardest thing
  /// on screen to read.
  final bool readOnly;

  /// How to present the field while it is EMPTY — the parent's channel
  /// selector. Detection takes over the moment anything is typed, so the two
  /// never disagree about a value the user can see.
  final LoginIdentifierType? emptyStateType;

  /// Overrides the placeholder. Defaults to the detected-types list.
  final String? hintText;

  const SmartIdentifierInput({
    super.key,
    required this.countryCode,
    required this.onChanged,
    this.initialPhoneNational,
    this.onCountryTap,
    this.onSubmitted,
    this.errorText,
    this.allowUsername = true,
    this.phoneKeypadOnly = false,
    this.readOnly = false,
    this.emptyStateType,
    this.hintText,
  });

  @override
  State<SmartIdentifierInput> createState() => _SmartIdentifierInputState();
}

class _SmartIdentifierInputState extends State<SmartIdentifierInput> {
  late final TextEditingController _controller;
  late CountryConfig _country;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: widget.initialPhoneNational ?? '');
    _country =
        CountryConfigs.getByCode(widget.countryCode) ?? CountryConfigs.nigeria;
    // Emit the initial resolved value so the parent starts in sync.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _emit();
    });
  }

  @override
  void didUpdateWidget(covariant SmartIdentifierInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countryCode != widget.countryCode) {
      _country = CountryConfigs.getByCode(widget.countryCode) ?? _country;
      _emit();
    }
    // The parent flipped the empty-state presentation (its channel selector).
    // Re-emit so its notion of the detected type matches what is on screen
    // even before a single character is typed.
    if (oldWidget.emptyStateType != widget.emptyStateType && _raw.isEmpty) {
      _emit();
    }
    // A device-SIM hint fill replaces the national number + re-emits.
    final hint = widget.initialPhoneNational ?? '';
    if (oldWidget.initialPhoneNational != widget.initialPhoneNational &&
        hint.isNotEmpty &&
        hint != _controller.text) {
      _controller.text = hint;
      _emit();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Caps phone input at the active country's national-number length while a
  /// phone is being typed (never for email). Rejects the keystroke/paste that
  /// would exceed the limit so the field simply stops accepting more digits.
  late final TextInputFormatter _lengthLimiter =
      _SmartPhoneLengthLimiter(maxDigitsFor: _maxPhoneDigits);

  String get _raw => _controller.text.trim();

  /// The live-detected type of what's currently typed.
  LoginIdentifierType get _type {
    final raw = _raw;
    if (raw.isEmpty && widget.emptyStateType != null) {
      return widget.emptyStateType!;
    }
    final detected = detectLoginIdentifierType(raw);
    if (!widget.allowUsername &&
        detected == LoginIdentifierType.username) {
      // Letters with no '@' YET. On a username-less field that is an email
      // mid-typing, so the leading glyph and the badge both say Email and
      // nothing flickers through a third state on the way there.
      return LoginIdentifierType.email;
    }
    return detected;
  }

  /// Phone is the only type that keeps the country pill, the length cap and the
  /// SIM shortcut; email + username share the "non-phone" text presentation.
  bool get _isPhone => _type == LoginIdentifierType.phone;

  /// Whether THIS field should present a number keypad right now: the caller
  /// asked for it AND the field is currently in phone mode. Flipping the
  /// channel chip flips this back, so the email branch keeps its letters.
  bool get _numericKeypad => widget.phoneKeypadOnly && _isPhone;

  /// Max digits allowed for the current country, honouring an optional leading
  /// trunk '0' and a pasted dialing code so both "8012345678" and
  /// "08012345678" (and "2348012345678") are accepted but nothing longer.
  int _maxPhoneDigits(String digits) {
    final nat = _country.nationalNumberLength;
    final dial = _country.dialingCode.replaceAll('+', '');
    var body = digits;
    var prefix = 0;
    if (dial.isNotEmpty && body.startsWith(dial)) {
      body = body.substring(dial.length);
      prefix = dial.length;
    }
    final withLeadingZero = body.startsWith('0');
    return prefix + (withLeadingZero ? nat + 1 : nat);
  }

  /// Builds an E.164 phone from the typed national number + selected country,
  /// tolerating a pasted dialing code and a single leading trunk '0'.
  String _toE164(String raw) {
    var digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return '';
    final dial = _country.dialingCode.replaceAll('+', '');
    if (digits.startsWith(dial)) digits = digits.substring(dial.length);
    if (digits.startsWith('0')) digits = digits.substring(1);
    if (digits.isEmpty) return '';
    return '+$dial$digits';
  }

  /// The resolved identifier to hand upward: E.164 for phone, lowercased email,
  /// or a normalized (@-stripped, lowercased) username.
  String get _identifier {
    switch (_type) {
      case LoginIdentifierType.phone:
        return _toE164(_raw);
      case LoginIdentifierType.email:
        return _raw.toLowerCase();
      case LoginIdentifierType.username:
        return normalizeUsernameIdentifier(_raw);
    }
  }

  /// Label for the live "what did we detect" badge.
  String get _detectedLabel {
    switch (_type) {
      case LoginIdentifierType.phone:
        return 'Phone';
      case LoginIdentifierType.email:
        return 'Email';
      case LoginIdentifierType.username:
        return 'Username';
    }
  }

  IconData get _typeIcon {
    switch (_type) {
      case LoginIdentifierType.phone:
        return Icons.smartphone;
      case LoginIdentifierType.email:
        return Icons.alternate_email;
      case LoginIdentifierType.username:
        return Icons.alternate_email;
    }
  }

  void _emit() => widget.onChanged(_identifier, _type);

  @override
  Widget build(BuildContext context) {
    final isPhone = _isPhone;
    final hasError = widget.errorText != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(24.r),
            border:
                hasError ? Border.all(color: const Color(0xFFEF4444)) : null,
          ),
          child: Row(children: [
            // Leading morphs its CONTENT with the detected type (country pill
            // for phone, an '@' glyph for email) but keeps a STABLE widget type
            // (GestureDetector > Padding). Swapping the widget type here — while
            // the trailing badge also appears on the first letter — made the
            // non-keyed Row drop the middle TextField's element, closing the
            // keyboard. Stable type + a keyed field below keeps focus.
            GestureDetector(
              onTap: isPhone ? widget.onCountryTap : null,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: isPhone
                    ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h)
                    : EdgeInsets.only(left: 16.w, right: 4.w),
                child: isPhone
                    ? Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(_country.flag, style: TextStyle(fontSize: 18.sp)),
                        SizedBox(width: 6.w),
                        Text(_country.dialingCode,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800)),
                        if (widget.onCountryTap != null)
                          Icon(Icons.arrow_drop_down,
                              size: 18.sp, color: Colors.grey.shade600),
                      ])
                    : Icon(_typeIcon,
                        size: 20.sp, color: const Color(0xFF4834D4)),
              ),
            ),
            Expanded(
              // Stable key so the input element (and its focus/keyboard) is
              // preserved across the phone⇄email rebuild.
              key: const ValueKey('smart-identifier-field'),
              child: TextField(
                controller: _controller,
                readOnly: widget.readOnly,
                // A combined identifier field needs both letters and digits —
                // UNLESS the caller has committed this one to a phone, in
                // which case a QWERTY keyboard just makes the user hunt for
                // the digits. TextInputType.phone is the dialpad, and the same
                // type every other phone field in the app uses.
                keyboardType: _numericKeypad
                    ? TextInputType.phone
                    : TextInputType.emailAddress,
                // Autofill follows the keyboard: offering "username" over a
                // dialpad suggests the wrong thing from the wrong store.
                autofillHints: _numericKeypad
                    ? const [AutofillHints.telephoneNumberNational]
                    : const [AutofillHints.username],
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  // Keep it to a single line; no spaces in a phone or email.
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  // Stop phone input once it reaches the country's length
                  // (email input is never capped).
                  _lengthLimiter,
                ],
                onChanged: (_) {
                  _emit();
                  setState(() {}); // repaint leading + detection indicator
                },
                onSubmitted: widget.onSubmitted,
                style:
                    TextStyle(fontSize: 15.sp, color: const Color(0xFF111827)),
                decoration: InputDecoration(
                  hintText: widget.hintText ??
                      (widget.allowUsername
                          ? 'Phone, email or username'
                          : 'Phone number or email'),
                  hintStyle:
                      TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
                  border: InputBorder.none,
                  isCollapsed: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                ),
              ),
            ),
            // Live "what did we detect" badge — sits at the RIGHT end of the
            // field once the user starts typing.
            if (_raw.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(left: 6.w, right: 14.w),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(_typeIcon, size: 13.sp, color: const Color(0xFF4834D4)),
                  SizedBox(width: 4.w),
                  Text(_detectedLabel,
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280))),
                ]),
              ),
          ]),
        ),
        if (hasError) ...[
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(widget.errorText!,
                style:
                    TextStyle(fontSize: 11.sp, color: const Color(0xFFEF4444))),
          ),
        ],
      ],
    );
  }
}

/// Rejects edits that would push a PHONE entry past the active country's
/// national-number length. Only applies while the value looks like a phone
/// (digits only) — the moment a letter or '@' appears it's an email and the
/// cap is lifted. [maxDigitsFor] receives the candidate digit string and
/// returns the max digits allowed for the current country.
class _SmartPhoneLengthLimiter extends TextInputFormatter {
  final int Function(String digits) maxDigitsFor;

  _SmartPhoneLengthLimiter({required this.maxDigitsFor});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;
    // Email (contains a letter or '@') — no length cap.
    if (text.contains('@') || RegExp(r'[a-zA-Z]').hasMatch(text)) {
      return newValue;
    }
    final digits = text.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.length > maxDigitsFor(digits)) {
      // Over the limit — keep the previous value so further input stops.
      return oldValue;
    }
    return newValue;
  }
}
