import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class GetWatchlistsUseCase {
  final IStockRepository repository;

  GetWatchlistsUseCase(this.repository);

  Future<Either<Failure, List<Watchlist>>> call() async {
    return await repository.getWatchlists();
  }
} 