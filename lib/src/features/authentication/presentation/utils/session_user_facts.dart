import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/injection_container.dart';
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
/// The auth service already answers all of it in one call: `GetMe` returns
/// the same `User` proto a credential login does, plus `has_passcode`. The
/// transaction PIN lives in its own service and has its own check. So this
/// asks both, in parallel, and lays the answers over the profile user.
///
/// ## How it fails
///
/// Toward NOT gating. If `GetMe` cannot be reached the stored `has_passcode`
/// mirror (written as authoritative on every passcode login and every passcode
/// set) stands in; if that is absent too, the passcode is treated as present.
/// If the PIN check cannot be reached the PIN is treated as present. Each gate
/// this can wrongly skip is skippable, self-correcting on the next credential
/// login, and detected again by the setup screen it leads to — whereas gating
/// on a value we never read is exactly the defect being removed. Phone and
/// email verification are only ever read from a live `GetMe`; absent that
/// they stay as the profile reported them, which is "verified" for both.
Future<User> enrichSessionUser(
  User base, {
  Future<Either<Failure, User>> Function()? fetchMe,
  Future<bool> Function()? fetchHasPin,
  Future<String?> Function()? readPasscodeMirror,
  Duration timeout = const Duration(seconds: 8),
}) async {
  fetchMe ??= () => serviceLocator<IAuthRepository>().getMe();
  fetchHasPin ??= () => serviceLocator<ITransactionPinService>()
      .checkUserHasPin(forceRefresh: true);
  readPasscodeMirror ??=
      () => serviceLocator<FlutterSecureStorage>().read(key: 'has_passcode');

  final results = await Future.wait<Object?>([
    _guard(() => fetchMe!().timeout(timeout)),
    _guard(() => fetchHasPin!().timeout(timeout)),
    _guard(() => readPasscodeMirror!()),
  ]);

  final me = results[0] is Either<Failure, User>
      ? (results[0] as Either<Failure, User>).fold((_) => null, (u) => u)
      : null;
  final hasPin = results[1] is bool ? results[1] as bool : true;
  final mirror = results[2] is String ? results[2] as String : null;

  if (me != null) {
    return base.copyWith(
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
