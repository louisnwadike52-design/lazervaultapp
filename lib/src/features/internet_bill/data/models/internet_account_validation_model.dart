import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/internet_account_validation_entity.dart';

class InternetAccountValidationModel extends InternetAccountValidationEntity {
  const InternetAccountValidationModel({
    required super.isValid,
    required super.customerName,
    required super.accountNumber,
    required super.status,
    required super.dueAmount,
  });

  factory InternetAccountValidationModel.fromProto(pb.InternetAccountValidation proto) {
    return InternetAccountValidationModel(
      isValid: proto.isValid,
      customerName: proto.customerName,
      accountNumber: proto.accountNumber,
      status: proto.status,
      dueAmount: proto.dueAmount,
    );
  }
}
