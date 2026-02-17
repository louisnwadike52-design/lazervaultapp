import 'package:lazervault/src/generated/accounts.pbgrpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';

/// gRPC Client for Accounts Service
///
/// This client provides a clean interface to interact with the accounts-microservice
/// for transaction history operations. It uses the Core Gateway channel and includes
/// automatic authentication via GrpcCallOptionsHelper.
///
/// Architecture Notes:
/// - Transaction history is integrated into the accounts microservice
/// - Locale is derived from the account (not passed as parameter)
/// - Each account has an associated locale (en-US, en-NG, fr-FR, etc.)
class AccountsGrpcClient {
  final AccountsServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  AccountsGrpcClient({
    required AccountsServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  /// Get transaction history for an account
  ///
  /// The locale is automatically derived from the account's locale setting.
  ///
  /// Parameters:
  /// - [accountId]: The account ID to get transactions for
  /// - [type]: Optional filter by transaction type (credit/debit)
  /// - [category]: Optional filter by category (airtime, transfer, etc.)
  /// - [status]: Optional filter by status (completed, pending, etc.)
  /// - [serviceName]: Optional filter by service name (core-payments, giftcards, etc.)
  /// - [startDate]: Optional start date for filtering
  /// - [endDate]: Optional end date for filtering
  /// - [limit]: Maximum number of transactions to return (default: 20)
  /// - [offset]: Number of transactions to skip (for pagination)
  Future<GetTransactionHistoryResponse> getTransactionHistory({
    required String accountId,
    String? type,
    String? category,
    String? status,
    String? serviceName,
    DateTime? startDate,
    DateTime? endDate,
    int limit = 20,
    int offset = 0,
  }) async {
    final request = GetTransactionHistoryRequest()
      ..accountId = accountId
      ..limit = limit
      ..offset = offset;

    if (type != null && type.isNotEmpty) {
      request.type = type;
    }

    if (category != null && category.isNotEmpty) {
      request.category = category;
    }

    if (status != null && status.isNotEmpty) {
      request.status = status;
    }

    if (serviceName != null && serviceName.isNotEmpty) {
      request.serviceName = serviceName;
    }

    if (startDate != null) {
      request.startDate = _dateTimeToString(startDate);
    }

    if (endDate != null) {
      request.endDate = _dateTimeToString(endDate);
    }

    final options = await _callOptionsHelper.withAuth();

    try {
      final response = await _client.getTransactionHistory(
        request,
        options: options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch transaction history: $e');
    }
  }

  /// Get transaction statistics for an account
  ///
  /// Provides aggregated statistics including total count, totals, and
  /// breakdowns by transaction type and service name.
  ///
  /// Parameters:
  /// - [accountId]: The account ID to get statistics for
  /// - [startDate]: Optional start date for filtering
  /// - [endDate]: Optional end date for filtering
  Future<GetTransactionStatisticsResponse> getTransactionStatistics({
    required String accountId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final request = GetTransactionStatisticsRequest()
      ..accountId = accountId;

    if (startDate != null) {
      request.startDate = _dateTimeToString(startDate);
    }

    if (endDate != null) {
      request.endDate = _dateTimeToString(endDate);
    }

    final options = await _callOptionsHelper.withAuth();

    try {
      final response = await _client.getTransactionStatistics(
        request,
        options: options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch transaction statistics: $e');
    }
  }

  /// Create a transaction (for inter-service calls)
  ///
  /// This method is called by other services (payments, giftcards, etc.)
  /// to record transactions in the central accounts-service.
  ///
  /// Parameters:
  /// - [accountId]: The account ID to create transaction for
  /// - [type]: Transaction type (credit/debit)
  /// - [category]: Transaction category
  /// - [amount]: Transaction amount
  /// - [description]: Transaction description
  /// - [metadata]: Optional metadata JSON string
  /// - [serviceName]: The service creating this transaction
  /// - [reference]: Optional transaction reference
  Future<CreateTransactionResponse> createTransaction({
    required String accountId,
    required String type,
    required String category,
    required double amount,
    required String description,
    String? metadata,
    required String serviceName,
    String? reference,
  }) async {
    final request = CreateTransactionRequest()
      ..accountId = accountId
      ..type = type
      ..category = category
      ..amount = amount
      ..description = description
      ..serviceName = serviceName;

    if (metadata != null && metadata.isNotEmpty) {
      request.metadata = metadata;
    }

    if (reference != null && reference.isNotEmpty) {
      request.reference = reference;
    }

    final options = await _callOptionsHelper.withAuth();

    try {
      final response = await _client.createTransaction(
        request,
        options: options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create transaction: $e');
    }
  }

  /// Get account details
  ///
  /// Retrieves account information including locale, balance, etc.
  Future<Account> getAccount({
    required String accountId,
  }) async {
    final request = GetAccountRequest()
      ..accountId = accountId;

    final options = await _callOptionsHelper.withAuth();

    try {
      final response = await _client.getAccount(
        request,
        options: options,
      );
      return response.account;
    } catch (e) {
      throw Exception('Failed to fetch account: $e');
    }
  }

  /// Create a virtual account via Flutterwave/VFD provider
  ///
  /// Creates a real virtual NUBAN account for receiving payments.
  /// The provider (Flutterwave or VFD) is determined by the backend configuration.
  ///
  /// Parameters:
  /// - [accountName]: Account holder name
  /// - [accountType]: Type of account (personal, savings, etc.)
  /// - [currency]: Currency code (e.g., "NGN")
  /// - [locale]: BCP 47 locale (e.g., "en-NG")
  /// - [email]: User's email address
  /// - [firstName]: User's first name
  /// - [lastName]: User's last name
  /// - [phoneNumber]: User's phone number
  /// - [bvn]: Bank Verification Number (required for Nigeria)
  /// - [isPrimary]: Whether this is the primary account
  Future<CreateVirtualAccountResponse> createVirtualAccount({
    required String accountName,
    required String accountType,
    required String currency,
    required String locale,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String bvn,
    bool isPrimary = false,
  }) async {
    final request = CreateVirtualAccountRequest()
      ..accountName = accountName
      ..accountType = accountType
      ..currency = currency
      ..locale = locale
      ..email = email
      ..firstName = firstName
      ..lastName = lastName
      ..phoneNumber = phoneNumber
      ..bvn = bvn
      ..isPrimary = isPrimary;

    final options = await _callOptionsHelper.withAuth();

    try {
      final response = await _client.createVirtualAccount(
        request,
        options: options,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create virtual account: $e');
    }
  }

  /// Get financial analytics (income/expense with period comparison)
  Future<GetFinancialAnalyticsResponse> getFinancialAnalytics({
    required String accountId,
    String period = 'month',
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final request = GetFinancialAnalyticsRequest()
      ..accountId = accountId
      ..period = period;

    if (startDate != null) {
      request.startDate = _dateTimeToString(startDate);
    }
    if (endDate != null) {
      request.endDate = _dateTimeToString(endDate);
    }

    final options = await _callOptionsHelper.withAuth();

    try {
      return await _client.getFinancialAnalytics(request, options: options);
    } catch (e) {
      throw Exception('Failed to fetch financial analytics: $e');
    }
  }

  /// Get category analytics (income/expense breakdown by category)
  Future<GetCategoryAnalyticsResponse> getCategoryAnalytics({
    required String accountId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final request = GetCategoryAnalyticsRequest()
      ..accountId = accountId;

    if (startDate != null) {
      request.startDate = _dateTimeToString(startDate);
    }
    if (endDate != null) {
      request.endDate = _dateTimeToString(endDate);
    }

    final options = await _callOptionsHelper.withAuth();

    try {
      return await _client.getCategoryAnalytics(request, options: options);
    } catch (e) {
      throw Exception('Failed to fetch category analytics: $e');
    }
  }

  /// Get monthly trends (income/expense per month for last N months)
  Future<GetMonthlyTrendsResponse> getMonthlyTrends({
    required String accountId,
    int months = 6,
  }) async {
    final request = GetMonthlyTrendsRequest()
      ..accountId = accountId
      ..months = months;

    final options = await _callOptionsHelper.withAuth();

    try {
      return await _client.getMonthlyTrends(request, options: options);
    } catch (e) {
      throw Exception('Failed to fetch monthly trends: $e');
    }
  }

  /// Get expense time series (daily expense totals)
  Future<GetExpenseTimeSeriesResponse> getExpenseTimeSeries({
    required String accountId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final request = GetExpenseTimeSeriesRequest()
      ..accountId = accountId;

    if (startDate != null) {
      request.startDate = _dateTimeToString(startDate);
    }
    if (endDate != null) {
      request.endDate = _dateTimeToString(endDate);
    }

    final options = await _callOptionsHelper.withAuth();

    try {
      return await _client.getExpenseTimeSeries(request, options: options);
    } catch (e) {
      throw Exception('Failed to fetch expense time series: $e');
    }
  }

  // ===== CATEGORY MANAGEMENT =====

  /// Get user's custom category mappings
  Future<GetUserCategoryMappingsResponse> getUserCategoryMappings() async {
    final request = GetUserCategoryMappingsRequest();
    final options = await _callOptionsHelper.withAuth();
    try {
      return await _client.getUserCategoryMappings(request, options: options);
    } catch (e) {
      throw Exception('Failed to fetch category mappings: $e');
    }
  }

  /// Update a category mapping (rename, re-parent)
  Future<UpdateUserCategoryMappingResponse> updateUserCategoryMapping({
    required String originalCategory,
    required String customCategory,
    String parentCategory = '',
  }) async {
    final request = UpdateUserCategoryMappingRequest()
      ..originalCategory = originalCategory
      ..customCategory = customCategory
      ..parentCategory = parentCategory;
    final options = await _callOptionsHelper.withAuth();
    try {
      return await _client.updateUserCategoryMapping(request, options: options);
    } catch (e) {
      throw Exception('Failed to update category mapping: $e');
    }
  }

  /// Reorder categories (batch update display order)
  Future<ReorderCategoriesResponse> reorderCategories({
    required List<CategoryOrderItem> orderings,
  }) async {
    final request = ReorderCategoriesRequest()..orderings.addAll(orderings);
    final options = await _callOptionsHelper.withAuth();
    try {
      return await _client.reorderCategories(request, options: options);
    } catch (e) {
      throw Exception('Failed to reorder categories: $e');
    }
  }

  /// Helper: Convert DateTime to ISO8601 string
  String _dateTimeToString(DateTime dateTime) {
    return dateTime.toIso8601String();
  }
}
