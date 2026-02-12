import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/smart_card_validation_entity.dart';

class SmartCardValidationModel extends SmartCardValidationEntity {
  const SmartCardValidationModel({
    required super.isValid,
    required super.customerName,
    required super.smartCardNumber,
    required super.currentPackage,
    required super.renewalDate,
    required super.dueDate,
  });

  factory SmartCardValidationModel.fromProto(pb.SmartCardValidation proto) {
    return SmartCardValidationModel(
      isValid: proto.isValid,
      customerName: proto.customerName,
      smartCardNumber: proto.smartCardNumber,
      currentPackage: proto.currentPackage,
      renewalDate: proto.renewalDate,
      dueDate: proto.dueDate,
    );
  }
}
