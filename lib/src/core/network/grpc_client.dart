import 'package:grpc/grpc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/auth/jwt_payload.dart';
import '../../../core/services/grpc_call_options_helper.dart';
import '../../generated/invoice.pbgrpc.dart';
import '../../generated/invoice_payment.pbgrpc.dart';
import '../../generated/tagged_invoice.pbgrpc.dart';
import '../../generated/statistics.pbgrpc.dart';
import '../../generated/ai_scan.pbgrpc.dart';
import '../../generated/tag_pay.pbgrpc.dart';
import '../../generated/exchange.pbgrpc.dart';
import '../../generated/qr_pay.pbgrpc.dart';
import '../../generated/id_pay.pbgrpc.dart';
import '../../generated/portfolio.pbgrpc.dart';
import '../../generated/account_card.pbgrpc.dart';
import '../../generated/electricity_bill.pbgrpc.dart';
import '../../generated/giftcards.pbgrpc.dart';
import '../../generated/lock_funds.pbgrpc.dart';
import '../../generated/insurance.pbgrpc.dart';
import '../../generated/financial-products.pbgrpc.dart';
import '../../generated/contactless_payment.pbgrpc.dart';
import '../../generated/split_bill.pbgrpc.dart';
import '../../generated/utility-payments.pbgrpc.dart';
import '../../generated/escrow.pbgrpc.dart';

class GrpcClient {
  final ClientChannel _channel;
  late InvoiceServiceClient _invoiceClient;
  late InvoicePaymentServiceClient _paymentClient;
  late TaggedInvoiceServiceClient _taggedInvoiceClient;
  late StatisticsServiceClient _statisticsClient;
  late AiScanServiceClient _aiScanClient;
  late TagPayServiceClient _tagPayClient;
  late ExchangeServiceClient _exchangeClient;
  late QRPayServiceClient _qrPayClient;
  late IDPayServiceClient _idPayClient;
  late PortfolioServiceClient _portfolioClient;
  late AccountCardServiceClient _accountCardClient;
  late ElectricityBillServiceClient _electricityBillClient;
  late GiftCardsServiceClient _giftCardClient;
  late LockFundsServiceClient _lockFundsClient;
  late InsuranceServiceClient _insuranceClient;
  late FinancialProductsServiceClient _financialProductsClient;
  late ContactlessPaymentServiceClient _contactlessPaymentClient;
  late SplitBillServiceClient _splitBillClient;
  late UtilityPaymentsServiceClient _utilityPaymentsClient;
  late EscrowServiceClient _escrowClient;

  final FlutterSecureStorage _secureStorage;
  final GrpcCallOptionsHelper? _callOptionsHelper;
  static const String _accessTokenKey = 'access_token';
  // Same key SecureStorageService persists the logged-in user id under (written
  // by AuthenticationCubit on login). Used by getCurrentUserId().
  static const String _userIdKey = 'user_id';

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
    _qrPayClient = QRPayServiceClient(_channel);
    _idPayClient = IDPayServiceClient(_channel);
    _portfolioClient = PortfolioServiceClient(_channel);
    _accountCardClient = AccountCardServiceClient(_channel);
    _electricityBillClient = ElectricityBillServiceClient(_channel);
    _giftCardClient = GiftCardsServiceClient(_channel);
    _lockFundsClient = LockFundsServiceClient(_channel);
    _insuranceClient = InsuranceServiceClient(_channel);
    _financialProductsClient = FinancialProductsServiceClient(_channel);
    _contactlessPaymentClient = ContactlessPaymentServiceClient(_channel);
    _splitBillClient = SplitBillServiceClient(_channel);
    _utilityPaymentsClient = UtilityPaymentsServiceClient(_channel);
    _escrowClient = EscrowServiceClient(_channel);
  }

  InvoiceServiceClient get invoiceClient => _invoiceClient;
  InvoicePaymentServiceClient get paymentClient => _paymentClient;
  InvoicePaymentServiceClient get invoicePaymentClient => _paymentClient;
  TaggedInvoiceServiceClient get taggedInvoiceClient => _taggedInvoiceClient;
  StatisticsServiceClient get statisticsClient => _statisticsClient;
  AiScanServiceClient get aiScanClient => _aiScanClient;
  TagPayServiceClient get tagPayClient => _tagPayClient;
  ExchangeServiceClient get exchangeClient => _exchangeClient;
  QRPayServiceClient get qrPayClient => _qrPayClient;
  IDPayServiceClient get idPayClient => _idPayClient;
  PortfolioServiceClient get portfolioClient => _portfolioClient;
  AccountCardServiceClient get accountCardClient => _accountCardClient;
  ElectricityBillServiceClient get electricityBillClient => _electricityBillClient;
  GiftCardsServiceClient get giftCardClient => _giftCardClient;
  LockFundsServiceClient get lockFundsClient => _lockFundsClient;
  InsuranceServiceClient get insuranceClient => _insuranceClient;
  FinancialProductsServiceClient get financialProductsClient => _financialProductsClient;
  ContactlessPaymentServiceClient get contactlessPaymentClient => _contactlessPaymentClient;
  SplitBillServiceClient get splitBillClient => _splitBillClient;
  UtilityPaymentsServiceClient get utilityPaymentsClient => _utilityPaymentsClient;
  EscrowServiceClient get escrowClient => _escrowClient;

  /// Get call options with authentication token
  /// If callOptionsHelper is available, use it for automatic token rotation
  Future<CallOptions> get callOptions async {
    // Use helper if available (provides automatic token rotation)
    if (_callOptionsHelper != null) {
      return await _callOptionsHelper!.withAuth();
    }

    // Fallback to manual token retrieval (legacy mode, no auto-rotation)
    final accessToken = await _secureStorage.read(key: _accessTokenKey);

    if (accessToken == null || accessToken.isEmpty) {
      throw GrpcError.unauthenticated('No authentication token available. Please log in again.');
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

  /// Current logged-in user id.
  ///
  /// Was a stub returning null, which made every caller that gates on it (e.g.
  /// AI Scan-to-Pay's `_getUserId()`) throw "User not authenticated" even when
  /// the user was signed in. Resolve it for real: prefer the id persisted at
  /// login (`user_id`), then fall back to the `sub`/`user_id` claim decoded from
  /// the access-token JWT (which is always present when authenticated).
  Future<String?> getCurrentUserId() async {
    final stored = await _secureStorage.read(key: _userIdKey);
    if (stored != null && stored.isNotEmpty) return stored;

    final token = await _secureStorage.read(key: _accessTokenKey);
    if (token != null && token.isNotEmpty) {
      final claims = decodeJwtPayload(token);
      final fromJwt = (claims?['user_id'] ??
              claims?['sub'] ??
              claims?['userId'] ??
              claims?['uid'])
          ?.toString();
      if (fromJwt != null && fromJwt.isNotEmpty) return fromJwt;
    }
    return null;
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final accessToken = await _secureStorage.read(key: _accessTokenKey);
    return accessToken != null && accessToken.isNotEmpty;
  }
}
