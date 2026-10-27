import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/login_facts_store.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

/// Give a session-login user the facts the post-login router gates on.
///
/// ## Why this exists
///
/// Face ID, fingerprint and voice do not authenticate with a credential RPC.
/// They prove a LOCAL gate, then rebuild the user from `ProfileCubit`, whose
/// user comes through the `common` profile proto. That proto carries a name
/// and an avatar; it does not carry `has_passcode`, `has_transaction_pin`,
/// `kyc_tier`, `kyc_status`, `signup_status` or `current_signup_step`. So on
/// that path every one of those arrives at the router as its Dart default —
/// `false`, `0`, `null` — and the router, which is right to send someone with
/// no passcode to set one, sent the app's daily Face ID users to "Set Up
/// Passcode" for the passcode they had just chosen not to type.
///
/// ## Cached first, backend second
///
/// The facts the backend gave at the LAST login are kept in
/// [LoginFactsStore]. When a record exists for this user it is applied at
/// once and the unlock proceeds — no round trip stands between a proven
/// biometric and the dashboard. The auth service (`GetMe`) and the PIN
/// service are then asked in the background and the record is replaced with
/// their answer, so the NEXT unlock is judged by today's facts. That is the
/// same shape every list screen in the app is moving to: paint what you know,
/// refresh behind it.
///
/// With no record — first unlock after install, a record for another user,
/// or one older than [LoginFactsStore.maxAge] — the backend is awaited, as it
/// was before, and its answer is recorded.
///
/// ## How it fails
///
/// Toward NOT gating. If `GetMe` cannot be reached the stored `has_passcode`
/// mirror (written as authoritative on every passcode login and every passcode
/// set) stands in; if that is absent too, the passcode is treated as present.
/// If the PIN check cannot be reached the PIN is treated as present. Each gate
/// this can wrongly skip is skippable, self-correcting on the next credential
/// login, and detected again by the setup screen it leads to — whereas gating
/// on a value we never read is exactly the defect being removed.
Future<User> enrichSessionUser(
  User base, {
  Future<Either<Failure, User>> Function()? fetchMe,
  Future<bool> Function()? fetchHasPin,
  Future<String?> Function()? readPasscodeMirror,
  Future<LoginFacts?> Function(String userId)? readFacts,
  Future<void> Function(User user, {bool? hasTransactionPin})? writeFacts,
  Duration timeout = const Duration(seconds: 8),

  /// Set false to skip the background refresh (tests, or a caller that will
  /// do its own credential login shortly).
  bool refreshInBackground = true,
}) async {
  fetchMe ??= () => serviceLocator<IAuthRepository>().getMe();
  fetchHasPin ??= () => serviceLocator<ITransactionPinService>()
      .checkUserHasPin(forceRefresh: true);
  readPasscodeMirror ??=
      () => serviceLocator<FlutterSecureStorage>().read(key: 'has_passcode');
  readFacts ??= LoginFactsStore.read;
  writeFacts ??= LoginFactsStore.record;

  // FOREGROUND: the last recorded answer, if it is this user's.
  final cached = await _guard(() => readFacts!(base.id));
  if (cached is LoginFacts) {
    if (refreshInBackground) {
      unawaited(_refreshFacts(
        base,
        fetchMe: fetchMe,
        fetchHasPin: fetchHasPin,
        readPasscodeMirror: readPasscodeMirror,
        writeFacts: writeFacts,
        timeout: timeout,
      ));
    }
    return cached.applyTo(base);
  }

  // No usable record: ask now, and remember the answer for next time.
  return _refreshFacts(
    base,
    fetchMe: fetchMe,
    fetchHasPin: fetchHasPin,
    readPasscodeMirror: readPasscodeMirror,
    writeFacts: writeFacts,
    timeout: timeout,
  );
}

Future<User> _refreshFacts(
  User base, {
  required Future<Either<Failure, User>> Function() fetchMe,
  required Future<bool> Function() fetchHasPin,
  required Future<String?> Function() readPasscodeMirror,
  required Future<void> Function(User user, {bool? hasTransactionPin})
      writeFacts,
  required Duration timeout,
}) async {
  final results = await Future.wait<Object?>([
    _guard(() => fetchMe().timeout(timeout)),
    _guard(() => fetchHasPin().timeout(timeout)),
    _guard(readPasscodeMirror),
  ]);

  final me = results[0] is Either<Failure, User>
      ? (results[0] as Either<Failure, User>).fold((_) => null, (u) => u)
      : null;
  final pinAnswered = results[1] is bool;
  final hasPin = pinAnswered ? results[1] as bool : true;
  final mirror = results[2] is String ? results[2] as String : null;

  if (me != null) {
    final enriched = base.copyWith(
      hasPasscode: me.hasPasscode,
      hasPassword: me.hasPassword,
      hasTransactionPin: hasPin,
      preferredLoginMethod: me.preferredLoginMethod,
      verified: me.verified,
      isEmailVerified: me.isEmailVerified,
      phoneNumber: me.phoneNumber ?? base.phoneNumber,
      signupStatus: me.signupStatus,
      currentSignupStep: me.currentSignupStep,
      kycTier: me.kycTier,
      kycStatus: me.kycStatus,
    );
    // Only a LIVE answer is worth remembering. Recording the fail-safe
    // defaults below would turn one outage into a month of "has a PIN".
    await _guard(() =>
        writeFacts(enriched, hasTransactionPin: pinAnswered ? hasPin : null));
    return enriched;
  }

  // GetMe unavailable: the mirror decides the passcode; absence means present.
  final hasPasscode = mirror == null || mirror.isEmpty
      ? true
      : (mirror == 'true' || mirror == '1');
  return base.copyWith(
    hasPasscode: hasPasscode,
    hasTransactionPin: hasPin,
  );
}

/// Run [action], turning any throw (timeout included) into `null` so one
/// failed lookup cannot take the others — or the login — down with it.
Future<Object?> _guard(Future<Object?> Function() action) async {
  try {
    return await action();
  } catch (_) {
    return null;
  }
}
