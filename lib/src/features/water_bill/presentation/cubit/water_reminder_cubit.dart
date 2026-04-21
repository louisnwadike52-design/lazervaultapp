import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/water_beneficiary_remote_datasource.dart';
import 'water_reminder_state.dart';

/// Cubit for water-bill-scoped reminders.
class WaterReminderCubit extends Cubit<WaterReminderState> {
  final WaterBeneficiaryRemoteDataSource datasource;

  WaterReminderCubit({required this.datasource})
      : super(WaterReminderInitial());

  Future<void> getReminders({String? status, bool includePast = false}) async {
    if (isClosed) return;
    emit(WaterReminderLoading());
    try {
      final list = await datasource.getReminders(
        status: status,
        includePast: includePast,
      );
      if (isClosed) return;
      emit(WaterRemindersLoaded(reminders: list));
    } catch (e) {
      if (isClosed) return;
      emit(WaterReminderError(message: _friendly(e)));
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
    emit(WaterReminderCreating());
    try {
      final reminder = await datasource.createReminder(
        beneficiaryId: beneficiaryId ?? '',
        title: title,
        description: description,
        reminderDate: reminderDate.toUtc().toIso8601String(),
        amount: amount,
        currency: currency,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      if (isClosed) return;
      emit(WaterReminderCreated(reminder: reminder));
    } catch (e) {
      if (isClosed) return;
      emit(WaterReminderError(message: _friendly(e)));
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
    emit(WaterReminderUpdating());
    try {
      await datasource.updateReminder(
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
      emit(const WaterReminderUpdated());
      await getReminders(includePast: true);
    } catch (e) {
      if (isClosed) return;
      emit(WaterReminderError(message: _friendly(e)));
    }
  }

  Future<void> markReminderComplete({required String reminderId}) async {
    if (isClosed) return;
    emit(WaterReminderCompleting());
    try {
      await datasource.markReminderComplete(reminderId);
      if (isClosed) return;
      emit(const WaterReminderCompleted());
    } catch (e) {
      if (isClosed) return;
      emit(WaterReminderError(message: _friendly(e)));
    }
  }

  Future<void> deleteReminder({required String reminderId}) async {
    if (isClosed) return;
    emit(WaterReminderDeleting());
    try {
      await datasource.deleteReminder(reminderId);
      if (isClosed) return;
      emit(const WaterReminderDeleted());
    } catch (e) {
      if (isClosed) return;
      emit(WaterReminderError(message: _friendly(e)));
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
