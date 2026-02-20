import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/usecases/create_virtual_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/create_disposable_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/get_user_cards_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/get_card_details_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/freeze_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/unfreeze_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/cancel_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/update_card_nickname_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/update_card_spending_limit_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/set_default_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/request_physical_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/set_card_pin_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/reveal_card_pin_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/reveal_card_details_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/fund_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/withdraw_from_card_usecase.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_state.dart';

/// Card Cubit for managing card state
class CardCubit extends Cubit<CardState> {
  final CreateVirtualCardUseCase createVirtualCardUseCase;
  final CreateDisposableCardUseCase createDisposableCardUseCase;
  final GetUserCardsUseCase getUserCardsUseCase;
  final GetCardDetailsUseCase getCardDetailsUseCase;
  final FreezeCardUseCase freezeCardUseCase;
  final UnfreezeCardUseCase unfreezeCardUseCase;
  final CancelCardUseCase cancelCardUseCase;
  final UpdateCardNicknameUseCase updateCardNicknameUseCase;
  final UpdateCardSpendingLimitUseCase updateCardSpendingLimitUseCase;
  final SetDefaultCardUseCase setDefaultCardUseCase;
  final RequestPhysicalCardUseCase requestPhysicalCardUseCase;
  final SetCardPINUseCase setCardPINUseCase;
  final RevealCardPINUseCase revealCardPINUseCase;
  final RevealCardDetailsUseCase revealCardDetailsUseCase;
  final FundCardUseCase fundCardUseCase;
  final WithdrawFromCardUseCase withdrawFromCardUseCase;

  CardCubit({
    required this.createVirtualCardUseCase,
    required this.createDisposableCardUseCase,
    required this.getUserCardsUseCase,
    required this.getCardDetailsUseCase,
    required this.freezeCardUseCase,
    required this.unfreezeCardUseCase,
    required this.cancelCardUseCase,
    required this.updateCardNicknameUseCase,
    required this.updateCardSpendingLimitUseCase,
    required this.setDefaultCardUseCase,
    required this.requestPhysicalCardUseCase,
    required this.setCardPINUseCase,
    required this.revealCardPINUseCase,
    required this.revealCardDetailsUseCase,
    required this.fundCardUseCase,
    required this.withdrawFromCardUseCase,
  }) : super(const CardInitial());

  /// Create a virtual card
  Future<void> createVirtualCard({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    String? currency,
    String? billingAddress,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardCreating(CardType.virtual));

      final result = await createVirtualCardUseCase(
        accountId: accountId,
        cardHolderName: cardHolderName,
        nickname: nickname,
        currency: currency,
        billingAddress: billingAddress,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardCreated(card: card)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to create virtual card: ${e.toString()}'));
    }
  }

  /// Create a disposable card
  Future<void> createDisposableCard({
    required int accountId,
    required String cardHolderName,
    String? nickname,
    double? spendingLimit,
    int? maxUsageCount,
    int? expiresInHours,
    String? currency,
    String? billingAddress,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardCreating(CardType.disposable));

      final result = await createDisposableCardUseCase(
        accountId: accountId,
        cardHolderName: cardHolderName,
        nickname: nickname,
        spendingLimit: spendingLimit,
        maxUsageCount: maxUsageCount,
        expiresInHours: expiresInHours,
        currency: currency,
        billingAddress: billingAddress,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardCreated(card: card)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to create disposable card: ${e.toString()}'));
    }
  }

  /// Get all user cards
  Future<void> getUserCards({
    CardType? typeFilter,
    CardStatus? statusFilter,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await getUserCardsUseCase(
        typeFilter: typeFilter,
        statusFilter: statusFilter,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (cards) {
          final stats = _calculateStats(cards);
          emit(CardsLoaded(
            cards: cards,
            totalCards: stats['total']!,
            activeCards: stats['active']!,
            virtualCards: stats['virtual']!,
            disposableCards: stats['disposable']!,
          ));
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to get user cards: ${e.toString()}'));
    }
  }

  /// Get card details
  Future<void> getCardDetails({
    required String cardUuid,
    bool includeFullDetails = false,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await getCardDetailsUseCase(
        cardUuid: cardUuid,
        includeFullDetails: includeFullDetails,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardDetailsLoaded(card)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to get card details: ${e.toString()}'));
    }
  }

  /// Freeze a card
  Future<void> freezeCard({
    required String cardUuid,
    String? reason,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await freezeCardUseCase(
        cardUuid: cardUuid,
        reason: reason,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardUpdated(card: card, message: 'Card frozen successfully')),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to freeze card: ${e.toString()}'));
    }
  }

  /// Unfreeze a card
  Future<void> unfreezeCard({required String cardUuid}) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await unfreezeCardUseCase(cardUuid: cardUuid);

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardUpdated(card: card, message: 'Card unfrozen successfully')),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to unfreeze card: ${e.toString()}'));
    }
  }

  /// Cancel a card
  Future<void> cancelCard({
    required String cardUuid,
    String? reason,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await cancelCardUseCase(
        cardUuid: cardUuid,
        reason: reason,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (_) => emit(const CardActionSuccess('Card cancelled successfully')),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to cancel card: ${e.toString()}'));
    }
  }

  /// Update card nickname
  Future<void> updateCardNickname({
    required String cardUuid,
    required String nickname,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await updateCardNicknameUseCase(
        cardUuid: cardUuid,
        nickname: nickname,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardUpdated(card: card, message: 'Nickname updated')),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to update nickname: ${e.toString()}'));
    }
  }

  /// Update card spending limit
  Future<void> updateCardSpendingLimit({
    required String cardUuid,
    required double newLimit,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await updateCardSpendingLimitUseCase(
        cardUuid: cardUuid,
        newLimit: newLimit,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardUpdated(card: card, message: 'Spending limit updated')),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to update spending limit: ${e.toString()}'));
    }
  }

  /// Set card as default
  Future<void> setDefaultCard({required String cardUuid}) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await setDefaultCardUseCase(cardUuid: cardUuid);

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardUpdated(card: card, message: 'Default card updated')),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to set default card: ${e.toString()}'));
    }
  }

  /// Request a physical card
  Future<void> requestPhysicalCard({
    required int accountId,
    String? nickname,
    String? currency,
    String? billingAddress,
    String? shippingAddress,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardCreating(CardType.permanent));

      final result = await requestPhysicalCardUseCase(
        accountId: accountId,
        nickname: nickname,
        currency: currency,
        billingAddress: billingAddress,
        shippingAddress: shippingAddress,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardCreated(
          card: card,
          message: 'Physical card requested successfully',
        )),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to request physical card: ${e.toString()}'));
    }
  }

  /// Set card PIN
  Future<void> setCardPIN({
    required String cardUuid,
    required String pin,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await setCardPINUseCase(
        cardUuid: cardUuid,
        pin: pin,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (_) => emit(const CardActionSuccess('Card PIN set successfully')),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to set card PIN: ${e.toString()}'));
    }
  }

  /// Reveal card PIN
  Future<void> revealCardPIN({required String cardUuid}) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await revealCardPINUseCase(cardUuid: cardUuid);

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (pin) => emit(CardPINRevealed(pin)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to reveal card PIN: ${e.toString()}'));
    }
  }

  /// Reveal full card details (number, CVV)
  Future<void> revealFullCardDetails({required String cardUuid}) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await revealCardDetailsUseCase(cardUuid: cardUuid);

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardDetailsRevealed(card)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to reveal card details: ${e.toString()}'));
    }
  }

  /// Fund a card
  Future<void> fundCard({
    required String cardUuid,
    required double amount,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await fundCardUseCase(
        cardUuid: cardUuid,
        amount: amount,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardFunded(card: card, amount: amount)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to fund card: ${e.toString()}'));
    }
  }

  /// Withdraw from card
  Future<void> withdrawFromCard({
    required String cardUuid,
    required double amount,
  }) async {
    try {
      if (isClosed) return;
      emit(const CardLoading());

      final result = await withdrawFromCardUseCase(
        cardUuid: cardUuid,
        amount: amount,
      );

      if (isClosed) return;
      result.fold(
        (failure) => emit(CardError(message: failure.message)),
        (card) => emit(CardWithdrawn(card: card, amount: amount)),
      );
    } catch (e) {
      if (isClosed) return;
      emit(CardError(message: 'Failed to withdraw from card: ${e.toString()}'));
    }
  }

  Map<String, int> _calculateStats(List<Card> cards) {
    return {
      'total': cards.length,
      'active': cards.where((c) => c.isActive).length,
      'virtual': cards.where((c) => c.type == CardType.virtual).length,
      'disposable': cards.where((c) => c.type == CardType.disposable).length,
    };
  }

  void reset() {
    if (isClosed) return;
    emit(const CardInitial());
  }
}
