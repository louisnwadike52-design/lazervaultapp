import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/domain/usecases/create_virtual_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/create_disposable_card_usecase.dart';
import 'package:lazervault/src/features/cards/domain/usecases/get_user_cards_usecase.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_state.dart';

/// Card Cubit for managing card state
class CardCubit extends Cubit<CardState> {
  final CreateVirtualCardUseCase createVirtualCardUseCase;
  final CreateDisposableCardUseCase createDisposableCardUseCase;
  final GetUserCardsUseCase getUserCardsUseCase;

  CardCubit({
    required this.createVirtualCardUseCase,
    required this.createDisposableCardUseCase,
    required this.getUserCardsUseCase,
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

  /// Calculate card statistics
  Map<String, int> _calculateStats(List<Card> cards) {
    return {
      'total': cards.length,
      'active': cards.where((c) => c.isActive).length,
      'virtual': cards.where((c) => c.type == CardType.virtual).length,
      'disposable': cards.where((c) => c.type == CardType.disposable).length,
    };
  }

  /// Reset state to initial
  void reset() {
    if (isClosed) return;
    emit(const CardInitial());
  }
}
