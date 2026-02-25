import 'package:grpc/grpc.dart';
import 'package:lazervault/src/core/errors/grpc_exceptions.dart';
import '../../../../../core/services/grpc_call_options_helper.dart';
import '../../../../generated/family_accounts.pbgrpc.dart' as family_pb;
import '../models/family_account_proto.dart';
import 'family_account_remote_data_source.dart';

class FamilyAccountGrpcDataSource implements FamilyAccountRemoteDataSource {
  final family_pb.FamilyAccountsServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  FamilyAccountGrpcDataSource({
    required family_pb.FamilyAccountsServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<List<FamilyAccountProto>> getFamilyAccounts({String? statusFilter}) async {
    try {
      final request = family_pb.GetFamilyAccountsRequest(
        status: statusFilter ?? '',
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getFamilyAccounts(request, options: callOptions);

      return response.familyAccounts.map((account) => _mapFamilyAccountFromProto(account)).toList();
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyAccountProto> getFamilyAccount(String familyId) async {
    try {
      final request = family_pb.GetFamilyAccountRequest(
        familyId: familyId,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getFamilyAccount(request, options: callOptions);

      return _mapFamilyAccountFromProto(response.familyAccount);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyAccountProto> createFamilyAccount(CreateFamilyAccountRequest req) async {
    try {
      final request = family_pb.CreateFamilyAccountRequest(
        name: req.name,
        description: req.description,
        initialCurrency: req.initialCurrency,
        initialFunding: req.initialFunding,
        allowMemberContributions: req.allowMemberContributions,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.createFamilyAccount(request, options: callOptions);

      return _mapFamilyAccountFromProto(response.familyAccount);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyMemberProto> addFamilyMember(AddFamilyMemberRequest req) async {
    try {
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

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.addFamilyMember(request, options: callOptions);

      return _mapFamilyMemberFromProto(response.member);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyMemberProto> updateFamilyMember(UpdateFamilyMemberRequest req) async {
    try {
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

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.updateFamilyMember(request, options: callOptions);

      return _mapFamilyMemberFromProto(response.member);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<double> removeFamilyMember({
    required String familyId,
    required String memberId,
    String? reason,
    bool returnBalanceToPool = true,
  }) async {
    try {
      final request = family_pb.RemoveFamilyMemberRequest(
        familyId: familyId,
        memberId: memberId,
        reason: reason ?? '',
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.removeFamilyMember(request, options: callOptions);

      return response.returnedBalance;
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyAccountProto> acceptFamilyInvitation(String invitationToken) async {
    try {
      final request = family_pb.AcceptFamilyInvitationRequest(
        invitationToken: invitationToken,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.acceptFamilyInvitation(request, options: callOptions);

      return _mapFamilyAccountFromProto(response.familyAccount);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<bool> declineFamilyInvitation(String invitationToken) async {
    try {
      final request = family_pb.DeclineFamilyInvitationRequest(
        invitationToken: invitationToken,
        reason: '',
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.declineFamilyInvitation(request, options: callOptions);

      return response.success;
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<List<PendingInvitationProto>> getPendingInvitations() async {
    try {
      final request = family_pb.GetPendingInvitationsRequest();

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getPendingInvitations(request, options: callOptions);

      return response.invitations.map((invitation) => _mapPendingInvitationFromProto(invitation)).toList();
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<List<FamilyTransactionProto>> getFamilyTransactions({
    required String familyId,
    String? memberId,
    String? type,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final request = family_pb.GetFamilyTransactionsRequest(
        familyId: familyId,
        memberId: memberId ?? '',
        type: type ?? '',
        page: page,
        pageSize: pageSize,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getFamilyTransactions(request, options: callOptions);

      return response.transactions.map((txn) => _mapFamilyTransactionFromProto(txn)).toList();
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyMemberProto> allocateFunds({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    try {
      final request = family_pb.AllocateFundsRequest(
        familyId: familyId,
        memberId: memberId,
        amount: amount,
        description: description ?? '',
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.allocateFunds(request, options: callOptions);

      return _mapFamilyMemberFromProto(response.member);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyMemberProto> generateMemberCard({
    required String familyId,
    required String memberId,
    String? cardName,
  }) async {
    try {
      final request = family_pb.GenerateMemberCardRequest(
        familyId: familyId,
        memberId: memberId,
        cardName: cardName ?? '',
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.generateMemberCard(request, options: callOptions);

      return _mapFamilyMemberFromProto(response.member);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyAccountProto> freezeFamilyAccount({
    required String familyId,
    String? reason,
  }) async {
    try {
      final request = family_pb.FreezeFamilyAccountRequest(
        familyId: familyId,
        reason: reason ?? '',
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.freezeFamilyAccount(request, options: callOptions);

      return _mapFamilyAccountFromProto(response.familyAccount);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyAccountProto> unfreezeFamilyAccount(String familyId) async {
    try {
      final request = family_pb.UnfreezeFamilyAccountRequest(
        familyId: familyId,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.unfreezeFamilyAccount(request, options: callOptions);

      return _mapFamilyAccountFromProto(response.familyAccount);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<double> deleteFamilyAccount({
    required String familyId,
    required String confirmationCode,
  }) async {
    try {
      final request = family_pb.DeleteFamilyAccountRequest(
        familyId: familyId,
        confirmationCode: confirmationCode,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.deleteFamilyAccount(request, options: callOptions);

      return response.returnedBalance;
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyAccountProto> processMemberContribution({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    try {
      final request = family_pb.ProcessMemberContributionRequest(
        familyId: familyId,
        memberId: memberId,
        amount: amount,
        description: description ?? '',
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.processMemberContribution(request, options: callOptions);

      return _mapFamilyAccountFromProto(response.familyAccount);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  @override
  Future<FamilyAccountProto> setupFamilyAccount({
    required String familyId,
    required String fundDistributionMode,
    required bool spendingVisibilityEnabled,
    List<MemberAllocationProto> allocations = const [],
  }) async {
    try {
      final protoAllocations = allocations.map((a) => family_pb.MemberAllocation(
        memberId: a.memberId,
        amount: a.amount,
      )).toList();

      final protoMode = _mapDistributionMode(fundDistributionMode);

      final request = family_pb.SetupFamilyAccountRequest(
        familyId: familyId,
        fundDistributionMode: protoMode,
        spendingVisibilityEnabled: spendingVisibilityEnabled,
        allocations: protoAllocations,
      );

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.setupFamilyAccount(request, options: callOptions);

      return _mapFamilyAccountFromProto(response.familyAccount);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  family_pb.FundDistributionMode _mapDistributionMode(String mode) {
    switch (mode) {
      case 'shared_pool':
        return family_pb.FundDistributionMode.SHARED_POOL;
      case 'equal_split':
        return family_pb.FundDistributionMode.EQUAL_SPLIT;
      case 'custom_allocation':
        return family_pb.FundDistributionMode.CUSTOM_ALLOCATION;
      default:
        return family_pb.FundDistributionMode.CUSTOM_ALLOCATION;
    }
  }

  String _mapDistributionModeToString(family_pb.FundDistributionMode mode) {
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
      fundDistributionMode: _mapDistributionModeToString(proto.fundDistributionMode),
      setupCompleted: proto.setupCompleted,
      spendingVisibilityEnabled: proto.spendingVisibilityEnabled,
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
      memberAvatar: proto.memberAvatar.isNotEmpty ? proto.memberAvatar : null,
      transactionId: proto.transactionId.isNotEmpty ? proto.transactionId : null,
      amount: proto.amount,
      type: proto.type,
      description: proto.description,
      merchantName: proto.merchantName.isNotEmpty ? proto.merchantName : null,
      merchantCategory: proto.merchantCategory.isNotEmpty ? proto.merchantCategory : null,
      metadata: proto.metadata.isNotEmpty ? Map<String, dynamic>.from(proto.metadata) : null,
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
