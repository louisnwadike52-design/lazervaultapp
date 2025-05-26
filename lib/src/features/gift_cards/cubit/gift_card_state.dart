import 'package:equatable/equatable.dart';
import '../domain/entities/gift_card_entity.dart';

abstract class GiftCardState extends Equatable {
  const GiftCardState();

  @override
  List<Object> get props => [];
}

// Initial States
class GiftCardInitial extends GiftCardState {}

// Loading States
class GiftCardLoading extends GiftCardState {}
class GiftCardBrandsLoading extends GiftCardState {}
class GiftCardPurchasing extends GiftCardState {}
class GiftCardRedeeming extends GiftCardState {}
class GiftCardSending extends GiftCardState {}
class GiftCardSelling extends GiftCardState {}

// Success States
class GiftCardBrandsLoaded extends GiftCardState {
  final List<GiftCardBrand> brands;
  final GiftCardCategory? selectedCategory;

  const GiftCardBrandsLoaded(this.brands, {this.selectedCategory});

  @override
  List<Object> get props => [brands, if (selectedCategory != null) selectedCategory!];
}

class GiftCardBrandsSearched extends GiftCardState {
  final List<GiftCardBrand> brands;
  final String query;

  const GiftCardBrandsSearched(this.brands, this.query);

  @override
  List<Object> get props => [brands, query];
}

class UserGiftCardsLoaded extends GiftCardState {
  final List<GiftCard> giftCards;
  const UserGiftCardsLoaded(this.giftCards);
  @override
  List<Object> get props => [giftCards];
}

class GiftCardDetailsLoaded extends GiftCardState {
  final GiftCard giftCard;
  const GiftCardDetailsLoaded(this.giftCard);
  @override
  List<Object> get props => [giftCard];
}

class GiftCardPurchased extends GiftCardState {
  final GiftCard giftCard;
  const GiftCardPurchased(this.giftCard);
  @override
  List<Object> get props => [giftCard];
}

class GiftCardRedeemed extends GiftCardState {
  final GiftCard giftCard;
  const GiftCardRedeemed(this.giftCard);
  @override
  List<Object> get props => [giftCard];
}

class GiftCardSent extends GiftCardState {
  final GiftCard giftCard;
  const GiftCardSent(this.giftCard);
  @override
  List<Object> get props => [giftCard];
}

class GiftCardSold extends GiftCardState {
  final GiftCard giftCard;
  const GiftCardSold(this.giftCard);
  @override
  List<Object> get props => [giftCard];
}

class GiftCardTransactionsLoaded extends GiftCardState {
  final List<GiftCardTransaction> transactions;
  const GiftCardTransactionsLoaded(this.transactions);
  @override
  List<Object> get props => [transactions];
}

class GiftCardCodeValidated extends GiftCardState {
  final bool isValid;
  const GiftCardCodeValidated(this.isValid);
  @override
  List<Object> get props => [isValid];
}

class GiftCardBalanceLoaded extends GiftCardState {
  final double balance;
  final String giftCardId;
  const GiftCardBalanceLoaded(this.balance, this.giftCardId);
  @override
  List<Object> get props => [balance, giftCardId];
}

// Error States
class GiftCardError extends GiftCardState {
  final String message;
  final int? statusCode;

  const GiftCardError(this.message, {this.statusCode});

  @override
  List<Object> get props => [message, if (statusCode != null) statusCode!];
}

class GiftCardPurchaseError extends GiftCardState {
  final String message;
  const GiftCardPurchaseError(this.message);
  @override
  List<Object> get props => [message];
}

class GiftCardRedeemError extends GiftCardState {
  final String message;
  const GiftCardRedeemError(this.message);
  @override
  List<Object> get props => [message];
}

class GiftCardSendError extends GiftCardState {
  final String message;
  const GiftCardSendError(this.message);
  @override
  List<Object> get props => [message];
}

class GiftCardSellError extends GiftCardState {
  final String message;
  const GiftCardSellError(this.message);
  @override
  List<Object> get props => [message];
}

class MyGiftCardsLoaded extends GiftCardState {
  final List<GiftCard> giftCards;

  const MyGiftCardsLoaded(this.giftCards);

  @override
  List<Object> get props => [giftCards];
} 