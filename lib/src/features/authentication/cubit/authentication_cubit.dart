import 'dart:async';

import 'package:dartz/dartz.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_snapshot_cache.dart';
import 'package:lazervault/src/features/p2p_chat/services/p2p_chat_websocket_service.dart';
import 'package:lazervault/core/utilities/passcode_policy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/signup_state_service.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/haptics_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/pending_actions/data/pending_payments_prompt_gate.dart';
import 'package:lazervault/src/features/pending_actions/presentation/cubit/pending_actions_cubit.dart';
import 'package:lazervault/core/services/push_notifications_service.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/user_switch_purge.dart';
import 'package:lazervault/core/services/login_flow_resolver.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/remote_log_sink.dart';
import 'package:lazervault/core/utils/friendly_error.dart';
import 'package:lazervault/core/notifications/notification_navigator.dart';
import 'package:lazervault/src/features/authentication/utils/login_identifier.dart';
import 'package:lazervault/src/features/group_account/presentation/cubit/group_account_cubit.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/src/generated/auth.pbenum.dart' as auth_enum;
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/login_with_passcode_usecase.dart';
import '../domain/usecases/register_passcode_usecase.dart';
import '../domain/usecases/sign_up_usecase.dart';
import '../domain/usecases/sign_in_with_google_usecase.dart';
import '../domain/usecases/sign_in_with_apple_usecase.dart';
import '../domain/usecases/forgot_password_usecase.dart';
import '../domain/usecases/reset_password_usecase.dart';
import '../domain/usecases/verify_email_usecase.dart';
import '../domain/usecases/resend_verification_usecase.dart';
import '../domain/usecases/check_email_availability_usecase.dart';
import '../domain/usecases/verify_identity_usecase.dart';
import '../domain/usecases/validate_token_usecase.dart';
import '../../virtual_account/domain/usecases/create_virtual_account_usecase.dart';
import '../../referral/domain/usecases/validate_referral_code_usecase.dart';
import '../domain/entities/profile_entity.dart';
import '../domain/entities/user.dart';
import '../domain/entities/signup_draft.dart';
import '../domain/entities/two_factor_entity.dart';
import 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final LoginUseCase _loginUseCase;
  final LoginWithPasscodeUseCase _loginWithPasscodeUseCase;
  final RegisterPasscodeUseCase _registerPasscodeUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResendVerificationUseCase _resendVerificationUseCase;
  final CheckEmailAvailabilityUseCase _checkEmailAvailabilityUseCase;
  final VerifyIdentityUseCase _verifyIdentityUseCase;
  final ValidateTokenUseCase _validateTokenUseCase;
  final CreateVirtualAccountUseCase? _createVirtualAccountUseCase;
  final IAuthRepository _authRepository;
  final FlutterSecureStorage _storage;
  final CurrencySyncService _currencySyncService;
  final AccountManager _accountManager;
  final SignupStateService? _signupStateService;
  final ValidateReferralCodeUseCase? _validateReferralCodeUseCase;

  ProfileEntity? _currentProfile;
  Timer? _draftSaveTimer;

  /// True while an intentional logout is in flight. In-flight background ops
  /// (profile refresh / websocket reconnect / token validation) will start
  /// failing the moment the session is cleared and would otherwise surface a
  /// noisy auth-error snackbar on top of the "come back soon" message. This
  /// flag lets us suppress those self-inflicted errors WITHOUT suppressing
  /// legitimate auth errors during login. Cleared on the next login attempt.
  bool _isLoggingOut = false;

  /// Whether an intentional logout is currently in progress. Listeners can
  /// read this to avoid reacting to the transient AuthenticationError that a
  /// background request may emit while the session is being torn down.
  bool get isLoggingOut => _isLoggingOut;

  AuthenticationCubit({
    required LoginUseCase login,
    required LoginWithPasscodeUseCase loginWithPasscode,
    required RegisterPasscodeUseCase registerPasscode,
    required SignUpUseCase signUp,
    required SignInWithGoogleUseCase signInWithGoogle,
    required SignInWithAppleUseCase signInWithApple,
    required ForgotPasswordUseCase forgotPassword,
    required ResetPasswordUseCase resetPassword,
    required VerifyEmailUseCase verifyEmail,
    required ResendVerificationUseCase resendVerification,
    required CheckEmailAvailabilityUseCase checkEmailAvailability,
    required VerifyIdentityUseCase verifyIdentity,
    required ValidateTokenUseCase validateToken,
    CreateVirtualAccountUseCase? createVirtualAccount,
    required IAuthRepository authRepository,
    FlutterSecureStorage? storage,
    required CurrencySyncService currencySyncService,
    required AccountManager accountManager,
    SignupStateService? signupStateService,
    ValidateReferralCodeUseCase? validateReferralCode,
  })  : _loginUseCase = login,
        _loginWithPasscodeUseCase = loginWithPasscode,
        _registerPasscodeUseCase = registerPasscode,
        _signUpUseCase = signUp,
        _signInWithGoogleUseCase = signInWithGoogle,
        _signInWithAppleUseCase = signInWithApple,
        _forgotPasswordUseCase = forgotPassword,
        _resetPasswordUseCase = resetPassword,
        _verifyEmailUseCase = verifyEmail,
        _resendVerificationUseCase = resendVerification,
        _checkEmailAvailabilityUseCase = checkEmailAvailability,
        _verifyIdentityUseCase = verifyIdentity,
        _validateTokenUseCase = validateToken,
        _createVirtualAccountUseCase = createVirtualAccount,
        _authRepository = authRepository,
        _storage = storage ?? const FlutterSecureStorage(),
        _currencySyncService = currencySyncService,
        _accountManager = accountManager,
        _signupStateService = signupStateService,
        _validateReferralCodeUseCase = validateReferralCode,
        super(AuthenticationInitial());

  // Getters
  ProfileEntity? get currentProfile => _currentProfile;
  bool get isAuthenticated => _currentProfile != null;
  bool get isEmailVerified => _currentProfile?.user.isEmailVerified ?? false;
  String? get userId => _currentProfile?.user.id;

  // Storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';

  // --- Session Management ---
  Future<void> tryAutoLogin() async {
    try {
      final accessToken = await _storage.read(key: _accessTokenKey);
      final userId = await _storage.read(key: _userIdKey);

      if (accessToken != null && userId != null) {
        // Token exists, validate it with the backend
        if (isClosed) return;
        emit(AuthenticationCheckingSession());

        final result = await _validateTokenUseCase(accessToken: accessToken);

        if (isClosed) return;

        await result.fold(
          (failure) async {
            // The ACCESS token failed validation — routine after its ~1h TTL.
            // Do NOT nuke the session on that alone: first try a refresh-token
            // rotation. Wiping here (the old behaviour) is what forced returning
            // users back to the passcode AND dead-ended biometric unlock (the
            // fingerprint succeeded but the refresh_token was already gone).
            print('Auto login: access token invalid, attempting refresh: '
                '${failure.message}');
            final r = await _authRepository.refreshTokensWithReason();
            if (isClosed) return;
            final newAccess = r.tokens?['accessToken'];
            if (r.tokens != null && newAccess != null && newAccess.isNotEmpty) {
              final revalidate =
                  await _validateTokenUseCase(accessToken: newAccess);
              if (isClosed) return;
              final restored = revalidate.fold((_) => false, (profile) {
                _currentProfile = profile;
                // Revalidated a real profile → refresh the Send Funds flow pin in
                // the background (updates memory + storage only if it changed).
                FeatureFlags.pinSendFlowForSession();
                emit(AuthenticationAuthenticated(profile));
                unawaited(_registerPushTokenIfReady());
                // The rotated refresh token was already persisted by
                // refreshTokensWithReason — that single `refresh_token` IS the
                // biometric credential (no durable second copy).
                return true;
              });
              if (restored) return;
            }
            if (r.authExpired) {
              // The refresh token was DEFINITIVELY rejected (revoked / expired /
              // invalid) → the session is genuinely gone → passcode required.
              print('Auto login: refresh definitively rejected — clearing');
              await _clearSession();
              if (isClosed) return;
              emit(AuthenticationInitial());
            } else {
              // TRANSIENT failure (network / timeout / 5xx / server down). The
              // refresh token is STILL VALID — do NOT log the user out and do NOT
              // wipe any token. This was the real cause of "fingerprint succeeds
              // but then asks for my passcode": a mere network blip on cold start
              // wiped a perfectly good session, so biometric had nothing to
              // re-mint from. By preserving refresh_token + the durable biometric
              // copy, the fingerprint fast-path rotates them the moment the
              // network recovers. Stay logged in if we still hold the profile.
              print('Auto login: transient refresh failure — session preserved');
              if (_currentProfile != null) {
                emit(AuthenticationAuthenticated(_currentProfile!));
              } else {
                emit(AuthenticationInitial());
              }
            }
          },
          (profile) async {
            // Token is valid, restore session
            _currentProfile = profile;
            // Revalidated on cold start → refresh the Send Funds flow pin in the
            // background (memory + storage, only if it changed).
            FeatureFlags.pinSendFlowForSession();
            emit(AuthenticationAuthenticated(profile));
            unawaited(_registerPushTokenIfReady());
          },
        );
      }
    } catch (e) {
      print('Auto login failed: $e');
      if (isClosed) return;
      emit(AuthenticationInitial());
    }
  }

  /// Re-fetch the authenticated profile from the backend so the app reflects
  /// any server-side changes (e.g. a KYC tier that was just upgraded). Used by
  /// flows that detour to KYC mid-action and need the refreshed standing on
  /// return so a retry doesn't fail again with the same gate. Best-effort: a
  /// failure leaves the existing profile untouched and the caller can proceed
  /// (the backend re-checks KYC authoritatively at the operation boundary).
  Future<void> refreshProfile() async {
    try {
      final accessToken =
          _currentProfile?.session.accessToken ??
              await _storage.read(key: _accessTokenKey);
      if (accessToken == null || accessToken.isEmpty) return;

      final result = await _validateTokenUseCase(accessToken: accessToken);
      if (isClosed) return;
      result.fold(
        (failure) {
          // Token still valid locally; just couldn't refresh. Keep the
          // current profile and let the caller proceed.
          print('refreshProfile failed: ${failure.message}');
        },
        (profile) {
          _currentProfile = profile;
          emit(AuthenticationSuccess(profile));
        },
      );
    } catch (e) {
      print('refreshProfile failed: $e');
    }
  }

  /// Hydrate the shared auth state from a profile obtained via an ALTERNATE
  /// auth path (the phone+passcode flow uses its own [PhonePasscodeCubit]).
  /// Without this, the app-wide AuthenticationCubit stays empty after a phone
  /// signup and downstream screens that read [currentProfile] (KYC readiness,
  /// dashboard, profile) see no email/user. No network round-trip — the caller
  /// already holds the freshly-issued profile.
  void hydrateProfile(ProfileEntity profile) {
    _currentProfile = profile;
    // Tag subsequent Loki logs with this user so a failed flow is traceable.
    RemoteLogSink.instance.setUserId(profile.user.id);
    // Pin the Send Funds flow for this session too — the phone+passcode path
    // hydrates here instead of via `_saveSession`, so without this a phone
    // signup/login would leave the flow unpinned (see `_saveSession`).
    FeatureFlags.pinSendFlowForSession();
    emit(AuthenticationSuccess(profile));
  }

  Future<void> _saveSession(ProfileEntity profile) async {
    try {
      // CROSS-USER CACHE GUARD: if the profile we're about to store belongs to a
      // DIFFERENT user than the one currently cached on this device (e.g. logout
      // / inactivity-logout then signup or login as another person), purge every
      // per-user cache FIRST so the new user never inherits the previous user's
      // passcode, avatar, KYC tier, cached API data, or in-memory cubit state.
      // Same-user re-login (the legitimate "remember last email for passcode"
      // UX) is a no-op here — the ids/emails match.
      final prevUserId = await _storage.read(key: _userIdKey);
      final prevEmail = await _storage.read(key: 'stored_email');
      if (isUserSwitch(
        previousUserId: prevUserId,
        previousEmail: prevEmail,
        newUserId: profile.user.id,
        newEmail: profile.user.email,
      )) {
        await _purgeStaleUserCache();
      }

      // IDENTITY FIRST — before any I/O that can throw.
      //
      // Everything below this line is PERSISTENCE, and it is legitimately
      // best-effort: the catch at the bottom swallows failures so a bad write
      // can't block a sign-in. But `_currentProfile` used to be assigned at the
      // very END of that same try, ~90 awaited storage writes later, and
      // `_purgeStaleUserCache` nulls it on the way in. So on a USER SWITCH, one
      // throwing write left the app authenticated with NO profile: callers
      // still emitted AuthenticationSuccess and routed to the dashboard, where
      // `currentProfile == null` renders "Guest User" and every screen gated on
      // it (wallet, transaction history) waits forever on an identity that will
      // never arrive. Assigning here cannot fail — the profile is already in
      // hand — so the in-memory session survives any storage problem.
      _currentProfile = profile;

      // Tag subsequent Loki logs with this user (covers every passcode/email/
      // phone login path that funnels through here).
      RemoteLogSink.instance.setUserId(profile.user.id);

      await _storage.write(
        key: _accessTokenKey,
        value: profile.session.accessToken,
      );
      await _storage.write(
        key: _refreshTokenKey,
        value: profile.session.refreshToken,
      );
      await _storage.write(
        key: _userIdKey,
        value: profile.user.id,
      );
      await _storage.write(
        key: _userEmailKey,
        value: profile.user.email,
      );
      // Also store email in fallback key for passcode login consistency
      await _storage.write(
        key: 'stored_email',
        value: profile.user.email,
      );
      // Store user profile data for passcode screen
      await _storage.write(
        key: 'user_first_name',
        value: profile.user.firstName,
      );
      await _storage.write(
        key: 'user_last_name',
        value: profile.user.lastName,
      );
      // Store profile picture if available; otherwise DELETE the key so a new
      // user without an avatar can never show the previous user's picture on
      // the passcode screen (writing nothing would leave the stale value).
      if (profile.user.profilePicture != null && profile.user.profilePicture!.isNotEmpty) {
        await _storage.write(
          key: 'user_avatar_url',
          value: profile.user.profilePicture!,
        );
      } else {
        await _storage.delete(key: 'user_avatar_url');
      }

      // Mirror the user's explicit login-method preference locally so the
      // app-launch router can honor it without a GetMe round-trip. IMPORTANT:
      // only WRITE when the backend actually has a value — do NOT delete on an
      // empty value. Empty means "user never chose", not "clear the choice";
      // deleting it was the main cause of the login flow flip-flopping, because
      // it wiped the one stable signal for every user who never opened Settings.
      final pref = profile.user.preferredLoginMethod;
      if (pref != null && pref.isNotEmpty) {
        await _storage.write(key: 'preferred_login_method', value: pref);
      }
      // Mirror password presence for Settings (its ProfileCubit user, sourced
      // from user-service, doesn't carry has_password).
      await _storage.write(
        key: 'has_password',
        value: profile.user.hasPassword ? 'true' : 'false',
      );
      // Mirror passcode presence too (used by the canonical flow resolver).
      // NEVER downgrade a known passcode: a passcode credential doesn't vanish
      // because one GetMe omitted/echoed hasPasscode=false, and a wrongful
      // 'false' is exactly what sent returning users from the app lock to the
      // full login page. Treat an existing 'true' — or a passcode-family
      // login_method — as authoritative and keep it.
      final existingHasPasscode =
          (await _storage.read(key: 'has_passcode')) == 'true';
      final method =
          (await _storage.read(key: 'login_method'))?.toLowerCase().trim();
      final passcodeKnown = profile.user.hasPasscode ||
          existingHasPasscode ||
          method == 'passcode' ||
          method == 'phone_passcode';
      await _storage.write(
        key: 'has_passcode',
        value: passcodeKnown ? 'true' : 'false',
      );
      // Resolve + cache the SINGLE canonical login flow from the account's real
      // shape + explicit choice, so every screen/router agrees on the next
      // launch (offline-safe, default phone_passcode). See LoginFlowResolver.
      await LoginFlowResolver.record(
        preferred: pref,
        hasPasscode: profile.user.hasPasscode,
        hasPassword: profile.user.hasPassword,
      );

      // Reset locale/currency from registration country (in-memory, derived)
      final localeManager = serviceLocator<LocaleManager>();
      final country = profile.user.country;
      if (country != null && country.isNotEmpty) {
        localeManager.resetToCountry(country.toUpperCase());
      }

      // Resolve + pin the Send Funds flow (short vs long) ONCE per session, right
      // beside the login-flow resolution above. Every send ENTRY point then reads
      // this in-memory value, so a mid-session background config refresh can't
      // flip the user between flows mid-journey (e.g. switching right after the
      // transaction-PIN sheet on a slow network). Re-resolved on the next login.
      FeatureFlags.pinSendFlowForSession();
    } catch (e) {
      // The in-memory profile is already set above, so the session survives
      // this. What did NOT survive is persistence — the access/refresh tokens,
      // the remembered email, the passcode-screen name/avatar — so the user is
      // fine now but will be bounced to a full login on next launch, with no
      // clue why. Ship it to Loki so that turns into a report instead of a
      // mystery.
      print('Error saving session: $e');
      RemoteLogSink.instance.log(
        level: 'error',
        flow: 'auth',
        message: 'save_session failed: $e',
        fields: {'user_id': profile.user.id},
      );
    }
  }

  /// Purge every PER-USER cache that survives a logout, so a different user
  /// signing in on the same device never sees the previous user's data. This
  /// covers three classes of stale state the cross-user leak came from:
  ///   1. Secure-storage keys the passcode/login screens read directly
  ///      (passcode credential, avatar, names, login method, KYC flags, cached
  ///      BVN/NIN, last chat session).
  ///   2. The SWR API cache (profile, accounts, KYC tier + limits, balances) —
  ///      a persisted+in-memory cache that would otherwise replay the previous
  ///      user's responses for the new user.
  ///   3. Long-lived singleton cubits / managers whose in-memory state outlives
  ///      the session (active account, group accounts).
  /// Best-effort: any individual failure is swallowed so a partial purge can
  /// never block (or crash) the new user's sign-in.
  Future<void> _purgeStaleUserCache() async {
    // The purge itself lives in core/services/user_switch_purge.dart because
    // PhonePasscodeCubit persists sessions too and needs the identical
    // behaviour — it used to have none, so a switch over the phone path left
    // the previous user's passcode credential, BVN/NIN, biometric token and
    // cached balances behind.
    await purgeStaleUserCache(_storage);

    // The INJECTED instances this cubit holds. The shared purge resolves these
    // from the serviceLocator, which is the same singleton in production — but
    // a test that injects its own must still see them cleared.
    try {
      _accountManager.clearActiveAccount();
    } catch (_) {/* best-effort */}
    try {
      _currencySyncService.clear();
    } catch (_) {/* best-effort */}

    // Drop the previous user's profile so no getter returns stale identity
    // between the purge and the new session write.
    _currentProfile = null;
  }

  Future<void> _clearSession() async {
    try {
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
      await _storage.delete(key: _userIdKey);
      await _storage.delete(key: _userEmailKey);
      // Keep stored_email, user_first_name, user_last_name, user_avatar_url
      // for passcode login screen greeting. Overwritten on next login via _saveSession().
      // Clear active account to prevent using stale account_id from previous user
      _accountManager.clearActiveAccount();
      _currentProfile = null;
      // Clear the IN-MEMORY Send Funds flow pin so the NEXT genuine login
      // re-resolves it (and picks up any changed platform default). The
      // PERSISTED value is kept (clearSessionSendFlowPin doesn't touch prefs) so
      // cold-boot routing before that login is still instant + offline-safe.
      // In-session revalidations (app-lock unlock) no longer re-pin, so this is
      // the only place — besides a Settings change — the flow can be re-resolved.
      FeatureFlags.clearSessionSendFlowPin();
      // Stop tagging Loki logs with the logged-out user.
      RemoteLogSink.instance.setUserId(null);
      // Drop the session "has transaction PIN" cache. Without this, if the next
      // login (same process) is a user whose PIN was cleared server-side (e.g. a
      // super-admin reset), the stale `true` would skip the required PIN setup.
      if (serviceLocator.isRegistered<ITransactionPinService>()) {
        try {
          serviceLocator<ITransactionPinService>().resetPinCache();
        } catch (_) {}
      }
      // Wipe in-memory P2P caches (conversation snapshots + saved contacts) so
      // the NEXT user never briefly sees the previous user's chats/contacts.
      clearAllP2PCaches();
      // Drop the shared P2P realtime socket. It's a lazy singleton connected
      // with THIS user's token; its `connect()` early-returns while connected,
      // so without disconnecting here the next user would keep receiving the
      // previous user's messages/badge events. Disconnecting forces a clean
      // reconnect with the new user's token on the next conversations load.
      if (serviceLocator.isRegistered<P2PChatWebSocketService>()) {
        try {
          serviceLocator<P2PChatWebSocketService>().disconnect();
        } catch (_) {}
      }
    } catch (e) {
      print('Error clearing session: $e');
    }
  }

  // --- Main Auth Methods ---
  Future<void> loginUser({
    required String email,
    required String password,
    String countryIso = 'NG',
  }) async {
    // `email` is the raw identifier from the sign-in field — it may be an email
    // OR a phone number. Split into the (email, phone) pair the Login RPC
    // expects; phone is normalized to E.164 using the country selected in the
    // login UI (default Nigeria).
    final id = splitLoginIdentifier(email, countryIso: countryIso);
    print('🔐 Login attempt (identifier resolved: '
        '${id.phone.isNotEmpty ? 'phone' : 'email'})');
    if (isClosed) return;
    _isLoggingOut = false; // genuine login attempt — re-enable error surfacing
    emit(AuthenticationLoading());

    final result =
        await _loginUseCase(email: id.email, phone: id.phone, password: password);

    if (isClosed) return;

    // Handle result properly - fold doesn't await async callbacks
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => throw StateError('unreachable'));
      // 2FA enabled: route to the 2FA verification flow.
      if (failure is TwoFactorRequiredFailure) {
        emit(LoginTwoFactorRequired(twoFactorToken: failure.twoFactorToken, method: failure.method));
        return;
      }
      // Risk-based step-up: route to the OTP flow instead of an error.
      if (failure is StepUpRequiredFailure) {
        emit(LoginStepUpRequired(
          stepUpToken: failure.stepUpToken,
          method: failure.stepUpMethod,
          destination: failure.destination,
        ));
        return;
      }
      print('❌ Login failed for email: $email - ${failure.message}');
      // Network/server outages must not be mislabelled as a credential error.
      // Surface a friendly network message for those; otherwise keep the
      // deliberately generic credential message (don't reveal which field).
      final message = isNetworkStatusCode(failure.statusCode)
          ? networkErrorMessage
          : 'Invalid email or password';
      emit(AuthenticationFailure(
        message,
        statusCode: failure.statusCode,
      ));
    } else {
      final profile = result.fold((l) => throw StateError('unreachable'), (r) => r);
      print('✅ Login successful for email: ${profile.user.email}');
      // IMPORTANT: Await session storage to ensure user data is persisted
      // before emitting success and navigating away
      await _saveSession(profile);
      print('✅ Session saved for email: ${profile.user.email}');
      emit(AuthenticationSuccess(profile));
    }
  }

  Future<void> loginWithPasscode({
    required String email,
    required String passcode,
  }) async {
    if (isClosed) return;
    _isLoggingOut = false; // genuine login attempt — re-enable error surfacing
    emit(const AuthenticationLoading());

    final result = await _loginWithPasscodeUseCase(
      email: email,
      passcode: passcode,
    );

    if (isClosed) return;

    // Handle result properly - fold doesn't await async callbacks
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => throw StateError('unreachable'));
      if (failure is TwoFactorRequiredFailure) {
        emit(LoginTwoFactorRequired(twoFactorToken: failure.twoFactorToken, method: failure.method));
        return;
      }
      if (failure is StepUpRequiredFailure) {
        emit(LoginStepUpRequired(
          stepUpToken: failure.stepUpToken,
          method: failure.stepUpMethod,
          destination: failure.destination,
        ));
        return;
      }
      emit(AuthenticationError(failure.message));
    } else {
      final profile = result.fold((l) => throw StateError('unreachable'), (r) => r);
      // IMPORTANT: Await all storage operations before emitting success
      await _saveSession(profile);
      await _storage.write(key: 'login_method', value: 'passcode');
      await _storage.write(key: 'stored_email', value: email);
      emit(AuthenticationSuccess(profile));
    }
  }

  /// Complete an adaptive step-up login: verify the OTP and, on success, save the
  /// session and emit [AuthenticationSuccess] (same as a normal login).
  Future<void> verifyLoginOtp({
    required String stepUpToken,
    required String code,
  }) async {
    if (isClosed) return;
    emit(const AuthenticationLoading());
    final result = await _authRepository.verifyLoginOtp(
      stepUpToken: stepUpToken,
      code: code,
    );
    if (isClosed) return;
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => throw StateError('unreachable'));
      emit(AuthenticationError(failure.message));
    } else {
      final profile = result.fold((l) => throw StateError('unreachable'), (r) => r);
      await _saveSession(profile);
      emit(AuthenticationSuccess(profile));
    }
  }

  Future<void> registerPasscode({
    required String passcode,
  }) async {
    if (isClosed) return;
    emit(const AuthenticationLoading());

    final result = await _registerPasscodeUseCase(passcode: passcode);

    if (isClosed) return;

    // Handle result properly - fold doesn't await async callbacks
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => throw StateError('unreachable'));
      _showErrorSnackbar('Passcode Registration Failed', failure.message);
      emit(AuthenticationError(failure.message));
    } else {
      // Store login method preference after successful registration
      await _storage.write(key: 'login_method', value: 'passcode');
      // Local-authoritative passcode signal (see _registerPasscodeFromSetup).
      await _storage.write(key: 'has_passcode', value: 'true');
      if (_currentProfile != null) {
        await _storage.write(key: 'stored_email', value: _currentProfile!.user.email);
        await _storage.write(key: 'user_first_name', value: _currentProfile!.user.firstName);
      }
      _showSuccessSnackbar('Success!', 'Passcode registered successfully');
      // Return to the current authenticated state
      if (_currentProfile != null) {
        emit(AuthenticationSuccess(_currentProfile!));
      } else {
        emit(AuthenticationInitial());
      }
    }
  }

  Future<void> signInWithGoogle() async {
    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _signInWithGoogleUseCase();

    if (isClosed) return;

    // Handle result properly - fold doesn't await async callbacks
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => throw StateError('unreachable'));
      _showErrorSnackbar('Google Sign-In Failed', failure.message);
      emit(AuthenticationFailure(
        failure.message,
        statusCode: failure.statusCode,
      ));
    } else {
      final profile = result.fold((l) => throw StateError('unreachable'), (r) => r);
      await _saveSession(profile);
      emit(AuthenticationSuccess(profile));
    }
  }

  Future<void> signInWithApple() async {
    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _signInWithAppleUseCase();

    if (isClosed) return;

    // Handle result properly - fold doesn't await async callbacks
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => throw StateError('unreachable'));
      _showErrorSnackbar('Apple Sign-In Failed', failure.message);
      emit(AuthenticationFailure(
        failure.message,
        statusCode: failure.statusCode,
      ));
    } else {
      final profile = result.fold((l) => throw StateError('unreachable'), (r) => r);
      await _saveSession(profile);
      emit(AuthenticationSuccess(profile));
    }
  }

  // --- Password Recovery Flow---
  void startForgotPassword() {
    emit(const ForgotPasswordInProgress());
  }

  void forgotPasswordEmailChanged(String email) {
    if (state is ForgotPasswordInProgress) {
      final currentState = state as ForgotPasswordInProgress;
      emit(currentState.copyWith(email: email, clearError: true));
    }
  }

  Future<void> submitForgotPassword() async {
    if (state is! ForgotPasswordInProgress) return;

    final currentState = state as ForgotPasswordInProgress;

    // Validate email
    if (currentState.email.isEmpty) {
      if (isClosed) return;
      emit(currentState.copyWith(errorMessage: 'Email is required'));
      return;
    }

    if (!_isValidEmail(currentState.email)) {
      if (isClosed) return;
      emit(currentState.copyWith(errorMessage: 'Please enter a valid email address'));
      return;
    }

    if (isClosed) return;
    emit(currentState.copyWith(isLoading: true, clearError: true));

    final result = await _forgotPasswordUseCase(currentState.email);

    if (isClosed) return;
    result.fold(
      (failure) {
        _showErrorSnackbar('Password Reset Failed', failure.message);
        if (state is ForgotPasswordInProgress) {
          emit((state as ForgotPasswordInProgress).copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ));
        }
      },
      (_) {
        _showSuccessSnackbar(
          'Email Sent!',
          'Check your email for password reset instructions.',
        );
        emit(PasswordResetEmailSent());
      },
    );
  }

  // --- Reset Password Flow ---
  void startResetPassword({required String email, required String token}) {
    emit(ResetPasswordInProgress(email: email, token: token));
  }

  void resetPasswordNewPasswordChanged(String password) {
    if (state is ResetPasswordInProgress) {
      final currentState = state as ResetPasswordInProgress;
      emit(currentState.copyWith(newPassword: password, clearError: true));
    }
  }

  void resetPasswordTokenChanged(String token) {
    if (state is ResetPasswordInProgress) {
      final currentState = state as ResetPasswordInProgress;
      emit(currentState.copyWith(token: token, clearError: true));
    }
  }

  void resetPasswordConfirmPasswordChanged(String password) {
    if (state is ResetPasswordInProgress) {
      final currentState = state as ResetPasswordInProgress;
      emit(currentState.copyWith(confirmPassword: password, clearError: true));
    }
  }

  Future<void> submitResetPassword() async {
    if (state is! ResetPasswordInProgress) return;

    final currentState = state as ResetPasswordInProgress;

    // Validate passwords
    final passwordError = _validatePassword(currentState.newPassword);
    if (passwordError != null) {
      _showErrorSnackbar('Invalid Password', passwordError);
      if (isClosed) return;
      emit(currentState.copyWith(errorMessage: passwordError));
      return;
    }

    if (currentState.newPassword != currentState.confirmPassword) {
      const error = 'Passwords do not match';
      _showErrorSnackbar('Error', error);
      if (isClosed) return;
      emit(currentState.copyWith(errorMessage: error));
      return;
    }

    if (isClosed) return;
    emit(currentState.copyWith(isLoading: true, clearError: true));

    final result = await _resetPasswordUseCase(
      email: currentState.email,
      token: currentState.token,
      newPassword: currentState.newPassword,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        _showErrorSnackbar('Password Reset Failed', failure.message);
        if (state is ResetPasswordInProgress) {
          emit((state as ResetPasswordInProgress).copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ));
        }
      },
      (_) {
        _showSuccessSnackbar(
          'Password Reset!',
          'Your password has been successfully reset. You can now log in.',
        );
        emit(const PasswordResetSuccess());
      },
    );
  }

  // --- Email Verification ---
  Future<void> verifyEmail(String token) async {
    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _verifyEmailUseCase(token);

    if (isClosed) return;
    result.fold(
      (failure) {
        _showErrorSnackbar('Verification Failed', failure.message);
        emit(AuthenticationFailure(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (profile) async {
        await _saveSession(profile);
        _showSuccessSnackbar(
          'Email Verified!',
          'Your email has been successfully verified.',
        );
        emit(EmailVerified(profile));
      },
    );
  }

  Future<void> resendVerificationEmail() async {
    if (_currentProfile == null) {
      _showErrorSnackbar('Error', 'Please sign in first');
      return;
    }

    final email = _currentProfile!.user.email;
    if (email.isEmpty) {
      _showErrorSnackbar('Error', 'No email address found');
      return;
    }

    if (isClosed) return;
    emit(AuthenticationLoading());

    final result = await _resendVerificationUseCase(email: email);

    if (isClosed) return;
    result.fold(
      (failure) {
        _showErrorSnackbar('Failed to Send Email', failure.message);
        emit(AuthenticationFailure(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (_) {
        _showSuccessSnackbar(
          'Email Sent!',
          'Verification email has been resent.',
        );
        // Return to previous success state
        if (_currentProfile != null) {
          emit(AuthenticationSuccess(_currentProfile!));
        } else {
          emit(AuthenticationInitial());
        }
      },
    );
  }

  // --- Update User Profile ---
  void updateCurrentUser(User updatedUser) {
    if (_currentProfile != null) {
      _currentProfile = ProfileEntity(
        user: updatedUser,
        session: _currentProfile!.session,
      );
      emit(AuthenticationSuccess(_currentProfile!));
    }
  }

  // --- Logout ---
  Future<void> logout() async {
    // Mark the logout window so any background op (profile refresh, websocket
    // reconnect, token validation) that fails on the just-cleared session is
    // suppressed instead of popping a noisy auth-error snackbar. Cleared on the
    // next login attempt (startPasscodeLogin / loginWithPasscode / login).
    _isLoggingOut = true;

    // Drop any notification destination stashed for the outgoing user. These
    // targets are account-specific (an invoice id, a chat with a contact), and
    // the stash is a process-lifetime singleton — without this, a push tapped
    // before a user switch would replay into the NEXT user's session and open
    // a record they have no business seeing.
    PendingDeepLink.instance.clear();

    // Snapshot current user's email to stored_email before clearing session,
    // so passcode login screen shows the correct user after logout.
    final currentEmail = _currentProfile?.user.email;
    if (currentEmail != null && currentEmail.isNotEmpty) {
      await _storage.write(key: 'stored_email', value: currentEmail);
    }

    // 1) End any ACTIVE VOICE CALL first — we must never leave a LiveKit room /
    //    voice agent connected against a user who has just logged out and been
    //    routed to the passcode screen. Silent full teardown (no rating screen).
    try {
      if (serviceLocator.isRegistered<VoiceSessionCubit>()) {
        final voice = serviceLocator<VoiceSessionCubit>();
        if (voice.hasActiveVoiceSession) {
          await voice.disconnectFromLiveKitRoom(fullCleanup: true);
        }
      }
    } catch (e) {
      debugPrint('Logout: failed to end voice session (continuing): $e');
    }

    // 2) REVOKE THE SESSION ON THE BACKEND so the JWT/refresh token can't be
    //    replayed — logout must invalidate server-side, not just route to the
    //    passcode screen. Read the tokens BEFORE _clearSession() wipes them.
    //    Best-effort: a network failure here must not block local logout.
    final userId = _currentProfile?.user.id ?? '';
    final refreshToken = _currentProfile?.session.refreshToken ??
        (await _storage.read(key: _refreshTokenKey)) ??
        '';
    if (userId.isNotEmpty || refreshToken.isNotEmpty) {
      final result = await _authRepository.logout(
        userId: userId,
        refreshToken: refreshToken,
      );
      result.fold(
        (f) => debugPrint(
            'Logout: backend revoke failed (continuing local logout): ${f.message}'),
        (_) => debugPrint('Logout: backend session revoked'),
      );
    }

    await _clearSession();
    // Explicit logout revokes the session server-side above. Sweep any LEGACY
    // durable-biometric keys left on old installs (there is no durable token
    // anymore — biometric unlocks the single `refresh_token`, which _clearSession
    // just wiped). The opt-in flag survives, so the next passcode login re-arms
    // biometric unlock automatically.
    try {
      if (serviceLocator.isRegistered<SecureStorageService>()) {
        await serviceLocator<SecureStorageService>().clearBiometricSession();
      }
    } catch (_) {/* best-effort */}
    // Clear currency sync state on logout
    _currencySyncService.clear();
    // Wipe per-user caches owned by long-lived singletons. The group-account
    // cubit is registered as a lazy singleton so its in-memory state outlives
    // the session unless explicitly cleared.
    if (serviceLocator.isRegistered<GroupAccountCubit>()) {
      serviceLocator<GroupAccountCubit>().clearOnLogout();
    }
    // Same reason for the pending-payments aggregator: it is a lazy singleton
    // holding "you owe ₦X" counts. Left alone, the next person to sign in on
    // this device would see the previous user's debts badged on their tiles.
    if (serviceLocator.isRegistered<PendingActionsCubit>()) {
      serviceLocator<PendingActionsCubit>().clear();
    }
    // Re-arm the once-per-run launch prompt so the next user gets their own.
    PendingPaymentsPromptGate.resetForNewSession();
    // Clear the cached FCM-registration flag so the NEXT user to log in on this
    // device re-registers their token (the backend may have dropped this
    // device's tokens on logout, and a stale marker must not skip them).
    if (serviceLocator.isRegistered<PushNotificationsService>()) {
      unawaited(serviceLocator<PushNotificationsService>().clearRegistrationMarker());
    }
    // No logout snackbar (removed per request).
    // Emit PasscodeLoginInProgress instead of AuthenticationInitial
    // to prevent infinite loading spinner on passcode screen
    emit(const PasscodeLoginInProgress());
  }

  // --- Sign Up Flow Methods ---

  /// Start signup flow, loading any existing draft
  Future<void> startSignUp() async {
    // Try to load existing draft
    final draft = await _signupStateService?.loadDraft();

    if (draft != null && draft.hasData && !draft.isExpired) {
      // Restore from draft, deriving country fields from locale
      final countryCode = draft.countryCode ?? 'NG';
      final countryName = draft.countryName ?? 'Nigeria';
      final currencyCode = draft.currencyCode ?? 'NGN';

      emit(SignUpInProgress(
        email: draft.email ?? '',
        firstName: draft.firstName ?? '',
        lastName: draft.lastName ?? '',
        username: draft.username ?? '',
        referralCode: draft.referralCode ?? '',
        selectedDate: draft.dateOfBirth,
        phoneNumber: draft.phone ?? '',
        // Always START on the first page even when a draft is restored, so a
        // previously-started signup never drops the user mid-flow on page 1/2
        // (confusing — they see later fields with no context). The draft FIELDS
        // are still restored above so nothing they typed is lost.
        currentPage: 0,
        primaryContactType: _stringToPrimaryContactType(draft.primaryContactType),
        countryCode: countryCode,
        countryName: countryName,
        currencyCode: currencyCode,
      ));
    } else {
      emit(const SignUpInProgress());
    }
  }

  /// Start signup flow synchronously (for compatibility)
  void startSignUpSync() {
    emit(const SignUpInProgress());
  }

  void cancelSignUp() {
    _draftSaveTimer?.cancel();
    emit(const AuthenticationInitial());
  }

  /// Clear signup draft and state
  Future<void> clearSignupDraft() async {
    _draftSaveTimer?.cancel();
    await _signupStateService?.clearDraft();
  }

  /// Save current signup state to draft (debounced)
  void _scheduleDraftSave() {
    _draftSaveTimer?.cancel();
    _draftSaveTimer = Timer(const Duration(milliseconds: 500), () {
      _saveCurrentStateToDraft();
    });
  }

  /// Save current state to draft immediately
  Future<void> _saveCurrentStateToDraft() async {
    if (_signupStateService == null) return;

    final currentState = state;
    if (currentState is SignUpInProgress) {
      // Build locale from country code (e.g., 'en-NG')
      final locale = currentState.countryCode.isNotEmpty
          ? 'en-${currentState.countryCode.toUpperCase()}'
          : null;

      final draft = SignupDraft(
        email: currentState.email.isNotEmpty ? currentState.email : null,
        phone: currentState.phoneNumber.isNotEmpty ? currentState.phoneNumber : null,
        firstName: currentState.firstName.isNotEmpty ? currentState.firstName : null,
        lastName: currentState.lastName.isNotEmpty ? currentState.lastName : null,
        username: currentState.username.isNotEmpty ? currentState.username : null,
        referralCode: currentState.referralCode.isNotEmpty ? currentState.referralCode : null,
        dateOfBirth: currentState.selectedDate,
        primaryContactType: _primaryContactTypeToString(currentState.primaryContactType),
        currentPage: currentState.currentPage,
        currentStep: currentState.currentPage == 0
            ? SignupDraft.stepFormPage0
            : SignupDraft.stepFormPage1,
        locale: locale,
      );
      await _signupStateService!.saveDraft(draft);
    }
  }

  PrimaryContactType _stringToPrimaryContactType(String? type) {
    switch (type) {
      case 'email':
        return PrimaryContactType.email;
      case 'phone':
        return PrimaryContactType.phone;
      default:
        return PrimaryContactType.none;
    }
  }

  String? _primaryContactTypeToString(PrimaryContactType type) {
    switch (type) {
      case PrimaryContactType.email:
        return 'email';
      case PrimaryContactType.phone:
        return 'phone';
      case PrimaryContactType.none:
        return null;
    }
  }

  void signUpEmailChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(email: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpPasswordChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(password: value, clearErrorMessage: true, isLoading: false));
      // Note: We don't save password to draft for security
    }
  }

  void signUpConfirmPasswordChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(confirmPassword: value, clearErrorMessage: true, isLoading: false));
      // Note: We don't save password to draft for security
    }
  }

  void signUpFirstNameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(firstName: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpLastNameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(lastName: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpUsernameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // Usernames are ALWAYS lowercase (money-safety: the backend lowercases on
      // create + lookup, so the @handle the user sees, stores, and sends must
      // match case-for-case — otherwise a transfer-by-username could miss).
      emit(currentState.copyWith(username: value.toLowerCase(), clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpReferralCodeChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(
        referralCode: value,
        clearErrorMessage: true,
        isLoading: false,
        isReferralCodeValid: null,
        isReferralCodeValidating: false,
      ));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  /// Validate referral code when field loses focus
  Future<void> validateReferralCodeOnBlur() async {
    if (state is! SignUpInProgress) return;
    final currentState = state as SignUpInProgress;
    final code = currentState.referralCode.trim();

    // Skip validation if empty (field is optional)
    if (code.isEmpty) {
      emit(currentState.copyWith(
        isReferralCodeValid: null,
        isReferralCodeValidating: false,
      ));
      return;
    }

    // Show loading spinner
    emit(currentState.copyWith(isReferralCodeValidating: true));

    if (_validateReferralCodeUseCase == null) return;

    final result = await _validateReferralCodeUseCase!(code: code);

    if (isClosed) return;
    if (state is! SignUpInProgress) return;
    final latestState = state as SignUpInProgress;

    result.fold(
      (failure) => emit(latestState.copyWith(
        isReferralCodeValid: false,
        isReferralCodeValidating: false,
      )),
      (isValid) => emit(latestState.copyWith(
        isReferralCodeValid: isValid,
        isReferralCodeValidating: false,
      )),
    );
  }

  void signUpDateOfBirthChanged(DateTime? value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(selectedDate: value, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  void signUpPhoneNumberChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // Format phone number to remove spaces and special characters
      final formattedPhone = _formatPhoneNumber(value);
      emit(currentState.copyWith(phoneNumber: formattedPhone, clearErrorMessage: true, isLoading: false));
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  // ========== COUNTRY & IDENTITY VERIFICATION METHODS ==========

  /// Change selected locale (e.g., 'en-NG', 'en-GH', 'en-KE')
  /// Derives countryCode, countryName, and currencyCode from the locale string
  void signUpLocaleChanged(String? locale) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;

      // Extract country code from locale
      final countryCode = CountryConfigs.getCountryCodeFromLocale(locale) ?? 'NG';
      final countryConfig = CountryConfigs.getByCode(countryCode);

      final countryName = countryConfig?.name ?? 'Nigeria';
      final currencyCode = countryConfig?.currency ?? 'NGN';

      // Also update identity type to match country
      final identityType = _getDefaultIdentityTypeForCountry(countryCode);

      emit(currentState.copyWith(
        countryCode: countryCode,
        countryName: countryName,
        currencyCode: currencyCode,
        identityType: identityType,
        clearErrorMessage: true,
        isLoading: false,
      ));
      _scheduleDraftSave();
    }
  }

  /// Change selected country (Nigeria only for now)
  /// @deprecated Use signUpLocaleChanged instead
  void signUpCountryChanged(String countryCode, String countryName, String currencyCode) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(
        countryCode: countryCode,
        countryName: countryName,
        currencyCode: currencyCode,
        clearErrorMessage: true,
        isLoading: false,
      ));
      _scheduleDraftSave();
    }
  }

  /// Change identity verification type (BVN or NIN)
  void signUpIdentityTypeChanged(IdentityType type) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(
        identityType: type,
        // Clear both fields when switching types
        bvn: type == IdentityType.bvn ? currentState.bvn : '',
        nin: type == IdentityType.nin ? currentState.nin : '',
        bvnVerified: false,
        clearErrorMessage: true,
        isLoading: false,
      ));
    }
  }

  /// Change BVN value
  void signUpBvnChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // Remove any non-digit characters
      final cleanedBvn = value.replaceAll(RegExp(r'[^0-9]'), '');
      emit(currentState.copyWith(
        bvn: cleanedBvn,
        bvnVerified: false, // Reset verification when BVN changes
        clearErrorMessage: true,
        isLoading: false,
      ));
    }
  }

  /// Change NIN value
  void signUpNinChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // Remove any non-digit characters
      final cleanedNin = value.replaceAll(RegExp(r'[^0-9]'), '');
      emit(currentState.copyWith(
        nin: cleanedNin,
        bvnVerified: false, // Reset verification when NIN changes
        clearErrorMessage: true,
        isLoading: false,
      ));
    }
  }

  /// Change generic identity value (for non-NG countries)
  void signUpIdentityValueChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(
        identityValue: value,
        bvnVerified: false, // Reset verification when identity value changes
        clearErrorMessage: true,
        isLoading: false,
      ));
    }
  }

  /// Validate BVN format (must be exactly 11 digits)
  String? _validateBvn(String bvn) {
    if (bvn.isEmpty) return 'BVN is required';
    if (bvn.length != 11) return 'BVN must be exactly 11 digits';
    if (!RegExp(r'^\d{11}$').hasMatch(bvn)) return 'BVN must contain only numbers';
    return null;
  }

  /// Validate NIN format (must be exactly 11 digits)
  String? _validateNin(String nin) {
    if (nin.isEmpty) return 'NIN is required';
    if (nin.length != 11) return 'NIN must be exactly 11 digits';
    if (!RegExp(r'^\d{11}$').hasMatch(nin)) return 'NIN must contain only numbers';
    return null;
  }

  /// Get identity value based on identity type
  String _getIdentityValueForType(SignUpInProgress state) {
    switch (state.identityType) {
      case IdentityType.bvn:
        return state.bvn;
      case IdentityType.nin:
        return state.nin;
      default:
        return state.identityValue;
    }
  }

  /// Validate identity value based on country and type
  String? _validateIdentityValue(String countryCode, IdentityType identityType, String value) {
    if (value.isEmpty) {
      return '${identityType.displayName} is required';
    }

    switch (identityType) {
      case IdentityType.bvn:
        return _validateBvn(value);
      case IdentityType.nin:
        return _validateNin(value);
      case IdentityType.ssn:
        if (value.length != 4 || !RegExp(r'^\d{4}$').hasMatch(value)) {
          return 'SSN must be exactly 4 digits';
        }
        return null;
      case IdentityType.saId:
        if (value.length != 13 || !RegExp(r'^\d{13}$').hasMatch(value)) {
          return 'South African ID must be exactly 13 digits';
        }
        return null;
      case IdentityType.kenyaNationalId:
        if (value.length < 7 || value.length > 8 || !RegExp(r'^\d+$').hasMatch(value)) {
          return 'Kenya National ID must be 7-8 digits';
        }
        return null;
      case IdentityType.ghanaCard:
        // Ghana Card format: GHA-XXXXXXXXX-X
        if (!RegExp(r'^GHA-\d{9}-\d$').hasMatch(value) && value.length < 10) {
          return 'Please enter a valid Ghana Card number';
        }
        return null;
      case IdentityType.passport:
      case IdentityType.usPassport:
      case IdentityType.ghanaPassport:
      case IdentityType.kenyaPassport:
      case IdentityType.saPassport:
        if (value.length < 6) {
          return 'Passport number must be at least 6 characters';
        }
        return null;
      case IdentityType.drivingLicence:
        if (value.length < 8) {
          return 'Driving licence number must be at least 8 characters';
        }
        return null;
      case IdentityType.stateId:
      case IdentityType.ghanaVoterId:
        if (value.length < 6) {
          return 'ID number must be at least 6 characters';
        }
        return null;
    }
  }

  /// Map identity type enum to backend string format
  String _getIdentityTypeString(IdentityType type) {
    switch (type) {
      case IdentityType.bvn:
        return 'bvn';
      case IdentityType.nin:
        return 'nin';
      case IdentityType.ssn:
        return 'ssn';
      case IdentityType.passport:
        return 'uk_passport';
      case IdentityType.drivingLicence:
        return 'uk_driving_licence';
      case IdentityType.usPassport:
        return 'us_passport';
      case IdentityType.stateId:
        return 'us_state_id';
      case IdentityType.ghanaCard:
        return 'ghana_card';
      case IdentityType.ghanaVoterId:
        return 'ghana_voter_id';
      case IdentityType.ghanaPassport:
        return 'ghana_passport';
      case IdentityType.kenyaNationalId:
        return 'kenya_national_id';
      case IdentityType.kenyaPassport:
        return 'kenya_passport';
      case IdentityType.saId:
        return 'sa_id';
      case IdentityType.saPassport:
        return 'sa_passport';
    }
  }

  /// Map country code to locale string
  String _getLocaleForCountry(String countryCode) {
    switch (countryCode) {
      case 'NG':
        return 'en-NG';
      case 'GH':
        return 'en-GH';
      case 'KE':
        return 'en-KE';
      case 'ZA':
        return 'en-ZA';
      case 'GB':
        return 'en-GB';
      case 'US':
        return 'en-US';
      default:
        return 'en-NG'; // Default to Nigeria
    }
  }

  /// Verify identity with backend - supports multi-country verification
  /// This calls the auth service which connects to banking service to verify identity
  Future<void> verifyIdentity() async {
    if (state is! SignUpInProgress) return;

    final currentState = state as SignUpInProgress;

    // Get identity value based on identity type
    final identityNumber = _getIdentityValueForType(currentState);

    // Validate format based on country and identity type
    final error = _validateIdentityValue(currentState.countryCode, currentState.identityType, identityNumber);

    if (error != null) {
      _showErrorSnackbar('Validation Error', error);
      emit(currentState.copyWith(errorMessage: error));
      return;
    }

    // Validate date of birth is set (required for most verifications)
    if (currentState.selectedDate == null) {
      _showErrorSnackbar('Validation Error', 'Date of birth is required for verification');
      emit(currentState.copyWith(errorMessage: 'Date of birth is required'));
      return;
    }

    if (isClosed) return;
    emit(currentState.copyWith(isLoading: true, clearErrorMessage: true));

    try {
      // Format date as YYYY-MM-DD
      final dob = currentState.selectedDate!;
      final formattedDob = '${dob.year}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}';

      // Map identity type to backend format
      final identityTypeString = _getIdentityTypeString(currentState.identityType);

      // Call the actual backend endpoint via use case
      final result = await _verifyIdentityUseCase(
        identityType: identityTypeString,
        identityNumber: identityNumber,
        dateOfBirth: formattedDob,
        countryCode: currentState.countryCode,
      );

      if (isClosed) return;

      result.fold(
        (failure) {
          final errorMsg = failure.message;
          _showErrorSnackbar('Verification Failed', errorMsg);
          emit(currentState.copyWith(
            isLoading: false,
            bvnVerified: false,
            errorMessage: errorMsg,
          ));
        },
        (verificationResult) {
          if (verificationResult.verified) {
            emit(currentState.copyWith(
              isLoading: false,
              bvnVerified: true,
              verifiedFirstName: verificationResult.firstName ?? currentState.firstName,
              verifiedLastName: verificationResult.lastName ?? currentState.lastName,
              verifiedDateOfBirth: verificationResult.dateOfBirth ?? formattedDob,
              clearErrorMessage: true,
            ));

            _showSuccessSnackbar(
              'Identity Verified!',
              'Your ${currentState.identityType.displayName} has been verified successfully.',
            );

            // Create virtual account after successful identity verification
            // This is done in the background and won't block the signup flow
            _createVirtualAccountAfterVerification();

            // Navigate directly to email verification - email will be sent when page loads
            final email = currentState.email;
            final phoneNumber = currentState.phoneNumber;

            // Determine if secondary verification is needed
            final hasSecondaryPhone = phoneNumber.isNotEmpty;

            // Persist the step so a quit here resumes at email verification.
            // Fire-and-forget (this fold callback is sync), like the virtual
            // account creation above; the write completes before backgrounding.
            _signupStateService?.markAccountCreated();
            // Navigate to email verification (codeSent: false - page will send email on load)
            Get.offAllNamed(AppRoutes.emailVerification, arguments: {
              'email': email,
              'codeSent': false,
              'isRequired': true,
              'secondaryPhone': hasSecondaryPhone ? phoneNumber : null,
            });
          } else {
            _showErrorSnackbar('Verification Failed', 'Identity could not be verified');
            emit(currentState.copyWith(
              isLoading: false,
              bvnVerified: false,
              errorMessage: 'Identity could not be verified',
            ));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      final errorMsg = 'Failed to verify identity: ${e.toString()}';
      _showErrorSnackbar('Verification Failed', errorMsg);
      emit(currentState.copyWith(
        isLoading: false,
        bvnVerified: false,
        errorMessage: errorMsg,
      ));
    }
  }

  /// Create virtual account after successful identity verification
  /// This creates a real virtual NUBAN account via Flutterwave/VFD provider
  Future<void> _createVirtualAccountAfterVerification() async {
    if (_createVirtualAccountUseCase == null) {
      print('Virtual account use case not available - skipping');
      return;
    }

    if (state is! SignUpInProgress) return;
    final currentState = state as SignUpInProgress;

    // Only create for Nigerian users with verified BVN
    if (currentState.countryCode != 'NG') {
      print('Virtual accounts only supported for Nigeria (current: ${currentState.countryCode})');
      return;
    }

    // Get BVN from state - use identityValue which holds the verified ID number
    final bvn = currentState.bvn.isNotEmpty
        ? currentState.bvn
        : currentState.identityValue;

    if (bvn.isEmpty || bvn.length < 10) {
      print('BVN not available or invalid - skipping virtual account creation');
      return;
    }

    // Derive locale from country code
    final locale = _getLocaleForCountry(currentState.countryCode);

    try {
      print('Creating virtual account for ${currentState.email}...');

      final result = await _createVirtualAccountUseCase!(
        accountName: '${currentState.firstName} ${currentState.lastName}',
        accountType: 'personal',
        currency: currentState.currencyCode,
        locale: locale,
        email: currentState.email,
        firstName: currentState.firstName,
        lastName: currentState.lastName,
        phoneNumber: currentState.phoneNumber,
        bvn: bvn,
        isPrimary: true,
      );

      result.fold(
        (failure) {
          print('Failed to create virtual account: ${failure.message}');
          // Don't block the signup flow if virtual account creation fails
          // The user can still use the app with a basic account
          _showErrorSnackbar(
            'Account Created',
            'Your account has been created. Virtual account setup will complete shortly.',
          );
        },
        (virtualAccount) {
          print('Virtual account created successfully: ${virtualAccount.accountNumber} via ${virtualAccount.provider}');
          _showSuccessSnackbar(
            'Account Created',
            'Your virtual NUBAN account (${virtualAccount.accountNumber}) is ready to receive payments.',
          );
        },
      );
    } catch (e) {
      print('Error creating virtual account: $e');
      // Don't block signup flow
    }
  }

  /// Unified method to handle email or phone number input
  /// Intelligently detects whether input is an email or phone number
  void signUpEmailOrPhoneChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      final trimmedValue = value.trim();

      // Detect if input looks like an email or phone number
      final isEmail = _looksLikeEmail(trimmedValue);
      final isPhone = _looksLikePhone(trimmedValue);

      if (isEmail) {
        // Store as email and set primary contact type
        emit(currentState.copyWith(
          email: trimmedValue,
          phoneNumber: '', // Clear phone
          primaryContactType: PrimaryContactType.email,
          clearErrorMessage: true,
          isLoading: false,
        ));
      } else if (isPhone) {
        // Store as phone and set primary contact type
        final formattedPhone = _formatPhoneNumber(trimmedValue);
        emit(currentState.copyWith(
          phoneNumber: formattedPhone,
          email: '', // Clear email
          primaryContactType: PrimaryContactType.phone,
          clearErrorMessage: true,
          isLoading: false,
        ));
      } else {
        // Input is ambiguous - store in both fields temporarily
        // and let validation determine the type later
        // If it contains @ it's likely email, otherwise treat as phone
        if (trimmedValue.contains('@')) {
          emit(currentState.copyWith(
            email: trimmedValue,
            phoneNumber: '',
            primaryContactType: PrimaryContactType.email,
            clearErrorMessage: true,
            isLoading: false,
          ));
        } else if (trimmedValue.isNotEmpty && RegExp(r'^[0-9+\-\s()]+$').hasMatch(trimmedValue)) {
          // Contains only phone-like characters
          emit(currentState.copyWith(
            phoneNumber: _formatPhoneNumber(trimmedValue),
            email: '',
            primaryContactType: PrimaryContactType.phone,
            clearErrorMessage: true,
            isLoading: false,
          ));
        } else {
          // Default to email field (most common)
          emit(currentState.copyWith(
            email: trimmedValue,
            primaryContactType: trimmedValue.isEmpty ? PrimaryContactType.none : PrimaryContactType.email,
            clearErrorMessage: true,
            isLoading: false,
          ));
        }
      }
      _scheduleDraftSave();
    }
  }

  /// Check if input looks like an email address
  bool _looksLikeEmail(String value) {
    if (value.isEmpty) return false;
    // Simple check: contains @ and has text before and after
    return value.contains('@') &&
           value.indexOf('@') > 0 &&
           value.indexOf('@') < value.length - 1;
  }

  /// Check if input looks like a phone number
  bool _looksLikePhone(String value) {
    if (value.isEmpty) return false;
    // Remove common phone formatting characters
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
    // Check if remaining characters are mostly digits (allowing for some letters in some formats)
    final digitCount = cleaned.replaceAll(RegExp(r'[^0-9]'), '').length;
    return digitCount >= 7 && digitCount <= 15 && digitCount / cleaned.length > 0.8;
  }

  /// Get the current primary contact value (email or phone) for display
  String get currentPrimaryContactValue {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      if (currentState.primaryContactType == PrimaryContactType.phone) {
        return currentState.phoneNumber;
      }
      return currentState.email;
    }
    return '';
  }

  // New method to set primary contact type (email or phone)
  void signUpSetPrimaryContactType(PrimaryContactType type) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      // When switching types, clear the data for the previous type
      if (type == PrimaryContactType.email) {
        emit(currentState.copyWith(
          primaryContactType: type,
          phoneNumber: '', // Clear phone if switching to email
          clearErrorMessage: true,
        ));
      } else if (type == PrimaryContactType.phone) {
        emit(currentState.copyWith(
          primaryContactType: type,
          email: '', // Clear email if switching to phone
          clearErrorMessage: true,
        ));
      }
      _scheduleDraftSave(); // Auto-save draft
    }
  }

  /// Signup flow pages:
  /// Page 0: Country Selection (Nigeria only for now)
  /// Page 1: Phone (primary contact, country chip + SIM hint) + Password
  /// Page 2: Personal Info (First Name, Last Name, DOB) + optional Email
  /// BVN verification: progressive KYC after passcode/PIN (not on signup).
  Future<void> signUpNextPage() async {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;

      if (currentState.currentPage == 0) {
        // ========== PAGE 0: Country Selection ==========
        // For now, only Nigeria is supported
        if (currentState.countryCode.isEmpty) {
          final errorMsg = 'Please select your country';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Validate country is in supported list
        final supportedCountries = ['NG', 'GB', 'US', 'GH', 'KE', 'ZA'];
        if (!supportedCountries.contains(currentState.countryCode)) {
          final errorMsg = 'Selected country is not currently supported. Please choose from: Nigeria, UK, USA, Ghana, Kenya, or South Africa.';
          _showErrorSnackbar('Country Not Supported', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Proceed to page 1
        if (isClosed) return;
        emit(currentState.copyWith(currentPage: 1, clearErrorMessage: true));
        return;
      } else if (currentState.currentPage == 1) {
        // ========== PAGE 1: Phone (primary) + Password ==========
        // Phone is now the PRIMARY contact, captured here with a country chip
        // + per-country length check + SIM-hint prefill (the widget stamps the
        // value as E.164 via signUpPhoneNumberChanged before we run). Email is
        // an optional secondary contact collected on page 2.
        if (currentState.phoneNumber.isEmpty) {
          const errorMsg = 'Phone number is required';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        if (!_isValidPhoneNumber(currentState.phoneNumber)) {
          const errorMsg = 'Please enter a valid phone number';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Validate password
        if (currentState.password.isEmpty) {
          final errorMsg = 'Password is required';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        final passwordError = _validatePassword(currentState.password);
        if (passwordError != null) {
          _showErrorSnackbar('Password Requirements', passwordError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: passwordError));
          return;
        }

        if (currentState.confirmPassword.isEmpty) {
          final errorMsg = 'Please confirm your password';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        if (currentState.password != currentState.confirmPassword) {
          final errorMsg = 'Passwords do not match';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Phone is always the primary contact in this flow — stamp it so the
        // backend signup + post-signup verification routing pick the phone-OTP
        // path. Advance to page 2 (personal info + optional email).
        if (isClosed) return;
        emit(currentState.copyWith(
          currentPage: 2,
          primaryContactType: PrimaryContactType.phone,
          clearErrorMessage: true,
          isLoading: false,
        ));
        return;
      } else if (currentState.currentPage == 2) {
        // ========== PAGE 2: Personal Info ==========
        final firstNameError = _validateName(currentState.firstName, 'First name');
        if (firstNameError != null) {
          _showErrorSnackbar('Validation Error', firstNameError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: firstNameError));
          return;
        }

        final lastNameError = _validateName(currentState.lastName, 'Last name');
        if (lastNameError != null) {
          _showErrorSnackbar('Validation Error', lastNameError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: lastNameError));
          return;
        }

        final dobError = _validateDateOfBirth(currentState.selectedDate);
        if (dobError != null) {
          _showErrorSnackbar('Validation Error', dobError);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: dobError));
          return;
        }

        // Secondary contact validation. Phone (the primary contact) was already
        // captured + validated on page 1, so here we only validate the OPTIONAL
        // email's format when the user actually provided one. An empty email is
        // fine — it's a secondary contact for password-reset / recovery only.
        if (currentState.email.isNotEmpty && !_isValidEmail(currentState.email)) {
          final errorMsg = 'Please enter a valid email address';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg));
          return;
        }

        // Validate username if provided (optional field)
        if (currentState.username.isNotEmpty) {
          final cleanUsername = currentState.username.trim().replaceAll(RegExp(r'^@'), '').toLowerCase();
          if (cleanUsername.length < 3) {
            const errorMsg = 'Username must be at least 3 characters';
            _showErrorSnackbar('Validation Error', errorMsg);
            if (isClosed) return;
            emit(currentState.copyWith(errorMessage: errorMsg));
            return;
          }
          if (cleanUsername.length > 30) {
            const errorMsg = 'Username must be at most 30 characters';
            _showErrorSnackbar('Validation Error', errorMsg);
            if (isClosed) return;
            emit(currentState.copyWith(errorMessage: errorMsg));
            return;
          }
          if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(cleanUsername)) {
            const errorMsg = 'Username can only contain letters, numbers, and underscores';
            _showErrorSnackbar('Validation Error', errorMsg);
            if (isClosed) return;
            emit(currentState.copyWith(errorMessage: errorMsg));
            return;
          }
        }

        // If an optional email was provided, make sure it isn't already
        // registered before we attempt signup (this moved here from page 1
        // along with the email field). Empty email skips the check entirely.
        if (currentState.email.isNotEmpty) {
          if (isClosed) return;
          emit(currentState.copyWith(isLoading: true, clearErrorMessage: true));

          final availability = await _checkEmailAvailabilityUseCase(email: currentState.email);

          if (isClosed) return;

          final bool emailOk = availability.fold(
            (failure) {
              const errorMsg = 'Failed to verify email availability. Please try again.';
              _showErrorSnackbar('Connection Error', errorMsg);
              emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
              return false;
            },
            (isAvailable) {
              if (!isAvailable) {
                const errorMsg = 'This email is already registered. Use a different email or leave it blank.';
                _showErrorSnackbar('Email Already Exists', errorMsg);
                emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
                return false;
              }
              return true;
            },
          );

          if (!emailOk) return;
        }

        // Create account; BVN/NIN verification happens in progressive KYC after passcode/PIN.
        if (isClosed) return;
        emit(currentState.copyWith(isLoading: true, clearErrorMessage: true));

        // Determine primary contact for backend
        final primaryContact = currentState.primaryContactType == PrimaryContactType.phone
            ? SignupPrimaryContact.phone
            : SignupPrimaryContact.email;

        // Construct locale from countryCode (e.g., "NG" -> "en-NG")
        final locale = currentState.countryCode.isNotEmpty
            ? 'en-${currentState.countryCode.toUpperCase()}'
            : null;

        // Clean username: strip @ prefix before sending to API (backend also does this)
        final cleanedUsername = currentState.username.isNotEmpty
            ? currentState.username.trim().replaceAll(RegExp(r'^@'), '').toLowerCase()
            : null;

        final signupResult = await _signUpUseCase(
          firstName: currentState.firstName,
          lastName: currentState.lastName,
          email: currentState.email,
          password: currentState.password,
          primaryContact: primaryContact,
          phoneNumber: currentState.phoneNumber.isEmpty ? null : currentState.phoneNumber,
          username: cleanedUsername,
          referralCode: currentState.referralCode.isEmpty ? null : currentState.referralCode,
          locale: locale,
          bvn: null,
          nin: null,
        );

        if (isClosed) return;

        signupResult.fold(
          (failure) {
            print('Error during signup: ${failure.message}');
            _showErrorSnackbar('Sign Up Failed', failure.message);
            emit(currentState.copyWith(
              isLoading: false,
              errorMessage: failure.message,
            ));
          },
          (profile) async {
            await _saveSession(profile);
            _currentProfile = profile;
            // Persist the post-account-creation step so quitting during email
            // verification resumes there (not the signup form). Clears the local
            // draft; keeps has_incomplete_signup + pins EMAIL_PASSWORD.
            await _signupStateService?.markAccountCreated();
            if (isClosed) return;
            emit(currentState.copyWith(
              isLoading: false,
              clearErrorMessage: true,
              accountCreated: true,
            ));
            emit(UserCreated());
          },
        );
        return;
      }
    }
  }

  void signUpPreviousPage() {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      if (currentState.currentPage > 0) {
        emit(currentState.copyWith(currentPage: currentState.currentPage - 1, clearErrorMessage: true));
      }
    }
  }

  Future<void> signUpSubmitted() async {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;

      // If account was already created during ID verification, just proceed
      if (currentState.accountCreated) {
        // Account already exists, tokens are saved, just emit UserCreated
        emit(UserCreated());
        return;
      }

      // Comprehensive validation before submission
      // Email validation - required only if email is primary contact
      if (currentState.primaryContactType == PrimaryContactType.email ||
          currentState.primaryContactType == PrimaryContactType.none) {
        // Email is primary - must be valid
        if (!_isValidEmail(currentState.email)) {
          final errorMsg = 'Please enter a valid email address';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
          return;
        }
      } else {
        // Phone is primary - email is optional, only validate format if provided
        if (currentState.email.isNotEmpty && !_isValidEmail(currentState.email)) {
          final errorMsg = 'Please enter a valid email address';
          _showErrorSnackbar('Validation Error', errorMsg);
          if (isClosed) return;
          emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
          return;
        }
      }

      final passwordError = _validatePassword(currentState.password);
      if (passwordError != null) {
        _showErrorSnackbar('Password Requirements', passwordError);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: passwordError, isLoading: false));
        return;
      }

      if (currentState.password != currentState.confirmPassword) {
        final errorMsg = 'Passwords do not match';
        _showErrorSnackbar('Validation Error', errorMsg);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
        return;
      }

      final firstNameError = _validateName(currentState.firstName, 'First name');
      if (firstNameError != null) {
        _showErrorSnackbar('Validation Error', firstNameError);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: firstNameError, isLoading: false));
        return;
      }

      final lastNameError = _validateName(currentState.lastName, 'Last name');
      if (lastNameError != null) {
        _showErrorSnackbar('Validation Error', lastNameError);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: lastNameError, isLoading: false));
        return;
      }

      final dobError = _validateDateOfBirth(currentState.selectedDate);
      if (dobError != null) {
        _showErrorSnackbar('Validation Error', dobError);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: dobError, isLoading: false));
        return;
      }

      // Phone is REQUIRED at signup — it lives at the bottom of page 2
      // (with country chip + SIM-hint prefill). Empty phone fails the
      // format check below ("must start with +"), so we just call the
      // optional-format helper and surface its error. The cubit's phone
      // state is stamped as E.164 by the sign_up.dart widget before it
      // calls signUpPhoneNumberChanged().
      if (currentState.phoneNumber.isEmpty) {
        const errorMsg = 'Phone number is required';
        _showErrorSnackbar('Validation Error', errorMsg);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: errorMsg, isLoading: false));
        return;
      }
      final phoneError = _validateOptionalPhoneNumber(currentState.phoneNumber);
      if (phoneError != null) {
        _showErrorSnackbar('Validation Error', phoneError);
        if (isClosed) return;
        emit(currentState.copyWith(errorMessage: phoneError, isLoading: false));
        return;
      }

      if (currentState.isLoading) return;
      if (isClosed) return;
      emit(currentState.copyWith(isLoading: true, clearErrorMessage: true));

      // Navigate directly to email verification - email will be sent when page loads
      final email = currentState.email;
      final phoneNumber = currentState.phoneNumber;

      // Determine if secondary verification is needed
      final hasSecondaryPhone = phoneNumber.isNotEmpty;

      // Persist the step so a quit here resumes at email verification.
      await _signupStateService?.markAccountCreated();
      // Navigate to email verification (codeSent: false - page will send email on load)
      Get.offAllNamed(AppRoutes.emailVerification, arguments: {
        'email': email,
        'codeSent': false,
        'isRequired': true,
        'secondaryPhone': hasSecondaryPhone ? phoneNumber : null,
      });
    } else {
      print('Cannot submit sign up from current state: $state');
      if (isClosed) return;
      emit(AuthenticationFailure("Cannot submit sign up from current state.", statusCode: 400));
    }
  }

  // --- Helper Methods ---
  bool _isValidEmail(String email) {
    // Production-grade email validation
    // Requires: user@domain.tld format (must have at least one dot in domain)
    // This prevents typos like "user@gmailcom" instead of "user@gmail.com"
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$',
      // Note: Changed * to + at the end to require at least one dot in domain
    );
    return email.isNotEmpty && emailRegex.hasMatch(email) && email.length <= 254;
  }

  bool _isValidPhoneNumber(String phone) {
    // Validate phone number - expects E.164 format from IntlPhoneField
    // E.164 format: +[country code][number] (e.g., +12345678901)
    if (phone.isEmpty) return false;

    // Remove any whitespace
    final cleanPhone = phone.replaceAll(RegExp(r'\s+'), '');

    // Check if it starts with + and has 7-15 digits (E.164 standard)
    final phoneRegex = RegExp(r'^\+[1-9]\d{6,14}$');
    return phoneRegex.hasMatch(cleanPhone);
  }

  String? _validatePassword(String password) {
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Password must be at least 8 characters';
    if (password.length > 128) return 'Password is too long (max 128 characters)';

    // Check for uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for digit
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }

    // Check for special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\\/;`~]').hasMatch(password)) {
      return 'Password must contain at least one special character';
    }

    return null; // Password is valid
  }

  // Validates phone number only if provided (for optional secondary contact)
  String? _validateOptionalPhoneNumber(String phoneNumber) {
    // If empty, it's valid (optional field)
    if (phoneNumber.isEmpty) return null;

    // If provided, validate the format
    // IntlPhoneField already validates and formats phone numbers
    // Just ensure it starts with + and has reasonable length
    if (!phoneNumber.startsWith('+')) {
      return 'Please select a country code for your phone number';
    }

    if (phoneNumber.length < 8) {
      return 'Please enter a complete phone number';
    }

    return null; // Phone number is valid
  }

  String _formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters except +
    return phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
  }

  String? _validateName(String name, String fieldName) {
    if (name.isEmpty) return '$fieldName is required';
    if (name.length < 2) return '$fieldName must be at least 2 characters';
    if (name.length > 255) return '$fieldName is too long (max 255 characters)';

    // Allow letters, spaces, hyphens, and apostrophes
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(name)) {
      return '$fieldName can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null; // Name is valid
  }

  String? _validateDateOfBirth(DateTime? dob) {
    if (dob == null) return 'Date of birth is required';

    final now = DateTime.now();
    final age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1);

    if (age < 13) {
      return 'You must be at least 13 years old to sign up';
    }

    if (age > 150) {
      return 'Please enter a valid date of birth';
    }

    return null; // Date of birth is valid
  }

  /// Get the default identity type for a country
  IdentityType _getDefaultIdentityTypeForCountry(String countryCode) {
    switch (countryCode) {
      case 'NG':
        return IdentityType.bvn;
      case 'GB':
        return IdentityType.passport;
      case 'US':
        return IdentityType.ssn;
      case 'GH':
        return IdentityType.ghanaCard;
      case 'KE':
        return IdentityType.kenyaNationalId;
      case 'ZA':
        return IdentityType.saId;
      default:
        return IdentityType.bvn;
    }
  }

  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withValues(alpha: 0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      borderRadius: 10,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  void _showErrorSnackbar(String title, String message) {
    // Suppress auth-error snackbars triggered by an intentional logout — a
    // background op failing on the just-cleared session must not pop an error
    // over the "come back soon" message. Legitimate login errors still show
    // because _isLoggingOut is only ever true during logout().
    if (_isLoggingOut) return;
    // Error haptic on EVERY error snackbar — validation and API alike. Previously
    // only page-2 phone validation buzzed (the UI called Haptics.error directly),
    // so all other signup validation errors (email/password/name/DOB/username/
    // country) showed the snackbar with no vibration. Centralising it here makes
    // the haptic fire consistently wherever an error snackbar is shown.
    Haptics.error();
    // GetX shows ONE snackbar at a time and drops a new one while another is
    // still on screen — so a second validation error (e.g. user re-taps Continue
    // after fixing one field) could silently not appear. Close any open snackbar
    // first so the latest error always shows.
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withValues(alpha: 0.9),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
      borderRadius: 10,
      icon: const Icon(Icons.error, color: Colors.white),
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  /// Dedicated, themed "come back soon" snackbar shown only on intentional
  /// logout. Matches the dashboard account-cards-summary look: dark card
  /// (#1F1F1F) with the brand-purple gradient (#5B45C9 -> #3D2F8B) accent and
  /// an animated fade/slide-in on the message. Kept brief (2.5s).
  // --- Passcode Setup Flow Methods ---
  void startPasscodeSetup() {
    emit(const PasscodeSetupInProgress());
  }

  void passcodeSetupDigitEntered(String digit) {
    if (state is PasscodeSetupInProgress) {
      final currentState = state as PasscodeSetupInProgress;
      if (currentState.enteredPasscode.length < 6) {
        final newPasscode = currentState.enteredPasscode + digit;
        emit(currentState.copyWith(enteredPasscode: newPasscode, clearError: true));

        // Auto-submit when 6 digits entered
        if (newPasscode.length == 6) {
          _handlePasscodeSetupComplete(newPasscode);
        }
      }
    }
  }

  void passcodeSetupBackspace() {
    if (state is PasscodeSetupInProgress) {
      final currentState = state as PasscodeSetupInProgress;
      if (currentState.enteredPasscode.isNotEmpty) {
        final newPasscode = currentState.enteredPasscode.substring(
          0,
          currentState.enteredPasscode.length - 1,
        );
        emit(currentState.copyWith(enteredPasscode: newPasscode, clearError: true));
      }
    }
  }

  void _handlePasscodeSetupComplete(String passcode) {
    if (state is PasscodeSetupInProgress) {
      final currentState = state as PasscodeSetupInProgress;

      if (!currentState.isConfirmMode) {
        // Reject weak passcodes up front (before asking to confirm) so users
        // can't set 111111 / 123456 etc. — same policy as the Settings flow.
        if (isWeakNumericCode(passcode)) {
          emit(const PasscodeSetupInProgress(
            errorMessage:
                'Choose a less predictable passcode (avoid 111111 or 123456).',
          ));
          return;
        }
        // First entry - ask for confirmation
        emit(PasscodeSetupInProgress(
          isConfirmMode: true,
          initialPasscode: passcode,
          enteredPasscode: '',
        ));
      } else {
        // Confirmation mode - check if they match
        if (passcode == currentState.initialPasscode) {
          _registerPasscodeFromSetup(passcode);
        } else {
          _showErrorSnackbar('Error', 'Passcodes do not match. Please try again.');
          emit(const PasscodeSetupInProgress()); // Reset to initial mode
        }
      }
    }
  }

  Future<void> _registerPasscodeFromSetup(String passcode) async {
    if (state is! PasscodeSetupInProgress) return;

    final currentState = state as PasscodeSetupInProgress;
    if (isClosed) return;
    emit(currentState.copyWith(isRegistering: true, clearError: true));

    // Store passcode locally
    try {
      await _storage.write(key: 'user_passcode', value: passcode);
    } catch (e) {
      print('Error storing passcode locally: $e');
    }

    // Call backend API. Bounded with a timeout: RegisterPasscode is issued with
    // no gRPC deadline (CallOptions from withAuth() carry none) and the channel's
    // keepalive keeps a stalled-but-live connection open, so without this a hung
    // RPC would leave `isRegistering` true and spin the confirm screen forever.
    // Any timeout/throw resets the flag so the user can retry.
    final Either<Failure, void> result;
    try {
      result = await _registerPasscodeUseCase(passcode: passcode)
          .timeout(const Duration(seconds: 20));
    } on TimeoutException {
      if (isClosed) return;
      _showErrorSnackbar('Passcode Registration Failed',
          'The request timed out. Check your connection and try again.');
      emit(PasscodeSetupInProgress(
        isConfirmMode: true,
        initialPasscode: currentState.initialPasscode,
        errorMessage: 'Request timed out. Please try again.',
        isRegistering: false,
      ));
      return;
    } catch (e) {
      if (isClosed) return;
      _showErrorSnackbar(
          'Passcode Registration Failed', 'Something went wrong. Please try again.');
      emit(PasscodeSetupInProgress(
        isConfirmMode: true,
        initialPasscode: currentState.initialPasscode,
        errorMessage: 'Something went wrong. Please try again.',
        isRegistering: false,
      ));
      return;
    }

    if (isClosed) return;
    result.fold(
      (failure) {
        _showErrorSnackbar('Passcode Registration Failed', failure.message);
        emit(PasscodeSetupInProgress(
          errorMessage: failure.message,
          isRegistering: false,
        ));
      },
      (_) async {
        // Store login method preference
        await _storage.write(key: 'login_method', value: 'passcode');
        // The user JUST set a passcode — record it locally as authoritative so
        // the passcode lock recognises them even if a later GetMe echoes a stale
        // hasPasscode=false (the source of the "app lock → login page" bug).
        await _storage.write(key: 'has_passcode', value: 'true');
        if (_currentProfile != null) {
          await _storage.write(key: 'stored_email', value: _currentProfile!.user.email);
        }

        // Mark signup as complete (passcode is the final step)
        await _signupStateService?.markSignupComplete();

        // Flag KYC onboarding as pending for new signups
        await _storage.write(key: 'kyc_onboarding_pending', value: 'true');

        // Create default stablecoin wallets in background
        _triggerBackgroundWalletCreation();

        _showSuccessSnackbar('Success!', 'Passcode registered successfully');

        // Navigate to dashboard by emitting success
        if (_currentProfile != null) {
          emit(AuthenticationSuccess(_currentProfile!));
        } else {
          emit(AuthenticationInitial());
        }
      },
    );
  }

  void _triggerBackgroundWalletCreation() {
    // No-op: LazerVault is a distributor — crypto custody is managed by Quidax.
    // User sub-accounts are created on-demand when they first buy/sell crypto.
  }

  Future<void> skipPasscodeSetup() async {
    // Mark signup as complete even when skipping passcode
    await _signupStateService?.markSignupComplete();

    // Flag KYC onboarding as pending, same as the register path — a user who
    // SKIPS passcode setup is still a new signup that must be offered KYC on
    // reaching the dashboard (previously only the register branch set this, so
    // passcode-skippers silently missed the onboarding KYC gate).
    await _storage.write(key: 'kyc_onboarding_pending', value: 'true');

    // Create default stablecoin wallets in background
    _triggerBackgroundWalletCreation();

    // Emit success to navigate to dashboard
    if (_currentProfile != null) {
      emit(AuthenticationSuccess(_currentProfile!));
    } else {
      emit(AuthenticationInitial());
    }
  }

  // --- Passcode Login Flow Methods ---
  void startPasscodeLogin() {
    emit(const PasscodeLoginInProgress());
  }

  void passcodeLoginDigitEntered(String digit) {
    // The user is actively logging back in — re-enable auth-error snackbars so
    // a genuine wrong-passcode / login failure surfaces normally.
    _isLoggingOut = false;
    if (state is PasscodeLoginInProgress) {
      final currentState = state as PasscodeLoginInProgress;
      if (currentState.enteredPasscode.length < 6 && !currentState.isAuthenticating) {
        final newPasscode = currentState.enteredPasscode + digit;
        emit(currentState.copyWith(enteredPasscode: newPasscode, clearError: true));

        // Auto-submit when 6 digits entered
        if (newPasscode.length == 6) {
          _attemptPasscodeLogin(newPasscode);
        }
      }
    }
  }

  void passcodeLoginBackspace() {
    if (state is PasscodeLoginInProgress) {
      final currentState = state as PasscodeLoginInProgress;
      if (currentState.enteredPasscode.isNotEmpty && !currentState.isAuthenticating) {
        final newPasscode = currentState.enteredPasscode.substring(
          0,
          currentState.enteredPasscode.length - 1,
        );
        emit(currentState.copyWith(enteredPasscode: newPasscode, clearError: true));
      }
    }
  }

  /// The lock screen submits a CACHED identifier the user cannot see or edit.
  /// If the server answers "invalid credentials" it means nobody matches that
  /// identifier — so the cache is wrong, and no passcode the user types can
  /// ever succeed. Left alone this is an unescapable screen: it just keeps
  /// saying "Login Failed" at someone whose passcode is perfectly correct.
  ///
  /// Drop the stale identifiers so the next launch routes to the full login
  /// screen where the user can type a real one, and say plainly what happened.
  /// Session TOKENS are deliberately untouched — this is about a bad cached
  /// identifier, not a bad session.
  ///
  /// Returns true when it handled the failure.
  bool _handleUnknownCachedIdentifier(String message) {
    if (!isUnknownIdentifierFailure(message)) return false;
    unawaited(() async {
      for (final key in const [
        'stored_phone',
        'stored_email',
        'user_email',
        'preferred_login_method',
        'login_method',
      ]) {
        try {
          await _storage.delete(key: key);
        } catch (_) {/* best-effort */}
      }
    }());
    _showErrorSnackbar(
      'Sign in again',
      "We couldn't find the account saved on this device. Please sign in with "
          'your email, phone or username.',
    );
    emit(AuthenticationInitial());
    return true;
  }

  Future<void> _attemptPasscodeLogin(String passcode) async {
    if (state is! PasscodeLoginInProgress) return;

    final currentState = state as PasscodeLoginInProgress;

    final storedPhone = await _storage.read(key: 'stored_phone');
    // Try multiple keys for email (for backwards compatibility)
    String? email = await _storage.read(key: _userEmailKey);
    if (email == null || email.isEmpty) {
      email = await _storage.read(key: 'stored_email');
    }

    // INVARIANT: these cached identifiers must belong to the user this screen is
    // greeting. They are submitted VERBATIM below, and a stale one does not fail
    // harmlessly — it spends a failed-login attempt against whoever the
    // identifier really belongs to, and three of those lock THAT person out of
    // their own account. That is exactly what happened when `stored_phone`
    // survived a user switch while the display name next to it was rewritten:
    // the screen said "Hey <new user>" and signed in as the previous one.
    // `_purgeStaleUserCache` clears all of them on a switch; anything that
    // writes an identifier here must clear it on the way out too.

    // Phone+passcode (passwordless) accounts MUST authenticate by phone
    // (LoginWithPhonePasscode). Using the email path for them fails with
    // "error finding user" when no email is stored. `stored_phone` is written
    // ONLY by the phone+passcode flows (signup + phone login), so its presence
    // reliably identifies a phone-primary account regardless of the (possibly
    // stale) login_method or whether the platform-mode pref has loaded yet.
    final usePhone = storedPhone != null && storedPhone.isNotEmpty;

    if (usePhone) {
      print('🔐 Passcode login attempt - using PHONE: $storedPhone');
      if (isClosed) return;
      emit(currentState.copyWith(isAuthenticating: true, clearError: true));

      final result = await _authRepository.loginWithPhonePasscode(
        phone: storedPhone,
        passcode: passcode,
      );
      if (isClosed) return;
      result.fold(
        (failure) {
          print('🔐 Phone passcode login failed: ${failure.message}');
          // 2FA enabled: route to the 2FA verification flow. The lock screen
          // listens for LoginTwoFactorRequired — this MUST NOT be swallowed as a
          // generic "Login Failed", or a 2FA-enabled user is locked out of the
          // daily unlock path (parity with the full phone-login screen).
          if (failure is TwoFactorRequiredFailure) {
            emit(LoginTwoFactorRequired(
                twoFactorToken: failure.twoFactorToken, method: failure.method));
            return;
          }
          // Risk-based step-up: route to the OTP flow instead of an error.
          if (failure is StepUpRequiredFailure) {
            emit(LoginStepUpRequired(
              stepUpToken: failure.stepUpToken,
              method: failure.stepUpMethod,
              destination: failure.destination,
            ));
            return;
          }
          if (_handleUnknownCachedIdentifier(failure.message)) return;
          _showErrorSnackbar('Login Failed', failure.message);
          emit(PasscodeLoginInProgress(
            enteredPasscode: '',
            isAuthenticating: false,
            errorMessage: failure.message,
          ));
        },
        (profile) async {
          print('🔐 Phone passcode login successful for: $storedPhone');
          await _saveSession(profile);
          await _storage.write(key: 'login_method', value: 'phone_passcode');
          await _storage.write(key: 'stored_phone', value: storedPhone);
          emit(AuthenticationSuccess(profile));
        },
      );
      return;
    }

    print('🔐 Passcode login attempt - Email from storage: $email');

    if (email == null || email.isEmpty) {
      _showErrorSnackbar('Error', 'No stored email found. Please use email/password login.');
      if (isClosed) return;
      emit(currentState.copyWith(enteredPasscode: '', clearError: true));
      return;
    }

    if (isClosed) return;
    emit(currentState.copyWith(isAuthenticating: true, clearError: true));

    print('🔐 Calling loginWithPasscode for email: $email');

    final result = await _loginWithPasscodeUseCase(
      email: email,
      passcode: passcode,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        print('🔐 Passcode login failed: ${failure.message}');
        // Same 2FA / step-up enforcement as the phone branch above — the email
        // passcode lock screen must also route a 2FA-enabled user to the
        // verification flow instead of swallowing the challenge as an error.
        if (failure is TwoFactorRequiredFailure) {
          emit(LoginTwoFactorRequired(
              twoFactorToken: failure.twoFactorToken, method: failure.method));
          return;
        }
        if (failure is StepUpRequiredFailure) {
          emit(LoginStepUpRequired(
            stepUpToken: failure.stepUpToken,
            method: failure.stepUpMethod,
            destination: failure.destination,
          ));
          return;
        }
        if (_handleUnknownCachedIdentifier(failure.message)) return;
        _showErrorSnackbar('Login Failed', failure.message);
        emit(PasscodeLoginInProgress(
          enteredPasscode: '',
          isAuthenticating: false,
          errorMessage: failure.message,
        ));
      },
      (profile) async {
        print('🔐 Passcode login successful for: ${profile.user.email}');
        await _saveSession(profile);
        await _storage.write(key: 'login_method', value: 'passcode');
        await _storage.write(key: 'stored_email', value: email);
        emit(AuthenticationSuccess(profile));
      },
    );
  }

  // ========== Password Recovery Verification Methods ==========
  // V2 implementations are below in the "Password Reset V2" section

  // ========== Two-Factor Authentication Methods ==========
  //
  // All five live methods delegate to IAuthRepository, which in turn calls
  // the corresponding auth-service gRPC handler (EnableTwoFactor,
  // CompleteTwoFactorSetup, DisableTwoFactor, GetTwoFactorStatus,
  // RegenerateBackupCodes). Each handler reads the user id from the JWT —
  // we never trust the client-supplied user id.

  /// Get the current 2FA status for the authenticated user
  Future<TwoFactorStatus> getTwoFactorStatus() async {
    final result = await _authRepository.getTwoFactorStatus();
    return result.fold(
      (failure) {
        // Surface the error via snackbar so the UI doesn't render a stale
        // disabled state and the user can retry.
        _showErrorSnackbar('2FA status', failure.message);
        return const TwoFactorStatus.disabled();
      },
      (status) => status,
    );
  }

  /// Enable two-factor authentication for the user
  /// Returns the setup data including QR code and backup codes
  Future<TwoFactorSetup> enableTwoFactor(TwoFactorMethod method) async {
    if (isClosed) throw Exception('Cubit is closed');
    // Bounded — a stalled EnableTwoFactor RPC must not leave the "Enable" button
    // spinning forever. On timeout return the empty setup (treated as failure by
    // the caller, which already snackbar'd nothing yet) with a clear message.
    final Either<Failure, TwoFactorSetup> result;
    try {
      result = await _authRepository
          .enableTwoFactor(method: method)
          .timeout(const Duration(seconds: 20));
    } on TimeoutException {
      _showErrorSnackbar(
          '2FA setup failed', 'The request timed out. Please try again.');
      return const TwoFactorSetup.empty();
    }
    return result.fold(
      (failure) {
        _showErrorSnackbar('2FA setup failed', failure.message);
        return const TwoFactorSetup.empty();
      },
      (setup) => setup,
    );
  }

  /// Complete two-factor authentication setup by verifying the code
  Future<bool> completeTwoFactorSetup(String userId, String code) async {
    if (isClosed) return false;
    // Bounded — a stalled CompleteTwoFactorSetup RPC must not leave the setup
    // sheet's verify spinner running forever.
    final Either<Failure, void> result;
    try {
      result = await _authRepository
          .completeTwoFactorSetup(code: code)
          .timeout(const Duration(seconds: 20));
    } on TimeoutException {
      if (isClosed) return false;
      _showErrorSnackbar(
          'Verification failed', 'The request timed out. Please try again.');
      return false;
    }
    if (isClosed) return false;
    return result.fold(
      (failure) {
        _showErrorSnackbar('Verification failed', failure.message);
        return false;
      },
      (_) {
        _showSuccessSnackbar(
          '2FA Enabled',
          'Two-factor authentication has been enabled on your account.',
        );
        return true;
      },
    );
  }

  /// Verify a 2FA code during login. Verifies via the backend VerifyTwoFactor
  /// RPC (TOTP / SMS / email / backup code), saves the session on success, emits
  /// AuthenticationSuccess, and returns true so the screen can navigate.
  Future<bool> verifyTwoFactor(String twoFactorToken, String code) async {
    if (isClosed) return false;
    final result = await _authRepository.verifyTwoFactor(
      twoFactorToken: twoFactorToken,
      code: code,
    );
    if (isClosed) return false;
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => throw StateError('unreachable'));
      _showErrorSnackbar('Verification failed', failure.message);
      return false;
    }
    final profile = result.fold((l) => throw StateError('unreachable'), (r) => r);
    await _saveSession(profile);
    emit(AuthenticationSuccess(profile));
    return true;
  }

  /// Disable two-factor authentication
  Future<bool> disableTwoFactor(String code) async {
    if (isClosed) return false;
    final result = await _authRepository.disableTwoFactor(code: code);
    return result.fold(
      (failure) {
        _showErrorSnackbar('Disable failed', failure.message);
        return false;
      },
      (_) {
        _showSuccessSnackbar(
          '2FA Disabled',
          'Two-factor authentication has been disabled from your account.',
        );
        return true;
      },
    );
  }

  /// Regenerate backup codes for 2FA
  Future<List<String>> regenerateBackupCodes(String code) async {
    if (isClosed) throw Exception('Cubit is closed');
    final result = await _authRepository.regenerateBackupCodes(code: code);
    return result.fold(
      (failure) {
        _showErrorSnackbar('Regeneration failed', failure.message);
        return <String>[];
      },
      (codes) {
        _showSuccessSnackbar(
          'Backup Codes Regenerated',
          'Your new backup codes have been generated. Please save them securely.',
        );
        return codes;
      },
    );
  }

  /// (Re)send a 2FA code for SMS/Email methods. During LOGIN pass the temp
  /// [twoFactorToken] from the login response (used as the Bearer); during 2FA
  /// SETUP call with no argument (the authed session's access token is used).
  /// No-op for TOTP.
  Future<bool> sendTwoFactorCode([String? twoFactorToken]) async {
    if (isClosed) return false;
    final result = await _authRepository.sendTwoFactorLoginCode(twoFactorToken: twoFactorToken);
    if (isClosed) return false;
    return result.fold(
      (failure) {
        _showErrorSnackbar('Could not send code', failure.message);
        return false;
      },
      (_) {
        _showSuccessSnackbar('Code sent', 'A verification code has been sent.');
        return true;
      },
    );
  }

  /// Update profile after email/phone verification in signup flow
  /// This ensures the user remains authenticated after verification
  void updateProfileAfterVerification(ProfileEntity profile) {
    if (isClosed) return;
    _currentProfile = profile;
    emit(AuthenticationAuthenticated(profile));
    unawaited(_registerPushTokenIfReady());
  }

  /// Single chokepoint: register the FCM token on EVERY transition into an
  /// authenticated state — email/password login, Google/Apple sign-in, passcode
  /// login, post-verification, and cold-start session restore all emit either
  /// [AuthenticationSuccess] or [AuthenticationAuthenticated]. Without this, the
  /// common email/password login path (which emits AuthenticationSuccess) never
  /// registered a token, so fcm_tokens stayed empty and no push could be sent.
  /// registerCurrentToken() is idempotent (server keyed by user_id+device_id).
  @override
  void onChange(Change<AuthenticationState> change) {
    super.onChange(change);
    final next = change.nextState;
    if (next is AuthenticationSuccess || next is AuthenticationAuthenticated) {
      unawaited(_registerPushTokenIfReady());
    }
  }

  /// Pushes the FCM token to notifications-service. The service skips the
  /// network call if user_id isn't in secure storage yet.
  Future<void> _registerPushTokenIfReady() async {
    try {
      if (!serviceLocator.isRegistered<PushNotificationsService>()) return;
      await serviceLocator<PushNotificationsService>().registerCurrentToken();
    } catch (_) {
      // Token registration retries on next auth transition / app start.
    }
  }

  // ===== Password Reset V2 (Email/SMS Support) =====

  /// Request password reset via email or SMS
  Future<Either<Failure, PasswordResetResult>> requestPasswordResetV2({
    String? email,
    String? phone,
    auth_enum.PasswordResetDeliveryMethod? deliveryMethod,
  }) async {
    if (isClosed) {
      return Left(ServerFailure(message: 'System error', statusCode: 500));
    }

    emit(ForgotPasswordInProgress(isLoading: true));

    try {
      final result = await _authRepository.requestPasswordResetV2(
        email: email,
        phone: phone,
        deliveryMethod: deliveryMethod,
      );

      result.fold(
        (failure) => emit(AuthenticationError(failure.message)),
        (_) => emit(const PasswordResetEmailSent()),
      );

      return result;
    } catch (e) {
      emit(AuthenticationError(e.toString()));
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  /// Verify password reset code (OTP for SMS or token for email)
  Future<Either<Failure, PasswordResetVerificationResult>> verifyPasswordResetCode({
    required String contact,
    required String code,
    required String deliveryMethod,
  }) async {
    if (isClosed) {
      return Left(ServerFailure(message: 'System error', statusCode: 500));
    }

    try {
      final result = await _authRepository.verifyPasswordResetCode(
        contact: contact,
        code: code,
        deliveryMethod: _parseDeliveryMethod(deliveryMethod),
      );

      result.fold(
        (failure) => emit(AuthenticationError(failure.message)),
        (_) {},
      );

      return result;
    } catch (e) {
      emit(AuthenticationError(e.toString()));
      return Left(ServerFailure(message: e.toString(), statusCode: 500));
    }
  }

  /// Reset password using verified reset token
  Future<void> resetPasswordWithToken({
    required String resetToken,
    required String newPassword,
  }) async {
    if (isClosed) return;

    emit(ResetPasswordInProgress(isLoading: true));

    try {
      final result = await _authRepository.resetPasswordWithToken(
        resetToken: resetToken,
        newPassword: newPassword,
      );

      // Feedback (success/error) is surfaced by the screen via an on-theme
      // status bottom sheet — don't also fire a snackbar here (double feedback).
      result.fold(
        (failure) => emit(AuthenticationError(failure.message)),
        (_) => emit(const PasswordResetSuccess()),
      );
    } catch (e) {
      emit(AuthenticationError(e.toString()));
    }
  }

  // ===== Login-method preference + initial password (Settings) =====

  /// Persist the user's login-method preference on the backend and mirror it to
  /// secure storage so the next cold start honors it. Returns the applied
  /// method on success (or a Failure). Does NOT emit AuthenticationSuccess (to
  /// avoid navigation side-effects on the settings screen).
  Future<Either<Failure, String>> setPreferredLoginMethod(String method) async {
    final res = await _authRepository.setPreferredLoginMethod(method: method);
    await res.fold(
      (_) async {},
      (applied) async {
        // Explicit user choice from Settings — update BOTH the mirror and the
        // canonical resolved flow so the login/signup screens switch immediately
        // and consistently on the next launch.
        await LoginFlowResolver.setExplicit(applied, storage: _storage);
        if (_currentProfile != null) {
          _currentProfile = ProfileEntity(
            user: _currentProfile!.user.copyWith(preferredLoginMethod: applied),
            session: _currentProfile!.session,
          );
        }
      },
    );
    return res;
  }

  /// Set an initial password for a passwordless account, then reflect
  /// has_password locally. Returns success/failure for the caller to render.
  Future<Either<Failure, void>> setInitialPassword(String newPassword) async {
    final res = await _authRepository.setPassword(newPassword: newPassword);
    await res.fold(
      (_) async {},
      (_) async {
        await _storage.write(key: 'has_password', value: 'true');
        if (_currentProfile != null) {
          _currentProfile = ProfileEntity(
            user: _currentProfile!.user.copyWith(hasPassword: true),
            session: _currentProfile!.session,
          );
        }
      },
    );
    return res;
  }

  /// Parse delivery method string to enum
  auth_enum.PasswordResetDeliveryMethod _parseDeliveryMethod(String? method) {
    if (method == null || method == 'unspecified') {
      return auth_enum.PasswordResetDeliveryMethod.DELIVERY_METHOD_UNSPECIFIED;
    }
    if (method == 'email') {
      return auth_enum.PasswordResetDeliveryMethod.DELIVERY_METHOD_EMAIL;
    }
    if (method == 'sms') {
      return auth_enum.PasswordResetDeliveryMethod.DELIVERY_METHOD_SMS;
    }
    return auth_enum.PasswordResetDeliveryMethod.DELIVERY_METHOD_UNSPECIFIED;
  }
}
