import 'package:fixnum/fixnum.dart';
import 'package:lazervault/src/generated/recipient.pb.dart' as proto;

class RecipientModel {
  final String id;
  final String name;
  final String accountNumber;
  final String bankName;
  final String? profileImageUrl;
  final bool isFavorite;
  final String sortCode;
  final String? countryCode;
  final String? email;
  final String? phoneNumber;
  final String? currency;
  final String? swiftCode;
  final String? iban;

  const RecipientModel({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.bankName,
    this.profileImageUrl,
    required this.isFavorite,
    required this.sortCode,
    this.countryCode,
    this.email,
    this.phoneNumber,
    this.currency,
    this.swiftCode,
    this.iban,
  });

  factory RecipientModel.fromProto(proto.Recipient recipient) {
    return RecipientModel(
      id: recipient.id.toString(),
      name: recipient.name,
      accountNumber: recipient.accountNumber,
      bankName: recipient.bankName,
      isFavorite: recipient.isFavorite,
      sortCode: recipient.sortCode,
      countryCode: recipient.countryCode.isNotEmpty ? recipient.countryCode : null,
      email: recipient.email.isNotEmpty ? recipient.email : null,
      phoneNumber: recipient.phoneNumber.isNotEmpty ? recipient.phoneNumber : null,
      currency: recipient.currency.isNotEmpty ? recipient.currency : null,
      swiftCode: recipient.swiftCode.isNotEmpty ? recipient.swiftCode : null,
      iban: recipient.iban.isNotEmpty ? recipient.iban : null,
    );
  }

  proto.Recipient toProto() {
    return proto.Recipient()
      ..id = Int64.parseInt(id)
      ..name = name
      ..accountNumber = accountNumber
      ..bankName = bankName
      ..sortCode = sortCode
      ..isFavorite = isFavorite
      ..countryCode = countryCode ?? ''
      ..email = email ?? ''
      ..phoneNumber = phoneNumber ?? ''
      ..currency = currency ?? ''
      ..swiftCode = swiftCode ?? ''
      ..iban = iban ?? '';
  }

  RecipientModel copyWith({
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
  }) {
    return RecipientModel(
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
    );
  }
} 