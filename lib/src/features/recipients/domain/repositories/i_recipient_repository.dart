import 'package:dartz/dartz.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

abstract class IRecipientRepository {
  Future<Either<Failure, List<RecipientModel>>> getRecipients({
    required String accessToken,
    String? countryCode,
    String? currency,
    bool? favoritesOnly,
  });
  Future<Either<Failure, RecipientModel>> addRecipient({required RecipientModel recipient, required String accessToken});
  Future<Either<Failure, void>> toggleFavorite({required String recipientId, required bool isFavorite, required String accessToken});
} 