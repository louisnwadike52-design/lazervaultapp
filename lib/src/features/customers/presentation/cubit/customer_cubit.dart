import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/customers/domain/repositories/customer_repository.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CustomerRepository _repository;

  CustomerCubit({required CustomerRepository repository})
      : _repository = repository,
        super(CustomerInitial());

  String _friendlyGrpcError(GrpcError e) {
    switch (e.code) {
      case StatusCode.unavailable:
        return 'Unable to reach customer service. Check your connection.';
      case StatusCode.deadlineExceeded:
        return 'Request timed out. Please try again.';
      case StatusCode.permissionDenied:
        return 'You don\'t have permission for this action.';
      case StatusCode.unauthenticated:
        return 'Session expired. Please log in again.';
      case StatusCode.notFound:
        return 'Customer not found.';
      default:
        return e.message ?? 'An error occurred';
    }
  }

  // ---------------------------------------------------------------------------
  // Customer CRUD methods
  // ---------------------------------------------------------------------------

  Future<void> listCustomers({
    int page = 1,
    String? search,
    int? segment,
    int? status,
    String? tag,
  }) async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      final result = await _repository.listCustomers(
        page: page,
        search: search,
        segment: segment,
        status: status,
        tag: tag,
      );
      if (isClosed) return;
      emit(CustomersLoaded(
        customers: result.items,
        totalPages: result.totalPages,
      ));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }

  Future<void> getCustomer(String customerId) async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      final customer = await _repository.getCustomer(customerId);
      if (isClosed) return;
      emit(CustomerLoaded(customer: customer));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }

  Future<void> createCustomer({
    required String name,
    String businessName = '',
    String email = '',
    String phone = '',
    String address = '',
    String city = '',
    String state = '',
    String country = '',
    String tin = '',
    String bankAccountNumber = '',
    String bankCode = '',
    String bankName = '',
    int segment = 0,
    List<String> tags = const [],
    String notes = '',
  }) async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      final customer = await _repository.createCustomer(
        name: name,
        businessName: businessName,
        email: email,
        phone: phone,
        address: address,
        city: city,
        state: state,
        country: country,
        tin: tin,
        bankAccountNumber: bankAccountNumber,
        bankCode: bankCode,
        bankName: bankName,
        segment: segment,
        tags: tags,
        notes: notes,
      );
      if (isClosed) return;
      emit(CustomerCreated(customer: customer));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }

  Future<void> updateCustomer({
    required String customerId,
    String? name,
    String? businessName,
    String? email,
    String? phone,
    String? address,
    String? city,
    String? state,
    String? country,
    String? tin,
    String? bankAccountNumber,
    String? bankCode,
    String? bankName,
    int? segment,
    int? status,
    List<String>? tags,
    String? notes,
  }) async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      final customer = await _repository.updateCustomer(
        customerId: customerId,
        name: name,
        businessName: businessName,
        email: email,
        phone: phone,
        address: address,
        city: city,
        state: state,
        country: country,
        tin: tin,
        bankAccountNumber: bankAccountNumber,
        bankCode: bankCode,
        bankName: bankName,
        segment: segment,
        status: status,
        tags: tags,
        notes: notes,
      );
      if (isClosed) return;
      emit(CustomerUpdated(customer: customer));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }

  Future<void> deleteCustomer(String customerId) async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      await _repository.deleteCustomer(customerId);
      if (isClosed) return;
      emit(CustomerDeleted());
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Financial Profile methods
  // ---------------------------------------------------------------------------

  Future<void> getFinancialProfile(String customerId) async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      final profile = await _repository.getFinancialProfile(customerId);
      if (isClosed) return;
      emit(FinancialProfileLoaded(profile: profile));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Summary methods
  // ---------------------------------------------------------------------------

  Future<void> getSummary() async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      final data = await _repository.getSummary();
      if (isClosed) return;
      emit(CustomerSummaryLoaded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Notes methods
  // ---------------------------------------------------------------------------

  Future<void> addNote({
    required String customerId,
    required String content,
  }) async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      final note = await _repository.addNote(
        customerId: customerId,
        content: content,
      );
      if (isClosed) return;
      emit(NoteAdded(note: note));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }

  Future<void> listNotes({
    required String customerId,
    int page = 1,
  }) async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      final notes = await _repository.listNotes(
        customerId: customerId,
        page: page,
      );
      if (isClosed) return;
      emit(NotesLoaded(notes: notes));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }

  // ---------------------------------------------------------------------------
  // Statement methods
  // ---------------------------------------------------------------------------

  Future<void> getStatement({
    required String customerId,
    String? startDate,
    String? endDate,
  }) async {
    try {
      if (isClosed) return;
      emit(CustomerLoading());
      final data = await _repository.getStatement(
        customerId: customerId,
        startDate: startDate,
        endDate: endDate,
      );
      if (isClosed) return;
      emit(StatementLoaded(data: data));
    } on GrpcError catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: _friendlyGrpcError(e)));
    } catch (e) {
      if (isClosed) return;
      emit(CustomerError(message: e.toString()));
    }
  }
}
