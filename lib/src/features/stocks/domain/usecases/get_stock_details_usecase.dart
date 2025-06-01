import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class GetStockDetailsUseCase {
  final IStockRepository repository;

  GetStockDetailsUseCase(this.repository);

  Future<Either<Failure, Stock>> call(String symbol) async {
    return await repository.getStockDetails(symbol);
  }
} 