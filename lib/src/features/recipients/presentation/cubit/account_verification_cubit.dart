import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/recipient_verification_remote_datasource.dart';
import '../../domain/entities/account_verification_result.dart';
import '../../data/datasources/lazervault_account_lookup.dart';
import '../../domain/entities/account_suggestion.dart';
import 'account_verification_state.dart';
import '../../../../../core/utilities/banks_data.dart';
import '../../data/models/recipient_model.dart';
import 'package:lazervault/core/utils/destination_account_number.dart';

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

  /// Resolves a typed account number to a LAZERVAULT account, so the bank
  /// flows can offer the internal rail for a number that is on this platform.
  ///
  /// Optional: when absent every method below behaves exactly as it did before
  /// this existed, so a wiring gap costs a suggestion and nothing else.
  final LazervaultAccountLookup? _lazervaultLookup;

  /// The payer's already-loaded saved recipients.
  ///
  /// A PROVIDER rather than a list, because the saved set changes while this
  /// cubit lives — add a payee, then type their number, and a captured list
  /// would not contain them.
  ///
  /// Optional for the same reason as the lookup above: absent means the
  /// suggestion list behaves exactly as it did before, so a wiring gap costs a
  /// convenience and never a payment.
  final List<RecipientModel> Function()? _savedRecipients;

  // Store last verification parameters for retry
  String? _lastBankCode;
  String? _lastAccountNumber;
  String? _lastCountry;

  AccountVerificationCubit({
    required RecipientVerificationRemoteDataSource dataSource,
    LazervaultAccountLookup? lazervaultLookup,
    List<RecipientModel> Function()? savedRecipients,
  })  : _dataSource = dataSource,
        _lazervaultLookup = lazervaultLookup,
        _savedRecipients = savedRecipients,
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

  /// Suggest matching destination(s) for a bare 10-digit account number.
  ///
  /// Powers the account-number-first UX: the backend narrows candidate banks
  /// via the NUBAN check-digit algorithm and resolves the holder name against
  /// each through the admin-selected provider, returning only banks that
  /// resolved. Best-effort and side-effect-free — it does NOT emit cubit
  /// states (so it never disturbs the shared verification state machine other
  /// flows rely on) and returns an empty list on any error, letting the UI
  /// fall back to manual bank selection.
  ///
  /// LAZERVAULT FIRST. If the number is an account on this platform, the
  /// internal destination leads the list. A Lazervault user's receiving number
  /// is a genuine NUBAN at a partner bank, so the external probe below
  /// resolves it too — and before this, that was the ONLY answer the payer
  /// was offered: a NIBSS payout with a fee and a settlement wait, to land in
  /// a wallet the money never had to leave. Both are now offered and the payer
  /// chooses; the internal one is marked (`isLazervault`) so a surface can say
  /// what it is, and must not be auto-applied.
  ///
  /// Run together, not in series: the external probe fans out to a provider
  /// name-enquiry per candidate bank and is the slow half, so the internal
  /// lookup adds no latency the user can feel.
  Future<List<AccountSuggestion>> suggestBanks({
    required String accountNumber,
    String country = 'NG',
  }) async {
    // The same forms the account field accepts, not 10 digits alone.
    //
    // This read `length != 10`, so an 11-digit wallet number — OPay, PalmPay,
    // Moniepoint, all of which assign phone-number-based accounts — returned
    // NOTHING: no saved payee, no internal match, no bank. The field had
    // already been widened to accept them (`maxLength: 11`) and the surface
    // treated the empty result as "could not resolve", so a perfectly valid
    // wallet number silently dropped the payer into manual bank selection.
    // LazervaultAccountLookup.candidatesFor already tries both forms.
    if (!_isCompleteAccountNumber(accountNumber)) {
      return const <AccountSuggestion>[];
    }

    // SAVED RECIPIENTS FIRST, and they cost nothing.
    //
    // The payer's saved set is already in memory (RecipientCubit holds it
    // behind an SWR cache), so this is a list filter, not a round trip — it
    // resolves before the bank name-enquiry has finished opening a socket.
    // That ordering is the point: the overwhelmingly common case for a typed
    // account number is someone the payer has paid before, and making them
    // wait on a provider lookup to be shown a payee they already saved is
    // latency for nothing.
    //
    // The bank lookup still runs. The same ten digits legitimately exist at
    // different institutions, and suppressing the external list would hide a
    // destination the payer may actually want.
    final saved = _savedSuggestions(accountNumber);

    final internalFuture = lazervaultSuggestion(accountNumber: accountNumber);
    List<AccountSuggestion> external = const <AccountSuggestion>[];
    try {
      external = await _dataSource.suggestAccounts(
        accountNumber: accountNumber,
        country: country,
      );
    } catch (_) {
      external = const <AccountSuggestion>[];
    }
    final internal = await internalFuture;

    final ordered = <AccountSuggestion>[
      ...saved,
      if (internal != null) internal,
      ...external,
    ];
    return _dedupeDestinations(ordered);
  }

  /// Whether [v] is a complete destination number: a 10-digit NUBAN, or an
  /// 11-digit wallet number with the leading zero (which core-payments'
  /// `normalizePhoneAccount` reduces to the same NUBAN).
  ///
  /// Held here rather than read from the widget because the cubit is what
  /// decides whether to spend a network call, and the two must agree — they
  /// did not, which is how 11-digit wallet numbers resolved to nothing.
  static bool _isCompleteAccountNumber(String v) =>
      isCompleteDestinationAccount(v);

  /// Saved recipients matching what has been typed SO FAR.
  ///
  /// Synchronous, allocation-light and network-free by design: this is what
  /// the account field calls on every keystroke, and the whole point is that
  /// it answers before anything could be fetched. The payer's saved set is
  /// already in memory (RecipientCubit holds it behind an SWR cache), so this
  /// is a list filter.
  ///
  /// Matching is on DIGITS ONLY, both sides. Saved rows have been written by
  /// several generations of this app and some carry spaces or dashes, so a
  /// literal comparison silently misses them.
  ///
  /// RANKED, not merely filtered. An account number is typed from the left, so
  /// a PREFIX match is what the payer is doing and leads; a CONTAINS match is
  /// kept behind it because people reliably remember the last four digits of a
  /// number whose start they do not. Within each group the saved order is
  /// preserved — it is the payer's own, and re-sorting it by anything we
  /// invented would move payees around under their thumb between keystrokes.
  ///
  /// [limit] caps the rows: this list floats over the form in an overlay, and
  /// a payer with sixty saved payees typing one digit must not be handed a
  /// list taller than the screen.
  List<AccountSuggestion> savedRecipientMatches(
    String typedNumber, {
    int limit = 5,
  }) {
    final provider = _savedRecipients;
    if (provider == null) return const <AccountSuggestion>[];
    final typed = _digitsOnly(typedNumber);
    if (typed.isEmpty || limit <= 0) return const <AccountSuggestion>[];

    final prefix = <AccountSuggestion>[];
    final inner = <AccountSuggestion>[];
    try {
      for (final r in provider()) {
        final digits = _digitsOnly(r.accountNumber);
        if (digits.isEmpty) continue;
        final bucket = digits.startsWith(typed)
            ? prefix
            : (digits.contains(typed) ? inner : null);
        if (bucket == null) continue;
        bucket.add(AccountSuggestion.savedRecipient(
          accountNumber: r.accountNumber,
          accountName: (r.accountHolderName?.trim().isNotEmpty ?? false)
              ? r.accountHolderName!.trim()
              : r.name,
          bankName: r.bankName,
          bankCode: r.sortCode,
          alias: r.alias ?? '',
          internalUserId: r.internalUserId ?? '',
          internalAccountId: r.internalAccountId ?? '',
        ));
      }
    } catch (_) {
      // A provider that throws must cost a convenience, never the suggestion
      // list — the bank results are still perfectly usable.
      return const <AccountSuggestion>[];
    }

    final ordered = _dedupeDestinations(<AccountSuggestion>[...prefix, ...inner]);
    return ordered.length <= limit ? ordered : ordered.sublist(0, limit);
  }

  /// Saved recipients whose account number IS the one typed — the exact-match
  /// subset [savedRecipientMatches] degenerates to once the number is
  /// complete. Kept separate because [suggestBanks] merges this with the bank
  /// results and must not pull in a payee who merely shares a prefix.
  List<AccountSuggestion> _savedSuggestions(String accountNumber) {
    final provider = _savedRecipients;
    if (provider == null) return const <AccountSuggestion>[];
    final typed = _digitsOnly(accountNumber);
    if (typed.isEmpty) return const <AccountSuggestion>[];

    final out = <AccountSuggestion>[];
    try {
      for (final r in provider()) {
        if (_digitsOnly(r.accountNumber) != typed) continue;
        out.add(AccountSuggestion.savedRecipient(
          accountNumber: r.accountNumber,
          accountName: (r.accountHolderName?.trim().isNotEmpty ?? false)
              ? r.accountHolderName!.trim()
              : r.name,
          bankName: r.bankName,
          bankCode: r.sortCode,
          alias: r.alias ?? '',
          internalUserId: r.internalUserId ?? '',
          internalAccountId: r.internalAccountId ?? '',
        ));
      }
    } catch (_) {
      // A provider that throws must cost a convenience, never the suggestion
      // list — the bank results below are still perfectly usable.
      return const <AccountSuggestion>[];
    }
    return out;
  }

  /// Collapses rows that name the SAME destination, keeping the first.
  ///
  /// Order is the priority: saved, then internal, then external. So a payee
  /// the payer already saved suppresses the bank's own row for that account —
  /// which matters because the saved row carries the alias the payer chose and
  /// the account they pinned, while the bank row carries only the registered
  /// name.
  ///
  /// Keyed on bank + digits rather than on the display name, because the two
  /// sources routinely disagree about the name for one real account, which is
  /// exactly the disagreement that would defeat a name-based key.
  static List<AccountSuggestion> _dedupeDestinations(
    List<AccountSuggestion> rows,
  ) {
    final seen = <String>{};
    final out = <AccountSuggestion>[];
    for (final r in rows) {
      final bank = r.isLazervault
          ? 'lazervault'
          : (r.bankCode.trim().isNotEmpty
              ? r.bankCode.trim().toLowerCase()
              : r.bankName.trim().toLowerCase());
      final key = '$bank|${_digitsOnly(r.accountNumber)}';
      if (!seen.add(key)) continue;
      out.add(r);
    }
    return out;
  }

  static String _digitsOnly(String v) => v.replaceAll(RegExp(r'[^0-9]'), '');

  /// The LAZERVAULT destination [accountNumber] names, or null when it is not
  /// an account on this platform (which is the common case).
  ///
  /// Public and separate from [suggestBanks] so the bank-destination surfaces
  /// that have no suggestion list — they select a bank then call
  /// [verifyAccount] directly — can offer the internal rail too without
  /// duplicating the resolution. Side-effect-free and never throws: null is
  /// "treat it as external", exactly as every caller did before.
  Future<AccountSuggestion?> lazervaultSuggestion({
    required String accountNumber,
  }) async {
    final lookup = _lazervaultLookup;
    if (lookup == null) return null;
    try {
      final match = await lookup.resolve(accountNumber);
      if (match == null) return null;
      return AccountSuggestion.lazervault(
        accountNumber: match.accountNumber,
        accountName: match.holderName,
        userId: match.userId,
        accountId: match.accountId,
      );
    } catch (_) {
      return null;
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
