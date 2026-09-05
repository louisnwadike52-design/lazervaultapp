import 'package:fixnum/fixnum.dart';
import 'package:lazervault/core/utilities/banks_data.dart';
import 'package:lazervault/src/generated/recipient.pb.dart' as proto;

class RecipientModel {
  final String id;
  final String name;
  final String accountNumber;
  final String bankName;
  final String? profileImageUrl;
  final bool isFavorite;
  final bool isSaved;
  final String sortCode;
  final String? countryCode;
  final String? email;
  final String? phoneNumber;
  final String? currency;
  final String? swiftCode;
  final String? iban;
  final String? alias;
  final String? type;
  final String? internalUserId;

  const RecipientModel({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.bankName,
    this.profileImageUrl,
    required this.isFavorite,
    this.isSaved = true,
    required this.sortCode,
    this.countryCode,
    this.email,
    this.phoneNumber,
    this.currency,
    this.swiftCode,
    this.iban,
    this.alias,
    this.type,
    this.internalUserId,
  });

  /// Bank label to SHOW the user — resolves a bare/numeric code (e.g. "001")
  /// to the real bank name via the canonical list. The code still goes to the
  /// payout provider; the user only ever sees the name.
  String get displayBankName => BanksData.displayName(bankName, sortCode);

  /// True when [accountNumber] is a REAL, maskable account number (all digits,
  /// NUBAN-style). Internal Lazervault recipients created from a chat/username
  /// carry the user-id UUID in [accountNumber] purely to satisfy send-flow
  /// validation — that is NOT an account number and must never be masked and
  /// shown to the user (it would surface a meaningless UUID fragment).
  bool get hasRealAccountNumber {
    final a = accountNumber.trim();
    if (a.length < 4) return false;
    // The chat/username path copies the user-id straight into accountNumber —
    // that exact value is never an account number (covers hyphenated AND
    // hyphenless UUIDs).
    if (internalUserId != null && a == internalUserId!.trim()) return false;
    // Real account numbers are contiguous alphanumerics (NUBAN digits, IBAN
    // letters+digits); a UUID contains hyphens and fails this.
    return RegExp(r'^[A-Za-z0-9]+$').hasMatch(a);
  }

  /// Whether this recipient may be sent to as an INTERNAL (LazerVault-to-
  /// LazerVault) transfer.
  ///
  /// Internal must be PROVEN, never inferred. `type` alone is not proof: it is
  /// defaulted to 'internal' in several construction paths simply because no
  /// bank/sort code was captured (see batch_transfer_form.dart), so the absence
  /// of a bank was being read as evidence of a LazerVault account.
  ///
  /// When that guess is wrong the transfer does not quietly reroute — the
  /// backend refuses it outright ("recipient not found on LazerVault"), because
  /// silently sending externally after the user asked for an internal transfer
  /// would be worse. The user just sees "check the account number" for a
  /// recipient whose details were entirely correct.
  ///
  /// Proof is either:
  ///   * a resolved LazerVault user id, or
  ///   * a bank explicitly identified as LazerVault (the LazerVault tab / a
  ///     recipient returned by a LazerVault user lookup).
  bool get canSendAsInternal {
    if (internalUserId != null && internalUserId!.trim().isNotEmpty) return true;
    return bankName.trim().toLowerCase() == 'lazervault';
  }

  /// A Lazervault internal recipient identified only by user id — there is no
  /// account number to display; show the name + "Lazervault" instead.
  bool get isInternalUserRecipient =>
      (type == 'internal' || bankName.toLowerCase() == 'lazervault') &&
      !hasRealAccountNumber;

  /// Masked account number for display, or '' when there is no real account
  /// number (internal user recipient). Every send confirm/receipt masking site
  /// MUST use this instead of blindly masking [accountNumber], so an internal
  /// transfer never renders a masked `uuid-fragment`.
  String get maskedAccount => hasRealAccountNumber
      ? '•••• ${accountNumber.substring(accountNumber.length - 4)}'
      : '';

  /// Account-TYPE tokens that must NEVER be shown as a person's display name.
  /// Some legacy/internal connection records were saved with the account type
  /// (e.g. "personal") in the `name` field instead of a real name.
  static const Set<String> _accountTypeTokens = {
    'personal',
    'business',
    'savings',
    'current',
    'checking',
    'investment',
    'family',
    'family & friends',
    'campaign',
  };

  /// True when [value] is empty or is just an account-TYPE token, meaning it
  /// must not be surfaced as a human display name.
  static bool _isUnusableName(String? value) {
    if (value == null) return true;
    final v = value.trim();
    if (v.isEmpty) return true;
    return _accountTypeTokens.contains(v.toLowerCase());
  }

  /// Safe display name for the recipient. Prefers the user-defined [alias],
  /// then the stored [name] (unless it's empty or an account-TYPE token like
  /// "personal"), then falls back to the email local-part or a masked account
  /// number so the UI never renders an account type where a name belongs.
  /// Strips a leading `institution/` prefix from a stored name.
  ///
  /// Some recipients are saved with the account label rather than the person —
  /// "Lazervault/Nnaemeka Ezeke" — which reads as an account reference in a list
  /// of PEOPLE (financial connections, chat peers), where the institution is
  /// both redundant and the least useful half.
  ///
  /// Only strips when the prefix is THIS recipient's own bankName, so a person
  /// whose name legitimately contains a slash is never mangled, and a different
  /// institution's label is left visible rather than silently hidden.
  String _withoutInstitutionPrefix(String value) {
    final v = value.trim();
    final bank = bankName.trim();
    if (bank.isEmpty || !v.contains('/')) return v;
    final head = v.substring(0, v.indexOf('/')).trim();
    if (head.toLowerCase() != bank.toLowerCase()) return v;
    final tail = v.substring(v.indexOf('/') + 1).trim();
    // Never strip down to nothing — a bare institution name beats an empty row.
    return tail.isEmpty ? v : tail;
  }

  String get displayName {
    if (alias != null && alias!.trim().isNotEmpty) return alias!.trim();
    if (!_isUnusableName(name)) return _withoutInstitutionPrefix(name);
    if (email != null && email!.contains('@')) {
      final local = email!.split('@').first.trim();
      if (local.isNotEmpty) return local;
    }
    if (accountNumber.startsWith('@')) return accountNumber;
    // Only fall back to a masked account when it's a REAL account number — never
    // mask the internal user-id UUID (that would read as "••••<uuid-fragment>").
    if (hasRealAccountNumber) {
      return '••••${accountNumber.substring(accountNumber.length - 4)}';
    }
    return 'Unknown';
  }

  factory RecipientModel.fromProto(proto.Recipient recipient) {
    // Determine type: LazerVault bank recipients are internal, not external
    String? resolvedType = recipient.type.isNotEmpty ? recipient.type : null;
    if (recipient.bankName.toLowerCase() == 'lazervault') {
      resolvedType = 'internal';
    }

    // Extract internal user ID (string UUID)
    final internalUid = recipient.internalUserId.isNotEmpty
        ? recipient.internalUserId
        : null;

    return RecipientModel(
      id: recipient.id.toString(),
      name: recipient.name,
      accountNumber: recipient.accountNumber,
      bankName: recipient.bankName,
      isFavorite: recipient.isFavorite,
      isSaved: recipient.isSaved,
      sortCode: recipient.sortCode,
      countryCode: recipient.countryCode.isNotEmpty ? recipient.countryCode : null,
      email: recipient.email.isNotEmpty ? recipient.email : null,
      phoneNumber: recipient.phoneNumber.isNotEmpty ? recipient.phoneNumber : null,
      currency: recipient.currency.isNotEmpty ? recipient.currency : null,
      swiftCode: recipient.swiftCode.isNotEmpty ? recipient.swiftCode : null,
      iban: recipient.iban.isNotEmpty ? recipient.iban : null,
      alias: recipient.alias.isNotEmpty ? recipient.alias : null,
      type: resolvedType,
      internalUserId: internalUid,
    );
  }

  factory RecipientModel.fromJson(Map<String, dynamic> json) {
    return RecipientModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      accountNumber: json['accountNumber'] as String? ?? '',
      bankName: json['bankName'] as String? ?? '',
      profileImageUrl: json['profileImageUrl'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isSaved: json['isSaved'] as bool? ?? true,
      sortCode: json['sortCode'] as String? ?? '',
      countryCode: json['countryCode'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      currency: json['currency'] as String?,
      swiftCode: json['swiftCode'] as String?,
      iban: json['iban'] as String?,
      alias: json['alias'] as String?,
      type: json['type'] as String?,
      internalUserId: json['internalUserId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'accountNumber': accountNumber,
      'bankName': bankName,
      'profileImageUrl': profileImageUrl,
      'isFavorite': isFavorite,
      'isSaved': isSaved,
      'sortCode': sortCode,
      'countryCode': countryCode,
      'email': email,
      'phoneNumber': phoneNumber,
      'currency': currency,
      'swiftCode': swiftCode,
      'iban': iban,
      'alias': alias,
      'type': type,
      'internalUserId': internalUserId,
    };
  }

  proto.Recipient toProto() {
    return proto.Recipient()
      ..id = Int64.parseInt(id)
      ..name = name
      ..accountNumber = accountNumber
      ..bankName = bankName
      ..sortCode = sortCode
      ..isFavorite = isFavorite
      ..isSaved = isSaved
      ..countryCode = countryCode ?? ''
      ..email = email ?? ''
      ..phoneNumber = phoneNumber ?? ''
      ..currency = currency ?? ''
      ..swiftCode = swiftCode ?? ''
      ..iban = iban ?? ''
      ..alias = alias ?? ''
      ..type = type ?? ''
      // Carry the internal payee id so any save routed through toProto() still
      // hits the server's internal_user_id dedup (matches the field-by-field
      // request builder in recipient_repository_impl).
      ..internalUserId = internalUserId ?? '';
  }

  RecipientModel copyWith({
    String? id,
    String? name,
    String? accountNumber,
    String? bankName,
    String? profileImageUrl,
    bool? isFavorite,
    bool? isSaved,
    String? sortCode,
    String? countryCode,
    String? email,
    String? phoneNumber,
    String? currency,
    String? swiftCode,
    String? iban,
    String? alias,
    String? type,
    String? internalUserId,
  }) {
    return RecipientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      isSaved: isSaved ?? this.isSaved,
      sortCode: sortCode ?? this.sortCode,
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      currency: currency ?? this.currency,
      swiftCode: swiftCode ?? this.swiftCode,
      iban: iban ?? this.iban,
      alias: alias ?? this.alias,
      type: type ?? this.type,
      internalUserId: internalUserId ?? this.internalUserId,
    );
  }
} 