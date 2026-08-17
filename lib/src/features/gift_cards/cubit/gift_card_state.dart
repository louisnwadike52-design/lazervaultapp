import 'package:equatable/equatable.dart';
import '../domain/entities/gift_card_entity.dart';
part 'gift_card_state_widgets.dart';


// Success States
class GiftCardBrandsLoaded extends GiftCardState {
  final List<GiftCardBrand> brands;
  final String? selectedCategory;
  final bool isStale;
  final int currentPage;
  final int totalPages;
  final bool hasNext;
  final bool isLoadingMore;

  const GiftCardBrandsLoaded(
    this.brands, {
    this.selectedCategory,
    this.isStale = false,
    this.currentPage = 0,
    this.totalPages = 1,
    this.hasNext = false,
    this.isLoadingMore = false,
  });

  @override
  List<Object> get props => [brands, if (selectedCategory != null) selectedCategory!, isStale, currentPage, totalPages, hasNext, isLoadingMore];
}
