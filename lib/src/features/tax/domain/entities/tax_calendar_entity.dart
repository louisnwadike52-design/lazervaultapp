import 'package:equatable/equatable.dart';
import 'tax_obligation_entity.dart';

class TaxCalendarEventEntity extends Equatable {
  final TaxType taxType;
  final String description;
  final DateTime dueDate;
  final bool isFiled;
  final bool isPaid;
  final String period;

  const TaxCalendarEventEntity({
    required this.taxType,
    required this.description,
    required this.dueDate,
    required this.isFiled,
    required this.isPaid,
    required this.period,
  });

  bool get isDone => isFiled || isPaid;

  int get daysUntilDue => dueDate.difference(DateTime.now()).inDays;

  bool get isOverdue => !isDone && dueDate.isBefore(DateTime.now());

  @override
  List<Object?> get props => [taxType, dueDate, period];
}
