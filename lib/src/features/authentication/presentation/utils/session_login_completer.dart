import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/utils/logger.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/domain/entities/session_entity.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';

/// Result of finishing a login once a session already exists on the device.
enum SessionLoginOutcome {
  /// Profile loaded + AuthenticationCubit hydrated → the screen's BlocConsumer
  /// runs the normal post-login gates and navigates. Nothing else to do.
  success,

  /// The cached/minted session is genuinely dead (unauthenticated/permission
  /// denied even after a token rotation). Local tokens were cleared. The caller
  /// should tell the user to sign in with their password/passcode.
  revoked,

  /// A transient network/backend failure — DON'T wipe the session. The caller
  /// should offer a single-shot retry (never an auto-retry loop).
  network,
}

/// Shared "finish the login" tail for every credential that ends with a session
/// already on the device — fingerprint / Face ID (LOCAL gate over the cached
/// `refresh_token`) and voice (server mints fresh tokens which the caller
/// persists first). Used by BOTH the passcode lock and the email sign-in screen
/// so the funnel + failure classification live in ONE place.
///
/// Flow: load the REAL user profile from the user-service (the only source of
/// the name+avatar; also the session gate — a merely-expired access token is
/// transparently rotated inside `getUserProfile`), then hydrate the app-wide
/// [AuthenticationCubit] → it emits `AuthenticationSuccess`, which the host
/// screen's BlocConsumer handles exactly like a passcode/password login (resume
/// / verification / transaction-PIN gates, then nav). Failure is CLASSIFIED so a
/// transient network blip is never misreported as an expired session.
mixin SessionLoginCompleter<T extends StatefulWidget> on State<T> {
  FlutterSecureStorage get _sessionStorage =>
      serviceLocator<FlutterSecureStorage>();

  Future<SessionLoginOutcome> completeSessionLogin({
    String flow = 'biometric_login',
  }) async {
    try {
      final profileCubit = context.read<ProfileCubit>();
      await profileCubit.getUserProfile();
      if (!mounted) return SessionLoginOutcome.network;

      final pState = profileCubit.state;
      if (pState is! ProfileLoaded) {
        // gRPC: unauthenticated=16, permissionDenied=7. getUserProfile already
        // rotated + retried once, so these mean the session is really dead.
        final code = pState is ProfileError ? pState.statusCode : null;
        final revoked = code == 16 || code == 7;
        AppLogger.event(flow, 'profile_load_failed',
            level: revoked ? 'warn' : 'error',
            fields: {
              'status_code': code,
              'classification': revoked ? 'revoked' : 'network',
              'message': pState is ProfileError ? pState.message : '',
            });
        if (revoked) {
          // Clear the dead tokens so a re-tap can't replay them; keep the
          // greeting identity (stored_email/name) for the next password login.
          await _sessionStorage.delete(key: 'access_token');
          await _sessionStorage.delete(key: 'refresh_token');
          return SessionLoginOutcome.revoked;
        }
        return SessionLoginOutcome.network;
      }

      final at = await _sessionStorage.read(key: 'access_token') ?? '';
      final rt = await _sessionStorage.read(key: 'refresh_token') ?? '';
      if (!mounted) return SessionLoginOutcome.network;

      final now = DateTime.now();
      final profile = ProfileEntity(
        user: pState.user,
        session: SessionEntity(
          id: pState.user.id,
          userId: pState.user.id,
          accessToken: at,
          refreshToken: rt,
          accessTokenExpiresAt: now.add(const Duration(hours: 1)),
          refreshTokenExpiresAt: now.add(const Duration(days: 30)),
        ),
      );
      AppLogger.event(flow, 'login_success', fields: {'user_id': profile.user.id});
      if (!mounted) return SessionLoginOutcome.network;
      context.read<AuthenticationCubit>().hydrateProfile(profile);
      return SessionLoginOutcome.success;
    } catch (e, st) {
      // Capture the real error; treat unexpected failures as transient (never
      // wipe the session on an unknown error).
      AppLogger.error('session login threw',
          error: e, stackTrace: st, flow: flow);
      return SessionLoginOutcome.network;
    }
  }
}
