import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/payments.pbgrpc.dart';
import '../../domain/entities/account_verification_result.dart';
import 'recipient_verification_remote_datasource.dart';

/// gRPC-based data source for recipient account verification.
///
/// Uses PaymentsService.VerifyBankAccount to verify bank accounts via Paystack.
class RecipientVerificationGrpcDataSource
    implements RecipientVerificationRemoteDataSource {
  final PaymentsServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  RecipientVerificationGrpcDataSource({
    required PaymentsServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<AccountVerificationResult> verifyAccount({
    required String bankCode,
    required String accountNumber,
    String country = 'NG',
  }) async {
    try {
      final request = VerifyBankAccountRequest(
        bankCode: bankCode,
        accountNumber: accountNumber,
        country: country,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.verifyBankAccount(
        request,
        options: callOptions,
      );

      if (response.success) {
        return AccountVerificationResult(
          accountNumber: response.accountNumber,
          accountName: response.accountName,
          bankName: response.bankName,
          bankCode: response.bankCode,
          verificationStatus: response.verificationStatus.isNotEmpty
              ? response.verificationStatus
              : 'verified',
        );
      } else {
        // Handle error responses
        final errorCode = response.errorCode;
        final userMessage = response.userMessage.isNotEmpty
            ? response.userMessage
            : response.errorMessage;

        if (errorCode == 'ACCOUNT_NOT_FOUND' || errorCode == 'NOT_FOUND') {
          throw AccountNotFoundException(
            userMessage.isNotEmpty
                ? userMessage
                : 'Account not found. Please check the account number.',
          );
        } else if (errorCode == 'RATE_LIMIT' || errorCode == 'RATE_LIMIT_EXCEEDED') {
          throw RateLimitException(
            userMessage.isNotEmpty
                ? userMessage
                : 'Too many attempts. Please wait a minute.',
          );
        } else {
          throw VerificationException(
            userMessage.isNotEmpty ? userMessage : 'Verification failed',
            errorCode.isNotEmpty ? errorCode : 'VERIFICATION_FAILED',
          );
        }
      }
    } on GrpcError catch (e) {
      // Handle gRPC-specific errors
      switch (e.code) {
        case StatusCode.unavailable:
        case StatusCode.deadlineExceeded:
          throw NetworkException(
            'Connection timeout. Please check your internet and try again.',
          );
        case StatusCode.notFound:
          throw AccountNotFoundException(
            'Account not found. Please verify the account details.',
          );
        case StatusCode.resourceExhausted:
          throw RateLimitException(
            'Too many requests. Please wait a moment and try again.',
          );
        case StatusCode.unauthenticated:
          throw VerificationException(
            'Session expired. Please log in again.',
            'UNAUTHENTICATED',
          );
        case StatusCode.permissionDenied:
          throw VerificationException(
            'Permission denied. Please try again.',
            'PERMISSION_DENIED',
          );
        case StatusCode.invalidArgument:
          throw VerificationException(
            e.message ?? 'Invalid account details provided.',
            'INVALID_ARGUMENT',
          );
        default:
          throw VerificationException(
            e.message ?? 'Verification failed. Please try again.',
            'GRPC_ERROR_${e.code}',
          );
      }
    } catch (e) {
      // Re-throw our custom exceptions
      if (e is AccountNotFoundException ||
          e is RateLimitException ||
          e is VerificationException ||
          e is NetworkException) {
        rethrow;
      }
      throw VerificationException('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<List<Map<String, String>>> getSupportedBanks({
    String country = 'NG',
  }) async {
    // Nigerian banks with Paystack codes - hardcoded for now
    // TODO: Add gRPC endpoint for dynamic bank list if needed
    return [
      {"name": "Access Bank", "code": "044"},
      {"name": "Citibank", "code": "023"},
      {"name": "Ecobank Nigeria", "code": "050"},
      {"name": "Fidelity Bank", "code": "070"},
      {"name": "First Bank of Nigeria", "code": "011"},
      {"name": "First City Monument Bank", "code": "214"},
      {"name": "Globus Bank", "code": "00103"},
      {"name": "Guaranty Trust Bank", "code": "058"},
      {"name": "Heritage Bank", "code": "030"},
      {"name": "Keystone Bank", "code": "082"},
      {"name": "Polaris Bank", "code": "076"},
      {"name": "Providus Bank", "code": "101"},
      {"name": "Stanbic IBTC Bank", "code": "221"},
      {"name": "Standard Chartered Bank", "code": "068"},
      {"name": "Sterling Bank", "code": "232"},
      {"name": "Suntrust Bank", "code": "100"},
      {"name": "Union Bank of Nigeria", "code": "032"},
      {"name": "United Bank for Africa", "code": "033"},
      {"name": "Unity Bank", "code": "215"},
      {"name": "Wema Bank", "code": "035"},
      {"name": "Zenith Bank", "code": "057"},
      {"name": "Opay", "code": "999992"},
      {"name": "Kuda Bank", "code": "50211"},
      {"name": "Palmpay", "code": "999991"},
      {"name": "Moniepoint MFB", "code": "50515"},
    ];
  }

  @override
  void dispose() {
    // gRPC client cleanup is handled by the channel manager
  }
}
