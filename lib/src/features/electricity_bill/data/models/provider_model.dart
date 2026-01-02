import '../../domain/entities/provider_entity.dart';
import 'package:lazervault/src/generated/electricity_bill.pb.dart' as pb;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as $timestamp;

class ElectricityProviderModel extends ElectricityProviderEntity {
  const ElectricityProviderModel({
    required super.id,
    required super.providerCode,
    required super.providerName,
    required super.country,
    super.logoUrl,
    super.description,
    super.minAmount,
    super.maxAmount,
    required super.supportsPrepaid,
    required super.supportsPostpaid,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ElectricityProviderModel.fromProto(pb.ElectricityProvider proto) {
    return ElectricityProviderModel(
      id: proto.id,
      providerCode: proto.providerCode,
      providerName: proto.providerName,
      country: proto.country,
      logoUrl: proto.hasLogoUrl() ? proto.logoUrl : null,
      description: null, // Not in proto
      minAmount: proto.hasMinAmount() ? proto.minAmount : null,
      maxAmount: proto.hasMaxAmount() ? proto.maxAmount : null,
      supportsPrepaid: true, // Default, could be enhanced in proto
      supportsPostpaid: true, // Default, could be enhanced in proto
      isActive: proto.isActive,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.createdAt.toDateTime(), // Using created_at as fallback
    );
  }

  pb.ElectricityProvider toProto() {
    final proto = pb.ElectricityProvider()
      ..id = id
      ..providerCode = providerCode
      ..providerName = providerName
      ..country = country
      ..isActive = isActive
      ..createdAt = $timestamp.Timestamp.fromDateTime(createdAt);

    if (logoUrl != null) {
      proto.logoUrl = logoUrl!;
    }

    if (minAmount != null) {
      proto.minAmount = minAmount!;
    }

    if (maxAmount != null) {
      proto.maxAmount = maxAmount!;
    }

    return proto;
  }
}
