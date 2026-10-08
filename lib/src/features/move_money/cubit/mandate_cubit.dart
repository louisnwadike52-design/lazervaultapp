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

  /// Drop everything belonging to the signed-out user.
  ///
  /// This cubit is a LAZY SINGLETON, so its state outlives a session. Without
  /// this, the next person to sign in on the same device inherits the previous
  /// user's Direct Debit mandates — their bank, their limits, their expiry —
  /// keyed by account ids that are not theirs.
  void clearOnLogout() {
    _mandatesByAccountId.clear();
    _operationInProgress = false;
    if (!isClosed) emit(MandateInitial());
  }

  /// Prevents concurrent operations (double-tap, overlapping pause/reinstate).
  bool _operationInProgress = false;

  MandateCubit(this._dataSource) : super(MandateInitial());

  /// Server-side authorization-attempt stamp (device-independent "Setting up"
  /// signal). Best-effort passthrough.
  Future<void> markAuthAttempt(String mandateId, {bool cleared = false}) =>
      _dataSource.markMandateAuthAttempt(
          mandateId: mandateId, cleared: cleared);

  /// Ask the PROVIDER what actually happened, once, right now.
  ///
  /// The only trustworthy answer to "is this mandate authorized?" comes from
  /// Mono, and the server's GetMandate refreshes from Mono before replying.
  /// Neither of the two things the UI is tempted to believe is evidence:
  ///
  ///  - the webview's redirect, which for a mandate carries no status at all;
  ///  - the user's own "yes, I finished it", which they answer in good faith
  ///    about a transfer that may have failed, been reversed, or never left
  ///    their bank app.
  ///
  /// Returns the refreshed mandate, or null if the provider could not be
  /// reached — null means UNKNOWN, never "no". Callers must not downgrade a
  /// mandate on a null.
  Future<MandateEntity?> verifyWithProvider({
    required String mandateId,
    required String userId,
  }) async {
    try {
      final mandate =
          await _dataSource.getMandate(mandateId: mandateId, userId: userId);
      _mandatesByAccountId[mandate.linkedAccountId] = mandate;
      return mandate;
    } catch (e, st) {
      AppLogger.error('mandate: provider verification failed',
          error: e, stackTrace: st);
      return null;
    }
  }

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
        final fresh =
            await _dataSource.getMandate(mandateId: m.id, userId: userId);
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
  /// Returns TRUE only when the bank confirmed the pause.
  ///
  /// The deposit screen used to fire this and announce "Switching to
  /// one-time" in the same breath, without awaiting — so a Mono timeout left
  /// the user told it was happening while the mandate stayed ready_to_debit.
  /// A caller must be able to tell success from failure, hence a bool rather
  /// than void.
  Future<bool> pauseMandate({
    required String mandateId,
    required String userId,
  }) async {
    // Another mutation is mid-flight. Report FALSE rather than silently
    // returning: the caller would otherwise announce a switch that was never
    // even attempted.
    if (_operationInProgress) return false;
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
      return true;
    } catch (e, st) {
      emit(_mandateError(e, st, 'pause Direct Debit'));
      return false;
    } finally {
      _operationInProgress = false;
    }
  }

  /// Reinstate a paused mandate.
  /// Returns TRUE only when the bank confirmed the reinstate. See
  /// [pauseMandate] for why this is not void.
  Future<bool> reinstateMandate({
    required String mandateId,
    required String userId,
  }) async {
    if (_operationInProgress) return false;
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
      return true;
    } catch (e, st) {
      emit(_mandateError(e, st, 'resume Direct Debit'));
      return false;
    } finally {
      _operationInProgress = false;
    }
  }

  /// Cancel a mandate.
  /// Returns TRUE only when the bank confirmed the cancellation. See
  /// [pauseMandate] for why this is not void.
  Future<bool> cancelMandate({
    required String mandateId,
    required String userId,
    required String linkedAccountId,
  }) async {
    if (_operationInProgress) return false;
    _operationInProgress = true;
    emit(MandateLoading());
    try {
      await _dataSource.cancelMandate(
        mandateId: mandateId,
        userId: userId,
      );
      _mandatesByAccountId.remove(linkedAccountId);
      emit(MandateCancelled(mandateId: mandateId));
      return true;
    } catch (e, st) {
      emit(_mandateError(e, st, 'cancel Direct Debit'));
      return false;
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
    // Bounded. This used to stop ONLY on success, so a mandate that ended up
    // rejected/cancelled/expired polled every 60s for the life of the cubit —
    // and since an abandoned setup now starts a poll, that was one permanent
    // background call per abandonment.
    //
    // 30 minutes matches the Mono authorization window: past it the link is
    // dead and nothing can change without the user starting again, so there is
    // nothing left to watch for.
    const maxPolls = 30;
    var polls = 0;
    _mandatePollTimer =
        Timer.periodic(const Duration(seconds: 60), (timer) async {
      if (isClosed) {
        timer.cancel();
        return;
      }
      if (++polls > maxPolls) {
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
          return;
        }
        // Terminal failure: nothing further will happen on its own. Stop, and
        // EMIT so the UI can drop any "setting up" state instead of showing a
        // spinner against a mandate that is already dead.
        if (mandate.isTerminal) {
          timer.cancel();
          if (!isClosed) {
            emit(MandateCreated(
              mandate: mandate,
              needsAuthorization: false,
            ));
          }
        }
      } catch (_) {
        // Continue polling on transient errors — a flaky network must not be
        // mistaken for a dead mandate.
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

  /// The mandate currently being polled, so a resume can tell whether the poll
  /// it would start is already running.
  String? _switchPollMandateId;

  /// Backoff schedule for the switch poll.
  ///
  /// WHY NOT A FIXED 12s TICK
  ///
  /// It used to be `Timer.periodic(12s)` bounded at 8 ticks — a 96-second
  /// window. The SERVER holds the "Switching…" marker until Mono confirms or a
  /// THIRTY MINUTE grace elapses (mandateSwitchConfirmGrace in
  /// banking-service). So whenever Mono lagged past a minute and a half the
  /// client simply stopped looking, and the badge sat on "Switching…" until the
  /// user happened to cold-start the app — measured in prod on a mandate whose
  /// status had ALREADY reached its switch target.
  ///
  /// This covers the server's own window instead of a shorter invented one:
  /// fast early ticks because the common case settles in seconds, then
  /// widening gaps so ~31 minutes costs 17 requests rather than 155.
  static const List<Duration> _switchPollSchedule = [
    Duration(seconds: 3),
    Duration(seconds: 5),
    Duration(seconds: 8),
    Duration(seconds: 12),
    Duration(seconds: 20),
    Duration(seconds: 30),
    Duration(seconds: 45),
    Duration(seconds: 60),
    Duration(minutes: 2),
    Duration(minutes: 3),
    Duration(minutes: 4),
    Duration(minutes: 5),
    Duration(minutes: 5),
    Duration(minutes: 5),
  ];

  void pollSwitchUntilSettled({
    required String mandateId,
    required String userId,
  }) {
    _switchPollTimer?.cancel();
    _switchPollMandateId = mandateId;
    var step = 0;

    void scheduleNext() {
      if (isClosed || step >= _switchPollSchedule.length) {
        _switchPollMandateId = null;
        return;
      }
      final delay = _switchPollSchedule[step++];
      _switchPollTimer = Timer(delay, () async {
        if (isClosed) return;
        try {
          final fresh = await _dataSource.getMandate(
              mandateId: mandateId, userId: userId);
          _mandatesByAccountId[fresh.linkedAccountId] = fresh;
          if (!isClosed) {
            emit(UserMandatesLoaded(
                mandates: _mandatesByAccountId.values.toList()));
          }
          if (!fresh.switchProcessing) {
            _switchPollMandateId = null;
            return; // settled — stop
          }
        } catch (_) {
          // best-effort — a transient failure must not end the watch
        }
        scheduleNext();
      });
    }

    scheduleNext();
  }

  /// Restart the switch poll for any cached mandate still mid-switch.
  ///
  /// Called when the deposit screen is shown or resumed. Without it a user who
  /// backgrounded the app, or opened the screen long after the switch, had no
  /// way to see the badge settle short of a cold start: the poll only ever
  /// began inside pause/reinstate, so it did not exist for them.
  ///
  /// No-op when nothing is switching, or when the poll for that mandate is
  /// already running, so repeated screen visits cannot stack timers.
  void resumeSwitchPollingIfNeeded({required String userId}) {
    if (isClosed) return;
    for (final m in _mandatesByAccountId.values) {
      if (!m.switchProcessing) continue;
      if (_switchPollMandateId == m.id) return; // already watching this one
      pollSwitchUntilSettled(mandateId: m.id, userId: userId);
      return; // one at a time — a user has one switch in flight in practice
    }
  }

  /// Prefer active/readyToDebit mandates over others.
  bool _isBetterMandate(MandateEntity candidate, MandateEntity existing) {
    if (candidate.isActive && !existing.isActive) return true;
    if (candidate.isActivating &&
        !existing.isActive &&
        !existing.isActivating) {
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
