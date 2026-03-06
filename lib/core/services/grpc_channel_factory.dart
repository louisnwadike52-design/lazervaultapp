import 'package:grpc/grpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Factory for creating gRPC channels for different API gateways
///
/// LazerVault uses independent API gateways with dual servers (HTTP + gRPC):
/// 1. Core Gateway - gRPC: 50070, HTTP: 7878 (Auth, Accounts, Users, Support, Referrals, Notifications)
/// 2. Commerce Gateway - gRPC: 50071, HTTP: 8080 (Utility Payments, GiftCards, Group Accounts, TagPay, Invoices)
/// 3. Investment Gateway - gRPC: 50072, HTTP: 9090 (Stocks, Crypto, Portfolio, Analytics)
/// 4. Transfer Gateway - gRPC: 50076, HTTP: 8084 (Payments, Transfers)
/// 5. Banking Gateway - gRPC: 50077, HTTP: 8082 (Banking, Virtual Accounts, Bank Verification)
/// 6. Products Gateway - gRPC: 50078, HTTP: 8083 (AutoSave, Crowdfund, Insurance)
/// 7. Contactless Payment Gateway - gRPC: 50075, HTTP: 8086 (NFC Payments, Payment Sessions)
/// 8. Business Gateway - gRPC: 50079, HTTP: 8085 (Payroll, Business Services)
class GrpcChannelFactory {
  /// Creates Core Gateway gRPC channel (Auth, Accounts, Users, Deposits, Withdrawals, etc.)
  /// gRPC Port: 50070
  static ClientChannel createCoreChannel() {
    final host = dotenv.env['GRPC_API_HOST'] ??
        (throw Exception(
            'GRPC_API_HOST not set. For Android emulator, use http://10.0.2.2'));
    final port = int.parse(dotenv.env['GRPC_API_PORT'] ?? '50070');

    // Extract host without protocol
    final uri = Uri.parse(host);
    final cleanHost = uri.host.isEmpty ? host : uri.host;

    print("📡 Creating Core Gateway Channel → $cleanHost:$port");
    return _createChannel(cleanHost, port, 'Core Gateway');
  }

  /// Creates Investment Gateway gRPC channel (Stocks, Crypto, Portfolio, Analytics)
  /// gRPC Port: 50072
  static ClientChannel createInvestmentChannel() {
    final host = dotenv.env['STOCKS_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['STOCKS_GRPC_PORT'] ?? '50072');

    print("📈 Creating Investment Gateway Channel → $host:$port");
    return _createChannel(host, port, 'Investment Gateway');
  }

  /// Creates Commerce Gateway gRPC channel (Utility Payments, GiftCards, Group Accounts, TagPay, Invoices)
  /// gRPC Port: 50071
  static ClientChannel createCommerceChannel() {
    final host = dotenv.env['PAYMENT_GRPC_HOST'] ??
        dotenv.env['INVOICE_GRPC_HOST'] ??
        dotenv.env['CARDS_GRPC_HOST'] ??
        '10.0.2.2';
    final port = int.parse(dotenv.env['PAYMENT_GRPC_PORT'] ??
        dotenv.env['INVOICE_GRPC_PORT'] ??
        dotenv.env['CARDS_GRPC_PORT'] ??
        '50071');

    print("💳 Creating Commerce Gateway Channel → $host:$port");
    return _createChannel(host, port, 'Commerce Gateway');
  }

  /// @deprecated Use [createCommerceChannel] instead.
  /// Kept for backward compatibility.
  static ClientChannel createFinancialChannel() => createCommerceChannel();

  /// Creates Transfer Gateway gRPC channel (Payments, Transfers)
  /// gRPC Port: 50076
  /// This is the PRIMARY channel for Send Funds/Transfers (via Core-Payment-Service)
  static ClientChannel createTransferChannel() {
    final host = dotenv.env['TRANSFER_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['TRANSFER_GRPC_PORT'] ?? '50076');
    print("💸 Creating Transfer/Payments Gateway Channel → $host:$port");
    return _createChannel(host, port, 'Transfer Gateway (Payments)');
  }

  /// Creates Banking Gateway gRPC channel (Banking, Virtual Accounts, Bank Verification)
  /// gRPC Port: 50077
  static ClientChannel createBankingGatewayChannel() {
    final host = dotenv.env['BANKING_GATEWAY_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['BANKING_GATEWAY_GRPC_PORT'] ?? '50077');
    return _createChannel(host, port, 'Banking Gateway');
  }

  /// Creates Products Gateway gRPC channel (AutoSave, Crowdfund, Insurance)
  /// Note: Group Accounts are routed through Commerce Gateway (50071)
  /// gRPC Port: 50078
  static ClientChannel createProductsChannel() {
    final host = dotenv.env['PRODUCTS_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['PRODUCTS_GRPC_PORT'] ?? '50078');
    return _createChannel(host, port, 'Products Gateway');
  }

  /// Creates Contactless Payment Gateway gRPC channel (NFC Payments, Sessions)
  /// gRPC Port: 50075
  static ClientChannel createContactlessChannel() {
    final host = dotenv.env['CONTACTLESS_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['CONTACTLESS_GRPC_PORT'] ?? '50075');

    print("📡 Creating Contactless Payment Gateway Channel → $host:$port");
    return _createChannel(host, port, 'Contactless Payment Gateway');
  }

  /// Creates Exchange Service gRPC channel (Currency Exchange, International Transfers)
  /// Routes through Core Gateway (port 50070) per architecture rules
  static ClientChannel createExchangeChannel() {
    final host = dotenv.env['CORE_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['CORE_GRPC_PORT'] ?? '50070');

    print("💱 Creating Exchange Service Channel (via Core Gateway) → $host:$port");
    return _createChannel(host, port, 'Exchange Service');
  }

  /// Creates Business Gateway gRPC channel (Payroll, Business Services)
  /// gRPC Port: 50079
  static ClientChannel createBusinessChannel() {
    final host = dotenv.env['BUSINESS_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['BUSINESS_GRPC_PORT'] ?? '50079');

    print("💼 Creating Business Gateway Channel → $host:$port");
    return _createChannel(host, port, 'Business Gateway');
  }

  /// Creates Chat Proxy Gateway gRPC channel (Direct Service Chat)
  /// gRPC Port: 50074
  static ClientChannel createChatProxyChannel() {
    final host = dotenv.env['CHAT_PROXY_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['CHAT_PROXY_GRPC_PORT'] ?? '50074');

    print("Creating Chat Proxy Gateway Channel -> $host:$port");
    return _createChannel(host, port, 'Chat Proxy Gateway');
  }

  /// Creates Banking Service gRPC channel (Transfers, Virtual Accounts, Bank Verification)
  /// gRPC Port: 50073
  static ClientChannel createBankingChannel() {
    final host = dotenv.env['BANKING_GRPC_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['BANKING_GRPC_PORT'] ?? '50073');

    print("🏦 Creating Banking Service Channel → $host:$port");
    return _createChannel(host, port, 'Banking Service');
  }

  /// Creates Voice Biometrics Service gRPC channel (Voice enrollment and verification)
  /// gRPC Port: 50060
  /// Direct connection to voice-biometrics-service (not via gateway)
  static ClientChannel createVoiceBiometricsChannel() {
    final host = dotenv.env['VOICE_BIOMETRICS_HOST'] ?? '10.0.2.2';
    final port = int.parse(dotenv.env['VOICE_BIOMETRICS_PORT'] ?? '50060');

    print("🎙️ Creating Voice Biometrics Service Channel → $host:$port");
    return _createChannel(host, port, 'Voice Biometrics Service');
  }

  /// Internal method to create channel with standard production-grade options
  /// Includes gzip compression for 60-80% payload reduction on low-bandwidth networks
  static ClientChannel _createChannel(String host, int port, String name) {
    return ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(), // Use TLS in production
        codecRegistry: CodecRegistry(codecs: const [GzipCodec()]), // Enable gzip compression
        keepAlive: const ClientKeepAliveOptions(
          pingInterval: Duration(seconds: 30), // Keep connection alive
          timeout: Duration(seconds: 10), // Ping timeout
          permitWithoutCalls: true, // Allow pings even when idle
        ),
        connectionTimeout: const Duration(seconds: 10), // Connection establishment timeout
        idleTimeout: const Duration(minutes: 5), // Close idle connections after 5 minutes
      ),
    );
  }

  /// Closes all channels gracefully
  static Future<void> closeAllChannels(
    ClientChannel coreChannel,
    ClientChannel investmentChannel,
    ClientChannel commerceChannel, {
    ClientChannel? bankingChannel,
    ClientChannel? transferChannel,
    ClientChannel? productsChannel,
  }) async {
    print("🔌 Closing all gRPC channels...");
    final futures = [
      coreChannel.shutdown(),
      investmentChannel.shutdown(),
      commerceChannel.shutdown(),
    ];
    if (bankingChannel != null) {
      futures.add(bankingChannel.shutdown());
    }
    if (transferChannel != null) {
      futures.add(transferChannel.shutdown());
    }
    if (productsChannel != null) {
      futures.add(productsChannel.shutdown());
    }
    await Future.wait(futures);
    print("✅ All gRPC channels closed");
  }
}
