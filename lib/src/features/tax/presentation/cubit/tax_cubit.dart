import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/tax/domain/repositories/tax_repository.dart';
import 'tax_state.dart';

class TaxCubit extends Cubit<TaxState> {
  final TaxRepository _repository;

  TaxCubit({required TaxRepository repository})
      : _repository = repository,
        super(TaxInitial());

  String _friendlyGrpcError(GrpcError e) {
    switch (e.code) {
      case StatusCode.unavailable:
        return 'Unable to reach tax service. Check your connection.';
      case StatusCode.deadlineExceeded:
        return 'Request timed out. Please try again.';
      case StatusCode.permissionDenied:
        return 'You don\'t have permission for this action.';
      case StatusCode.unauthenticated:
        return 'Session expired. Please log in again.';
      case StatusCode.notFound:
        return 'Record not found.';
      default:
        return e.message ?? 'An error occurred';
    }
  }

  // ---------------------------------------------------------------------------
  // Dashboard
  // ---------------------------------------------------------------------------

  Future<void> getDashboard() async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final data = await _repository.getDashboard();
      if (isClosed) return;
      emit(TaxDashboardLoaded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Calendar
  // ---------------------------------------------------------------------------

  Future<void> getCalendar({
    int? year,
    int? month,
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final events = await _repository.getCalendar(
        year: year,
        month: month,
      );
      if (isClosed) return;
      emit(TaxCalendarLoaded(events: events));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Obligation methods
  // ---------------------------------------------------------------------------

  Future<void> createObligation({
    required int taxType,
    required String period,
    required int amount,
    required String dueDate,
    String notes = '',
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final obligation = await _repository.createObligation(
        taxType: taxType,
        period: period,
        amount: amount,
        dueDate: dueDate,
        notes: notes,
      );
      if (isClosed) return;
      emit(ObligationCreated(obligation: obligation));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  Future<void> updateObligation({
    required String obligationId,
    int? status,
    int? amount,
    String? reference,
    String? notes,
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final obligation = await _repository.updateObligation(
        obligationId: obligationId,
        status: status,
        amount: amount,
        reference: reference,
        notes: notes,
      );
      if (isClosed) return;
      emit(ObligationUpdated(obligation: obligation));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  Future<void> listObligations({
    int page = 1,
    int limit = 20,
    int? taxType,
    int? status,
    int? year,
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final obligations = await _repository.listObligations(
        page: page,
        limit: limit,
        taxType: taxType,
        status: status,
        year: year,
      );
      if (isClosed) return;
      emit(ObligationsLoaded(obligations: obligations));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Document methods
  // ---------------------------------------------------------------------------

  Future<void> uploadDocument({
    required int documentType,
    required String name,
    required String fileUrl,
    String? expiryDate,
    String notes = '',
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final document = await _repository.uploadDocument(
        documentType: documentType,
        name: name,
        fileUrl: fileUrl,
        expiryDate: expiryDate,
        notes: notes,
      );
      if (isClosed) return;
      emit(DocumentUploaded(document: document));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  Future<void> listDocuments({
    int page = 1,
    int limit = 20,
    int? documentType,
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final documents = await _repository.listDocuments(
        page: page,
        limit: limit,
        documentType: documentType,
      );
      if (isClosed) return;
      emit(DocumentsLoaded(documents: documents));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      await _repository.deleteDocument(documentId);
      if (isClosed) return;
      emit(DocumentDeleted());
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // VAT methods
  // ---------------------------------------------------------------------------

  Future<void> getVATSchedule(String period) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final data = await _repository.getVATSchedule(period);
      if (isClosed) return;
      emit(VATScheduleLoaded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  Future<void> recordVATTransaction({
    required String description,
    required int baseAmount,
    required int direction,
    String invoiceReference = '',
    required String period,
    required String transactionDate,
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final data = await _repository.recordVATTransaction(
        description: description,
        baseAmount: baseAmount,
        direction: direction,
        invoiceReference: invoiceReference,
        period: period,
        transactionDate: transactionDate,
      );
      if (isClosed) return;
      emit(VATTransactionRecorded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // WHT methods
  // ---------------------------------------------------------------------------

  Future<void> getWHTSchedule(String period) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final data = await _repository.getWHTSchedule(period);
      if (isClosed) return;
      emit(WHTScheduleLoaded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  Future<void> recordWHTDeduction({
    required String vendorName,
    required int paymentAmount,
    required double whtRate,
    String paymentReference = '',
    required String period,
    required String transactionDate,
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final data = await _repository.recordWHTDeduction(
        vendorName: vendorName,
        paymentAmount: paymentAmount,
        whtRate: whtRate,
        paymentReference: paymentReference,
        period: period,
        transactionDate: transactionDate,
      );
      if (isClosed) return;
      emit(WHTDeductionRecorded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Report methods
  // ---------------------------------------------------------------------------

  Future<void> getPAYESummary({
    String? period,
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final data = await _repository.getPAYESummary(
        period: period,
      );
      if (isClosed) return;
      emit(PAYESummaryLoaded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }

  Future<void> getCITEstimation({
    int? year,
  }) async {
    try {
      if (isClosed) return;
      emit(TaxLoading());
      final data = await _repository.getCITEstimation(
        year: year,
      );
      if (isClosed) return;
      emit(CITEstimationLoaded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(TaxError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(TaxError(message: e.toString()));
    }
  }
}
