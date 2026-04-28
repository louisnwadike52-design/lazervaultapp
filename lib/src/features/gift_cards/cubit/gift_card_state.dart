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
// GET REDEEM CODE STATES
// ============================================

class GiftCardRedeeming extends GiftCardState {}

/// The merchant redeem code was successfully retrieved from the provider
class RedeemCodeLoaded extends GiftCardState {
  final String redemptionCode;          // The actual merchant code (e.g., Amazon code)
  final String redemptionPin;           // PIN code (if applicable)
  final String transactionId;           // Provider transaction ID
  final String status;                  // "available", "pending", "unavailable"
  final String message;

  const RedeemCodeLoaded({
    required this.redemptionCode,
    required this.redemptionPin,
    required this.transactionId,
    required this.status,
    required this.message,
  });

  @override
  List<Object> get props => [redemptionCode, redemptionPin, transactionId, status, message];
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

/// Payout-method picker — loading.
class PayoutMethodsLoading extends GiftCardState {
  const PayoutMethodsLoading();
}

/// Payout-method picker — methods returned by the backend (filtered to
/// available==true). The Flutter sell flow renders these as a single-
/// selection list.
class PayoutMethodsLoaded extends GiftCardState {
  final List<PayoutMethodEntity> methods;
  /// Pre-selected method when the system_settings default is in the
  /// available list, empty string when the UI should pick the first row.
  final String defaultMethodName;

  const PayoutMethodsLoaded(this.methods, {this.defaultMethodName = ''});

  @override
  List<Object> get props => [methods, defaultMethodName];
}

/// Payout-method fetch failure. Shown as inline error on the picker
/// step; user can retry.
class PayoutMethodsError extends GiftCardState {
  final String message;
  const PayoutMethodsError(this.message);

  @override
  List<Object> get props => [message];
}

/// Emitted when the user attempts to advance past the disclaimer step
/// without ticking the acceptance checkbox. The UI listens for this to
/// shake the checkbox / show inline error copy.
class SellDisclaimerNotAccepted extends GiftCardState {
  const SellDisclaimerNotAccepted();
}

class GiftCardBrandsLoadingMore extends GiftCardState {
  final List<GiftCardBrand> currentBrands;
  const GiftCardBrandsLoadingMore(this.currentBrands);
  @override
  List<Object> get props => [currentBrands];
}

class SupportedCountriesLoaded extends GiftCardState {
  final List<GiftCardCountry> countries;
  const SupportedCountriesLoaded(this.countries);
  @override
  List<Object> get props => [countries];
}

class GiftCardTimeoutError extends GiftCardState {
  final String operation;
  const GiftCardTimeoutError({this.operation = ''});
  @override
  List<Object> get props => [operation];
}

class GiftCardServerUnavailable extends GiftCardState {
  final String operation;
  const GiftCardServerUnavailable({this.operation = ''});
  @override
  List<Object> get props => [operation];
}

// ============================================
// IMAGE UPLOAD STATES
// ============================================

class SellImageUploading extends GiftCardState {}

class SellImageUploaded extends GiftCardState {
  final String imageUrl;
  final String imageKey;
  const SellImageUploaded({required this.imageUrl, required this.imageKey});
  @override
  List<Object> get props => [imageUrl, imageKey];
}

class SellImageError extends GiftCardState {
  final String message;
  const SellImageError(this.message);
  @override
  List<Object> get props => [message];
}

// ============================================
// OCR EXTRACTION STATES
// ============================================

class OCRExtracting extends GiftCardState {}

class OCRExtracted extends GiftCardState {
  final String brand;
  final String cardNumber;
  final String pin;
  final double denomination;
  final String currency;
  final double confidence;
  final String rawText;
  const OCRExtracted({
    required this.brand,
    required this.cardNumber,
    required this.pin,
    required this.denomination,
    required this.currency,
    required this.confidence,
    required this.rawText,
  });
  @override
  List<Object> get props => [brand, cardNumber, pin, denomination, currency, confidence, rawText];
}

class OCRFailed extends GiftCardState {
  final String message;
  const OCRFailed(this.message);
  @override
  List<Object> get props => [message];
}


// ============================================
// PROVIDER SELECTION STATES (PRESTMIT/MANUAL)
// ============================================

class SellProviderLoading extends GiftCardState {}

class SellProviderLoaded extends GiftCardState {
  final String provider; // "manual" or "prestmit"
  final String description;

  const SellProviderLoaded({
    required this.provider,
    required this.description,
  });

  @override
  List<Object> get props => [provider, description];
}

class SellProviderError extends GiftCardState {
  final String message;

  const SellProviderError(this.message);

  @override
  List<Object> get props => [message];
}

// ============================================
// SETTLEMENT HISTORY STATES
// ============================================

class SettlementHistoryLoading extends GiftCardState {}

class SettlementHistoryLoaded extends GiftCardState {
  final List<Settlement> settlements;

  const SettlementHistoryLoaded(this.settlements);

  @override
  List<Object> get props => [settlements];
}

class SettlementHistoryEmpty extends GiftCardState {
  const SettlementHistoryEmpty();
}

class SettlementDetailLoaded extends GiftCardState {
  final Settlement settlement;

  const SettlementDetailLoaded(this.settlement);

  @override
  List<Object> get props => [settlement];
}

class SettlementRetryInitiated extends GiftCardState {
  final String settlementId;
  final String message;

  const SettlementRetryInitiated({
    required this.settlementId,
    required this.message,
  });

  @override
  List<Object> get props => [settlementId, message];
}

class SettlementExportSuccess extends GiftCardState {
  final String filePath;
  final String format; // "pdf" or "csv"

  const SettlementExportSuccess({
    required this.filePath,
    required this.format,
  });

  @override
  List<Object> get props => [filePath, format];
}
