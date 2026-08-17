part of 'group_account_usecases.dart';

// Contribution Use Cases
class GetGroupContributions extends UseCase<List<Contribution>, String> {
  final GroupAccountRepository repository;

  GetGroupContributions(this.repository);

  @override
  Future<List<Contribution>> call(String groupId) {
    return repository.getGroupContributions(groupId);
  }
}

class GetContributionById extends UseCase<Contribution, String> {
  final GroupAccountRepository repository;

  GetContributionById(this.repository);

  @override
  Future<Contribution> call(String contributionId) {
    return repository.getContributionById(contributionId);
  }
}

class CreateContribution extends UseCase<Contribution, CreateContributionParams> {
  final GroupAccountRepository repository;

  CreateContribution(this.repository);

  @override
  Future<Contribution> call(CreateContributionParams params) {
    return repository.createContribution(
      groupId: params.groupId,
      title: params.title,
      description: params.description,
      targetAmount: params.targetAmount,
      currency: params.currency,
      deadline: params.deadline,
      createdBy: params.createdBy,
      type: params.type,
      frequency: params.frequency,
      regularAmount: params.regularAmount,
      startDate: params.startDate,
      totalCycles: params.totalCycles,
      memberRotationOrder: params.memberRotationOrder,
      autoPayEnabled: params.autoPayEnabled,
      penaltyAmount: params.penaltyAmount,
      gracePeriodDays: params.gracePeriodDays,
      allowPartialPayments: params.allowPartialPayments,
      minimumBalance: params.minimumBalance,
      autoPayoutEnabled: params.autoPayoutEnabled,
      metadata: params.metadata,
    );
  }
}

class UpdateContribution extends UseCase<Contribution, Contribution> {
  final GroupAccountRepository repository;

  UpdateContribution(this.repository);

  @override
  Future<Contribution> call(Contribution contribution) {
    return repository.updateContribution(contribution);
  }
}

class DeleteContribution extends UseCase<void, String> {
  final GroupAccountRepository repository;

  DeleteContribution(this.repository);

  @override
  Future<void> call(String contributionId) {
    return repository.deleteContribution(contributionId);
  }
}

// Contribution Member Use Cases
class AddMembersToContribution extends UseCase<List<ContributionMember>, AddMembersToContributionParams> {
  final GroupAccountRepository repository;

  AddMembersToContribution(this.repository);

  @override
  Future<List<ContributionMember>> call(AddMembersToContributionParams params) {
    return repository.addMembersToContribution(
      contributionId: params.contributionId,
      memberUserIds: params.memberUserIds,
    );
  }
}

class GetContributionMembers extends UseCase<List<ContributionMember>, String> {
  final GroupAccountRepository repository;

  GetContributionMembers(this.repository);

  @override
  Future<List<ContributionMember>> call(String contributionId) {
    return repository.getContributionMembers(contributionId);
  }
}

class RemoveMemberFromContribution
    extends UseCase<MemberExitResult, RemoveMemberFromContributionParams> {
  final GroupAccountRepository repository;

  RemoveMemberFromContribution(this.repository);

  @override
  Future<MemberExitResult> call(RemoveMemberFromContributionParams params) {
    return repository.removeMemberFromContribution(
      contributionId: params.contributionId,
      userId: params.userId,
    );
  }
}

class RemoveContributionShadow
    extends UseCase<int, RemoveMemberFromContributionParams> {
  final GroupAccountRepository repository;

  RemoveContributionShadow(this.repository);

  @override
  Future<int> call(RemoveMemberFromContributionParams params) {
    return repository.removeContributionShadow(
      contributionId: params.contributionId,
      userId: params.userId,
    );
  }
}

class PreviewMemberExit
    extends UseCase<MemberExitPreview, RemoveMemberFromContributionParams> {
  final GroupAccountRepository repository;

  PreviewMemberExit(this.repository);

  @override
  Future<MemberExitPreview> call(RemoveMemberFromContributionParams params) {
    return repository.previewMemberExit(
      contributionId: params.contributionId,
      userId: params.userId,
    );
  }
}

// Payment Use Cases
class GetContributionPayments extends UseCase<List<ContributionPayment>, String> {
  final GroupAccountRepository repository;

  GetContributionPayments(this.repository);

  @override
  Future<List<ContributionPayment>> call(String contributionId) {
    return repository.getContributionPayments(contributionId);
  }
}

class MakeContributionPayment extends UseCase<ContributionPayment, MakePaymentParams> {
  final GroupAccountRepository repository;

  MakeContributionPayment(this.repository);

  @override
  Future<ContributionPayment> call(MakePaymentParams params) {
    return repository.makeContributionPayment(
      contributionId: params.contributionId,
      groupId: params.groupId,
      userId: params.userId,
      userName: params.userName,
      amount: params.amount,
      currency: params.currency,
      notes: params.notes,
      transactionPin: params.transactionPin,
      sourceAccountId: params.sourceAccountId,
      idempotencyKey: params.idempotencyKey,
    );
  }
}

class UpdatePaymentStatus extends UseCase<ContributionPayment, UpdatePaymentStatusParams> {
  final GroupAccountRepository repository;

  UpdatePaymentStatus(this.repository);

  @override
  Future<ContributionPayment> call(UpdatePaymentStatusParams params) {
    return repository.updatePaymentStatus(
      paymentId: params.paymentId,
      status: params.status,
      transactionId: params.transactionId,
    );
  }
}

// Receipt Use Cases
class GenerateReceipt extends UseCase<ContributionReceipt, String> {
  final GroupAccountRepository repository;

  GenerateReceipt(this.repository);

  @override
  Future<ContributionReceipt> call(String paymentId) {
    return repository.generateReceipt(paymentId);
  }
}

class GetUserReceipts extends UseCase<List<ContributionReceipt>, String> {
  final GroupAccountRepository repository;

  GetUserReceipts(this.repository);

  @override
  Future<List<ContributionReceipt>> call(String userId) {
    return repository.getUserReceipts(userId);
  }
}

// Transcript Use Cases
class GenerateContributionTranscript extends UseCase<ContributionTranscript, String> {
  final GroupAccountRepository repository;

  GenerateContributionTranscript(this.repository);

  @override
  Future<ContributionTranscript> call(String contributionId) {
    return repository.generateContributionTranscript(contributionId);
  }
}

class CreateContributionParams {
  final String groupId;
  final String title;
  final String description;
  final double targetAmount;
  final String currency;
  final DateTime deadline;
  final String createdBy;
  final ContributionType type;
  final ContributionFrequency? frequency;
  final double? regularAmount;
  final DateTime? startDate;
  final int? totalCycles;
  final List<String>? memberRotationOrder;
  final bool autoPayEnabled;
  final double? penaltyAmount;
  final int? gracePeriodDays;
  final bool allowPartialPayments;
  final double? minimumBalance;
  final bool autoPayoutEnabled;
  final Map<String, dynamic>? metadata;

  CreateContributionParams({
    required this.groupId,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.currency,
    required this.deadline,
    required this.createdBy,
    this.type = ContributionType.oneTime,
    this.frequency,
    this.regularAmount,
    this.startDate,
    this.totalCycles,
    this.memberRotationOrder,
    this.autoPayEnabled = false,
    this.penaltyAmount,
    this.gracePeriodDays,
    this.allowPartialPayments = true,
    this.minimumBalance,
    this.autoPayoutEnabled = false,
    this.metadata,
  });
}

class MakePaymentParams {
  final String contributionId;
  final String groupId;
  final String userId;
  final String userName;
  final double amount;
  final String currency;
  final String? notes;
  final String? transactionPin;
  final String? sourceAccountId;
  final String? idempotencyKey;

  MakePaymentParams({
    required this.contributionId,
    required this.groupId,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.currency,
    this.notes,
    this.transactionPin,
    this.sourceAccountId,
    this.idempotencyKey,
  });
}

class UpdatePaymentStatusParams {
  final String paymentId;
  final PaymentStatus status;
  final String? transactionId;

  UpdatePaymentStatusParams({
    required this.paymentId,
    required this.status,
    this.transactionId,
  });
}

class AddMembersToContributionParams {
  final String contributionId;
  final List<String> memberUserIds;

  AddMembersToContributionParams({
    required this.contributionId,
    required this.memberUserIds,
  });
}

class RemoveMemberFromContributionParams {
  final String contributionId;
  final String userId;

  RemoveMemberFromContributionParams({
    required this.contributionId,
    required this.userId,
  });
}

// =============================================================
// Cycle history use cases.
// =============================================================

class ListContributionCyclesParams {
  final String contributionId;
  final bool includeInProgress;
  final int page;
  final int pageSize;

  const ListContributionCyclesParams({
    required this.contributionId,
    this.includeInProgress = true,
    this.page = 1,
    this.pageSize = 50,
  });
}

class ListContributionCycles extends UseCase<
    ({List<ContributionCycle> cycles, int total}),
    ListContributionCyclesParams> {
  final GroupAccountRepository repository;
  ListContributionCycles(this.repository);

  @override
  Future<({List<ContributionCycle> cycles, int total})> call(
      ListContributionCyclesParams p) {
    return repository.listContributionCycles(
      contributionId: p.contributionId,
      includeInProgress: p.includeInProgress,
      page: p.page,
      pageSize: p.pageSize,
    );
  }
}

class GetContributionCycleDetailsParams {
  final String contributionId;
  final int cycleIndex;

  const GetContributionCycleDetailsParams({
    required this.contributionId,
    this.cycleIndex = 0,
  });
}

class GetContributionCycleDetails extends UseCase<ContributionCycleDetails,
    GetContributionCycleDetailsParams> {
  final GroupAccountRepository repository;
  GetContributionCycleDetails(this.repository);

  @override
  Future<ContributionCycleDetails> call(
      GetContributionCycleDetailsParams p) {
    return repository.getContributionCycleDetails(
      contributionId: p.contributionId,
      cycleIndex: p.cycleIndex,
    );
  }
}

class RestartContributionParams {
  final String contributionId;
  final double? newTargetAmount;
  final DateTime? newDeadline;
  final String reason;

  const RestartContributionParams({
    required this.contributionId,
    this.newTargetAmount,
    this.newDeadline,
    this.reason = '',
  });
}

class RestartContribution extends UseCase<Contribution, RestartContributionParams> {
  final GroupAccountRepository repository;
  RestartContribution(this.repository);

  @override
  Future<Contribution> call(RestartContributionParams p) {
    return repository.restartContribution(
      contributionId: p.contributionId,
      newTargetAmount: p.newTargetAmount,
      newDeadline: p.newDeadline,
      reason: p.reason,
    );
  }
}
