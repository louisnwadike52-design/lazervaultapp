import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/data_plan_entity.dart';

class DataPlanModel extends DataPlanEntity {
  const DataPlanModel({
    required super.variationId,
    required super.name,
    required super.price,
    required super.network,
    required super.availability,
  });

  factory DataPlanModel.fromProto(pb.DataPlan proto) {
    return DataPlanModel(
      variationId: proto.variationId,
      name: proto.name,
      price: proto.price,
      network: proto.network,
      availability: proto.availability,
    );
  }
}
