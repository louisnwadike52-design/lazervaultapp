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

// ============================================
// NEW PRODUCTION-READY STATES (Insurance Pattern)
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

// Redemption Processing States
class GiftCardRedemptionProcessing extends GiftCardState {
  final String giftCardId;
  final String currentStep;
  final double progress;

  const GiftCardRedemptionProcessing({
    required this.giftCardId,
    required this.currentStep,
    required this.progress,
  });

  @override
  List<Object> get props => [giftCardId, currentStep, progress];
}

class GiftCardRedemptionCompleted extends GiftCardState {
  final GiftCard giftCard;
  final double redeemedAmount;
  final double remainingBalance;
  final String? receiptUrl;

  const GiftCardRedemptionCompleted({
    required this.giftCard,
    required this.redeemedAmount,
    required this.remainingBalance,
    this.receiptUrl,
  });

  @override
  List<Object> get props => [
        giftCard,
        redeemedAmount,
        remainingBalance,
        if (receiptUrl != null) receiptUrl!,
      ];
}

// Statistics with Dashboard Data
class GiftCardStatisticsLoaded extends GiftCardState {
  final int totalCards;
  final int activeCards;
  final int usedCards;
  final int pendingCards;
  final int expiredCards;
  final double totalValue;
  final double totalSpent;
  final double totalSaved;
  final List<GiftCard> recentCards;
  final List<GiftCardTransaction> recentTransactions;

  const GiftCardStatisticsLoaded({
    required this.totalCards,
    required this.activeCards,
    required this.usedCards,
    required this.pendingCards,
    required this.expiredCards,
    required this.totalValue,
    required this.totalSpent,
    required this.totalSaved,
    required this.recentCards,
    required this.recentTransactions,
  });

  @override
  List<Object> get props => [
        totalCards,
        activeCards,
        usedCards,
        pendingCards,
        expiredCards,
        totalValue,
        totalSpent,
        totalSaved,
        recentCards,
        recentTransactions,
      ];
}

// Balance Check Result
class GiftCardBalanceChecked extends GiftCardState {
  final String giftCardId;
  final double remainingBalance;
  final double originalAmount;
  final double redeemedAmount;
  final GiftCard? giftCard;

  const GiftCardBalanceChecked({
    required this.giftCardId,
    required this.remainingBalance,
    required this.originalAmount,
    required this.redeemedAmount,
    this.giftCard,
  });

  @override
  List<Object> get props => [
        giftCardId,
        remainingBalance,
        originalAmount,
        redeemedAmount,
        if (giftCard != null) giftCard!,
      ];
}

// Empty States
class GiftCardBrandsEmpty extends GiftCardState {
  final GiftCardCategory? category;
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

class ResellableCardsEmpty extends GiftCardState {
  const ResellableCardsEmpty();
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
  final DateTime expiryDate;

  const GiftCardExpired({
    required this.giftCard,
    required this.expiryDate,
  });

  @override
  List<Object> get props => [giftCard, expiryDate];
}

class GiftCardAlreadyRedeemed extends GiftCardState {
  final GiftCard giftCard;
  final DateTime? redeemedAt;

  const GiftCardAlreadyRedeemed({
    required this.giftCard,
    this.redeemedAt,
  });

  @override
  List<Object> get props => [
        giftCard,
        if (redeemedAt != null) redeemedAt!,
      ];
}

class GiftCardInvalidCode extends GiftCardState {
  final String code;
  final String message;

  const GiftCardInvalidCode({
    required this.code,
    required this.message,
  });

  @override
  List<Object> get props => [code, message];
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
  final String identifier; // ID or code
  final String type; // 'card' or 'brand'

  const GiftCardNotFound({
    required this.identifier,
    required this.type,
  });

  @override
  List<Object> get props => [identifier, type];
}

class GiftCardTransferError extends GiftCardState {
  final String message;
  final String giftCardId;
  final String recipientEmail;

  const GiftCardTransferError({
    required this.message,
    required this.giftCardId,
    required this.recipientEmail,
  });

  @override
  List<Object> get props => [message, giftCardId, recipientEmail];
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

// Transfer/Send States
class GiftCardTransferProcessing extends GiftCardState {
  final String giftCardId;
  final String recipientEmail;
  final String currentStep;
  final double progress;

  const GiftCardTransferProcessing({
    required this.giftCardId,
    required this.recipientEmail,
    required this.currentStep,
    required this.progress,
  });

  @override
  List<Object> get props => [giftCardId, recipientEmail, currentStep, progress];
}

class GiftCardTransferCompleted extends GiftCardState {
  final GiftCard giftCard;
  final String recipientEmail;

  const GiftCardTransferCompleted({
    required this.giftCard,
    required this.recipientEmail,
  });

  @override
  List<Object> get props => [giftCard, recipientEmail];
}

// Sell/Resale States
class GiftCardSellProcessing extends GiftCardState {
  final String giftCardId;
  final double askingPrice;
  final String currentStep;
  final double progress;

  const GiftCardSellProcessing({
    required this.giftCardId,
    required this.askingPrice,
    required this.currentStep,
    required this.progress,
  });

  @override
  List<Object> get props => [giftCardId, askingPrice, currentStep, progress];
}

class GiftCardSellCompleted extends GiftCardState {
  final GiftCard giftCard;
  final String listingId;
  final double askingPrice;

  const GiftCardSellCompleted({
    required this.giftCard,
    required this.listingId,
    required this.askingPrice,
  });

  @override
  List<Object> get props => [giftCard, listingId, askingPrice];
}

class ResellableGiftCardsLoaded extends GiftCardState {
  final List<GiftCard> giftCards;

  const ResellableGiftCardsLoaded(this.giftCards);

  @override
  List<Object> get props => [giftCards];
} 