import 'dart:math';
import '../models/family_account_proto.dart';

abstract class FamilyAccountRemoteDataSource {
  Future<List<FamilyAccountProto>> getFamilyAccounts({String? statusFilter});
  Future<FamilyAccountProto> getFamilyAccount(String familyId);
  Future<FamilyAccountProto> createFamilyAccount(CreateFamilyAccountRequest request);
  Future<FamilyMemberProto> addFamilyMember(AddFamilyMemberRequest request);
  Future<FamilyMemberProto> updateFamilyMember(UpdateFamilyMemberRequest request);
  Future<double> removeFamilyMember({
    required String familyId,
    required String memberId,
    String? reason,
    bool returnBalanceToPool = true,
  });
  Future<FamilyAccountProto> acceptFamilyInvitation(String invitationToken);
  Future<bool> declineFamilyInvitation(String invitationToken);
  Future<List<PendingInvitationProto>> getPendingInvitations();
  Future<List<FamilyTransactionProto>> getFamilyTransactions({
    required String familyId,
    String? memberId,
    String? type,
    int page = 1,
    int pageSize = 20,
  });
  Future<FamilyMemberProto> allocateFunds({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  });
  Future<FamilyMemberProto> generateMemberCard({
    required String familyId,
    required String memberId,
    String? cardName,
  });
  Future<FamilyAccountProto> freezeFamilyAccount({
    required String familyId,
    String? reason,
  });
  Future<FamilyAccountProto> unfreezeFamilyAccount(String familyId);
  Future<double> deleteFamilyAccount({
    required String familyId,
    required String confirmationCode,
  });
  Future<FamilyAccountProto> processMemberContribution({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  });
}

class FamilyAccountRemoteDataSourceImpl implements FamilyAccountRemoteDataSource {
  final dynamic dio;
  final dynamic secureStorage;

  FamilyAccountRemoteDataSourceImpl({
    required this.dio,
    required this.secureStorage,
  });

  // Mock data storage
  static final Map<String, FamilyAccountProto> _familyAccounts = {};
  static final Map<String, List<FamilyMemberProto>> _familyMembers = {};
  static final Map<String, List<FamilyTransactionProto>> _familyTransactions = {};
  static final Map<String, PendingInvitationProto> _pendingInvitations = {};

  final Random _random = Random();

  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString() + _random.nextInt(1000).toString();

  @override
  Future<List<FamilyAccountProto>> getFamilyAccounts({String? statusFilter}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var accounts = _familyAccounts.values.toList();

    // Apply status filter if provided
    if (statusFilter != null) {
      accounts = accounts.where((account) => account.status == statusFilter).toList();
    }

    // Include members for each account
    return accounts.map((account) {
      final members = _familyMembers[account.id] ?? [];
      return FamilyAccountProto(
        id: account.id,
        creatorId: account.creatorId,
        creatorName: account.creatorName,
        name: account.name,
        description: account.description,
        totalAllocatedBalance: account.totalAllocatedBalance,
        totalPoolBalance: account.totalPoolBalance,
        allowMemberContributions: account.allowMemberContributions,
        totalBalance: account.totalBalance,
        status: account.status,
        createdAt: account.createdAt,
        updatedAt: account.updatedAt,
        members: members,
        memberCount: account.memberCount,
        activeMemberCount: account.activeMemberCount,
      );
    }).toList();
  }

  @override
  Future<FamilyAccountProto> getFamilyAccount(String familyId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final account = _familyAccounts[familyId];
    if (account == null) {
      throw Exception('Family account not found');
    }

    // Include members
    final members = _familyMembers[familyId] ?? [];

    return FamilyAccountProto(
      id: account.id,
      creatorId: account.creatorId,
      creatorName: account.creatorName,
      name: account.name,
      description: account.description,
      totalAllocatedBalance: account.totalAllocatedBalance,
      totalPoolBalance: account.totalPoolBalance,
      allowMemberContributions: account.allowMemberContributions,
      totalBalance: account.totalBalance,
      status: account.status,
      createdAt: account.createdAt,
      updatedAt: account.updatedAt,
      members: members,
      memberCount: account.memberCount,
      activeMemberCount: account.activeMemberCount,
    );
  }

  @override
  Future<FamilyAccountProto> createFamilyAccount(CreateFamilyAccountRequest request) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final familyId = _generateId();
    final memberId = _generateId();
    final now = DateTime.now();
    final nowIso = now.toIso8601String();

    // Create admin member
    final adminMember = FamilyMemberProto(
      id: memberId,
      familyId: familyId,
      userId: request.creatorId,
      fullName: request.creatorName,
      email: request.creatorEmail,
      phone: null,
      username: null,
      avatarUrl: null,
      role: 'admin',
      allocatedBalance: request.initialFunding,
      dailySpendingLimit: 0.0,
      monthlySpendingLimit: 0.0,
      perTransactionLimit: 0.0,
      allocationPercentageCap: 100.0,
      spentToday: 0.0,
      spentThisMonth: 0.0,
      remainingBalance: request.initialFunding,
      invitationStatus: 'accepted',
      invitationToken: '',
      invitationExpiresAt: '',
      cardLastFour: null,
      hasCard: false,
      joinedAt: nowIso,
      createdAt: nowIso,
      updatedAt: nowIso,
    );

    final account = FamilyAccountProto(
      id: familyId,
      creatorId: request.creatorId,
      creatorName: request.creatorName,
      name: request.name,
      description: request.description,
      totalAllocatedBalance: request.initialFunding,
      totalPoolBalance: 0.0,
      allowMemberContributions: request.allowMemberContributions,
      totalBalance: request.initialFunding,
      status: 'active',
      createdAt: nowIso,
      updatedAt: nowIso,
      members: [adminMember],
      memberCount: 1,
      activeMemberCount: 1,
    );

    _familyAccounts[familyId] = account;
    _familyMembers[familyId] = [adminMember];
    _familyTransactions[familyId] = [];

    // Add initial funding transaction
    _familyTransactions[familyId]!.add(FamilyTransactionProto(
      id: _generateId(),
      familyId: familyId,
      memberId: memberId,
      memberName: request.creatorName,
      amount: request.initialFunding,
      type: 'allocation',
      description: 'Initial funding',
      createdAt: nowIso,
    ));

    return account;
  }

  @override
  Future<FamilyMemberProto> addFamilyMember(AddFamilyMemberRequest request) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final memberId = _generateId();
    final now = DateTime.now();
    final nowIso = now.toIso8601String();

    // Create invitation token
    final invitationToken = 'INV_${_generateId()}';
    final invitationExpiresAt = now.add(const Duration(days: 7)).toIso8601String();

    final member = FamilyMemberProto(
      id: memberId,
      familyId: request.familyId,
      userId: '', // Will be filled when invitation is accepted
      fullName: request.fullName,
      email: request.invitationMethod == 'email' ? request.invitationDestination : null,
      phone: request.invitationMethod == 'phone' ? request.invitationDestination : null,
      username: null,
      avatarUrl: null,
      role: request.role,
      allocatedBalance: request.initialAllocation,
      dailySpendingLimit: request.dailyLimit,
      monthlySpendingLimit: request.monthlyLimit,
      perTransactionLimit: request.perTransactionLimit,
      allocationPercentageCap: request.allocationPercentageCap,
      spentToday: 0.0,
      spentThisMonth: 0.0,
      remainingBalance: request.initialAllocation,
      invitationStatus: 'pending',
      invitationToken: invitationToken,
      invitationExpiresAt: invitationExpiresAt,
      cardLastFour: null,
      hasCard: false,
      joinedAt: null,
      createdAt: nowIso,
      updatedAt: nowIso,
    );

    // Add to pending invitations
    final familyAccount = _familyAccounts[request.familyId];
    _pendingInvitations[invitationToken] = PendingInvitationProto(
      invitationToken: invitationToken,
      familyId: request.familyId,
      familyName: familyAccount?.name ?? '',
      creatorName: familyAccount?.creatorName ?? '',
      initialAllocation: request.initialAllocation,
      dailyLimit: request.dailyLimit,
      monthlyLimit: request.monthlyLimit,
      perTransactionLimit: request.perTransactionLimit,
      allocationPercentageCap: request.allocationPercentageCap,
      invitedBy: request.familyId, // Use family ID as inviter reference
      invitedEmail: member.email,
      invitedPhone: member.phone,
      role: request.role,
      personalMessage: request.personalMessage,
      createdAt: nowIso,
      expiresAt: invitationExpiresAt,
    );

    // Add member to family (pending status)
    _familyMembers.putIfAbsent(request.familyId, () => []).add(member);

    // Add transaction
    _familyTransactions.putIfAbsent(request.familyId, () => []).add(FamilyTransactionProto(
      id: _generateId(),
      familyId: request.familyId,
      memberId: memberId,
      memberName: member.fullName.isNotEmpty ? member.fullName : (member.email ?? member.phone ?? 'Pending Member'),
      amount: request.initialAllocation,
      type: 'allocation',
      description: 'Initial allocation for pending member',
      createdAt: nowIso,
    ));

    return member;
  }

  @override
  Future<FamilyMemberProto> updateFamilyMember(UpdateFamilyMemberRequest request) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final members = _familyMembers[request.familyId] ?? [];
    final memberIndex = members.indexWhere((m) => m.id == request.memberId);

    if (memberIndex == -1) {
      throw Exception('Member not found');
    }

    final existingMember = members[memberIndex];
    final nowIso = DateTime.now().toIso8601String();

    // Build updated member with only provided fields
    final updatedMember = FamilyMemberProto(
      id: existingMember.id,
      familyId: existingMember.familyId,
      userId: existingMember.userId,
      fullName: existingMember.fullName,
      email: existingMember.email,
      phone: existingMember.phone,
      username: existingMember.username,
      avatarUrl: existingMember.avatarUrl,
      role: request.role ?? existingMember.role,
      allocatedBalance: request.allocatedBalance ?? existingMember.allocatedBalance,
      dailySpendingLimit: request.dailySpendingLimit ?? existingMember.dailySpendingLimit,
      monthlySpendingLimit: request.monthlySpendingLimit ?? existingMember.monthlySpendingLimit,
      perTransactionLimit: request.perTransactionLimit ?? existingMember.perTransactionLimit,
      allocationPercentageCap: request.allocationPercentageCap ?? existingMember.allocationPercentageCap,
      spentToday: existingMember.spentToday,
      spentThisMonth: existingMember.spentThisMonth,
      remainingBalance: existingMember.remainingBalance,
      invitationStatus: existingMember.invitationStatus,
      invitationToken: existingMember.invitationToken,
      invitationExpiresAt: existingMember.invitationExpiresAt,
      cardLastFour: existingMember.cardLastFour,
      hasCard: existingMember.hasCard,
      joinedAt: existingMember.joinedAt,
      createdAt: existingMember.createdAt,
      updatedAt: nowIso,
    );

    members[memberIndex] = updatedMember;

    // Update total allocated balance
    _updateFamilyBalance(request.familyId);

    return updatedMember;
  }

  @override
  Future<double> removeFamilyMember({
    required String familyId,
    required String memberId,
    String? reason,
    bool returnBalanceToPool = true,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final members = _familyMembers[familyId] ?? [];
    final memberIndex = members.indexWhere((m) => m.id == memberId);

    if (memberIndex == -1) {
      throw Exception('Member not found');
    }

    final member = members[memberIndex];
    final returnedBalance = member.allocatedBalance;

    // Remove member
    members.removeAt(memberIndex);

    // Return balance to pool if requested
    if (returnBalanceToPool) {
      final account = _familyAccounts[familyId];
      if (account != null) {
        final nowIso = DateTime.now().toIso8601String();
        _familyAccounts[familyId] = FamilyAccountProto(
          id: account.id,
          creatorId: account.creatorId,
          creatorName: account.creatorName,
          name: account.name,
          description: account.description,
          totalAllocatedBalance: account.totalAllocatedBalance - returnedBalance,
          totalPoolBalance: account.totalPoolBalance + returnedBalance,
          allowMemberContributions: account.allowMemberContributions,
          totalBalance: account.totalBalance,
          status: account.status,
          createdAt: account.createdAt,
          updatedAt: nowIso,
          members: account.members,
          memberCount: account.memberCount,
          activeMemberCount: account.activeMemberCount,
        );
      }
    }

    // Add transaction
    final nowIso = DateTime.now().toIso8601String();
    _familyTransactions.putIfAbsent(familyId, () => []).add(FamilyTransactionProto(
      id: _generateId(),
      familyId: familyId,
      memberId: memberId,
      memberName: member.fullName,
      amount: returnedBalance,
      type: 'refund',
      description: 'Member removed${reason != null ? ': $reason' : ''}',
      createdAt: nowIso,
    ));

    return returnedBalance;
  }

  @override
  Future<FamilyAccountProto> acceptFamilyInvitation(String invitationToken) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final invitation = _pendingInvitations[invitationToken];
    if (invitation == null) {
      throw Exception('Invitation not found or expired');
    }

    final members = _familyMembers[invitation.familyId] ?? [];
    final memberIndex = members.indexWhere((m) =>
        m.email == invitation.invitedEmail || m.phone == invitation.invitedPhone);

    if (memberIndex == -1) {
      throw Exception('Member not found');
    }

    final member = members[memberIndex];
    final nowIso = DateTime.now().toIso8601String();

    // Update member status to accepted
    final updatedMember = FamilyMemberProto(
      id: member.id,
      familyId: member.familyId,
      userId: _generateId(), // Simulate user ID generation
      fullName: member.fullName,
      email: member.email,
      phone: member.phone,
      username: member.username,
      avatarUrl: member.avatarUrl,
      role: member.role,
      allocatedBalance: member.allocatedBalance,
      dailySpendingLimit: member.dailySpendingLimit,
      monthlySpendingLimit: member.monthlySpendingLimit,
      perTransactionLimit: member.perTransactionLimit,
      allocationPercentageCap: member.allocationPercentageCap,
      spentToday: member.spentToday,
      spentThisMonth: member.spentThisMonth,
      remainingBalance: member.remainingBalance,
      invitationStatus: 'accepted',
      invitationToken: member.invitationToken,
      invitationExpiresAt: member.invitationExpiresAt,
      cardLastFour: member.cardLastFour,
      hasCard: member.hasCard,
      joinedAt: nowIso,
      createdAt: member.createdAt,
      updatedAt: nowIso,
    );

    members[memberIndex] = updatedMember;

    // Remove from pending invitations
    _pendingInvitations.remove(invitationToken);

    // Get and return the family account
    return getFamilyAccount(invitation.familyId);
  }

  @override
  Future<bool> declineFamilyInvitation(String invitationToken) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final invitation = _pendingInvitations[invitationToken];
    if (invitation == null) {
      throw Exception('Invitation not found or expired');
    }

    // Remove from pending invitations
    _pendingInvitations.remove(invitationToken);

    // Remove the pending member
    final members = _familyMembers[invitation.familyId] ?? [];
    members.removeWhere((m) =>
        m.email == invitation.invitedEmail || m.phone == invitation.invitedPhone);

    return true;
  }

  @override
  Future<List<PendingInvitationProto>> getPendingInvitations() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _pendingInvitations.values.toList();
  }

  @override
  Future<List<FamilyTransactionProto>> getFamilyTransactions({
    required String familyId,
    String? memberId,
    String? type,
    int page = 1,
    int pageSize = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    var transactions = _familyTransactions[familyId] ?? [];

    // Apply filters
    if (memberId != null) {
      transactions = transactions.where((t) => t.memberId == memberId).toList();
    }
    if (type != null) {
      transactions = transactions.where((t) => t.type == type).toList();
    }

    // Apply pagination
    final start = (page - 1) * pageSize;
    final end = start + pageSize;

    if (start >= transactions.length) {
      return [];
    }

    return transactions.sublist(start, end.clamp(0, transactions.length));
  }

  @override
  Future<FamilyMemberProto> allocateFunds({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final account = _familyAccounts[familyId];
    if (account == null) {
      throw Exception('Family account not found');
    }

    if (account.totalPoolBalance < amount) {
      throw Exception('Insufficient pool balance');
    }

    final members = _familyMembers[familyId] ?? [];
    final memberIndex = members.indexWhere((m) => m.id == memberId);

    if (memberIndex == -1) {
      throw Exception('Member not found');
    }

    final member = members[memberIndex];
    final nowIso = DateTime.now().toIso8601String();

    // Update member allocation
    final updatedMember = FamilyMemberProto(
      id: member.id,
      familyId: member.familyId,
      userId: member.userId,
      fullName: member.fullName,
      email: member.email,
      phone: member.phone,
      username: member.username,
      avatarUrl: member.avatarUrl,
      role: member.role,
      allocatedBalance: member.allocatedBalance + amount,
      dailySpendingLimit: member.dailySpendingLimit,
      monthlySpendingLimit: member.monthlySpendingLimit,
      perTransactionLimit: member.perTransactionLimit,
      allocationPercentageCap: member.allocationPercentageCap,
      spentToday: member.spentToday,
      spentThisMonth: member.spentThisMonth,
      remainingBalance: member.remainingBalance + amount,
      invitationStatus: member.invitationStatus,
      invitationToken: member.invitationToken,
      invitationExpiresAt: member.invitationExpiresAt,
      cardLastFour: member.cardLastFour,
      hasCard: member.hasCard,
      joinedAt: member.joinedAt,
      createdAt: member.createdAt,
      updatedAt: nowIso,
    );

    members[memberIndex] = updatedMember;

    // Update account balances
    _familyAccounts[familyId] = FamilyAccountProto(
      id: account.id,
      creatorId: account.creatorId,
      creatorName: account.creatorName,
      name: account.name,
      description: account.description,
      totalAllocatedBalance: account.totalAllocatedBalance + amount,
      totalPoolBalance: account.totalPoolBalance - amount,
      allowMemberContributions: account.allowMemberContributions,
      totalBalance: account.totalBalance,
      status: account.status,
      createdAt: account.createdAt,
      updatedAt: nowIso,
      members: account.members,
      memberCount: account.memberCount,
      activeMemberCount: account.activeMemberCount,
    );

    // Add transaction
    _familyTransactions.putIfAbsent(familyId, () => []).add(FamilyTransactionProto(
      id: _generateId(),
      familyId: familyId,
      memberId: memberId,
      memberName: member.fullName,
      amount: amount,
      type: 'allocation',
      description: description ?? 'Funds allocated',
      createdAt: nowIso,
    ));

    return updatedMember;
  }

  @override
  Future<FamilyMemberProto> generateMemberCard({
    required String familyId,
    required String memberId,
    String? cardName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final members = _familyMembers[familyId] ?? [];
    final memberIndex = members.indexWhere((m) => m.id == memberId);

    if (memberIndex == -1) {
      throw Exception('Member not found');
    }

    final member = members[memberIndex];
    final nowIso = DateTime.now().toIso8601String();

    // Simulate card generation with random last 4 digits
    final cardLastFour = _random.nextInt(10000).toString().padLeft(4, '0');

    final updatedMember = FamilyMemberProto(
      id: member.id,
      familyId: member.familyId,
      userId: member.userId,
      fullName: member.fullName,
      email: member.email,
      phone: member.phone,
      username: member.username,
      avatarUrl: member.avatarUrl,
      role: member.role,
      allocatedBalance: member.allocatedBalance,
      dailySpendingLimit: member.dailySpendingLimit,
      monthlySpendingLimit: member.monthlySpendingLimit,
      perTransactionLimit: member.perTransactionLimit,
      allocationPercentageCap: member.allocationPercentageCap,
      spentToday: member.spentToday,
      spentThisMonth: member.spentThisMonth,
      remainingBalance: member.remainingBalance,
      invitationStatus: member.invitationStatus,
      invitationToken: member.invitationToken,
      invitationExpiresAt: member.invitationExpiresAt,
      cardLastFour: cardLastFour,
      hasCard: true,
      joinedAt: member.joinedAt,
      createdAt: member.createdAt,
      updatedAt: nowIso,
    );

    members[memberIndex] = updatedMember;

    return updatedMember;
  }

  @override
  Future<FamilyAccountProto> freezeFamilyAccount({
    required String familyId,
    String? reason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final account = _familyAccounts[familyId];
    if (account == null) {
      throw Exception('Family account not found');
    }

    final nowIso = DateTime.now().toIso8601String();
    final updatedAccount = FamilyAccountProto(
      id: account.id,
      creatorId: account.creatorId,
      creatorName: account.creatorName,
      name: account.name,
      description: account.description,
      totalAllocatedBalance: account.totalAllocatedBalance,
      totalPoolBalance: account.totalPoolBalance,
      allowMemberContributions: account.allowMemberContributions,
      totalBalance: account.totalBalance,
      status: 'frozen',
      createdAt: account.createdAt,
      updatedAt: nowIso,
      members: account.members,
      memberCount: account.memberCount,
      activeMemberCount: account.activeMemberCount,
    );

    _familyAccounts[familyId] = updatedAccount;

    return updatedAccount;
  }

  @override
  Future<FamilyAccountProto> unfreezeFamilyAccount(String familyId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final account = _familyAccounts[familyId];
    if (account == null) {
      throw Exception('Family account not found');
    }

    final nowIso = DateTime.now().toIso8601String();
    final updatedAccount = FamilyAccountProto(
      id: account.id,
      creatorId: account.creatorId,
      creatorName: account.creatorName,
      name: account.name,
      description: account.description,
      totalAllocatedBalance: account.totalAllocatedBalance,
      totalPoolBalance: account.totalPoolBalance,
      allowMemberContributions: account.allowMemberContributions,
      totalBalance: account.totalBalance,
      status: 'active',
      createdAt: account.createdAt,
      updatedAt: nowIso,
      members: account.members,
      memberCount: account.memberCount,
      activeMemberCount: account.activeMemberCount,
    );

    _familyAccounts[familyId] = updatedAccount;

    return updatedAccount;
  }

  @override
  Future<double> deleteFamilyAccount({
    required String familyId,
    required String confirmationCode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final account = _familyAccounts[familyId];
    if (account == null) {
      throw Exception('Family account not found');
    }

    // Calculate total balance to return
    final totalBalance = account.totalAllocatedBalance + account.totalPoolBalance;

    // Remove account
    _familyAccounts.remove(familyId);
    _familyMembers.remove(familyId);
    _familyTransactions.remove(familyId);

    return totalBalance;
  }

  @override
  Future<FamilyAccountProto> processMemberContribution({
    required String familyId,
    required String memberId,
    required double amount,
    String? description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final account = _familyAccounts[familyId];
    if (account == null) {
      throw Exception('Family account not found');
    }

    if (!account.allowMemberContributions) {
      throw Exception('Member contributions are not allowed for this account');
    }

    final members = _familyMembers[familyId] ?? [];
    final memberIndex = members.indexWhere((m) => m.id == memberId);

    if (memberIndex == -1) {
      throw Exception('Member not found');
    }

    final member = members[memberIndex];
    final nowIso = DateTime.now().toIso8601String();

    // Add to pool balance
    final updatedAccount = FamilyAccountProto(
      id: account.id,
      creatorId: account.creatorId,
      creatorName: account.creatorName,
      name: account.name,
      description: account.description,
      totalAllocatedBalance: account.totalAllocatedBalance,
      totalPoolBalance: account.totalPoolBalance + amount,
      allowMemberContributions: account.allowMemberContributions,
      totalBalance: account.totalBalance + amount,
      status: account.status,
      createdAt: account.createdAt,
      updatedAt: nowIso,
      members: account.members,
      memberCount: account.memberCount,
      activeMemberCount: account.activeMemberCount,
    );

    _familyAccounts[familyId] = updatedAccount;

    // Add transaction
    _familyTransactions.putIfAbsent(familyId, () => []).add(FamilyTransactionProto(
      id: _generateId(),
      familyId: familyId,
      memberId: memberId,
      memberName: member.fullName,
      amount: amount,
      type: 'contribution',
      description: description ?? 'Member contribution',
      createdAt: nowIso,
    ));

    return updatedAccount;
  }

  // Helper method to update family balance after member changes
  void _updateFamilyBalance(String familyId) {
    final members = _familyMembers[familyId] ?? [];
    final account = _familyAccounts[familyId];

    if (account != null) {
      final totalAllocated = members.fold<double>(
        0.0,
        (sum, member) => sum + member.allocatedBalance,
      );
      final nowIso = DateTime.now().toIso8601String();

      _familyAccounts[familyId] = FamilyAccountProto(
        id: account.id,
        creatorId: account.creatorId,
        creatorName: account.creatorName,
        name: account.name,
        description: account.description,
        totalAllocatedBalance: totalAllocated,
        totalPoolBalance: account.totalPoolBalance,
        allowMemberContributions: account.allowMemberContributions,
        totalBalance: account.totalBalance,
        status: account.status,
        createdAt: account.createdAt,
        updatedAt: nowIso,
        members: members,
        memberCount: account.memberCount,
        activeMemberCount: account.activeMemberCount,
      );
    }
  }
}
