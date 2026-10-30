import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/masked_account_number.dart';
import 'package:lazervault/src/features/profile/domain/repositories/i_profile_repository.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;

/// A Lazervault account resolved FROM A BARE ACCOUNT NUMBER.
///
/// [accountId] — not [accountNumber] — is the destination identity. A receiving
/// number is a virtual account minted by whichever provider is active, so the
/// server re-projects the number, the bank and the holder name from this id on
/// every read (see `RecipientModel.internalAccountId`).
class LazervaultAccountMatch {
  /// accounts-service account UUID — the account the money lands in.
  final String accountId;

  /// The owning user's UUID — what the internal transfer rail routes on.
  final String userId;

  /// The number as the SERVER returned it, which is the number the payer
  /// should be shown. Not necessarily byte-identical to what they typed: an
  /// 11-digit wallet-phone form resolves to the 10-digit NUBAN.
  final String accountNumber;

  /// The account holder's real name.
  final String holderName;

  /// The payee's `@handle`, when the directory knew one. Empty is normal —
  /// a user matched by account number need never have set a username.
  final String username;
  final String profilePicture;
  final String currency;

  const LazervaultAccountMatch({
    required this.accountId,
    required this.userId,
    required this.accountNumber,
    required this.holderName,
    this.username = '',
    this.profilePicture = '',
    this.currency = '',
  });

  /// `•••• 7890` — what every surface must show next to [holderName] so the
  /// payer can see WHICH account is about to receive the money.
  String get masked => maskedAccountNumber(accountNumber);
}

/// Resolves a typed ACCOUNT NUMBER to the Lazervault account it names.
///
/// WHY THIS EXISTS: every bank-destination surface in the app sent a typed
/// account number straight to an external NUBAN name-enquiry, and the user
/// directory (auth-service `SearchUsers`) has no account-number mode at all —
/// it searches `users`, which does not hold account numbers. So a payer who
/// had been given their payee's Lazervault account number — the identifier a
/// payee is most likely to hand out — could not find them by it, and typing it
/// into the bank field routed the money out over NIBSS with a fee, for a
/// transfer that needed neither.
///
/// The resolution itself already existed and is reused rather than reinvented:
/// `accounts.AccountsService/GetAccountByNumber` (proxied by core-gateway,
/// ownership check deliberately skipped — it is a lookup), which the P2P chat
/// icon already calls to turn a saved recipient's number into a user id. The
/// only thing added here is that it now runs BEFORE the internal-vs-external
/// decision rather than after it.
///
/// Every failure mode returns null. A number that does not resolve is simply
/// "not a Lazervault account", which is the overwhelmingly common case and
/// must cost the caller nothing — no error surface, no blocked flow.
class LazervaultAccountLookup {
  final accounts_grpc.AccountsServiceClient _accounts;
  final GrpcCallOptionsHelper _callOptions;
  final SecureStorageService _secureStorage;

  /// Optional enrichment. The account row carries the holder name, which is
  /// all any surface strictly needs; the directory adds the `@handle` and the
  /// avatar. When it is absent or returns nothing the match still stands.
  final IProfileRepository? _profiles;

  LazervaultAccountLookup({
    required accounts_grpc.AccountsServiceClient accountsClient,
    required GrpcCallOptionsHelper callOptionsHelper,
    required SecureStorageService secureStorage,
    IProfileRepository? profileRepository,
  })  : _accounts = accountsClient,
        _callOptions = callOptionsHelper,
        _secureStorage = secureStorage,
        _profiles = profileRepository;

  // ---- shape detection -----------------------------------------------------

  static final RegExp _digitsOnly = RegExp(r'^[0-9]+$');

  /// [raw] with the separators people actually type removed — nothing else.
  ///
  /// Deliberately NOT "strip every non-digit": that would turn `praiz1234567`
  /// into a 7-digit "account number" and send a name search off to an account
  /// lookup. Separators are removed because a number read off a screenshot is
  /// often pasted as `0123 456 789`; everything else has to already be a digit
  /// for [looksLikeAccountNumber] to say yes.
  static String compact(String raw) =>
      raw.replaceAll(RegExp(r'[\s\-]'), '').trim();

  /// Whether [raw] is shaped like an account number, i.e. nothing but digits.
  ///
  /// The point of a shape test rather than a mode picker is that the payer
  /// should not have to tell us what kind of identifier they are holding. The
  /// cost of guessing wrong is why the caller must keep its existing search
  /// too: an 11-digit string is a perfectly good Nigerian PHONE number as well
  /// as a wallet account number, so BOTH are looked up and the results are
  /// labelled, rather than one of them being chosen on the user's behalf.
  ///
  /// Bounds: 8 (the shortest real account number we take — UK) to 11 (the
  /// Nigerian wallet-phone form). Below 8 it is a fragment of a number the
  /// user is still typing; above 11 it is not an account number at all.
  static bool looksLikeAccountNumber(String raw) {
    final d = compact(raw);
    if (d.length < 8 || d.length > 11) return false;
    return _digitsOnly.hasMatch(d);
  }

  /// The forms to try, most-likely first.
  ///
  /// An 11-digit number beginning `0` is also tried without the leading zero:
  /// the fintech wallets assign PHONE-NUMBER-based account numbers and the
  /// same account is addressed as `08012345678` or `8012345678` depending on
  /// who wrote the number down. core-payments' own `normalizePhoneAccount`
  /// makes exactly this allowance, so the two sides agree.
  static List<String> candidatesFor(String raw) {
    if (!looksLikeAccountNumber(raw)) return const [];
    final d = compact(raw);
    if (d.length == 11 && d.startsWith('0')) return [d, d.substring(1)];
    return [d];
  }

  // ---- cache ---------------------------------------------------------------

  // Keyed by the exact number probed. A search field fires this on every
  // debounced keystroke and three surfaces share one instance, so without a
  // cache a payer correcting a typo re-asks for the same number repeatedly.
  //
  // Negative answers are cached too, and for much less time: "not a Lazervault
  // account" is the answer for almost every number ever typed, and caching it
  // is what keeps the bank flow from paying for a lookup per keystroke — but a
  // freshly provisioned account must not stay invisible, so it expires fast.
  static final Map<String, _CacheEntry> _cache = {};
  static const Duration _hitTtl = Duration(minutes: 10);
  static const Duration _missTtl = Duration(minutes: 2);

  static LazervaultAccountMatch? _cachedHit(String key) {
    final e = _cache[key];
    if (e == null) return null;
    if (DateTime.now().isAfter(e.expiresAt)) {
      _cache.remove(key);
      return null;
    }
    return e.match;
  }

  static bool _isCached(String key) {
    final e = _cache[key];
    if (e == null) return false;
    if (DateTime.now().isAfter(e.expiresAt)) {
      _cache.remove(key);
      return false;
    }
    return true;
  }

  static void _put(String key, LazervaultAccountMatch? match) {
    _cache[key] = _CacheEntry(
      match: match,
      expiresAt: DateTime.now().add(match == null ? _missTtl : _hitTtl),
    );
  }

  /// Forget everything. For tests and for a sign-out, after which the
  /// "is this me?" answer below is a different person's.
  static void clearCache() => _cache.clear();

  // ---- resolution ----------------------------------------------------------

  /// The Lazervault account [raw] names, or null.
  ///
  /// Null covers every "no": not an account-number shape, no such account, a
  /// frozen or closed account, the CALLER'S OWN account, and any transport
  /// failure. Callers may treat null as "external" exactly as they did before
  /// this lookup existed.
  Future<LazervaultAccountMatch?> resolve(String raw) async {
    final candidates = candidatesFor(raw);
    if (candidates.isEmpty) return null;

    // Who we are, so we never offer the payer their own account. Checked here
    // rather than per-surface because every surface would otherwise have to
    // remember to, and "send to yourself" fails late and confusingly.
    final selfId = (await _secureStorage.getUserId())?.trim() ?? '';

    for (final number in candidates) {
      if (_isCached(number)) {
        final hit = _cachedHit(number);
        if (hit != null) {
          if (selfId.isNotEmpty && hit.userId == selfId) continue;
          return hit;
        }
        continue; // cached miss — try the next form
      }
      final match = await _probe(number, selfId);
      _put(number, match);
      if (match != null) return match;
    }
    return null;
  }

  Future<LazervaultAccountMatch?> _probe(String number, String selfId) async {
    accounts_pb.Account? account;
    try {
      final options = await _callOptions.withAuth();
      final response = await _accounts.getAccountByNumber(
        accounts_pb.GetAccountByNumberRequest(accountNumber: number),
        options: options,
      );
      if (!response.hasAccount()) return null;
      account = response.account;
    } catch (_) {
      // "Account not found" arrives as an error, and so does an unreachable
      // gateway. Neither may break the caller's search, and neither is
      // evidence of anything but "not resolved".
      return null;
    }

    if (account.userId.trim().isEmpty) return null;
    if (selfId.isNotEmpty && account.userId.trim() == selfId) return null;

    // A frozen or closed account cannot receive. Suggesting it would move the
    // failure from "we couldn't find that" to a refused transfer after the PIN.
    // An EMPTY status is treated as fine — some projections omit it, and a
    // missing field is not a freeze.
    final status = account.status.trim().toLowerCase();
    if (status.isNotEmpty && status != 'active') return null;

    final resolvedNumber = account.accountNumber.trim().isNotEmpty
        ? account.accountNumber.trim()
        : number;

    var holder = account.accountName.trim();
    var username = '';
    var picture = '';

    // Enrich from the directory. auth-service's user search answers an exact
    // UUID query with that one user (its `trySearchUserByUUID` branch), so the
    // user id we just resolved is itself the query — no new endpoint, and the
    // same payable filter the rest of the search already applies.
    final profiles = _profiles;
    if (profiles != null) {
      try {
        final users = await profiles.searchUsers(
          query: account.userId.trim(),
          limit: 1,
        );
        if (users.isNotEmpty) {
          final u = users.first;
          final full = u.fullName.trim();
          if (full.isNotEmpty) holder = full;
          username = u.username.trim();
          picture = u.profilePicture.trim();
        }
      } catch (_) {
        // Enrichment is a nicety; the account row already names the holder.
      }
    }

    if (holder.isEmpty && username.isEmpty) {
      // Nothing to show the payer but digits. A row that cannot say WHO is
      // receiving the money is worse than no row — see the "name plus the
      // masked account number, never a name alone" rule, which cuts both ways.
      return null;
    }

    return LazervaultAccountMatch(
      accountId: account.id.trim(),
      userId: account.userId.trim(),
      accountNumber: resolvedNumber,
      holderName: holder,
      username: username,
      profilePicture: picture,
      currency: account.currency.trim(),
    );
  }
}

class _CacheEntry {
  final LazervaultAccountMatch? match;
  final DateTime expiresAt;
  const _CacheEntry({required this.match, required this.expiresAt});
}
