import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class GetStockAnalysisUseCase {
  final IStockRepository repository;

  GetStockAnalysisUseCase(this.repository);

  Future<Either<Failure, StockAnalysis>> call(String symbol) async {
    return await repository.getStockAnalysis(symbol);
  }
} 