part of 'family_account_usecases.dart';

// Base use case class
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}

// Get Family Accounts Use Case
class GetFamilyAccountsUseCase extends UseCase<List<FamilyAccount>, GetFamilyAccountsParams> {
  final FamilyAccountRepository repository;

  GetFamilyAccountsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FamilyAccount>>> call(GetFamilyAccountsParams params) {
    return repository.getFamilyAccounts(statusFilter: params.statusFilter);
  }
}

class GetFamilyAccountsParams {
  final String? statusFilter;
  const GetFamilyAccountsParams({this.statusFilter});
}

// Get Family Account Use Case
class GetFamilyAccountUseCase extends UseCase<FamilyAccount, String> {
  final FamilyAccountRepository repository;

  GetFamilyAccountUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyAccount>> call(String familyId) {
    return repository.getFamilyAccount(familyId);
  }
}

// Create Family Account Use Case
class CreateFamilyAccountUseCase extends UseCase<FamilyAccount, CreateFamilyAccountParams> {
  final FamilyAccountRepository repository;

  CreateFamilyAccountUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyAccount>> call(CreateFamilyAccountParams params) {
    return repository.createFamilyAccount(
      name: params.name,
      description: params.description,
      initialCurrency: params.initialCurrency,
      initialFunding: params.initialFunding,
      allowMemberContributions: params.allowMemberContributions,
    );
  }
}

class CreateFamilyAccountParams {
  final String name;
  final String? description;
  final String initialCurrency;
  final double initialFunding;
  final bool allowMemberContributions;

  CreateFamilyAccountParams({
    required this.name,
    this.description,
    required this.initialCurrency,
    required this.initialFunding,
    required this.allowMemberContributions,
  });
}

// Add Family Member Use Case
class AddFamilyMemberUseCase extends UseCase<FamilyMember, AddFamilyMemberParams> {
  final FamilyAccountRepository repository;

  AddFamilyMemberUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyMember>> call(AddFamilyMemberParams params) {
    return repository.addFamilyMember(
      familyId: params.familyId,
      invitationMethod: params.invitationMethod,
      invitationDestination: params.invitationDestination,
      initialAllocation: params.initialAllocation,
      dailyLimit: params.dailyLimit,
      monthlyLimit: params.monthlyLimit,
      perTransactionLimit: params.perTransactionLimit,
      allocationPercentageCap: params.allocationPercentageCap,
      role: params.role,
      personalMessage: params.personalMessage,
      displayName: params.displayName,
    );
  }
}

// Update Family Member Use Case
class UpdateFamilyMemberUseCase extends UseCase<FamilyMember, UpdateFamilyMemberParams> {
  final FamilyAccountRepository repository;

  UpdateFamilyMemberUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyMember>> call(UpdateFamilyMemberParams params) {
    return repository.updateFamilyMember(
      familyId: params.familyId,
      memberId: params.memberId,
      allocatedBalance: params.allocatedBalance,
      dailySpendingLimit: params.dailySpendingLimit,
      monthlySpendingLimit: params.monthlySpendingLimit,
      perTransactionLimit: params.perTransactionLimit,
      allocationPercentageCap: params.allocationPercentageCap,
      role: params.role,
    );
  }
}

class UpdateFamilyMemberParams {
  final String familyId;
  final String memberId;
  final double? allocatedBalance;
  final double? dailySpendingLimit;
  final double? monthlySpendingLimit;
  final double? perTransactionLimit;
  final double? allocationPercentageCap;
  final String? role;

  UpdateFamilyMemberParams({
    required this.familyId,
    required this.memberId,
    this.allocatedBalance,
    this.dailySpendingLimit,
    this.monthlySpendingLimit,
    this.perTransactionLimit,
    this.allocationPercentageCap,
    this.role,
  });
}

// Remove Family Member Use Case
class RemoveFamilyMemberUseCase extends UseCase<double, RemoveFamilyMemberParams> {
  final FamilyAccountRepository repository;

  RemoveFamilyMemberUseCase(this.repository);

  @override
  Future<Either<Failure, double>> call(RemoveFamilyMemberParams params) {
    return repository.removeFamilyMember(
      familyId: params.familyId,
      memberId: params.memberId,
      reason: params.reason,
      returnBalanceToPool: params.returnBalanceToPool,
    );
  }
}

class RemoveFamilyMemberParams {
  final String familyId;
  final String memberId;
  final String? reason;
  final bool returnBalanceToPool;

  RemoveFamilyMemberParams({
    required this.familyId,
    required this.memberId,
    this.reason,
    this.returnBalanceToPool = true,
  });
}

// Accept Family Invitation Use Case
class AcceptFamilyInvitationUseCase extends UseCase<FamilyAccount, String> {
  final FamilyAccountRepository repository;

  AcceptFamilyInvitationUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyAccount>> call(String invitationToken) {
    return repository.acceptFamilyInvitation(invitationToken: invitationToken);
  }
}

// Decline Family Invitation Use Case
class DeclineFamilyInvitationUseCase extends UseCase<bool, String> {
  final FamilyAccountRepository repository;

  DeclineFamilyInvitationUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String invitationToken) {
    return repository.declineFamilyInvitation(invitationToken: invitationToken);
  }
}

// Get Pending Invitations Use Case
class GetPendingInvitationsUseCase extends UseCase<List<PendingInvitation>, NoParams> {
  final FamilyAccountRepository repository;

  GetPendingInvitationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<PendingInvitation>>> call(NoParams params) {
    return repository.getPendingInvitations();
  }
}

// Get Family Transactions Use Case
class GetFamilyTransactionsUseCase extends UseCase<List<FamilyTransaction>, GetFamilyTransactionsParams> {
  final FamilyAccountRepository repository;

  GetFamilyTransactionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FamilyTransaction>>> call(GetFamilyTransactionsParams params) {
    return repository.getFamilyTransactions(
      familyId: params.familyId,
      memberId: params.memberId,
      type: params.type,
      page: params.page,
      pageSize: params.pageSize,
      startDate: params.startDate,
      endDate: params.endDate,
    );
  }
}

class GetFamilyTransactionsParams {
  final String familyId;
  final String? memberId;
  final FamilyTransactionType? type;
  final int page;
  final int pageSize;
  final DateTime? startDate;
  final DateTime? endDate;

  GetFamilyTransactionsParams({
    required this.familyId,
    this.memberId,
    this.type,
    this.page = 1,
    this.pageSize = 20,
    this.startDate,
    this.endDate,
  });
}

// Allocate Funds Use Case
class AllocateFundsUseCase extends UseCase<FamilyMember, AllocateFundsParams> {
  final FamilyAccountRepository repository;

  AllocateFundsUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyMember>> call(AllocateFundsParams params) {
    return repository.allocateFunds(
      familyId: params.familyId,
      memberId: params.memberId,
      amount: params.amount,
      description: params.description,
      idempotencyKey: params.idempotencyKey,
    );
  }
}

class AllocateFundsParams {
  final String familyId;
  final String memberId;
  final double amount;
  final String? description;
  final String? idempotencyKey;

  AllocateFundsParams({
    required this.familyId,
    required this.memberId,
    required this.amount,
    this.description,
    this.idempotencyKey,
  });
}

// Generate Member Card Use Case
class GenerateMemberCardUseCase extends UseCase<FamilyMember, GenerateMemberCardParams> {
  final FamilyAccountRepository repository;

  GenerateMemberCardUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyMember>> call(GenerateMemberCardParams params) {
    return repository.generateMemberCard(
      familyId: params.familyId,
      memberId: params.memberId,
      cardName: params.cardName,
    );
  }
}

class GenerateMemberCardParams {
  final String familyId;
  final String memberId;
  final String? cardName;

  GenerateMemberCardParams({
    required this.familyId,
    required this.memberId,
    this.cardName,
  });
}

// Freeze Family Account Use Case
class FreezeFamilyAccountUseCase extends UseCase<FamilyAccount, FreezeFamilyAccountParams> {
  final FamilyAccountRepository repository;

  FreezeFamilyAccountUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyAccount>> call(FreezeFamilyAccountParams params) {
    return repository.freezeFamilyAccount(
      familyId: params.familyId,
      reason: params.reason,
    );
  }
}

class FreezeFamilyAccountParams {
  final String familyId;
  final String? reason;

  FreezeFamilyAccountParams({
    required this.familyId,
    this.reason,
  });
}

// Unfreeze Family Account Use Case
class UnfreezeFamilyAccountUseCase extends UseCase<FamilyAccount, String> {
  final FamilyAccountRepository repository;

  UnfreezeFamilyAccountUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyAccount>> call(String familyId) {
    return repository.unfreezeFamilyAccount(familyId: familyId);
  }
}

// Delete Family Account Use Case
class DeleteFamilyAccountUseCase extends UseCase<double, DeleteFamilyAccountParams> {
  final FamilyAccountRepository repository;

  DeleteFamilyAccountUseCase(this.repository);

  @override
  Future<Either<Failure, double>> call(DeleteFamilyAccountParams params) {
    return repository.deleteFamilyAccount(
      familyId: params.familyId,
      confirmationCode: params.confirmationCode,
    );
  }
}

class DeleteFamilyAccountParams {
  final String familyId;
  final String confirmationCode;

  DeleteFamilyAccountParams({
    required this.familyId,
    required this.confirmationCode,
  });
}

// Leave Family Account Use Case (self-serve member leave)
class LeaveFamilyAccountUseCase extends UseCase<double, LeaveFamilyAccountParams> {
  final FamilyAccountRepository repository;

  LeaveFamilyAccountUseCase(this.repository);

  @override
  Future<Either<Failure, double>> call(LeaveFamilyAccountParams params) {
    return repository.leaveFamilyAccount(familyId: params.familyId);
  }
}

class LeaveFamilyAccountParams {
  final String familyId;
  LeaveFamilyAccountParams({required this.familyId});
}

// Process Member Contribution Use Case (Hybrid Funding)
class ProcessMemberContributionUseCase extends UseCase<FamilyAccount, ProcessMemberContributionParams> {
  final FamilyAccountRepository repository;

  ProcessMemberContributionUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyAccount>> call(ProcessMemberContributionParams params) {
    return repository.processMemberContribution(
      familyId: params.familyId,
      memberId: params.memberId,
      amount: params.amount,
      description: params.description,
      idempotencyKey: params.idempotencyKey,
    );
  }
}

class ProcessMemberContributionParams {
  final String familyId;
  final String memberId;
  final double amount;
  final String? description;
  final String? idempotencyKey;

  ProcessMemberContributionParams({
    required this.familyId,
    required this.memberId,
    required this.amount,
    this.description,
    this.idempotencyKey,
  });
}

// Setup Family Account Use Case
class SetupFamilyAccountUseCase extends UseCase<FamilyAccount, SetupFamilyAccountParams> {
  final FamilyAccountRepository repository;

  SetupFamilyAccountUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyAccount>> call(SetupFamilyAccountParams params) {
    return repository.setupFamilyAccount(
      familyId: params.familyId,
      fundDistributionMode: params.fundDistributionMode,
      spendingVisibilityEnabled: params.spendingVisibilityEnabled,
      allocations: params.allocations,
      fundingPolicy: params.fundingPolicy,
      specificMemberIds: params.specificMemberIds,
    );
  }
}

class SetupFamilyAccountParams {
  final String familyId;
  final String fundDistributionMode;
  final bool spendingVisibilityEnabled;
  final List<MemberAllocationEntry> allocations;
  // Who may fund the pool: any_member (default) | creator_only | specific_members.
  final String fundingPolicy;
  // Member ids allowed to fund when fundingPolicy == specific_members.
  final List<String> specificMemberIds;

  SetupFamilyAccountParams({
    required this.familyId,
    required this.fundDistributionMode,
    required this.spendingVisibilityEnabled,
    this.allocations = const [],
    this.fundingPolicy = 'any_member',
    this.specificMemberIds = const [],
  });
}

// Update Fund Distribution Mode Use Case
class UpdateFundDistributionModeUseCase extends UseCase<FamilyAccount, UpdateFundDistributionModeParams> {
  final FamilyAccountRepository repository;

  UpdateFundDistributionModeUseCase(this.repository);

  @override
  Future<Either<Failure, FamilyAccount>> call(UpdateFundDistributionModeParams params) {
    return repository.updateFundDistributionMode(
      familyId: params.familyId,
      fundDistributionMode: params.fundDistributionMode,
      allocations: params.allocations,
    );
  }
}

class UpdateFundDistributionModeParams {
  final String familyId;
  final String fundDistributionMode;
  final List<MemberAllocationEntry> allocations;

  UpdateFundDistributionModeParams({
    required this.familyId,
    required this.fundDistributionMode,
    this.allocations = const [],
  });
}

// ─── Invitation history use cases ──────────────────────────────────────

class GetMyInvitationHistoryUseCase
    extends UseCase<List<InvitationHistoryEntry>, GetMyInvitationHistoryParams> {
  final FamilyAccountRepository repository;
  GetMyInvitationHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<InvitationHistoryEntry>>> call(
      GetMyInvitationHistoryParams params) {
    return repository.getMyInvitationHistory(
      statusFilter: params.statusFilter,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class GetMyInvitationHistoryParams {
  final String statusFilter;
  final int page;
  final int pageSize;
  const GetMyInvitationHistoryParams({
    this.statusFilter = '',
    this.page = 1,
    this.pageSize = 25,
  });
}

class GetSentInvitationsUseCase
    extends UseCase<List<SentInvitationEntry>, GetSentInvitationsParams> {
  final FamilyAccountRepository repository;
  GetSentInvitationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<SentInvitationEntry>>> call(
      GetSentInvitationsParams params) {
    return repository.getSentInvitations(
      familyId: params.familyId,
      statusFilter: params.statusFilter,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class GetSentInvitationsParams {
  final String? familyId;
  final String statusFilter;
  final int page;
  final int pageSize;
  const GetSentInvitationsParams({
    this.familyId,
    this.statusFilter = '',
    this.page = 1,
    this.pageSize = 25,
  });
}
