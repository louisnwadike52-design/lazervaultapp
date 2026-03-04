import 'package:equatable/equatable.dart';
import '../../domain/entities/split_bill_entity.dart';

abstract class SplitBillState extends Equatable {
  const SplitBillState();

  @override
  List<Object?> get props => [];
}

class SplitBillInitial extends SplitBillState {}

class SplitBillLoading extends SplitBillState {}

class SplitBillListLoading extends SplitBillState {}

class SplitBillDetailLoading extends SplitBillState {}

class SplitBillPaymentProcessing extends SplitBillState {}

class SplitBillError extends SplitBillState {
  final String message;
  const SplitBillError(this.message);

  @override
  List<Object?> get props => [message];
}

class CreatedSplitBillsLoaded extends SplitBillState {
  final List<SplitBillEntity> bills;
  final int total;
  final int page;
  final int totalPages;

  const CreatedSplitBillsLoaded({
    required this.bills,
    this.total = 0,
    this.page = 1,
    this.totalPages = 1,
  });

  @override
  List<Object?> get props => [bills, total, page, totalPages];
}

class IncomingSplitBillsLoaded extends SplitBillState {
  final List<SplitBillEntity> bills;
  final int total;
  final int page;
  final int totalPages;

  const IncomingSplitBillsLoaded({
    required this.bills,
    this.total = 0,
    this.page = 1,
    this.totalPages = 1,
  });

  @override
  List<Object?> get props => [bills, total, page, totalPages];
}

class SplitBillDetailLoaded extends SplitBillState {
  final SplitBillEntity bill;

  const SplitBillDetailLoaded(this.bill);

  @override
  List<Object?> get props => [bill];
}

class SplitBillCreated extends SplitBillState {
  final SplitBillEntity bill;
  final String message;

  const SplitBillCreated({required this.bill, required this.message});

  @override
  List<Object?> get props => [bill, message];
}

class SplitBillSharePaid extends SplitBillState {
  final String transactionReference;
  final String message;
  final SplitBillEntity updatedBill;

  const SplitBillSharePaid({
    required this.transactionReference,
    required this.message,
    required this.updatedBill,
  });

  @override
  List<Object?> get props => [transactionReference, message, updatedBill];
}

class SplitBillCancelled extends SplitBillState {
  final String message;
  const SplitBillCancelled(this.message);

  @override
  List<Object?> get props => [message];
}

class SplitBillShareDeclined extends SplitBillState {
  final String message;
  const SplitBillShareDeclined(this.message);

  @override
  List<Object?> get props => [message];
}

class SplitBillReminderSent extends SplitBillState {
  final int count;
  final String message;

  const SplitBillReminderSent({required this.count, required this.message});

  @override
  List<Object?> get props => [count, message];
}
