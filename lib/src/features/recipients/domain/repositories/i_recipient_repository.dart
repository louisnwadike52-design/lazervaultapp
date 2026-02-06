import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';

abstract class IRecipientRepository {
  Future<Either<Failure, List<RecipientModel>>> getRecipients({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
  });
  Future<Either<Failure, PaginatedRecipientsResult>> getRecipientsPaginated({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
    required int page,
    int pageSize = 20,
  });
  Future<Either<Failure, RecipientModel>> addRecipient({required RecipientModel recipient, required String accessToken});
  Future<Either<Failure, void>> toggleFavorite({required String recipientId, required bool isFavorite, required String accessToken});
  Future<Either<Failure, RecipientModel>> updateAlias({required String recipientId, required String? alias, required String accessToken});
  Future<Either<Failure, void>> deleteRecipient({required String recipientId, required String accessToken});
} 