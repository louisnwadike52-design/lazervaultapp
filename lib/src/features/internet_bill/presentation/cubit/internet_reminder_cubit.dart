import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/internet_beneficiary_remote_datasource.dart';
import '../../domain/entities/internet_reminder.dart';
import 'internet_reminder_state.dart';

/// Cubit for the internet-scoped reminders surface. Mirrors
/// `DataReminderCubit`. The backend timer worker
/// (`InternetReminderTimerWorker`) fires notifications at the exact
/// `reminder_date` — this cubit only renders state, it doesn't drive
/// the firing.
///
/// MUTATION PATTERN (mark complete / update / delete):
///   1. call the backend RPC
///   2. patch the cached list locally (copyWith / removeWhere)
///   3. emit a transient message state (Completed/Updated/Deleted) for
///      the screen's BlocListener to show a snackbar
///   4. emit a fresh InternetRemindersLoaded with the patched list so
///      the builder refreshes only the affected row — never flashes
///      through Loading, never refetches over the wire
/// The reminders screen filters its BlocBuilder with buildWhen so the
/// transient message states don't cause an extra rebuild.
class InternetReminderCubit extends Cubit<InternetReminderState> {
  final InternetBeneficiaryRemoteDataSource datasource;

  /// Source of truth for the list surfaced on the reminders screen.
  /// Refilled on every successful `getReminders`; patched in place by
  /// `markReminderComplete` / `updateReminder` / `deleteReminder`.
  List<InternetReminder> _cachedReminders = <InternetReminder>[];

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
      _cachedReminders = List<InternetReminder>.from(list);
      emit(InternetRemindersLoaded(reminders: _cachedReminders));
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
      // Prepend the new reminder into the cache so the list surfaces it
      // immediately when the user lands back on the reminders screen —
      // the create screen pops with result=true but we don't want the
      // caller screen to need a reload round-trip either.
      _cachedReminders = [reminder, ..._cachedReminders];
      emit(InternetReminderCreated(reminder: reminder));
      emit(InternetRemindersLoaded(reminders: _cachedReminders));
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
      // Patch the cached row with the fields that just changed so the
      // screen re-renders just this row instead of triggering the full
      // getReminders spinner. Fields the caller left null keep their
      // existing values via copyWith's null-fallback.
      _cachedReminders = _cachedReminders
          .map((r) => r.id == reminderId
              ? r.copyWith(
                  title: title,
                  description: description,
                  reminderDate: reminderDate?.toUtc().toIso8601String(),
                  amount: amount,
                  packageId: packageId,
                  currency: currency,
                  isRecurring: isRecurring,
                  recurrenceType: recurrenceType,
                  updatedAt: DateTime.now().toUtc().toIso8601String(),
                )
              : r)
          .toList();
      emit(const InternetReminderUpdated());
      emit(InternetRemindersLoaded(reminders: _cachedReminders));
    } catch (e) {
      if (isClosed) return;
      emit(InternetReminderError(message: _friendly(e)));
    }
  }

  Future<void> markReminderComplete({required String reminderId}) async {
    if (isClosed) return;
    // No Completing transient here — the reactive patch flips the row's
    // status instantly so the user sees the change without a spinner.
    // If the backend fails we revert via the catch branch.
    final previous = _cachedReminders;
    try {
      _cachedReminders = _cachedReminders
          .map((r) => r.id == reminderId
              ? r.copyWith(status: 'completed')
              : r)
          .toList();
      emit(InternetRemindersLoaded(reminders: _cachedReminders));
      await datasource.markReminderComplete(reminderId);
      if (isClosed) return;
      emit(const InternetReminderCompleted());
      emit(InternetRemindersLoaded(reminders: _cachedReminders));
    } catch (e) {
      if (isClosed) return;
      // Revert the optimistic patch so the UI matches the backend again.
      _cachedReminders = previous;
      emit(InternetReminderError(message: _friendly(e)));
      emit(InternetRemindersLoaded(reminders: _cachedReminders));
    }
  }

  Future<void> deleteReminder({required String reminderId}) async {
    if (isClosed) return;
    final previous = _cachedReminders;
    try {
      // Optimistic remove — the row disappears the instant the user
      // confirms, then we confirm the backend accepted it. If the
      // backend rejects, we restore the row and surface the error.
      _cachedReminders =
          _cachedReminders.where((r) => r.id != reminderId).toList();
      emit(InternetRemindersLoaded(reminders: _cachedReminders));
      await datasource.deleteReminder(reminderId);
      if (isClosed) return;
      emit(const InternetReminderDeleted());
      emit(InternetRemindersLoaded(reminders: _cachedReminders));
    } catch (e) {
      if (isClosed) return;
      _cachedReminders = previous;
      emit(InternetReminderError(message: _friendly(e)));
      emit(InternetRemindersLoaded(reminders: _cachedReminders));
    }
  }

  String _friendly(Object e) =>
      e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
}
