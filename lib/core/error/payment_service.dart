import 'package:dio/dio.dart';
import 'package:lazervault/core/error/error_handler.dart';

/// PaymentService demonstrates error recovery integration for Flutter app
class PaymentService {
  final Dio _dio;
  final ErrorHandler _errorHandler;

  PaymentService({
    required Dio dio,
    ErrorHandler? errorHandler,
  })  : _dio = dio,
        _errorHandler = errorHandler ?? ErrorHandler();

  /// Send money with automatic retry and error handling
  Future<Map<String, dynamic>> sendMoney({
    required String recipientId,
    required double amount,
    String? idempotencyKey,
  }) async {
    try {
      // Use idempotent retry for safe payment retry
      return await _errorHandler.executeIdempotent(
        idempotencyKey ?? 'payment_${DateTime.now().millisecondsSinceEpoch}',
        () => _executePayment(recipientId, amount),
      );
    } on AppError catch (e) {
      // Log error for analytics
      _logPaymentError(e, recipientId, amount);

      // Re-throw for UI to handle
      rethrow;
    }
  }

  /// Execute the actual payment API call
  Future<Map<String, dynamic>> _executePayment(
    String recipientId,
    double amount,
  ) async {
    final response = await _dio.post(
      '/api/v1/payments/send',
      data: {
        'recipient_id': recipientId,
        'amount': amount,
        'currency': 'USD',
      },
    );

    return response.data as Map<String, dynamic>;
  }

  /// Get balance with retry
  Future<double> getBalance() async {
    try {
      final result = await _errorHandler.executeWithRetry(
        () => _dio.get('/api/v1/accounts/balance'),
        config: RetryConfig.fast, // Fast retry for balance checks
      );

      final balance = (result.data as Map<String, dynamic>)['balance'] as double;
      return balance;
    } on AppError catch (e) {
      _logBalanceError(e);
      rethrow;
    }
  }

  /// Get transaction history with timeout
  Future<List<Map<String, dynamic>>> getTransactionHistory({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final result = await _errorHandler.executeWithRetry(
        () => _dio.get(
          '/api/v1/transactions/history',
          queryParameters: {
            'limit': limit,
            'offset': offset,
          },
        ),
        config: RetryConfig.standard,
      );

      final transactions = (result.data['transactions'] as List)
          .cast<Map<String, dynamic>>();
      return transactions;
    } on AppError catch (e) {
      _logTransactionError(e);
      rethrow;
    }
  }

  /// Error logging for analytics
  void _logPaymentError(AppError error, String recipientId, double amount) {
    // Send to analytics service
    print('Payment Error: ${error.code} - ${error.message}');
    print('Recipient: $recipientId, Amount: $amount');
    print('Retryable: ${error.retryable}');
    print('Trace ID: ${error.traceId}');
  }

  void _logBalanceError(AppError error) {
    print('Balance Error: ${error.code} - ${error.message}');
    print('Retryable: ${error.retryable}');
  }

  void _logTransactionError(AppError error) {
    print('Transaction Error: ${error.code} - ${error.message}');
    print('Retryable: ${error.retryable}');
  }
}

/// PaymentBloc demonstrates using PaymentService with BLoC pattern
class PaymentBloc {
  final PaymentService _paymentService;

  PaymentBloc({required PaymentService paymentService})
      : _paymentService = paymentService;

  /// Send money use case
  Future<void> sendMoney({
    required String recipientId,
    required double amount,
  }) async {
    try {
      // Show loading indicator
      // emit(PaymentLoading());

      final result = await _paymentService.sendMoney(
        recipientId: recipientId,
        amount: amount,
      );

      // Show success
      // emit(PaymentSuccess(result));
      print('Payment successful: ${result['transaction_id']}');

    } on AppError catch (e) {
      // Handle structured error
      print('Payment failed: ${e.userMessage}');

      if (e.isAuthError) {
        // Navigate to login
        print('Redirecting to login...');
        // emit(PaymentAuthRequired());
      } else if (e.retryable) {
        // Show retry dialog
        print('Payment failed but can be retried');
        // emit(PaymentRetryable(e));
      } else if (e.code == ErrorCode.insufficientFunds) {
        // Show insufficient funds message
        print('Insufficient funds');
        // emit(PaymentInsufficientFunds());
      } else {
        // Show generic error
        // emit(PaymentFailure(e));
      }
    } catch (e) {
      // Handle unexpected errors
      print('Unexpected error: $e');
      // emit(PaymentFailure(AppError(
      //   code: ErrorCode.unknown,
      //   message: e.toString(),
      // )));
    }
  }

  /// Get balance use case
  Future<double> getBalance() async {
    try {
      return await _paymentService.getBalance();
    } on AppError catch (e) {
      print('Failed to get balance: ${e.userMessage}');

      if (e.isNetworkError) {
        // Show cached balance if available
        print('Showing cached balance...');
        return 0.0; // Return cached balance
      }

      rethrow;
    }
  }
}

/// Usage Example in Flutter Widget:
///
/// ```dart
/// class SendMoneyScreen extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     final paymentService = PaymentService(
///       dio: Dio(BaseOptions(
///         baseUrl: 'https://api.lazervault.com',
///         connectTimeout: Duration(seconds: 10),
///         receiveTimeout: Duration(seconds: 30),
///       )),
///     );
///
///     final paymentBloc = PaymentBloc(
///       paymentService: paymentService,
///     );
///
///     return ElevatedButton(
///       onPressed: () async {
///         await paymentBloc.sendMoney(
///           recipientId: 'user-123',
///           amount: 100.0,
///         );
///       },
///       child: Text('Send $100'),
///     );
///   }
/// }
/// ```

/// Dio Interceptor for automatic error handling
class PaymentInterceptor extends Interceptor {
  final ErrorHandler _errorHandler;

  PaymentInterceptor({ErrorHandler? errorHandler})
      : _errorHandler = errorHandler ?? ErrorHandler();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Convert Dio error to AppError
    final appError = AppError.fromDioError(err);

    // Log error
    _errorHandler.handleError(appError);

    // Continue with AppError
    handler.resolve(Response(
      requestOptions: err.requestOptions,
      data: {
        'error': {
          'code': appError.code.value,
          'message': appError.message,
          'retryable': appError.retryable,
          'trace_id': appError.traceId,
        }
      },
      statusCode: appError.httpStatus ?? 500,
    ));
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // Add idempotency key for write operations
    if (options.method != 'GET' && !options.headers.containsKey('Idempotency-Key')) {
      options.headers['Idempotency-Key'] =
          'req_${DateTime.now().millisecondsSinceEpoch}_${options.uri}';
    }

    // Add trace ID
    options.headers['X-Trace-ID'] =
        'trace_${DateTime.now().millisecondsSinceEpoch}';

    handler.next(options);
  }
}

/// Setup Dio with error recovery
Dio createDioWithRecovery() {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.lazervault.com',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 30),
    sendTimeout: Duration(seconds: 10),
  ));

  // Add interceptors
  dio.interceptors.addAll([
    // Logging interceptor
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: false,
      responseHeader: false,
      error: true,
    ),

    // Payment interceptor for automatic error handling
    PaymentInterceptor(),
  ]);

  return dio;
}
