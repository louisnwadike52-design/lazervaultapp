import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class GetStocksUseCase {
  final IStockRepository repository;

  GetStocksUseCase(this.repository);

  Future<Either<Failure, List<Stock>>> call({
    String? sector,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    return await repository.getStocks(
      sector: sector,
      searchQuery: searchQuery,
      page: page,
      limit: limit,
    );
  }
} 