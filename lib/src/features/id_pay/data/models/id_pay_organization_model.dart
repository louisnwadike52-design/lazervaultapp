import '../../domain/entities/id_pay_organization_entity.dart';
import 'package:lazervault/src/generated/id_pay.pb.dart' as pb;

class IDPayOrganizationModel extends IDPayOrganizationEntity {
  const IDPayOrganizationModel({
    required super.id,
    required super.creatorId,
    required super.name,
    required super.description,
    required super.logoUrl,
    required super.accountId,
    required super.totalReceived,
    required super.totalPaymentCount,
    required super.activeIdPayCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory IDPayOrganizationModel.fromProto(pb.IDPayOrganization proto) {
    return IDPayOrganizationModel(
      id: proto.id,
      creatorId: proto.creatorId,
      name: proto.name,
      description: proto.description,
      logoUrl: proto.logoUrl,
      accountId: proto.accountId,
      totalReceived: proto.totalReceived,
      totalPaymentCount: proto.totalPaymentCount,
      activeIdPayCount: proto.activeIdPayCount,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }
}
