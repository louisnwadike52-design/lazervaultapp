import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/education_pin_entity.dart';

class EducationPinModel extends EducationPinEntity {
  const EducationPinModel({
    required super.pin,
    required super.serial,
    required super.expiresAt,
  });

  factory EducationPinModel.fromProto(pb.EducationPinResult proto) {
    return EducationPinModel(
      pin: proto.pin,
      serial: proto.serial,
      expiresAt: proto.expiresAt,
    );
  }
}
