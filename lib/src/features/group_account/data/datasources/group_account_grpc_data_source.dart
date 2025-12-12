import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/group_account.pbgrpc.dart' as pb;
import 'package:lazervault/src/generated/group_account.pbenum.dart' as pb_enum;
import '../models/group_account_models.dart';
import '../../domain/entities/group_entities.dart';
import 'group_account_remote_data_source.dart';
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:lazervault/src/generated/google/protobuf/timestamp.pb.dart' as $pb_timestamp;

class GroupAccountGrpcDataSource implements GroupAccountRemoteDataSource {
  final pb.GroupAccountServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  GroupAccountGrpcDataSource({
    required pb.GroupAccountServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  // ============================================================================
  // GROUP MANAGEMENT
  // ============================================================================

  
    // NOTE: _map*ToProto functions convert domain -> proto enums
  // NOTE: _map*FromProto functions convert proto -> domain enums

  // Helper to convert DateTime to protobuf Timestamp
  $pb_timestamp.Timestamp _dateTimeToTimestamp(DateTime dateTime) {
    return $pb_timestamp.Timestamp.fromDateTime(dateTime);
  }

  // Helper to convert Timestamp to DateTime
  DateTime _timestampToDateTime($pb_timestamp.Timestamp timestamp) {
    return timestamp.toDateTime();
  }

  // Helper to convert amount in dollars to cents (Int64)
  fixnum.Int64 _amountToInt64(double amount) {
    return fixnum.Int64((amount * 100).toInt());
  }

  // Helper to convert cents (Int64) to dollars (double)
  double _int64ToAmount(fixnum.Int64 cents) {
    return cents.toInt() / 100.0;
  }

  // Helper to parse String ID to Int64
  fixnum.Int64 _stringToInt64(String id) {
    return fixnum.Int64.parseInt(id);
  }

  // Helper to convert Int64 ID to String
  String _int64ToString(fixnum.Int64 id) {
    return id.toString();
  }


  @override
  Future<List<GroupAccountModel>> getUserGroups(String userId) async {
    try {
      final request = pb.ListUserGroupsRequest()
        ..page = 1
        ..pageSize = 100;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.listUserGroups(request, options: callOptions);

      return response.groups.map((group) => _mapGroupFromProto(group)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get user groups'}');
    }
  }

  @override
  Future<GroupAccountModel> getGroupById(String groupId) async {
    try {
      final request = pb.GetGroupRequest()..groupId = groupId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getGroup(request, options: callOptions);

      // TODO: Ensure _mapGroupFromProto converts Timestamps and Int64s properly
      return _mapGroupFromProto(response.group);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get group'}');
    }
  }

  @override
  Future<GroupAccountModel> createGroup({
    required String name,
    required String description,
    required String adminId,
  }) async {
    try {
      final request = pb.CreateGroupRequest()
        ..name = name
        ..description = description;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.createGroup(request, options: callOptions);

      // TODO: Ensure _mapGroupFromProto converts Timestamps and Int64s properly
      return _mapGroupFromProto(response.group);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to create group'}');
    }
  }

  @override
  Future<GroupAccountModel> updateGroup(GroupAccountModel group) async {
    try {
      final request = pb.UpdateGroupRequest()
        ..groupId = group.id
        ..name = group.name
        ..description = group.description;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.updateGroup(request, options: callOptions);

      // TODO: Ensure _mapGroupFromProto converts Timestamps and Int64s properly
      return _mapGroupFromProto(response.group);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to update group'}');
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    try {
      final request = pb.DeleteGroupRequest()..groupId = groupId;

      final callOptions = await _callOptionsHelper.withAuth();
      await _client.deleteGroup(request, options: callOptions);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to delete group'}');
    }
  }

  // ============================================================================
  // MEMBER MANAGEMENT
  // ============================================================================

  @override
  Future<List<GroupMemberModel>> getGroupMembers(String groupId) async {
    try {
      final request = pb.GetGroupMembersRequest()..groupId = groupId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getGroupMembers(request, options: callOptions);

      return response.members.map((member) => _mapMemberFromProto(member)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get group members'}');
    }
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
    try {
      final request = pb.AddMemberRequest()
        ..groupId = groupId
        ..role = _mapRoleToProto(role);

      // Only send userId if it's a real user ID (numeric and less than 10 digits)
      // Otherwise, send email/phone/username to let backend handle lookup/creation
      if (userId.isNotEmpty &&
          int.tryParse(userId) != null &&
          userId.length > 0 &&
          userId.length < 10) {
        request.userId = _stringToInt64(userId);
      } else if (email.isNotEmpty) {
        // Send email for backend to find existing user or create partial user
        request.email = email;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.addMember(request, options: callOptions);

      return _mapMemberFromProto(response.member);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to add member'}');
    }
  }

  @override
  Future<GroupMemberModel> updateMemberRole({
    required String groupId,
    required String memberId,
    required GroupMemberRole newRole,
  }) async {
    try {
      final request = pb.UpdateMemberRoleRequest()
        ..groupId = groupId
        ..memberId = memberId
        ..newRole = _mapRoleToProto(newRole);

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.updateMemberRole(request, options: callOptions);

      return _mapMemberFromProto(response.member);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to update member role'}');
    }
  }

  @override
  Future<void> removeMemberFromGroup({
    required String groupId,
    required String memberId,
  }) async {
    try {
      final request = pb.RemoveMemberRequest()
        ..groupId = groupId
        ..memberId = memberId;

      final callOptions = await _callOptionsHelper.withAuth();
      await _client.removeMember(request, options: callOptions);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to remove member'}');
    }
  }

  @override
  Future<List<GroupMemberModel>> searchUsers(String query) async {
    try {
      final request = pb.SearchUsersRequest()
        ..query = query
        ..limit = 20;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.searchUsers(request, options: callOptions);

      return response.users.map((user) => GroupMemberModel(
        id: _int64ToString(user.userId),
        userId: _int64ToString(user.userId),
        userName: user.userName,
        email: user.email,
        profileImage: user.profileImage.isNotEmpty ? user.profileImage : null,
        role: GroupMemberRole.member,
        joinedAt: DateTime.now(),
        status: GroupMemberStatus.active,
      )).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to search users'}');
    }
  }

  // ============================================================================
  // CONTRIBUTION MANAGEMENT
  // ============================================================================

  @override
  Future<List<ContributionModel>> getGroupContributions(String groupId) async {
    try {
      final request = pb.ListGroupContributionsRequest()
        ..groupId = groupId
        ..page = 1
        ..pageSize = 100;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.listGroupContributions(request, options: callOptions);

      return response.contributions.map((contribution) => _mapContributionFromProto(contribution)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get contributions'}');
    }
  }

  @override
  Future<ContributionModel> getContributionById(String contributionId) async {
    try {
      final request = pb.GetContributionRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getContribution(request, options: callOptions);

      return _mapContributionFromProto(response.contribution);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get contribution'}');
    }
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
    try {
      final request = pb.CreateContributionRequest()
        ..groupId = groupId
        ..title = title
        ..description = description
        ..targetAmount = _amountToInt64(targetAmount)        ..type = _mapContributionTypeToProto(type)
        ..autoPayEnabled = autoPayEnabled
        ..allowPartialPayments = allowPartialPayments;

      if (frequency != null) {
        request.frequency = _mapFrequencyToProto(frequency);
      }
      if (regularAmount != null) {
        request.regularAmount = _amountToInt64(regularAmount);
      }
      if (startDate != null) {
        request.startDate = _dateTimeToTimestamp(startDate);
      }
      if (totalCycles != null) {
        request.totalCycles = totalCycles;
      }
      if (memberRotationOrder != null) {
        request.memberRotationOrder.addAll(memberRotationOrder.map((id) => _stringToInt64(id)));
      }
      if (penaltyAmount != null) {
        request.penaltyAmount = _amountToInt64(penaltyAmount);
      }
      if (gracePeriodDays != null) {
        request.gracePeriodDays = gracePeriodDays;
      }
      if (minimumBalance != null) {
        request.minimumBalance = _amountToInt64(minimumBalance);
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.createContribution(request, options: callOptions);

      return _mapContributionFromProto(response.contribution);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to create contribution'}');
    }
  }

  @override
  Future<ContributionModel> updateContribution(ContributionModel contribution) async {
    try {
      final request = pb.UpdateContributionRequest()
        ..contributionId = contribution.id
        ..title = contribution.title
        ..description = contribution.description
        ..targetAmount = _amountToInt64(contribution.targetAmount)
        ..status = _mapContributionStatusToProto(contribution.status);

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.updateContribution(request, options: callOptions);

      return _mapContributionFromProto(response.contribution);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to update contribution'}');
    }
  }

  @override
  Future<void> deleteContribution(String contributionId) async {
    try {
      final request = pb.DeleteContributionRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      await _client.deleteContribution(request, options: callOptions);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to delete contribution'}');
    }
  }

  // ============================================================================
  // PAYMENT OPERATIONS
  // ============================================================================

  @override
  Future<List<ContributionPaymentModel>> getContributionPayments(String contributionId) async {
    try {
      final request = pb.GetContributionPaymentsRequest()
        ..contributionId = contributionId
        ..page = 1
        ..pageSize = 100;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getContributionPayments(request, options: callOptions);

      return response.payments.map((payment) => _mapPaymentFromProto(payment)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get payments'}');
    }
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
    try {
      final request = pb.MakePaymentRequest()
        ..contributionId = contributionId
        ..amount = _amountToInt64(amount);

      if (notes != null) {
        request.notes = notes;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.makePayment(request, options: callOptions);

      return _mapPaymentFromProto(response.payment);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to make payment'}');
    }
  }

  @override
  Future<ContributionPaymentModel> updatePaymentStatus({
    required String paymentId,
    required PaymentStatus status,
    String? transactionId,
  }) async {
    try {
      final request = pb.UpdatePaymentStatusRequest()
        ..paymentId = paymentId
        ..status = _mapPaymentStatusToProto(status);

      if (transactionId != null) {
        request.transactionId = transactionId;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.updatePaymentStatus(request, options: callOptions);

      return _mapPaymentFromProto(response.payment);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to update payment status'}');
    }
  }

  @override
  Future<ContributionModel> processScheduledPayments(String contributionId) async {
    try {
      final request = pb.ProcessScheduledPaymentsRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.processScheduledPayments(request, options: callOptions);

      return _mapContributionFromProto(response.contribution);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to process scheduled payments'}');
    }
  }

  @override
  Future<List<ContributionModel>> getOverdueContributions(String userId) async {
    try {
      final request = pb.GetOverdueContributionsRequest();

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getOverdueContributions(request, options: callOptions);

      return response.contributions.map((contribution) => _mapContributionFromProto(contribution)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get overdue contributions'}');
    }
  }

  @override
  Future<ContributionModel> updatePaymentSchedule({
    required String contributionId,
    required DateTime nextPaymentDate,
    int? currentCycle,
  }) async {
    try {
      // This might need to be done via update contribution
      final request = pb.GetContributionRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getContribution(request, options: callOptions);

      return _mapContributionFromProto(response.contribution);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to update payment schedule'}');
    }
  }

  // ============================================================================
  // PAYOUT OPERATIONS
  // ============================================================================

  @override
  Future<List<PayoutScheduleModel>> getPayoutSchedule(String contributionId) async {
    try {
      final request = pb.GetPayoutScheduleRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getPayoutSchedule(request, options: callOptions);

      return response.schedule.map((schedule) => _mapPayoutScheduleFromProto(schedule)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get payout schedule'}');
    }
  }

  @override
  Future<PayoutTransactionModel> processPayoutTransaction({
    required String contributionId,
    required String recipientUserId,
    required double amount,
    String? paymentMethod,
  }) async {
    try {
      final request = pb.ProcessPayoutRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.processPayout(request, options: callOptions);

      return _mapPayoutTransactionFromProto(response.transaction);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to process payout'}');
    }
  }

  @override
  Future<PayoutTransactionModel> updatePayoutStatus({
    required String payoutId,
    required PayoutTransactionStatus status,
    String? transactionId,
    String? failureReason,
  }) async {
    try {
      final request = pb.UpdatePayoutStatusRequest()
        ..payoutId = payoutId
        ..status = _mapPayoutStatusToProtoTransaction(status);

      if (transactionId != null) {
        request.transactionId = transactionId;
      }
      if (failureReason != null) {
        request.failureReason = failureReason;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.updatePayoutStatus(request, options: callOptions);

      return _mapPayoutTransactionFromProto(response.payout);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to update payout status'}');
    }
  }

  @override
  Future<ContributionModel> calculateAndProcessPayout(String contributionId) async {
    try {
      final request = pb.ProcessPayoutRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.processPayout(request, options: callOptions);

      // Get updated contribution
      final getRequest = pb.GetContributionRequest()..contributionId = contributionId;
      final getResponse = await _client.getContribution(getRequest, options: callOptions);

      return _mapContributionFromProto(getResponse.contribution);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to calculate and process payout'}');
    }
  }

  @override
  Future<ContributionModel> advancePayoutRotation(String contributionId) async {
    try {
      final request = pb.AdvancePayoutRotationRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.advancePayoutRotation(request, options: callOptions);

      return _mapContributionFromProto(response.contribution);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to advance payout rotation'}');
    }
  }

  // ============================================================================
  // RECEIPTS & TRANSCRIPTS
  // ============================================================================

  @override
  Future<ContributionReceiptModel> generateReceipt(String paymentId) async {
    try {
      final request = pb.GenerateReceiptRequest()..paymentId = paymentId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.generateReceipt(request, options: callOptions);

      return _mapReceiptFromProto(response.receipt);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to generate receipt'}');
    }
  }

  @override
  Future<List<ContributionReceiptModel>> getUserReceipts(String userId) async {
    try {
      final request = pb.GetUserContributionReceiptsRequest()
        ..page = 1
        ..pageSize = 100;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getUserReceipts(request, options: callOptions);

      return response.receipts.map((receipt) => _mapReceiptFromProto(receipt)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get user receipts'}');
    }
  }

  @override
  Future<ContributionTranscriptModel> generateContributionTranscript(String contributionId) async {
    try {
      final request = pb.GenerateTranscriptRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.generateTranscript(request, options: callOptions);

      return _mapTranscriptFromProto(response.transcript);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to generate transcript'}');
    }
  }

  // ============================================================================
  // STATISTICS
  // ============================================================================

  @override
  Future<Map<String, dynamic>> getGroupStatistics(String groupId) async {
    try {
      final request = pb.GetGroupStatisticsRequest()..groupId = groupId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getGroupStatistics(request, options: callOptions);

      return {
        'memberCount': response.memberCount,
        'totalContributions': response.totalContributions,
        'completedContributions': response.completedContributions,
        'activeContributions': response.activeContributions,
        'totalTargetAmount': response.totalTargetAmount,
        'totalCurrentAmount': response.totalCurrentAmount,
        'completionRate': response.completionRate,
      };
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get group statistics'}');
    }
  }

  @override
  Future<Map<String, dynamic>> getUserContributionStats(String userId) async {
    try {
      final request = pb.GetUserContributionStatsRequest();

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getUserContributionStats(request, options: callOptions);

      return {
        'totalPayments': response.totalPayments,
        'totalAmount': response.totalAmount,
        'groupsCount': response.groupsCount,
        'averagePayment': response.averagePayment,
      };
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get user contribution stats'}');
    }
  }

  @override
  Future<Map<String, dynamic>> getContributionAnalytics(String contributionId) async {
    try {
      final request = pb.GetContributionAnalyticsRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getContributionAnalytics(request, options: callOptions);

      return {
        'contributionId': response.contributionId,
        'type': response.type,
        'progressPercentage': response.progressPercentage,
        'totalPayments': response.totalPayments,
        'averagePayment': response.averagePayment,
        'currentAmount': response.currentAmount,
        'targetAmount': response.targetAmount,
        'memberParticipation': {
          'totalMembers': response.memberParticipation.totalMembers,
          'participatingMembers': response.memberParticipation.participatingMembers,
          'participationRate': response.memberParticipation.participationRate,
        },
        'schedule': {
          'isOnSchedule': response.schedule.isOnSchedule,
          'daysBehindSchedule': response.schedule.daysBehindSchedule,
          'nextPaymentDate': response.schedule.nextPaymentDate.seconds > 0
              ? _timestampToDateTime(response.schedule.nextPaymentDate)
              : null,
          'currentCycle': response.schedule.currentCycle,
          'totalCycles': response.schedule.totalCycles,
        },
      };
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get contribution analytics'}');
    }
  }

  // ============================================================================
  // MAPPING HELPERS
  // ============================================================================

  GroupAccountModel _mapGroupFromProto(pb.GroupAccountMessage group) {
    return GroupAccountModel(
      id: group.id,
      name: group.name,
      description: group.description,
      adminId: _int64ToString(group.adminId),
      members: group.members.map((m) => _mapMemberFromProto(m)).toList(),
      contributions: [],
      createdAt: _timestampToDateTime(group.createdAt),
      updatedAt: _timestampToDateTime(group.updatedAt),
      status: _mapGroupStatusFromProto(group.status),
    );
  }

  GroupMemberModel _mapMemberFromProto(pb.GroupMemberMessage member) {
    return GroupMemberModel(
      id: member.id,
      userId: _int64ToString(member.userId),
      userName: member.userName,
      email: member.email,
      profileImage: member.profileImage.isNotEmpty ? member.profileImage : null,
      role: _mapRoleFromProto(member.role),
      joinedAt: _timestampToDateTime(member.joinedAt),
      status: _mapMemberStatusFromProto(member.status),
      phoneNumber: member.phoneNumber.isNotEmpty ? member.phoneNumber : null,
      isPartial: member.isPartial,
      userUsername: member.userUsername.isNotEmpty ? member.userUsername : null,
    );
  }

  ContributionModel _mapContributionFromProto(pb.ContributionMessage contribution) {
    return ContributionModel(
      id: contribution.id,
      groupId: contribution.groupId,
      title: contribution.title,
      description: contribution.description,
      targetAmount: _int64ToAmount(contribution.targetAmount),
      currentAmount: _int64ToAmount(contribution.currentAmount),
      currency: contribution.currency,
      deadline: _timestampToDateTime(contribution.deadline),
      createdAt: _timestampToDateTime(contribution.createdAt),
      updatedAt: _timestampToDateTime(contribution.updatedAt),
      status: _mapContributionStatusFromProto(contribution.status),
      createdBy: _int64ToString(contribution.createdBy),
      payments: [],
      type: _mapContributionTypeFromProto(contribution.type),
      frequency: contribution.hasFrequency() ? _mapFrequencyFromProto(contribution.frequency) : null,
      regularAmount: contribution.hasRegularAmount() ? _int64ToAmount(contribution.regularAmount) : null,
      nextPaymentDate: contribution.hasNextPaymentDate()
          ? _timestampToDateTime(contribution.nextPaymentDate)
          : null,
      startDate: contribution.hasStartDate()
          ? _timestampToDateTime(contribution.startDate)
          : null,
      totalCycles: contribution.hasTotalCycles() ? contribution.totalCycles : null,
      currentCycle: contribution.hasCurrentCycle() ? contribution.currentCycle : null,
      payoutSchedule: [],
      currentPayoutRecipient: contribution.hasCurrentPayoutRecipient() ? _int64ToString(contribution.currentPayoutRecipient) : null,
      nextPayoutDate: contribution.hasNextPayoutDate()
          ? _timestampToDateTime(contribution.nextPayoutDate)
          : null,
      payoutHistory: [],
      autoPayEnabled: contribution.autoPayEnabled,
      penaltyAmount: contribution.hasPenaltyAmount() ? _int64ToAmount(contribution.penaltyAmount) : null,
      gracePeriodDays: contribution.hasGracePeriodDays() ? contribution.gracePeriodDays : null,
      allowPartialPayments: contribution.allowPartialPayments,
      minimumBalance: contribution.hasMinimumBalance() ? _int64ToAmount(contribution.minimumBalance) : null,
    );
  }

  ContributionPaymentModel _mapPaymentFromProto(pb.ContributionPaymentMessage payment) {
    return ContributionPaymentModel(
      id: payment.id,
      contributionId: payment.contributionId,
      groupId: payment.groupId,
      userId: _int64ToString(payment.userId),
      userName: payment.userName,
      amount: _int64ToAmount(payment.amount),
      currency: payment.currency,
      paymentDate: _timestampToDateTime(payment.paymentDate),
      status: _mapPaymentStatusFromProto(payment.status),
      transactionId: payment.transactionId.isNotEmpty ? payment.transactionId : null,
      notes: payment.notes.isNotEmpty ? payment.notes : null,
    );
  }

  PayoutScheduleModel _mapPayoutScheduleFromProto(pb.PayoutScheduleMessage schedule) {
    return PayoutScheduleModel(
      id: schedule.id,
      userId: _int64ToString(schedule.userId),
      userName: schedule.userName,
      position: schedule.position,
      scheduledDate: _timestampToDateTime(schedule.scheduledDate),
      expectedAmount: _int64ToAmount(schedule.expectedAmount),
      status: _mapPayoutStatusFromProto(schedule.status),
      receivedDate: schedule.hasReceivedDate()
          ? _timestampToDateTime(schedule.receivedDate)
          : null,
      actualAmount: schedule.hasActualAmount() ? _int64ToAmount(schedule.actualAmount) : null,
    );
  }

  PayoutTransactionModel _mapPayoutTransactionFromProto(pb.PayoutTransactionMessage payout) {
    return PayoutTransactionModel(
      id: payout.id,
      contributionId: payout.contributionId,
      groupId: payout.groupId,
      recipientUserId: _int64ToString(payout.recipientUserId),
      recipientUserName: payout.recipientUserName,
      amount: _int64ToAmount(payout.amount),
      currency: payout.currency,
      payoutDate: _timestampToDateTime(payout.payoutDate),
      status: _mapPayoutTransactionStatusFromProto(payout.status),
      transactionId: payout.transactionId.isNotEmpty ? payout.transactionId : null,
      paymentMethod: payout.paymentMethod.isNotEmpty ? payout.paymentMethod : null,
      failureReason: payout.hasFailureReason() ? payout.failureReason : null,
    );
  }

  ContributionReceiptModel _mapReceiptFromProto(pb.ContributionReceiptMessage receipt) {
    return ContributionReceiptModel(
      id: receipt.id,
      paymentId: receipt.paymentId,
      contributionId: receipt.contributionId,
      groupId: receipt.groupId,
      userId: _int64ToString(receipt.userId),
      userName: receipt.userName,
      amount: _int64ToAmount(receipt.amount),
      currency: receipt.currency,
      paymentDate: _timestampToDateTime(receipt.paymentDate),
      generatedAt: _timestampToDateTime(receipt.generatedAt),
      receiptNumber: receipt.receiptNumber,
      receiptData: {}, // TODO: Parse JSON from receipt.receiptData if needed
    );
  }

  ContributionTranscriptModel _mapTranscriptFromProto(pb.ContributionTranscriptMessage transcript) {
    return ContributionTranscriptModel(
      id: transcript.id,
      contributionId: transcript.contributionId,
      groupId: transcript.groupId,
      generatedAt: _timestampToDateTime(transcript.generatedAt),
      payments: transcript.payments.map((p) => _mapPaymentFromProto(p)).toList(),
      totalAmount: _int64ToAmount(transcript.totalAmount),
      currency: transcript.currency,
      memberContributions: {}, // TODO: Parse JSON from transcript.memberContributions if needed
    );
  }

  // Enum mappers
  GroupAccountStatus _mapGroupStatusFromProto(pb_enum.GroupAccountStatus status) {
    switch (status) {
      case pb_enum.GroupAccountStatus.GROUP_ACCOUNT_STATUS_ACTIVE:
        return GroupAccountStatus.active;
      case pb_enum.GroupAccountStatus.GROUP_ACCOUNT_STATUS_SUSPENDED:
        return GroupAccountStatus.suspended;
      case pb_enum.GroupAccountStatus.GROUP_ACCOUNT_STATUS_CLOSED:
        return GroupAccountStatus.suspended; // closed not in domain
      default:
        return GroupAccountStatus.active;
    }
  }

  GroupMemberRole _mapRoleFromProto(pb_enum.GroupMemberRole role) {
    switch (role) {
      case pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_ADMIN:
        return GroupMemberRole.admin;
      case pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_MEMBER:
        return GroupMemberRole.moderator;
      case pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_MEMBER:
        return GroupMemberRole.member;
      default:
        return GroupMemberRole.member;
    }
  }

  pb_enum.GroupMemberRole _mapRoleToProto(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_ADMIN;
      case GroupMemberRole.moderator:
        return pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_MEMBER;
      case GroupMemberRole.member:
        return pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_MEMBER;
    }
  }

  GroupMemberStatus _mapMemberStatusFromProto(pb_enum.GroupMemberStatus status) {
    switch (status) {
      case pb_enum.GroupMemberStatus.GROUP_MEMBER_STATUS_ACTIVE:
        return GroupMemberStatus.active;
      case pb_enum.GroupMemberStatus.GROUP_MEMBER_STATUS_INACTIVE:
        return GroupMemberStatus.inactive;
      case pb_enum.GroupMemberStatus.GROUP_MEMBER_STATUS_REMOVED:
        return GroupMemberStatus.removed;
      default:
        return GroupMemberStatus.active;
    }
  }

  ContributionType _mapContributionTypeFromProto(pb_enum.ContributionType type) {
    switch (type) {
      case pb_enum.ContributionType.CONTRIBUTION_TYPE_ONE_TIME:
        return ContributionType.oneTime;
      case pb_enum.ContributionType.CONTRIBUTION_TYPE_RECURRING:
        return ContributionType.oneTime; // recurring not in domain
      case pb_enum.ContributionType.CONTRIBUTION_TYPE_ROTATING_SAVINGS:
        return ContributionType.rotatingSavings;
      default:
        return ContributionType.oneTime;
    }
  }

  pb_enum.ContributionType _mapContributionTypeToProto(ContributionType type) {
    switch (type) {
      case ContributionType.oneTime:
        return pb_enum.ContributionType.CONTRIBUTION_TYPE_ONE_TIME;
      case ContributionType.recurringGoal:
        return pb_enum.ContributionType.CONTRIBUTION_TYPE_RECURRING;
      case ContributionType.rotatingSavings:
        return pb_enum.ContributionType.CONTRIBUTION_TYPE_ROTATING_SAVINGS;
      case ContributionType.investmentPool:
        return pb_enum.ContributionType.CONTRIBUTION_TYPE_ONE_TIME; // Map to one-time as fallback
    }
  }

  ContributionStatus _mapContributionStatusFromProto(pb_enum.ContributionStatus status) {
    switch (status) {
      case pb_enum.ContributionStatus.CONTRIBUTION_STATUS_ACTIVE:
        return ContributionStatus.active;
      case pb_enum.ContributionStatus.CONTRIBUTION_STATUS_COMPLETED:
        return ContributionStatus.completed;
      case pb_enum.ContributionStatus.CONTRIBUTION_STATUS_CANCELLED:
        return ContributionStatus.cancelled;
      case pb_enum.ContributionStatus.CONTRIBUTION_STATUS_PAUSED:
        return ContributionStatus.paused;
      default:
        return ContributionStatus.active;
    }
  }

  pb_enum.ContributionStatus _mapContributionStatusToProto(ContributionStatus status) {
    switch (status) {
      case ContributionStatus.active:
        return pb_enum.ContributionStatus.CONTRIBUTION_STATUS_ACTIVE;
      case ContributionStatus.completed:
        return pb_enum.ContributionStatus.CONTRIBUTION_STATUS_COMPLETED;
      case ContributionStatus.cancelled:
        return pb_enum.ContributionStatus.CONTRIBUTION_STATUS_CANCELLED;
      case ContributionStatus.paused:
        return pb_enum.ContributionStatus.CONTRIBUTION_STATUS_PAUSED;
    }
  }

  ContributionFrequency? _mapFrequencyFromProto(pb_enum.ContributionFrequency frequency) {
    switch (frequency) {
      case pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_DAILY:
        return ContributionFrequency.daily;
      case pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_WEEKLY:
        return ContributionFrequency.weekly;
      case pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_BIWEEKLY:
        return ContributionFrequency.biWeekly;
      case pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_MONTHLY:
        return ContributionFrequency.monthly;
      case pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_QUARTERLY:
        return ContributionFrequency.quarterly;
      case pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_YEARLY:
        return ContributionFrequency.monthly;
      default:
        return null;
    }
  }

  pb_enum.ContributionFrequency _mapFrequencyToProto(ContributionFrequency frequency) {
    switch (frequency) {
      case ContributionFrequency.daily:
        return pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_DAILY;
      case ContributionFrequency.weekly:
        return pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_WEEKLY;
      case ContributionFrequency.biWeekly:
        return pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_BIWEEKLY;
      case ContributionFrequency.monthly:
        return pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_MONTHLY;
      case ContributionFrequency.quarterly:
        return pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_QUARTERLY;
      case ContributionFrequency.monthly:
        return pb_enum.ContributionFrequency.CONTRIBUTION_FREQUENCY_YEARLY;
    }
  }

  PaymentStatus _mapPaymentStatusFromProto(pb_enum.PaymentStatus status) {
    switch (status) {
      case pb_enum.PaymentStatus.PAYMENT_STATUS_PENDING:
        return PaymentStatus.pending;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_COMPLETED:
        return PaymentStatus.completed;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_FAILED:
        return PaymentStatus.failed;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_REFUNDED:
        return PaymentStatus.refunded;
      default:
        return PaymentStatus.pending;
    }
  }

  pb_enum.PaymentStatus _mapPaymentStatusToProto(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_PENDING;
      case PaymentStatus.processing:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_PENDING; // Map to pending as fallback
      case PaymentStatus.completed:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_COMPLETED;
      case PaymentStatus.failed:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_FAILED;
      case PaymentStatus.cancelled:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_FAILED; // Map to failed as fallback
      case PaymentStatus.refunded:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_REFUNDED;
    }
  }

  PayoutStatus _mapPayoutStatusFromProto(pb_enum.PayoutStatus status) {
    switch (status) {
      case pb_enum.PayoutStatus.PAYOUT_STATUS_PENDING:
        return PayoutStatus.pending;
      case pb_enum.PayoutStatus.PAYOUT_STATUS_COMPLETED:
        return PayoutStatus.completed;
      default:
        return PayoutStatus.pending;
    }
  }

  PayoutTransactionStatus _mapPayoutTransactionStatusFromProto(pb_enum.PayoutTransactionStatus status) {
    switch (status) {
      case pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_PENDING:
        return PayoutTransactionStatus.pending;
      case pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_COMPLETED:
        return PayoutTransactionStatus.completed;
      case pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_FAILED:
        return PayoutTransactionStatus.failed;
      default:
        return PayoutTransactionStatus.pending;
    }
  }

  pb_enum.PayoutTransactionStatus _mapPayoutStatusToProtoTransaction(PayoutTransactionStatus status) {
    switch (status) {
      case PayoutTransactionStatus.pending:
        return pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_PENDING;
      case PayoutTransactionStatus.processing:
        return pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_PENDING; // Map to pending as fallback
      case PayoutTransactionStatus.completed:
        return pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_COMPLETED;
      case PayoutTransactionStatus.failed:
        return pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_FAILED;
      case PayoutTransactionStatus.cancelled:
        return pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_FAILED; // Map to failed as fallback
    }
  }
}
