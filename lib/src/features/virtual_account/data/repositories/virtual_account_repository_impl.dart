import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/core/grpc/accounts_grpc_client.dart';
import 'package:lazervault/src/features/virtual_account/domain/repositories/i_virtual_account_repository.dart';

/// Implementation of virtual account repository
/// Creates virtual NUBAN accounts via the accounts microservice
class VirtualAccountRepositoryImpl implements IVirtualAccountRepository {
  final AccountsGrpcClient _grpcClient;

  VirtualAccountRepositoryImpl({
    required AccountsGrpcClient grpcClient,
    required GrpcCallOptionsHelper callOptionsHelper,
  }) : _grpcClient = grpcClient; // callOptionsHelper is used by grpcClient internally

  @override
  Future<Either<Failure, VirtualAccountEntity>> createVirtualAccount({
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
    try {
      print('Creating virtual account for $email with BVN: $bvn');

      final response = await _grpcClient.createVirtualAccount(
        accountName: accountName,
        accountType: accountType,
        currency: currency,
        locale: locale,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        bvn: bvn,
        isPrimary: isPrimary,
      );

      print('Virtual account created successfully: ${response.account.accountNumber}');

      return Right(VirtualAccountEntity(
        accountId: response.account.id,
        accountNumber: response.account.accountNumber,
        accountName: response.account.accountName,
        bankCode: response.account.bankCode,
        bankName: response.account.bankName,
        provider: response.provider,
        providerRef: response.account.providerRef,
        currency: response.account.currency,
        message: response.message,
      ));
    } on GrpcError catch (e) {
      print('gRPC Error during virtual account creation: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to create virtual account.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during createVirtualAccount: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while creating virtual account.',
        statusCode: 500,
      ));
    }
  }
}
