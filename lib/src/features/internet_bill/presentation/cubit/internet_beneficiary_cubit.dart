import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';
import '../../domain/entities/internet_beneficiary.dart';
import 'internet_beneficiary_state.dart';

/// Cubit for the internet-scoped saved-contacts surface. Mirrors
/// `DataBeneficiaryCubit` — dedicated state space so the ISP flows
/// don't have to pattern-match against data/airtime states.
class InternetBeneficiaryCubit extends Cubit<InternetBeneficiaryState> {
  final InternetBeneficiaryRemoteDataSource datasource;

  /// Snapshot of the list we last successfully emitted as `Loaded`.
  /// Cached as a field (rather than derived from `state`) because the
  /// mutation paths emit transient `...Saved`/`...Updated`/`...Deleted`
  /// states in between — reading the list off `state` at patch time
  /// would see one of those transients and come back null, which
  /// silently dropped in-place updates before this fix.
  List<InternetBeneficiary>? _cache;

  InternetBeneficiaryCubit({required this.datasource})
      : super(InternetBeneficiaryInitial());

  Future<void> load({String? providerCode}) async {
    if (isClosed) return;
    emit(InternetBeneficiariesLoading());
    try {
      final list =
          await datasource.getBeneficiaries(providerCode: providerCode);
      if (isClosed) return;
      _cache = list;
      emit(InternetBeneficiariesLoaded(beneficiaries: list));
    } catch (e) {
      if (isClosed) return;
      emit(InternetBeneficiaryError(message: _friendly(e)));
    }
  }

  Future<void> save({
    required String accountNumber,
    required String providerCode,
    required String providerName,
    String? nickname,
  }) async {
    try {
      final saved = await datasource.saveBeneficiary(
        accountNumber: accountNumber,
        providerCode: providerCode,
        providerName: providerName,
        nickname: nickname,
      );
      if (isClosed) return;
      emit(InternetBeneficiarySaved(beneficiary: saved));
      // Append the new row to the current loaded list if possible —
      // avoids the Loading state flash. Falls back to a full reload
      // when we don't have a list yet (e.g. save happened before the
      // user ever opened the saved-accounts screen).
      _applyAppend(saved);
    } catch (e) {
      if (isClosed) return;
      emit(InternetBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> update({
    required String beneficiaryId,
    String? nickname,
  }) async {
    try {
      final updated = await datasource.updateBeneficiary(
        beneficiaryId: beneficiaryId,
        nickname: nickname,
      );
      if (isClosed) return;
      emit(InternetBeneficiaryUpdated(beneficiary: updated));
      // Reactively patch the single row — no `await load()` means no
      // full-screen spinner for a one-word nickname change. When the
      // backend returns null (older backends that don't echo the row)
      // we synthesize the patch from the currently-loaded entity +
      // the nickname we just sent; only fall back to a full `load()`
      // if we can't find the row locally either.
      if (updated != null) {
        applyBeneficiaryUpdate(updated);
        return;
      }
      final current = _lastLoaded;
      if (current != null) {
        final idx = current.indexWhere((b) => b.id == beneficiaryId);
        if (idx >= 0) {
          final old = current[idx];
          applyBeneficiaryUpdate(old.copyWithNickname(nickname));
          return;
        }
      }
      await load();
    } catch (e) {
      if (isClosed) return;
      emit(InternetBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  Future<void> delete(String beneficiaryId) async {
    try {
      await datasource.deleteBeneficiary(beneficiaryId);
      if (isClosed) return;
      emit(InternetBeneficiaryDeleted(id: beneficiaryId));
      // Drop the row locally so the list doesn't bounce through a
      // Loading spinner on every delete.
      _applyDelete(beneficiaryId);
    } catch (e) {
      if (isClosed) return;
      emit(InternetBeneficiaryError(message: _friendly(e)));
      rethrow;
    }
  }

  /// Replace one beneficiary in the cached list. No-op if we haven't
  /// loaded anything yet (UI will pick up the change on the next
  /// `load()` call).
  void applyBeneficiaryUpdate(InternetBeneficiary updated) {
    if (isClosed) return;
    final current = _cache;
    if (current == null) return;
    final idx = current.indexWhere((b) => b.id == updated.id);
    if (idx < 0) return;
    final next = List<InternetBeneficiary>.of(current);
    next[idx] = updated;
    _cache = next;
    emit(InternetBeneficiariesLoaded(beneficiaries: next));
  }

  void _applyAppend(InternetBeneficiary added) {
    final current = _cache;
    if (current == null) {
      // No list cached — re-fetch lazily on next load() call.
      return;
    }
    if (current.any((b) => b.id == added.id)) return;
    final next = [...current, added];
    _cache = next;
    emit(InternetBeneficiariesLoaded(beneficiaries: next));
  }

  void _applyDelete(String id) {
    final current = _cache;
    if (current == null) return;
    final next = current.where((b) => b.id != id).toList();
    if (next.length == current.length) return;
    _cache = next;
    emit(InternetBeneficiariesLoaded(beneficiaries: next));
  }

  /// Used by the nickname-update fallback path to synthesise a patch
  /// when the backend didn't echo the row back. Exposed at package
  /// privacy rather than public because it's specific to that code
  /// path and using it elsewhere would obscure the in-place patch.
  List<InternetBeneficiary>? get _lastLoaded => _cache;

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
