import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/recipient_verification_remote_datasource.dart';
import 'account_verification_state.dart';
import '../../../../../core/utilities/banks_data.dart';

/// Cubit for managing account verification state.
///
/// Handles verification of bank account details via Paystack API,
/// with comprehensive error handling and retry logic.
class AccountVerificationCubit extends Cubit<AccountVerificationState> {
  final RecipientVerificationRemoteDataSource _dataSource;

  // Store last verification parameters for retry
  String? _lastBankCode;
  String? _lastAccountNumber;
  String? _lastCountry;

  AccountVerificationCubit({
    required RecipientVerificationRemoteDataSource dataSource,
  })  : _dataSource = dataSource,
        super(const AccountVerificationInitial());

  /// Verify a bank account and fetch account holder name.
  ///
  /// Emits [AccountVerificationLoading] while processing,
  /// [AccountVerificationSuccess] on success,
  /// or [AccountVerificationFailure] on error.
  Future<void> verifyAccount({
    required String bankCode,
    required String accountNumber,
    required String bankName,
    String country = 'NG',
  }) async {
    if (isClosed) return;

    // Store parameters for potential retry
    _lastBankCode = bankCode;
    _lastAccountNumber = accountNumber;
    _lastCountry = country;

    // Emit loading state
    emit(AccountVerificationLoading(
      accountNumber: accountNumber,
      bankName: bankName,
      bankCode: bankCode,
    ));

    try {
      // Call API to verify account
      final result = await _dataSource.verifyAccount(
        bankCode: bankCode,
        accountNumber: accountNumber,
        country: country,
      );

      if (isClosed) return;

      // Emit success state
      emit(AccountVerificationSuccess(
        accountNumber: result.accountNumber,
        accountName: result.accountName,
        bankName: result.bankName,
        bankCode: result.bankCode,
        verificationStatus: result.verificationStatus,
      ));
    } on AccountNotFoundException catch (e) {
      if (isClosed) return;
      emit(AccountVerificationFailure(
        errorCode: 'ACCOUNT_NOT_FOUND',
        message: e.toString(),
        userMessage: e.message,
        allowManualEntry: false,
        accountNumber: accountNumber,
        bankCode: bankCode,
      ));
    } on RateLimitException catch (e) {
      if (isClosed) return;
      emit(AccountVerificationFailure(
        errorCode: 'RATE_LIMIT_EXCEEDED',
        message: e.toString(),
        userMessage: e.message,
        allowManualEntry: false,
        accountNumber: accountNumber,
        bankCode: bankCode,
      ));
    } on NetworkException catch (e) {
      if (isClosed) return;
      emit(AccountVerificationFailure(
        errorCode: 'NETWORK_ERROR',
        message: e.toString(),
        userMessage: e.message,
        allowManualEntry: true,
        accountNumber: accountNumber,
        bankCode: bankCode,
      ));
    } on VerificationException catch (e) {
      if (isClosed) return;
      emit(AccountVerificationFailure(
        errorCode: e.errorCode ?? 'VERIFICATION_FAILED',
        message: e.toString(),
        userMessage: e.message,
        allowManualEntry: true,
        accountNumber: accountNumber,
        bankCode: bankCode,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(AccountVerificationFailure(
        errorCode: 'UNKNOWN_ERROR',
        message: e.toString(),
        userMessage: 'An unexpected error occurred. Please try again.',
        allowManualEntry: true,
        accountNumber: accountNumber,
        bankCode: bankCode,
      ));
    }
  }

  /// Retry the last failed verification.
  ///
  /// Only works if there was a previous verification attempt.
  /// Returns false if no previous attempt exists.
  Future<bool> retryVerification({required String bankName}) async {
    if (_lastBankCode == null ||
        _lastAccountNumber == null ||
        _lastCountry == null) {
      return false;
    }

    await verifyAccount(
      bankCode: _lastBankCode!,
      accountNumber: _lastAccountNumber!,
      bankName: bankName,
      country: _lastCountry!,
    );

    return true;
  }

  /// Reset to initial state.
  ///
  /// Clears any verification data and error states.
  void reset() {
    if (isClosed) return;
    _lastBankCode = null;
    _lastAccountNumber = null;
    _lastCountry = null;
    emit(const AccountVerificationInitial());
  }

  /// Get list of supported banks for a country.
  ///
  /// Returns list of banks with their codes and names from local configuration.
  /// No API calls - all data comes from local BanksData config.
  List<Map<String, String>> getSupportedBanks({
    String country = 'NG',
  }) {
    return BanksData.getBanksForCountry(country);
  }

  @override
  Future<void> close() {
    _dataSource.dispose();
    return super.close();
  }
}
