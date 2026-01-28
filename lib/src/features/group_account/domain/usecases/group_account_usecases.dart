import '../entities/group_entities.dart';
import '../repositories/group_account_repository.dart';

// Base use case class
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {}

// Group Account Use Cases
class GetUserGroups extends UseCase<List<GroupAccount>, String> {
  final GroupAccountRepository repository;

  GetUserGroups(this.repository);

  @override
  Future<List<GroupAccount>> call(String userId) {
    return repository.getUserGroups(userId);
  }
}

class GetGroupById extends UseCase<GroupAccount, String> {
  final GroupAccountRepository repository;

  GetGroupById(this.repository);

  @override
  Future<GroupAccount> call(String groupId) {
    return repository.getGroupById(groupId);
  }
}

class CreateGroup extends UseCase<GroupAccount, CreateGroupParams> {
  final GroupAccountRepository repository;

  CreateGroup(this.repository);

  @override
  Future<GroupAccount> call(CreateGroupParams params) {
    return repository.createGroup(
      name: params.name,
      description: params.description,
      adminId: params.adminId,
    );
  }
}

class UpdateGroup extends UseCase<GroupAccount, GroupAccount> {
  final GroupAccountRepository repository;

  UpdateGroup(this.repository);

  @override
  Future<GroupAccount> call(GroupAccount group) {
    return repository.updateGroup(group);
  }
}

class DeleteGroup extends UseCase<void, String> {
  final GroupAccountRepository repository;

  DeleteGroup(this.repository);

  @override
  Future<void> call(String groupId) {
    return repository.deleteGroup(groupId);
  }
}

// Group Member Use Cases
class GetGroupMembers extends UseCase<List<GroupMember>, String> {
  final GroupAccountRepository repository;

  GetGroupMembers(this.repository);

  @override
  Future<List<GroupMember>> call(String groupId) {
    return repository.getGroupMembers(groupId);
  }
}

class AddMemberToGroup extends UseCase<GroupMember, AddMemberParams> {
  final GroupAccountRepository repository;

  AddMemberToGroup(this.repository);

  @override
  Future<GroupMember> call(AddMemberParams params) {
    return repository.addMemberToGroup(
      groupId: params.groupId,
      userId: params.userId,
      userName: params.userName,
      email: params.email,
      profileImage: params.profileImage,
      role: params.role,
    );
  }
}

class UpdateMemberRole extends UseCase<GroupMember, UpdateMemberRoleParams> {
  final GroupAccountRepository repository;

  UpdateMemberRole(this.repository);

  @override
  Future<GroupMember> call(UpdateMemberRoleParams params) {
    return repository.updateMemberRole(
      groupId: params.groupId,
      memberId: params.memberId,
      newRole: params.newRole,
    );
  }
}

class RemoveMemberFromGroup extends UseCase<void, RemoveMemberParams> {
  final GroupAccountRepository repository;

  RemoveMemberFromGroup(this.repository);

  @override
  Future<void> call(RemoveMemberParams params) {
    return repository.removeMemberFromGroup(
      groupId: params.groupId,
      memberId: params.memberId,
    );
  }
}

class SearchUsers extends UseCase<List<GroupMember>, String> {
  final GroupAccountRepository repository;

  SearchUsers(this.repository);

  @override
  Future<List<GroupMember>> call(String query) {
    return repository.searchUsers(query);
  }
}

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

// Statistics Use Cases
class GetGroupStatistics extends UseCase<Map<String, dynamic>, String> {
  final GroupAccountRepository repository;

  GetGroupStatistics(this.repository);

  @override
  Future<Map<String, dynamic>> call(String groupId) {
    return repository.getGroupStatistics(groupId);
  }
}

class GetUserContributionStats extends UseCase<Map<String, dynamic>, String> {
  final GroupAccountRepository repository;

  GetUserContributionStats(this.repository);

  @override
  Future<Map<String, dynamic>> call(String userId) {
    return repository.getUserContributionStats(userId);
  }
}

// Parameter classes
class CreateGroupParams {
  final String name;
  final String description;
  final String adminId;

  CreateGroupParams({
    required this.name,
    required this.description,
    required this.adminId,
  });
}

class AddMemberParams {
  final String groupId;
  final String userId;
  final String userName;
  final String email;
  final String? profileImage;
  final GroupMemberRole role;

  AddMemberParams({
    required this.groupId,
    required this.userId,
    required this.userName,
    required this.email,
    this.profileImage,
    this.role = GroupMemberRole.member,
  });
}

class UpdateMemberRoleParams {
  final String groupId;
  final String memberId;
  final GroupMemberRole newRole;

  UpdateMemberRoleParams({
    required this.groupId,
    required this.memberId,
    required this.newRole,
  });
}

class RemoveMemberParams {
  final String groupId;
  final String memberId;

  RemoveMemberParams({
    required this.groupId,
    required this.memberId,
  });
}

class CreateContributionParams {
  final String groupId;
  final String title;
  final String description;
  final double targetAmount;
  final String currency;
  final DateTime deadline;
  final String createdBy;

  CreateContributionParams({
    required this.groupId,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.currency,
    required this.deadline,
    required this.createdBy,
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

  MakePaymentParams({
    required this.contributionId,
    required this.groupId,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.currency,
    this.notes,
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