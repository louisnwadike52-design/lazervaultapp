import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/cable_tv_beneficiary_remote_datasource.dart';
import 'cable_tv_reminder_state.dart';

/// Cubit for cable-TV-scoped reminders.
class CableTVReminderCubit extends Cubit<CableTVReminderState> {
  final CableTVBeneficiaryRemoteDataSource datasource;

  CableTVReminderCubit({required this.datasource})
      : super(CableTVReminderInitial());

  Future<void> getReminders({String? status, bool includePast = false}) async {
    if (isClosed) return;
    emit(CableTVReminderLoading());
    try {
      final list = await datasource.getReminders(
        status: status,
        includePast: includePast,
      );
      if (isClosed) return;
      emit(CableTVRemindersLoaded(reminders: list));
    } catch (e) {
      if (isClosed) return;
      emit(CableTVReminderError(message: _friendly(e)));
    }
  }

  Future<void> createReminder({
    required String title,
    required String description,
    required DateTime reminderDate,
    String? beneficiaryId,
    double? amount,
    String? variationCode,
    String currency = 'NGN',
    bool isRecurring = false,
    String? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(CableTVReminderCreating());
    try {
      final reminder = await datasource.createReminder(
        beneficiaryId: beneficiaryId ?? '',
        title: title,
        description: description,
        reminderDate: reminderDate.toUtc().toIso8601String(),
        amount: amount,
        variationCode: variationCode,
        currency: currency,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      if (isClosed) return;
      emit(CableTVReminderCreated(reminder: reminder));
    } catch (e) {
      if (isClosed) return;
      emit(CableTVReminderError(message: _friendly(e)));
    }
  }

  Future<void> updateReminder({
    required String reminderId,
    String? title,
    String? description,
    DateTime? reminderDate,
    double? amount,
    String? variationCode,
    String? currency,
    bool? isRecurring,
    String? recurrenceType,
  }) async {
    if (isClosed) return;
    emit(CableTVReminderUpdating());
    try {
      await datasource.updateReminder(
        reminderId: reminderId,
        title: title,
        description: description,
        reminderDate: reminderDate?.toUtc().toIso8601String(),
        amount: amount,
        variationCode: variationCode,
        currency: currency,
        isRecurring: isRecurring,
        recurrenceType: recurrenceType,
      );
      if (isClosed) return;
      emit(const CableTVReminderUpdated());
      await getReminders(includePast: true);
    } catch (e) {
      if (isClosed) return;
      emit(CableTVReminderError(message: _friendly(e)));
    }
  }

  Future<void> markReminderComplete({required String reminderId}) async {
    if (isClosed) return;
    emit(CableTVReminderCompleting());
    try {
      await datasource.markReminderComplete(reminderId);
      if (isClosed) return;
      emit(const CableTVReminderCompleted());
    } catch (e) {
      if (isClosed) return;
      emit(CableTVReminderError(message: _friendly(e)));
    }
  }

  Future<void> deleteReminder({required String reminderId}) async {
    if (isClosed) return;
    emit(CableTVReminderDeleting());
    try {
      await datasource.deleteReminder(reminderId);
      if (isClosed) return;
      emit(const CableTVReminderDeleted());
    } catch (e) {
      if (isClosed) return;
      emit(CableTVReminderError(message: _friendly(e)));
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
