import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/payroll.pbgrpc.dart' as payroll_pb;
import '../../domain/entities/tax_obligation_entity.dart';
import '../../domain/entities/tax_document_entity.dart';
import '../../domain/entities/tax_calendar_entity.dart';
import '../../domain/repositories/tax_repository.dart';

class TaxRepositoryGrpcImpl implements TaxRepository {
  final payroll_pb.TaxServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  TaxRepositoryGrpcImpl({
    required payroll_pb.TaxServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  // ---------------------------------------------------------------------------
  // Dashboard
  // ---------------------------------------------------------------------------

  @override
  Future<Map<String, dynamic>> getDashboard() async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetTaxDashboardRequest();

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getTaxDashboard(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        final d = response.dashboard;
        return {
          'vatDue': d.vatDue.toInt() / 100.0,
          'payeDue': d.payeDue.toInt() / 100.0,
          'whtDue': d.whtDue.toInt() / 100.0,
          'citEstimated': d.citEstimated.toInt() / 100.0,
          'pendingObligations': d.pendingObligations,
          'overdueObligations': d.overdueObligations,
          'upcomingDeadlines': d.upcomingDeadlines
              .map((e) => _calendarEventFromProto(e))
              .toList(),
        };
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Calendar
  // ---------------------------------------------------------------------------

  @override
  Future<List<TaxCalendarEventEntity>> getCalendar({
    int? year,
    int? month,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetTaxCalendarRequest();

        if (year != null) request.year = year;
        if (month != null) request.month = month;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getTaxCalendar(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return response.events
            .map((e) => _calendarEventFromProto(e))
            .toList();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Obligations
  // ---------------------------------------------------------------------------

  @override
  Future<TaxObligationEntity> createObligation({
    required int taxType,
    required String period,
    required int amount,
    required String dueDate,
    String notes = '',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.CreateTaxObligationRequest()
          ..taxType = _taxTypeToProto(taxType)
          ..period = period
          ..amount = $fixnum.Int64(amount)
          ..dueDate = dueDate
          ..notes = notes;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.createTaxObligation(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _obligationFromProto(response.obligation);
      },
    );
  }

  @override
  Future<TaxObligationEntity> updateObligation({
    required String obligationId,
    int? status,
    int? amount,
    String? reference,
    String? notes,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.UpdateTaxObligationRequest()
          ..obligationId = obligationId;

        if (status != null && status > 0) {
          request.status = _obligationStatusToProto(status);
        }
        if (amount != null) {
          request.amount = $fixnum.Int64(amount);
        }
        if (reference != null) request.reference = reference;
        if (notes != null) request.notes = notes;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.updateTaxObligation(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _obligationFromProto(response.obligation);
      },
    );
  }

  @override
  Future<List<TaxObligationEntity>> listObligations({
    int page = 1,
    int limit = 20,
    int? taxType,
    int? status,
    int? year,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListTaxObligationsRequest()
          ..page = page
          ..limit = limit;

        if (taxType != null && taxType > 0) {
          request.taxType = _taxTypeToProto(taxType);
        }
        if (status != null && status > 0) {
          request.status = _obligationStatusToProto(status);
        }
        if (year != null) request.year = year;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listTaxObligations(
          request,
          options: options,
        );

        return response.obligations
            .map((o) => _obligationFromProto(o))
            .toList();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Documents
  // ---------------------------------------------------------------------------

  @override
  Future<TaxDocumentEntity> uploadDocument({
    required int documentType,
    required String name,
    required String fileUrl,
    String? expiryDate,
    String notes = '',
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.UploadTaxDocumentRequest()
          ..documentType = _documentTypeToProto(documentType)
          ..name = name
          ..fileUrl = fileUrl
          ..notes = notes;

        if (expiryDate != null && expiryDate.isNotEmpty) {
          request.expiryDate = expiryDate;
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.uploadTaxDocument(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _documentFromProto(response.document);
      },
    );
  }

  @override
  Future<List<TaxDocumentEntity>> listDocuments({
    int page = 1,
    int limit = 20,
    int? documentType,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListTaxDocumentsRequest()
          ..page = page
          ..limit = limit;

        if (documentType != null && documentType > 0) {
          request.documentType = _documentTypeToProto(documentType);
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listTaxDocuments(
          request,
          options: options,
        );

        return response.documents
            .map((d) => _documentFromProto(d))
            .toList();
      },
    );
  }

  @override
  Future<void> deleteDocument(String documentId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.DeleteTaxDocumentRequest()
          ..documentId = documentId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.deleteTaxDocument(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }
      },
    );
  }

  // ---------------------------------------------------------------------------
  // VAT
  // ---------------------------------------------------------------------------

  @override
  Future<Map<String, dynamic>> getVATSchedule(String period) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetVATScheduleRequest()
          ..period = period;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getVATSchedule(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return {
          'entries': response.entries
              .map((e) => {
                    'id': e.id,
                    'businessId': e.businessId,
                    'description': e.description,
                    'baseAmount': e.baseAmount.toInt() / 100.0,
                    'vatAmount': e.vatAmount.toInt() / 100.0,
                    'direction': e.direction.value,
                    'invoiceReference': e.invoiceReference,
                    'period': e.period,
                    'transactionDate': e.transactionDate.toDateTime().toIso8601String(),
                    'createdAt': e.createdAt.toDateTime().toIso8601String(),
                  })
              .toList(),
          'totalOutputVat': response.totalOutputVat.toInt() / 100.0,
          'totalInputVat': response.totalInputVat.toInt() / 100.0,
          'netVatPayable': response.netVatPayable.toInt() / 100.0,
        };
      },
    );
  }

  @override
  Future<Map<String, dynamic>> recordVATTransaction({
    required String description,
    required int baseAmount,
    required int direction,
    String invoiceReference = '',
    required String period,
    required String transactionDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.RecordVATTransactionRequest()
          ..description = description
          ..baseAmount = $fixnum.Int64(baseAmount)
          ..direction = payroll_pb.VATDirection.valueOf(direction) ??
              payroll_pb.VATDirection.VAT_DIRECTION_OUTPUT
          ..invoiceReference = invoiceReference
          ..period = period
          ..transactionDate = transactionDate;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.recordVATTransaction(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        final e = response.entry;
        return {
          'id': e.id,
          'businessId': e.businessId,
          'description': e.description,
          'baseAmount': e.baseAmount.toInt() / 100.0,
          'vatAmount': e.vatAmount.toInt() / 100.0,
          'direction': e.direction.value,
          'invoiceReference': e.invoiceReference,
          'period': e.period,
          'transactionDate': e.transactionDate.toDateTime().toIso8601String(),
          'createdAt': e.createdAt.toDateTime().toIso8601String(),
        };
      },
    );
  }

  // ---------------------------------------------------------------------------
  // WHT
  // ---------------------------------------------------------------------------

  @override
  Future<Map<String, dynamic>> getWHTSchedule(String period) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetWHTScheduleRequest()
          ..period = period;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getWHTSchedule(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return {
          'entries': response.entries
              .map((e) => {
                    'id': e.id,
                    'businessId': e.businessId,
                    'vendorName': e.vendorName,
                    'paymentAmount': e.paymentAmount.toInt() / 100.0,
                    'whtRate': e.whtRate,
                    'whtAmount': e.whtAmount.toInt() / 100.0,
                    'paymentReference': e.paymentReference,
                    'period': e.period,
                    'transactionDate': e.transactionDate.toDateTime().toIso8601String(),
                    'createdAt': e.createdAt.toDateTime().toIso8601String(),
                  })
              .toList(),
          'totalWhtAmount': response.totalWhtDeducted.toInt() / 100.0,
        };
      },
    );
  }

  @override
  Future<Map<String, dynamic>> recordWHTDeduction({
    required String vendorName,
    required int paymentAmount,
    required double whtRate,
    String paymentReference = '',
    required String period,
    required String transactionDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.RecordWHTDeductionRequest()
          ..vendorName = vendorName
          ..paymentAmount = $fixnum.Int64(paymentAmount)
          ..whtRate = whtRate
          ..paymentReference = paymentReference
          ..period = period
          ..transactionDate = transactionDate;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.recordWHTDeduction(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        final e = response.entry;
        return {
          'id': e.id,
          'businessId': e.businessId,
          'vendorName': e.vendorName,
          'paymentAmount': e.paymentAmount.toInt() / 100.0,
          'whtRate': e.whtRate,
          'whtAmount': e.whtAmount.toInt() / 100.0,
          'paymentReference': e.paymentReference,
          'period': e.period,
          'transactionDate': e.transactionDate.toDateTime().toIso8601String(),
          'createdAt': e.createdAt.toDateTime().toIso8601String(),
        };
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Reports
  // ---------------------------------------------------------------------------

  @override
  Future<Map<String, dynamic>> getPAYESummary({String? period}) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetPAYESummaryRequest();

        if (period != null && period.isNotEmpty) {
          // Period format "YYYY-MM" — split into start/end
          request.periodStart = period;
          request.periodEnd = period;
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getPAYESummary(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return {
          'totalPaye': response.totalPaye.toInt() / 100.0,
          'employeeCount': response.employeeCount,
          'employeeSummaries': response.employeeSummaries
              .map((s) => {
                    'employeeId': s.employeeId,
                    'employeeName': s.employeeName,
                    'grossPay': s.grossPay.toInt() / 100.0,
                    'paye': s.paye.toInt() / 100.0,
                    'nhf': s.nhf.toInt() / 100.0,
                    'pension': s.pension.toInt() / 100.0,
                    'netPay': s.netPay.toInt() / 100.0,
                  })
              .toList(),
        };
      },
    );
  }

  @override
  Future<Map<String, dynamic>> getCITEstimation({int? year}) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetCITEstimationRequest();

        if (year != null) request.year = year;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getCITEstimation(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return {
          'annualRevenue': response.annualRevenue.toInt() / 100.0,
          'annualExpenses': response.annualExpenses.toInt() / 100.0,
          'taxableIncome': response.taxableIncome.toInt() / 100.0,
          'citRate': response.citRate,
          'estimatedCit': response.estimatedCit.toInt() / 100.0,
          'taxBand': response.taxBand,
        };
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Proto -> Entity Mappers
  // ---------------------------------------------------------------------------

  TaxObligationEntity _obligationFromProto(
    payroll_pb.TaxObligation proto,
  ) {
    return TaxObligationEntity(
      id: proto.id,
      businessId: proto.businessId,
      taxType: _taxTypeFromProto(proto.taxType),
      period: proto.period,
      amount: proto.amount.toInt() / 100.0,
      status: _obligationStatusFromProto(proto.status),
      dueDate: proto.dueDate.toDateTime(),
      filedDate:
          proto.hasFiledDate() ? proto.filedDate.toDateTime() : null,
      paidDate:
          proto.hasPaidDate() ? proto.paidDate.toDateTime() : null,
      reference: proto.reference,
      notes: proto.notes,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  TaxDocumentEntity _documentFromProto(payroll_pb.TaxDocument proto) {
    return TaxDocumentEntity(
      id: proto.id,
      businessId: proto.businessId,
      documentType: _documentTypeFromProto(proto.documentType),
      name: proto.name,
      fileUrl: proto.fileUrl,
      expiryDate:
          proto.hasExpiryDate() ? proto.expiryDate.toDateTime() : null,
      notes: proto.notes,
      createdAt: proto.createdAt.toDateTime(),
    );
  }

  TaxCalendarEventEntity _calendarEventFromProto(
    payroll_pb.TaxCalendarEvent proto,
  ) {
    return TaxCalendarEventEntity(
      taxType: _taxTypeFromProto(proto.taxType),
      description: proto.description,
      dueDate: proto.dueDate.toDateTime(),
      isFiled: proto.isFiled,
      isPaid: proto.isPaid,
      period: proto.period,
    );
  }

  // ---------------------------------------------------------------------------
  // Proto -> Entity Enum Mappers
  // ---------------------------------------------------------------------------

  TaxType _taxTypeFromProto(payroll_pb.TaxType type) {
    switch (type) {
      case payroll_pb.TaxType.TAX_TYPE_VAT:
        return TaxType.vat;
      case payroll_pb.TaxType.TAX_TYPE_PAYE:
        return TaxType.paye;
      case payroll_pb.TaxType.TAX_TYPE_WHT:
        return TaxType.wht;
      case payroll_pb.TaxType.TAX_TYPE_CIT:
        return TaxType.cit;
      default:
        return TaxType.vat;
    }
  }

  TaxObligationStatus _obligationStatusFromProto(
    payroll_pb.TaxObligationStatus status,
  ) {
    switch (status) {
      case payroll_pb.TaxObligationStatus.TAX_OBLIGATION_STATUS_PENDING:
        return TaxObligationStatus.pending;
      case payroll_pb.TaxObligationStatus.TAX_OBLIGATION_STATUS_FILED:
        return TaxObligationStatus.filed;
      case payroll_pb.TaxObligationStatus.TAX_OBLIGATION_STATUS_PAID:
        return TaxObligationStatus.paid;
      case payroll_pb.TaxObligationStatus.TAX_OBLIGATION_STATUS_OVERDUE:
        return TaxObligationStatus.overdue;
      default:
        return TaxObligationStatus.pending;
    }
  }

  TaxDocumentType _documentTypeFromProto(
    payroll_pb.TaxDocumentType type,
  ) {
    switch (type) {
      case payroll_pb.TaxDocumentType.TAX_DOCUMENT_TYPE_TIN_CERT:
        return TaxDocumentType.tinCert;
      case payroll_pb.TaxDocumentType.TAX_DOCUMENT_TYPE_VAT_REGISTRATION:
        return TaxDocumentType.vatRegistration;
      case payroll_pb.TaxDocumentType.TAX_DOCUMENT_TYPE_TAX_CLEARANCE:
        return TaxDocumentType.taxClearance;
      case payroll_pb.TaxDocumentType.TAX_DOCUMENT_TYPE_WHT_RECEIPT:
        return TaxDocumentType.whtReceipt;
      case payroll_pb.TaxDocumentType.TAX_DOCUMENT_TYPE_FILING_RECEIPT:
        return TaxDocumentType.filingReceipt;
      default:
        return TaxDocumentType.tinCert;
    }
  }

  // ---------------------------------------------------------------------------
  // Entity -> Proto Enum Mappers
  // ---------------------------------------------------------------------------

  payroll_pb.TaxType _taxTypeToProto(int value) {
    return payroll_pb.TaxType.valueOf(value) ??
        payroll_pb.TaxType.TAX_TYPE_VAT;
  }

  payroll_pb.TaxObligationStatus _obligationStatusToProto(int value) {
    return payroll_pb.TaxObligationStatus.valueOf(value) ??
        payroll_pb.TaxObligationStatus.TAX_OBLIGATION_STATUS_PENDING;
  }

  payroll_pb.TaxDocumentType _documentTypeToProto(int value) {
    return payroll_pb.TaxDocumentType.valueOf(value) ??
        payroll_pb.TaxDocumentType.TAX_DOCUMENT_TYPE_TIN_CERT;
  }
}
