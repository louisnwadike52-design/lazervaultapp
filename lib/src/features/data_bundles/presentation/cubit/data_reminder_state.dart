import 'package:equatable/equatable.dart';
import '../../domain/entities/data_reminder.dart';

sealed class DataReminderState extends Equatable {
  const DataReminderState();

  @override
  List<Object?> get props => [];
}

class DataReminderInitial extends DataReminderState {}

class DataReminderLoading extends DataReminderState {}

class DataReminderCreating extends DataReminderState {}

class DataReminderUpdating extends DataReminderState {}

class DataReminderDeleting extends DataReminderState {}

class DataReminderCompleting extends DataReminderState {}

class DataRemindersLoaded extends DataReminderState {
  final List<DataReminder> reminders;
  const DataRemindersLoaded({required this.reminders});

  @override
  List<Object?> get props => [reminders];
}

class DataReminderCreated extends DataReminderState {
  final DataReminder reminder;
  const DataReminderCreated({required this.reminder});

  @override
  List<Object?> get props => [reminder];
}

class DataReminderUpdated extends DataReminderState {
  final String message;
  const DataReminderUpdated({this.message = 'Reminder updated'});

  @override
  List<Object?> get props => [message];
}

class DataReminderCompleted extends DataReminderState {
  final String message;
  const DataReminderCompleted({this.message = 'Reminder marked as complete'});

  @override
  List<Object?> get props => [message];
}

class DataReminderDeleted extends DataReminderState {
  final String message;
  const DataReminderDeleted({this.message = 'Reminder deleted'});

  @override
  List<Object?> get props => [message];
}

class DataReminderError extends DataReminderState {
  final String message;
  const DataReminderError({required this.message});

  @override
  List<Object?> get props => [message];
}
