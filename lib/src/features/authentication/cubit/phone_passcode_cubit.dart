import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/signup_state_service.dart';
import '../domain/entities/profile_entity.dart';
import '../domain/repositories/i_auth_repository.dart';
import 'phone_passcode_state.dart';

/// Drives the dedicated "Phone Number + Passcode" authentication flow
/// (signup + login). Mirrors the responsibilities the [AuthenticationCubit]
/// has for the email/password flow, but scoped to the phone-primary surface.
///
/// Working data collected across the multi-screen signup journey (phone,
/// signupToken, passcode, names) lives on the cubit and is persisted to secure
/// storage (the signup-token + phone, NOT the passcode) so a kill/restart can
/// resume. Session persistence on success replicates exactly what
/// [AuthenticationCubit] writes after a login, plus `login_method` set to
/// `phone_passcode` and `stored_phone` as the per-account identifier.
class PhonePasscodeCubit extends Cubit<PhonePasscodeState> {
  final IAuthRepository _authRepository;
  final FlutterSecureStorage _storage;
  final SignupStateService _signupStateService;

  PhonePasscodeCubit({
    required IAuthRepository authRepository,
    required FlutterSecureStorage storage,
    required SignupStateService signupStateService,
  })  : _authRepository = authRepository,
        _storage = storage,
        _signupStateService = signupStateService,
        super(const PhonePasscodeInitial()) {
    // Best-effort resume: re-hydrate the in-progress signup draft (phone +
    // signupToken) so a restart mid-flow can continue without re-doing OTP.
    unawaited(_loadPersistedDraft());
  }

  // ── Session storage keys (kept in sync with AuthenticationCubit) ─────────
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';

  // ── Phone-signup draft keys (best-effort resume; passcode never stored) ──
  static const String _draftPhoneKey = 'phone_signup_phone';
  static const String _draftCountryKey = 'phone_signup_country';
  static const String _draftTokenKey = 'phone_signup_token';
  // 'true' when the user skipped phone verification — persisted so a resume can
  // continue the skipped journey (no token, phone_verified=false) rather than
  // forcing a restart.
  static const String _draftSkippedKey = 'phone_signup_skipped';
  // Epoch-ms the draft was last advanced. A draft older than [_draftTtl] is
  // discarded on load so a long-abandoned signup never resumes into a broken
  // state (e.g. a server-side OTP row that's since been cleaned up).
  static const String _draftTsKey = 'phone_signup_ts';
  static const Duration _draftTtl = Duration(hours: 24);

  // ── In-memory working data for the signup journey ────────────────────────
  String _phone = '';
  String _countryCode = 'NG';
  String? _signupToken;
  String _passcode = '';
  // True when the user skipped phone verification ("for now"): signup proceeds
  // with no token and the account is created phone_verified=false.
  bool _verificationSkipped = false;

  // Personal details are STASHED on the details step and the account is created
  // later — on the dedicated email step — once the user supplies the email that
  // is then verified (so the verify code is sent at the right moment).
  String _firstName = '';
  String _lastName = '';
  String? _dateOfBirth;
  String? _username;
  String? _referralCode;
  String _signupEmail = '';

  // Getters used by screens to seed initial UI.
  String get phone => _phone;
  String get countryCode => _countryCode;
  String get signupEmail => _signupEmail;
  bool get hasSignupToken => _signupToken != null && _signupToken!.isNotEmpty;

  Future<void> _loadPersistedDraft() async {
    try {
      // Discard a stale draft so an abandoned signup never resumes broken.
      final tsRaw = await _storage.read(key: _draftTsKey);
      final ts = int.tryParse(tsRaw ?? '');
      if (ts != null &&
          DateTime.now().millisecondsSinceEpoch - ts > _draftTtl.inMilliseconds) {
        await _clearPersistedDraft();
        return;
      }
      _phone = (await _storage.read(key: _draftPhoneKey)) ?? _phone;
      _countryCode = (await _storage.read(key: _draftCountryKey)) ?? _countryCode;
      _signupToken = await _storage.read(key: _draftTokenKey);
      _verificationSkipped =
          (await _storage.read(key: _draftSkippedKey)) == 'true';
    } catch (_) {
      // Best-effort — a missing/locked draft just starts the user fresh.
    }
  }

  Future<void> _touchDraft() async {
    try {
      await _storage.write(
          key: _draftTsKey,
          value: DateTime.now().millisecondsSinceEpoch.toString());
    } catch (_) {/* best-effort */}
  }

  Future<void> _clearPersistedDraft() async {
    for (final key in const [
      _draftPhoneKey,
      _draftCountryKey,
      _draftTokenKey,
      _draftSkippedKey,
      _draftTsKey,
    ]) {
      try {
        await _storage.delete(key: key);
      } catch (_) {/* best-effort */}
    }
  }

  // ── Signup: request OTP ──────────────────────────────────────────────────
  Future<void> requestPhoneOtp({
    required String phone,
    required String countryCode,
  }) async {
    if (isClosed || state is PhonePasscodeLoading) return;
    _phone = phone;
    _countryCode = countryCode;
    // Requesting a (re)send invalidates any prior verification — e.g. the user
    // went back and changed the number. Drop the old token/skip so signup can
    // never run against a stale, mismatched verification.
    _signupToken = null;
    _verificationSkipped = false;
    try {
      await _storage.delete(key: _draftTokenKey);
      await _storage.delete(key: _draftSkippedKey);
    } catch (_) {/* best-effort */}
    emit(const PhonePasscodeLoading());

    // Pin the auth mode for this in-progress journey so an admin flip can't
    // bounce the user into the email flow mid-onboarding.
    await _signupStateService
        .saveOnboardingAuthType(SignupStateService.authTypePhonePasscode);

    final result = await _authRepository.requestSignupPhoneOtp(
      phone: phone,
      countryCode: countryCode,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(PhonePasscodeFailure(
        failure.message,
        alreadyRegistered: _isAlreadyRegistered(failure.message),
      )),
      (otp) async {
        // Persist phone/country for best-effort resume.
        await _storage.write(key: _draftPhoneKey, value: phone);
        await _storage.write(key: _draftCountryKey, value: countryCode);
        await _touchDraft();
        await _signupStateService.markPhoneStep(SignupStateService.stepPhoneOtp);
        emit(PhoneOtpSent(
          phone: phone,
          expiresInSeconds: otp.expiresInSeconds,
          resendAfterSeconds: otp.resendAfterSeconds,
        ));
      },
    );
  }

  bool _isAlreadyRegistered(String message) =>
      message.toLowerCase().contains('already registered') ||
      message.toLowerCase().contains('already in use');

  /// Re-request the OTP (resend). Same as [requestPhoneOtp] for the current
  /// phone; screens gate this behind the [PhoneOtpSent.resendAfterSeconds]
  /// cooldown.
  Future<void> resendPhoneOtp() async {
    if (_phone.isEmpty) return;
    await requestPhoneOtp(phone: _phone, countryCode: _countryCode);
  }

  // ── Signup: verify OTP ───────────────────────────────────────────────────
  Future<void> verifyOtp({required String phone, required String code}) async {
    if (isClosed || state is PhonePasscodeLoading) return;
    emit(const PhonePasscodeLoading());

    final result =
        await _authRepository.verifySignupPhoneOtp(phone: phone, code: code);

    if (isClosed) return;
    result.fold(
      (failure) => emit(PhonePasscodeFailure(failure.message)),
      (signupToken) async {
        _signupToken = signupToken;
        _verificationSkipped = false; // a real verification supersedes any skip
        // Persist the single-use token so a restart can resume past OTP.
        await _storage.write(key: _draftTokenKey, value: signupToken);
        await _storage.delete(key: _draftSkippedKey);
        await _touchDraft();
        await _signupStateService
            .markPhoneStep(SignupStateService.stepPhonePasscodeCreate);
        emit(PhoneOtpVerified(signupToken));
      },
    );
  }

  /// Skip phone verification "for now": advance past the OTP screen WITHOUT a
  /// verified token. The account is created with phone_verified=false (the
  /// backend still requires that an OTP was requested for this phone). Reuses
  /// [PhoneOtpVerified] so the OTP screen advances to passcode setup.
  Future<void> skipPhoneVerification() async {
    if (isClosed || state is PhonePasscodeLoading) return;
    _verificationSkipped = true;
    _signupToken = '';
    try {
      await _storage.delete(key: _draftTokenKey);
      // Persist the skip so a quit/resume continues (no token) instead of
      // restarting verification.
      await _storage.write(key: _draftSkippedKey, value: 'true');
    } catch (_) {/* best-effort */}
    await _touchDraft();
    await _signupStateService
        .markPhoneStep(SignupStateService.stepPhonePasscodeCreate);
    emit(const PhoneOtpVerified(''));
  }

  // ── Signup: passcode capture (in memory only) ────────────────────────────
  /// Hold the chosen passcode after the user enters + confirms it. The passcode
  /// is intentionally NOT persisted to storage.
  Future<void> setPasscode(String passcode) async {
    _passcode = passcode;
    if (isClosed) return;
    await _signupStateService
        .markPhoneStep(SignupStateService.stepPhonePersonalDetails);
    emit(const PhonePasscodeSet());
  }

  /// Validate that the confirmation matches and store it. Returns true when the
  /// two entries match (caller advances), false otherwise (caller shows error).
  Future<bool> confirmPasscode({
    required String passcode,
    required String confirmation,
  }) async {
    if (passcode != confirmation) {
      if (!isClosed) {
        emit(const PhonePasscodeFailure('Passcodes do not match'));
      }
      return false;
    }
    await setPasscode(passcode);
    return true;
  }

  // ── Signup: details (stash only — no network) ────────────────────────────
  /// Stash the personal details collected on the details step. The account is
  /// NOT created here — it is created on the dedicated email step (via
  /// [submitSignup]) so the email is supplied + its verification code sent at
  /// the moment the user reaches the email/verify screen.
  void stashDetails({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    String? username,
    String? referralCode,
  }) {
    _firstName = firstName.trim();
    _lastName = lastName.trim();
    _dateOfBirth =
        dateOfBirth.trim().isEmpty ? null : dateOfBirth.trim();
    _username = (username != null && username.trim().isNotEmpty)
        ? username.trim()
        : null;
    _referralCode = (referralCode != null && referralCode.trim().isNotEmpty)
        ? referralCode.trim()
        : null;
  }

  // ── Signup: submit (email step, phase 1 — creates the account) ───────────
  /// Create the account with the stashed details + the [email] entered on the
  /// email step. SignupWithPhone sends an email verification code on success,
  /// so the email screen then reveals its code-entry section.
  Future<void> submitSignup({required String email}) async {
    if (isClosed || state is PhonePasscodeLoading) return; // guard double-submit
    final token = _signupToken ?? '';
    // A token is required UNLESS the user skipped verification.
    if (!_verificationSkipped && token.isEmpty) {
      await _clearPersistedDraft();
      emit(const PhonePasscodeFailure(
        'Your signup session expired. Please start again.',
        restartFlow: true,
      ));
      return;
    }
    if (_passcode.isEmpty) {
      // Passcode is in-memory only — a resume lands on passcode-create, but be
      // defensive: send the user back to set it.
      emit(const PhonePasscodeFailure(
        'Please set your passcode again.',
        restartFlow: true,
      ));
      return;
    }
    if (_firstName.isEmpty || _lastName.isEmpty) {
      emit(const PhonePasscodeFailure(
        'Please re-enter your details.',
        restartFlow: true,
      ));
      return;
    }

    _signupEmail = email.trim();
    emit(const PhonePasscodeLoading());

    await _signupStateService
        .markPhoneStep(SignupStateService.stepPhoneOptionalEmail);

    final locale = 'en-${_countryCode.toUpperCase()}';
    final result = await _authRepository.signUpWithPhone(
      phone: _phone,
      signupToken: token,
      passcode: _passcode,
      firstName: _firstName,
      lastName: _lastName,
      email: _signupEmail,
      countryCode: _countryCode,
      locale: locale,
      username: _username,
      referralCode: _referralCode,
      dateOfBirth: _dateOfBirth,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        final lower = failure.message.toLowerCase();
        final invalidSession = lower.contains('signup session') ||
            lower.contains('verify your phone again');
        if (invalidSession) {
          unawaited(_clearPersistedDraft());
          emit(const PhonePasscodeFailure(
            'Your signup session expired. Please start again.',
            restartFlow: true,
          ));
        } else {
          emit(PhonePasscodeFailure(
            failure.message,
            alreadyRegistered: _isAlreadyRegistered(failure.message),
          ));
        }
      },
      (profile) async {
        await _persistSession(profile);
        // Signup complete — clear the in-progress draft + mode pin.
        await _clearPersistedDraft();
        await _signupStateService.markSignupComplete();
        // Flag KYC onboarding as pending so the BVN step shows in the signup
        // flow (parity with the email_password flow, which sets this after
        // passcode setup). The BVN screen reads this to run in onboarding mode
        // and routes forward to the dashboard on Skip/Done.
        await _storage.write(key: 'kyc_onboarding_pending', value: 'true');
        emit(PhoneSignupSuccess(profile));
      },
    );
  }

  // ── Signup: email step, phase 2 — verify the code ────────────────────────
  /// Verify the 6-digit code emailed after the account was created. On success
  /// the account's email is marked verified and the flow advances to the
  /// transaction-PIN step.
  Future<void> verifyEmailCode(String code) async {
    if (isClosed || state is PhonePasscodeLoading) return;
    final c = code.trim();
    if (c.length != 6) {
      emit(const PhonePasscodeFailure('Enter the 6-digit code.'));
      return;
    }
    emit(const PhonePasscodeLoading());
    final result = await _authRepository.verifyEmail(verificationCode: c);
    if (isClosed) return;
    result.fold(
      (failure) => emit(PhonePasscodeFailure(failure.message)),
      (profile) => emit(PhoneEmailVerified(profile)),
    );
  }

  /// Resend the email verification code to the address used at signup.
  Future<void> resendSignupEmailCode() async {
    if (isClosed || _signupEmail.isEmpty) return;
    final result =
        await _authRepository.resendVerificationEmail(email: _signupEmail);
    if (isClosed) return;
    result.fold(
      (failure) => emit(PhonePasscodeFailure(failure.message)),
      (cooldown) => emit(PhoneEmailCodeResent(cooldown)),
    );
  }

  // ── Login ────────────────────────────────────────────────────────────────
  Future<void> loginWithPhonePasscode({
    required String phone,
    required String passcode,
  }) async {
    if (isClosed || state is PhonePasscodeLoading) return;
    emit(const PhonePasscodeLoading());

    final result = await _authRepository.loginWithPhonePasscode(
      phone: phone,
      passcode: passcode,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        if (failure is TwoFactorRequiredFailure) {
          emit(PhoneLoginTwoFactorRequired(
            twoFactorToken: failure.twoFactorToken,
            method: failure.method,
          ));
          return;
        }
        if (failure is StepUpRequiredFailure) {
          emit(PhoneLoginStepUpRequired(
            stepUpToken: failure.stepUpToken,
            method: failure.stepUpMethod,
            destination: failure.destination,
          ));
          return;
        }
        emit(PhonePasscodeFailure(failure.message));
      },
      (profile) async {
        await _persistSession(profile);
        emit(PhoneLoginSuccess(profile));
      },
    );
  }

  // ── Session persistence (replicates AuthenticationCubit._saveSession) ─────
  Future<void> _persistSession(ProfileEntity profile) async {
    try {
      await _storage.write(
          key: _accessTokenKey, value: profile.session.accessToken);
      await _storage.write(
          key: _refreshTokenKey, value: profile.session.refreshToken);
      await _storage.write(key: _userIdKey, value: profile.user.id);
      await _storage.write(key: _userEmailKey, value: profile.user.email);
      await _storage.write(key: 'stored_email', value: profile.user.email);
      await _storage.write(
          key: 'user_first_name', value: profile.user.firstName);
      await _storage.write(key: 'user_last_name', value: profile.user.lastName);
      if (profile.user.profilePicture != null &&
          profile.user.profilePicture!.isNotEmpty) {
        await _storage.write(
            key: 'user_avatar_url', value: profile.user.profilePicture!);
      } else {
        await _storage.delete(key: 'user_avatar_url');
      }

      // Phone+passcode is this account's login method. `stored_phone` is the
      // per-account identifier boot routing reads to send the user straight to
      // the phone-passcode login screen.
      await _storage.write(key: 'login_method', value: 'phone_passcode');
      // A phone+passcode session by definition has a passcode; record it as
      // locally authoritative so the passcode lock recognises this returning
      // user even if a later GetMe echoes a stale hasPasscode=false.
      await _storage.write(key: 'has_passcode', value: 'true');
      final phone = (profile.user.phoneNumber != null &&
              profile.user.phoneNumber!.isNotEmpty)
          ? profile.user.phoneNumber!
          : _phone;
      await _storage.write(key: 'stored_phone', value: phone);

      // Mirror the refresh token into the DURABLE biometric store when the user
      // has opted into fingerprint/Face login, so biometric unlock can re-mint a
      // fresh session after the volatile refresh_token is wiped (see
      // SecureStorageService's biometric-session key docs). Raw keys keep this
      // cubit dependency-free; they match SecureStorageService exactly.
      final biometricOn =
          (await _storage.read(key: 'fingerprint_login_enabled')) == 'true' ||
              (await _storage.read(key: 'face_login_enabled')) == 'true';
      if (biometricOn && profile.session.refreshToken.isNotEmpty) {
        await _storage.write(
            key: 'biometric_refresh_token',
            value: profile.session.refreshToken);
        await _storage.write(key: 'biometric_user_id', value: profile.user.id);
      }
    } catch (e) {
      // Never let a storage hiccup block the success emission — the backend
      // session is already valid; worst case the user re-authenticates.
      // ignore: avoid_print
      print('Error persisting phone+passcode session: $e');
    }
  }

  /// True when the platform is in phone+passcode mode (for callers that want to
  /// branch UI). Existing accounts keep their own method regardless.
  bool get isPhonePasscodeMode => FeatureFlags.isPhonePasscodeMode;
}
