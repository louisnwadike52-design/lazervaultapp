import 'package:equatable/equatable.dart';
import '../../domain/entities/education_reminder.dart';

sealed class EducationReminderState extends Equatable {
  const EducationReminderState();

  @override
  List<Object?> get props => [];
}

class EducationReminderInitial extends EducationReminderState {}

class EducationReminderLoading extends EducationReminderState {}

class EducationReminderCreating extends EducationReminderState {}

class EducationReminderUpdating extends EducationReminderState {}

class EducationReminderDeleting extends EducationReminderState {}

class EducationReminderCompleting extends EducationReminderState {}

class EducationRemindersLoaded extends EducationReminderState {
  final List<EducationReminder> reminders;
  const EducationRemindersLoaded({required this.reminders});

  @override
  List<Object?> get props => [reminders];
}

class EducationReminderCreated extends EducationReminderState {
  final EducationReminder reminder;
  const EducationReminderCreated({required this.reminder});

  @override
  List<Object?> get props => [reminder];
}

class EducationReminderUpdated extends EducationReminderState {
  final String message;
  const EducationReminderUpdated({this.message = 'Reminder updated'});

  @override
  List<Object?> get props => [message];
}

class EducationReminderCompleted extends EducationReminderState {
  final String message;
  const EducationReminderCompleted(
      {this.message = 'Reminder marked as complete'});

  @override
  List<Object?> get props => [message];
}

class EducationReminderDeleted extends EducationReminderState {
  final String message;
  const EducationReminderDeleted({this.message = 'Reminder deleted'});

  @override
  List<Object?> get props => [message];
}

class EducationReminderError extends EducationReminderState {
  final String message;
  const EducationReminderError({required this.message});

  @override
  List<Object?> get props => [message];
}
