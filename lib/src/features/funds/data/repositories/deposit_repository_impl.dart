import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/funds/data/models/deposit_model.dart';
import 'package:lazervault/src/features/funds/domain/entities/deposit_entity.dart';
import 'package:lazervault/src/features/funds/domain/repositories/i_deposit_repository.dart';
import 'package:lazervault/src/generated/deposit.pb.dart' as req_resp;
import 'package:lazervault/src/generated/deposit.pbgrpc.dart';

class DepositRepositoryImpl implements IDepositRepository {
  final DepositServiceClient _depositServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  DepositRepositoryImpl(
    this._depositServiceClient,
    this._callOptionsHelper,
  );

  @override
  Future<Either<Failure, DepositDetails>> initiateDeposit({
    required String targetAccountId,
    required double amount,
    required String currency,
    required String sourceBankName,
    String? countryCode,
    String? accessToken,
  }) async {
    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final amountMinorUnits = Int64((amount * 100).round());

        final request = req_resp.InitiateDepositRequest(
          targetAccountId: targetAccountId,
          amount: amountMinorUnits,
          currency: currency,
          sourceBankName: sourceBankName,
        );
        if (countryCode != null && countryCode.isNotEmpty) {
          request.countryCode = countryCode;
        }

        final callOptions = await _callOptionsHelper.withAuth();
        return await _depositServiceClient.initiateDeposit(request, options: callOptions);
      });

      final deposit = DepositModel.fromProto(response);
      if (deposit.depositId.isEmpty && !deposit.requiresAuthorization) {
        return Left(ServerFailure(
          message: 'Server returned empty deposit ID.',
          statusCode: 500,
        ));
      }
      return Right(deposit);
    } on GrpcError catch (e) {
      return Left(_mapGrpcError(e, 'Deposit initiation'));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred during deposit initiation.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, DepositDetails>> simulateTestDeposit({
    required String destinationAccountId,
    required double amount,
    required String currency,
    required String countryCode,
  }) async {
    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final amountMinorUnits = Int64((amount * 100).round());

        final request = req_resp.SimulateTestDepositRequest(
          destinationAccountId: destinationAccountId,
          amount: amountMinorUnits,
          currency: currency,
          countryCode: countryCode,
        );

        final callOptions = await _callOptionsHelper.withAuth();
        return await _depositServiceClient.simulateTestDeposit(request, options: callOptions);
      });

      return Right(DepositModel.fromProto(response));
    } on GrpcError catch (e) {
      return Left(_mapGrpcError(e, 'Test deposit simulation'));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred during test deposit simulation.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<DepositMethodInfo>>> getDepositMethods({
    required String countryCode,
    required String currency,
  }) async {
    try {
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = req_resp.GetDepositMethodsRequest(
          countryCode: countryCode,
          currency: currency,
        );

        final callOptions = await _callOptionsHelper.withAuth();
        return await _depositServiceClient.getDepositMethods(request, options: callOptions);
      });

      final methods = response.methods
          .map((m) => DepositMethodModel.fromProto(m))
          .toList();
      return Right(methods);
    } on GrpcError catch (e) {
      return Left(_mapGrpcError(e, 'Fetching deposit methods'));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred while fetching deposit methods.',
        statusCode: 500,
      ));
    }
  }

  ServerFailure _mapGrpcError(GrpcError e, String operation) {
    switch (e.code) {
      case StatusCode.unauthenticated:
        return ServerFailure(
          message: 'Authentication required. Please log in again.',
          statusCode: e.code,
        );
      case StatusCode.permissionDenied:
        return ServerFailure(
          message: 'You do not have permission to perform this action.',
          statusCode: e.code,
        );
      case StatusCode.invalidArgument:
        return ServerFailure(
          message: 'Invalid information provided: ${e.message}',
          statusCode: e.code,
        );
      case StatusCode.notFound:
        return ServerFailure(
          message: 'Account not found. Please check your details.',
          statusCode: e.code,
        );
      default:
        return ServerFailure(
          message: e.message ?? '$operation failed due to server error.',
          statusCode: e.code,
        );
    }
  }
}