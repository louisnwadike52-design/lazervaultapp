import 'package:get_it/get_it.dart';
import '../auth/token_manager.dart';
import '../network/grpc_client.dart';
import '../../features/invoice/data/repositories/invoice_repository_grpc_impl.dart';
import '../../features/invoice/domain/repositories/invoice_repository.dart';
import '../../features/pay_invoice/data/repositories/pay_invoice_repository_grpc_impl.dart';
import '../../features/pay_invoice/domain/repositories/pay_invoice_repository.dart';
import '../../features/currency_exchange/data/repositories/exchange_repository_impl.dart';
import '../../features/currency_exchange/domain/repositories/i_exchange_repository.dart';

final grpcServiceLocator = GetIt.instance;

/// Initialize gRPC-related dependencies
/// Call this during app initialization after environment is loaded
Future<void> initGrpcDependencies() async {
  // Core services
  if (!grpcServiceLocator.isRegistered<TokenManager>()) {
    grpcServiceLocator.registerLazySingleton<TokenManager>(() => TokenManager());
  }

  if (!grpcServiceLocator.isRegistered<GrpcClient>()) {
    grpcServiceLocator.registerLazySingleton<GrpcClient>(
      () => GrpcClient(),
    );

    // Initialize the gRPC client
    await grpcServiceLocator<GrpcClient>().initialize();
  }

  // Invoice Repository (gRPC implementation)
  if (!grpcServiceLocator.isRegistered<InvoiceRepository>(instanceName: 'grpc')) {
    grpcServiceLocator.registerLazySingleton<InvoiceRepository>(
      () => InvoiceRepositoryGrpcImpl(
        grpcClient: grpcServiceLocator<GrpcClient>(),
        currentUserId: '', // Will be set dynamically
      ),
      instanceName: 'grpc',
    );
  }

  // Payment Repository (gRPC implementation)
  if (!grpcServiceLocator.isRegistered<PayInvoiceRepository>(instanceName: 'grpc')) {
    grpcServiceLocator.registerLazySingleton<PayInvoiceRepository>(
      () {
        // Create invoice repository instance for payment repository
        final invoiceRepo = InvoiceRepositoryGrpcImpl(
          grpcClient: grpcServiceLocator<GrpcClient>(),
          currentUserId: '', // Will be set dynamically
        );
        return PayInvoiceRepositoryGrpcImpl(
          grpcClient: grpcServiceLocator<GrpcClient>(),
          currentUserId: '', // Will be set dynamically
          invoiceRepository: invoiceRepo,
        );
      },
      instanceName: 'grpc',
    );
  }

  // Exchange Repository (gRPC implementation)
  if (!grpcServiceLocator.isRegistered<IExchangeRepository>()) {
    grpcServiceLocator.registerLazySingleton<IExchangeRepository>(
      () => ExchangeRepositoryImpl(
        grpcClient: grpcServiceLocator<GrpcClient>(),
      ),
    );
  }
}

/// Get the current user ID for repository initialization
Future<String> getCurrentUserId() async {
  final grpcClient = grpcServiceLocator<GrpcClient>();
  return await grpcClient.getCurrentUserId() ?? '';
}

/// Create invoice repository with current user ID
Future<InvoiceRepository> createInvoiceRepository() async {
  final userId = await getCurrentUserId();
  return InvoiceRepositoryGrpcImpl(
    grpcClient: grpcServiceLocator<GrpcClient>(),
    currentUserId: userId,
  );
}

/// Create payment repository with current user ID
Future<PayInvoiceRepository> createPaymentRepository() async {
  final userId = await getCurrentUserId();
  final invoiceRepository = await createInvoiceRepository();
  return PayInvoiceRepositoryGrpcImpl(
    grpcClient: grpcServiceLocator<GrpcClient>(),
    currentUserId: userId,
    invoiceRepository: invoiceRepository,
  );
}

/// Get exchange repository
IExchangeRepository getExchangeRepository() {
  return grpcServiceLocator<IExchangeRepository>();
}

/// Dispose gRPC resources
Future<void> disposeGrpcDependencies() async {
  if (grpcServiceLocator.isRegistered<GrpcClient>()) {
    await grpcServiceLocator<GrpcClient>().dispose();
  }
}
