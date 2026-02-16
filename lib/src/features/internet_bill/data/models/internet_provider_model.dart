import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/internet_provider_entity.dart';

class InternetProviderModel extends InternetProviderEntity {
  const InternetProviderModel({
    required super.id,
    required super.name,
    required super.serviceId,
    required super.logoUrl,
    required super.isActive,
    required super.commissionRate,
  });

  factory InternetProviderModel.fromProto(pb.InternetProvider proto) {
    return InternetProviderModel(
      id: proto.id,
      name: proto.name,
      serviceId: proto.serviceId,
      logoUrl: proto.logoUrl,
      isActive: proto.isActive,
      commissionRate: proto.commissionRate,
    );
  }
}
