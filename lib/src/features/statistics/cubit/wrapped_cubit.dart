import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/wrapped_types_stub.dart';
import '../data/statistics_repository.dart';
import 'wrapped_state.dart';

/// Cubit for managing Financial Wrapped state
class WrappedCubit extends Cubit<WrappedState> {
  final StatisticsRepository repository;

  WrappedCubit({required this.repository}) : super(WrappedInitial());

  /// Load Financial Wrapped data
  /// TODO: Implement when proto types are available
  Future<void> loadWrapped({
    WrappedPeriod period = WrappedPeriod.WRAPPED_PERIOD_YEARLY,
    int? year,
    int? month,
  }) async {
    try {
      if (isClosed) return;
      emit(const WrappedLoading(loadingMessage: 'Generating your financial wrapped...'));

      // TODO: Uncomment when getFinancialWrapped is implemented
      // final wrapped = await repository.getFinancialWrapped(
      //   period: period,
      //   year: year ?? DateTime.now().year,
      //   month: month,
      // );

      // Return stub data for now
      final wrapped = FinancialWrapped();

      if (isClosed) return;
      emit(WrappedLoaded(wrapped: wrapped));
    } catch (e, stackTrace) {
      if (isClosed) return;
      emit(WrappedError(
        message: 'Failed to load financial wrapped: ${e.toString()}',
        stackTrace: stackTrace,
      ));
    }
  }

  /// Load yearly wrapped for a specific year
  Future<void> loadYearlyWrapped({int? year}) async {
    await loadWrapped(
      period: WrappedPeriod.WRAPPED_PERIOD_YEARLY,
      year: year,
    );
  }

  /// Load monthly wrapped for a specific month
  Future<void> loadMonthlyWrapped({
    required int year,
    required int month,
  }) async {
    await loadWrapped(
      period: WrappedPeriod.WRAPPED_PERIOD_MONTHLY,
      year: year,
      month: month,
    );
  }

  /// Navigate to the next card
  void nextCard() {
    if (state is WrappedLoaded) {
      final currentState = state as WrappedLoaded;
      if (!currentState.isLastCard && !currentState.isAnimating) {
        emit(currentState.copyWith(
          currentCardIndex: currentState.currentCardIndex + 1,
          isAnimating: true,
        ));
        // Reset animating flag after a short delay
        Future.delayed(const Duration(milliseconds: 300), () {
          if (!isClosed && state is WrappedLoaded) {
            emit((state as WrappedLoaded).copyWith(isAnimating: false));
          }
        });
      }
    }
  }

  /// Navigate to the previous card
  void previousCard() {
    if (state is WrappedLoaded) {
      final currentState = state as WrappedLoaded;
      if (!currentState.isFirstCard && !currentState.isAnimating) {
        emit(currentState.copyWith(
          currentCardIndex: currentState.currentCardIndex - 1,
          isAnimating: true,
        ));
        // Reset animating flag after a short delay
        Future.delayed(const Duration(milliseconds: 300), () {
          if (!isClosed && state is WrappedLoaded) {
            emit((state as WrappedLoaded).copyWith(isAnimating: false));
          }
        });
      }
    }
  }

  /// Jump to a specific card
  void goToCard(int index) {
    if (state is WrappedLoaded) {
      final currentState = state as WrappedLoaded;
      if (index >= 0 && index < currentState.totalCards && !currentState.isAnimating) {
        emit(currentState.copyWith(
          currentCardIndex: index,
          isAnimating: true,
        ));
        // Reset animating flag after a short delay
        Future.delayed(const Duration(milliseconds: 300), () {
          if (!isClosed && state is WrappedLoaded) {
            emit((state as WrappedLoaded).copyWith(isAnimating: false));
          }
        });
      }
    }
  }

  /// Reset to the first card
  void reset() {
    if (state is WrappedLoaded) {
      final currentState = state as WrappedLoaded;
      emit(currentState.copyWith(currentCardIndex: 0));
    }
  }

  /// Retry loading after an error
  Future<void> retry({
    WrappedPeriod period = WrappedPeriod.WRAPPED_PERIOD_YEARLY,
    int? year,
    int? month,
  }) async {
    await loadWrapped(period: period, year: year, month: month);
  }
}
