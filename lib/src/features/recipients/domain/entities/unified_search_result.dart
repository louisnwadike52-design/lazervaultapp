import 'package:equatable/equatable.dart';

import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

/// A single row from the unified user-search endpoint
/// (`GET /api/v1/users/search-unified`). Carries BOTH a saved-recipient hit
/// (the caller's own contacts, incl. alias) and a global platform-user hit in
/// one shape, plus the metadata the UI needs to badge them ("★ Saved",
/// "alias: Mum") and the adapters every existing surface needs.
class UnifiedSearchResult extends Equatable {
  /// "saved" (the caller's saved recipient) or "global" (platform directory).
  final String source;

  /// Internal user UUID. Empty for external (bank-account) saved recipients.
  final String userId;

  /// Saved-recipient id (only set when [source] == "saved").
  final String recipientId;

  /// Alias if present, else the name/username — what to show as the headline.
  final String displayName;
  final String name;
  final String alias;
  final String username;
  final String email;
  final String phoneNumber;
  final String accountNumber;
  final String bankName;
  final String profilePicture;
  final String primaryAccountId;
  final bool isLazervault;
  final bool isSaved;
  final bool isFavorite;

  /// Which field the query matched: alias|name|email|phone|account|username|"".
  final String matchedField;

  /// "internal" | "external".
  final String type;

  const UnifiedSearchResult({
    required this.source,
    required this.userId,
    this.recipientId = '',
    required this.displayName,
    this.name = '',
    this.alias = '',
    this.username = '',
    this.email = '',
    this.phoneNumber = '',
    this.accountNumber = '',
    this.bankName = '',
    this.profilePicture = '',
    this.primaryAccountId = '',
    this.isLazervault = false,
    this.isSaved = false,
    this.isFavorite = false,
    this.matchedField = '',
    this.type = '',
  });

  bool get isSavedHit => source == 'saved';
  bool get aliasMatched => matchedField == 'alias';

  /// Stable identity for de-duplication across pages: prefer the internal user
  /// id, fall back to the saved recipient id, then a name+account composite.
  String get dedupeKey {
    if (userId.isNotEmpty) return 'u:$userId';
    if (recipientId.isNotEmpty) return 'r:$recipientId';
    return 'x:${name.toLowerCase()}|$accountNumber';
  }

  factory UnifiedSearchResult.fromJson(Map<String, dynamic> j) {
    String s(String k) => (j[k] ?? '').toString();
    bool b(String k) => j[k] == true;
    final name = s('name');
    var display = s('display_name');
    if (display.isEmpty) {
      display = name.isNotEmpty ? name : s('username');
    }
    return UnifiedSearchResult(
      source: s('source'),
      userId: s('user_id'),
      recipientId: s('recipient_id'),
      displayName: display,
      name: name,
      alias: s('alias'),
      username: s('username'),
      email: s('email'),
      phoneNumber: s('phone_number'),
      accountNumber: s('account_number'),
      bankName: s('bank_name'),
      profilePicture: s('profile_picture'),
      primaryAccountId: s('primary_account_id'),
      isLazervault: b('is_lazervault_user'),
      isSaved: b('is_saved'),
      isFavorite: b('is_favorite'),
      matchedField: s('matched_field'),
      type: s('type'),
    );
  }

  /// Adapt to the entity the great majority of search surfaces already consume.
  /// First/last name are split from [name] (the global directory returns a
  /// single display name; saved recipients store a single name too).
  UserSearchResultEntity toUserSearchResultEntity() {
    final base = name.isNotEmpty ? name : displayName;
    final parts = base.trim().split(RegExp(r'\s+'));
    final first = parts.isNotEmpty ? parts.first : '';
    final last = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    return UserSearchResultEntity(
      userId: userId,
      username: username,
      firstName: first,
      lastName: last,
      email: email,
      phoneNumber: phoneNumber,
      profilePicture: profilePicture,
      searchType: matchedField,
      primaryAccountId: primaryAccountId.isNotEmpty ? primaryAccountId : null,
      // Carry the authoritative on-platform flag through. Without this the
      // consuming surfaces (split-bill, tag-pay) wrongly inferred it from a
      // (frequently empty) username and rejected real users.
      isLazervault: isLazervault || type == 'internal',
    );
  }

  /// Adapt to a RecipientModel for the send-funds / batch surfaces. For an
  /// internal Lazervault user with no stored account number, the username /
  /// userId is the routing identifier (mirrors the existing QR + batch code).
  RecipientModel toRecipientModel({String? countryCode, String? currency}) {
    final internal = type == 'internal' || isLazervault;
    final acct = accountNumber.isNotEmpty
        ? accountNumber
        : (username.isNotEmpty ? username : userId);
    return RecipientModel(
      id: recipientId.isNotEmpty ? recipientId : userId,
      name: name.isNotEmpty ? name : displayName,
      accountNumber: acct,
      bankName: bankName.isNotEmpty ? bankName : (internal ? 'Lazervault' : ''),
      sortCode: '',
      isFavorite: isFavorite,
      isSaved: isSaved,
      countryCode: countryCode,
      email: email.isNotEmpty ? email : null,
      phoneNumber: phoneNumber.isNotEmpty ? phoneNumber : null,
      currency: currency,
      alias: alias.isNotEmpty ? alias : null,
      profileImageUrl: profilePicture.isNotEmpty ? profilePicture : null,
      type: internal ? 'internal' : 'external',
      internalUserId: userId.isNotEmpty ? userId : null,
    );
  }

  @override
  List<Object?> get props => [source, userId, recipientId, accountNumber, name];
}

/// One page of unified results: saved (local) hits + global hits + paging.
class UnifiedSearchPage {
  final List<UnifiedSearchResult> local;
  final List<UnifiedSearchResult> global;
  final bool hasMore;
  final int nextOffset;

  const UnifiedSearchPage({
    required this.local,
    required this.global,
    required this.hasMore,
    required this.nextOffset,
  });

  factory UnifiedSearchPage.fromJson(Map<String, dynamic> j) {
    List<UnifiedSearchResult> parse(String k) =>
        ((j[k] as List?) ?? const [])
            .whereType<Map>()
            .map((e) => UnifiedSearchResult.fromJson(
                Map<String, dynamic>.from(e)))
            .toList();
    return UnifiedSearchPage(
      local: parse('local'),
      global: parse('global'),
      hasMore: j['has_more'] == true,
      nextOffset: (j['next_offset'] is num)
          ? (j['next_offset'] as num).toInt()
          : 0,
    );
  }

  static const empty =
      UnifiedSearchPage(local: [], global: [], hasMore: false, nextOffset: 0);
}
