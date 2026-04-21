import 'package:equatable/equatable.dart';
import '../../domain/entities/cable_tv_reminder.dart';

sealed class CableTVReminderState extends Equatable {
  const CableTVReminderState();

  @override
  List<Object?> get props => [];
}

class CableTVReminderInitial extends CableTVReminderState {}

class CableTVReminderLoading extends CableTVReminderState {}

class CableTVReminderCreating extends CableTVReminderState {}

class CableTVReminderUpdating extends CableTVReminderState {}

class CableTVReminderDeleting extends CableTVReminderState {}

class CableTVReminderCompleting extends CableTVReminderState {}

class CableTVRemindersLoaded extends CableTVReminderState {
  final List<CableTVReminder> reminders;
  const CableTVRemindersLoaded({required this.reminders});

  @override
  List<Object?> get props => [reminders];
}

class CableTVReminderCreated extends CableTVReminderState {
  final CableTVReminder reminder;
  const CableTVReminderCreated({required this.reminder});

  @override
  List<Object?> get props => [reminder];
}

class CableTVReminderUpdated extends CableTVReminderState {
  final String message;
  const CableTVReminderUpdated({this.message = 'Reminder updated'});

  @override
  List<Object?> get props => [message];
}

class CableTVReminderCompleted extends CableTVReminderState {
  final String message;
  const CableTVReminderCompleted(
      {this.message = 'Reminder marked as complete'});

  @override
  List<Object?> get props => [message];
}

class CableTVReminderDeleted extends CableTVReminderState {
  final String message;
  const CableTVReminderDeleted({this.message = 'Reminder deleted'});

  @override
  List<Object?> get props => [message];
}

class CableTVReminderError extends CableTVReminderState {
  final String message;
  const CableTVReminderError({required this.message});

  @override
  List<Object?> get props => [message];
}
