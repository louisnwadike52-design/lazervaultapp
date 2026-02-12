import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/tv_package_entity.dart';

class TVPackageModel extends TVPackageEntity {
  const TVPackageModel({
    required super.id,
    required super.name,
    required super.variationCode,
    required super.amount,
    required super.providerId,
    required super.validity,
  });

  factory TVPackageModel.fromProto(pb.TVPackage proto) {
    return TVPackageModel(
      id: proto.id,
      name: proto.name,
      variationCode: proto.variationCode,
      amount: proto.amount,
      providerId: proto.providerId,
      validity: proto.validity,
    );
  }
}
