class RecipientEntity {
  final String id;
  final String name;
  final String accountNumber;
  final String bankName;
  final String? profileImageUrl;
  final bool isFavorite;
  final String? sortCode;
  final String? countryCode;
  final String? email;
  final String? phoneNumber;
  final String? currency;
  final String? swiftCode;
  final String? iban;
  final String? alias;
  final String? type;

  RecipientEntity({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.bankName,
    this.profileImageUrl,
    this.isFavorite = false,
    this.sortCode,
    this.countryCode,
    this.email,
    this.phoneNumber,
    this.currency,
    this.swiftCode,
    this.iban,
    this.alias,
    this.type,
  });

  RecipientEntity copyWith({
    String? id,
    String? name,
    String? accountNumber,
    String? bankName,
    String? profileImageUrl,
    bool? isFavorite,
    String? sortCode,
    String? countryCode,
    String? email,
    String? phoneNumber,
    String? currency,
    String? swiftCode,
    String? iban,
    String? alias,
    String? type,
  }) {
    return RecipientEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      sortCode: sortCode ?? this.sortCode,
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      currency: currency ?? this.currency,
      swiftCode: swiftCode ?? this.swiftCode,
      iban: iban ?? this.iban,
      alias: alias ?? this.alias,
      type: type ?? this.type,
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
      'sortCode': sortCode,
      'countryCode': countryCode,
      'email': email,
      'phoneNumber': phoneNumber,
      'currency': currency,
      'swiftCode': swiftCode,
      'iban': iban,
      'alias': alias,
      'type': type,
    };
  }

  factory RecipientEntity.fromJson(Map<String, dynamic> json) {
    return RecipientEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      accountNumber: json['accountNumber'] as String,
      bankName: json['bankName'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
      sortCode: json['sortCode'] as String?,
      countryCode: json['countryCode'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      currency: json['currency'] as String?,
      swiftCode: json['swiftCode'] as String?,
      iban: json['iban'] as String?,
      alias: json['alias'] as String?,
      type: json['type'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RecipientEntity &&
        other.id == id &&
        other.name == name &&
        other.accountNumber == accountNumber &&
        other.bankName == bankName &&
        other.profileImageUrl == profileImageUrl &&
        other.isFavorite == isFavorite &&
        other.sortCode == sortCode &&
        other.countryCode == countryCode &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.currency == currency &&
        other.swiftCode == swiftCode &&
        other.iban == iban &&
        other.alias == alias &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        accountNumber.hashCode ^
        bankName.hashCode ^
        profileImageUrl.hashCode ^
        isFavorite.hashCode ^
        sortCode.hashCode ^
        countryCode.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        currency.hashCode ^
        swiftCode.hashCode ^
        iban.hashCode ^
        alias.hashCode ^
        type.hashCode;
  }
} 