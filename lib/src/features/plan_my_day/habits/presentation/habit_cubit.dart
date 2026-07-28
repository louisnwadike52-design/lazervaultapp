import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/src/features/plan_my_day/habits/data/habit_repository.dart';
import 'package:lazervault/src/features/plan_my_day/habits/domain/habit.dart';

sealed class HabitState {}

class HabitInitial extends HabitState {}

class HabitLoading extends HabitState {}

class HabitsLoaded extends HabitState {
  final List<Habit> habits;
  HabitsLoaded(this.habits);
}

class HabitError extends HabitState {
  final String message;
  HabitError(this.message);
}

class HabitCubit extends Cubit<HabitState> {
  final HabitRepository _repository;
  HabitCubit(this._repository) : super(HabitInitial());

  Future<void> loadHabits() async {
    emit(HabitLoading());
    try {
      emit(HabitsLoaded(await _repository.getHabits()));
    } catch (e) {
      if (!isClosed) emit(HabitError(_msg(e)));
    }
  }

  Future<void> saveHabit({
    String? id,
    required String title,
    String? description,
    String frequency = 'daily',
    int targetStreakDays = 0,
  }) async {
    try {
      final habit = Habit(
        id: id ?? '',
        userId: '',
        title: title,
        description: description,
        frequency: frequency,
        targetStreakDays: targetStreakDays,
      );
      if (id != null && id.isNotEmpty) {
        await _repository.updateHabit(id, habit);
      } else {
        await _repository.createHabit(habit);
      }
      await loadHabits();
    } catch (e) {
      if (!isClosed) emit(HabitError(_msg(e)));
    }
  }

  Future<void> logToday(String id) async {
    try {
      await _repository.logCompletion(id);
      await loadHabits();
    } catch (e) {
      if (!isClosed) emit(HabitError(_msg(e)));
    }
  }

  Future<void> deleteHabit(String id) async {
    try {
      await _repository.deleteHabit(id);
      await loadHabits();
    } catch (e) {
      if (!isClosed) emit(HabitError(_msg(e)));
    }
  }

  String _msg(Object e) => e.toString().replaceFirst('Exception: ', '');
}
