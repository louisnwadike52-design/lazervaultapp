import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class ManageTradingSessionsUseCase {
  final IStockRepository repository;

  ManageTradingSessionsUseCase(this.repository);

  Future<Either<Failure, TradingSession>> getCurrentSession() async {
    return await repository.getCurrentTradingSession();
  }

  Future<Either<Failure, TradingSession>> startSession(double startingBalance) async {
    return await repository.startTradingSession(startingBalance);
  }

  Future<Either<Failure, TradingSession>> endSession(String sessionId) async {
    return await repository.endTradingSession(sessionId);
  }

  Future<Either<Failure, List<TradingSession>>> getSessionHistory() async {
    return await repository.getTradingSessionHistory();
  }
} 