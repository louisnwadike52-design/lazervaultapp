import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/account_actions/domain/entities/document_entity.dart';
import 'package:lazervault/src/features/account_actions/domain/repositories/i_account_actions_repository.dart';
import 'account_actions_state.dart';

/// Cubit for managing account actions (card settings, security, limits, documents)
class AccountActionsCubit extends Cubit<AccountActionsState> {
  final IAccountActionsRepository _repository;

  // Cache for account details
  final Map<String, AccountDetailsEntity> _accountDetailsCache = {};

  AccountActionsCubit(this._repository) : super(AccountActionsInitial());

  /// Get account details
  Future<void> getAccountDetails({
    required String accountId,
    String? accessToken,
  }) async {
    if (isClosed) return;
    emit(AccountActionsLoading());

    final result = await _repository.getAccountDetails(
      accountId: accountId,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (accountDetails) {
        _accountDetailsCache[accountId] = accountDetails;
        if (isClosed) return;
        emit(AccountDetailsLoaded(accountDetails));
      },
    );
  }

  /// Freeze account
  Future<void> freezeAccount({
    required String accountId,
    String? reason,
    String? accessToken,
  }) async {
    if (isClosed) return;

    var currentDetails = _accountDetailsCache[accountId];
    if (currentDetails == null) {
      // Fetch details first
      await getAccountDetails(accountId: accountId, accessToken: accessToken);
      if (state is! AccountDetailsLoaded) return;
      currentDetails = (state as AccountDetailsLoaded).accountDetails;
    }

    emit(AccountFreezing(currentDetails!));

    final result = await _repository.updateAccountStatus(
      accountId: accountId,
      action: AccountStatusAction.freeze,
      reason: reason,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
        // Re-emit loaded state on error
        if (_accountDetailsCache.containsKey(accountId) && isClosed) return;
        emit(AccountDetailsLoaded(currentDetails!));
      },
      (updatedDetails) {
        _accountDetailsCache[accountId] = updatedDetails;
        if (isClosed) return;
        emit(AccountFrozen(updatedDetails));
      },
    );
  }

  /// Unfreeze account
  Future<void> unfreezeAccount({
    required String accountId,
    String? accessToken,
  }) async {
    if (isClosed) return;

    final currentDetails = _accountDetailsCache[accountId];
    if (currentDetails == null) {
      await getAccountDetails(accountId: accountId, accessToken: accessToken);
      if (state is! AccountDetailsLoaded) return;
    }

    final result = await _repository.updateAccountStatus(
      accountId: accountId,
      action: AccountStatusAction.unfreeze,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
        // Re-emit loaded state on error
        final cached = _accountDetailsCache[accountId];
        if (cached != null && !isClosed) {
          emit(AccountDetailsLoaded(cached));
        }
      },
      (updatedDetails) {
        _accountDetailsCache[accountId] = updatedDetails;
        if (isClosed) return;
        emit(AccountUnfrozen(updatedDetails));
      },
    );
  }

  /// Temporarily block card
  Future<void> temporarilyBlockCard({
    required String accountId,
    String? reason,
    String? accessToken,
  }) async {
    if (isClosed) return;

    final result = await _repository.updateAccountStatus(
      accountId: accountId,
      action: AccountStatusAction.temporarilyBlock,
      reason: reason ?? 'User requested temporary block',
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (updatedDetails) {
        _accountDetailsCache[accountId] = updatedDetails;
        if (isClosed) return;
        emit(AccountFrozen(
          updatedDetails,
          message: 'Card temporarily blocked',
        ));
      },
    );
  }

  /// Permanently block card
  Future<void> permanentlyBlockCard({
    required String accountId,
    String? reason,
    String? accessToken,
  }) async {
    if (isClosed) return;

    final result = await _repository.updateAccountStatus(
      accountId: accountId,
      action: AccountStatusAction.permanentlyBlock,
      reason: reason ?? 'User requested permanent block',
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (updatedDetails) {
        _accountDetailsCache[accountId] = updatedDetails;
        if (isClosed) return;
        emit(AccountFrozen(
          updatedDetails,
          message: 'Card permanently blocked',
        ));
      },
    );
  }

  /// Report stolen card
  Future<void> reportStolenCard({
    required String accountId,
    String? reason,
    String? accessToken,
  }) async {
    if (isClosed) return;

    final result = await _repository.updateAccountStatus(
      accountId: accountId,
      action: AccountStatusAction.reportStolen,
      reason: reason ?? 'Card reported as stolen',
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (updatedDetails) {
        _accountDetailsCache[accountId] = updatedDetails;
        if (isClosed) return;
        emit(AccountFrozen(
          updatedDetails,
          message: 'Card reported as stolen. A replacement will be shipped to your registered address.',
        ));
      },
    );
  }

  /// Update security settings
  Future<void> updateSecuritySettings({
    required String accountId,
    required bool enable3DSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
    required bool enableATMWithdrawals,
    required bool enableInternationalPayments,
    String? accessToken,
  }) async {
    if (isClosed) return;

    final currentDetails = _accountDetailsCache[accountId];
    if (currentDetails == null) {
      await getAccountDetails(accountId: accountId, accessToken: accessToken);
      if (state is! AccountDetailsLoaded) return;
    }

    emit(SecuritySettingsUpdating(currentDetails ?? _accountDetailsCache[accountId]!));

    final result = await _repository.updateSecuritySettings(
      accountId: accountId,
      enable3DSecure: enable3DSecure,
      enableContactless: enableContactless,
      enableOnlinePayments: enableOnlinePayments,
      enableATMWithdrawals: enableATMWithdrawals,
      enableInternationalPayments: enableInternationalPayments,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
        // Re-emit loaded state on error
        final cached = _accountDetailsCache[accountId];
        if (cached != null && !isClosed) {
          emit(AccountDetailsLoaded(cached));
        }
      },
      (updatedDetails) {
        _accountDetailsCache[accountId] = updatedDetails;
        if (isClosed) return;
        emit(SecuritySettingsUpdated(updatedDetails));
      },
    );
  }

  /// Update a single security setting
  Future<void> toggleSecuritySetting({
    required String accountId,
    required String setting, // '3DSecure', 'Contactless', 'OnlinePayments', 'ATMWithdrawals', 'InternationalPayments'
    String? accessToken,
  }) async {
    final currentDetails = _accountDetailsCache[accountId];
    if (currentDetails == null) {
      await getAccountDetails(accountId: accountId, accessToken: accessToken);
      if (state is! AccountDetailsLoaded) return;
    }

    final details = _accountDetailsCache[accountId]!;

    // Toggle the specific setting
    await updateSecuritySettings(
      accountId: accountId,
      enable3DSecure: setting == '3DSecure' ? !details.enable3DSecure : details.enable3DSecure,
      enableContactless: setting == 'Contactless' ? !details.enableContactless : details.enableContactless,
      enableOnlinePayments: setting == 'OnlinePayments' ? !details.enableOnlinePayments : details.enableOnlinePayments,
      enableATMWithdrawals: setting == 'ATMWithdrawals' ? !details.enableATMWithdrawals : details.enableATMWithdrawals,
      enableInternationalPayments: setting == 'InternationalPayments' ? !details.enableInternationalPayments : details.enableInternationalPayments,
      accessToken: accessToken,
    );
  }

  /// Update spending limits
  Future<void> updateSpendingLimits({
    required String accountId,
    double? dailyLimit,
    double? monthlyLimit,
    double? singleTransactionLimit,
    String? accessToken,
  }) async {
    if (isClosed) return;

    final currentDetails = _accountDetailsCache[accountId];
    if (currentDetails == null) {
      await getAccountDetails(accountId: accountId, accessToken: accessToken);
      if (state is! AccountDetailsLoaded) return;
    }

    emit(SpendingLimitsUpdating(currentDetails ?? _accountDetailsCache[accountId]!));

    final result = await _repository.updateSpendingLimits(
      accountId: accountId,
      dailyLimit: dailyLimit,
      monthlyLimit: monthlyLimit,
      singleTransactionLimit: singleTransactionLimit,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
        // Re-emit loaded state on error
        final cached = _accountDetailsCache[accountId];
        if (cached != null && !isClosed) {
          emit(AccountDetailsLoaded(cached));
        }
      },
      (updatedDetails) {
        _accountDetailsCache[accountId] = updatedDetails;
        if (isClosed) return;
        emit(SpendingLimitsUpdated(updatedDetails));
      },
    );
  }

  /// Reveal PIN
  Future<void> revealPIN({
    required String accountId,
    required String transactionPin,
    String? accessToken,
  }) async {
    if (isClosed) return;

    final currentDetails = _accountDetailsCache[accountId];
    if (currentDetails == null) {
      await getAccountDetails(accountId: accountId, accessToken: accessToken);
      if (state is! AccountDetailsLoaded) return;
    }

    emit(PINRevealing(_accountDetailsCache[accountId]!));

    final result = await _repository.revealPIN(
      accountId: accountId,
      transactionPin: transactionPin,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
        // Re-emit loaded state on error
        final cached = _accountDetailsCache[accountId];
        if (cached != null && !isClosed) {
          emit(AccountDetailsLoaded(cached));
        }
      },
      (pin) {
        if (isClosed) return;
        // Auto-hide after 30 seconds
        final expiresAt = DateTime.now().add(const Duration(seconds: 30));
        emit(PINRevealed(_accountDetailsCache[accountId]!, pin, expiresAt: expiresAt));

        // Auto-hide timer
        Future.delayed(const Duration(seconds: 30), () {
          if (!isClosed && state is PINRevealed) {
            emit(AccountDetailsLoaded(_accountDetailsCache[accountId]!));
          }
        });
      },
    );
  }

  /// Reveal card details
  Future<void> revealCardDetails({
    required String accountId,
    required String transactionPin,
    String? accessToken,
  }) async {
    if (isClosed) return;

    final currentDetails = _accountDetailsCache[accountId];
    if (currentDetails == null) {
      await getAccountDetails(accountId: accountId, accessToken: accessToken);
      if (state is! AccountDetailsLoaded) return;
    }

    emit(CardDetailsRevealing(_accountDetailsCache[accountId]!));

    final result = await _repository.revealCardDetails(
      accountId: accountId,
      transactionPin: transactionPin,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
        // Re-emit loaded state on error
        final cached = _accountDetailsCache[accountId];
        if (cached != null && !isClosed) {
          emit(AccountDetailsLoaded(cached));
        }
      },
      (cardDetails) {
        if (isClosed) return;
        emit(CardDetailsRevealed(
          accountDetails: _accountDetailsCache[accountId]!,
          cardNumber: cardDetails.cardNumber,
          expiryDate: cardDetails.expiryDate,
          cvv: cardDetails.cvv,
        ));
      },
    );
  }

  /// Download account statement
  Future<void> downloadAccountStatement({
    required String accountId,
    required DateTime startDate,
    required DateTime endDate,
    DocumentFormat format = DocumentFormat.pdf,
    String? accessToken,
  }) async {
    if (isClosed) return;
    emit(const DocumentDownloading('Account Statement'));

    final result = await _repository.downloadAccountStatement(
      accountId: accountId,
      startDate: startDate,
      endDate: endDate,
      format: format,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (document) {
        if (isClosed) return;
        emit(const DocumentDownloaded(
          DocumentEntity(
            id: 'stmt_123',
            title: 'Account Statement',
            description: 'Your monthly account statement',
            type: DocumentType.accountStatement,
            format: DocumentFormat.pdf,
          ),
        ));
      },
    );
  }

  /// Download account confirmation letter
  Future<void> downloadAccountConfirmation({
    required String accountId,
    String? accessToken,
  }) async {
    if (isClosed) return;
    emit(const DocumentDownloading('Account Confirmation'));

    final result = await _repository.downloadAccountConfirmation(
      accountId: accountId,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (document) {
        if (isClosed) return;
        emit(DocumentDownloaded(document));
      },
    );
  }

  /// Request proof of funds
  Future<void> requestProofOfFunds({
    required String accountId,
    String? accessToken,
  }) async {
    if (isClosed) return;
    emit(const DocumentDownloading('Proof of Funds'));

    final result = await _repository.requestProofOfFunds(
      accountId: accountId,
      accessToken: accessToken,
    );

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(AccountActionsError(
          failure.message,
          statusCode: failure.statusCode,
        ));
      },
      (document) {
        if (isClosed) return;
        emit(DocumentDownloaded(document));
      },
    );
  }

  /// Get cached account details
  AccountDetailsEntity? getCachedDetails(String accountId) {
    return _accountDetailsCache[accountId];
  }

  /// Clear cache
  void clearCache() {
    _accountDetailsCache.clear();
    if (!isClosed) {
      emit(AccountActionsInitial());
    }
  }

  /// Reset to loaded state (after error or success)
  void resetToLoaded(String accountId) {
    final cached = _accountDetailsCache[accountId];
    if (cached != null && !isClosed) {
      emit(AccountDetailsLoaded(cached));
    }
  }
}
