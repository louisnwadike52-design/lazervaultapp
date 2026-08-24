import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/utils/logger.dart';
import 'package:lazervault/src/features/open_banking/data/datasources/open_banking_grpc_datasource.dart';

import '../domain/entities/mandate_entity.dart';
import 'mandate_state.dart';

/// Cubit for managing direct debit mandates.
///
/// Maintains an internal cache of mandates keyed by [linkedAccountId]
/// for O(1) lookup when rendering account cards.
class MandateCubit extends Cubit<MandateState> {
  final OpenBankingGrpcDataSource _dataSource;

  /// Internal cache: linkedAccountId → MandateEntity
  final Map<String, MandateEntity> _mandatesByAccountId = {};

  /// Prevents concurrent operations (double-tap, overlapping pause/reinstate).
  bool _operationInProgress = false;

  MandateCubit(this._dataSource) : super(MandateInitial());

  /// Server-side authorization-attempt stamp (device-independent "Setting up"
  /// signal). Best-effort passthrough.
  Future<void> markAuthAttempt(String mandateId, {bool cleared = false}) =>
      _dataSource.markMandateAuthAttempt(mandateId: mandateId, cleared: cleared);

  /// Classify a mandate failure, log it to Loki (flow: 'mandate'), and build a
  /// user-facing [MandateError]. A backend KYC_REQUIRED (the "no fake customer
  /// data" gate — Direct Debit needs a real email/phone/address on file) is
  /// surfaced with its actionable message + isKYCRequired so the UI routes to
  /// verification instead of showing a raw gRPC error.
  MandateError _mandateError(Object e, StackTrace st, String action,
      [Map<String, dynamic> fields = const {}]) {
    final raw = e is GrpcError ? (e.message ?? e.toString()) : e.toString();
    final isKyc = raw.contains('KYC_REQUIRED') ||
        raw.contains('verify your identity') ||
        raw.contains('we need your address') ||
        raw.contains('we need a valid email') ||
        raw.contains('we need your phone') ||
        raw.contains('complete your identity verification');
    String userMsg;
    if (isKyc) {
      userMsg = raw.contains('KYC_REQUIRED:')
          ? raw.split('KYC_REQUIRED:').last.trim()
          : raw.trim();
      if (userMsg.isEmpty) {
        userMsg = 'Please complete your identity verification to continue.';
      }
    } else {
      userMsg = 'Failed to $action. Please try again.';
    }
    AppLogger.error(
      'mandate: $action failed${isKyc ? ' (KYC_REQUIRED)' : ''}',
      error: e,
      stackTrace: st,
      flow: 'mandate',
      fields: {...fields, 'kyc_required': isKyc},
    );
    return MandateError(message: userMsg, isKYCRequired: isKyc);
  }

  /// Create a mandate for a linked bank account.
  ///
  /// Optional [userEmail], [userName], [userPhone] are forwarded as gRPC
  /// metadata so the backend can auto-create a Mono customer if needed.
  Future<void> createMandate({
    required String userId,
    required String linkedAccountId,
    String mandateType = 'gsm',
    int amountLimit = 0,
    String? userEmail,
    String? userName,
    String? userPhone,
  }) async {
    if (_operationInProgress) return;
    _operationInProgress = true;
    emit(MandateLoading());
    try {
      final result = await _dataSource.createMandate(
        userId: userId,
        linkedAccountId: linkedAccountId,
        mandateType: mandateType,
        amountLimit: amountLimit,
        userEmail: userEmail,
        userName: userName,
        userPhone: userPhone,
      );

      // Update cache
      _mandatesByAccountId[linkedAccountId] = result.mandate;

      emit(MandateCreated(
        mandate: result.mandate,
        needsAuthorization: result.needsAuthorization,
        authorizationUrl: result.authorizationUrl,
      ));
    } catch (e, st) {
      emit(_mandateError(e, st, 'set up Direct Debit',
          {'account_id': linkedAccountId, 'user_id': userId}));
    } finally {
      _operationInProgress = false;
    }
  }

  /// Fetch all mandates for a user and rebuild the cache.
  Future<void> fetchUserMandates({
    required String userId,
    bool activeOnly = false,
  }) async {
    try {
      final mandates = await _dataSource.getUserMandates(
        userId: userId,
        activeOnly: activeOnly,
      );

      // Rebuild cache — prefer active/ready mandates over others for the same account
      _mandatesByAccountId.clear();
      for (final mandate in mandates) {
        final existing = _mandatesByAccountId[mandate.linkedAccountId];
        if (existing == null || _isBetterMandate(mandate, existing)) {
          _mandatesByAccountId[mandate.linkedAccountId] = mandate;
        }
      }

      // Show the synced (cached) badges INSTANTLY...
      emit(UserMandatesLoaded(mandates: mandates));
      // ...then re-verify against Mono (source of truth) in the background and
      // update the badges if anything drifted. Fire-and-forget so the UI is
      // never blocked on Mono round-trips.
      unawaited(refreshUserMandatesFromMono(userId: userId));
    } catch (e) {
      // Silently fail — mandates are optional enhancement
      emit(UserMandatesLoaded(mandates: []));
    }
  }

  /// Background refresh — Mono is the source of truth. Call this AFTER
  /// [fetchUserMandates] has shown the synced (possibly stale) badge instantly:
  /// it re-verifies each LIVE mandate against Mono (the backend getMandate
  /// refreshes from Mono on read), updates the cache, and emits so the badges
  /// correct themselves on display. Best-effort + silent — a refresh failure
  /// never disturbs what the user already sees.
  Future<void> refreshUserMandatesFromMono({required String userId}) async {
    final live = _mandatesByAccountId.values
        .where((m) => !m.isCancelled && !m.isRejected && !m.isExpired)
        .toList();
    if (live.isEmpty) return;

    var changed = false;
    for (final m in live) {
      try {
        final fresh = await _dataSource.getMandate(mandateId: m.id, userId: userId);
        final existing = _mandatesByAccountId[fresh.linkedAccountId];
        // Same mandate → always take the fresh status. A DIFFERENT mandate on
        // the same account only replaces the cached one if it is genuinely
        // better — without this, iteration order let a stale awaiting mandate
        // overwrite the active one (badge + rail decision both flipped wrong).
        if (existing == null || existing.id == fresh.id) {
          if (existing == null || existing.status != fresh.status) {
            _mandatesByAccountId[fresh.linkedAccountId] = fresh;
            changed = true;
          }
        } else if (_isBetterMandate(fresh, existing)) {
          _mandatesByAccountId[fresh.linkedAccountId] = fresh;
          changed = true;
        }
      } catch (_) {
        // best-effort background refresh — ignore transient errors
      }
    }

    if (changed && !isClosed) {
      emit(UserMandatesLoaded(mandates: _mandatesByAccountId.values.toList()));
    }
  }

  /// Synchronous lookup: get the best mandate for a linked account, or null.
  MandateEntity? getMandateForAccount(String linkedAccountId) {
    return _mandatesByAccountId[linkedAccountId];
  }

  /// Pause a mandate.
  Future<void> pauseMandate({
    required String mandateId,
    required String userId,
  }) async {
    if (_operationInProgress) return;
    _operationInProgress = true;
    emit(MandateLoading());
    try {
      final mandate = await _dataSource.pauseMandate(
        mandateId: mandateId,
        userId: userId,
      );
      _mandatesByAccountId[mandate.linkedAccountId] = mandate;
      emit(MandatePaused(mandate: mandate));
      // Converge the "Switching…" badge to the confirmed state once Mono acks the
      // pause — every pause surface (deposit card, Manage sheet) gets this.
      pollSwitchUntilSettled(mandateId: mandateId, userId: userId);
    } catch (e, st) {
      emit(_mandateError(e, st, 'pause Direct Debit'));
    } finally {
      _operationInProgress = false;
    }
  }

  /// Reinstate a paused mandate.
  Future<void> reinstateMandate({
    required String mandateId,
    required String userId,
  }) async {
    if (_operationInProgress) return;
    _operationInProgress = true;
    emit(MandateLoading());
    try {
      final mandate = await _dataSource.reinstateMandate(
        mandateId: mandateId,
        userId: userId,
      );
      _mandatesByAccountId[mandate.linkedAccountId] = mandate;
      emit(MandateReinstated(mandate: mandate));
      // Converge the "Switching…" badge to the confirmed state once Mono acks the
      // reinstate — every reinstate surface (deposit card, Manage sheet) gets this.
      pollSwitchUntilSettled(mandateId: mandateId, userId: userId);
    } catch (e, st) {
      emit(_mandateError(e, st, 'resume Direct Debit'));
    } finally {
      _operationInProgress = false;
    }
  }

  /// Cancel a mandate.
  Future<void> cancelMandate({
    required String mandateId,
    required String userId,
    required String linkedAccountId,
  }) async {
    if (_operationInProgress) return;
    _operationInProgress = true;
    emit(MandateLoading());
    try {
      await _dataSource.cancelMandate(
        mandateId: mandateId,
        userId: userId,
      );
      _mandatesByAccountId.remove(linkedAccountId);
      emit(MandateCancelled(mandateId: mandateId));
    } catch (e, st) {
      emit(_mandateError(e, st, 'cancel Direct Debit'));
    } finally {
      _operationInProgress = false;
    }
  }

  /// Recreate a mandate for an account (cancel old one first if needed).
  Future<void> recreateMandateForAccount({
    required String userId,
    required String linkedAccountId,
    String? userEmail,
    String? userName,
    String? userPhone,
  }) async {
    if (_operationInProgress) return;
    _operationInProgress = true;
    emit(MandateLoading());

    try {
      // Cancel existing mandate if there is one
      final existing = _mandatesByAccountId[linkedAccountId];
      if (existing != null &&
          existing.status != MandateStatus.cancelled &&
          existing.status != MandateStatus.expired) {
        try {
          await _dataSource.cancelMandate(
            mandateId: existing.id,
            userId: userId,
          );
        } catch (_) {
          // Ignore cancel failure — proceed to create new one
        }
      }

      // Create new GSM mandate
      final result = await _dataSource.createMandate(
        userId: userId,
        linkedAccountId: linkedAccountId,
        mandateType: 'gsm',
        userEmail: userEmail,
        userName: userName,
        userPhone: userPhone,
      );

      _mandatesByAccountId[linkedAccountId] = result.mandate;
      emit(MandateCreated(
        mandate: result.mandate,
        needsAuthorization: result.needsAuthorization,
        authorizationUrl: result.authorizationUrl,
      ));
    } catch (e, st) {
      emit(_mandateError(e, st, 'set up Direct Debit'));
    } finally {
      _operationInProgress = false;
    }
  }

  /// Ensure a mandate is active for the given account.
  /// Returns (mandate, needsWait) — needsWait is true for e-mandate 24h scenarios.
  Future<(MandateEntity?, bool)> ensureMandateActive({
    required String userId,
    required String linkedAccountId,
    String? userEmail,
    String? userName,
    String? userPhone,
  }) async {
    final existing = _mandatesByAccountId[linkedAccountId];

    // Already active
    if (existing != null && existing.isActive) {
      return (existing, false);
    }

    // Activating — just needs time
    if (existing != null && existing.isActivating) {
      return (existing, true);
    }

    // Missing, expired, cancelled, or rejected — create new
    try {
      final result = await _dataSource.createMandate(
        userId: userId,
        linkedAccountId: linkedAccountId,
        mandateType: 'gsm',
        userEmail: userEmail,
        userName: userName,
        userPhone: userPhone,
      );

      _mandatesByAccountId[linkedAccountId] = result.mandate;

      if (!isClosed) {
        emit(MandateCreated(
          mandate: result.mandate,
          needsAuthorization: result.needsAuthorization,
          authorizationUrl: result.authorizationUrl,
        ));
      }

      return (result.mandate, result.mandate.isActivating);
    } catch (_) {
      return (null, false);
    }
  }

  /// Poll mandate status until it becomes active (for e-mandate 24h wait).
  Timer? _mandatePollTimer;

  void pollMandateStatus({
    required String mandateId,
    required String userId,
  }) {
    _mandatePollTimer?.cancel();
    _mandatePollTimer = Timer.periodic(const Duration(seconds: 60), (timer) async {
      if (isClosed) {
        timer.cancel();
        return;
      }

      try {
        final mandate = await _dataSource.getMandate(
          mandateId: mandateId,
          userId: userId,
        );

        _mandatesByAccountId[mandate.linkedAccountId] = mandate;

        if (mandate.isActive) {
          timer.cancel();
          if (!isClosed) {
            emit(MandateCreated(
              mandate: mandate,
              needsAuthorization: false,
            ));
          }
        }
      } catch (_) {
        // Continue polling on transient errors
      }
    });
  }

  void stopPolling() {
    _mandatePollTimer?.cancel();
    _mandatePollTimer = null;
  }

  /// Poll a mandate after a deposit-method switch (pause⇄reinstate) until Mono
  /// confirms it — i.e. until [MandateEntity.switchProcessing] clears — refreshing
  /// the cache/badges so the card converges from "Switching…" to the settled
  /// state without a manual pull-to-refresh. Bounded ([maxTicks]) so it never
  /// polls forever; best-effort + silent on transient errors.
  Timer? _switchPollTimer;

  void pollSwitchUntilSettled({
    required String mandateId,
    required String userId,
    int maxTicks = 8,
  }) {
    _switchPollTimer?.cancel();
    var ticks = 0;
    _switchPollTimer = Timer.periodic(const Duration(seconds: 12), (timer) async {
      ticks++;
      if (isClosed || ticks > maxTicks) {
        timer.cancel();
        return;
      }
      try {
        final fresh = await _dataSource.getMandate(mandateId: mandateId, userId: userId);
        _mandatesByAccountId[fresh.linkedAccountId] = fresh;
        if (!isClosed) {
          emit(UserMandatesLoaded(mandates: _mandatesByAccountId.values.toList()));
        }
        if (!fresh.switchProcessing) {
          timer.cancel();
        }
      } catch (_) {
        // best-effort — keep trying until maxTicks
      }
    });
  }

  /// Prefer active/readyToDebit mandates over others.
  bool _isBetterMandate(MandateEntity candidate, MandateEntity existing) {
    if (candidate.isActive && !existing.isActive) return true;
    if (candidate.isActivating && !existing.isActive && !existing.isActivating) {
      return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    _mandatePollTimer?.cancel();
    _switchPollTimer?.cancel();
    return super.close();
  }
}
