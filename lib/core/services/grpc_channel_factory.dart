import 'package:grpc/grpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lazervault/core/services/resilient_client_channel.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';

/// Factory for creating gRPC channels for different API gateways
///
/// LazerVault uses independent API gateways with dual servers (HTTP + gRPC):
/// 1. Core Gateway - gRPC: 50070, HTTP: 7878 (Auth, Accounts, Users, Support, Referrals, Notifications)
/// 2. Commerce Gateway - gRPC: 50061, HTTP: 8080 (Utility Payments, GiftCards, Group Accounts, TagPay, Invoices, Electricity Bills)
/// 3. Financial Gateway - gRPC: 50071, HTTP: 8016 (Invoices, Group Accounts, Split Bill, QR Pay, ID Pay, GiftCards,
///    Currency Exchange + International Transfers). Exchange was relocated here to isolate it from the
///    high-volume C2C path served by Transfer Gateway.
/// 4. Investment Gateway - gRPC: 50072, HTTP: 9090 (Stocks, Crypto, Portfolio, Analytics)
/// 5. Transfer Gateway - gRPC: 50076, HTTP: 8084 (Payments, Transfers)
/// 6. Banking Gateway - gRPC: 50077, HTTP: 8082 (Banking, Virtual Accounts, Bank Verification)
/// 7. Products Gateway - gRPC: 50078, HTTP: 8083 (AutoSave, Crowdfund, Insurance)
/// 8. Contactless Payment Gateway - gRPC: 50075, HTTP: 8086 (NFC Payments, Payment Sessions)
/// 9. Business Gateway - gRPC: 50079, HTTP: 8085 (Payroll, Business Services)
class GrpcChannelFactory {
  /// Creates Core Gateway gRPC channel (Auth, Accounts, Users, Deposits, Withdrawals, etc.)
  /// Routed by cloudflared to core-gateway gRPC port 50070 via
  /// /pb.AuthService/* (and the broader core-gateway service set).
  static ClientChannel createCoreChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'GRPC_API_HOST',
      legacyPortEnvKey: 'GRPC_API_PORT',
      fallbackPort: 50070,
    );
    print("📡 Creating Core Gateway Channel → ${ep.host}:${ep.port} (tls=${ep.useTls})");
    return _createChannel(ep.host, ep.port, 'Core Gateway', useTls: ep.useTls);
  }

  /// Creates Investment Gateway gRPC channel — investment-gateway port 50072.
  static ClientChannel createInvestmentChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'STOCKS_GRPC_HOST',
      legacyPortEnvKey: 'STOCKS_GRPC_PORT',
      fallbackPort: 50072,
    );
    print("📈 Creating Investment Gateway Channel → ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Investment Gateway', useTls: ep.useTls);
  }

  /// Creates Commerce Gateway gRPC channel — commerce-gateway port 50061.
  static ClientChannel createCommerceChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'PAYMENT_GRPC_HOST',
      legacyPortEnvKey: 'PAYMENT_GRPC_PORT',
      fallbackPort: 50061,
    );
    print("💳 Creating Commerce Gateway Channel → ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Commerce Gateway', useTls: ep.useTls);
  }

  /// Creates Financial Gateway gRPC channel — financial-gateway port 50071.
  static ClientChannel createFinancialChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'FINANCIAL_GRPC_HOST',
      legacyPortEnvKey: 'FINANCIAL_GRPC_PORT',
      fallbackPort: 50071,
    );
    print("💱 Creating Financial Gateway Channel → ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Financial Gateway', useTls: ep.useTls);
  }

  /// Creates Transfer Gateway gRPC channel (Payments, Transfers)
  /// This is the PRIMARY channel for Send Funds/Transfers (via Core-Payment-Service).
  ///
  /// Canonical local ports (keep in sync with backend):
  /// - [PORTS_CONFIG.json]: `transfer_gateway_grpc` (50076), `transfer_gateway_http` (8084)
  /// - [scripts/service-discovery.sh]: `TRANSFER_GATEWAY_GRPC_PORT`, `TRANSFER_GATEWAY_HTTP_PORT`
  /// - [start_all_local_no_docker.sh]: `transfer-gateway:8084:50076`
  static ClientChannel createTransferChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'TRANSFER_GRPC_HOST',
      legacyPortEnvKey: 'TRANSFER_GRPC_PORT',
      fallbackPort: 50076,
    );
    print("💸 Creating Transfer/Payments Gateway Channel → ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Transfer Gateway (Payments)', useTls: ep.useTls);
  }

  /// Creates Banking Gateway gRPC channel — banking-gateway port 50077.
  static ClientChannel createBankingGatewayChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'BANKING_GATEWAY_GRPC_HOST',
      legacyPortEnvKey: 'BANKING_GATEWAY_GRPC_PORT',
      fallbackPort: 50077,
    );
    return _createChannel(ep.host, ep.port, 'Banking Gateway', useTls: ep.useTls);
  }

  /// Creates Products Gateway gRPC channel — products-gateway port 50078.
  static ClientChannel createProductsChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'PRODUCTS_GRPC_HOST',
      legacyPortEnvKey: 'PRODUCTS_GRPC_PORT',
      fallbackPort: 50078,
    );
    return _createChannel(ep.host, ep.port, 'Products Gateway', useTls: ep.useTls);
  }

  /// Creates Contactless Payment Gateway gRPC channel — contactless-payment-gateway port 50075.
  static ClientChannel createContactlessChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'CONTACTLESS_GRPC_HOST',
      legacyPortEnvKey: 'CONTACTLESS_GRPC_PORT',
      fallbackPort: 50075,
    );
    print("📡 Creating Contactless Payment Gateway Channel → ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Contactless Payment Gateway', useTls: ep.useTls);
  }

  /// Creates Exchange Service gRPC channel (Currency Exchange, International
  /// Transfers).
  ///
  /// Routes through **Financial Gateway** (gRPC 50071, HTTP 8016). That
  /// gateway now owns Exchange registration exclusively — it was moved
  /// off transfer-gateway so the high-volume C2C transfer RPCs can't
  /// starve FX requests for keepalive slots or goroutines under load.
  ///
  /// The proto used is the microservice's canonical `package exchange;`
  /// (imported via `github.com/lazervault/exchange-service/proto`), so
  /// the wire contract is `/exchange.ExchangeService/*` — matching the
  /// generated `exchange.pbgrpc.dart` stub.
  ///
  /// Override order:
  ///   1. `EXCHANGE_GRPC_PORT` / `EXCHANGE_GRPC_HOST` — dedicated vars,
  ///      preferred when the operator needs to pin exchange to a custom
  ///      endpoint.
  ///   2. `FINANCIAL_GRPC_PORT` / `FINANCIAL_GRPC_HOST` — fallback that
  ///      matches the gateway's main config.
  ///   3. Hard-coded defaults (10.0.2.2:50071).
  static ClientChannel createExchangeChannel() {
    // Exchange shares the financial-gateway port (50071).
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'EXCHANGE_GRPC_HOST',
      legacyPortEnvKey: 'EXCHANGE_GRPC_PORT',
      fallbackPort: 50071,
    );
    print("💱 Creating Exchange Service Channel (via Financial Gateway) → ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Financial Gateway (Exchange)', useTls: ep.useTls);
  }

  /// Creates Business Gateway gRPC channel — business-gateway port 50079.
  static ClientChannel createBusinessChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'BUSINESS_GRPC_HOST',
      legacyPortEnvKey: 'BUSINESS_GRPC_PORT',
      fallbackPort: 50079,
    );
    print("💼 Creating Business Gateway Channel → ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Business Gateway', useTls: ep.useTls);
  }

  /// Creates Chat Proxy Gateway gRPC channel — chat-proxy-gateway port 50074.
  static ClientChannel createChatProxyChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'CHAT_PROXY_GRPC_HOST',
      legacyPortEnvKey: 'CHAT_PROXY_GRPC_PORT',
      fallbackPort: 50074,
    );
    print("Creating Chat Proxy Gateway Channel -> ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Chat Proxy Gateway', useTls: ep.useTls);
  }

  /// Creates Banking Service gRPC channel — banking-service port 50073.
  static ClientChannel createBankingChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'BANKING_GRPC_HOST',
      legacyPortEnvKey: 'BANKING_GRPC_PORT',
      fallbackPort: 50073,
    );
    print("🏦 Creating Banking Service Channel → ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Banking Service', useTls: ep.useTls);
  }

  /// Creates Voice Biometrics Service gRPC channel — voice-biometrics-service port 50060.
  static ClientChannel createVoiceBiometricsChannel() {
    final ep = _resolveEndpoint(
      legacyHostEnvKey: 'VOICE_BIOMETRICS_HOST',
      legacyPortEnvKey: 'VOICE_BIOMETRICS_PORT',
      fallbackPort: 50060,
    );
    print("🎙️ Creating Voice Biometrics Service Channel → ${ep.host}:${ep.port}");
    return _createChannel(ep.host, ep.port, 'Voice Biometrics Service', useTls: ep.useTls);
  }

  /// Resolves the (host, port, useTls) tuple for any gRPC channel.
  ///
  /// Resolution precedence is intentionally explicit so local-dev override
  /// still works after the migration to the Cloudflare-tunneled
  /// `EndpointRegistry`:
  ///
  ///   1. Legacy per-gateway `dotenv` overrides (e.g. `STOCKS_GRPC_HOST`,
  ///      `TRANSFER_GRPC_HOST`) — when set, take precedence so a developer
  ///      with a `.env` pointing at `10.0.2.2:50076` keeps that workflow.
  ///   2. `EndpointRegistry.grpcBase` — the single tunnel endpoint
  ///      (`api.lazervault.app:443`) Flutter reads on cold start from
  ///      SharedPreferences and refreshes in the background. This is the
  ///      production path; every channel lands on the same host:port and
  ///      cloudflared dispatches to the right backend by gRPC path
  ///      (`/pb.<Service>/<Method>`).
  ///   3. Hard-coded fallback per channel, kept as a third belt for unit
  ///      tests that don't initialise either dotenv or the registry.
  ///
  /// TLS is selected by port: 443 → secure (`ChannelCredentials.secure()`),
  /// anything else → insecure cleartext (matches the old behaviour
  /// against `10.0.2.2:50xxx`).
  static _GrpcEndpoint _resolveEndpoint({
    required String legacyHostEnvKey,
    required String legacyPortEnvKey,
    required int fallbackPort,
  }) {
    String host;
    int port;

    final overrideHost = dotenv.env[legacyHostEnvKey];
    final overridePort = dotenv.env[legacyPortEnvKey];
    if (overrideHost != null && overrideHost.isNotEmpty) {
      // Strip any accidental scheme from the override.
      final parsed = Uri.tryParse(overrideHost);
      host = (parsed != null && parsed.host.isNotEmpty)
          ? parsed.host
          : overrideHost;
      port = int.tryParse(overridePort ?? '') ?? fallbackPort;
    } else {
      // Tunnel path — single endpoint for every channel.
      host = endpointRegistry.grpcHost;
      port = endpointRegistry.grpcPort;
    }
    return _GrpcEndpoint(host: host, port: port, useTls: port == 443);
  }

  /// Internal method to create channel with standard production-grade options
  /// Includes gzip compression for 60-80% payload reduction on low-bandwidth networks
  static ClientChannel _createChannel(String host, int port, String name, {bool useTls = false}) {
    // Self-healing wrapper: swaps in a fresh inner channel whenever the old
    // one wedges in SHUTDOWN (see ResilientClientChannel). The builder below
    // produces the raw channel each time.
    return ResilientClientChannel(
      () => _rawChannel(host, port, useTls: useTls),
      host: host,
      name: name,
    );
  }

  static ClientChannel _rawChannel(String host, int port, {bool useTls = false}) {
    return ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        // Cloudflare-tunneled traffic terminates TLS at the edge; cleartext
        // h2c is used for origin (cloudflared handles HTTP/2 negotiation),
        // so client-side TLS is mandatory only when we hit port 443. The
        // useTls flag keeps the local-dev cleartext path untouched.
        credentials: useTls
            ? const ChannelCredentials.secure()
            : const ChannelCredentials.insecure(),
        codecRegistry: CodecRegistry(codecs: const [GzipCodec()]), // Enable gzip compression
        keepAlive: const ClientKeepAliveOptions(
          pingInterval: Duration(seconds: 30), // Keep connection alive
          timeout: Duration(seconds: 10), // Ping timeout
          permitWithoutCalls: true, // Allow pings even when idle
        ),
        connectionTimeout: const Duration(seconds: 10), // Connection establishment timeout
        // Long idleTimeout: the channel is registered as a GetIt singleton,
        // so once it transitions to SHUTDOWN it cannot recover and every
        // subsequent RPC fails with "Connection shutting down" until the
        // app is restarted. The keepalive PING/TIMEOUT pair already detects
        // dead connections; idleTimeout was redundant and actively harmful.
        // We keep a 24h cap as a defensive ceiling rather than disabling it.
        idleTimeout: const Duration(hours: 24),
      ),
    );
  }

  /// Closes all channels gracefully
  static Future<void> closeAllChannels(
    ClientChannel coreChannel,
    ClientChannel investmentChannel,
    ClientChannel commerceChannel, {
    ClientChannel? financialChannel,
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
    if (financialChannel != null) {
      futures.add(financialChannel.shutdown());
    }
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

/// Resolved gRPC endpoint tuple — the host/port the channel will dial,
/// plus whether TLS should be negotiated. Used internally by
/// [GrpcChannelFactory._resolveEndpoint] so every channel can pick up
/// the live admin-managed URL via [EndpointRegistry] while still
/// honouring per-channel dotenv overrides for local dev.
class _GrpcEndpoint {
  const _GrpcEndpoint({required this.host, required this.port, required this.useTls});
  final String host;
  final int port;
  final bool useTls;
}
