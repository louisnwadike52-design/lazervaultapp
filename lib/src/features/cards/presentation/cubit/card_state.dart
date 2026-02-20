import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';

/// Card state base class
abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CardInitial extends CardState {
  const CardInitial();
}

/// Loading state (for fetching cards)
class CardLoading extends CardState {
  const CardLoading();
}

/// Cards loaded state
class CardsLoaded extends CardState {
  final List<Card> cards;
  final int totalCards;
  final int activeCards;
  final int virtualCards;
  final int disposableCards;

  const CardsLoaded({
    required this.cards,
    this.totalCards = 0,
    this.activeCards = 0,
    this.virtualCards = 0,
    this.disposableCards = 0,
  });

  @override
  List<Object?> get props => [
        cards,
        totalCards,
        activeCards,
        virtualCards,
        disposableCards,
      ];
}

/// Creating card state (during API call)
class CardCreating extends CardState {
  final CardType cardType;

  const CardCreating(this.cardType);

  @override
  List<Object?> get props => [cardType];
}

/// Card created successfully state
class CardCreated extends CardState {
  final Card card;
  final String message;

  const CardCreated({
    required this.card,
    this.message = 'Card created successfully',
  });

  @override
  List<Object?> get props => [card, message];
}

/// Card details loaded state
class CardDetailsLoaded extends CardState {
  final Card card;

  const CardDetailsLoaded(this.card);

  @override
  List<Object?> get props => [card];
}

/// Card updated state (after freeze, unfreeze, etc.)
class CardUpdated extends CardState {
  final Card card;
  final String message;

  const CardUpdated({
    required this.card,
    required this.message,
  });

  @override
  List<Object?> get props => [card, message];
}

/// Card action success state (for actions that don't return a card)
class CardActionSuccess extends CardState {
  final String message;

  const CardActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Card PIN revealed state
class CardPINRevealed extends CardState {
  final String pin;

  const CardPINRevealed(this.pin);

  @override
  List<Object?> get props => [pin];
}

/// Card full details revealed state (includes card number, CVV)
class CardDetailsRevealed extends CardState {
  final Card card;

  const CardDetailsRevealed(this.card);

  @override
  List<Object?> get props => [card];
}

/// Card funded state
class CardFunded extends CardState {
  final Card card;
  final double amount;

  const CardFunded({required this.card, required this.amount});

  @override
  List<Object?> get props => [card, amount];
}

/// Card withdrawal state
class CardWithdrawn extends CardState {
  final Card card;
  final double amount;

  const CardWithdrawn({required this.card, required this.amount});

  @override
  List<Object?> get props => [card, amount];
}

/// Error state
class CardError extends CardState {
  final String message;
  final String? errorCode;

  const CardError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}
