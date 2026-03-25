import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import 'package:lazervault/src/core/errors/failures.dart';

class PlaceOrderUseCase {
  final IStockRepository repository;

  PlaceOrderUseCase(this.repository);

  Future<Either<Failure, StockOrder>> call({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
    double? quantityExact,
    String? transactionId,
    String? verificationToken,
  }) async {
    return await repository.placeOrder(
      symbol: symbol,
      type: type,
      side: side,
      quantity: quantity,
      price: price,
      quantityExact: quantityExact,
      transactionId: transactionId,
      verificationToken: verificationToken,
    );
  }
} 