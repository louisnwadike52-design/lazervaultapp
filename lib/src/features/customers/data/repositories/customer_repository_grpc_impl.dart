import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/core/network/retry_helper.dart';
import 'package:lazervault/src/generated/payroll.pbgrpc.dart' as payroll_pb;
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/customer_financial_profile_entity.dart';
import '../../domain/entities/customer_note_entity.dart';
import '../../domain/repositories/customer_repository.dart';

class CustomerRepositoryGrpcImpl implements CustomerRepository {
  final payroll_pb.CustomerServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  CustomerRepositoryGrpcImpl({
    required payroll_pb.CustomerServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  // ---------------------------------------------------------------------------
  // CRUD
  // ---------------------------------------------------------------------------

  @override
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
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.CreateCustomerRequest()
          ..name = name
          ..businessName = businessName
          ..email = email
          ..phone = phone
          ..address = address
          ..city = city
          ..state = state
          ..country = country
          ..tin = tin
          ..bankAccountNumber = bankAccountNumber
          ..bankCode = bankCode
          ..bankName = bankName
          ..segment = payroll_pb.CustomerSegment.valueOf(segment) ??
              payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_NONE
          ..tags.addAll(tags)
          ..notes = notes;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.createCustomer(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _customerFromProto(response.customer);
      },
    );
  }

  @override
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
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.UpdateCustomerRequest()
          ..customerId = customerId;

        if (name != null) request.name = name;
        if (businessName != null) request.businessName = businessName;
        if (email != null) request.email = email;
        if (phone != null) request.phone = phone;
        if (address != null) request.address = address;
        if (city != null) request.city = city;
        if (state != null) request.state = state;
        if (country != null) request.country = country;
        if (tin != null) request.tin = tin;
        if (bankAccountNumber != null) {
          request.bankAccountNumber = bankAccountNumber;
        }
        if (bankCode != null) request.bankCode = bankCode;
        if (bankName != null) request.bankName = bankName;
        if (segment != null && segment > 0) {
          request.segment = payroll_pb.CustomerSegment.valueOf(segment) ??
              payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_NONE;
        }
        if (status != null && status > 0) {
          request.status = payroll_pb.CustomerStatus.valueOf(status) ??
              payroll_pb.CustomerStatus.CUSTOMER_STATUS_ACTIVE;
        }
        if (tags != null) {
          request.tags.clear();
          request.tags.addAll(tags);
        }
        if (notes != null) request.notes = notes;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.updateCustomer(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _customerFromProto(response.customer);
      },
    );
  }

  @override
  Future<void> deleteCustomer(String customerId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.DeleteCustomerRequest()
          ..customerId = customerId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.deleteCustomer(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }
      },
    );
  }

  @override
  Future<CustomerEntity> getCustomer(String customerId) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetCustomerRequest()
          ..customerId = customerId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getCustomer(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _customerFromProto(response.customer);
      },
    );
  }

  @override
  Future<CustomersPageResult> listCustomers({
    int page = 1,
    int limit = 20,
    String? search,
    int? segment,
    int? status,
    String? tag,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListCustomersRequest()
          ..page = page
          ..limit = limit;

        if (search != null && search.isNotEmpty) {
          request.search = search;
        }
        if (segment != null && segment > 0) {
          request.segment =
              payroll_pb.CustomerSegment.valueOf(segment) ??
                  payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_NONE;
        }
        if (status != null && status > 0) {
          request.status =
              payroll_pb.CustomerStatus.valueOf(status) ??
                  payroll_pb.CustomerStatus.CUSTOMER_STATUS_ACTIVE;
        }
        if (tag != null && tag.isNotEmpty) {
          request.tag = tag;
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listCustomers(
          request,
          options: options,
        );

        return CustomersPageResult(
          items: response.customers
              .map((c) => _customerFromProto(c))
              .toList(),
          totalItems: response.pagination.totalItems,
          currentPage: response.pagination.currentPage,
          totalPages: response.pagination.totalPages,
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Financial Profile
  // ---------------------------------------------------------------------------

  @override
  Future<CustomerFinancialProfileEntity> getFinancialProfile(
    String customerId,
  ) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetCustomerFinancialProfileRequest()
          ..customerId = customerId;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getCustomerFinancialProfile(
          request,
          options: options,
        );

        return _profileFromProto(response.profile);
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Summary
  // ---------------------------------------------------------------------------

  @override
  Future<Map<String, dynamic>> getSummary() async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetCustomerSummaryRequest();

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getCustomerSummary(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        final summary = response.summary;
        return {
          'totalCustomers': summary.totalCustomers,
          'activeCustomers': summary.activeCustomers,
          'totalOutstanding': summary.totalOutstanding.toInt() / 100.0,
          'overdueCustomers': summary.overdueCustomers,
        };
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Notes
  // ---------------------------------------------------------------------------

  @override
  Future<CustomerNoteEntity> addNote({
    required String customerId,
    required String content,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.AddCustomerNoteRequest()
          ..customerId = customerId
          ..content = content;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.addCustomerNote(
          request,
          options: options,
        );

        if (!response.success) {
          throw Exception(response.message);
        }

        return _noteFromProto(response.note);
      },
    );
  }

  @override
  Future<List<CustomerNoteEntity>> listNotes({
    required String customerId,
    int page = 1,
    int limit = 20,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.ListCustomerNotesRequest()
          ..customerId = customerId
          ..page = page
          ..limit = limit;

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.listCustomerNotes(
          request,
          options: options,
        );

        return response.notes
            .map((n) => _noteFromProto(n))
            .toList();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Statement
  // ---------------------------------------------------------------------------

  @override
  Future<Map<String, dynamic>> getStatement({
    required String customerId,
    String? startDate,
    String? endDate,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = payroll_pb.GetCustomerStatementRequest()
          ..customerId = customerId;

        if (startDate != null && startDate.isNotEmpty) {
          request.startDate = startDate;
        }
        if (endDate != null && endDate.isNotEmpty) {
          request.endDate = endDate;
        }

        final options = await _callOptionsHelper.withAuth();
        final response = await _client.getCustomerStatement(
          request,
          options: options,
        );

        return {
          'customerId': customerId,
          'openingBalance': response.openingBalance.toInt() / 100.0,
          'closingBalance': response.closingBalance.toInt() / 100.0,
          'entries': response.entries
              .map((e) => {
                    'id': e.id,
                    'type': e.type,
                    'reference': e.reference,
                    'description': e.description,
                    'amount': e.amount.toInt() / 100.0,
                    'balance': e.balance.toInt() / 100.0,
                    'date': e.hasDate()
                        ? e.date.toDateTime().toIso8601String()
                        : '',
                  })
              .toList(),
        };
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Proto -> Entity Mappers
  // ---------------------------------------------------------------------------

  CustomerEntity _customerFromProto(payroll_pb.Customer proto) {
    return CustomerEntity(
      id: proto.id,
      businessId: proto.businessId,
      name: proto.name,
      businessName: proto.businessName,
      email: proto.email,
      phone: proto.phone,
      address: proto.address,
      city: proto.city,
      state: proto.state,
      country: proto.country,
      tin: proto.tin,
      bankAccountNumber: proto.bankAccountNumber,
      bankCode: proto.bankCode,
      bankName: proto.bankName,
      segment: _segmentFromProto(proto.segment),
      status: _statusFromProto(proto.status),
      tags: proto.tags.toList(),
      notes: proto.notes,
      createdAt: proto.createdAt.toDateTime(),
      updatedAt: proto.updatedAt.toDateTime(),
    );
  }

  CustomerFinancialProfileEntity _profileFromProto(
    payroll_pb.CustomerFinancialProfile proto,
  ) {
    return CustomerFinancialProfileEntity(
      customerId: proto.customerId,
      totalInvoiced: proto.totalInvoiced.toInt() / 100.0,
      totalPaid: proto.totalPaid.toInt() / 100.0,
      outstanding: proto.outstanding.toInt() / 100.0,
      avgPaymentDays: proto.avgPaymentDays,
      totalInvoices: proto.totalInvoices,
      paidInvoices: proto.paidInvoices,
      overdueInvoices: proto.overdueInvoices,
      lastPaymentDate: proto.hasLastPaymentDate()
          ? proto.lastPaymentDate.toDateTime()
          : null,
    );
  }

  CustomerNoteEntity _noteFromProto(payroll_pb.CustomerNote proto) {
    return CustomerNoteEntity(
      id: proto.id,
      customerId: proto.customerId,
      businessId: proto.businessId,
      content: proto.content,
      createdBy: proto.createdBy,
      createdAt: proto.createdAt.toDateTime(),
    );
  }

  // ---------------------------------------------------------------------------
  // Proto -> Entity Enum Mappers
  // ---------------------------------------------------------------------------

  CustomerSegment _segmentFromProto(payroll_pb.CustomerSegment segment) {
    switch (segment) {
      case payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_NONE:
        return CustomerSegment.none;
      case payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_VIP:
        return CustomerSegment.vip;
      case payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_RETAIL:
        return CustomerSegment.retail;
      case payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_WHOLESALE:
        return CustomerSegment.wholesale;
      case payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_GOVERNMENT:
        return CustomerSegment.government;
      case payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_OVERDUE:
        return CustomerSegment.overdue;
      default:
        return CustomerSegment.none;
    }
  }

  CustomerStatus _statusFromProto(payroll_pb.CustomerStatus status) {
    switch (status) {
      case payroll_pb.CustomerStatus.CUSTOMER_STATUS_ACTIVE:
        return CustomerStatus.active;
      case payroll_pb.CustomerStatus.CUSTOMER_STATUS_INACTIVE:
        return CustomerStatus.inactive;
      case payroll_pb.CustomerStatus.CUSTOMER_STATUS_BLOCKED:
        return CustomerStatus.blocked;
      default:
        return CustomerStatus.active;
    }
  }

  // ---------------------------------------------------------------------------
  // Entity -> Proto Enum Mappers
  // ---------------------------------------------------------------------------

  payroll_pb.CustomerSegment _segmentToProto(CustomerSegment segment) {
    switch (segment) {
      case CustomerSegment.none:
        return payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_NONE;
      case CustomerSegment.vip:
        return payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_VIP;
      case CustomerSegment.retail:
        return payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_RETAIL;
      case CustomerSegment.wholesale:
        return payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_WHOLESALE;
      case CustomerSegment.government:
        return payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_GOVERNMENT;
      case CustomerSegment.overdue:
        return payroll_pb.CustomerSegment.CUSTOMER_SEGMENT_OVERDUE;
    }
  }

  payroll_pb.CustomerStatus _statusToProto(CustomerStatus status) {
    switch (status) {
      case CustomerStatus.active:
        return payroll_pb.CustomerStatus.CUSTOMER_STATUS_ACTIVE;
      case CustomerStatus.inactive:
        return payroll_pb.CustomerStatus.CUSTOMER_STATUS_INACTIVE;
      case CustomerStatus.blocked:
        return payroll_pb.CustomerStatus.CUSTOMER_STATUS_BLOCKED;
    }
  }
}
