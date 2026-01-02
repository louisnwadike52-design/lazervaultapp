import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/card_settings/cubit/card_settings_state.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/card_settings/domain/usecases/get_account_details_usecase.dart';
import 'package:lazervault/src/features/card_settings/domain/usecases/update_account_status_usecase.dart';
import 'package:lazervault/src/features/card_settings/domain/usecases/update_security_settings_usecase.dart';

class CardSettingsCubit extends Cubit<CardSettingsState> {
  final GetAccountDetailsUseCase _getAccountDetailsUseCase;
  final UpdateSecuritySettingsUseCase _updateSecuritySettingsUseCase;
  final UpdateAccountStatusUseCase _updateAccountStatusUseCase;

  // Store account details in memory
  final Map<String, AccountDetailsEntity> _accountDetailsCache = {};

  CardSettingsCubit(
    this._getAccountDetailsUseCase,
    this._updateSecuritySettingsUseCase,
    this._updateAccountStatusUseCase,
  ) : super(CardSettingsInitial());

  /// Get detailed account information for a specific account
  Future<void> getAccountDetails({
    required String accountId,
    String? accessToken,
  }) async {
    if (isClosed) return;
    emit(CardSettingsLoading());

    final result = await _getAccountDetailsUseCase.call(
      accountId: accountId,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(CardSettingsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (accountDetails) {
        _accountDetailsCache[accountId] = accountDetails;
        if (isClosed) return;
        emit(CardSettingsLoaded(_accountDetailsCache));
      },
    );
  }

  /// Update security settings for a specific account
  Future<void> updateSecuritySettings({
    required String accountId,
    required bool enable3dSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
    String? accessToken,
  }) async {
    if (isClosed) return;
    emit(CardSettingsUpdating(accountId, 'security'));

    final result = await _updateSecuritySettingsUseCase.call(
      accountId: accountId,
      enable3dSecure: enable3dSecure,
      enableContactless: enableContactless,
      enableOnlinePayments: enableOnlinePayments,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(CardSettingsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
        // Re-emit loaded state to maintain UI
        if (_accountDetailsCache.isNotEmpty) {
          if (isClosed) return;
          emit(CardSettingsLoaded(_accountDetailsCache));
        }
      },
      (accountDetails) {
        _accountDetailsCache[accountId] = accountDetails;
        if (isClosed) return;
        emit(CardSettingsUpdateSuccess(
          accountDetails,
          'Security settings updated successfully',
        ));
        // Re-emit loaded state with updated data
        if (isClosed) return;
        emit(CardSettingsLoaded(_accountDetailsCache));
      },
    );
  }

  /// Update account status (freeze/unfreeze)
  Future<void> updateAccountStatus({
    required String accountId,
    required String status,
    required String reason,
    String? accessToken,
  }) async {
    if (isClosed) return;
    emit(CardSettingsUpdating(accountId, 'status'));

    final result = await _updateAccountStatusUseCase.call(
      accountId: accountId,
      status: status,
      reason: reason,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(CardSettingsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
        // Re-emit loaded state to maintain UI
        if (_accountDetailsCache.isNotEmpty) {
          if (isClosed) return;
          emit(CardSettingsLoaded(_accountDetailsCache));
        }
      },
      (accountDetails) {
        _accountDetailsCache[accountId] = accountDetails;
        final message = status.toLowerCase() == 'frozen'
            ? 'Card frozen successfully'
            : 'Card unfrozen successfully';
        if (isClosed) return;
        emit(CardSettingsUpdateSuccess(accountDetails, message));
        // Re-emit loaded state with updated data
        if (isClosed) return;
        emit(CardSettingsLoaded(_accountDetailsCache));
      },
    );
  }

  /// Get cached account details without making a network call
  AccountDetailsEntity? getCachedAccountDetails(String accountId) {
    return _accountDetailsCache[accountId];
  }

  /// Check if we have cached details for an account
  bool hasCachedAccountDetails(String accountId) {
    return _accountDetailsCache.containsKey(accountId);
  }

  /// Clear the cache
  void clearCache() {
    _accountDetailsCache.clear();
    if (isClosed) return;
    emit(CardSettingsInitial());
  }
}
