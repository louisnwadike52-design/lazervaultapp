import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:lazervault/core/services/secure_storage_service.dart';

/// App-wide state for "am I currently viewing someone else's account?".
///
/// A [ValueNotifier] rather than a cubit so the banner can sit above the
/// navigator — it has to render on EVERY screen, including ones that build
/// their own BlocProviders, and a notifier needs no ancestor.
///
/// WHY THE BANNER IS NOT OPTIONAL
/// An admin who forgets they are impersonating will read someone else's
/// balance as their own and act on it. The banner is the only thing standing
/// between "I am looking at Chris's account" and a support reply about the
/// wrong person's money, so it is always visible and always carries the exit.
class ImpersonationSession extends ValueNotifier<ImpersonationState> {
  ImpersonationSession(this._storage) : super(const ImpersonationState.none());

  final SecureStorageService _storage;
  Timer? _expiryTimer;

  /// Read persisted state at startup.
  ///
  /// THE CRASH CASE. If the app died mid-session the stored ACTIVE token is
  /// the target's, and without this the admin would silently resume as them —
  /// no banner, no exit, someone else's account presented as their own. That is
  /// the single worst failure this feature can have, so startup either
  /// restores the banner (session still valid) or ends the session outright
  /// (expired), and never leaves the target's token active unannounced.
  Future<void> restore() async {
    final sessionId = await _storage.getImpersonationSessionId();
    if (sessionId == null || sessionId.isEmpty) {
      value = const ImpersonationState.none();
      return;
    }
    final label = await _storage.getImpersonationTargetLabel() ?? 'this user';
    final expiresAt = await _storage.getImpersonationExpiresAt();

    if (expiresAt != null && !expiresAt.isAfter(DateTime.now().toUtc())) {
      // Expired while the app was closed. The token is already inert, but the
      // app must not keep presenting it as a session: restore the admin.
      debugPrint('[impersonation] stored session had expired — restoring admin');
      await _storage.endImpersonation();
      value = const ImpersonationState.none();
      return;
    }

    value = ImpersonationState(
      active: true,
      sessionId: sessionId,
      targetLabel: label,
      expiresAt: expiresAt,
    );
    _armExpiry(expiresAt);
  }

  void begin({
    required String sessionId,
    required String targetLabel,
    DateTime? expiresAt,
  }) {
    value = ImpersonationState(
      active: true,
      sessionId: sessionId,
      targetLabel: targetLabel,
      expiresAt: expiresAt,
    );
    _armExpiry(expiresAt);
  }

  /// Clear the banner. The token swap itself is the service's job.
  void end() {
    _expiryTimer?.cancel();
    _expiryTimer = null;
    value = const ImpersonationState.none();
  }

  /// Fires [onExpired] when the token dies, so the UI stops claiming a live
  /// session.
  ///
  /// Without this the banner would keep saying "viewing Chris" long after the
  /// token stopped working, and every screen would quietly fail to load with
  /// no explanation.
  VoidCallback? onExpired;

  void _armExpiry(DateTime? expiresAt) {
    _expiryTimer?.cancel();
    _expiryTimer = null;
    if (expiresAt == null) return;
    final remaining = expiresAt.difference(DateTime.now().toUtc());
    if (remaining.isNegative) {
      onExpired?.call();
      return;
    }
    _expiryTimer = Timer(remaining, () {
      debugPrint('[impersonation] session expired');
      onExpired?.call();
    });
  }

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
  }
}

@immutable
class ImpersonationState {
  const ImpersonationState({
    required this.active,
    this.sessionId = '',
    this.targetLabel = '',
    this.expiresAt,
  });

  const ImpersonationState.none()
      : active = false,
        sessionId = '',
        targetLabel = '',
        expiresAt = null;

  final bool active;
  final String sessionId;
  final String targetLabel;
  final DateTime? expiresAt;

  /// Whole minutes left, for the banner. Never negative.
  int get minutesRemaining {
    if (expiresAt == null) return 0;
    final d = expiresAt!.difference(DateTime.now().toUtc());
    return d.isNegative ? 0 : d.inMinutes;
  }
}
