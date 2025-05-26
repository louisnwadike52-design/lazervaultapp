class Recipient {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String accountNumber;
  final String bankName;
  final String? swiftCode;
  final String? iban;
  final String? routingNumber;
  final String countryCode;
  final String currency;
  final String? address;
  final String? city;
  final String? state;
  final String? postalCode;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime? lastUsed;
  final String? avatarUrl;
  final RecipientType type;

  const Recipient({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.accountNumber,
    required this.bankName,
    this.swiftCode,
    this.iban,
    this.routingNumber,
    required this.countryCode,
    required this.currency,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.isFavorite = false,
    required this.createdAt,
    this.lastUsed,
    this.avatarUrl,
    this.type = RecipientType.manual,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) {
    return Recipient(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      accountNumber: json['accountNumber'] ?? '',
      bankName: json['bankName'] ?? '',
      swiftCode: json['swiftCode'],
      iban: json['iban'],
      routingNumber: json['routingNumber'],
      countryCode: json['countryCode'] ?? '',
      currency: json['currency'] ?? '',
      address: json['address'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      isFavorite: json['isFavorite'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastUsed: json['lastUsed'] != null ? DateTime.parse(json['lastUsed']) : null,
      avatarUrl: json['avatarUrl'],
      type: RecipientType.values.firstWhere(
        (e) => e.toString() == 'RecipientType.${json['type']}',
        orElse: () => RecipientType.manual,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'accountNumber': accountNumber,
      'bankName': bankName,
      'swiftCode': swiftCode,
      'iban': iban,
      'routingNumber': routingNumber,
      'countryCode': countryCode,
      'currency': currency,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'isFavorite': isFavorite,
      'createdAt': createdAt.toIso8601String(),
      'lastUsed': lastUsed?.toIso8601String(),
      'avatarUrl': avatarUrl,
      'type': type.toString().split('.').last,
    };
  }

  Recipient copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? accountNumber,
    String? bankName,
    String? swiftCode,
    String? iban,
    String? routingNumber,
    String? countryCode,
    String? currency,
    String? address,
    String? city,
    String? state,
    String? postalCode,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? lastUsed,
    String? avatarUrl,
    RecipientType? type,
  }) {
    return Recipient(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      swiftCode: swiftCode ?? this.swiftCode,
      iban: iban ?? this.iban,
      routingNumber: routingNumber ?? this.routingNumber,
      countryCode: countryCode ?? this.countryCode,
      currency: currency ?? this.currency,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      lastUsed: lastUsed ?? this.lastUsed,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      type: type ?? this.type,
    );
  }

  String get initials {
    final names = name.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0][0].toUpperCase();
    }
    return 'R';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Recipient && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Recipient(id: $id, name: $name, email: $email)';
  }
}

enum RecipientType {
  manual,
  contact,
  saved,
  frequent,
} 