import 'package:grpc/grpc.dart';
import '../../../../core/network/grpc_client.dart';
import '../../../../generated/utility-payments.pb.dart' as pb;
import '../../domain/entities/epin_entities.dart';
import '../../domain/repositories/epin_repository.dart';
import '../models/epin_models.dart';

/// A catalogue read: the networks plus the active rail's order minimum.
typedef EPinCatalogue = ({List<EPinNetwork> networks, int minQuantity});

abstract class EPinRemoteDataSource {
  /// The catalogue AND the active rail's smallest printable order.
  ///
  /// The two travel together deliberately. The minimum is the PROVIDER's term
  /// — ePINs prints in batches of ten or more, VTU.africa prints singles — so
  /// a picker built against a number from anywhere else can offer a quantity
  /// the purchase will refuse.
  Future<EPinCatalogue> getNetworks();
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
  Future<EPinCatalogue> getNetworks() async {
    try {
      final options = await grpcClient.callOptions;
      final response = await grpcClient.utilityPaymentsClient
          .getEPinNetworks(pb.GetEPinNetworksRequest(), options: options);
      return (
        networks: response.networks.map(EPinMappers.network).toList(),
        // 0 means the server did not state one (an older build). Treat that
        // as 1 rather than blocking — a floor the app invents would refuse
        // orders a working rail would take.
        minQuantity:
            response.minQuantity > 0 ? response.minQuantity : 1,
      );
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
