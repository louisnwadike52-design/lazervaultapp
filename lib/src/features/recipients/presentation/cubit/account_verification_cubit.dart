import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/recipient_verification_remote_datasource.dart';
import '../../domain/entities/account_verification_result.dart';
import '../../domain/entities/account_suggestion.dart';
import 'account_verification_state.dart';
import '../../../../../core/utilities/banks_data.dart';

/// Process-local verification cache.
///
/// Bank name-enquiry is the slowest single RPC in the SendFunds flow
/// (~800ms-2s against Paystack/Flutterwave sandbox on Nigerian 4G). The
/// (bank_code, account_number) → account_name mapping is stable for the
/// lifetime of an open account, so caching for 30 minutes avoids paying
/// the cost again when a user re-enters the same recipient (e.g. typo
/// then corrects back, or comes back to the screen).
///
/// Why 30 min (not longer): Paystack itself may rate-limit our test-mode
/// resolves; aggressive caching also masks closed/frozen accounts. 30
/// min is short enough that a closed account surfaces within one user
/// session, long enough to cover the rapid-iteration flow.
///
/// Why in-memory (not Hive): names are PII-adjacent. Persisting them to
/// disk widens the data-at-rest surface for marginal benefit (app-restart
/// cache hits are rare on this screen). Kept process-local.
class _VerificationCache {
  static final Map<String, _CacheEntry> _entries = {};
  static const Duration _ttl = Duration(minutes: 30);

  static String _key(String bankCode, String accountNumber, String country) =>
      '$country:$bankCode:$accountNumber';

  static AccountVerificationResult? get(
      String bankCode, String accountNumber, String country) {
    final entry = _entries[_key(bankCode, accountNumber, country)];
    if (entry == null) return null;
    if (DateTime.now().isAfter(entry.expiresAt)) {
      _entries.remove(_key(bankCode, accountNumber, country));
      return null;
    }
    return entry.result;
  }

  static void put(String bankCode, String accountNumber, String country,
      AccountVerificationResult result) {
    _entries[_key(bankCode, accountNumber, country)] = _CacheEntry(
      result: result,
      expiresAt: DateTime.now().add(_ttl),
    );
  }
}

class _CacheEntry {
  final AccountVerificationResult result;
  final DateTime expiresAt;
  const _CacheEntry({required this.result, required this.expiresAt});
}

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

    // Cache hit short-circuit. Same (country, bankCode, accountNumber)
    // tuple resolved within the last 30min is reused — saves a network
    // round-trip on Nigerian 4G + dodges the Paystack test-mode daily-
    // resolve rate limit on the same recipient.
    final cached = _VerificationCache.get(bankCode, accountNumber, country);
    if (cached != null) {
      emit(AccountVerificationSuccess(
        accountNumber: cached.accountNumber,
        accountName: cached.accountName,
        bankName: cached.bankName,
        bankCode: cached.bankCode,
        verificationStatus: cached.verificationStatus,
      ));
      return;
    }

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

      // Cache successful verifications only — failures should re-query
      // so the user gets up-to-date error reasons.
      _VerificationCache.put(bankCode, accountNumber, country, result);

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

  /// Suggest matching bank(s) for a bare 10-digit account number.
  ///
  /// Powers the account-number-first UX: the backend narrows candidate banks
  /// via the NUBAN check-digit algorithm and resolves the holder name against
  /// each through the admin-selected provider, returning only banks that
  /// resolved. Best-effort and side-effect-free — it does NOT emit cubit
  /// states (so it never disturbs the shared verification state machine other
  /// flows rely on) and returns an empty list on any error, letting the UI
  /// fall back to manual bank selection.
  Future<List<AccountSuggestion>> suggestBanks({
    required String accountNumber,
    String country = 'NG',
  }) async {
    if (accountNumber.length != 10) return const <AccountSuggestion>[];
    try {
      return await _dataSource.suggestAccounts(
        accountNumber: accountNumber,
        country: country,
      );
    } catch (_) {
      return const <AccountSuggestion>[];
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
