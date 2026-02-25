import 'package:dartz/dartz.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../entities/family_account_entities.dart';
import '../repositories/family_account_repository.dart' show FamilyAccountRepository, MemberAllocationEntry;

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
    );
  }
}

class AddFamilyMemberParams {
  final String familyId;
  final String invitationMethod;
  final String invitationDestination;
  final double initialAllocation;
  final double dailyLimit;
  final double monthlyLimit;
  final double perTransactionLimit;
  final double allocationPercentageCap;
  final String role;
  final String? personalMessage;

  AddFamilyMemberParams({
    required this.familyId,
    required this.invitationMethod,
    required this.invitationDestination,
    required this.initialAllocation,
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.perTransactionLimit,
    required this.allocationPercentageCap,
    required this.role,
    this.personalMessage,
  });
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
    );
  }
}

class AllocateFundsParams {
  final String familyId;
  final String memberId;
  final double amount;
  final String? description;

  AllocateFundsParams({
    required this.familyId,
    required this.memberId,
    required this.amount,
    this.description,
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
    );
  }
}

class ProcessMemberContributionParams {
  final String familyId;
  final String memberId;
  final double amount;
  final String? description;

  ProcessMemberContributionParams({
    required this.familyId,
    required this.memberId,
    required this.amount,
    this.description,
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
    );
  }
}

class SetupFamilyAccountParams {
  final String familyId;
  final String fundDistributionMode;
  final bool spendingVisibilityEnabled;
  final List<MemberAllocationEntry> allocations;

  SetupFamilyAccountParams({
    required this.familyId,
    required this.fundDistributionMode,
    required this.spendingVisibilityEnabled,
    this.allocations = const [],
  });
}
