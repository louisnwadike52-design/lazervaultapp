import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class CreateWatchlistUseCase {
  final IStockRepository repository;

  CreateWatchlistUseCase(this.repository);

  Future<Either<Failure, Watchlist>> call(String name, List<String> symbols) async {
    return await repository.createWatchlist(name, symbols);
  }
} 