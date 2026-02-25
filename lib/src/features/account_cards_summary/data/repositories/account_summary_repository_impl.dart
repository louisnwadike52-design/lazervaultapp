import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/features/account_cards_summary/data/models/account_summary_model.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/repositories/i_account_summary_repository.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as req_resp;
import 'package:lazervault/src/generated/family_accounts.pbgrpc.dart' as family_pb;


class AccountSummaryRepositoryImpl implements IAccountSummaryRepository {
  final AccountsServiceClient _accountsServiceClient;
  final family_pb.FamilyAccountsServiceClient _familyAccountsClient;
  final GrpcCallOptionsHelper _callOptionsHelper;

  AccountSummaryRepositoryImpl(
    this._accountsServiceClient,
    this._familyAccountsClient,
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
          final metadata = Map<String, String>.from(callOptions.metadata);
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

      final List<AccountSummaryEntity> allAccounts = response.accounts
          .map((proto) => AccountSummaryModel.fromProto(proto) as AccountSummaryEntity)
          .toList();

      // Separate generic family accounts (from regular accounts) from non-family accounts
      final genericFamilyAccounts = allAccounts
          .where((a) => a.accountTypeEnum == VirtualAccountType.family)
          .toList();
      final accountSummaries = allAccounts
          .where((a) => a.accountTypeEnum != VirtualAccountType.family)
          .toList();

      // Fetch proper family accounts (with familyStatus, memberCount, etc.)
      final familyAccounts = await _fetchFamilyAccounts();

      if (familyAccounts.isNotEmpty) {
        // Enrich proper family accounts with virtual account number from generic ones
        if (genericFamilyAccounts.isNotEmpty) {
          final generic = genericFamilyAccounts.first;
          final enriched = familyAccounts.map((fa) {
            final last4 = fa.accountNumberLast4 == '••••'
                ? generic.accountNumberLast4
                : fa.accountNumberLast4;
            return fa.copyWith(
              accountNumber: generic.accountNumber,
              accountNumberLast4: last4,
              bankName: generic.bankName,
              accountName: generic.accountName,
            );
          }).toList();
          accountSummaries.addAll(enriched);
        } else {
          accountSummaries.addAll(familyAccounts);
        }
      } else if (genericFamilyAccounts.isNotEmpty) {
        // No proper family accounts returned (error fallback) — convert generic
        // accounts into family entities so they show "Setup" instead of "Details".
        // familyAccountId is null because g.id is the virtual bank account UUID,
        // NOT the family_accounts table ID. The carousel will resolve the real ID
        // via GetFamilyAccounts when the user taps Setup.
        // Note: familyAccountId is intentionally NOT set here — g.familyAccountId
        // is already null (generic accounts never have it). The carousel resolves
        // the real family ID via GetFamilyAccounts when the user taps Setup.
        final converted = genericFamilyAccounts.map((g) => g.copyWith(
          isFamilyAccount: true,
          familyStatus: 'pending_setup',
        )).toList();
        accountSummaries.addAll(converted);
      }

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

  /// Fetch family accounts and convert them to AccountSummaryEntity objects.
  /// Returns empty list on error (family accounts are supplementary, shouldn't block dashboard).
  Future<List<AccountSummaryEntity>> _fetchFamilyAccounts() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = family_pb.GetFamilyAccountsRequest();
      final response = await _familyAccountsClient.getFamilyAccounts(
        request,
        options: callOptions,
      );

      print('gRPC GetFamilyAccounts Response received with ${response.familyAccounts.length} items');

      return response.familyAccounts.map((proto) {
        final status = proto.status.isNotEmpty ? proto.status : 'active';
        return AccountSummaryEntity.familyAccount(
          id: proto.id,
          currency: 'USD', // Family accounts use the initial currency
          totalBalance: proto.totalBalance,
          memberAllocatedBalance: proto.totalAllocatedBalance,
          memberRemainingBalance: proto.totalPoolBalance,
          memberCount: proto.memberCount,
          allowMemberContributions: proto.allowMemberContributions,
          trendPercentage: 0.0,
          familyAccountId: proto.id,
          familyStatus: status,
          fundDistributionMode: _mapDistributionMode(proto.fundDistributionMode),
        );
      }).toList();
    } catch (e) {
      print('Error fetching family accounts for carousel: $e');
      return [];
    }
  }

  String _mapDistributionMode(family_pb.FundDistributionMode mode) {
    switch (mode) {
      case family_pb.FundDistributionMode.SHARED_POOL:
        return 'shared_pool';
      case family_pb.FundDistributionMode.EQUAL_SPLIT:
        return 'equal_split';
      case family_pb.FundDistributionMode.CUSTOM_ALLOCATION:
        return 'custom_allocation';
      default:
        return 'custom_allocation';
    }
  }

  /// Sort account summaries in the desired order:
  /// 1. Personal
  /// 2. Investment
  /// 3. Savings
  /// 4. Others (main, business, usd, gbp, eur) in their original order
  List<AccountSummaryEntity> _sortAccountSummaries(List<AccountSummaryEntity> summaries) {
    // Define the priority order for account types
    const priorityOrder = {
      'Personal': 0,
      'Investment': 1,
      'Savings': 2,
      'Family': 3,
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