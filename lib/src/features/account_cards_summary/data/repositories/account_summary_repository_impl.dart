import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/account_cards_summary/data/models/account_summary_model.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/repositories/i_account_summary_repository.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as req_resp;


class AccountSummaryRepositoryImpl implements IAccountSummaryRepository {
  final AccountsServiceClient _accountsServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  AccountSummaryRepositoryImpl(
    this._accountsServiceClient,
    this._callOptionsHelper,
  );

  @override
  Future<Either<Failure, List<AccountSummaryEntity>>> getAccountSummaries({
    required String userId,
    String? accessToken,
    String? country,
  }) async {
    try {
      // Use executeWithTokenRotation for automatic token refresh on auth errors
      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = req_resp.GetUserAccountsRequest();

        print('Sending gRPC GetUserAccounts Request for user: $userId${country != null ? ', country: $country' : ''}');

        // Use helper to get call options with authorization header from secure storage
        CallOptions callOptions = await _callOptionsHelper.withAuth();

        // Add country code to metadata if provided
        if (country != null && country.isNotEmpty) {
          final metadata = Map<String, String>.from(callOptions.metadata ?? {});
          metadata['x-country-code'] = country;

          callOptions = CallOptions(
            metadata: metadata,
            timeout: callOptions.timeout,
          );
        }

        return await _accountsServiceClient.getUserAccounts(
          request,
          options: callOptions,
        );
      });

      print('gRPC GetUserAccounts Response received with ${response.accounts.length} items');

      final accountSummaries = response.accounts
          .map((proto) => AccountSummaryModel.fromProto(proto))
          .toList();

      // Sort accounts in the desired order: Personal > Investment > Savings > Family & Friends > Others
      final sortedSummaries = _sortAccountSummaries(accountSummaries);

      return Right(sortedSummaries);
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

  /// Sort account summaries in the desired order:
  /// 1. Personal
  /// 2. Investment
  /// 3. Savings
  /// 4. Family & Friends
  /// 5. Others (main, business, usd, gbp, eur) in their original order
  List<AccountSummaryEntity> _sortAccountSummaries(List<AccountSummaryEntity> summaries) {
    // Define the priority order for account types
    const priorityOrder = {
      'Personal': 0,
      'Investment': 1,
      'Savings': 2,
      'Family & Friends': 3,
      'Family': 3, // Handle alternative naming
    };

    final sortedList = List<AccountSummaryEntity>.from(summaries);
    sortedList.sort((a, b) {
      final aTypeLower = a.accountType.toLowerCase();
      final bTypeLower = b.accountType.toLowerCase();

      // Check if account types are in our priority list
      int? aPriority;
      int? bPriority;

      for (final entry in priorityOrder.entries) {
        if (aTypeLower.contains(entry.key.toLowerCase())) {
          aPriority = entry.value;
        }
        if (bTypeLower.contains(entry.key.toLowerCase())) {
          bPriority = entry.value;
        }
      }

      // If both have priorities, sort by priority
      if (aPriority != null && bPriority != null) {
        return aPriority.compareTo(bPriority);
      }
      // If only a has priority, it comes first
      if (aPriority != null) return -1;
      // If only b has priority, it comes first
      if (bPriority != null) return 1;

      // Neither has priority, maintain original order (stable sort)
      return 0;
    });

    return sortedList;
  }
} 