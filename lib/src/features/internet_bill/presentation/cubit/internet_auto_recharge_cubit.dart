import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';
import '../../domain/entities/internet_auto_recharge.dart';
import 'internet_auto_recharge_state.dart';

/// Cubit for managing internet "Rollover" (auto-recharge) schedules.
/// Mirrors `DataAutoRechargeCubit`. Each schedule re-buys the SAME
/// internet package (`packageId` + `planName`) at a recurring cadence —
/// package-locked by design so users don't get surprise pricing when
/// ISPs retire packages.
///
/// Mutations are reactive: create/update/pause/resume/delete all patch
/// the currently-loaded list in place and emit a fresh
/// `InternetAutoRechargesLoaded` — the `InternetAutoRechargesLoading`
/// state only fires on explicit `load()` calls, so a pause tap never
/// blanks the whole list to a spinner.
class InternetAutoRechargeCubit extends Cubit<InternetAutoRechargeState> {
  final InternetBeneficiaryRemoteDataSource datasource;

  InternetAutoRechargeCubit({required this.datasource})
      : super(InternetAutoRechargeInitial());

  /// Last list we successfully emitted as `Loaded`. Mutations read this
  /// as the source of truth for in-place patches; when null (we've
  /// never loaded yet) the mutation falls back to a full `load()` so
  /// the UI still converges.
  List<InternetAutoRecharge>? _lastLoaded;

  /// Monotonic revision tag bumped on every local mutation. Used by
  /// `_silentReload` to detect and discard its own response when a
  /// later mutation has already patched the list — otherwise a
  /// silent-reload in flight could resurrect a just-deleted row or
  /// clobber a later pause/resume flip with pre-mutation server data.
  int _revision = 0;

  Future<void> load({String? status}) async {
    if (isClosed) return;
    emit(InternetAutoRechargesLoading());
    try {
      final list = await datasource.getAutoRecharges(status: status);
      if (isClosed) return;
      _lastLoaded = list;
      emit(InternetAutoRechargesLoaded(autoRecharges: list));
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
    }
  }

  /// Silent variant of [load] that refreshes the list without flashing
  /// the `Loading` state. Used by pause/resume to reconcile any
  /// backend-side fields we can't easily synthesise client-side (e.g.
  /// the recomputed `nextRunDate` on resume). Swallows errors because
  /// the optimistic patch is already visible — a stale reconcile is
  /// better than bouncing the UI.
  ///
  /// Captures [_revision] at call time and discards its own emission
  /// if another mutation has advanced the revision while we were in
  /// flight. Without this guard, a delete tapped during an in-flight
  /// pause's silent reload would see its row reappear in the list for
  /// ~half a second before the next reload cleared it again.
  Future<void> _silentReload() async {
    if (isClosed) return;
    final stamp = _revision;
    try {
      final list = await datasource.getAutoRecharges();
      if (isClosed) return;
      if (stamp != _revision) return;
      _lastLoaded = list;
      emit(InternetAutoRechargesLoaded(autoRecharges: list));
    } catch (_) {
      // Ignore — the optimistic patch is still in place.
    }
  }

  Future<void> create({
    required String beneficiaryId,
    required String packageId,
    required String planName,
    required double amount,
    required String currency,
    required String frequency,
    int dayOfWeek = 0,
    int dayOfMonth = 1,
    int maxRetries = 3,
    int? executionHour,
    int? executionMinute,
  }) async {
    if (isClosed) return;
    try {
      final created = await datasource.createAutoRecharge(
        beneficiaryId: beneficiaryId,
        packageId: packageId,
        planName: planName,
        amount: amount,
        currency: currency,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
        executionHour: executionHour,
        executionMinute: executionMinute,
      );
      if (isClosed) return;
      _appendOrReload(created);
      emit(const InternetAutoRechargeMutated(message: 'Rollover scheduled'));
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> update({
    required String autoRechargeId,
    String? packageId,
    String? planName,
    double? amount,
    String? frequency,
    int? dayOfWeek,
    int? dayOfMonth,
    int? maxRetries,
    int? executionHour,
    int? executionMinute,
  }) async {
    if (isClosed) return;
    try {
      final updated = await datasource.updateAutoRecharge(
        autoRechargeId: autoRechargeId,
        packageId: packageId,
        planName: planName,
        amount: amount,
        frequency: frequency,
        dayOfWeek: dayOfWeek,
        dayOfMonth: dayOfMonth,
        maxRetries: maxRetries,
        executionHour: executionHour,
        executionMinute: executionMinute,
      );
      if (isClosed) return;
      applyAutoRechargeUpdate(updated);
      emit(const InternetAutoRechargeMutated(message: 'Rollover updated'));
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> pause(String id) async {
    if (isClosed) return;
    try {
      await datasource.pauseAutoRecharge(id);
      if (isClosed) return;
      // Optimistic in-place flip so the row's badge turns orange
      // immediately. Then silent-reload to reconcile server-side
      // fields (LastRunDate, etc.).
      _flipStatus(id, 'paused');
      emit(const InternetAutoRechargeMutated(message: 'Rollover paused'));
      await _silentReload();
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> resume(String id) async {
    if (isClosed) return;
    try {
      await datasource.resumeAutoRecharge(id);
      if (isClosed) return;
      _flipStatus(id, 'active');
      emit(const InternetAutoRechargeMutated(message: 'Rollover resumed'));
      // Server recomputes NextRunDate on resume — silent reload pulls
      // the new value so the details dialog shows the right time.
      await _silentReload();
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    if (isClosed) return;
    try {
      await datasource.deleteAutoRecharge(id);
      if (isClosed) return;
      applyAutoRechargeDelete(id);
      emit(const InternetAutoRechargeMutated(message: 'Rollover deleted'));
    } catch (e) {
      if (isClosed) return;
      emit(InternetAutoRechargeError(message: _friendly(e)));
      rethrow;
    }
  }

  // -------------------------------------------------------------------
  // In-place patch helpers — keep the list widget rebuilding off fresh
  // `Loaded` emissions rather than bouncing through `Loading`.
  // -------------------------------------------------------------------

  /// Replace a single auto-recharge in the loaded list. Public so
  /// external flows (e.g. an edit screen that returns the freshly-
  /// updated entity) can drive the patch without re-querying.
  void applyAutoRechargeUpdate(InternetAutoRecharge updated) {
    if (isClosed) return;
    final current = _lastLoaded;
    if (current == null) return;
    final idx = current.indexWhere((ar) => ar.id == updated.id);
    if (idx < 0) return;
    final next = List<InternetAutoRecharge>.of(current);
    next[idx] = updated;
    _lastLoaded = next;
    _revision++;
    emit(InternetAutoRechargesLoaded(autoRecharges: next));
  }

  /// Drop a row from the loaded list. No-op when the id isn't present.
  void applyAutoRechargeDelete(String id) {
    if (isClosed) return;
    final current = _lastLoaded;
    if (current == null) return;
    final next = current.where((ar) => ar.id != id).toList();
    if (next.length == current.length) return;
    _lastLoaded = next;
    _revision++;
    emit(InternetAutoRechargesLoaded(autoRecharges: next));
  }

  void _appendOrReload(InternetAutoRecharge created) {
    final current = _lastLoaded;
    if (current == null) {
      // No cached list — re-fetch lazily so the new row appears next
      // time the screen opens. Fires a silent reload instead of the
      // visible one so we don't strobe the list for a create that
      // happened from another surface.
      _silentReload();
      return;
    }
    if (current.any((ar) => ar.id == created.id)) return;
    final next = [...current, created];
    _lastLoaded = next;
    _revision++;
    emit(InternetAutoRechargesLoaded(autoRecharges: next));
  }

  /// Flip the status of a row locally. The caller follows up with a
  /// silent reload to sync the server-side fields we can't derive on
  /// the client (recomputed NextRunDate, etc.).
  void _flipStatus(String id, String newStatus) {
    final current = _lastLoaded;
    if (current == null) return;
    final idx = current.indexWhere((ar) => ar.id == id);
    if (idx < 0) return;
    final old = current[idx];
    final next = List<InternetAutoRecharge>.of(current);
    next[idx] = InternetAutoRecharge(
      id: old.id,
      userId: old.userId,
      beneficiaryId: old.beneficiaryId,
      accountNumber: old.accountNumber,
      providerCode: old.providerCode,
      providerName: old.providerName,
      packageId: old.packageId,
      planName: old.planName,
      amount: old.amount,
      currency: old.currency,
      frequency: old.frequency,
      dayOfWeek: old.dayOfWeek,
      dayOfMonth: old.dayOfMonth,
      executionHour: old.executionHour,
      executionMinute: old.executionMinute,
      nextRunDate: old.nextRunDate,
      lastRunDate: old.lastRunDate,
      status: newStatus,
      failureCount: old.failureCount,
      maxRetries: old.maxRetries,
      createdAt: old.createdAt,
      beneficiary: old.beneficiary,
    );
    _lastLoaded = next;
    _revision++;
    emit(InternetAutoRechargesLoaded(autoRecharges: next));
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
