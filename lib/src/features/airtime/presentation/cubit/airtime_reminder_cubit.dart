import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/airtime_repository.dart';
import 'airtime_reminder_state.dart';

/// Dedicated Cubit for the airtime-reminder screens (list + create).
///
/// The shared `AirtimeCubit` also owns a reminders flow, but it emits into
/// the large `AirtimeState` space which is cumbersome for a focused reminder
/// screen. This Cubit exposes a sealed, reminder-only state surface while
/// delegating all I/O to the existing `AirtimeRepository` (same paths as
/// `AirtimeCubit.loadReminders`, etc.).
class AirtimeReminderCubit extends Cubit<AirtimeReminderState> {
  final AirtimeRepository repository;

  AirtimeReminderCubit({required this.repository})
      : super(AirtimeReminderInitial());

  Future<void> getReminders({String? status, bool includePast = false}) async {
    if (isClosed) return;
    emit(AirtimeReminderLoading());
    try {
      final reminders = await repository.getAirtimeReminders(
        status: status,
        includePast: includePast,
      );
      if (isClosed) return;
      emit(AirtimeRemindersLoaded(reminders: reminders));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeReminderError(message: _friendly(e)));
    }
  }

  Future<void> createReminder({
    required String title,
    required String description,
    required DateTime reminderDate,
    String? beneficiaryId,
    double? amount,
    String currency = 'NGN',
    bool isRecurring = false,
    String? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(AirtimeReminderCreating());
    try {
      final reminder = await repository.createAirtimeReminder(
        beneficiaryId: beneficiaryId ?? '',
        title: title,
        description: description,
        // Backend expects UTC timestamp; Dart DateTime.toUtc() gives us the
        // right instant regardless of the user's local timezone offset.
        reminderDate: reminderDate.toUtc().toIso8601String(),
        amount: amount,
        currency: currency,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      if (isClosed) return;
      emit(AirtimeReminderCreated(reminder: reminder));
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeReminderError(message: _friendly(e)));
    }
  }

  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? reminderDate,
    double? amount,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(AirtimeReminderUpdating());
    try {
      await repository.updateAirtimeReminder(
        reminderId: reminderId,
        title: title,
        description: description,
        reminderDate: reminderDate?.toUtc().toIso8601String(),
        amount: amount,
        currency: currency,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      if (isClosed) return;
      // Re-fetch the list so the UI shows the newest state
      await getReminders();
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeReminderError(message: _friendly(e)));
    }
  }

  Future<void> markReminderComplete({required String reminderId}) async {
    if (isClosed) return;
    emit(AirtimeReminderCompleting());
    try {
      await repository.markReminderComplete(reminderId);
      if (isClosed) return;
      emit(const AirtimeReminderCompleted());
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeReminderError(message: _friendly(e)));
    }
  }

  Future<void> deleteReminder({required String reminderId}) async {
    if (isClosed) return;
    emit(AirtimeReminderDeleting());
    try {
      await repository.deleteAirtimeReminder(reminderId);
      if (isClosed) return;
      emit(const AirtimeReminderDeleted());
    } catch (e) {
      if (isClosed) return;
      emit(AirtimeReminderError(message: _friendly(e)));
    }
  }

  void reset() {
    if (isClosed) return;
    emit(AirtimeReminderInitial());
  }

  String _friendly(Object e) {
    final raw = e.toString();
    return raw.replaceFirst('Exception: ', '');
  }
}
