class RecipientEntity {
  final String id;
  final String name;
  final String accountNumber;
  final String bankName;
  final String? profileImageUrl;
  final bool isFavorite;

  RecipientEntity({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.bankName,
    this.profileImageUrl,
    this.isFavorite = false,
  });

  RecipientEntity copyWith({
    String? id,
    String? name,
    String? accountNumber,
    String? bankName,
    String? profileImageUrl,
    bool? isFavorite,
  }) {
    return RecipientEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
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
    };
  }

  factory RecipientEntity.fromJson(Map<String, dynamic> json) {
    return RecipientEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      accountNumber: json['accountNumber'] as String,
      bankName: json['bankName'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      isFavorite: json['isFavorite'] as bool,
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
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        accountNumber.hashCode ^
        bankName.hashCode ^
        profileImageUrl.hashCode ^
        isFavorite.hashCode;
  }
} 