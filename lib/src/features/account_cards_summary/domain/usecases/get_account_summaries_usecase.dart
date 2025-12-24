import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import '../entities/account_summary_entity.dart';
import '../repositories/i_account_summary_repository.dart';


class GetAccountSummariesUseCase {
  final IAccountSummaryRepository _repository;

  GetAccountSummariesUseCase(this._repository);

  Future<Either<Failure, List<AccountSummaryEntity>>> call({
    required String userId,
    String? accessToken,
    String? country,
  }) async {
    return await _repository.getAccountSummaries(
      userId: userId,
      accessToken: accessToken,
      country: country,
    );
  }
} 