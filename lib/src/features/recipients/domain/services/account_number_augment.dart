import 'package:lazervault/src/features/recipients/data/datasources/lazervault_account_lookup.dart';

/// Lets any user-search surface accept a typed ACCOUNT NUMBER, without each
/// one reinventing the merge.
///
/// WHY THIS IS NEEDED PER-SURFACE. The directory search every feature calls is
/// auth-service `SearchUsers`, which reads the `users` table — and that table
/// does not hold account numbers. It cannot: `accounts` lives in a schema
/// auth_role cannot see. So there is no `searchType` for account numbers and
/// no query shaping that produces one; the resolution has to be a second
/// lookup, against accounts-service, merged in by the caller.
///
/// [UnifiedUserSearchRepository] already does exactly this, but only two
/// surfaces use it (the recipients sheet and SprayMe tagging). Tag-Pay,
/// invoices, batch transfers, crypto send and the family invite each call
/// their own search, so a payee's account number — the identifier a payee is
/// most likely to read out — found nobody on five of the seven screens that
/// ask "who are you paying?".
///
/// ALWAYS IN ADDITION, NEVER INSTEAD. The same digits can be a phone number,
/// and the person typing them neither knows nor should have to say which they
/// meant. Both readings are offered and the account hit is placed first,
/// because an exact account match is a stronger signal than a substring of
/// somebody's phone number.
class AccountNumberAugment {
  const AccountNumberAugment._();

  /// Starts the resolve so it runs ALONGSIDE the caller's own search rather
  /// than after it. Call this before awaiting the directory request, then
  /// pass the future to [merge].
  ///
  /// Never throws and never returns a failure: [LazervaultAccountLookup.resolve]
  /// answers null for everything that is not a live Lazervault account, which
  /// is the overwhelmingly common case and must cost the caller nothing.
  /// Returns null immediately when the term cannot be an account number, so a
  /// name search spends no round trip.
  static Future<LazervaultAccountMatch?> start(
    LazervaultAccountLookup? lookup,
    String query, {
    int offset = 0,
  }) {
    // First page only. The account match is a single exact hit; repeating it
    // on every load-more page would be de-duplicated away and paid for again.
    if (lookup == null ||
        offset != 0 ||
        !LazervaultAccountLookup.looksLikeAccountNumber(query)) {
      return Future<LazervaultAccountMatch?>.value(null);
    }
    return lookup.resolve(query);
  }

  /// Puts [match] at the head of [results], dropping any duplicate of the same
  /// user that the directory search also returned.
  ///
  /// The account row wins over the directory row for the same person: it is
  /// the one that knows WHICH of their accounts the number names, and paying
  /// the wrong account of the right person is still the wrong outcome.
  static List<T> merge<T>({
    required List<T> results,
    required LazervaultAccountMatch? match,
    required String Function(T) userIdOf,
    required T Function(LazervaultAccountMatch) map,
  }) {
    if (match == null) return results;
    final id = match.userId.trim();
    if (id.isEmpty) return results;
    return <T>[
      map(match),
      ...results.where((r) => userIdOf(r).trim() != id),
    ];
  }

  /// Splits an account holder's name for surfaces that store first and last
  /// separately.
  ///
  /// The account row carries ONE name, as the bank holds it
  /// ("LAZERVAULT/NNAEMEKA EZEKE"), so any split is a presentation guess. The
  /// whole string goes in `first` and `last` stays empty unless there is a
  /// clean space-separated remainder — a surface that renders "first last"
  /// then shows the full name either way, and nothing invents a surname that
  /// the bank did not give us.
  static ({String first, String last}) splitHolderName(String holder) {
    final cleaned = holder.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (cleaned.isEmpty) return (first: '', last: '');
    final slash = cleaned.lastIndexOf('/');
    final bare = slash >= 0 ? cleaned.substring(slash + 1).trim() : cleaned;
    final parts = bare.split(' ');
    if (parts.length < 2) return (first: bare, last: '');
    return (first: parts.first, last: parts.sublist(1).join(' '));
  }

  /// The hint every search field that supports this should show, so the label
  /// and the capability cannot drift apart.
  static const String searchHint =
      'Name, username, phone, email or account no.';
}
