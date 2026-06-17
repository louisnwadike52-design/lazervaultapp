# Flutter gRPC Integration Guide

## Overview
This guide provides step-by-step instructions to integrate the Flutter frontend with the Go backend via gRPC for invoice and payment functionality.

## Current Status
- ✅ Backend gRPC services fully implemented and tested
- ✅ Payment processing with account balance complete
- ✅ Invoice creation and management ready
- ❌ Flutter currently uses local Hive storage (offline mode)
- ❌ No gRPC client integration yet

## Prerequisites

### 1. Install Protocol Buffer Compiler
```bash
# macOS
brew install protobuf

# Verify installation
protoc --version
```

### 2. Install Dart Protobuf Plugin
```bash
flutter pub global activate protoc_plugin
export PATH="$PATH:$HOME/.pub-cache/bin"
```

### 3. Add Dependencies to pubspec.yaml
```yaml
dependencies:
  grpc: ^3.2.4
  protobuf: ^3.1.0
```

## Step 1: Generate Dart gRPC Client Code

### Create proto generation script
Create `scripts/generate_proto.sh`:

```bash
#!/bin/bash

# Navigate to project root
cd "$(dirname "$0")/.."

# Create output directory
mkdir -p lib/src/grpc_generated

# Generate Dart code from protobuf definitions
protoc --dart_out=grpc:lib/src/grpc_generated \
  -I../lazervault-golang/pb \
  ../lazervault-golang/pb/invoice.proto \
  ../lazervault-golang/pb/invoice_payment.proto \
  ../lazervault-golang/pb/rpc_create_invoice.proto \
  ../lazervault-golang/pb/rpc_send_invoice.proto \
  ../lazervault-golang/pb/rpc_list_invoices.proto \
  ../lazervault-golang/pb/rpc_get_invoice.proto

echo "✅ Proto files generated successfully!"
```

Make it executable and run:
```bash
chmod +x scripts/generate_proto.sh
./scripts/generate_proto.sh
```

## Step 2: Create gRPC Client Wrapper

Create `lib/src/core/network/grpc_client.dart`:

```dart
import 'package:grpc/grpc.dart';
import 'package:lazervaultapp/src/grpc_generated/invoice.pbgrpc.dart';
import 'package:lazervaultapp/src/grpc_generated/invoice_payment.pbgrpc.dart';

class GrpcClient {
  static const String _host = 'localhost'; // Update for production
  static const int _port = 9090;

  late ClientChannel _channel;
  late InvoiceServiceClient _invoiceClient;
  late InvoicePaymentServiceClient _paymentClient;

  String? _authToken;

  GrpcClient();

  Future<void> initialize({String? authToken}) async {
    _authToken = authToken;

    _channel = ClientChannel(
      _host,
      port: _port,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(),
        connectionTimeout: const Duration(seconds: 10),
      ),
    );

    _invoiceClient = InvoiceServiceClient(_channel);
    _paymentClient = InvoicePaymentServiceClient(_channel);
  }

  InvoiceServiceClient get invoiceClient => _invoiceClient;
  InvoicePaymentServiceClient get paymentClient => _paymentClient;

  CallOptions get _callOptions {
    final metadata = <String, String>{};
    if (_authToken != null) {
      metadata['authorization'] = 'Bearer $_authToken';
    }
    return CallOptions(metadata: metadata);
  }

  CallOptions get callOptions => _callOptions;

  Future<void> dispose() async {
    await _channel.shutdown();
  }

  void updateAuthToken(String token) {
    _authToken = token;
  }
}
```

## Step 3: Create Error Handling

Create `lib/src/core/errors/grpc_exceptions.dart`:

```dart
import 'package:grpc/grpc.dart';

class GrpcException implements Exception {
  final String message;
  final StatusCode? code;

  GrpcException(this.message, [this.code]);

  @override
  String toString() => message;
}

class NotFoundException extends GrpcException {
  NotFoundException(String message) : super(message, StatusCode.notFound);
}

class UnauthorizedException extends GrpcException {
  UnauthorizedException() : super('Unauthorized', StatusCode.unauthenticated);
}

class InsufficientFundsException extends GrpcException {
  InsufficientFundsException(String message) : super(message, StatusCode.failedPrecondition);
}

class NetworkException extends GrpcException {
  NetworkException(String message) : super(message, StatusCode.unavailable);
}

class ServerException extends GrpcException {
  ServerException(String message) : super(message, StatusCode.internal);
}

Exception mapGrpcError(GrpcError error) {
  switch (error.code) {
    case StatusCode.notFound:
      return NotFoundException(error.message ?? 'Resource not found');
    case StatusCode.unauthenticated:
      return UnauthorizedException();
    case StatusCode.permissionDenied:
      return GrpcException('Access denied', StatusCode.permissionDenied);
    case StatusCode.failedPrecondition:
      if (error.message?.contains('insufficient funds') ?? false) {
        return InsufficientFundsException(error.message!);
      }
      return GrpcException(error.message ?? 'Precondition failed', error.code);
    case StatusCode.unavailable:
      return NetworkException('Service unavailable. Please check your connection.');
    case StatusCode.deadlineExceeded:
      return NetworkException('Request timed out');
    default:
      return ServerException(error.message ?? 'An unexpected error occurred');
  }
}
```

## Step 4: Create Retry Logic with Exponential Backoff

Create `lib/src/core/network/retry_helper.dart`:

```dart
import 'package:grpc/grpc.dart';
import '../errors/grpc_exceptions.dart';

Future<T> retryWithBackoff<T>({
  required Future<T> Function() operation,
  int maxRetries = 3,
  Duration initialDelay = const Duration(seconds: 1),
  double backoffMultiplier = 2.0,
}) async {
  int retries = 0;
  Duration delay = initialDelay;

  while (true) {
    try {
      return await operation();
    } on GrpcError catch (e) {
      if (retries >= maxRetries || !_isRetryable(e)) {
        throw mapGrpcError(e);
      }

      print('Retry attempt ${retries + 1}/$maxRetries after ${delay.inSeconds}s delay');
      await Future.delayed(delay);

      delay = Duration(milliseconds: (delay.inMilliseconds * backoffMultiplier).toInt());
      retries++;
    }
  }
}

bool _isRetryable(GrpcError error) {
  return error.code == StatusCode.unavailable ||
         error.code == StatusCode.deadlineExceeded ||
         error.code == StatusCode.resourceExhausted;
}
```

## Step 5: Update Invoice Repository Implementation

Replace `lib/src/features/invoice/data/repositories/invoice_repository_impl.dart`:

```dart
import 'package:lazervaultapp/src/core/network/grpc_client.dart';
import 'package:lazervaultapp/src/core/network/retry_helper.dart';
import 'package:lazervaultapp/src/grpc_generated/invoice.pb.dart';
import 'package:lazervaultapp/src/grpc_generated/rpc_create_invoice.pb.dart';
import 'package:lazervaultapp/src/grpc_generated/rpc_send_invoice.pb.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final GrpcClient grpcClient;

  InvoiceRepositoryImpl({required this.grpcClient});

  @override
  Future<List<Invoice>> getAllInvoices() async {
    return retryWithBackoff(
      operation: () async {
        final request = ListInvoicesRequest()
          ..pageSize = 100;

        final response = await grpcClient.invoiceClient.listInvoices(
          request,
          options: grpcClient.callOptions,
        );

        return response.invoices.map((inv) => _fromProto(inv)).toList();
      },
    );
  }

  @override
  Future<Invoice?> getInvoiceById(String id) async {
    return retryWithBackoff(
      operation: () async {
        final request = GetInvoiceRequest()..invoiceId = id;

        final response = await grpcClient.invoiceClient.getInvoice(
          request,
          options: grpcClient.callOptions,
        );

        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<Invoice> createInvoice(Invoice invoice) async {
    return retryWithBackoff(
      operation: () async {
        final request = CreateInvoiceRequest()
          ..invoice = _toProto(invoice);

        final response = await grpcClient.invoiceClient.createInvoice(
          request,
          options: grpcClient.callOptions,
        );

        return _fromProto(response.invoice);
      },
    );
  }

  @override
  Future<Invoice> sendInvoice(String invoiceId) async {
    return retryWithBackoff(
      operation: () async {
        final request = SendInvoiceRequest()..invoiceId = invoiceId;

        final response = await grpcClient.invoiceClient.sendInvoice(
          request,
          options: grpcClient.callOptions,
        );

        return _fromProto(response.invoice);
      },
    );
  }

  // Helper: Convert protobuf to entity
  Invoice _fromProto(InvoiceProto proto) {
    return Invoice(
      id: proto.id,
      userId: proto.userId,
      recipientId: proto.recipientId,
      title: proto.title,
      description: proto.description,
      amount: proto.amount,
      currency: proto.currency,
      dueDate: DateTime.parse(proto.dueDate),
      isPaid: proto.isPaid,
      status: _mapStatus(proto.status),
      createdAt: DateTime.parse(proto.createdAt),
    );
  }

  // Helper: Convert entity to protobuf
  InvoiceProto _toProto(Invoice invoice) {
    return InvoiceProto()
      ..id = invoice.id ?? ''
      ..userId = invoice.userId
      ..recipientId = invoice.recipientId
      ..title = invoice.title
      ..description = invoice.description
      ..amount = invoice.amount
      ..currency = invoice.currency
      ..dueDate = invoice.dueDate.toIso8601String()
      ..isPaid = invoice.isPaid;
  }

  InvoiceStatus _mapStatus(String status) {
    // Map protobuf status to domain status
    switch (status.toLowerCase()) {
      case 'pending':
        return InvoiceStatus.pending;
      case 'paid':
        return InvoiceStatus.paid;
      case 'cancelled':
        return InvoiceStatus.cancelled;
      default:
        return InvoiceStatus.pending;
    }
  }
}
```

## Step 6: Update Payment Repository Implementation

Replace `lib/src/features/pay_invoice/data/repositories/pay_invoice_repository_impl.dart`:

```dart
import 'package:lazervaultapp/src/core/network/grpc_client.dart';
import 'package:lazervaultapp/src/core/network/retry_helper.dart';
import 'package:lazervaultapp/src/grpc_generated/invoice_payment.pb.dart';
import '../../domain/entities/payment_result.dart';
import '../../domain/repositories/pay_invoice_repository.dart';

class PayInvoiceRepositoryImpl implements PayInvoiceRepository {
  final GrpcClient grpcClient;

  PayInvoiceRepositoryImpl({required this.grpcClient});

  @override
  Future<PaymentResult> processPayment({
    required String invoiceId,
    required String paymentMethodId,
    required double amount,
    required String currency,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = ProcessInvoicePaymentRequest()
          ..invoiceId = invoiceId
          ..paymentMethodId = paymentMethodId
          ..amount = amount
          ..currency = currency;

        final response = await grpcClient.paymentClient.processInvoicePayment(
          request,
          options: grpcClient.callOptions,
        );

        return PaymentResult(
          success: response.success,
          transactionId: response.result.transactionId,
          confirmationCode: response.result.confirmationCode,
          message: response.message,
        );
      },
      maxRetries: 2, // Lower retries for payment to avoid duplicate charges
    );
  }

  @override
  Future<List<UserAccount>> getUserAccounts() async {
    return retryWithBackoff(
      operation: () async {
        final request = GetUserAccountBalanceRequest();

        final response = await grpcClient.paymentClient.getUserAccountBalance(
          request,
          options: grpcClient.callOptions,
        );

        return response.accounts.map((account) => UserAccount(
          accountNumber: account.accountNumber,
          accountName: account.accountName,
          currency: account.currency,
          availableBalance: account.availableBalance,
        )).toList();
      },
    );
  }

  @override
  Future<ValidationResult> validatePayment({
    required String invoiceId,
    required String paymentMethodId,
    required double amount,
  }) async {
    return retryWithBackoff(
      operation: () async {
        final request = ValidateInvoicePaymentRequest()
          ..invoiceId = invoiceId
          ..paymentMethodId = paymentMethodId
          ..amount = amount;

        final response = await grpcClient.paymentClient.validateInvoicePayment(
          request,
          options: grpcClient.callOptions,
        );

        return ValidationResult(
          isValid: response.isValid,
          errors: response.errors,
          availableBalance: response.availableBalance,
          paymentFees: response.paymentFees,
        );
      },
    );
  }
}
```

## Step 7: Update Dependency Injection

In `lib/src/core/di/injection_container.dart`:

```dart
import 'package:get_it/get_it.dart';
import 'package:lazervaultapp/src/core/network/grpc_client.dart';
import 'package:lazervaultapp/src/features/invoice/data/repositories/invoice_repository_impl.dart';
import 'package:lazervaultapp/src/features/pay_invoice/data/repositories/pay_invoice_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<GrpcClient>(() => GrpcClient());

  // Initialize gRPC client
  await sl<GrpcClient>().initialize();

  // Repositories
  sl.registerLazySingleton<InvoiceRepository>(
    () => InvoiceRepositoryImpl(grpcClient: sl()),
  );

  sl.registerLazySingleton<PayInvoiceRepository>(
    () => PayInvoiceRepositoryImpl(grpcClient: sl()),
  );
}
```

## Step 8: Handle Authentication Token

Update the authentication service to pass the token to gRPC client:

```dart
class AuthService {
  final GrpcClient grpcClient;

  Future<void> login(String email, String password) async {
    // ... existing login logic

    final token = await getAuthToken();
    grpcClient.updateAuthToken(token);
  }

  Future<void> logout() async {
    grpcClient.updateAuthToken('');
    // ... rest of logout logic
  }
}
```

## Testing

### 1. Backend Testing
```bash
# Start backend
cd lazervault-golang
go run main.go
```

### 2. Frontend Testing
```bash
# In another terminal
cd lazervaultapp
flutter run
```

### 3. Test Flows

#### Create Invoice Flow:
1. Open app → Navigate to Invoices
2. Click "Create Invoice"
3. Fill in recipient, amount, due date
4. Submit → Verify invoice appears in list

#### Send Invoice Flow:
1. Select an invoice
2. Click "Send Invoice"
3. Verify email is sent (check backend logs)
4. Verify invoice status updates

#### Pay Invoice Flow:
1. Open invoice to pay
2. Select payment account
3. Enter amount
4. Click "Pay"
5. Verify success message with confirmation code
6. Verify invoice marked as paid

## Troubleshooting

### Connection Refused
- Ensure backend is running on port 9090
- Check firewall settings
- Update host/port in `grpc_client.dart`

### Authentication Errors
- Verify JWT token is being passed correctly
- Check token expiration
- Ensure authorization header format is correct

### Proto Generation Errors
- Verify protoc is installed: `protoc --version`
- Check proto file paths in generation script
- Ensure dart protoc plugin is in PATH

## Next Steps

1. ✅ Generate proto files
2. ✅ Create gRPC client wrapper
3. ✅ Implement error handling
4. ✅ Update invoice repository
5. ✅ Update payment repository
6. ⏳ Test end-to-end invoice creation
7. ⏳ Test end-to-end payment processing
8. ⏳ Add loading states in UI
9. ⏳ Add proper error displays

## Backend Status: ✅ COMPLETE

- ✅ Invoice creation and management
- ✅ Payment processing with account balance
- ✅ Fee calculation (0.5%)
- ✅ Transaction history
- ✅ Payment validation
- ✅ Partial payments support
- ✅ Email sending (queued via workers)
- ✅ Comprehensive error handling

## Frontend Status: ⏳ IN PROGRESS

- ⏳ gRPC client integration (this guide)
- ❌ End-to-end testing
- ❌ Production deployment configuration
