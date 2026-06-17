import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/cable_tv_provider_entity.dart';

class CableTVProviderModel extends CableTVProviderEntity {
  const CableTVProviderModel({
    required super.id,
    required super.name,
    required super.serviceId,
    required super.logoUrl,
    required super.isActive,
    required super.commissionRate,
  });

  factory CableTVProviderModel.fromProto(pb.CableTVProvider proto) {
    return CableTVProviderModel(
      id: proto.id,
      name: proto.name,
      serviceId: proto.serviceId,
      logoUrl: proto.logoUrl,
      isActive: proto.isActive,
      commissionRate: proto.commissionRate,
    );
  }
}
