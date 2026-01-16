import 'package:dartz/dartz.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class RemoveFromWatchlistUseCase {
  final IStockRepository repository;

  RemoveFromWatchlistUseCase(this.repository);

  Future<Either<Failure, void>> call(String watchlistId, String symbol) async {
    return await repository.removeFromWatchlist(watchlistId, symbol);
  }
} 