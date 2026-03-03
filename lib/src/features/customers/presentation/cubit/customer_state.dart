import 'package:lazervault/src/features/customers/domain/entities/customer_entity.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_financial_profile_entity.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_note_entity.dart';

sealed class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerError extends CustomerState {
  final String message;
  CustomerError({required this.message});
}

// List
class CustomersLoaded extends CustomerState {
  final List<CustomerEntity> customers;
  final int totalPages;
  final bool isStale;
  CustomersLoaded({
    required this.customers,
    this.totalPages = 1,
    this.isStale = false,
  });
}

// Single
class CustomerLoaded extends CustomerState {
  final CustomerEntity customer;
  CustomerLoaded({required this.customer});
}

// CRUD results
class CustomerCreated extends CustomerState {
  final CustomerEntity customer;
  CustomerCreated({required this.customer});
}

class CustomerUpdated extends CustomerState {
  final CustomerEntity customer;
  CustomerUpdated({required this.customer});
}

class CustomerDeleted extends CustomerState {}

// Financial profile
class FinancialProfileLoaded extends CustomerState {
  final CustomerFinancialProfileEntity profile;
  FinancialProfileLoaded({required this.profile});
}

// Summary
class CustomerSummaryLoaded extends CustomerState {
  final Map<String, dynamic> data;
  CustomerSummaryLoaded({required this.data});
}

// Notes
class NoteAdded extends CustomerState {
  final CustomerNoteEntity note;
  NoteAdded({required this.note});
}

class NotesLoaded extends CustomerState {
  final List<CustomerNoteEntity> notes;
  NotesLoaded({required this.notes});
}

// Statement
class StatementLoaded extends CustomerState {
  final Map<String, dynamic> data;
  StatementLoaded({required this.data});
}
