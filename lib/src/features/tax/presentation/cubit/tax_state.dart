import 'package:lazervault/src/features/tax/domain/entities/tax_obligation_entity.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_document_entity.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_calendar_entity.dart';

sealed class TaxState {}

class TaxInitial extends TaxState {}

class TaxLoading extends TaxState {}

class TaxError extends TaxState {
  final String message;
  TaxError({required this.message});
}

// Dashboard
class TaxDashboardLoaded extends TaxState {
  final Map<String, dynamic> data;
  TaxDashboardLoaded({required this.data});
}

// Calendar
class TaxCalendarLoaded extends TaxState {
  final List<TaxCalendarEventEntity> events;
  TaxCalendarLoaded({required this.events});
}

// Obligations
class ObligationsLoaded extends TaxState {
  final List<TaxObligationEntity> obligations;
  ObligationsLoaded({required this.obligations});
}

class ObligationCreated extends TaxState {
  final TaxObligationEntity obligation;
  ObligationCreated({required this.obligation});
}

class ObligationUpdated extends TaxState {
  final TaxObligationEntity obligation;
  ObligationUpdated({required this.obligation});
}

// Documents
class DocumentsLoaded extends TaxState {
  final List<TaxDocumentEntity> documents;
  DocumentsLoaded({required this.documents});
}

class DocumentUploaded extends TaxState {
  final TaxDocumentEntity document;
  DocumentUploaded({required this.document});
}

class DocumentDeleted extends TaxState {}

// VAT
class VATScheduleLoaded extends TaxState {
  final Map<String, dynamic> data;
  VATScheduleLoaded({required this.data});
}

class VATTransactionRecorded extends TaxState {
  final Map<String, dynamic> data;
  VATTransactionRecorded({required this.data});
}

// WHT
class WHTScheduleLoaded extends TaxState {
  final Map<String, dynamic> data;
  WHTScheduleLoaded({required this.data});
}

class WHTDeductionRecorded extends TaxState {
  final Map<String, dynamic> data;
  WHTDeductionRecorded({required this.data});
}

// Reports
class PAYESummaryLoaded extends TaxState {
  final Map<String, dynamic> data;
  PAYESummaryLoaded({required this.data});
}

class CITEstimationLoaded extends TaxState {
  final Map<String, dynamic> data;
  CITEstimationLoaded({required this.data});
}
