import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/features/funds/data/models/withdrawal_model.dart';
import 'package:lazervault/src/features/funds/domain/entities/withdrawal_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_withdrawal_repository.dart';
import 'package:lazervault/src/generated/withdraw.pb.dart' as req_resp;
import 'package:lazervault/src/generated/withdraw.pbgrpc.dart';

class WithdrawalRepositoryImpl implements IWithdrawalRepository {
  final WithdrawServiceClient _withdrawServiceClient;

  WithdrawalRepositoryImpl(this._withdrawServiceClient);

  @override
  Future<Either<Failure, WithdrawalDetails>> initiateWithdrawal({
    required int sourceAccountId,
    required double amount,
    required String currency,
    required String targetBankName,
    required String targetAccountNumber,
    String? targetSortCode,
    String? accessToken,
  }) async {
    try {
      final amountMinorUnits = Int64((amount * 100).round());

      print('WithdrawalRepository: Preparing request with sourceAccountId: $sourceAccountId, amount: $amount, currency: $currency, targetBankName: $targetBankName');
      
      final request = req_resp.InitiateWithdrawalRequest(
        sourceAccountId: Int64(sourceAccountId),
        amount: amountMinorUnits,
        currency: currency,
        targetBankName: targetBankName,
        targetAccountNumber: targetAccountNumber,
        targetSortCode: targetSortCode,
      );

      CallOptions? callOptions;
      if (accessToken != null && accessToken.isNotEmpty) {
        callOptions = CallOptions(
          metadata: {
            'authorization': 'Bearer $accessToken',
          },
        );
        print('WithdrawalRepository: Using authorization token for withdrawal request: ${accessToken.substring(0, 10)}...');
      } else {
        print('WithdrawalRepository: WARNING - No authorization token provided for withdrawal request');
      }

      print('WithdrawalRepository: Sending gRPC InitiateWithdrawal Request: $request');
      
      final response = callOptions != null
          ? await _withdrawServiceClient.initiateWithdrawal(request, options: callOptions)
          : await _withdrawServiceClient.initiateWithdrawal(request);

      print('WithdrawalRepository: gRPC InitiateWithdrawal Response received: ${response.message} with status ${response.status.name}, withdrawalId: ${response.withdrawalId}');

      final withdrawalModel = WithdrawalModel.fromProto(response);
      print('WithdrawalRepository: Successfully created WithdrawalModel from response');

      return Right(withdrawalModel);
    } catch (e) {
      print('WithdrawalRepository: Error during initiateWithdrawal: $e');
      
      if (e is GrpcError) {
        return Left(
          ServerFailure(
            message: e.message ?? 'An unexpected gRPC error occurred',
            statusCode: e.code,
          ),
        );
      }
      
      return Left(
        ServerFailure(
          message: 'An unexpected error occurred: $e',
          statusCode: StatusCode.unknown,
        ),
      );
    }
  }
} 