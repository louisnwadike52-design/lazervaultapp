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

// Success States
class GiftCardBrandsLoaded extends GiftCardState {
  final List<GiftCardBrand> brands;
  final String? selectedCategory;
  final bool isStale;

  const GiftCardBrandsLoaded(this.brands, {this.selectedCategory, this.isStale = false});

  @override
  List<Object> get props => [brands, if (selectedCategory != null) selectedCategory!, isStale];
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

class GiftCardTransactionsLoaded extends GiftCardState {
  final List<GiftCardTransaction> transactions;
  const GiftCardTransactionsLoaded(this.transactions);
  @override
  List<Object> get props => [transactions];
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

class MyGiftCardsLoaded extends GiftCardState {
  final List<GiftCard> giftCards;

  const MyGiftCardsLoaded(this.giftCards);

  @override
  List<Object> get props => [giftCards];
}

// ============================================
// PRODUCTION-READY STATES
// ============================================

// Multi-step Purchase Processing States
class GiftCardPurchaseProcessing extends GiftCardState {
  final String brandId;
  final double amount;
  final String currentStep;
  final double progress; // 0.0 to 1.0

  const GiftCardPurchaseProcessing({
    required this.brandId,
    required this.amount,
    required this.currentStep,
    required this.progress,
  });

  @override
  List<Object> get props => [brandId, amount, currentStep, progress];
}

class GiftCardPurchaseCompleted extends GiftCardState {
  final GiftCard giftCard;
  final String? receiptUrl;
  final String? transactionId;

  const GiftCardPurchaseCompleted({
    required this.giftCard,
    this.receiptUrl,
    this.transactionId,
  });

  @override
  List<Object> get props => [
        giftCard,
        if (receiptUrl != null) receiptUrl!,
        if (transactionId != null) transactionId!,
      ];
}

// Empty States
class GiftCardBrandsEmpty extends GiftCardState {
  final String? category;
  final String? searchQuery;

  const GiftCardBrandsEmpty({this.category, this.searchQuery});

  @override
  List<Object> get props => [
        if (category != null) category!,
        if (searchQuery != null) searchQuery!,
      ];
}

class UserGiftCardsEmpty extends GiftCardState {
  const UserGiftCardsEmpty();
}

class TransactionsEmpty extends GiftCardState {
  const TransactionsEmpty();
}

// Specific Error States (Production Edge Cases)
class GiftCardInsufficientFunds extends GiftCardState {
  final double required;
  final double available;
  final String brandName;

  const GiftCardInsufficientFunds({
    required this.required,
    required this.available,
    required this.brandName,
  });

  @override
  List<Object> get props => [required, available, brandName];
}

class GiftCardExpired extends GiftCardState {
  final GiftCard giftCard;
  final String expiryDate;

  const GiftCardExpired({
    required this.giftCard,
    required this.expiryDate,
  });

  @override
  List<Object> get props => [giftCard, expiryDate];
}

class GiftCardSoldOut extends GiftCardState {
  final String brandId;
  final String brandName;

  const GiftCardSoldOut({
    required this.brandId,
    required this.brandName,
  });

  @override
  List<Object> get props => [brandId, brandName];
}

class GiftCardNetworkError extends GiftCardState {
  final String message;
  final bool canRetry;
  final String? operation;

  const GiftCardNetworkError({
    required this.message,
    this.canRetry = true,
    this.operation,
  });

  @override
  List<Object> get props => [
        message,
        canRetry,
        if (operation != null) operation!,
      ];
}

class GiftCardNotFound extends GiftCardState {
  final String identifier;
  final String type; // 'card' or 'brand'

  const GiftCardNotFound({
    required this.identifier,
    required this.type,
  });

  @override
  List<Object> get props => [identifier, type];
}

class GiftCardValidationError extends GiftCardState {
  final String field;
  final String message;

  const GiftCardValidationError({
    required this.field,
    required this.message,
  });

  @override
  List<Object> get props => [field, message];
}

// ============================================
// REDEEM FLOW STATES
// ============================================

class GiftCardRedeeming extends GiftCardState {}

class GiftCardRedeemed extends GiftCardState {
  final GiftCard giftCard;
  final double amountRedeemed;

  const GiftCardRedeemed({
    required this.giftCard,
    required this.amountRedeemed,
  });

  @override
  List<Object> get props => [giftCard, amountRedeemed];
}

class GiftCardRedeemError extends GiftCardState {
  final String message;
  const GiftCardRedeemError(this.message);
  @override
  List<Object> get props => [message];
}

// ============================================
// TRANSFER FLOW STATES
// ============================================

class GiftCardTransferring extends GiftCardState {}

class GiftCardTransferred extends GiftCardState {
  final GiftCard giftCard;

  const GiftCardTransferred({required this.giftCard});

  @override
  List<Object> get props => [giftCard];
}

class GiftCardTransferError extends GiftCardState {
  final String message;
  const GiftCardTransferError(this.message);
  @override
  List<Object> get props => [message];
}

// ============================================
// BALANCE CHECK STATES
// ============================================

class GiftCardBalanceLoading extends GiftCardState {}

class GiftCardBalanceLoaded extends GiftCardState {
  final double balance;
  final String brandName;
  final String expiryDate;
  final String status;

  const GiftCardBalanceLoaded({
    required this.balance,
    required this.brandName,
    required this.expiryDate,
    required this.status,
  });

  @override
  List<Object> get props => [balance, brandName, expiryDate, status];
}

class GiftCardBalanceError extends GiftCardState {
  final String message;
  const GiftCardBalanceError(this.message);
  @override
  List<Object> get props => [message];
}

// ============================================
// SELL FLOW STATES
// ============================================

class SellableCardsLoading extends GiftCardState {}

class SellableCardsLoaded extends GiftCardState {
  final List<SellableCard> cards;

  const SellableCardsLoaded(this.cards);

  @override
  List<Object> get props => [cards];
}

class SellableCardsEmpty extends GiftCardState {
  const SellableCardsEmpty();
}

class SellRateLoading extends GiftCardState {}

class SellRateLoaded extends GiftCardState {
  final SellRate rate;

  const SellRateLoaded(this.rate);

  @override
  List<Object> get props => [rate];
}

class SellRateExpired extends GiftCardState {
  final String cardType;
  final double denomination;

  const SellRateExpired({
    required this.cardType,
    required this.denomination,
  });

  @override
  List<Object> get props => [cardType, denomination];
}

class SellProcessing extends GiftCardState {
  final String cardType;
  final double denomination;
  final String currentStep;
  final double progress;

  const SellProcessing({
    required this.cardType,
    required this.denomination,
    required this.currentStep,
    required this.progress,
  });

  @override
  List<Object> get props => [cardType, denomination, currentStep, progress];
}

class SellSubmitted extends GiftCardState {
  final GiftCardSale sale;
  final String message;

  const SellSubmitted({
    required this.sale,
    this.message = 'Your card has been submitted for review',
  });

  @override
  List<Object> get props => [sale, message];
}

class SellStatusLoaded extends GiftCardState {
  final GiftCardSale sale;

  const SellStatusLoaded(this.sale);

  @override
  List<Object> get props => [sale];
}

class MySalesLoaded extends GiftCardState {
  final List<GiftCardSale> sales;

  const MySalesLoaded(this.sales);

  @override
  List<Object> get props => [sales];
}

class MySalesEmpty extends GiftCardState {
  const MySalesEmpty();
}

class SellError extends GiftCardState {
  final String message;

  const SellError(this.message);

  @override
  List<Object> get props => [message];
}

class SellQueued extends GiftCardState {
  final String message;

  const SellQueued({required this.message});

  @override
  List<Object> get props => [message];
}

