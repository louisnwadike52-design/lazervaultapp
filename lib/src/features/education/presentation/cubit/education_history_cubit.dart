import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../../domain/entities/education_history_entity.dart';
import '../../domain/repositories/education_repository.dart';

// States
sealed class EducationHistoryState {}

class EducationHistoryInitial extends EducationHistoryState {}

class EducationHistoryLoading extends EducationHistoryState {}

class EducationHistoryLoaded extends EducationHistoryState {
  final List<EducationHistoryEntity> history;
  final bool hasMore;

  EducationHistoryLoaded({
    required this.history,
    this.hasMore = true,
  });
}

class EducationHistoryError extends EducationHistoryState {
  final String message;

  EducationHistoryError(this.message);
}

// Cubit
class EducationHistoryCubit extends Cubit<EducationHistoryState> {
  final EducationRepository repository;

  EducationHistoryCubit(this.repository) : super(EducationHistoryInitial());

  int _currentOffset = 0;
  static const _limit = 20;

  Future<void> loadHistory({bool refresh = false}) async {
    if (refresh) {
      _currentOffset = 0;
    }

    if (state is EducationHistoryLoading) return;

    emit(EducationHistoryLoading());

    final result = await repository.getHistory(
      limit: _limit,
      offset: _currentOffset,
    );

    result.fold(
      (failure) => emit(EducationHistoryError(failure.message)),
      (history) {
        _currentOffset += history.length;

        if (refresh) {
          emit(EducationHistoryLoaded(
            history: history,
            hasMore: history.length >= _limit,
          ));
        } else if (state is EducationHistoryLoaded) {
          final currentState = state as EducationHistoryLoaded;
          emit(EducationHistoryLoaded(
            history: [...currentState.history, ...history],
            hasMore: history.length >= _limit,
          ));
        } else {
          emit(EducationHistoryLoaded(
            history: history,
            hasMore: history.length >= _limit,
          ));
        }
      },
    );
  }

  Future<void> loadMore() async {
    if (state is! EducationHistoryLoaded) return;

    final currentState = state as EducationHistoryLoaded;
    if (!currentState.hasMore) return;

    final result = await repository.getHistory(
      limit: _limit,
      offset: _currentOffset,
    );

    result.fold(
      (failure) => emit(EducationHistoryError(failure.message)),
      (history) {
        _currentOffset += history.length;
        emit(EducationHistoryLoaded(
          history: [...currentState.history, ...history],
          hasMore: history.length >= _limit,
        ));
      },
    );
  }

  Future<EducationHistoryEntity?> getPurchaseById(String id) async {
    final result = await repository.getPurchaseById(id);

    EducationHistoryEntity? purchase;
    result.fold(
      (failure) => null,
      (entity) => purchase = entity,
    );

    return purchase;
  }
}
