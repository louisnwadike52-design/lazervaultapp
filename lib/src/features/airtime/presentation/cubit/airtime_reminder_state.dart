import 'package:equatable/equatable.dart';
import 'airtime_state.dart' show AirtimeReminder;

// Sealed hierarchy for the dedicated airtime-reminder Cubit. We reuse the
// `AirtimeReminder` proto-backed value object already defined in
// airtime_state.dart so the same type flows through both cubits.

sealed class AirtimeReminderState extends Equatable {
  const AirtimeReminderState();

  @override
  List<Object?> get props => [];
}

class AirtimeReminderInitial extends AirtimeReminderState {}

class AirtimeReminderLoading extends AirtimeReminderState {}

class AirtimeReminderCreating extends AirtimeReminderState {}

class AirtimeReminderUpdating extends AirtimeReminderState {}

class AirtimeReminderDeleting extends AirtimeReminderState {}

class AirtimeReminderCompleting extends AirtimeReminderState {}

class AirtimeRemindersLoaded extends AirtimeReminderState {
  final List<AirtimeReminder> reminders;

  const AirtimeRemindersLoaded({required this.reminders});

  @override
  List<Object?> get props => [reminders];
}

class AirtimeReminderCreated extends AirtimeReminderState {
  final AirtimeReminder reminder;

  const AirtimeReminderCreated({required this.reminder});

  @override
  List<Object?> get props => [reminder];
}

class AirtimeReminderUpdated extends AirtimeReminderState {
  final AirtimeReminder reminder;

  const AirtimeReminderUpdated({required this.reminder});

  @override
  List<Object?> get props => [reminder];
}

class AirtimeReminderCompleted extends AirtimeReminderState {
  final String message;
  const AirtimeReminderCompleted({this.message = 'Reminder marked as complete'});

  @override
  List<Object?> get props => [message];
}

class AirtimeReminderDeleted extends AirtimeReminderState {
  final String message;
  const AirtimeReminderDeleted({this.message = 'Reminder deleted'});

  @override
  List<Object?> get props => [message];
}

class AirtimeReminderError extends AirtimeReminderState {
  final String message;

  const AirtimeReminderError({required this.message});

  @override
  List<Object?> get props => [message];
}
