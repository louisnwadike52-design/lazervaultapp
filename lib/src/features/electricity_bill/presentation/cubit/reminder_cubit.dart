import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/reminder_entity.dart';
import '../../domain/repositories/electricity_bill_repository.dart';
import 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  final ElectricityBillRepository repository;

  ReminderCubit({required this.repository}) : super(ReminderInitial());

  Future<void> createReminder({
    required String title,
    required String description,
    required DateTime reminderDate,
    String? beneficiaryId,
    double? amount,
    bool isRecurring = false,
    ReminderRecurrenceType? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(ReminderCreating());

    final result = await repository.createReminder(
      title: title,
      description: description,
      reminderDate: reminderDate,
      beneficiaryId: beneficiaryId,
      amount: amount,
      isRecurring: isRecurring,
      recurrenceType: recurrenceType,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (reminder) => emit(ReminderCreated(reminder: reminder)),
    );
  }

  Future<void> getReminders() async {
    if (isClosed) return;
    emit(ReminderLoading());

    final result = await repository.getReminders();

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (reminders) => emit(RemindersLoaded(reminders: reminders)),
    );
  }


  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? reminderDate,
    double? amount,
    bool? isRecurring,
    ReminderRecurrenceType? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(ReminderUpdating());

    final result = await repository.updateReminder(
      reminderId: reminderId,
      title: title,
      description: description,
      reminderDate: reminderDate,
      amount: amount,
      isRecurring: isRecurring,
      recurrenceType: recurrenceType,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (reminder) => emit(ReminderUpdated(reminder: reminder)),
    );
  }

  Future<void> markReminderComplete({required String reminderId}) async {
    if (isClosed) return;
    emit(ReminderCompleting());

    final result = await repository.markReminderComplete(reminderId: reminderId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (_) => emit(ReminderCompleted()),
    );
  }

  Future<void> deleteReminder({required String reminderId}) async {
    if (isClosed) return;
    emit(ReminderDeleting());

    final result = await repository.deleteReminder(reminderId: reminderId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(ReminderError(message: failure.message)),
      (_) => emit(ReminderDeleted()),
    );
  }

  void reset() {
    if (isClosed) return;
    emit(ReminderInitial());
  }
}
