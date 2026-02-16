import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;
import 'package:lazervault/src/core/network/grpc_client.dart';
import '../models/data_plan_model.dart';
import '../models/data_purchase_model.dart';

abstract class DataBundlesRemoteDataSource {
  Future<List<DataPlanModel>> getDataPlans({required String network});
  Future<DataPurchaseModel> buyData({
    required String phoneNumber,
    required String network,
    required String variationId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  });
}

class DataBundlesRemoteDataSourceImpl implements DataBundlesRemoteDataSource {
  final GrpcClient grpcClient;

  DataBundlesRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<DataPlanModel>> getDataPlans({required String network}) async {
    final request = pb.GetDataPlansRequest()..network = network;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.getDataPlans(
      request,
      options: options,
    );

    return response.plans.map((p) => DataPlanModel.fromProto(p)).toList();
  }

  @override
  Future<DataPurchaseModel> buyData({
    required String phoneNumber,
    required String network,
    required String variationId,
    required double amount,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    final request = pb.BuyDataRequest()
      ..phoneNumber = phoneNumber
      ..network = network
      ..variationId = variationId
      ..amount = amount
      ..transactionId = transactionId
      ..verificationToken = verificationToken
      ..idempotencyKey = idempotencyKey
      ..countryCode = 'NG';

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.buyData(
      request,
      options: options,
    );

    return DataPurchaseModel.fromResponse(response);
  }
}
