import '../../../../generated/family_accounts.pbgrpc.dart' as family_pb;
import '../models/family_account_proto.dart';
import 'family_account_remote_data_source.dart';

class FamilyAccountGrpcDataSource implements FamilyAccountRemoteDataSource {
  final family_pb.FamilyAccountsServiceClient _client;

  FamilyAccountGrpcDataSource(this._client);

  @override
  Future<List<FamilyAccountProto>> getFamilyAccounts({String? statusFilter}) async {
    final request = family_pb.GetFamilyAccountsRequest(
      status: statusFilter ?? '',
    );

    final response = await _client.getFamilyAccounts(request);

    return response.familyAccounts.map((account) => _mapFamilyAccountFromProto(account)).toList();
  }

  @override
  Future<FamilyAccountProto> getFamilyAccount(String familyId) async {
    final request = family_pb.GetFamilyAccountRequest(
      familyId: familyId,
    );

    final response = await _client.getFamilyAccount(request);

    return _mapFamilyAccountFromProto(response.familyAccount);
  }

  @override
  Future<FamilyAccountProto> createFamilyAccount(CreateFamilyAccountRequest req) async {
    final request = family_pb.CreateFamilyAccountRequest(
      name: req.name,
      description: req.description,
      initialCurrency: req.initialCurrency,
      initialFunding: req.initialFunding,
      allowMemberContributions: req.allowMemberContributions,
    );

    final response = await _client.createFamilyAccount(request);

    return _mapFamilyAccountFromProto(response.familyAccount);
  }

  @override
  Future<FamilyMemberProto> addFamilyMember(AddFamilyMemberRequest req) async {
    final request = family_pb.AddFamilyMemberRequest(
      familyId: req.familyId,
      invitationMethod: req.invitationMethod,
      invitationDestination: req.invitationDestination,
      initialAllocation: req.initialAllocation,
      dailyLimit: req.dailyLimit,
      monthlyLimit: req.monthlyLimit,
      perTransactionLimit: req.perTransactionLimit,
      allocationPercentageCap: req.allocationPercentageCap,
      role: req.role,
      personalMessage: req.personalMessage,
    );

    final response = await _client.addFamilyMember(request);

    return _mapFamilyMemberFromProto(response.member);
  }

  @override
  Future<FamilyMemberProto> updateFamilyMember(UpdateFamilyMemberRequest req) async {
    final request = family_pb.UpdateFamilyMemberRequest(
      familyId: req.familyId,
      memberId: req.memberId,
      allocatedBalance: req.allocatedBalance ?? 0.0,
      dailySpendingLimit: req.dailySpendingLimit ?? 0.0,
      monthlySpendingLimit: req.monthlySpendingLimit ?? 0.0,
      perTransactionLimit: req.perTransactionLimit ?? 0.0,
      allocationPercentageCap: req.allocationPercentageCap ?? 0.0,
      role: req.role ?? '',
    );

    final response = await _client.updateFamilyMember(request);

    return _mapFamilyMemberFromProto(response.member);
  }

  @override
  Future<double> removeFamilyMember({
    required String familyId,
    required String memberId,
    String? reason,
    bool returnBalanceToPool = true,
  }) async {
    final request = family_pb.RemoveFamilyMemberRequest(
      familyId: familyId,
      memberId: memberId,
      reason: reason ?? '',
    );

    final response = await _client.removeFamilyMember(request);

    return response.returnedBalance;
  }

  @override
  Future<FamilyAccountProto> acceptFamilyInvitation(String invitationToken) async {
    final request = family_pb.AcceptFamilyInvitationRequest(
      invitationToken: invitationToken,
    );

    final response = await _client.acceptFamilyInvitation(request);

    return _mapFamilyAccountFromProto(response.familyAccount);
  }

  @override
  Future<bool> declineFamilyInvitation(String invitationToken) async {
    final request = family_pb.DeclineFamilyInvitationRequest(
      invitationToken: invitationToken,
      reason: '',
    );

    final response = await _client.declineFamilyInvitation(request);

    return response.success;
  }

  @override
  Future<List<PendingInvitationProto>> getPendingInvitations() async {
    final request = family_pb.GetPendingInvitationsRequest();

    final response = await _client.getPendingInvitations(request);

    return response.invitations.map((invitation) => _mapPendingInvitationFromProto(invitation)).toList();
  }

  @override
  Future<List<FamilyTransactionProto>> getFamilyTransactions({
    required String familyId,
    String? memberId,
    String? type,
    int page = 1,
    int pageSize = 20,
  }) async {
    final request = family_pb.GetFamilyTransactionsRequest(
      familyId: familyId,
      memberId: memberId ?? '',
      type: type ?? '',
      page: page,
      pageSize: pageSize,
    );

    final response = await _client.getFamilyTransactions(request);

    return response.transactions.map((txn) => _mapFamilyTransactionFromProto(txn)).toList();
  }

  @override
  Future<FamilyMemberProto> allocateFunds({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    final request = family_pb.AllocateFundsRequest(
      familyId: familyId,
      memberId: memberId,
      amount: amount,
      description: description ?? '',
    );

    final response = await _client.allocateFunds(request);

    return _mapFamilyMemberFromProto(response.member);
  }

  @override
  Future<FamilyMemberProto> generateMemberCard({
    required String familyId,
    required String memberId,
    String? cardName,
  }) async {
    final request = family_pb.GenerateMemberCardRequest(
      familyId: familyId,
      memberId: memberId,
      cardName: cardName ?? '',
    );

    final response = await _client.generateMemberCard(request);

    return _mapFamilyMemberFromProto(response.member);
  }

  @override
  Future<FamilyAccountProto> freezeFamilyAccount({
    required String familyId,
    String? reason,
  }) async {
    final request = family_pb.FreezeFamilyAccountRequest(
      familyId: familyId,
      reason: reason ?? '',
    );

    final response = await _client.freezeFamilyAccount(request);

    return _mapFamilyAccountFromProto(response.familyAccount);
  }

  @override
  Future<FamilyAccountProto> unfreezeFamilyAccount(String familyId) async {
    final request = family_pb.UnfreezeFamilyAccountRequest(
      familyId: familyId,
    );

    final response = await _client.unfreezeFamilyAccount(request);

    return _mapFamilyAccountFromProto(response.familyAccount);
  }

  @override
  Future<double> deleteFamilyAccount({
    required String familyId,
    required String confirmationCode,
  }) async {
    final request = family_pb.DeleteFamilyAccountRequest(
      familyId: familyId,
      confirmationCode: confirmationCode,
    );

    final response = await _client.deleteFamilyAccount(request);

    return response.returnedBalance;
  }

  @override
  Future<FamilyAccountProto> processMemberContribution({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    // TODO: This endpoint may need to be added to the proto if not present
    // For now, this is a placeholder implementation
    throw UnimplementedError('Member contribution processing not yet implemented in gRPC service');
  }

  // Mapping functions to convert proto to data models

  FamilyAccountProto _mapFamilyAccountFromProto(family_pb.FamilyAccount proto) {
    return FamilyAccountProto(
      id: proto.id,
      creatorId: proto.creatorId,
      creatorName: proto.creatorName,
      name: proto.name,
      description: proto.description,
      totalAllocatedBalance: proto.totalAllocatedBalance,
      totalPoolBalance: proto.totalPoolBalance,
      allowMemberContributions: proto.allowMemberContributions,
      totalBalance: proto.totalBalance,
      status: proto.status,
      createdAt: proto.createdAt,
      updatedAt: proto.updatedAt,
      members: proto.members.map((m) => _mapFamilyMemberFromProto(m)).toList(),
      memberCount: proto.memberCount,
      activeMemberCount: proto.activeMemberCount,
    );
  }

  FamilyMemberProto _mapFamilyMemberFromProto(family_pb.FamilyMember proto) {
    return FamilyMemberProto(
      id: proto.id,
      familyId: proto.familyId,
      userId: proto.userId,
      fullName: proto.fullName,
      email: proto.email,
      phone: proto.phone,
      username: proto.username,
      avatarUrl: proto.avatarUrl,
      role: proto.role,
      allocatedBalance: proto.allocatedBalance,
      dailySpendingLimit: proto.dailySpendingLimit,
      monthlySpendingLimit: proto.monthlySpendingLimit,
      perTransactionLimit: proto.perTransactionLimit,
      allocationPercentageCap: proto.allocationPercentageCap,
      spentToday: proto.spentToday,
      spentThisMonth: proto.spentThisMonth,
      remainingBalance: proto.remainingBalance,
      invitationStatus: proto.invitationStatus,
      invitationToken: proto.invitationToken,
      invitationExpiresAt: proto.invitationExpiresAt,
      cardLastFour: proto.cardLastFour,
      hasCard: proto.hasCard,
      joinedAt: proto.joinedAt,
      createdAt: proto.createdAt,
      updatedAt: proto.updatedAt,
    );
  }

  FamilyTransactionProto _mapFamilyTransactionFromProto(family_pb.FamilyTransaction proto) {
    return FamilyTransactionProto(
      id: proto.id,
      familyId: proto.familyId,
      memberId: proto.memberId,
      memberName: proto.memberName,
      amount: proto.amount,
      type: proto.type,
      description: proto.description,
      createdAt: proto.createdAt,
    );
  }

  PendingInvitationProto _mapPendingInvitationFromProto(family_pb.PendingInvitation proto) {
    return PendingInvitationProto(
      invitationToken: proto.invitationToken,
      familyId: proto.familyId,
      familyName: proto.familyName,
      creatorName: proto.creatorName,
      creatorAvatar: proto.hasCreatorAvatar() ? proto.creatorAvatar : null,
      initialAllocation: proto.initialAllocation,
      dailyLimit: proto.dailyLimit,
      monthlyLimit: proto.monthlyLimit,
      perTransactionLimit: 0.0, // Default value - field not in proto
      allocationPercentageCap: 100.0, // Default value - field not in proto
      invitedBy: proto.invitedBy,
      invitedEmail: null, // Field not in proto
      invitedPhone: null, // Field not in proto
      role: 'member', // Default value - field not in proto
      personalMessage: null, // Field not in proto
      createdAt: proto.createdAt,
      expiresAt: proto.expiresAt,
    );
  }
}
