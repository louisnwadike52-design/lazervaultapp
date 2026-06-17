import 'package:dartz/dartz.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/card_settings/data/models/account_details_model.dart';
import 'package:lazervault/src/features/card_settings/domain/entities/account_details_entity.dart';
import 'package:lazervault/src/features/card_settings/domain/repositories/i_card_settings_repository.dart';
import 'package:lazervault/src/generated/account.pbgrpc.dart';
import 'package:lazervault/src/generated/account.pb.dart' as req_resp;

class CardSettingsRepositoryImpl implements ICardSettingsRepository {
  final AccountServiceClient _accountServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  CardSettingsRepositoryImpl(
    this._accountServiceClient,
    this._callOptionsHelper,
  );

  @override
  Future<Either<Failure, AccountDetailsEntity>> getAccountDetails({
    required String accountId,
    String? accessToken,
  }) async {
    try {
      // Use executeWithTokenRotation for automatic token refresh on auth errors
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = req_resp.GetAccountDetailsRequest(
          accountId: Int64.parseInt(accountId),
        );

        print('Sending gRPC GetAccountDetails Request for account: $accountId');

        // Use helper to get call options with authorization header from secure storage
        final callOptions = await _callOptionsHelper.withAuth();

        return await _accountServiceClient.getAccountDetails(
          request,
          options: callOptions,
        );
      });

      print('gRPC GetAccountDetails Response received');

      final accountDetails = AccountDetailsModel.fromProto(response.account);

      return Right(accountDetails);
    } on GrpcError catch (e) {
      print('gRPC Error during GetAccountDetails: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to fetch account details.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during getAccountDetails: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while fetching account details.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, AccountDetailsEntity>> updateSecuritySettings({
    required String accountId,
    required bool enable3dSecure,
    required bool enableContactless,
    required bool enableOnlinePayments,
    String? accessToken,
  }) async {
    try {
      // Use executeWithTokenRotation for automatic token refresh on auth errors
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final securitySettings = AccountDetailsModel.toProtoSecuritySettings(
          enable3dSecure: enable3dSecure,
          enableContactless: enableContactless,
          enableOnlinePayments: enableOnlinePayments,
        );

        final request = req_resp.UpdateSecuritySettingsRequest(
          accountId: Int64.parseInt(accountId),
          settings: securitySettings,
        );

        print('Sending gRPC UpdateSecuritySettings Request for account: $accountId');
        print('Security Settings: 3DS=$enable3dSecure, Contactless=$enableContactless, Online=$enableOnlinePayments');

        // Use helper to get call options with authorization header from secure storage
        final callOptions = await _callOptionsHelper.withAuth();

        return await _accountServiceClient.updateSecuritySettings(
          request,
          options: callOptions,
        );
      });

      print('gRPC UpdateSecuritySettings Response received');

      final accountDetails = AccountDetailsModel.fromProto(response.account);

      return Right(accountDetails);
    } on GrpcError catch (e) {
      print('gRPC Error during UpdateSecuritySettings: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to update security settings.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during updateSecuritySettings: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while updating security settings.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, AccountDetailsEntity>> updateAccountStatus({
    required String accountId,
    required String status,
    required String reason,
    String? accessToken,
  }) async {
    try {
      // Use executeWithTokenRotation for automatic token refresh on auth errors
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = req_resp.UpdateAccountStatusRequest(
          accountId: Int64.parseInt(accountId),
          status: status,
          reason: reason,
        );

        print('Sending gRPC UpdateAccountStatus Request for account: $accountId');
        print('Status: $status, Reason: $reason');

        // Use helper to get call options with authorization header from secure storage
        final callOptions = await _callOptionsHelper.withAuth();

        return await _accountServiceClient.updateAccountStatus(
          request,
          options: callOptions,
        );
      });

      print('gRPC UpdateAccountStatus Response received');

      final accountDetails = AccountDetailsModel.fromProto(response.account);

      return Right(accountDetails);
    } on GrpcError catch (e) {
      print('gRPC Error during UpdateAccountStatus: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: e.message ?? 'Failed to update account status.',
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during updateAccountStatus: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while updating account status.',
        statusCode: 500,
      ));
    }
  }
}
