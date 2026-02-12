import 'package:fpdart/fpdart.dart';
import 'package:lazervault/core/errors/failure.dart';
import '../entities/gift_card_entity.dart';
import '../repositories/i_gift_card_repository.dart';

class GetGiftCardBrandsUseCase {
  final IGiftCardRepository _repository;

  GetGiftCardBrandsUseCase(this._repository);

  Future<Either<Failure, List<GiftCardBrand>>> call({
    String? category,
    String? countryCode,
  }) async {
    return await _repository.getGiftCardBrands(
      category: category,
      countryCode: countryCode,
    );
  }
}
