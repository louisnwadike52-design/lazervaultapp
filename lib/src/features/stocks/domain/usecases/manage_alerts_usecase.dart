import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class ManageAlertsUseCase {
  final IStockRepository repository;

  ManageAlertsUseCase(this.repository);

  Future<Either<Failure, List<StockAlert>>> getAlerts() async {
    return await repository.getAlerts();
  }

  Future<Either<Failure, StockAlert>> createAlert({
    required String symbol,
    required AlertType type,
    required double targetValue,
    required AlertCondition condition,
  }) async {
    return await repository.createAlert(
      symbol: symbol,
      type: type,
      targetValue: targetValue,
      condition: condition,
    );
  }

  Future<Either<Failure, StockAlert>> updateAlert(
    String alertId, {
    AlertType? type,
    double? targetValue,
    AlertCondition? condition,
    bool? isActive,
  }) async {
    return await repository.updateAlert(
      alertId,
      type: type,
      targetValue: targetValue,
      condition: condition,
      isActive: isActive,
    );
  }

  Future<Either<Failure, void>> deleteAlert(String alertId) async {
    return await repository.deleteAlert(alertId);
  }
} 