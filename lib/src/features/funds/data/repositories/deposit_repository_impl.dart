import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/data/models/deposit_model.dart';
import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_deposit_repository.dart';
import 'package:lazervault/src/generated/deposit.pb.dart' as req_resp;
import 'package:lazervault/src/generated/deposit.pbgrpc.dart';

class DepositRepositoryImpl implements IDepositRepository {
  final DepositServiceClient _depositServiceClient;

  DepositRepositoryImpl(this._depositServiceClient);

  @override
  Future<Either<Failure, DepositDetails>> initiateDeposit({
    required int targetAccountId,
    required double amount,
    required String currency,
    required String sourceBankName,
    String? accessToken,
  }) async {
    try {
      final amountMinorUnits = Int64((amount * 100).round());

      print('DepositRepository: Preparing request with targetAccountId: $targetAccountId, amount: $amount, currency: $currency, sourceBankName: $sourceBankName');
      
      final request = req_resp.InitiateDepositRequest(
        targetAccountId: Int64(targetAccountId),
        amount: amountMinorUnits,
        currency: currency,
        sourceBankName: sourceBankName,
      );

      CallOptions? callOptions;
      if (accessToken != null && accessToken.isNotEmpty) {
        callOptions = CallOptions(
          metadata: {
            'authorization': 'Bearer $accessToken',
          },
        );
        print('DepositRepository: Using authorization token for deposit request: ${accessToken.substring(0, 10)}...');
      } else {
        print('DepositRepository: WARNING - No authorization token provided for deposit request');
      }

      print('DepositRepository: Sending gRPC InitiateDeposit Request: $request');
      
      final response = callOptions != null
          ? await _depositServiceClient.initiateDeposit(request, options: callOptions)
          : await _depositServiceClient.initiateDeposit(request);

      print('DepositRepository: gRPC InitiateDeposit Response received: ${response.message} with status ${response.status.name}, depositId: ${response.depositId}');

      final depositModel = DepositModel.fromProto(response);
      print('DepositRepository: Successfully created DepositModel from response');

      return Right(depositModel);
    } on GrpcError catch (e) {
      print('DepositRepository: gRPC Error during InitiateDeposit: code=${e.code}, codeName=${e.codeName}, message=${e.message}, details=${e.details}');
      
      if (e.code == StatusCode.unauthenticated) {
        return Left(ServerFailure(
          message: 'Authentication required. Please log in again.',
          statusCode: e.code,
        ));
      } else if (e.code == StatusCode.permissionDenied) {
        return Left(ServerFailure(
          message: 'You do not have permission to perform this action.',
          statusCode: e.code,
        ));
      } else if (e.code == StatusCode.invalidArgument) {
        return Left(ServerFailure(
          message: 'Invalid deposit information provided: ${e.message}',
          statusCode: e.code,
        ));
      } else if (e.code == StatusCode.notFound) {
        return Left(ServerFailure(
          message: 'Account not found. Please check your details and try again.',
          statusCode: e.code,
        ));
      } else {
        return Left(ServerFailure(
          message: e.message ?? 'Deposit initiation failed due to server error.',
          statusCode: e.code,
        ));
      }
    } catch (e, stackTrace) {
      print('DepositRepository: Unexpected error during initiateDeposit: $e');
      print('DepositRepository: Stack trace: $stackTrace');
      return Left(ServerFailure(
        message: 'An unexpected error occurred during deposit initiation. Please try again later.',
        statusCode: 500,
      ));
    }
  }
} 