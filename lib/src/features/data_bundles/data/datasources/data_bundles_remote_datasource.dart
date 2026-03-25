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
    String countryCode = 'NG',
  });

  // Auto-renewal (non-expiring data)
  Future<pb.EnableAutoRenewResponse> enableAutoRenew({
    required String subscriptionId,
    required String variationId,
    required String network,
    required double amount,
  });
  Future<pb.DisableAutoRenewResponse> disableAutoRenew({
    required String subscriptionId,
  });
  Future<pb.GetAutoRenewSubscriptionsResponse> getAutoRenewSubscriptions({
    int limit = 50,
    int offset = 0,
  });
  Future<pb.UpdateAutoRenewPlanResponse> updateAutoRenewPlan({
    required String subscriptionId,
    required String newVariationId,
    required double newAmount,
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
    String countryCode = 'NG',
  }) async {
    final request = pb.BuyDataRequest()
      ..phoneNumber = phoneNumber
      ..network = network
      ..variationId = variationId
      ..amount = amount
      ..transactionId = transactionId
      ..verificationToken = verificationToken
      ..idempotencyKey = idempotencyKey
      ..countryCode = countryCode;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient.buyData(
      request,
      options: options,
    );

    return DataPurchaseModel.fromResponse(response);
  }

  @override
  Future<pb.EnableAutoRenewResponse> enableAutoRenew({
    required String subscriptionId,
    required String variationId,
    required String network,
    required double amount,
  }) async {
    final request = pb.EnableAutoRenewRequest()
      ..subscriptionId = subscriptionId
      ..variationId = variationId
      ..network = network
      ..amount = amount;

    final options = await grpcClient.callOptions;
    return grpcClient.utilityPaymentsClient.enableAutoRenew(
      request,
      options: options,
    );
  }

  @override
  Future<pb.DisableAutoRenewResponse> disableAutoRenew({
    required String subscriptionId,
  }) async {
    final request = pb.DisableAutoRenewRequest()
      ..subscriptionId = subscriptionId;

    final options = await grpcClient.callOptions;
    return grpcClient.utilityPaymentsClient.disableAutoRenew(
      request,
      options: options,
    );
  }

  @override
  Future<pb.GetAutoRenewSubscriptionsResponse> getAutoRenewSubscriptions({
    int limit = 50,
    int offset = 0,
  }) async {
    final request = pb.GetAutoRenewSubscriptionsRequest()
      ..limit = limit
      ..offset = offset;

    final options = await grpcClient.callOptions;
    return grpcClient.utilityPaymentsClient.getAutoRenewSubscriptions(
      request,
      options: options,
    );
  }

  @override
  Future<pb.UpdateAutoRenewPlanResponse> updateAutoRenewPlan({
    required String subscriptionId,
    required String newVariationId,
    required double newAmount,
  }) async {
    final request = pb.UpdateAutoRenewPlanRequest()
      ..subscriptionId = subscriptionId
      ..newVariationId = newVariationId
      ..newAmount = newAmount;

    final options = await grpcClient.callOptions;
    return grpcClient.utilityPaymentsClient.updateAutoRenewPlan(
      request,
      options: options,
    );
  }
}
