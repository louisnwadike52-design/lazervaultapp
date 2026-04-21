import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/data_beneficiary_remote_datasource.dart';
import 'data_reminder_state.dart';

/// Cubit for the data-scoped reminders surface. Mirrors
/// `AirtimeReminderCubit`. The backend timer worker
/// (`DataReminderTimerWorker`) fires notifications at the exact
/// `reminder_date` — this cubit only renders state, it doesn't drive
/// the firing.
class DataReminderCubit extends Cubit<DataReminderState> {
  final DataBeneficiaryRemoteDataSource datasource;

  DataReminderCubit({required this.datasource})
      : super(DataReminderInitial());

  Future<void> getReminders({String? status, bool includePast = false}) async {
    if (isClosed) return;
    emit(DataReminderLoading());
    try {
      final list = await datasource.getReminders(
        status: status,
        includePast: includePast,
      );
      if (isClosed) return;
      emit(DataRemindersLoaded(reminders: list));
    } catch (e) {
      if (isClosed) return;
      emit(DataReminderError(message: _friendly(e)));
    }
  }

  Future<void> createReminder({
    required String title,
    required String description,
    required DateTime reminderDate,
    String? beneficiaryId,
    double? amount,
    String? variationId,
    String currency = 'NGN',
    bool isRecurring = false,
    String? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(DataReminderCreating());
    try {
      final reminder = await datasource.createReminder(
        beneficiaryId: beneficiaryId ?? '',
        title: title,
        description: description,
        reminderDate: reminderDate.toUtc().toIso8601String(),
        amount: amount,
        variationId: variationId,
        currency: currency,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      if (isClosed) return;
      emit(DataReminderCreated(reminder: reminder));
    } catch (e) {
      if (isClosed) return;
      emit(DataReminderError(message: _friendly(e)));
    }
  }

  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? reminderDate,
    double? amount,
    String? variationId,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(DataReminderUpdating());
    try {
      await datasource.updateReminder(
        reminderId: reminderId,
        title: title,
        description: description,
        reminderDate: reminderDate?.toUtc().toIso8601String(),
        amount: amount,
        variationId: variationId,
        currency: currency,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      if (isClosed) return;
      emit(const DataReminderUpdated());
      await getReminders(includePast: true);
    } catch (e) {
      if (isClosed) return;
      emit(DataReminderError(message: _friendly(e)));
    }
  }

  Future<void> markReminderComplete({required String reminderId}) async {
    if (isClosed) return;
    emit(DataReminderCompleting());
    try {
      await datasource.markReminderComplete(reminderId);
      if (isClosed) return;
      emit(const DataReminderCompleted());
    } catch (e) {
      if (isClosed) return;
      emit(DataReminderError(message: _friendly(e)));
    }
  }

  Future<void> deleteReminder({required String reminderId}) async {
    if (isClosed) return;
    emit(DataReminderDeleting());
    try {
      await datasource.deleteReminder(reminderId);
      if (isClosed) return;
      emit(const DataReminderDeleted());
    } catch (e) {
      if (isClosed) return;
      emit(DataReminderError(message: _friendly(e)));
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
