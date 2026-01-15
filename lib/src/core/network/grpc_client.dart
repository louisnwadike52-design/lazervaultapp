import 'package:grpc/grpc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/services/grpc_call_options_helper.dart';
import '../../generated/invoice.pbgrpc.dart';
import '../../generated/invoice_payment.pbgrpc.dart';
import '../../generated/tagged_invoice.pbgrpc.dart';
import '../../generated/statistics.pbgrpc.dart';
import '../../generated/ai_scan.pbgrpc.dart';
import '../../generated/tag_pay.pbgrpc.dart';
import '../../generated/exchange.pbgrpc.dart';
import '../../generated/barcode_payment.pbgrpc.dart';
import '../../generated/portfolio.pbgrpc.dart';
import '../../generated/account_card.pbgrpc.dart';
import '../../generated/electricity_bill.pbgrpc.dart';
import '../../generated/giftcard.pbgrpc.dart';
import '../../generated/lock_funds.pbgrpc.dart';
import '../../generated/insurance.pbgrpc.dart';

class GrpcClient {
  final ClientChannel _channel;
  late InvoiceServiceClient _invoiceClient;
  late InvoicePaymentServiceClient _paymentClient;
  late TaggedInvoiceServiceClient _taggedInvoiceClient;
  late StatisticsServiceClient _statisticsClient;
  late AiScanServiceClient _aiScanClient;
  late TagPayServiceClient _tagPayClient;
  late ExchangeServiceClient _exchangeClient;
  late BarcodePaymentServiceClient _barcodePaymentClient;
  late PortfolioServiceClient _portfolioClient;
  late AccountCardServiceClient _accountCardClient;
  late ElectricityBillServiceClient _electricityBillClient;
  late GiftCardServiceClient _giftCardClient;
  late LockFundsServiceClient _lockFundsClient;
  late InsuranceServiceClient _insuranceClient;

  final FlutterSecureStorage _secureStorage;
  final GrpcCallOptionsHelper? _callOptionsHelper;
  static const String _accessTokenKey = 'access_token';

  /// Accepts an injected ClientChannel (Financial Gateway from injection_container)
  /// This ensures all financial services go through the proper API gateway
  GrpcClient({
    required ClientChannel channel,
    FlutterSecureStorage? secureStorage,
    GrpcCallOptionsHelper? callOptionsHelper,
  })  : _channel = channel,
        _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        _callOptionsHelper = callOptionsHelper;

  Future<void> initialize() async {
    _invoiceClient = InvoiceServiceClient(_channel);
    _paymentClient = InvoicePaymentServiceClient(_channel);
    _taggedInvoiceClient = TaggedInvoiceServiceClient(_channel);
    _statisticsClient = StatisticsServiceClient(_channel);
    _aiScanClient = AiScanServiceClient(_channel);
    _tagPayClient = TagPayServiceClient(_channel);
    _exchangeClient = ExchangeServiceClient(_channel);
    _barcodePaymentClient = BarcodePaymentServiceClient(_channel);
    _portfolioClient = PortfolioServiceClient(_channel);
    _accountCardClient = AccountCardServiceClient(_channel);
    _electricityBillClient = ElectricityBillServiceClient(_channel);
    _giftCardClient = GiftCardServiceClient(_channel);
    _lockFundsClient = LockFundsServiceClient(_channel);
    _insuranceClient = InsuranceServiceClient(_channel);
  }

  InvoiceServiceClient get invoiceClient => _invoiceClient;
  InvoicePaymentServiceClient get paymentClient => _paymentClient;
  InvoicePaymentServiceClient get invoicePaymentClient => _paymentClient;
  TaggedInvoiceServiceClient get taggedInvoiceClient => _taggedInvoiceClient;
  StatisticsServiceClient get statisticsClient => _statisticsClient;
  AiScanServiceClient get aiScanClient => _aiScanClient;
  TagPayServiceClient get tagPayClient => _tagPayClient;
  ExchangeServiceClient get exchangeClient => _exchangeClient;
  BarcodePaymentServiceClient get barcodePaymentClient => _barcodePaymentClient;
  PortfolioServiceClient get portfolioClient => _portfolioClient;
  AccountCardServiceClient get accountCardClient => _accountCardClient;
  ElectricityBillServiceClient get electricityBillClient => _electricityBillClient;
  GiftCardServiceClient get giftCardClient => _giftCardClient;
  LockFundsServiceClient get lockFundsClient => _lockFundsClient;
  InsuranceServiceClient get insuranceClient => _insuranceClient;

  /// Get call options with authentication token
  /// If callOptionsHelper is available, use it for automatic token rotation
  Future<CallOptions> get callOptions async {
    // Use helper if available (provides automatic token rotation)
    if (_callOptionsHelper != null) {
      return await _callOptionsHelper!.withAuth();
    }

    // Fallback to manual token retrieval (legacy mode, no auto-rotation)
    final accessToken = await _secureStorage.read(key: _accessTokenKey);

    print('=== GrpcClient.callOptions (legacy mode) ===');
    print('Access token present: ${accessToken != null && accessToken.isNotEmpty}');

    if (accessToken == null || accessToken.isEmpty) {
      print('ERROR: No access token in secure storage');
      throw GrpcError.unauthenticated('No authentication token available. Please log in again.');
    }

    print('Access token length: ${accessToken.length}');
    if (accessToken.isNotEmpty && accessToken.length > 20) {
      print('Access token prefix: ${accessToken.substring(0, 20)}...');
    }

    final metadata = <String, String>{
      'authorization': 'Bearer $accessToken',
    };

    return CallOptions(
      metadata: metadata,
      timeout: const Duration(seconds: 30),
    );
  }

  /// Execute a gRPC call with automatic token rotation on auth failures
  /// If callOptionsHelper is available, provides automatic token refresh
  Future<T> executeWithTokenRotation<T>(
    Future<T> Function() call, {
    int maxRetries = 1,
  }) async {
    if (_callOptionsHelper != null) {
      return await _callOptionsHelper!.executeWithTokenRotation(call, maxRetries: maxRetries);
    }

    // Fallback: no token rotation if helper not available
    return await call();
  }

  Future<void> dispose() async {
    await _channel.shutdown();
  }

  /// Get current user ID from token (not implemented for this storage approach)
  Future<String?> getCurrentUserId() async {
    // User ID would need to be decoded from JWT or stored separately
    return null;
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);
    return accessToken != null && accessToken.isNotEmpty;
  }
}
