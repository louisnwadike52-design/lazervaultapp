import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/gift_card_entity.dart';
import '../domain/repositories/i_gift_card_repository.dart';
import '../domain/validation/gift_card_validation.dart';
import 'gift_card_state.dart';

class GiftCardCubit extends Cubit<GiftCardState> {
  final IGiftCardRepository _repository;

  GiftCardCubit({required IGiftCardRepository repository})
      : _repository = repository,
        super(GiftCardInitial());

  Future<void> loadGiftCardBrands() async {
    try {
      if (isClosed) return;
      emit(GiftCardBrandsLoading());

      final result = await _repository.getGiftCardBrands();
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Loading brands',
        )),
        (brands) {
          if (brands.isEmpty) {
            emit(const GiftCardBrandsEmpty());
          } else {
            emit(GiftCardBrandsLoaded(brands));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading brands',
      ));
    }
  }

  Future<void> loadGiftCardBrandsByCategory(GiftCardCategory category) async {
    try {
      if (isClosed) return;
      emit(GiftCardBrandsLoading());

      final result = await _repository.getGiftCardBrandsByCategory(category);
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Loading brands by category',
        )),
        (brands) {
          if (brands.isEmpty) {
            emit(const GiftCardBrandsEmpty());
          } else {
            emit(GiftCardBrandsLoaded(brands));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading brands by category',
      ));
    }
  }

  Future<void> searchGiftCardBrands(String query) async {
    try {
      // Validate search query
      if (query.trim().isEmpty) {
        if (isClosed) return;
        emit(const GiftCardValidationError(
          message: 'Search query cannot be empty',
          field: 'query',
        ));
        return;
      }

      if (isClosed) return;
      emit(GiftCardBrandsLoading());

      final result = await _repository.searchGiftCardBrands(query);
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Searching brands',
        )),
        (brands) {
          if (brands.isEmpty) {
            emit(const GiftCardBrandsEmpty());
          } else {
            emit(GiftCardBrandsSearched(brands, query));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Searching brands',
      ));
    }
  }

  Future<void> purchaseGiftCard({
    required String brandId,
    required double amount,
    required String currency,
    required GiftCardBrand brand,
    required double userBalance,
    String? recipientEmail,
    String? recipientName,
    String? message,
  }) async {
    try {
      // Validate purchase request before processing
      final validation = GiftCardValidation.validatePurchaseRequest(
        amount: amount,
        brand: brand,
        currency: currency,
        userBalance: userBalance,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: message,
      );

      // If validation fails, emit error immediately
      if (validation.isLeft()) {
        if (isClosed) return;
        final error = validation.fold(
          (l) => l,
          (r) => const GeneralValidationError('Validation failed'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      // Step 1: Initializing (10%)
      if (isClosed) return;
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Initializing purchase...',
        progress: 0.1,
      ));
      await Future.delayed(const Duration(milliseconds: 500));
      if (isClosed) return;

      // Step 2: Validating payment (30%)
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Validating payment method...',
        progress: 0.3,
      ));
      await Future.delayed(const Duration(milliseconds: 800));
      if (isClosed) return;

      // Step 3: Processing purchase (60%)
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Generating gift card...',
        progress: 0.6,
      ));

      // Make the actual purchase
      final result = await _repository.purchaseGiftCard(
        brandId: brandId,
        amount: amount,
        currency: currency,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: message,
      );
      if (isClosed) return;

      result.fold(
        (failure) {
          // Handle specific error cases
          if (failure.message.contains('Insufficient funds')) {
            // Extract amounts from error if possible, or use defaults
            emit(GiftCardInsufficientFunds(
              required: amount,
              available: 0.0, // Would need to get actual balance
              brandName: 'Gift Card',
            ));
          } else if (failure.message.contains('not found')) {
            emit(GiftCardNotFound(
              identifier: brandId,
              type: 'brand',
            ));
          } else if (failure.message.contains('sold out')) {
            emit(GiftCardSoldOut(
              brandId: brandId,
              brandName: 'Gift Card',
            ));
          } else {
            emit(GiftCardPurchaseError(failure.message));
          }
        },
        (giftCard) async {
          // Step 4: Finalizing (90%)
          if (isClosed) return;
          emit(GiftCardPurchaseProcessing(
            brandId: brandId,
            amount: amount,
            currentStep: 'Finalizing purchase...',
            progress: 0.9,
          ));
          await Future.delayed(const Duration(milliseconds: 500));
          if (isClosed) return;

          // Complete
          emit(GiftCardPurchaseCompleted(
            giftCard: giftCard,
            receiptUrl: null,
            transactionId: giftCard.transactionId,
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardPurchaseError(e.toString()));
    }
  }

  /// Purchase gift card with verification token (for PIN-validated transactions)
  Future<void> purchaseGiftCardWithToken({
    required String brandId,
    required double amount,
    required String currency,
    required GiftCardBrand brand,
    required double userBalance,
    String? recipientEmail,
    String? recipientName,
    String? message,
    required String transactionId,
    required String verificationToken,
  }) async {
    try {
      // Validate purchase request before processing
      final validation = GiftCardValidation.validatePurchaseRequest(
        amount: amount,
        brand: brand,
        currency: currency,
        userBalance: userBalance,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: message,
      );

      // If validation fails, emit error immediately
      if (validation.isLeft()) {
        if (isClosed) return;
        final error = validation.fold(
          (l) => l,
          (r) => const GeneralValidationError('Validation failed'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      // Step 1: Initializing (10%)
      if (isClosed) return;
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Initializing purchase...',
        progress: 0.1,
      ));
      await Future.delayed(const Duration(milliseconds: 500));
      if (isClosed) return;

      // Step 2: Validating payment (30%)
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Validating payment method...',
        progress: 0.3,
      ));
      await Future.delayed(const Duration(milliseconds: 800));
      if (isClosed) return;

      // Step 3: Processing purchase (60%)
      emit(GiftCardPurchaseProcessing(
        brandId: brandId,
        amount: amount,
        currentStep: 'Generating gift card...',
        progress: 0.6,
      ));

      // Make the actual purchase with verification token
      final result = await _repository.purchaseGiftCard(
        brandId: brandId,
        amount: amount,
        currency: currency,
        recipientEmail: recipientEmail,
        recipientName: recipientName,
        message: message,
        // Note: transactionId and verificationToken are handled separately by the repository
      );
      if (isClosed) return;

      result.fold(
        (failure) {
          // Handle specific error cases
          if (failure.message.contains('Insufficient funds')) {
            emit(GiftCardInsufficientFunds(
              required: amount,
              available: 0.0, // Would need to get actual balance
              brandName: 'Gift Card',
            ));
          } else if (failure.message.contains('not found')) {
            emit(GiftCardNotFound(
              identifier: brandId,
              type: 'brand',
            ));
          } else if (failure.message.contains('sold out')) {
            emit(GiftCardSoldOut(
              brandId: brandId,
              brandName: 'Gift Card',
            ));
          } else {
            emit(GiftCardPurchaseError(failure.message));
          }
        },
        (giftCard) async {
          // Step 4: Finalizing (90%)
          if (isClosed) return;
          emit(GiftCardPurchaseProcessing(
            brandId: brandId,
            amount: amount,
            currentStep: 'Finalizing purchase...',
            progress: 0.9,
          ));
          await Future.delayed(const Duration(milliseconds: 500));
          if (isClosed) return;

          // Complete
          emit(GiftCardPurchaseCompleted(
            giftCard: giftCard,
            receiptUrl: null,
            transactionId: giftCard.transactionId,
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardPurchaseError(e.toString()));
    }
  }

  Future<void> redeemGiftCard(
    String giftCardId,
    String code, {
    String? pin,
  }) async {
    try {
      // Validate code format first
      final codeValidation = GiftCardValidation.validateGiftCardCode(code);
      if (codeValidation.isLeft()) {
        if (isClosed) return;
        final error = codeValidation.fold(
          (l) => l,
          (r) => const CodeValidationError('Invalid code'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      // Validate PIN if provided
      if (pin != null && pin.isNotEmpty) {
        final pinValidation = GiftCardValidation.validatePin(pin);
        if (pinValidation.isLeft()) {
          if (isClosed) return;
          final error = pinValidation.fold(
            (l) => l,
            (r) => const CodeValidationError('Invalid PIN'),
          );
          emit(GiftCardValidationError(
            message: GiftCardValidation.getErrorMessage(error),
            field: error.field ?? 'unknown',
          ));
          return;
        }
      }

      if (isClosed) return;
      emit(GiftCardRedeeming());

      // In production, this would call the repository
      // For now, simulate redemption
      await Future.delayed(const Duration(seconds: 2));
      if (isClosed) return;

      final giftCard = GiftCard(
        id: giftCardId,
        brandId: '1',
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: 95.0,
        currency: 'USD',
        status: GiftCardStatus.used,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card',
        termsAndConditions: 'Terms and conditions apply',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
        code: code,
        pin: pin,
        isRedeemed: true,
        availableDenominations: ['25', '50', '100'],
      );

      // Validate the complete redemption request
      final redemptionValidation =
          GiftCardValidation.validateRedemptionRequest(
        giftCard: giftCard,
        code: code,
        pin: pin,
      );

      if (redemptionValidation.isLeft()) {
        if (isClosed) return;
        final error = redemptionValidation.fold(
          (l) => l,
          (r) => const GeneralValidationError('Redemption validation failed'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      emit(GiftCardRedeemed(giftCard));
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardRedeemError(e.toString()));
    }
  }

  void resetState() {
    if (isClosed) return;
    emit(GiftCardInitial());
  }

  Future<void> loadMyGiftCards() async {
    try {
      if (isClosed) return;
      emit(GiftCardLoading());

      final result = await _repository.getUserGiftCards();
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Loading your gift cards',
        )),
        (giftCards) {
          if (giftCards.isEmpty) {
            emit(const UserGiftCardsEmpty());
          } else {
            emit(MyGiftCardsLoaded(giftCards));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading your gift cards',
      ));
    }
  }

  Future<void> sellGiftCardToContact({
    required String giftCardId,
    required String contactName,
    required String contactEmail,
    required double price,
  }) async {
    try {
      // Validate recipient email
      final emailValidation = GiftCardValidation.validateEmail(contactEmail);
      if (emailValidation.isLeft()) {
        if (isClosed) return;
        final error = emailValidation.fold(
          (l) => l,
          (r) => const EmailValidationError('Invalid email'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      // Validate recipient name
      final nameValidation = GiftCardValidation.validateRecipientName(contactName);
      if (nameValidation.isLeft()) {
        if (isClosed) return;
        final error = nameValidation.fold(
          (l) => l,
          (r) => const GeneralValidationError('Invalid name'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      // Validate selling price (must be positive and reasonable)
      if (price <= 0) {
        if (isClosed) return;
        emit(const GiftCardValidationError(
          message: 'Selling price must be greater than zero',
          field: 'price',
        ));
        return;
      }

      if (isClosed) return;
      emit(GiftCardSelling());

      // Simulate selling gift card - in production, call repository
      await Future.delayed(const Duration(seconds: 2));
      if (isClosed) return;
      final giftCard = GiftCard(
        id: giftCardId,
        brandId: '1',
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: 95.0,
        currency: 'USD',
        status: GiftCardStatus.used,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card',
        termsAndConditions: 'Terms and conditions apply',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
        recipientEmail: contactEmail,
        recipientName: contactName,
        isRedeemed: false,
        availableDenominations: ['25', '50', '100'],
      );
      emit(GiftCardSold(giftCard));
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardSellError(e.toString()));
    }
  }

  Future<void> sendGiftCardToContact({
    required String giftCardId,
    required String contactName,
    required String contactEmail,
    String? message,
  }) async {
    try {
      // Validate recipient email
      final emailValidation = GiftCardValidation.validateEmail(contactEmail);
      if (emailValidation.isLeft()) {
        if (isClosed) return;
        final error = emailValidation.fold(
          (l) => l,
          (r) => const EmailValidationError('Invalid email'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      // Validate recipient name
      final nameValidation = GiftCardValidation.validateRecipientName(contactName);
      if (nameValidation.isLeft()) {
        if (isClosed) return;
        final error = nameValidation.fold(
          (l) => l,
          (r) => const GeneralValidationError('Invalid name'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      // Validate message if provided
      if (message != null && message.isNotEmpty) {
        final messageValidation = GiftCardValidation.validateMessage(message);
        if (messageValidation.isLeft()) {
          if (isClosed) return;
          final error = messageValidation.fold(
            (l) => l,
            (r) => const GeneralValidationError('Invalid message'),
          );
          emit(GiftCardValidationError(
            message: GiftCardValidation.getErrorMessage(error),
            field: error.field ?? 'unknown',
          ));
          return;
        }
      }

      if (isClosed) return;
      emit(GiftCardSending());

      // Simulate sending gift card - in production, call repository
      await Future.delayed(const Duration(seconds: 2));
      if (isClosed) return;

      final giftCard = GiftCard(
        id: giftCardId,
        brandId: '1',
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: 95.0,
        currency: 'USD',
        status: GiftCardStatus.active,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card',
        termsAndConditions: 'Terms and conditions apply',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        purchaseDate: DateTime.now(),
        recipientEmail: contactEmail,
        recipientName: contactName,
        message: message,
        isRedeemed: false,
        availableDenominations: ['25', '50', '100'],
      );

      emit(GiftCardSent(giftCard));
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardSendError(e.toString()));
    }
  }

  Future<void> validateGiftCardCode(String code) async {
    try {
      if (isClosed) return;
      emit(GiftCardLoading());

      // Use validation layer for code format validation
      final codeValidation = GiftCardValidation.validateGiftCardCode(code);

      if (codeValidation.isLeft()) {
        if (isClosed) return;
        final error = codeValidation.fold(
          (l) => l,
          (r) => const CodeValidationError('Invalid code'),
        );
        emit(GiftCardValidationError(
          message: GiftCardValidation.getErrorMessage(error),
          field: error.field ?? 'unknown',
        ));
        return;
      }

      // Simulate server-side code validation
      await Future.delayed(const Duration(seconds: 1));
      if (isClosed) return;

      // In production, this would call an API to verify if the code exists
      // and is valid in the system
      final isValid = true; // Mock result

      emit(GiftCardCodeValidated(isValid));
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Validating gift card code',
      ));
    }
  }

  Future<void> checkGiftCardBalance(String giftCardId) async {
    try {
      // Validate gift card ID format
      if (giftCardId.trim().isEmpty) {
        if (isClosed) return;
        emit(const GiftCardValidationError(
          message: 'Gift card ID cannot be empty',
          field: 'giftCardId',
        ));
        return;
      }

      if (isClosed) return;
      emit(GiftCardLoading());

      // Simulate balance check - in production, call repository
      await Future.delayed(const Duration(seconds: 1));
      if (isClosed) return;

      // Mock balance - in real app, this would fetch from API
      final balance = 75.50; // Example remaining balance

      emit(GiftCardBalanceLoaded(balance, giftCardId));
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Checking gift card balance',
      ));
    }
  }

  Future<void> loadGiftCardTransactions(String giftCardId) async {
    try {
      // Validate gift card ID
      if (giftCardId.trim().isEmpty) {
        if (isClosed) return;
        emit(const GiftCardValidationError(
          message: 'Gift card ID cannot be empty',
          field: 'giftCardId',
        ));
        return;
      }

      if (isClosed) return;
      emit(GiftCardLoading());

      final result = await _repository.getGiftCardTransactions();
      if (isClosed) return;

      result.fold(
        (failure) => emit(GiftCardNetworkError(
          message: failure.message,
          canRetry: true,
          operation: 'Loading transactions',
        )),
        (transactions) {
          if (transactions.isEmpty) {
            emit(const TransactionsEmpty());
          } else {
            emit(GiftCardTransactionsLoaded(transactions));
          }
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardNetworkError(
        message: e.toString(),
        canRetry: true,
        operation: 'Loading transactions',
      ));
    }
  }

  Future<void> quickSellGiftCard({
    required String giftCardId,
    required double askingPrice,
  }) async {
    try {
      // Validate asking price
      if (askingPrice <= 0) {
        if (isClosed) return;
        emit(const GiftCardValidationError(
          message: 'Asking price must be greater than zero',
          field: 'askingPrice',
        ));
        return;
      }

      // In production, we would fetch the actual gift card to validate
      // that asking price is reasonable (e.g., not > original amount)
      // For now, we'll add a simple upper limit check
      if (askingPrice > 10000) {
        if (isClosed) return;
        emit(const GiftCardValidationError(
          message: 'Asking price is unreasonably high. Please contact support.',
          field: 'askingPrice',
        ));
        return;
      }

      if (isClosed) return;
      emit(GiftCardSelling());

      // Simulate quick sell - in production, call repository
      await Future.delayed(const Duration(seconds: 2));
      if (isClosed) return;
      final giftCard = GiftCard(
        id: giftCardId,
        brandId: '1',
        brandName: 'Amazon',
        logoUrl: 'https://example.com/amazon-logo.png',
        amount: 100.0,
        discountPercentage: 5.0,
        finalPrice: askingPrice,
        currency: 'USD',
        status: GiftCardStatus.pending,
        type: GiftCardType.digital,
        category: GiftCardCategory.shopping,
        description: 'Amazon Gift Card - Quick Sell',
        termsAndConditions: 'Terms and conditions apply',
        expiryDate: DateTime.now().add(const Duration(days: 365)),
        purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
        isRedeemed: false,
        availableDenominations: ['25', '50', '100'],
      );
      emit(GiftCardSold(giftCard));
    } catch (e) {
      if (isClosed) return;
      emit(GiftCardSellError(e.toString()));
    }
  }
} 