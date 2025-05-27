import 'package:dartz/dartz.dart';
import '../entities/stock_entity.dart';
import '../repositories/i_stock_repository.dart';
import '../../../../core/errors/failures.dart';

class GetOptionsUseCase {
  final IStockRepository repository;

  GetOptionsUseCase(this.repository);

  Future<Either<Failure, List<OptionContract>>> call(
    String underlyingSymbol, {
    DateTime? expirationDate,
    OptionType? type,
  }) async {
    return await repository.getOptions(
      underlyingSymbol,
      expirationDate: expirationDate,
      type: type,
    );
  }

  Future<Either<Failure, OptionContract>> getOptionDetails(String optionSymbol) async {
    return await repository.getOptionDetails(optionSymbol);
  }
} 