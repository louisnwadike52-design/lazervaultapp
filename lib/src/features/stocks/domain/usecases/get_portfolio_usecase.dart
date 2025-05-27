import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class GetPortfolioUseCase {
  final IStockRepository repository;

  GetPortfolioUseCase(this.repository);

  Future<Either<Failure, Portfolio>> call() async {
    return await repository.getPortfolio();
  }
} 