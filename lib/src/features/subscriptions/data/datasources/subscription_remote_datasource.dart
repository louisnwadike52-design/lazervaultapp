import 'package:lazervault/src/core/network/grpc_client.dart';
import 'package:lazervault/src/features/subscriptions/data/models/active_subscription_model.dart';
import 'package:lazervault/src/features/subscriptions/data/models/subscription_summary_model.dart';
import 'package:lazervault/src/features/subscriptions/data/models/subscription_spending_model.dart';
import 'package:lazervault/src/generated/utility-payments.pb.dart' as pb;

abstract class SubscriptionRemoteDataSource {
  Future<(List<ActiveSubscriptionModel>, int)> getActiveSubscriptions({
    String? type,
    int limit = 20,
    int offset = 0,
  });

  Future<SubscriptionSummaryModel> getSubscriptionSummary();

  Future<SubscriptionSpendingModel> getSubscriptionSpending({
    int months = 6,
  });
}

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final GrpcClient grpcClient;

  SubscriptionRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<(List<ActiveSubscriptionModel>, int)> getActiveSubscriptions({
    String? type,
    int limit = 20,
    int offset = 0,
  }) async {
    final request = pb.GetActiveSubscriptionsRequest()
      ..limit = limit
      ..offset = offset;

    if (type != null && type.isNotEmpty) {
      request.subscriptionType = type;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient
        .getActiveSubscriptions(request, options: options);

    final subscriptions = response.subscriptions
        .map((sub) => ActiveSubscriptionModel.fromProto(sub))
        .toList();

    return (subscriptions, response.total);
  }

  @override
  Future<SubscriptionSummaryModel> getSubscriptionSummary() async {
    final request = pb.GetSubscriptionSummaryRequest();

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient
        .getSubscriptionSummary(request, options: options);

    return SubscriptionSummaryModel.fromProto(response);
  }

  @override
  Future<SubscriptionSpendingModel> getSubscriptionSpending({
    int months = 6,
  }) async {
    final request = pb.GetSubscriptionSpendingRequest()..months = months;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.utilityPaymentsClient
        .getSubscriptionSpending(request, options: options);

    return SubscriptionSpendingModel.fromProto(response);
  }
}
