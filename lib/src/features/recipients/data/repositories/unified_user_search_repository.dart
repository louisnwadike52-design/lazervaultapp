import 'dart:convert';
import 'package:lazervault/core/services/access_token_shape.dart';

import 'package:http/http.dart' as http;

import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/recipients/data/datasources/lazervault_account_lookup.dart';
import 'package:lazervault/src/features/recipients/domain/entities/unified_search_result.dart';

/// Calls the core-gateway unified search endpoint
/// `GET /api/v1/users/search-unified?q=&limit=&offset=` which composes the
/// caller's saved recipients (alias-first) with the global user directory.
///
/// The endpoint base comes from [EndpointRegistry.httpCore] (already ends in
/// `/api/v1`, and the cloudflare tunnel routes `/api/v1/users/*` to
/// core-gateway). Auth is the bearer access token from secure storage — the
/// gateway resolves the caller from the JWT and scopes the local recipients.
class UnifiedUserSearchRepository {
  final SecureStorageService _secureStorage;
  final http.Client _client;

  /// Resolves a typed ACCOUNT NUMBER to the Lazervault account it names.
  ///
  /// This is the one addition the endpoint above cannot make for us. Its
  /// directory half is auth-service `SearchUsers`, which searches the `users`
  /// table — and that table does not hold account numbers, so there is no
  /// `type` value for them and no amount of query shaping produces one. Its
  /// SAVED half does match a saved recipient's account number (the gateway's
  /// `matchRecipient` returns `"account"`), but only for payees the caller had
  /// already saved; a number you were just given matches nothing.
  ///
  /// Optional: when absent this repository behaves exactly as it did before,
  /// so a wiring gap degrades to the old search rather than to an error.
  final LazervaultAccountLookup? _accountLookup;

  UnifiedUserSearchRepository(
    this._secureStorage, {
    http.Client? client,
    LazervaultAccountLookup? accountLookup,
  })  : _client = client ?? http.Client(),
        _accountLookup = accountLookup;

  Future<UnifiedSearchPage> search(
    String query, {
    int limit = 20,
    int offset = 0,
    bool internalOnly = false,
  }) async {
    final q = query.trim();
    if (q.length < 2) return UnifiedSearchPage.empty;

    final token = await _secureStorage.getAccessToken();
    if (token == null || token.isEmpty) return UnifiedSearchPage.empty;

    // Started BEFORE the directory call and awaited after it, so the two run
    // together: a numeric query costs one round trip, not two in series.
    //
    // Deliberately in ADDITION to the directory search, never instead of it.
    // The same digits are a valid phone number, and nobody typing them knows
    // or should have to say which they meant — so both are asked and both are
    // offered, labelled (`matched_field`) so the payer can tell the person
    // whose phone ends in those digits from the account that IS them.
    final accountFuture = _resolveAccountMatch(q, offset);

    final uri = Uri.parse('${endpointRegistry.httpCore}/users/search-unified')
        .replace(queryParameters: {
      'q': q,
      'limit': '$limit',
      'offset': '$offset',
      // Person-search mode: only LazerVault users (drop saved external bank
      // recipients). Sent only when requested so external-bank flows are
      // unaffected.
      if (internalOnly) 'internal_only': 'true',
    });

    final resp = await _client.get(uri, headers: {
      ...authHeader(token),
      'Accept': 'application/json',
    }).timeout(const Duration(seconds: 12));

    if (resp.statusCode != 200) {
      throw UnifiedSearchException(
        'Search failed (${resp.statusCode})',
        statusCode: resp.statusCode,
      );
    }
    final body = jsonDecode(resp.body);
    if (body is! Map<String, dynamic>) return UnifiedSearchPage.empty;
    return _withAccountMatch(
      UnifiedSearchPage.fromJson(body),
      await accountFuture,
    );
  }

  /// The Lazervault account [q] names, or null. Never throws — see
  /// [LazervaultAccountLookup.resolve]. Must stay that way: this future is
  /// created before the HTTP call and would otherwise become an unhandled
  /// async error whenever the HTTP call threw first.
  ///
  /// First page only. The account match is a single exact hit, so repeating it
  /// on every page of a load-more would just be de-duplicated away, and the
  /// lookup would be paid for again each time.
  Future<LazervaultAccountMatch?> _resolveAccountMatch(String q, int offset) {
    final lookup = _accountLookup;
    if (offset != 0 ||
        lookup == null ||
        !LazervaultAccountLookup.looksLikeAccountNumber(q)) {
      return Future<LazervaultAccountMatch?>.value(null);
    }
    return lookup.resolve(q);
  }

  /// Folds a resolved account into [page] as the first GLOBAL hit.
  ///
  /// Global, not local: it is a directory-style discovery, not one of the
  /// caller's saved contacts. First, because an exact account number is the
  /// most precise thing a payer can give us — every other row on a numeric
  /// query is a substring match on somebody's phone.
  ///
  /// A SAVED row for the same person wins and this row is dropped: the saved
  /// row carries the payee's alias and the account the user pinned them to,
  /// which may deliberately not be the account just resolved. A DIRECTORY row
  /// for the same person loses and is replaced, because it carries no account
  /// number at all and so cannot say where the money is going.
  UnifiedSearchPage _withAccountMatch(
      UnifiedSearchPage page, LazervaultAccountMatch? match) {
    if (match == null) return page;
    final row = UnifiedSearchResult.lazervaultAccount(
      userId: match.userId,
      accountId: match.accountId,
      accountNumber: match.accountNumber,
      holderName: match.holderName,
      username: match.username,
      profilePicture: match.profilePicture,
    );
    if (page.local.any((r) => r.dedupeKey == row.dedupeKey)) return page;
    return UnifiedSearchPage(
      local: page.local,
      global: [
        row,
        ...page.global.where((r) => r.dedupeKey != row.dedupeKey),
      ],
      hasMore: page.hasMore,
      nextOffset: page.nextOffset,
    );
  }
}

class UnifiedSearchException implements Exception {
  final String message;
  final int? statusCode;
  const UnifiedSearchException(this.message, {this.statusCode});
  @override
  String toString() => 'UnifiedSearchException($statusCode): $message';
}
