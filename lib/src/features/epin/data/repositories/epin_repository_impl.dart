import '../../domain/entities/epin_entities.dart';
import '../../domain/repositories/epin_repository.dart';
import '../datasources/epin_remote_datasource.dart';

class EPinRepositoryImpl implements EPinRepository {
  final EPinRemoteDataSource remoteDataSource;

  EPinRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<EPinNetwork>> getNetworks() => remoteDataSource.getNetworks();

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
  }) =>
      remoteDataSource.initiatePurchase(
        network: network,
        denomination: denomination,
        quantity: quantity,
        sourceAccountId: sourceAccountId,
        phoneNumber: phoneNumber,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
        businessName: businessName,
      );

  @override
  Future<EPinOrder> getOrder(String orderId) =>
      remoteDataSource.getOrder(orderId);

  @override
  Future<List<EPinOrder>> listOrders({int limit = 20, int offset = 0}) =>
      remoteDataSource.listOrders(limit: limit, offset: offset);

  @override
  Future<(EPinOrder, String)> getReceipt(String orderId) =>
      remoteDataSource.getReceipt(orderId);
}
