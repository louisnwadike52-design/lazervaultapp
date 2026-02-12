import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/education_provider_entity.dart';

class EducationProviderModel extends EducationProviderEntity {
  const EducationProviderModel({
    required super.id,
    required super.name,
    required super.serviceId,
    required super.logoUrl,
    required super.isActive,
    required super.amount,
    required super.description,
  });

  factory EducationProviderModel.fromProto(pb.EducationProvider proto) {
    return EducationProviderModel(
      id: proto.id,
      name: proto.name,
      serviceId: proto.serviceId,
      logoUrl: proto.logoUrl,
      isActive: proto.isActive,
      amount: proto.amount,
      description: proto.description,
    );
  }
}
