import 'dart:math';
import '../models/group_account_models.dart';
import '../../domain/entities/group_entities.dart';

abstract class GroupAccountRemoteDataSource {
  Future<List<GroupAccountModel>> getUserGroups(String userId);
  Future<GroupAccountModel> getGroupById(String groupId);
  Future<GroupAccountModel> createGroup({
    required String name,
    required String description,
    required String adminId,
  });
  Future<GroupAccountModel> updateGroup(GroupAccountModel group);
  Future<void> deleteGroup(String groupId);
  
  Future<List<GroupMemberModel>> getGroupMembers(String groupId);
  Future<GroupMemberModel> addMemberToGroup({
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    String? profileImage,
    GroupMemberRole role = GroupMemberRole.member,
  });
  Future<GroupMemberModel> updateMemberRole({
    required String groupId,
    required String memberId,
    required GroupMemberRole newRole,
  });
  Future<void> removeMemberFromGroup({
    required String groupId,
    required String memberId,
  });
  Future<List<GroupMemberModel>> searchUsers(String query);
  
  Future<List<ContributionModel>> getGroupContributions(String groupId);
  Future<ContributionModel> getContributionById(String contributionId);
  Future<ContributionModel> createContribution({
    required String groupId,
    required String title,
    required String description,
    required double targetAmount,
    required String currency,
    required DateTime deadline,
    required String createdBy,
    ContributionType type = ContributionType.oneTime,
    ContributionFrequency? frequency,
    double? regularAmount,
    DateTime? startDate,
    int? totalCycles,
    List<String>? memberRotationOrder,
    bool autoPayEnabled = false,
    double? penaltyAmount,
    int? gracePeriodDays,
    bool allowPartialPayments = true,
    double? minimumBalance,
  });
  Future<ContributionModel> updateContribution(ContributionModel contribution);
  Future<void> deleteContribution(String contributionId);
  
  Future<List<ContributionPaymentModel>> getContributionPayments(String contributionId);
  Future<ContributionPaymentModel> makeContributionPayment({
    required String contributionId,
    required String groupId,
    required String userId,
    required String userName,
    required double amount,
    required String currency,
    String? notes,
  });
  Future<ContributionPaymentModel> updatePaymentStatus({
    required String paymentId,
    required PaymentStatus status,
    String? transactionId,
  });
  
  Future<ContributionModel> processScheduledPayments(String contributionId);
  Future<List<ContributionModel>> getOverdueContributions(String userId);
  Future<ContributionModel> updatePaymentSchedule({
    required String contributionId,
    required DateTime nextPaymentDate,
    int? currentCycle,
  });
  
  Future<List<PayoutScheduleModel>> getPayoutSchedule(String contributionId);
  Future<PayoutTransactionModel> processPayoutTransaction({
    required String contributionId,
    required String recipientUserId,
    required double amount,
    String? paymentMethod,
  });
  Future<PayoutTransactionModel> updatePayoutStatus({
    required String payoutId,
    required PayoutTransactionStatus status,
    String? transactionId,
    String? failureReason,
  });
  Future<ContributionModel> calculateAndProcessPayout(String contributionId);
  Future<ContributionModel> advancePayoutRotation(String contributionId);
  
  Future<ContributionReceiptModel> generateReceipt(String paymentId);
  Future<List<ContributionReceiptModel>> getUserReceipts(String userId);
  
  Future<ContributionTranscriptModel> generateContributionTranscript(String contributionId);
  
  Future<Map<String, dynamic>> getGroupStatistics(String groupId);
  Future<Map<String, dynamic>> getUserContributionStats(String userId);
  Future<Map<String, dynamic>> getContributionAnalytics(String contributionId);
}

class GroupAccountRemoteDataSourceImpl implements GroupAccountRemoteDataSource {
  // Mock data storage
  static final Map<String, GroupAccountModel> _groups = {};
  static final Map<String, List<GroupMemberModel>> _groupMembers = {};
  static final Map<String, List<ContributionModel>> _groupContributions = {};
  static final Map<String, List<ContributionPaymentModel>> _contributionPayments = {};
  static final Map<String, ContributionReceiptModel> _receipts = {};
  
  final Random _random = Random();

  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString() + _random.nextInt(1000).toString();

  @override
  Future<List<GroupAccountModel>> getUserGroups(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    // Return groups where user is admin or member
    return _groups.values.where((group) {
      return group.adminId == userId || 
             (_groupMembers[group.id]?.any((member) => member.userId == userId) ?? false);
    }).toList();
  }

  @override
  Future<GroupAccountModel> getGroupById(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final group = _groups[groupId];
    if (group == null) {
      throw Exception('Group not found');
    }
    
    // Include members and contributions
    final members = _groupMembers[groupId] ?? [];
    final contributions = _groupContributions[groupId] ?? [];
    
    return group.copyWith(
      members: members,
      contributions: contributions,
    );
  }

  @override
  Future<GroupAccountModel> createGroup({
    required String name,
    required String description,
    required String adminId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final groupId = _generateId();
    final now = DateTime.now();
    
    // Create admin member
    final adminMember = GroupMemberModel(
      id: _generateId(),
      userId: adminId,
      userName: 'Admin User', // In real app, fetch from user service
      email: 'admin@example.com',
      role: GroupMemberRole.admin,
      joinedAt: now,
      status: GroupMemberStatus.active,
    );
    
    final group = GroupAccountModel(
      id: groupId,
      name: name,
      description: description,
      adminId: adminId,
      members: [adminMember],
      contributions: [],
      createdAt: now,
      updatedAt: now,
      status: GroupAccountStatus.active,
    );
    
    _groups[groupId] = group;
    _groupMembers[groupId] = [adminMember];
    _groupContributions[groupId] = [];
    
    return group;
  }

  @override
  Future<GroupAccountModel> updateGroup(GroupAccountModel group) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final updatedGroup = group.copyWith(
      updatedAt: DateTime.now(),
    );
    
    _groups[group.id] = updatedGroup;
    return updatedGroup;
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    _groups.remove(groupId);
    _groupMembers.remove(groupId);
    _groupContributions.remove(groupId);
  }

  @override
  Future<List<GroupMemberModel>> getGroupMembers(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _groupMembers[groupId] ?? [];
  }

  @override
  Future<GroupMemberModel> addMemberToGroup({
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    String? profileImage,
    GroupMemberRole role = GroupMemberRole.member,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final member = GroupMemberModel(
      id: _generateId(),
      userId: userId,
      userName: userName,
      email: email,
      profileImage: profileImage,
      role: role,
      joinedAt: DateTime.now(),
      status: GroupMemberStatus.active,
    );
    
    _groupMembers.putIfAbsent(groupId, () => []).add(member);
    return member;
  }

  @override
  Future<GroupMemberModel> updateMemberRole({
    required String groupId,
    required String memberId,
    required GroupMemberRole newRole,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final members = _groupMembers[groupId] ?? [];
    final memberIndex = members.indexWhere((m) => m.id == memberId);
    
    if (memberIndex == -1) {
      throw Exception('Member not found');
    }
    
    final updatedMember = members[memberIndex].copyWith(role: newRole);
    members[memberIndex] = updatedMember;
    
    return updatedMember;
  }

  @override
  Future<void> removeMemberFromGroup({
    required String groupId,
    required String memberId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final members = _groupMembers[groupId] ?? [];
    members.removeWhere((m) => m.id == memberId);
  }

  @override
  Future<List<GroupMemberModel>> searchUsers(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Mock user search results
    final mockUsers = [
      GroupMemberModel(
        id: _generateId(),
        userId: 'user1',
        userName: 'John Doe',
        email: 'john.doe@example.com',
        role: GroupMemberRole.member,
        joinedAt: DateTime.now(),
        status: GroupMemberStatus.active,
      ),
      GroupMemberModel(
        id: _generateId(),
        userId: 'user2',
        userName: 'Jane Smith',
        email: 'jane.smith@example.com',
        role: GroupMemberRole.member,
        joinedAt: DateTime.now(),
        status: GroupMemberStatus.active,
      ),
    ];
    
    return mockUsers.where((user) => 
      user.userName.toLowerCase().contains(query.toLowerCase()) ||
      user.email.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  @override
  Future<List<ContributionModel>> getGroupContributions(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _groupContributions[groupId] ?? [];
  }

  @override
  Future<ContributionModel> getContributionById(String contributionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    for (final contributions in _groupContributions.values) {
      final contribution = contributions.where((c) => c.id == contributionId).firstOrNull;
      if (contribution != null) {
        // Include payments
        final payments = _contributionPayments[contributionId] ?? [];
        return contribution.copyWith(payments: payments);
      }
    }
    
    throw Exception('Contribution not found');
  }

  @override
  Future<ContributionModel> createContribution({
    required String groupId,
    required String title,
    required String description,
    required double targetAmount,
    required String currency,
    required DateTime deadline,
    required String createdBy,
    ContributionType type = ContributionType.oneTime,
    ContributionFrequency? frequency,
    double? regularAmount,
    DateTime? startDate,
    int? totalCycles,
    List<String>? memberRotationOrder,
    bool autoPayEnabled = false,
    double? penaltyAmount,
    int? gracePeriodDays,
    bool allowPartialPayments = true,
    double? minimumBalance,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final contributionId = _generateId();
    final now = DateTime.now();
    final effectiveStartDate = startDate ?? now;
    
    // Generate payout schedule for rotating savings
    List<PayoutScheduleModel> payoutSchedule = [];
    if (type == ContributionType.rotatingSavings && memberRotationOrder != null && frequency != null) {
      final members = _groupMembers[groupId] ?? [];
      payoutSchedule = _generatePayoutSchedule(
        contributionId,
        memberRotationOrder,
        members,
        effectiveStartDate,
        frequency,
        regularAmount ?? (targetAmount / memberRotationOrder.length),
      );
    }
    
    final contribution = ContributionModel(
      id: contributionId,
      groupId: groupId,
      title: title,
      description: description,
      targetAmount: targetAmount,
      currentAmount: 0.0,
      currency: currency,
      deadline: deadline,
      createdAt: now,
      updatedAt: now,
      status: ContributionStatus.active,
      createdBy: createdBy,
      payments: [],
      type: type,
      frequency: frequency,
      regularAmount: regularAmount,
      nextPaymentDate: frequency != null ? frequency.calculateNextDate(effectiveStartDate) : null,
      startDate: effectiveStartDate,
      totalCycles: totalCycles,
      currentCycle: 1,
      payoutSchedule: payoutSchedule,
      currentPayoutRecipient: payoutSchedule.isNotEmpty ? payoutSchedule.first.userId : null,
      nextPayoutDate: payoutSchedule.isNotEmpty ? payoutSchedule.first.scheduledDate : null,
      payoutHistory: [],
      autoPayEnabled: autoPayEnabled,
      penaltyAmount: penaltyAmount,
      gracePeriodDays: gracePeriodDays,
      allowPartialPayments: allowPartialPayments,
      minimumBalance: minimumBalance,
    );
    
    _groupContributions.putIfAbsent(groupId, () => []).add(contribution);
    _contributionPayments[contributionId] = [];
    
    return contribution;
  }

  List<PayoutScheduleModel> _generatePayoutSchedule(
    String contributionId,
    List<String> memberIds,
    List<GroupMemberModel> members,
    DateTime startDate,
    ContributionFrequency frequency,
    double expectedAmount,
  ) {
    final schedule = <PayoutScheduleModel>[];
    var currentDate = startDate;
    
    for (int i = 0; i < memberIds.length; i++) {
      final memberId = memberIds[i];
      final member = members.firstWhere(
        (m) => m.userId == memberId,
        orElse: () => GroupMemberModel(
          id: _generateId(),
          userId: memberId,
          userName: 'Unknown User',
          email: 'unknown@example.com',
          role: GroupMemberRole.member,
          joinedAt: DateTime.now(),
          status: GroupMemberStatus.active,
        ),
      );
      
      // Calculate payout date (typically after all members have contributed)
      final payoutDate = frequency.calculateNextDate(currentDate);
      
      schedule.add(PayoutScheduleModel(
        id: _generateId(),
        userId: member.userId,
        userName: member.userName,
        position: i + 1,
        scheduledDate: payoutDate,
        expectedAmount: expectedAmount * memberIds.length, // Total pool amount
        status: i == 0 ? PayoutStatus.pending : PayoutStatus.pending,
      ));
      
      currentDate = frequency.calculateNextDate(currentDate);
    }
    
    return schedule;
  }

  @override
  Future<ContributionModel> updateContribution(ContributionModel contribution) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final groupContributions = _groupContributions[contribution.groupId] ?? [];
    final index = groupContributions.indexWhere((c) => c.id == contribution.id);
    
    if (index == -1) {
      throw Exception('Contribution not found');
    }
    
    final updatedContribution = contribution.copyWith(
      updatedAt: DateTime.now(),
    );
    
    groupContributions[index] = updatedContribution;
    return updatedContribution;
  }

  @override
  Future<void> deleteContribution(String contributionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    for (final contributions in _groupContributions.values) {
      contributions.removeWhere((c) => c.id == contributionId);
    }
    _contributionPayments.remove(contributionId);
  }

  @override
  Future<List<ContributionPaymentModel>> getContributionPayments(String contributionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _contributionPayments[contributionId] ?? [];
  }

  @override
  Future<ContributionPaymentModel> makeContributionPayment({
    required String contributionId,
    required String groupId,
    required String userId,
    required String userName,
    required double amount,
    required String currency,
    String? notes,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    final payment = ContributionPaymentModel(
      id: _generateId(),
      contributionId: contributionId,
      groupId: groupId,
      userId: userId,
      userName: userName,
      amount: amount,
      currency: currency,
      paymentDate: DateTime.now(),
      status: PaymentStatus.completed, // Simulate successful payment
      transactionId: 'TXN_${_generateId()}',
      notes: notes,
    );
    
    _contributionPayments.putIfAbsent(contributionId, () => []).add(payment);
    
    // Update contribution current amount
    final groupContributions = _groupContributions[groupId] ?? [];
    final contributionIndex = groupContributions.indexWhere((c) => c.id == contributionId);
    if (contributionIndex != -1) {
      final contribution = groupContributions[contributionIndex];
      final updatedContribution = contribution.copyWith(
        currentAmount: contribution.currentAmount + amount,
        updatedAt: DateTime.now(),
      );
      groupContributions[contributionIndex] = updatedContribution;
    }
    
    return payment;
  }

  @override
  Future<ContributionPaymentModel> updatePaymentStatus({
    required String paymentId,
    required PaymentStatus status,
    String? transactionId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    for (final payments in _contributionPayments.values) {
      final paymentIndex = payments.indexWhere((p) => p.id == paymentId);
      if (paymentIndex != -1) {
        final updatedPayment = payments[paymentIndex].copyWith(
          status: status,
          transactionId: transactionId ?? payments[paymentIndex].transactionId,
        );
        payments[paymentIndex] = updatedPayment;
        return updatedPayment;
      }
    }
    
    throw Exception('Payment not found');
  }

  @override
  Future<ContributionModel> processScheduledPayments(String contributionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Find the contribution
    ContributionModel? contribution;
    String? groupId;
    for (final entry in _groupContributions.entries) {
      groupId = entry.key;
      contribution = entry.value.where((c) => c.id == contributionId).firstOrNull;
      if (contribution != null) break;
    }
    
    if (contribution == null || groupId == null) {
      throw Exception('Contribution not found');
    }
    
    // Check if auto-pay is enabled and payment is due
    if (!contribution.autoPayEnabled || 
        contribution.nextPaymentDate == null || 
        DateTime.now().isBefore(contribution.nextPaymentDate!)) {
      return contribution;
    }
    
    // Process automatic payments for each member (simulate)
    final members = _groupMembers[groupId] ?? [];
    final paymentAmount = contribution.regularAmount ?? 0;
    
    for (final member in members) {
      if (member.status == GroupMemberStatus.active) {
        try {
          await makeContributionPayment(
            contributionId: contributionId,
            groupId: groupId,
            userId: member.userId,
            userName: member.userName,
            amount: paymentAmount,
            currency: contribution.currency,
            notes: 'Automatic scheduled payment',
          );
        } catch (e) {
          // Log failed automatic payment
          print('Failed automatic payment for ${member.userName}: $e');
        }
      }
    }
    
    // Update next payment date
    final nextPaymentDate = contribution.frequency?.calculateNextDate(contribution.nextPaymentDate!);
    
    return await updatePaymentSchedule(
      contributionId: contributionId,
      nextPaymentDate: nextPaymentDate ?? contribution.nextPaymentDate!,
      currentCycle: (contribution.currentCycle ?? 0) + 1,
    );
  }

  @override
  Future<List<ContributionModel>> getOverdueContributions(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final overdueContributions = <ContributionModel>[];
    final now = DateTime.now();
    
    for (final contributions in _groupContributions.values) {
      for (final contribution in contributions) {
        // Check if user is a member and contribution is overdue
        final groupMembers = _groupMembers[contribution.groupId] ?? [];
        final isMember = groupMembers.any((m) => m.userId == userId);
        
        if (isMember && 
            contribution.nextPaymentDate != null && 
            now.isAfter(contribution.nextPaymentDate!) &&
            contribution.status == ContributionStatus.active) {
          overdueContributions.add(contribution);
        }
      }
    }
    
    return overdueContributions;
  }

  @override
  Future<ContributionModel> updatePaymentSchedule({
    required String contributionId,
    required DateTime nextPaymentDate,
    int? currentCycle,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Find the contribution
    ContributionModel? contribution;
    String? groupId;
    for (final entry in _groupContributions.entries) {
      groupId = entry.key;
      contribution = entry.value.where((c) => c.id == contributionId).firstOrNull;
      if (contribution != null) break;
    }
    
    if (contribution == null || groupId == null) {
      throw Exception('Contribution not found');
    }
    
    final updatedContribution = contribution.copyWith(
      nextPaymentDate: nextPaymentDate,
      currentCycle: currentCycle ?? contribution.currentCycle,
      updatedAt: DateTime.now(),
    );
    
    // Update in storage
    final groupContributions = _groupContributions[groupId]!;
    final index = groupContributions.indexWhere((c) => c.id == contributionId);
    groupContributions[index] = updatedContribution;
    
    return updatedContribution;
  }

  @override
  Future<List<PayoutScheduleModel>> getPayoutSchedule(String contributionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    for (final contributions in _groupContributions.values) {
      final contribution = contributions.where((c) => c.id == contributionId).firstOrNull;
      if (contribution != null) {
        return contribution.payoutSchedule.cast<PayoutScheduleModel>();
      }
    }
    
    throw Exception('Contribution not found');
  }

  @override
  Future<PayoutTransactionModel> processPayoutTransaction({
    required String contributionId,
    required String recipientUserId,
    required double amount,
    String? paymentMethod,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Find the contribution
    ContributionModel? contribution;
    String? groupId;
    for (final entry in _groupContributions.entries) {
      groupId = entry.key;
      contribution = entry.value.where((c) => c.id == contributionId).firstOrNull;
      if (contribution != null) break;
    }
    
    if (contribution == null || groupId == null) {
      throw Exception('Contribution not found');
    }
    
    // Verify recipient is valid
    final recipientSchedule = contribution.payoutSchedule
        .where((p) => p.userId == recipientUserId && p.status == PayoutStatus.pending)
        .firstOrNull;
    
    if (recipientSchedule == null) {
      throw Exception('Invalid payout recipient or no pending payout');
    }
    
    // Create payout transaction
    final payout = PayoutTransactionModel(
      id: _generateId(),
      contributionId: contributionId,
      groupId: groupId,
      recipientUserId: recipientUserId,
      recipientUserName: recipientSchedule.userName,
      amount: amount,
      currency: contribution.currency,
      payoutDate: DateTime.now(),
      status: PayoutTransactionStatus.completed, // Simulate successful payout
      transactionId: 'PAYOUT_${_generateId()}',
      paymentMethod: paymentMethod ?? 'Bank Transfer',
    );
    
    // Update contribution with payout
    final updatedContribution = contribution.copyWith(
      currentAmount: contribution.currentAmount - amount,
      payoutHistory: [...contribution.payoutHistory, payout],
      updatedAt: DateTime.now(),
    );
    
    // Update the contribution in storage
    final groupContributions = _groupContributions[groupId]!;
    final index = groupContributions.indexWhere((c) => c.id == contributionId);
    groupContributions[index] = updatedContribution;
    
    return payout;
  }

  @override
  Future<PayoutTransactionModel> updatePayoutStatus({
    required String payoutId,
    required PayoutTransactionStatus status,
    String? transactionId,
    String? failureReason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Find payout in contribution history
    for (final contributions in _groupContributions.values) {
      for (final contribution in contributions) {
        final payoutIndex = contribution.payoutHistory.indexWhere((p) => p.id == payoutId);
        if (payoutIndex != -1) {
          final payout = contribution.payoutHistory[payoutIndex] as PayoutTransactionModel;
          final updatedPayout = payout.copyWith(
            status: status,
            transactionId: transactionId ?? payout.transactionId,
            failureReason: failureReason,
          );
          
          final updatedPayouts = [...contribution.payoutHistory];
          updatedPayouts[payoutIndex] = updatedPayout;
          
          final updatedContribution = contribution.copyWith(
            payoutHistory: updatedPayouts,
            updatedAt: DateTime.now(),
          );
          
          // Update in storage
          final groupContributions = _groupContributions[contribution.groupId]!;
          final contribIndex = groupContributions.indexWhere((c) => c.id == contribution.id);
          groupContributions[contribIndex] = updatedContribution;
          
          return updatedPayout;
        }
      }
    }
    
    throw Exception('Payout not found');
  }

  @override
  Future<ContributionModel> calculateAndProcessPayout(String contributionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Find the contribution
    ContributionModel? foundContribution;
    String? groupId;
    for (final entry in _groupContributions.entries) {
      groupId = entry.key;
      foundContribution = entry.value.where((c) => c.id == contributionId).firstOrNull;
      if (foundContribution != null) break;
    }
    
    if (foundContribution == null || groupId == null) {
      throw Exception('Contribution not found');
    }
    
    // Now contribution is guaranteed to be non-null
    final contribution = foundContribution;
    
    // Check if payout is due and sufficient funds available
    if (!contribution.canPayout || contribution.currentPayoutRecipient == null) {
      throw Exception('Payout not ready or no recipient assigned');
    }
    
    final currentRecipient = contribution.payoutSchedule
        .where((p) => p.userId == contribution.currentPayoutRecipient! && p.status == PayoutStatus.pending)
        .firstOrNull;
    
    if (currentRecipient == null) {
      throw Exception('No valid payout recipient found');
    }
    
    // Calculate payout amount (could be current balance or scheduled amount)
    final payoutAmount = contribution.minimumBalance != null 
        ? contribution.currentAmount 
        : currentRecipient.expectedAmount;
    
    // Process the payout
    await processPayoutTransaction(
      contributionId: contributionId,
      recipientUserId: currentRecipient.userId,
      amount: payoutAmount,
    );
    
    // Advance to next recipient
    return await advancePayoutRotation(contributionId);
  }

  @override
  Future<ContributionModel> advancePayoutRotation(String contributionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Find the contribution
    ContributionModel? contribution;
    String? groupId;
    for (final entry in _groupContributions.entries) {
      groupId = entry.key;
      contribution = entry.value.where((c) => c.id == contributionId).firstOrNull;
      if (contribution != null) break;
    }
    
    if (contribution == null || groupId == null) {
      throw Exception('Contribution not found');
    }
    
    // Mark current recipient as completed
    final currentPayoutRecipient = contribution.currentPayoutRecipient;
    final updatedSchedule = contribution.payoutSchedule.map((schedule) {
      if (currentPayoutRecipient != null && schedule.userId == currentPayoutRecipient) {
        return (schedule as PayoutScheduleModel).copyWith(
          status: PayoutStatus.completed,
          receivedDate: DateTime.now(),
          actualAmount: contribution!.currentAmount,
        );
      }
      return schedule;
    }).toList();
    
    // Find next recipient
    final nextRecipient = updatedSchedule
        .where((p) => p.status == PayoutStatus.pending)
        .cast<PayoutScheduleModel>()
        .firstOrNull;
    
    final updatedContribution = contribution.copyWith(
      payoutSchedule: updatedSchedule,
      currentPayoutRecipient: nextRecipient?.userId,
      nextPayoutDate: nextRecipient?.scheduledDate,
      currentCycle: (contribution.currentCycle ?? 0) + 1,
      updatedAt: DateTime.now(),
    );
    
    // Update in storage
    final groupContributions = _groupContributions[groupId]!;
    final index = groupContributions.indexWhere((c) => c.id == contributionId);
    groupContributions[index] = updatedContribution;
    
    return updatedContribution;
  }

  @override
  Future<ContributionReceiptModel> generateReceipt(String paymentId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Find payment
    ContributionPaymentModel? payment;
    for (final payments in _contributionPayments.values) {
      payment = payments.where((p) => p.id == paymentId).firstOrNull;
      if (payment != null) break;
    }
    
    if (payment == null) {
      throw Exception('Payment not found');
    }
    
    final receipt = ContributionReceiptModel(
      id: _generateId(),
      paymentId: paymentId,
      contributionId: payment.contributionId,
      groupId: payment.groupId,
      userId: payment.userId,
      userName: payment.userName,
      amount: payment.amount,
      currency: payment.currency,
      paymentDate: payment.paymentDate,
      generatedAt: DateTime.now(),
      receiptNumber: 'RCP-${_generateId()}',
      receiptData: {
        'transactionId': payment.transactionId,
        'notes': payment.notes,
        'status': payment.status.displayName,
      },
    );
    
    _receipts[receipt.id] = receipt;
    return receipt;
  }

  @override
  Future<List<ContributionReceiptModel>> getUserReceipts(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _receipts.values.where((receipt) => receipt.userId == userId).toList();
  }

  @override
  Future<ContributionTranscriptModel> generateContributionTranscript(String contributionId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final payments = _contributionPayments[contributionId] ?? [];
    final totalAmount = payments.fold<double>(0, (sum, payment) => sum + payment.amount);
    
    // Calculate member contributions
    final memberContributions = <String, double>{};
    for (final payment in payments) {
      memberContributions[payment.userName] = 
          (memberContributions[payment.userName] ?? 0) + payment.amount;
    }
    
    final transcript = ContributionTranscriptModel(
      id: _generateId(),
      contributionId: contributionId,
      groupId: payments.isNotEmpty ? payments.first.groupId : '',
      generatedAt: DateTime.now(),
      payments: payments,
      totalAmount: totalAmount,
      currency: payments.isNotEmpty ? payments.first.currency : 'USD',
      memberContributions: memberContributions,
    );
    
    return transcript;
  }

  @override
  Future<Map<String, dynamic>> getGroupStatistics(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final contributions = _groupContributions[groupId] ?? [];
    final members = _groupMembers[groupId] ?? [];
    
    final totalContributions = contributions.length;
    final completedContributions = contributions.where((c) => c.isCompleted).length;
    final totalTargetAmount = contributions.fold<double>(0, (sum, c) => sum + c.targetAmount);
    final totalCurrentAmount = contributions.fold<double>(0, (sum, c) => sum + c.currentAmount);
    
    return {
      'memberCount': members.length,
      'totalContributions': totalContributions,
      'completedContributions': completedContributions,
      'activeContributions': totalContributions - completedContributions,
      'totalTargetAmount': totalTargetAmount,
      'totalCurrentAmount': totalCurrentAmount,
      'completionRate': totalContributions > 0 ? (completedContributions / totalContributions) * 100 : 0,
    };
  }

  @override
  Future<Map<String, dynamic>> getUserContributionStats(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    int totalPayments = 0;
    double totalAmount = 0;
    int groupsCount = 0;
    
    for (final payments in _contributionPayments.values) {
      final userPayments = payments.where((p) => p.userId == userId);
      totalPayments += userPayments.length;
      totalAmount += userPayments.fold<double>(0, (sum, p) => sum + p.amount);
    }
    
    groupsCount = _groups.values.where((group) {
      return group.adminId == userId || 
             (_groupMembers[group.id]?.any((member) => member.userId == userId) ?? false);
    }).length;
    
    return {
      'totalPayments': totalPayments,
      'totalAmount': totalAmount,
      'groupsCount': groupsCount,
      'averagePayment': totalPayments > 0 ? totalAmount / totalPayments : 0,
    };
  }

  @override
  Future<Map<String, dynamic>> getContributionAnalytics(String contributionId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    // Find the contribution
    ContributionModel? contribution;
    for (final contributions in _groupContributions.values) {
      contribution = contributions.where((c) => c.id == contributionId).firstOrNull;
      if (contribution != null) break;
    }
    
    if (contribution == null) {
      throw Exception('Contribution not found');
    }
    
    final payments = _contributionPayments[contributionId] ?? [];
    final members = _groupMembers[contribution.groupId] ?? [];
    
    // Calculate analytics
    final totalPayments = payments.length;
    final averagePayment = payments.isNotEmpty 
        ? payments.fold<double>(0, (sum, p) => sum + p.amount) / payments.length 
        : 0;
    
    // Member participation analysis
    final memberPayments = <String, int>{};
    final memberAmounts = <String, double>{};
    for (final payment in payments) {
      memberPayments[payment.userId] = (memberPayments[payment.userId] ?? 0) + 1;
      memberAmounts[payment.userId] = (memberAmounts[payment.userId] ?? 0) + payment.amount;
    }
    
    final activeMembers = members.where((m) => m.status == GroupMemberStatus.active).length;
    final participatingMembers = memberPayments.keys.length;
    
    // Schedule analysis
    final isOnSchedule = contribution.nextPaymentDate == null || 
        DateTime.now().isBefore(contribution.nextPaymentDate!);
    
    final daysBehindSchedule = contribution.nextPaymentDate != null 
        ? DateTime.now().difference(contribution.nextPaymentDate!).inDays.clamp(0, double.infinity).toInt()
        : 0;
    
    return {
      'contributionId': contributionId,
      'type': contribution.type.displayName,
      'progressPercentage': contribution.progressPercentage,
      'totalPayments': totalPayments,
      'averagePayment': averagePayment,
      'currentAmount': contribution.currentAmount,
      'targetAmount': contribution.targetAmount,
      'memberParticipation': {
        'totalMembers': activeMembers,
        'participatingMembers': participatingMembers,
        'participationRate': activeMembers > 0 ? (participatingMembers / activeMembers) * 100 : 0,
      },
      'schedule': {
        'isOnSchedule': isOnSchedule,
        'daysBehindSchedule': daysBehindSchedule,
        'nextPaymentDate': contribution.nextPaymentDate?.toIso8601String(),
        'currentCycle': contribution.currentCycle,
        'totalCycles': contribution.totalCycles,
      },
      'payout': {
        'currentRecipient': contribution.currentPayoutRecipient,
        'nextPayoutDate': contribution.nextPayoutDate?.toIso8601String(),
        'completedPayouts': contribution.payoutHistory.length,
        'pendingPayouts': contribution.payoutSchedule.where((p) => p.status == PayoutStatus.pending).length,
      },
      'memberStats': memberAmounts,
    };
  }
} 