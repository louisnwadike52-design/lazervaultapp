import 'package:equatable/equatable.dart';
import '../../domain/entities/reminder_entity.dart';

abstract class ReminderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReminderInitial extends ReminderState {}

class ReminderLoading extends ReminderState {}

class ReminderCreating extends ReminderState {}

class ReminderCreated extends ReminderState {
  final PaymentReminderEntity reminder;
  final String message;

  ReminderCreated({
    required this.reminder,
    this.message = 'Reminder created successfully',
  });

  @override
  List<Object?> get props => [reminder, message];
}

class RemindersLoaded extends ReminderState {
  final List<PaymentReminderEntity> reminders;

  RemindersLoaded({required this.reminders});

  @override
  List<Object?> get props => [reminders];
}

class ReminderLoaded extends ReminderState {
  final PaymentReminderEntity reminder;

  ReminderLoaded({required this.reminder});

  @override
  List<Object?> get props => [reminder];
}

class ReminderUpdating extends ReminderState {}

class ReminderUpdated extends ReminderState {
  final PaymentReminderEntity reminder;
  final String message;

  ReminderUpdated({
    required this.reminder,
    this.message = 'Reminder updated successfully',
  });

  @override
  List<Object?> get props => [reminder, message];
}

class ReminderCompleting extends ReminderState {}

class ReminderCompleted extends ReminderState {
  final String message;

  ReminderCompleted({this.message = 'Reminder marked as complete'});

  @override
  List<Object?> get props => [message];
}

class ReminderDeleting extends ReminderState {}

class ReminderDeleted extends ReminderState {
  final String message;

  ReminderDeleted({this.message = 'Reminder deleted successfully'});

  @override
  List<Object?> get props => [message];
}

class ReminderError extends ReminderState {
  final String message;

  ReminderError({required this.message});

  @override
  List<Object?> get props => [message];
}
