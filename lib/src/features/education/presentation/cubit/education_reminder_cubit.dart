import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/education_beneficiary_remote_datasource.dart';
import 'education_reminder_state.dart';

/// Cubit for education-scoped reminders (exam date reminders).
class EducationReminderCubit extends Cubit<EducationReminderState> {
  final EducationBeneficiaryRemoteDataSource datasource;

  EducationReminderCubit({required this.datasource})
      : super(EducationReminderInitial());

  Future<void> getReminders({String? status, bool includePast = false}) async {
    if (isClosed) return;
    emit(EducationReminderLoading());
    try {
      final list = await datasource.getReminders(
        status: status,
        includePast: includePast,
      );
      if (isClosed) return;
      emit(EducationRemindersLoaded(reminders: list));
    } catch (e) {
      if (isClosed) return;
      emit(EducationReminderError(message: _friendly(e)));
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
    emit(EducationReminderCreating());
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
      emit(EducationReminderCreated(reminder: reminder));
    } catch (e) {
      if (isClosed) return;
      emit(EducationReminderError(message: _friendly(e)));
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
    emit(EducationReminderUpdating());
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
      emit(const EducationReminderUpdated());
      await getReminders(includePast: true);
    } catch (e) {
      if (isClosed) return;
      emit(EducationReminderError(message: _friendly(e)));
    }
  }

  Future<void> markReminderComplete({required String reminderId}) async {
    if (isClosed) return;
    emit(EducationReminderCompleting());
    try {
      await datasource.markReminderComplete(reminderId);
      if (isClosed) return;
      emit(const EducationReminderCompleted());
    } catch (e) {
      if (isClosed) return;
      emit(EducationReminderError(message: _friendly(e)));
    }
  }

  Future<void> deleteReminder({required String reminderId}) async {
    if (isClosed) return;
    emit(EducationReminderDeleting());
    try {
      await datasource.deleteReminder(reminderId);
      if (isClosed) return;
      emit(const EducationReminderDeleted());
    } catch (e) {
      if (isClosed) return;
      emit(EducationReminderError(message: _friendly(e)));
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
