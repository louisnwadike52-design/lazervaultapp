import 'package:equatable/equatable.dart';
import '../../domain/entities/internet_reminder.dart';

sealed class InternetReminderState extends Equatable {
  const InternetReminderState();

  @override
  List<Object?> get props => [];
}

class InternetReminderInitial extends InternetReminderState {}

class InternetReminderLoading extends InternetReminderState {}

class InternetReminderCreating extends InternetReminderState {}

class InternetReminderUpdating extends InternetReminderState {}

class InternetReminderDeleting extends InternetReminderState {}

class InternetReminderCompleting extends InternetReminderState {}

class InternetRemindersLoaded extends InternetReminderState {
  final List<InternetReminder> reminders;
  const InternetRemindersLoaded({required this.reminders});

  @override
  List<Object?> get props => [reminders];
}

class InternetReminderCreated extends InternetReminderState {
  final InternetReminder reminder;
  const InternetReminderCreated({required this.reminder});

  @override
  List<Object?> get props => [reminder];
}

class InternetReminderUpdated extends InternetReminderState {
  final String message;
  const InternetReminderUpdated({this.message = 'Reminder updated'});

  @override
  List<Object?> get props => [message];
}

class InternetReminderCompleted extends InternetReminderState {
  final String message;
  const InternetReminderCompleted(
      {this.message = 'Reminder marked as complete'});

  @override
  List<Object?> get props => [message];
}

class InternetReminderDeleted extends InternetReminderState {
  final String message;
  const InternetReminderDeleted({this.message = 'Reminder deleted'});

  @override
  List<Object?> get props => [message];
}

class InternetReminderError extends InternetReminderState {
  final String message;
  const InternetReminderError({required this.message});

  @override
  List<Object?> get props => [message];
}
