import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/internet_package_entity.dart';

class InternetPackageModel extends InternetPackageEntity {
  const InternetPackageModel({
    required super.id,
    required super.name,
    required super.variationCode,
    required super.amount,
    required super.providerId,
    required super.validity,
  });

  factory InternetPackageModel.fromProto(pb.InternetPackage proto) {
    return InternetPackageModel(
      id: proto.id,
      name: proto.name,
      variationCode: proto.variationCode,
      amount: proto.amount,
      providerId: proto.providerId,
      validity: proto.validity,
    );
  }
}
