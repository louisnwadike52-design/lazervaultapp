import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class PlaceOrderUseCase {
  final IStockRepository repository;

  PlaceOrderUseCase(this.repository);

  Future<Either<Failure, StockOrder>> call({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
  }) async {
    return await repository.placeOrder(
      symbol: symbol,
      type: type,
      side: side,
      quantity: quantity,
      price: price,
    );
  }
} 