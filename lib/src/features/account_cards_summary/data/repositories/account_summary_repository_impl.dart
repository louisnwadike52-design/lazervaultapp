import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/account_cards_summary/data/models/account_summary_model.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/repositories/i_account_summary_repository.dart';
import 'package:lazervault/src/generated/account.pbgrpc.dart';
import 'package:lazervault/src/generated/account.pb.dart' as req_resp;


class AccountSummaryRepositoryImpl implements IAccountSummaryRepository {
  final AccountServiceClient _accountServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  AccountSummaryRepositoryImpl(
    this._accountServiceClient,
    this._callOptionsHelper,
  );

  @override
  Future<Either<Failure, List<AccountSummaryEntity>>> getAccountSummaries({
    required String userId,
    String? accessToken,
  }) async {
    try {
      final request = req_resp.GetUserAccountsRequest();
      print('Sending gRPC GetUserAccounts Request for user: $userId');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _accountServiceClient.getUserAccounts(
        request,
        options: callOptions,
      );

      print('gRPC GetUserAccounts Response received with ${response.accounts.length} items');

      final accountSummaries = response.accounts
          .map((proto) => AccountSummaryModel.fromProto(proto))
          .toList();

      return Right(accountSummaries);
    } on GrpcError catch (e) {
      print('gRPC Error during GetUserAccounts: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to fetch account summaries.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during getAccountSummaries: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while fetching account summaries.',
        statusCode: 500,
      ));
    }
  }
} 