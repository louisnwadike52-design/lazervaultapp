import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/epin_entities.dart';
import '../../domain/repositories/epin_repository.dart';
import '../models/epin_models.dart';

abstract class EPinRemoteDataSource {
  Future<List<EPinNetwork>> getNetworks();
  Future<EPinPurchaseResult> initiatePurchase({
    required String network,
    required double denomination,
    required int quantity,
    required String sourceAccountId,
    required String phoneNumber,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String businessName,
  });
  Future<EPinOrder> getOrder(String orderId);
  Future<List<EPinOrder>> listOrders({int limit, int offset});
  Future<(EPinOrder, String)> getReceipt(String orderId);
}

class EPinRemoteDataSourceImpl implements EPinRemoteDataSource {
  final GrpcClient grpcClient;

  EPinRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<List<EPinNetwork>> getNetworks() async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getEPinNetworks(pb.GetEPinNetworksRequest(), options: options);
      return response.networks.map(EPinMappers.network).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch recharge card networks: ${e.message}');
    }
  }

  @override
  Future<EPinPurchaseResult> initiatePurchase({
    required String network,
    required double denomination,
    required int quantity,
    required String sourceAccountId,
    required String phoneNumber,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String businessName = '',
  }) async {
    try {
      final request = pb.InitiateEPinPurchaseRequest()
        ..network = network
        ..denomination = denomination
        ..quantity = quantity
        ..sourceAccountId = sourceAccountId
        ..phoneNumber = phoneNumber
        ..transactionId = transactionId
        ..verificationToken = verificationToken
        ..idempotencyKey = idempotencyKey
        ..businessName = businessName.trim();

      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .initiateEPinPurchase(request, options: options);

      return EPinPurchaseResult(
        order: EPinMappers.order(response.order),
        newBalance: response.newBalance,
        message: response.message,
      );
    } on GrpcError catch (e) {
      throw Exception('Failed to purchase recharge cards: ${e.message}');
    }
  }

  @override
  Future<EPinOrder> getOrder(String orderId) async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient.getEPinOrder(
        pb.GetEPinOrderRequest()..orderId = orderId,
        options: options,
      );
      return EPinMappers.order(response.order);
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch order: ${e.message}');
    }
  }

  @override
  Future<List<EPinOrder>> listOrders({int limit = 20, int offset = 0}) async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient.listEPinOrders(
        pb.ListEPinOrdersRequest()
          ..limit = limit
          ..offset = offset,
        options: options,
      );
      return response.orders.map(EPinMappers.order).toList();
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch orders: ${e.message}');
    }
  }

  @override
  Future<(EPinOrder, String)> getReceipt(String orderId) async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient.getEPinReceipt(
        pb.GetEPinReceiptRequest()..orderId = orderId,
        options: options,
      );
      return (EPinMappers.order(response.order), response.pdfUrl);
    } on GrpcError catch (e) {
      throw Exception('Failed to fetch receipt: ${e.message}');
    }
  }
}
