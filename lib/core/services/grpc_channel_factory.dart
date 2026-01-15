import 'package:grpc/grpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Factory for creating gRPC channels for different API gateways
///
/// LazerVault uses 3 independent API gateways with dual servers (HTTP + gRPC):
/// 1. Core Gateway - gRPC: 50070, HTTP: 7878 (Auth, Accounts, Users, Support, Referrals)
/// 2. Investment Gateway - gRPC: 50072, HTTP: 9090 (Stocks, Crypto, Portfolio, Analytics)
/// 3. Financial Gateway - gRPC: 50071, HTTP: 8080 (Payments, Cards, Invoices, Expenses, Loans)
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

  /// Creates Financial Gateway gRPC channel (Payments, Cards, Invoices, Expenses, Loans, etc.)
  /// gRPC Port: 50071
  static ClientChannel createFinancialChannel() {
    final host = dotenv.env['PAYMENT_GRPC_HOST'] ??
        dotenv.env['INVOICE_GRPC_HOST'] ??
        dotenv.env['CARDS_GRPC_HOST'] ??
        '10.0.2.2';
    final port = int.parse(dotenv.env['PAYMENT_GRPC_PORT'] ??
        dotenv.env['INVOICE_GRPC_PORT'] ??
        dotenv.env['CARDS_GRPC_PORT'] ??
        '50071');

    print("💳 Creating Financial Gateway Channel → $host:$port");
    return _createChannel(host, port, 'Financial Gateway');
  }

  /// Internal method to create channel with standard production-grade options
  static ClientChannel _createChannel(String host, int port, String name) {
    return ClientChannel(
      host,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(), // Use TLS in production
        keepAlive: ClientKeepAliveOptions(
          pingInterval: Duration(seconds: 30), // Keep connection alive
          timeout: Duration(seconds: 10), // Ping timeout
          permitWithoutCalls: true, // Allow pings even when idle
        ),
        connectionTimeout: Duration(seconds: 10), // Connection establishment timeout
        idleTimeout: Duration(minutes: 5), // Close idle connections after 5 minutes
      ),
    );
  }

  /// Closes all channels gracefully
  static Future<void> closeAllChannels(
    ClientChannel coreChannel,
    ClientChannel investmentChannel,
    ClientChannel financialChannel,
  ) async {
    print("🔌 Closing all gRPC channels...");
    await Future.wait([
      coreChannel.shutdown(),
      investmentChannel.shutdown(),
      financialChannel.shutdown(),
    ]);
    print("✅ All gRPC channels closed");
  }
}
