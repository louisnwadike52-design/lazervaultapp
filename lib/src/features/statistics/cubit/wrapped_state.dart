import 'package:equatable/equatable.dart';
import '../data/wrapped_types_stub.dart';

/// Base class for all wrapped states
abstract class WrappedState extends Equatable {
  const WrappedState();

  @override
  List<Object?> get props => [];
}

/// Initial state when wrapped feature is first loaded
class WrappedInitial extends WrappedState {}

/// Loading state while fetching wrapped data
class WrappedLoading extends WrappedState {
  final String? loadingMessage;

  const WrappedLoading({this.loadingMessage});

  @override
  List<Object?> get props => [loadingMessage];
}

/// Loaded state with all wrapped data
class WrappedLoaded extends WrappedState {
  final FinancialWrapped wrapped;
  final int currentCardIndex;
  final bool isAnimating;

  const WrappedLoaded({
    required this.wrapped,
    this.currentCardIndex = 0,
    this.isAnimating = false,
  });

  @override
  List<Object?> get props => [wrapped, currentCardIndex, isAnimating];

  /// Create a copy with updated fields
  WrappedLoaded copyWith({
    FinancialWrapped? wrapped,
    int? currentCardIndex,
    bool? isAnimating,
  }) {
    return WrappedLoaded(
      wrapped: wrapped ?? this.wrapped,
      currentCardIndex: currentCardIndex ?? this.currentCardIndex,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }

  /// Total number of cards in the wrapped experience
  int get totalCards => 8;

  /// Whether we're at the last card
  bool get isLastCard => currentCardIndex >= totalCards - 1;

  /// Whether we're at the first card
  bool get isFirstCard => currentCardIndex <= 0;

  /// Progress percentage (0.0 to 1.0)
  double get progress => (currentCardIndex + 1) / totalCards;
}

/// Error state with detailed error message
class WrappedError extends WrappedState {
  final String message;
  final String? errorCode;
  final StackTrace? stackTrace;

  const WrappedError({
    required this.message,
    this.errorCode,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, errorCode, stackTrace];
}
