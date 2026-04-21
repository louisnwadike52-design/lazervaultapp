import 'package:equatable/equatable.dart';
import '../../domain/entities/water_reminder.dart';

sealed class WaterReminderState extends Equatable {
  const WaterReminderState();

  @override
  List<Object?> get props => [];
}

class WaterReminderInitial extends WaterReminderState {}

class WaterReminderLoading extends WaterReminderState {}

class WaterReminderCreating extends WaterReminderState {}

class WaterReminderUpdating extends WaterReminderState {}

class WaterReminderDeleting extends WaterReminderState {}

class WaterReminderCompleting extends WaterReminderState {}

class WaterRemindersLoaded extends WaterReminderState {
  final List<WaterReminder> reminders;
  const WaterRemindersLoaded({required this.reminders});

  @override
  List<Object?> get props => [reminders];
}

class WaterReminderCreated extends WaterReminderState {
  final WaterReminder reminder;
  const WaterReminderCreated({required this.reminder});

  @override
  List<Object?> get props => [reminder];
}

class WaterReminderUpdated extends WaterReminderState {
  final String message;
  const WaterReminderUpdated({this.message = 'Reminder updated'});

  @override
  List<Object?> get props => [message];
}

class WaterReminderCompleted extends WaterReminderState {
  final String message;
  const WaterReminderCompleted(
      {this.message = 'Reminder marked as complete'});

  @override
  List<Object?> get props => [message];
}

class WaterReminderDeleted extends WaterReminderState {
  final String message;
  const WaterReminderDeleted({this.message = 'Reminder deleted'});

  @override
  List<Object?> get props => [message];
}

class WaterReminderError extends WaterReminderState {
  final String message;
  const WaterReminderError({required this.message});

  @override
  List<Object?> get props => [message];
}
