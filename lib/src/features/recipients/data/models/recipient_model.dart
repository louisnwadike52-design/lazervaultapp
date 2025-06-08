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

  const RecipientModel({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.bankName,
    this.profileImageUrl,
    required this.isFavorite,
    required this.sortCode,
  });

  factory RecipientModel.fromProto(proto.Recipient recipient) {
    return RecipientModel(
      id: recipient.id.toString(),
      name: recipient.name,
      accountNumber: recipient.accountNumber,
      bankName: recipient.bankName,
      isFavorite: recipient.isFavorite,
      sortCode: recipient.sortCode,
    );
  }

  proto.Recipient toProto() {
    return proto.Recipient()
      ..id = Int64.parseInt(id)
      ..name = name
      ..accountNumber = accountNumber
      ..bankName = bankName
      ..sortCode = sortCode
      ..isFavorite = isFavorite;
  }

  RecipientModel copyWith({
    String? id,
    String? name,
    String? accountNumber,
    String? bankName,
    String? profileImageUrl,
    bool? isFavorite,
    String? sortCode,
  }) {
    return RecipientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      sortCode: sortCode ?? this.sortCode,
    );
  }
} 