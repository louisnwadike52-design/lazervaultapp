import 'package:lazervault/src/features/tax/domain/entities/tax_obligation_entity.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_document_entity.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_calendar_entity.dart';

abstract class TaxRepository {
  // Dashboard
  Future<Map<String, dynamic>> getDashboard();

  // Calendar
  Future<List<TaxCalendarEventEntity>> getCalendar({int? year, int? month});

  // Obligations
  Future<TaxObligationEntity> createObligation({
    required int taxType,
    required String period,
    required int amount, // kobo
    required String dueDate,
    String notes = '',
  });

  Future<TaxObligationEntity> updateObligation({
    required String obligationId,
    int? status,
    int? amount, // kobo
    String? reference,
    String? notes,
  });

  Future<List<TaxObligationEntity>> listObligations({
    int page = 1,
    int limit = 20,
    int? taxType,
    int? status,
    int? year,
  });

  // Documents
  Future<TaxDocumentEntity> uploadDocument({
    required int documentType,
    required String name,
    required String fileUrl,
    String? expiryDate,
    String notes = '',
  });

  Future<List<TaxDocumentEntity>> listDocuments({
    int page = 1,
    int limit = 20,
    int? documentType,
  });

  Future<void> deleteDocument(String documentId);

  // VAT
  Future<Map<String, dynamic>> getVATSchedule(String period);

  Future<Map<String, dynamic>> recordVATTransaction({
    required String description,
    required int baseAmount, // kobo
    required int direction, // 0=OUTPUT, 1=INPUT
    String invoiceReference = '',
    required String period,
    required String transactionDate,
  });

  // WHT
  Future<Map<String, dynamic>> getWHTSchedule(String period);

  Future<Map<String, dynamic>> recordWHTDeduction({
    required String vendorName,
    required int paymentAmount, // kobo
    required double whtRate,
    String paymentReference = '',
    required String period,
    required String transactionDate,
  });

  // Reports
  Future<Map<String, dynamic>> getPAYESummary({String? period});

  Future<Map<String, dynamic>> getCITEstimation({int? year});
}
