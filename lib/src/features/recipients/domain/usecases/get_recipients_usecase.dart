import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/domain/repositories/i_recipient_repository.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';

class GetRecipientsUseCase {
  final IRecipientRepository _repository;

  GetRecipientsUseCase(this._repository);

  Future<Either<Failure, List<RecipientModel>>> call({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
  }) async {
    return await _repository.getRecipients(
      accessToken: accessToken,
      countryCode: countryCode,
      currency: currency,
      favoritesOnly: favoritesOnly,
    );
  }

  Future<Either<Failure, PaginatedRecipientsResult>> callPaginated({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
    required int page,
    int pageSize = 20,
  }) async {
    return await _repository.getRecipientsPaginated(
      accessToken: accessToken,
      countryCode: countryCode,
      currency: currency,
      favoritesOnly: favoritesOnly,
      page: page,
      pageSize: pageSize,
    );
  }
} 