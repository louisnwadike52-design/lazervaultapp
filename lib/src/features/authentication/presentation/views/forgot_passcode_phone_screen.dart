import 'package:flutter/material.dart';
import 'package:lazervault/core/services/post_reset_handoff.dart';
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
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/src/features/widgets/verification_decorations.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

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
  /// The national number read from secure storage, kept apart from
  /// [_initialNsn] so switching to Email and back restores it instead of
  /// handing the user an empty field and the job of retyping their number.
  String? _prefilledNsn;

  /// The account this device remembers, per channel. Empty when the device
  /// has never signed anyone in — a fresh install, or storage cleared — in
  /// which case there is nothing to prefill and nothing to lock.
  String _prefilledEmail = '';

  /// The remembered phone in E.164, kept beside the national part so switching
  /// Email → Phone restores the identifier the cubit sends, not just the
  /// digits the field shows.
  String _prefilledPhoneE164 = '';

  /// LOCKED BY DEFAULT ONCE WE KNOW THE ACCOUNT, with a way out.
  ///
  /// The account is already registered and this device already knows which
  /// one, so retyping it is only an opportunity to typo into somebody else's
  /// and send THEM a code. Locking removes that.
  ///
  /// But a hard lock with no escape strands two real users: the person on a
  /// handset that remembers somebody ELSE (a shared or second-hand phone — the
  /// same case the passcode lock screen already has to handle), and anyone
  /// whose device remembers nothing. Recovery is the last path they have, so
  /// "Not you?" unlocks the field rather than leaving them stuck.
  bool _identityLocked = false;

  // Recover with the phone OR the email on the account — the same two shapes
  // signup accepts, and the only two a 6-digit code can be DELIVERED to.
  //
  // Username is deliberately gone. The field used to detect one, and the
  // backend then resolved it to the account's phone and texted the code there
  // — so a user who typed something that was not a phone still got "we cannot
  // send a code to your phone right now". A handle receives nothing; offering
  // it was offering a route that does not exist.
  //
  // The channel is a VISIBLE choice at the top of the screen as well as a
  // detection: the number is usually pre-filled, so without the selector there
  // was nothing on screen telling the user an email was even possible.
  String _identifier = '';
  LoginIdentifierType _identifierType = LoginIdentifierType.phone;
  String? _identifierError;
  ResetDeliveryChannel _channel = ResetDeliveryChannel.phone;
  // Rebuilds the smart field (fresh, empty) when the user switches channel.
  int _fieldKey = 0;

  bool get _isPhoneIdentifier => _channel == ResetDeliveryChannel.phone;

  void _onIdentifierChanged(String identifier, LoginIdentifierType type) {
    // DETECTION MOVES THE SELECTOR. Pasting an email into the phone mode is a
    // perfectly clear instruction; making the user also tap "Email" for it to
    // be honoured is the gap that produced an SMS attempt for an address.
    final detectedChannel = type == LoginIdentifierType.email
        ? ResetDeliveryChannel.email
        : ResetDeliveryChannel.phone;
    final needsRepaint = type != _identifierType ||
        detectedChannel != _channel ||
        _identifierError != null;
    _identifier = identifier;
    _identifierType = type;
    if (needsRepaint && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          _channel = detectedChannel;
          _identifierError = null;
        });
      });
    }
  }

  /// The user tapped a channel chip. Clear the field so the next thing typed
  /// cannot be read as the other kind — a half-typed phone left behind while
  /// the header says Email is how the two disagree.
  void _selectChannel(ResetDeliveryChannel channel) {
    if (channel == _channel) return;
    setState(() {
      _channel = channel;
      _identifier = '';
      _identifierType = channel == ResetDeliveryChannel.email
          ? LoginIdentifierType.email
          : LoginIdentifierType.phone;
      _identifierError = null;
      // EACH CHANNEL RESTORES ITS OWN PREFILL. Email used to start empty even
      // when this device knew the address perfectly well.
      _initialNsn =
          channel == ResetDeliveryChannel.phone ? _prefilledNsn : null;
      if (channel == ResetDeliveryChannel.email) {
        _identifier = _prefilledEmail;
      } else if (_prefilledNsn != null) {
        _identifier = _prefilledPhoneE164;
      }
      // Locked only while the field actually holds the remembered account.
      _identityLocked = _identifier.isNotEmpty;
      _fieldKey++;
    });
  }

  // OTP phase
  String _code = '';
  /// Masked destination the server reported sending to, for the OTP copy.
  String _sentToMasked = '';
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
    // EMAIL TOO, which it never read. The screen offers an Email chip and
    // then handed the user an empty box, so the one channel they could not
    // be prefilled on was the one they switched to deliberately.
    final storedEmail =
        (await _secureStorage.read(key: 'stored_email'))?.trim() ?? '';
    final stored = await _secureStorage.read(key: 'stored_phone');
    if (mounted && storedEmail.isNotEmpty) {
      setState(() {
        _prefilledEmail = storedEmail;
        _identityLocked = true;
      });
    }
    if (stored == null || stored.isEmpty || !mounted) return;
    // A prefilled number means the screen opens on the Phone channel, which is
    // the right default — but the Email chip beside it is what tells the user
    // the other route exists at all.
    _channel = ResetDeliveryChannel.phone;
    // Match the stored E.164 against a known dialing code to split country +
    // national number, so the field pre-fills correctly.
    // Shared with the login screen that follows a reset — see splitE164Phone.
    final split = splitE164Phone(stored);
    if (split != null) {
      setState(() {
        _countryCode = split.countryCode;
        _initialNsn = split.national;
        _prefilledNsn = _initialNsn;
        _identifier = stored;
        _prefilledPhoneE164 = stored;
        _identityLocked = true;
      });
      return;
    }
    setState(() => _identifier = stored);
  }

  // ── Phone phase ────────────────────────────────────────────────────────
  void _onSendCode() {
    if (_identifier.trim().isEmpty) {
      setState(() => _identifierError = _channel == ResetDeliveryChannel.email
          ? 'Enter the email address on your account.'
          : 'Enter your phone number to continue.');
      return;
    }
    // VALIDATE AGAINST THE CHOSEN CHANNEL, not the detected shape, so the two
    // can never disagree about what is being sent where.
    if (_channel == ResetDeliveryChannel.email) {
      if (!isEmailIdentifier(_identifier)) {
        setState(() => _identifierError = 'Enter a valid email address.');
        return;
      }
    } else {
      // Per-COUNTRY length/prefix rules, from the same CountryConfig the
      // signup screen validates against — not a generic "looks like digits".
      final country = CountryConfigs.getByCode(_countryCode);
      if (country == null) {
        setState(() => _identifierError = 'Choose your country, then re-enter '
            'your number.');
        return;
      }
      final dial = country.dialingCode.replaceAll('+', '');
      var nsn = _identifier.replaceAll(RegExp(r'[^\d]'), '');
      if (nsn.startsWith(dial)) nsn = nsn.substring(dial.length);
      final err = country.validateNationalNumber(nsn);
      if (err != null) {
        setState(() => _identifierError = err);
        return;
      }
    }
    // The identifier rides in `phone` (its wire name) and the CHANNEL rides
    // beside it, so the backend delivers where the user asked rather than
    // resolving everything down to a phone number.
    context.read<PasscodeResetCubit>().requestReset(
          phone: _identifier,
          countryCode: _countryCode,
          channel: _channel,
        );
  }

  void _openCountryPicker() {
    final available =
        CountryConfigs.activeCountries.where((c) => c.isAvailableForSignup);
    showAppBottomSheet<void>(
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
                      // A DIFFERENT country invalidates the stored national
                      // number; re-picking the same one keeps it.
                      _initialNsn = null;
                      _prefilledNsn = null;
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
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _onPasscodeComplete());
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
            // THE SERVER'S ANSWER, not the chip the user tapped. It is the
            // only party that knows which channel could actually deliver.
            _channel = state.channel;
            _sentToMasked = state.destinationMasked.isNotEmpty
                ? state.destinationMasked
                : state.phone;
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
          // HAND THE IDENTIFIER FORWARD. The user proved control of it seconds
          // ago; asking who they are again on the very next screen is the
          // complaint this closes. A PREFILL only — the passcode screen still
          // demands the passcode they just set, which is also what confirms
          // they remember it.
          //
          // Deliberately not an auto-login: that would mint a session from
          // possession of the OTP channel alone. See PostResetHandoff.
          PostResetHandoff.publish(
            _identifier,
            _channel == ResetDeliveryChannel.email
                ? LoginIdentifierType.email
                : LoginIdentifierType.phone,
          );
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
      // Names the ACTUAL destination. The old copy said "we'll text a 6-digit
      // code to the phone on your account" to everyone, including the user who
      // had just typed their email address into the field below it.
      subtitle: _isPhoneIdentifier
          ? 'We\'ll text a 6-digit code to your phone to confirm it\'s you.'
          : 'We\'ll email a 6-digit code to the address on your account to confirm it\'s you.',
      showHeadingLogo: false,
      primaryLabel: 'Send code',
      isLoading: isLoading,
      onPrimary: isLoading ? null : _onSendCode,
      children: [
        SizedBox(height: 10.h),
        _buildChannelSelector(isLoading),
        SizedBox(height: 14.h),
        // One smart field: auto-detects phone vs email and adapts inline. The
        // selector above and the detection here drive the same `_channel`.
        SmartIdentifierInput(
          key: ValueKey('$_fieldKey-$_countryCode-${_initialNsn ?? ''}'),
          countryCode: _countryCode,
          initialPhoneNational: _initialNsn,
          onCountryTap: _openCountryPicker,
          onChanged: _onIdentifierChanged,
          onSubmitted: (_) => isLoading ? null : _onSendCode(),
          errorText: _identifierError,
          // A code cannot reach a handle — see the note on _channel.
          allowUsername: false,
          // LOCKED TO THE ACCOUNT THIS DEVICE REMEMBERS. Unlocked by the
          // "Not you?" action below, which exists so a shared handset — or
          // one that remembers nobody — is not a dead end.
          readOnly: _identityLocked,
          // Phone mode gets the dialpad. Safe here, and only here, because
          // the chips above are the way to reach the email branch — the field
          // is not also the channel switcher on this screen. Selecting a chip
          // bumps _fieldKey, so the keyboard swaps with it.
          phoneKeypadOnly: true,
          emptyStateType: _channel == ResetDeliveryChannel.email
              ? LoginIdentifierType.email
              : LoginIdentifierType.phone,
          hintText: _channel == ResetDeliveryChannel.email
              ? 'Email address'
              : 'Phone number',
        ),
        _buildNotYouAction(),
      ],
    );
  }

  /// "Not you? Use a different account" — the way out of the locked field.
  ///
  /// WITHOUT THIS, LOCKING IS A LOCKOUT. The prefill comes from this device's
  /// stored identity, which can belong to somebody else entirely (a shared or
  /// second-hand handset — the same case the passcode lock screen already
  /// guards against). Recovery is the last path a user has; a reset screen
  /// that will only ever address the previous owner's account has no
  /// alternative to offer them.
  ///
  /// Shown only WHILE locked, so it disappears the moment it has done its job
  /// rather than inviting a change nobody needed.
  Widget _buildNotYouAction() {
    if (!_identityLocked) return const SizedBox.shrink();
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          setState(() {
            _identityLocked = false;
            _identifier = '';
            _initialNsn = null;
            _identifierError = null;
            _fieldKey++;
          });
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Not you? Use a different account',
          style: TextStyle(fontSize: 12.5.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  /// "Use my phone / Use my email", above the field.
  ///
  /// The field alone was not enough: the number is pre-filled from secure
  /// storage on almost every visit, so the screen opened looking like phone
  /// was the only option — which is exactly when it matters that it is not
  /// (no active SMS provider, a lost SIM, a number that has changed hands).
  Widget _buildChannelSelector(bool isLoading) {
    return Row(
      children: [
        Expanded(
          child: _channelChip(
            channel: ResetDeliveryChannel.phone,
            icon: Icons.smartphone,
            label: 'Use my phone',
            enabled: !isLoading,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _channelChip(
            channel: ResetDeliveryChannel.email,
            icon: Icons.alternate_email,
            label: 'Use my email',
            enabled: !isLoading,
          ),
        ),
      ],
    );
  }

  Widget _channelChip({
    required ResetDeliveryChannel channel,
    required IconData icon,
    required String label,
    required bool enabled,
  }) {
    const brand = Color(0xFF4834D4);
    final selected = _channel == channel;
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        borderRadius: BorderRadius.circular(24.r),
        onTap: enabled ? () => _selectChannel(channel) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: selected
                ? brand.withValues(alpha: 0.10)
                : const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: selected ? brand : Colors.transparent,
              width: 1.4,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16.sp,
                  color: selected ? brand : const Color(0xFF6B7280)),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected ? brand : const Color(0xFF6B7280),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpPhase(bool isLoading) {
    final destination =
        _sentToMasked.isNotEmpty ? _sentToMasked : context.read<PasscodeResetCubit>().phone;
    return PhoneFlowScaffold(
      title: _isPhoneIdentifier ? 'Verify your number' : 'Check your email',
      subtitle: 'Enter the 6-digit code we sent to $destination.',
      primaryLabel: 'Continue',
      isLoading: isLoading,
      onPrimary: isLoading ? null : _onOtpContinue,
      children: [
        SizedBox(height: 8.h),
        Center(
          child: VerificationBadgeIcon(
            icon: _isPhoneIdentifier
                ? Icons.sms_outlined
                : Icons.mark_email_unread_outlined,
          ),
        ),
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
            // The DND help is about SMS delivery over a downgraded route — it
            // means nothing on an emailed code, and offering it there sends
            // the user to check a phone setting for a message in their inbox.
            showSmsDndHelp: _isPhoneIdentifier,
            key: ValueKey('reset-resend-$_resendKey'),
            initialSeconds: _resendInitial,
            onResend: () async {
              // AWAITED, and the ANSWER decides the cooldown. Firing this and
              // returning a fixed number started the countdown before the
              // server had said anything, and kept it running when the answer
              // was a refusal — so a rate-limit banner sat above a cheerful
              // "Resend in 57s". null = nothing was sent, so nothing to count
              // down, and the server's own message stands alone.
              final cubit = context.read<PasscodeResetCubit>();
              await cubit.resendOtp();
              if (!mounted) return null;
              if (cubit.state is PasscodeResetFailure) return null;
              // The same dial the server reads, not a second number compiled
              // in here.
              return endpointRegistry.otpResendCooldownSeconds;
            },
          ),
        ),
        SizedBox(height: 28.h),
        SecureVerificationNote(
          message: _isPhoneIdentifier
              ? 'We sent a 6-digit code via SMS to verify your phone number.'
              : 'We emailed a 6-digit code to the address on your account. Check your spam folder if it is not in your inbox.',
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
          // Nothing typed yet → no backspace to show.
          hasEntry: _entered.isNotEmpty,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
