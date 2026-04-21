import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';
import 'internet_reminder_state.dart';

/// Cubit for the internet-scoped reminders surface. Mirrors
/// `DataReminderCubit`. The backend timer worker
/// (`InternetReminderTimerWorker`) fires notifications at the exact
/// `reminder_date` — this cubit only renders state, it doesn't drive
/// the firing.
class InternetReminderCubit extends Cubit<InternetReminderState> {
  final InternetBeneficiaryRemoteDataSource datasource;

  InternetReminderCubit({required this.datasource})
      : super(InternetReminderInitial());

  Future<void> getReminders({String? status, bool includePast = false}) async {
    if (isClosed) return;
    emit(InternetReminderLoading());
    try {
      final list = await datasource.getReminders(
        status: status,
        includePast: includePast,
      );
      if (isClosed) return;
      emit(InternetRemindersLoaded(reminders: list));
    } catch (e) {
      if (isClosed) return;
      emit(InternetReminderError(message: _friendly(e)));
    }
  }

  Future<void> createReminder({
    required String title,
    required String description,
    required DateTime reminderDate,
    String? beneficiaryId,
    double? amount,
    String? packageId,
    String currency = 'NGN',
    bool isRecurring = false,
    String? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(InternetReminderCreating());
    try {
      final reminder = await datasource.createReminder(
        beneficiaryId: beneficiaryId ?? '',
        title: title,
        description: description,
        reminderDate: reminderDate.toUtc().toIso8601String(),
        amount: amount,
        packageId: packageId,
        currency: currency,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      if (isClosed) return;
      emit(InternetReminderCreated(reminder: reminder));
    } catch (e) {
      if (isClosed) return;
      emit(InternetReminderError(message: _friendly(e)));
    }
  }

  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? reminderDate,
    double? amount,
    String? packageId,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(InternetReminderUpdating());
    try {
      await datasource.updateReminder(
        reminderId: reminderId,
        title: title,
        description: description,
        reminderDate: reminderDate?.toUtc().toIso8601String(),
        amount: amount,
        packageId: packageId,
        currency: currency,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      if (isClosed) return;
      emit(const InternetReminderUpdated());
      await getReminders(includePast: true);
    } catch (e) {
      if (isClosed) return;
      emit(InternetReminderError(message: _friendly(e)));
    }
  }

  Future<void> markReminderComplete({required String reminderId}) async {
    if (isClosed) return;
    emit(InternetReminderCompleting());
    try {
      await datasource.markReminderComplete(reminderId);
      if (isClosed) return;
      emit(const InternetReminderCompleted());
    } catch (e) {
      if (isClosed) return;
      emit(InternetReminderError(message: _friendly(e)));
    }
  }

  Future<void> deleteReminder({required String reminderId}) async {
    if (isClosed) return;
    emit(InternetReminderDeleting());
    try {
      await datasource.deleteReminder(reminderId);
      if (isClosed) return;
      emit(const InternetReminderDeleted());
    } catch (e) {
      if (isClosed) return;
      emit(InternetReminderError(message: _friendly(e)));
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
