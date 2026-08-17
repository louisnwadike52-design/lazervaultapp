part of 'invoice_entity.dart';

enum InvoiceStatus {
  draft,
  pending,
  paid,
  partiallyPaid,
  expired,
  cancelled,
}

enum InvoiceType {
  request,
  invoice,
  quote,
}

enum PaymentMethod {
  bankTransfer,
  crypto,
  paypal,
  card,
  cash,
}

class AddressDetails extends Equatable {
  final String? companyName;
  final String? contactName;
  final String? email;
  final String? phone;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  final String? bankAccount;
  final String? bicNumber;
  final String? iban;
  final String? routingNumber;
  final String? taxId;
  final String? bankName;
  final String? accountType;
  final String? swiftCode;
  final String? sortCode;
  final String? bankAddress;
  final String? intermediaryBankName;
  final String? intermediaryBankSwift;
  final String? accountHolderName;
  final String? logoUrl;

  const AddressDetails({
    this.companyName,
    this.contactName,
    this.email,
    this.phone,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.bankAccount,
    this.bicNumber,
    this.iban,
    this.routingNumber,
    this.taxId,
    this.bankName,
    this.accountType,
    this.swiftCode,
    this.sortCode,
    this.bankAddress,
    this.intermediaryBankName,
    this.intermediaryBankSwift,
    this.accountHolderName,
    this.logoUrl,
  });

  @override
  List<Object?> get props => [
        companyName,
        contactName,
        email,
        phone,
        addressLine1,
        addressLine2,
        city,
        state,
        postcode,
        country,
        bankAccount,
        bicNumber,
        iban,
        routingNumber,
        taxId,
        bankName,
        accountType,
        swiftCode,
        sortCode,
        bankAddress,
        intermediaryBankName,
        intermediaryBankSwift,
        accountHolderName,
        logoUrl,
      ];

  AddressDetails copyWith({
    String? companyName,
    String? contactName,
    String? email,
    String? phone,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? bankAccount,
    String? bicNumber,
    String? iban,
    String? routingNumber,
    String? taxId,
    String? bankName,
    String? accountType,
    String? swiftCode,
    String? sortCode,
    String? bankAddress,
    String? intermediaryBankName,
    String? intermediaryBankSwift,
    String? accountHolderName,
    String? logoUrl,
  }) {
    return AddressDetails(
      companyName: companyName ?? this.companyName,
      contactName: contactName ?? this.contactName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      state: state ?? this.state,
      postcode: postcode ?? this.postcode,
      country: country ?? this.country,
      bankAccount: bankAccount ?? this.bankAccount,
      bicNumber: bicNumber ?? this.bicNumber,
      iban: iban ?? this.iban,
      routingNumber: routingNumber ?? this.routingNumber,
      taxId: taxId ?? this.taxId,
      bankName: bankName ?? this.bankName,
      accountType: accountType ?? this.accountType,
      swiftCode: swiftCode ?? this.swiftCode,
      sortCode: sortCode ?? this.sortCode,
      bankAddress: bankAddress ?? this.bankAddress,
      intermediaryBankName: intermediaryBankName ?? this.intermediaryBankName,
      intermediaryBankSwift: intermediaryBankSwift ?? this.intermediaryBankSwift,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  bool get isEmpty {
    return companyName == null &&
        contactName == null &&
        email == null &&
        phone == null &&
        addressLine1 == null &&
        addressLine2 == null &&
        city == null &&
        state == null &&
        postcode == null &&
        country == null &&
        bankAccount == null &&
        bicNumber == null &&
        iban == null &&
        routingNumber == null &&
        taxId == null &&
        bankName == null &&
        accountType == null &&
        swiftCode == null &&
        sortCode == null &&
        bankAddress == null &&
        intermediaryBankName == null &&
        intermediaryBankSwift == null &&
        accountHolderName == null &&
        logoUrl == null;
  }

  String get formattedAddress {
    final parts = <String>[];
    if (addressLine1?.isNotEmpty == true) parts.add(addressLine1!);
    if (addressLine2?.isNotEmpty == true) parts.add(addressLine2!);
    if (city?.isNotEmpty == true) parts.add(city!);
    if (state?.isNotEmpty == true) parts.add(state!);
    if (postcode?.isNotEmpty == true) parts.add(postcode!);
    if (country?.isNotEmpty == true) parts.add(country!);
    return parts.join(', ');
  }
}

class TaggedUserInfo extends Equatable {
  final String userId;
  final String username;
  final String firstName;
  final String lastName;
  final String? profilePicture;
  final String status; // "pending", "viewed", "paid"
  final String tagType; // "platform", "email", "phone"
  final String? tagValue; // email address or phone number for external tags
  final DateTime? taggedAt;
  final DateTime? viewedAt;
  final DateTime? paidAt;
  final double shareAmount; // this user's equal share of the invoice total
  final double amountPaid; // what this user has actually paid

  const TaggedUserInfo({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.profilePicture,
    this.status = 'pending',
    this.tagType = 'platform',
    this.tagValue,
    this.taggedAt,
    this.viewedAt,
    this.paidAt,
    this.shareAmount = 0,
    this.amountPaid = 0,
  });

  bool get isPlatformUser => tagType == 'platform';
  bool get isExternalTag => tagType == 'email' || tagType == 'phone';

  String get displayName {
    if (firstName.isNotEmpty || lastName.isNotEmpty) {
      return '$firstName $lastName'.trim();
    }
    if (username.isNotEmpty) return username;
    return tagValue ?? 'Unknown';
  }

  String get tagMethodLabel {
    switch (tagType) {
      case 'email': return 'Via Email';
      case 'phone': return 'Via SMS';
      default: return 'On Platform';
    }
  }

  TaggedUserInfo copyWith({
    String? userId,
    String? username,
    String? firstName,
    String? lastName,
    String? profilePicture,
    String? status,
    String? tagType,
    String? tagValue,
    DateTime? taggedAt,
    DateTime? viewedAt,
    DateTime? paidAt,
    double? shareAmount,
    double? amountPaid,
  }) {
    return TaggedUserInfo(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
      status: status ?? this.status,
      tagType: tagType ?? this.tagType,
      tagValue: tagValue ?? this.tagValue,
      taggedAt: taggedAt ?? this.taggedAt,
      viewedAt: viewedAt ?? this.viewedAt,
      paidAt: paidAt ?? this.paidAt,
      shareAmount: shareAmount ?? this.shareAmount,
      amountPaid: amountPaid ?? this.amountPaid,
    );
  }

  @override
  List<Object?> get props => [userId, username, firstName, lastName, profilePicture, status, tagType, tagValue, taggedAt, viewedAt, paidAt, shareAmount, amountPaid];
}

class InvoiceItem extends Equatable {
  final String id;
  final String name;
  final String? description;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final String? category;

  const InvoiceItem({
    required this.id,
    required this.name,
    this.description,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.category,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        quantity,
        unitPrice,
        totalPrice,
        category,
      ];

  factory InvoiceItem.fromJson(Map<String, dynamic> json) {
    return InvoiceItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble() ?? 1.0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'totalPrice': totalPrice,
      'category': category,
    };
  }

  InvoiceItem copyWith({
    String? id,
    String? name,
    String? description,
    double? quantity,
    double? unitPrice,
    double? totalPrice,
    String? category,
  }) {
    return InvoiceItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      category: category ?? this.category,
    );
  }
}
