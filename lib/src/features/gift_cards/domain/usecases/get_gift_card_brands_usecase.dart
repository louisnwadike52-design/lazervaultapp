import 'package:fpdart/fpdart.dart';
import 'package:lazervault/core/errors/failure.dart';
import '../entities/gift_card_entity.dart';
import '../repositories/i_gift_card_repository.dart';

class GetGiftCardBrandsUseCase {
  final IGiftCardRepository _repository;

  GetGiftCardBrandsUseCase(this._repository);

  Future<Either<Failure, List<GiftCardBrand>>> call() async {
    return await _repository.getGiftCardBrands();
  }
}

class GetGiftCardBrandsByCategoryUseCase {
  final IGiftCardRepository _repository;

  GetGiftCardBrandsByCategoryUseCase(this._repository);

  Future<Either<Failure, List<GiftCardBrand>>> call(GiftCardCategory category) async {
    return await _repository.getGiftCardBrandsByCategory(category);
  }
}

class SearchGiftCardBrandsUseCase {
  final IGiftCardRepository _repository;

  SearchGiftCardBrandsUseCase(this._repository);

  Future<Either<Failure, List<GiftCardBrand>>> call(String query) async {
    return await _repository.searchGiftCardBrands(query);
  }
} 