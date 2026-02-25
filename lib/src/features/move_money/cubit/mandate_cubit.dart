import 'package:flutter_bloc/flutter_bloc.dart';
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
    } catch (e) {
      emit(MandateError(message: 'Failed to create mandate: $e'));
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

      emit(UserMandatesLoaded(mandates: mandates));
    } catch (e) {
      // Silently fail — mandates are optional enhancement
      emit(UserMandatesLoaded(mandates: []));
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
    } catch (e) {
      emit(MandateError(message: 'Failed to pause mandate: $e'));
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
    } catch (e) {
      emit(MandateError(message: 'Failed to reinstate mandate: $e'));
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
    } catch (e) {
      emit(MandateError(message: 'Failed to cancel mandate: $e'));
    } finally {
      _operationInProgress = false;
    }
  }

  /// Prefer active/readyToDebit mandates over others.
  bool _isBetterMandate(MandateEntity candidate, MandateEntity existing) {
    if (candidate.isActive && !existing.isActive) return true;
    if (candidate.isActivating && !existing.isActive && !existing.isActivating) {
      return true;
    }
    return false;
  }
}
