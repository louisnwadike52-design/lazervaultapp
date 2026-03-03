import 'package:lazervault/src/features/customers/domain/entities/customer_entity.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_financial_profile_entity.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_note_entity.dart';

abstract class CustomerRepository {
  // CRUD
  Future<CustomerEntity> createCustomer({
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
  });

  Future<CustomerEntity> updateCustomer({
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
  });

  Future<void> deleteCustomer(String customerId);

  Future<CustomerEntity> getCustomer(String customerId);

  Future<CustomersPageResult> listCustomers({
    int page = 1,
    int limit = 20,
    String? search,
    int? segment,
    int? status,
    String? tag,
  });

  // Financial Profile
  Future<CustomerFinancialProfileEntity> getFinancialProfile(String customerId);

  // Summary
  Future<Map<String, dynamic>> getSummary();

  // Notes
  Future<CustomerNoteEntity> addNote({
    required String customerId,
    required String content,
  });

  Future<List<CustomerNoteEntity>> listNotes({
    required String customerId,
    int page = 1,
    int limit = 20,
  });

  // Statement
  Future<Map<String, dynamic>> getStatement({
    required String customerId,
    String? startDate,
    String? endDate,
  });
}
