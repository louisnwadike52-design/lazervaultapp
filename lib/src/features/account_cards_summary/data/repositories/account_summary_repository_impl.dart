import 'package:dartz/dartz.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/core/errors/failures.dart'
    show friendlyGrpcError;
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/account_cards_summary/data/models/account_summary_model.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/repositories/i_account_summary_repository.dart';
import 'package:lazervault/src/generated/accounts.pbgrpc.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as req_resp;
import 'package:lazervault/src/generated/family_accounts.pbgrpc.dart'
    as family_pb;

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
    String? period,
  }) async {
    try {
      // Use executeWithTokenRotation for automatic token refresh on auth errors
      final response =
          await _callOptionsHelper.executeWithTokenRotation(() async {
        final request = req_resp.GetUserAccountsRequest();
        // Trend window for the dashboard %-change chip (day/week/month/year).
        if (period != null && period.isNotEmpty) {
          request.period = period;
        }

        print(
            'Sending gRPC GetUserAccounts Request for user: $userId${country != null ? ', country: $country' : ''}');

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

      print(
          'gRPC GetUserAccounts Response received with ${response.accounts.length} items');

      final List<AccountSummaryEntity> allAccounts = response.accounts
          .map((proto) =>
              AccountSummaryModel.fromProto(proto) as AccountSummaryEntity)
          .toList();

      // CLOSED wallets are tombstones, not accounts.
      //
      // Migration 037 retired duplicate wallets by CLOSING them — it cannot
      // delete them, because transactions reference the row — and the carousel
      // was rendering those tombstones beside the live wallet. A user in en-ZA
      // saw "Personal" twice; same for savings, business and investment, and in
      // en-KE too.
      //
      // The server now withholds them; this client-side mirror keeps the
      // carousel clean against an older backend, exactly like the investment
      // sunset below. Same carve-out: a closed wallet still holding money stays
      // visible, because hiding a balance is how it gets forgotten.
      allAccounts.removeWhere(
          (a) => a.isClosed && a.balance == 0 && a.availableBalance == 0);

      // Investment sunset (2026-09-07): the server already withholds EMPTY
      // legacy investment wallets; this client-side mirror keeps the carousel
      // clean even against an older backend. A wallet still holding money is
      // NEVER hidden — it stays visible until the admin sweep moves the funds
      // into Savings.
      allAccounts.removeWhere((a) =>
          a.accountTypeEnum == VirtualAccountType.investment &&
          a.balance == 0 &&
          a.availableBalance == 0);

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
        final converted = genericFamilyAccounts
            .map((g) => g.copyWith(
                  isFamilyAccount: true,
                  familyStatus: 'pending_setup',
                ))
            .toList();
        accountSummaries.addAll(converted);
      }

      // Sort accounts in the desired order: Personal > Investment > Savings > Family & Friends > Others
      final sortedSummaries = _sortAccountSummaries(accountSummaries);

      return Right(sortedSummaries);
    } on GrpcError catch (e) {
      print('gRPC Error during GetUserAccounts: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to fetch account summaries.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during getAccountSummaries: $e');
      return Left(ServerFailure(
        message:
            'An unexpected error occurred while fetching account summaries.',
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

      print(
          'gRPC GetFamilyAccounts Response received with ${response.familyAccounts.length} items');

      // Family accounts are created in the user's locale currency
      // (family_setup_flow uses LocaleManager.currentCurrency). The proto does
      // not yet carry a currency field, so resolve it from the active locale
      // rather than hardcoding USD — otherwise an NGN user sees a "$" card.
      // WHOSE allocation the card shows. Needed because a family account can
      // run two completely different ways, and the card must not conflate
      // them:
      //
      //   shared_pool        — nobody has an allocation; everyone spends the
      //                        pool, and the pool figure IS the member's
      //                        spendable balance.
      //   equal_split /      — each member has their OWN allocated balance and
      //   custom_allocation    can only spend that. The pool is what is left
      //                        UNallocated, which is not theirs to spend.
      //
      // In the second case showing only the family total tells a member they
      // have money they cannot touch.
      final currentUserId =
          await serviceLocator<SecureStorageService>().getCurrentUserId();

      final localeCurrency = serviceLocator<LocaleManager>().currentCurrency;
      final familyCurrency = localeCurrency.isNotEmpty ? localeCurrency : 'NGN';
      return response.familyAccounts.map((proto) {
        final status = proto.status.isNotEmpty ? proto.status : 'active';
        return AccountSummaryEntity.familyAccount(
          id: proto.id,
          name: proto.name, // the family account's actual name → card subtitle
          // Prefer the account's real currency from the backend; fall back to
          // the active locale currency (never hardcode USD).
          currency: proto.currency.isNotEmpty ? proto.currency : familyCurrency,
          totalBalance: proto.totalBalance,
          // THE LOGGED-IN MEMBER's own numbers, not the family aggregate.
          //
          // These were fed proto.totalAllocatedBalance (every member's
          // allocation added together) and proto.totalPoolBalance (the
          // UNallocated remainder). Rendered as "your allocation" that would
          // have told a member the whole family's money was theirs, and called
          // the unallocated pool their "remaining".
          //
          // The caller's own row is already on the wire in proto.members, so
          // this needs nothing new from the server.
          memberAllocatedBalance:
              _selfMember(proto, currentUserId)?.allocatedBalance,
          memberRemainingBalance: _selfRemaining(proto, currentUserId),
          poolBalance: proto.totalPoolBalance,
          memberCount: proto.memberCount,
          allowMemberContributions: proto.allowMemberContributions,
          trendPercentage: 0.0,
          familyAccountId: proto.id,
          virtualAccountId: proto.virtualAccountId,
          familyStatus: status,
          fundDistributionMode:
              _mapDistributionMode(proto.fundDistributionMode),
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
  List<AccountSummaryEntity> _sortAccountSummaries(
      List<AccountSummaryEntity> summaries) {
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

/// The caller's OWN row in a family account, or null when they are not a
/// member of it (an admin view, or a stale cache).
///
/// Matching on user_id, not on position: the members list is ordered by the
/// server and a family's first member is its creator, not whoever is looking.
family_pb.FamilyMember? _selfMember(
    family_pb.FamilyAccount account, String? currentUserId) {
  final uid = (currentUserId ?? '').trim();
  if (uid.isEmpty) return null;
  for (final m in account.members) {
    if (m.userId.trim() == uid) return m;
  }
  return null;
}

/// What the caller can actually still spend from their allocation today.
///
/// allocated − spentToday, floored at zero, which is the same arithmetic the
/// backend's GetRemainingBalance uses — so the number on the card is the
/// number the spend gate will enforce, rather than an optimistic figure the
/// server then refuses.
///
/// Null when the caller has no allocation: in shared_pool nobody does, and a
/// "remaining" of 0 would read as "you cannot spend" when in fact they spend
/// the pool.
double? _selfRemaining(family_pb.FamilyAccount account, String? currentUserId) {
  final me = _selfMember(account, currentUserId);
  if (me == null) return null;
  final remaining = me.allocatedBalance - me.spentToday;
  return remaining > 0 ? remaining : 0;
}
