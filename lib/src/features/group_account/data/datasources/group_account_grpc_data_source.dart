import 'dart:convert';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import 'package:lazervault/src/generated/group_account.pbgrpc.dart' as pb;
import 'package:lazervault/src/generated/group_account.pbenum.dart' as pb_enum;
import '../models/group_account_models.dart';
import '../../domain/entities/group_entities.dart';
import 'group_account_remote_data_source.dart' show GroupAccountRemoteDataSource, ActivityLogEntryModel;
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
      throw Exception(friendlyGrpcError(e, 'Failed to get user groups'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GroupAccountModel> getGroupById(String groupId) async {
    try {
      final request = pb.GetGroupRequest()..groupId = groupId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getGroup(request, options: callOptions);

      return _mapGroupFromProto(response.group);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to get group'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GroupAccountModel> createGroup({
    required String name,
    required String description,
    required String adminId,
    Map<String, dynamic>? metadata,
    GroupVisibility? visibility,
    String? imageUrl,
  }) async {
    try {
      final request = pb.CreateGroupRequest()
        ..name = name
        ..description = description;

      // Add metadata if provided
      if (metadata != null && metadata.isNotEmpty) {
        request.metadata = _encodeMetadata(metadata);
      }

      if (visibility != null) {
        request.visibility = _visibilityToProto(visibility);
      }

      if (imageUrl != null) {
        request.imageUrl = imageUrl;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.createGroup(request, options: callOptions);

      return _mapGroupFromProto(response.group);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to create group'));
    }
  }

  @override
  Future<GroupAccountModel> updateGroup(GroupAccountModel group) async {
    try {
      final request = pb.UpdateGroupRequest()
        ..groupId = group.id
        ..name = group.name
        ..description = group.description
        ..status = _mapGroupStatusToProto(group.status);

      // Include metadata if present
      if (group.metadata != null && group.metadata!.isNotEmpty) {
        request.metadata = _encodeMetadata(group.metadata!);
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.updateGroup(request, options: callOptions);

      return _mapGroupFromProto(response.group);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to update group'));
    }
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    try {
      final request = pb.DeleteGroupRequest()..groupId = groupId;

      final callOptions = await _callOptionsHelper.withAuth();
      await _client.deleteGroup(request, options: callOptions);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to delete group'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to get group members'));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GroupMemberModel> addMemberToGroup({
    required String groupId,
    required String userId,
    required String userName,
    required String email,
    String? profileImage,
    String? username,  // LazerTag username for user lookup
    GroupMemberRole role = GroupMemberRole.member,
  }) async {
    try {
      final request = pb.AddMemberRequest()
        ..groupId = groupId
        ..role = _mapRoleToProto(role);

      // Always set userId when provided (proto field is string, supports UUIDs)
      if (userId.isNotEmpty) {
        request.userId = userId;
      }

      // Also set lookupUsername for backend to resolve full user info
      if (username != null && username.isNotEmpty) {
        request.lookupUsername = username.replaceAll('@', '').trim();
      }

      // Set email for fallback lookup
      if (email.isNotEmpty) {
        request.email = email;
      }

      // 20s timeout: typical add-member finishes in <1s. Without an
      // explicit deadline a wedged backend would leave the bottom
      // sheet's loading spinner stuck forever — the BlocListener
      // would never get a Success/Error to count toward the batch
      // total. The DEADLINE_EXCEEDED hits the catch below and
      // surfaces as GroupAccountError → bottom sheet pops with
      // failure messaging.
      final base = await _callOptionsHelper.withAuth();
      final callOptions = base.mergedWith(
        CallOptions(timeout: const Duration(seconds: 20)),
      );
      final response = await _client.addMember(request, options: callOptions);

      return _mapMemberFromProto(response.member);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to add member'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to update member role'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to remove member'));
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
        id: user.userId,
        userId: user.userId,
        userName: user.userName,
        email: user.email,
        profileImage: user.profileImage.isNotEmpty ? user.profileImage : null,
        role: GroupMemberRole.member,
        joinedAt: DateTime.now(),
        status: GroupMemberStatus.active,
        userUsername: user.userUsername.isNotEmpty ? user.userUsername : null,
        emailMatchesSearchQuery: user.emailMatchesSearchQuery,
        phoneMatchesSearchQueryExact: user.phoneMatchesSearchQueryExact,
      )).toList();
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to search users'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to get contributions'));
    } catch (e) {
      rethrow;
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
      throw Exception(friendlyGrpcError(e, 'Failed to get contribution'));
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
    bool autoPayoutEnabled = false,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final request = pb.CreateContributionRequest()
        ..groupId = groupId
        ..title = title
        ..description = description
        ..targetAmount = _amountToInt64(targetAmount)
        ..currency = currency
        ..deadline = _dateTimeToTimestamp(deadline)
        ..type = _mapContributionTypeToProto(type)
        ..autoPayEnabled = autoPayEnabled
        ..allowPartialPayments = allowPartialPayments
        ..autoPayoutEnabled = autoPayoutEnabled;

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
      if (memberRotationOrder != null && memberRotationOrder.isNotEmpty) {
        request.memberRotationOrder.addAll(memberRotationOrder);  // Pass UUID strings directly
      }
      if (penaltyAmount != null) {
        request.penaltyAmount = _amountToInt64(penaltyAmount);
      }

      // Add metadata if provided
      if (metadata != null && metadata.isNotEmpty) {
        request.metadata = _encodeMetadata(metadata);
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
      throw Exception(friendlyGrpcError(e, 'Failed to create contribution'));
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
        ..status = _mapContributionStatusToProto(contribution.status)
        // Auto-payout flag is wrapped in a "_set" sentinel on the
        // wire so the server can distinguish "client omitted this
        // field" from "client wants false". We always send the
        // explicit set=true here because the edit form is the only
        // caller and it always carries an intent.
        ..autoPayoutEnabled = contribution.autoPayoutEnabled
        ..autoPayoutEnabledSet = true;

      // Include metadata if present
      if (contribution.metadata != null && contribution.metadata!.isNotEmpty) {
        request.metadata = _encodeMetadata(contribution.metadata!);
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.updateContribution(request, options: callOptions);

      return _mapContributionFromProto(response.contribution);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to update contribution'));
    }
  }

  @override
  Future<void> deleteContribution(String contributionId) async {
    try {
      final request = pb.DeleteContributionRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      await _client.deleteContribution(request, options: callOptions);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to delete contribution'));
    }
  }

  @override
  Future<List<ContributionMemberModel>> addMembersToContribution({
    required String contributionId,
    required List<String> memberUserIds,
  }) async {
    // Filter out empty or invalid UUIDs
    final validUserIds = memberUserIds.where((id) =>
      id.isNotEmpty && id != '00000000-0000-0000-0000-000000000000'
    ).toList();

    if (validUserIds.isEmpty) {
      throw Exception('No valid user IDs to add. All provided IDs were empty or invalid.');
    }

    try {
      final request = pb.AddMembersToContributionRequest()
        ..contributionId = contributionId
        ..memberUserIds.addAll(validUserIds);  // Pass only valid UUIDs

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.addMembersToContribution(request, options: callOptions);

      // Extract members from the updated contribution
      return response.contribution.members.map((m) => _mapContributionMemberFromProto(m)).toList();
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to add members to contribution'));
    }
  }

  @override
  Future<List<ContributionMemberModel>> getContributionMembers(String contributionId) async {
    try {
      final request = pb.GetContributionMembersRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getContributionMembers(request, options: callOptions);

      return response.members.map((m) => _mapContributionMemberFromProto(m)).toList();
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to get contribution members'));
    }
  }

  @override
  Future<MemberExitResult> removeMemberFromContribution({
    required String contributionId,
    required String userId,
  }) async {
    try {
      final request = pb.RemoveMemberFromContributionRequest()
        ..contributionId = contributionId
        ..memberUserId = userId;

      final callOptions = await _callOptionsHelper.withAuth();
      final resp = await _client.removeMemberFromContribution(request,
          options: callOptions);
      // Server returns minor units (kobo). Convert to major units —
      // same conversion the rest of this data source applies on the
      // read path so the UI layer always sees major units.
      return MemberExitResult(
        success: resp.success,
        refundAmount: _int64ToAmount(resp.refundAmount),
        forfeitedAmount: _int64ToAmount(resp.forfeitedAmount),
        refundStatus: resp.refundStatus,
        removalReason: resp.removalReason,
      );
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to remove member from contribution'));
    }
  }

  @override
  Future<int> removeContributionShadow({
    required String contributionId,
    required String userId,
  }) async {
    try {
      final request = pb.RemoveContributionShadowRequest()
        ..contributionId = contributionId
        ..memberUserId = userId;

      final callOptions = await _callOptionsHelper.withAuth();
      final resp = await _client.removeContributionShadow(request,
          options: callOptions);
      return resp.removedCount;
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to clear declined invite'));
    }
  }

  @override
  Future<({List<ContributionCycle> cycles, int total})> listContributionCycles({
    required String contributionId,
    bool includeInProgress = true,
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      final request = pb.ListContributionCyclesRequest()
        ..contributionId = contributionId
        ..includeInProgress = includeInProgress
        ..page = page
        ..pageSize = pageSize;
      final callOptions = await _callOptionsHelper.withAuth();
      final resp = await _client.listContributionCycles(request,
          options: callOptions);
      final cycles = resp.cycles.map(_mapCycleSummaryFromProto).toList();
      return (cycles: cycles, total: resp.totalCount);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to load cycles'));
    }
  }

  @override
  Future<ContributionCycleDetails> getContributionCycleDetails({
    required String contributionId,
    int cycleIndex = 0,
  }) async {
    try {
      final request = pb.GetContributionCycleDetailsRequest()
        ..contributionId = contributionId
        ..cycleIndex = cycleIndex;
      final callOptions = await _callOptionsHelper.withAuth();
      final resp = await _client.getContributionCycleDetails(request,
          options: callOptions);
      final d = resp.details;
      return ContributionCycleDetails(
        summary: _mapCycleSummaryFromProto(d.summary),
        members:
            d.members.map(_mapCycleMemberSnapshotFromProto).toList(),
        payments: d.payments.map((p) => _mapPaymentFromProto(p)).toList(),
      );
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to load cycle details'));
    }
  }

  @override
  Future<Contribution> restartContribution({
    required String contributionId,
    double? newTargetAmount,
    DateTime? newDeadline,
    String reason = '',
  }) async {
    try {
      final request = pb.RestartContributionRequest()
        ..contributionId = contributionId
        ..reason = reason;
      if (newTargetAmount != null && newTargetAmount > 0) {
        request.newTargetAmount = _amountToInt64(newTargetAmount);
      }
      if (newDeadline != null) {
        request.newDeadline = $pb_timestamp.Timestamp.fromDateTime(newDeadline.toUtc());
      }
      final callOptions = await _callOptionsHelper.withAuth();
      final resp = await _client.restartContribution(request,
          options: callOptions);
      return _mapContributionFromProto(resp.contribution);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to restart contribution'));
    }
  }

  ContributionCycle _mapCycleSummaryFromProto(
      pb.ContributionCycleSummary s) {
    return ContributionCycle(
      id: s.id,
      contributionId: s.contributionId,
      cycleIndex: s.cycleIndex,
      status: contributionCycleStatusFromString(s.status),
      startedAt: _timestampToDateTime(s.startedAt),
      endedAt: s.hasEndedAt() ? _timestampToDateTime(s.endedAt) : null,
      targetAmount: _int64ToAmount(s.targetAmount),
      raisedAmount: _int64ToAmount(s.raisedAmount),
      deficitAmount: _int64ToAmount(s.deficitAmount),
      payoutTransactionId:
          s.payoutTransactionId.isNotEmpty ? s.payoutTransactionId : null,
      receiverUserId:
          s.receiverUserId.isNotEmpty ? s.receiverUserId : null,
      receiverName: s.receiverName,
      paymentCount: s.paymentCount,
      membersCount: s.membersCount,
      pendingMembersCount: s.pendingMembersCount,
      partialMembersCount: s.partialMembersCount,
      closeReason: s.closeReason,
      currency: s.currency,
    );
  }

  ContributionCycleMemberSnapshot _mapCycleMemberSnapshotFromProto(
      pb.ContributionCycleMemberSnapshot m) {
    return ContributionCycleMemberSnapshot(
      userId: m.userId,
      userName: m.userName,
      email: m.email,
      expectedAmount: _int64ToAmount(m.expectedAmount),
      paidAmount: _int64ToAmount(m.paidAmount),
      hasPaid: m.hasPaid,
      wasReceiver: m.wasReceiver,
      missedCyclesAtClose: m.missedCyclesAtClose,
      statusAtClose: m.statusAtClose,
      joinedAt: m.hasJoinedAt() ? _timestampToDateTime(m.joinedAt) : null,
    );
  }

  @override
  Future<MemberExitPreview> previewMemberExit({
    required String contributionId,
    required String userId,
  }) async {
    try {
      final request = pb.PreviewMemberExitRequest()
        ..contributionId = contributionId
        ..memberUserId = userId;
      final callOptions = await _callOptionsHelper.withAuth();
      final resp =
          await _client.previewMemberExit(request, options: callOptions);
      return MemberExitPreview(
        exitAllowed: resp.exitAllowed,
        blockedReason: resp.blockedReason,
        removalReason: resp.removalReason,
        refundAmount: _int64ToAmount(resp.refundAmount),
        forfeitedAmount: _int64ToAmount(resp.forfeitedAmount),
        currency: resp.currency,
        memberHasReceivedPayout: resp.memberHasReceivedPayout,
        currentCycle: resp.currentCycle,
      );
    } on GrpcError catch (e) {
      throw Exception(
          friendlyGrpcError(e, 'Failed to preview member exit'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to get payments'));
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
    String? transactionPin,
    String? sourceAccountId,
    String? idempotencyKey,
  }) async {
    try {
      final request = pb.MakePaymentRequest()
        ..contributionId = contributionId
        ..amount = _amountToInt64(amount);

      if (notes != null && notes.isNotEmpty) {
        request.notes = notes;
      }

      // Send sourceAccountId - required for account lookup
      if (sourceAccountId != null && sourceAccountId.isNotEmpty) {
        request.sourceAccountId = sourceAccountId;
      }

      // Send transaction PIN token for validation
      if (transactionPin != null && transactionPin.isNotEmpty) {
        request.transactionPin = transactionPin;
      }

      // Send idempotency key for duplicate prevention
      if (idempotencyKey != null && idempotencyKey.isNotEmpty) {
        request.idempotencyKey = idempotencyKey;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.makePayment(request, options: callOptions);

      return _mapPaymentFromProto(response.payment);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to make payment'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to update payment status'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to process scheduled payments'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to get overdue contributions'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to update payment schedule'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to get payout schedule'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to process payout'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to update payout status'));
    }
  }

  @override
  Future<ContributionModel> calculateAndProcessPayout(String contributionId) async {
    try {
      final request = pb.ProcessPayoutRequest()..contributionId = contributionId;

      final callOptions = await _callOptionsHelper.withAuth();
      await _client.processPayout(request, options: callOptions);

      // Get updated contribution
      final getRequest = pb.GetContributionRequest()..contributionId = contributionId;
      final getResponse = await _client.getContribution(getRequest, options: callOptions);

      return _mapContributionFromProto(getResponse.contribution);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to calculate and process payout'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to advance payout rotation'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to generate receipt'));
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
      throw Exception(friendlyGrpcError(e, 'Failed to get user receipts'));
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

      // Amount fields come back from the gRPC server as MINOR units
      // (kobo). Every other read path on this data source converts to
      // major units via _int64ToAmount so the UI/cubit always sees a
      // consistent shape — apply the same here.
      //
      // Previous regression: the values were passed straight through
      // as Int64, which made any consumer of these stats render 100x
      // the actual amount (₦4,000,000 instead of ₦40,000). The path
      // wasn't bitten because the only consumer was an unused fire-
      // and-forget cubit method, but the latent inconsistency tripped
      // up the partial-payments slice when audit screens started
      // sourcing these values.
      return {
        'memberCount': response.memberCount,
        'totalContributions': response.totalContributions,
        'completedContributions': response.completedContributions,
        'activeContributions': response.activeContributions,
        'totalTargetAmount': _int64ToAmount(response.totalTargetAmount),
        'totalCurrentAmount': _int64ToAmount(response.totalCurrentAmount),
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
      adminId: group.adminId,  // Now a string in proto
      members: group.members.map((m) => _mapMemberFromProto(m)).toList(),
      contributions: [],
      createdAt: _timestampToDateTime(group.createdAt),
      updatedAt: _timestampToDateTime(group.updatedAt),
      status: _mapGroupStatusFromProto(group.status),
      metadata: group.metadata.isNotEmpty ? _decodeMetadata(group.metadata) : null,
      visibility: _visibilityFromProto(group.visibility),
      memberCount: group.memberCount,
      totalRaised: _int64ToAmount(group.totalRaised),
      imageUrl: group.imageUrl.isNotEmpty ? group.imageUrl : null,
      // Denormalized goal counter from migration 009 — list-groups
      // doesn't preload the contributions array, so this field is the
      // canonical source for the "Goals" stat tile on the My Groups
      // list. Field 15 in the proto; absent on a stale client gets
      // the proto default (0), which is also the safe fallback for a
      // group that legitimately has zero contributions.
      contributionCount: group.contributionCount,
    );
  }

  GroupVisibility _visibilityFromProto(pb.GroupVisibility visibility) {
    switch (visibility) {
      case pb.GroupVisibility.GROUP_VISIBILITY_PUBLIC:
        return GroupVisibility.public;
      default:
        return GroupVisibility.private;
    }
  }

  GroupMemberModel _mapMemberFromProto(pb.GroupMemberMessage member) {
    // The server returns pending invitees as shadow rows with
    // status=inactive + is_partial=true (no GROUP_MEMBER_STATUS_PENDING
    // proto value yet — would need a regen). Translate that combination
    // into the Flutter-side `pending` status so UI gates like
    // `isPendingInvite` light up without a proto change.
    var status = _mapMemberStatusFromProto(member.status);
    if (member.isPartial && status == GroupMemberStatus.inactive) {
      status = GroupMemberStatus.pending;
    }
    return GroupMemberModel(
      id: member.id,
      userId: member.userId,
      userName: member.userName,
      email: member.email,
      profileImage: member.profileImage.isNotEmpty ? member.profileImage : null,
      role: _mapRoleFromProto(member.role),
      joinedAt: _timestampToDateTime(member.joinedAt),
      status: status,
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
      createdBy: contribution.createdBy,  // Now a string in proto
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
      currentPayoutRecipient: contribution.currentPayoutRecipient.isNotEmpty ? contribution.currentPayoutRecipient : null,  // Now a string in proto
      nextPayoutDate: contribution.hasNextPayoutDate()
          ? _timestampToDateTime(contribution.nextPayoutDate)
          : null,
      payoutHistory: [],
      autoPayEnabled: contribution.autoPayEnabled,
      penaltyAmount: contribution.hasPenaltyAmount() ? _int64ToAmount(contribution.penaltyAmount) : null,
      gracePeriodDays: contribution.hasGracePeriodDays() ? contribution.gracePeriodDays : null,
      allowPartialPayments: contribution.allowPartialPayments,
      minimumBalance: contribution.hasMinimumBalance() ? _int64ToAmount(contribution.minimumBalance) : null,
      autoPayoutEnabled: contribution.autoPayoutEnabled,
      members: contribution.members.map((m) => _mapContributionMemberFromProto(m)).toList(),
    );
  }

  ContributionMemberModel _mapContributionMemberFromProto(pb.ContributionMemberMessage member) {
    return ContributionMemberModel(
      id: member.id,
      contributionId: member.contributionId,
      userId: member.userId,
      userName: member.userName,
      email: member.email,
      profileImage: member.profileImage.isNotEmpty ? member.profileImage : null,
      joinedAt: _timestampToDateTime(member.joinedAt),
      totalPaid: _int64ToAmount(member.totalPaid),
      expectedAmount: _int64ToAmount(member.expectedAmount),
      hasPaidCurrentCycle: member.hasPaidCurrentCycle,
      cyclePaidAmount: _int64ToAmount(member.cyclePaidAmount),
      missedCycles: member.missedCycles,
      membershipStatus:
          ContributionMembershipStatus.fromString(member.membershipStatus),
      linkedInvitationId:
          member.linkedInvitationId.isNotEmpty ? member.linkedInvitationId : null,
    );
  }

  // =====================================================================
  // Invite-first membership (slice 5)
  // =====================================================================

  /// Maps a proto GroupInvitationMessage to the domain entity. Wire
  /// status string is parsed defensively — unknown enum values map
  /// to GroupInvitationStatus.unknown so a server-side enum addition
  /// doesn't crash older Flutter builds.
  GroupInvitation _mapInvitationFromProto(pb.GroupInvitationMessage inv) {
    return GroupInvitation(
      id: inv.id,
      groupId: inv.groupId,
      inviteeUserId: inv.inviteeUserId,
      inviterUserId: inv.inviterUserId,
      role: inv.role,
      status: GroupInvitationStatus.fromString(inv.status),
      invitedAt: inv.hasInvitedAt()
          ? _timestampToDateTime(inv.invitedAt)
          : DateTime.now(),
      decidedAt:
          inv.hasDecidedAt() ? _timestampToDateTime(inv.decidedAt) : null,
      expiresAt: inv.hasExpiresAt()
          ? _timestampToDateTime(inv.expiresAt)
          : DateTime.now().add(const Duration(days: 30)),
      message: inv.message,
      groupName: inv.groupName,
      groupDescription: inv.groupDescription,
      inviterName: inv.inviterName,
    );
  }

  Future<GroupInvitation> inviteToGroup({
    required String groupId,
    required String inviteeUserId,
    String? role,
    String? message,
  }) async {
    try {
      final req = pb.InviteToGroupRequest()
        ..groupId = groupId
        ..inviteeUserId = inviteeUserId;
      if (role != null && role.isNotEmpty) req.role = role;
      if (message != null && message.isNotEmpty) req.message = message;
      final opts = await _callOptionsHelper.withAuth();
      final resp = await _client.inviteToGroup(req, options: opts);
      return _mapInvitationFromProto(resp.invitation);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to send invitation'));
    }
  }

  Future<GroupInvitation> respondToGroupInvite({
    required String invitationId,
    required bool accept,
  }) async {
    try {
      final req = pb.RespondToGroupInviteRequest()
        ..invitationId = invitationId
        ..accept = accept;
      final opts = await _callOptionsHelper.withAuth();
      final resp = await _client.respondToGroupInvite(req, options: opts);
      return _mapInvitationFromProto(resp.invitation);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to respond to invitation'));
    }
  }

  Future<void> cancelGroupInvite({required String invitationId}) async {
    try {
      final req = pb.CancelGroupInviteRequest()..invitationId = invitationId;
      final opts = await _callOptionsHelper.withAuth();
      await _client.cancelGroupInvite(req, options: opts);
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to cancel invitation'));
    }
  }

  Future<List<GroupInvitation>> listMyInvitations({
    List<GroupInvitationStatus>? statuses,
    int limit = 50,
  }) async {
    try {
      final req = pb.ListMyInvitationsRequest()..limit = limit;
      if (statuses != null) {
        req.statuses.addAll(statuses.map((s) => s.wireValue).where((s) => s.isNotEmpty));
      }
      final opts = await _callOptionsHelper.withAuth();
      final resp = await _client.listMyInvitations(req, options: opts);
      return resp.invitations.map(_mapInvitationFromProto).toList();
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to load invitations'));
    }
  }

  Future<List<GroupInvitation>> listGroupInvitations({
    required String groupId,
    List<GroupInvitationStatus>? statuses,
    int limit = 100,
  }) async {
    try {
      final req = pb.ListGroupInvitationsRequest()
        ..groupId = groupId
        ..limit = limit;
      if (statuses != null) {
        req.statuses.addAll(statuses.map((s) => s.wireValue).where((s) => s.isNotEmpty));
      }
      final opts = await _callOptionsHelper.withAuth();
      final resp = await _client.listGroupInvitations(req, options: opts);
      return resp.invitations.map(_mapInvitationFromProto).toList();
    } on GrpcError catch (e) {
      throw Exception(friendlyGrpcError(e, 'Failed to load group invitations'));
    }
  }

  ContributionPaymentModel _mapPaymentFromProto(pb.ContributionPaymentMessage payment) {
    return ContributionPaymentModel(
      id: payment.id,
      contributionId: payment.contributionId,
      groupId: payment.groupId,
      userId: payment.userId,
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
      userId: schedule.userId,
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
      recipientUserId: payout.recipientUserId,
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
      userId: receipt.userId,
      userName: receipt.userName,
      amount: _int64ToAmount(receipt.amount),
      currency: receipt.currency,
      paymentDate: _timestampToDateTime(receipt.paymentDate),
      generatedAt: _timestampToDateTime(receipt.generatedAt),
      receiptNumber: receipt.receiptNumber,
      receiptData: receipt.receiptData.isNotEmpty
          ? (jsonDecode(receipt.receiptData) as Map<String, dynamic>)
          : {},
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
      memberContributions: transcript.memberContributions.isNotEmpty
          ? Map<String, double>.from(
              (jsonDecode(transcript.memberContributions) as Map<String, dynamic>).map(
                (k, v) => MapEntry(k, (v as num).toDouble()),
              ),
            )
          : {},
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

  pb_enum.GroupAccountStatus _mapGroupStatusToProto(GroupAccountStatus status) {
    switch (status) {
      case GroupAccountStatus.active:
        return pb_enum.GroupAccountStatus.GROUP_ACCOUNT_STATUS_ACTIVE;
      case GroupAccountStatus.suspended:
        return pb_enum.GroupAccountStatus.GROUP_ACCOUNT_STATUS_SUSPENDED;
      case GroupAccountStatus.deleted:
        return pb_enum.GroupAccountStatus.GROUP_ACCOUNT_STATUS_CLOSED;
    }
  }

  GroupMemberRole _mapRoleFromProto(pb_enum.GroupMemberRole role) {
    switch (role) {
      case pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_ADMIN:
        return GroupMemberRole.admin;
      case pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_MODERATOR:
        return GroupMemberRole.moderator;
      case pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_VIEWER:
        return GroupMemberRole.viewer;
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
        return pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_MODERATOR;
      case GroupMemberRole.member:
        return pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_MEMBER;
      case GroupMemberRole.viewer:
        return pb_enum.GroupMemberRole.GROUP_MEMBER_ROLE_VIEWER;
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
      case pb_enum.GroupMemberStatus.GROUP_MEMBER_STATUS_PENDING:
        return GroupMemberStatus.pending;
      default:
        return GroupMemberStatus.active;
    }
  }

  ContributionType _mapContributionTypeFromProto(pb_enum.ContributionType type) {
    switch (type) {
      case pb_enum.ContributionType.CONTRIBUTION_TYPE_ONE_TIME:
        return ContributionType.oneTime;
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
      case ContributionType.rotatingSavings:
        return pb_enum.ContributionType.CONTRIBUTION_TYPE_ROTATING_SAVINGS;
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
    }
  }

  PaymentStatus _mapPaymentStatusFromProto(pb_enum.PaymentStatus status) {
    switch (status) {
      case pb_enum.PaymentStatus.PAYMENT_STATUS_PENDING:
        return PaymentStatus.pending;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_PROCESSING:
        return PaymentStatus.processing;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_AWAITING_VERIFICATION:
        return PaymentStatus.awaitingVerification;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_COMPLETED:
        return PaymentStatus.completed;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_FAILED:
        return PaymentStatus.failed;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_REFUNDING:
        return PaymentStatus.refunding;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_REFUNDED:
        return PaymentStatus.refunded;
      case pb_enum.PaymentStatus.PAYMENT_STATUS_MANUAL_REVIEW:
        return PaymentStatus.manualReview;
      default:
        return PaymentStatus.pending;
    }
  }

  pb_enum.PaymentStatus _mapPaymentStatusToProto(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_PENDING;
      case PaymentStatus.processing:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_PROCESSING;
      case PaymentStatus.awaitingVerification:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_AWAITING_VERIFICATION;
      case PaymentStatus.completed:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_COMPLETED;
      case PaymentStatus.failed:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_FAILED;
      case PaymentStatus.cancelled:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_FAILED; // legacy: no proto equivalent
      case PaymentStatus.refunding:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_REFUNDING;
      case PaymentStatus.refunded:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_REFUNDED;
      case PaymentStatus.manualReview:
        return pb_enum.PaymentStatus.PAYMENT_STATUS_MANUAL_REVIEW;
    }
  }

  PayoutStatus _mapPayoutStatusFromProto(pb_enum.PayoutStatus status) {
    switch (status) {
      case pb_enum.PayoutStatus.PAYOUT_STATUS_PENDING:
        return PayoutStatus.pending;
      case pb_enum.PayoutStatus.PAYOUT_STATUS_PROCESSING:
        return PayoutStatus.processing;
      case pb_enum.PayoutStatus.PAYOUT_STATUS_COMPLETED:
        return PayoutStatus.completed;
      case pb_enum.PayoutStatus.PAYOUT_STATUS_FAILED:
        return PayoutStatus.failed;
      case pb_enum.PayoutStatus.PAYOUT_STATUS_CANCELLED:
        return PayoutStatus.cancelled;
      case pb_enum.PayoutStatus.PAYOUT_STATUS_MANUAL_REVIEW:
        return PayoutStatus.manualReview;
      default:
        return PayoutStatus.pending;
    }
  }

  PayoutTransactionStatus _mapPayoutTransactionStatusFromProto(pb_enum.PayoutTransactionStatus status) {
    switch (status) {
      case pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_PENDING:
        return PayoutTransactionStatus.pending;
      case pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_PROCESSING:
        return PayoutTransactionStatus.processing;
      case pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_COMPLETED:
        return PayoutTransactionStatus.completed;
      case pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_FAILED:
        return PayoutTransactionStatus.failed;
      case pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_REFUNDED:
        return PayoutTransactionStatus.refunded;
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
      case PayoutTransactionStatus.refunded:
        return pb_enum.PayoutTransactionStatus.PAYOUT_TRANSACTION_STATUS_REFUNDED;
    }
  }

  // ============================================================================
  // ACTIVITY LOGS
  // ============================================================================

  @override
  Future<List<ActivityLogEntryModel>> getGroupActivityLogs(String groupId) async {
    try {
      final request = pb.GetGroupActivityLogsRequest()
        ..groupId = groupId
        ..page = 1
        ..pageSize = 50;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getGroupActivityLogs(request, options: callOptions);

      return response.logs.map((log) => _mapActivityLogFromProto(log)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get group activity logs'}');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ActivityLogEntryModel>> getContributionActivityLogs(String contributionId) async {
    try {
      final request = pb.GetContributionActivityLogsRequest()
        ..contributionId = contributionId
        ..page = 1
        ..pageSize = 50;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getContributionActivityLogs(request, options: callOptions);

      return response.logs.map((log) => _mapActivityLogFromProto(log)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get contribution activity logs'}');
    } catch (e) {
      rethrow;
    }
  }

  ActivityLogEntryModel _mapActivityLogFromProto(pb.GroupActivityLogMessage log) {
    // Parse details JSON string to Map
    Map<String, dynamic>? detailsMap;
    if (log.details.isNotEmpty) {
      try {
        detailsMap = jsonDecode(log.details) as Map<String, dynamic>;
      } catch (e) {
        // If JSON parsing fails, store as raw string
        detailsMap = {'raw': log.details};
      }
    }

    return ActivityLogEntryModel(
      id: log.id,
      groupId: log.groupId,
      contributionId: log.contributionId.isNotEmpty ? log.contributionId : null,
      actorUserId: log.actorUserId,
      actorName: log.actorName,
      actionType: log.actionType,
      targetType: log.targetType.isNotEmpty ? log.targetType : null,
      targetId: log.targetId.isNotEmpty ? log.targetId : null,
      details: detailsMap,
      createdAt: log.hasCreatedAt() ? _timestampToDateTime(log.createdAt) : DateTime.now(),
    );
  }

  // ============================================================================
  // METADATA HELPERS
  // ============================================================================

  /// Encode metadata Map to JSON string for gRPC transmission
  String _encodeMetadata(Map<String, dynamic> metadata) {
    try {
      return jsonEncode(metadata);
    } catch (e) {
      return '{}';
    }
  }

  /// Decode metadata JSON string from gRPC to Map
  Map<String, dynamic> _decodeMetadata(String metadataJson) {
    try {
      if (metadataJson.isEmpty) return {};
      final decoded = jsonDecode(metadataJson) as Map<String, dynamic>;
      return decoded;
    } catch (e) {
      return {};
    }
  }

  pb.GroupVisibility _visibilityToProto(GroupVisibility visibility) {
    switch (visibility) {
      case GroupVisibility.private:
        return pb.GroupVisibility.GROUP_VISIBILITY_PRIVATE;
      case GroupVisibility.public:
        return pb.GroupVisibility.GROUP_VISIBILITY_PUBLIC;
    }
  }

  // ============================================================================
  // PUBLIC GROUP DISCOVERY
  // ============================================================================

  @override
  Future<List<GroupAccountModel>> listPublicGroups({
    int page = 1,
    int pageSize = 20,
    String? sortBy,
    String? searchQuery,
  }) async {
    try {
      final request = pb.ListPublicGroupsRequest()
        ..page = page
        ..pageSize = pageSize;

      if (sortBy != null && sortBy.isNotEmpty) {
        request.sortBy = sortBy;
      }
      if (searchQuery != null && searchQuery.isNotEmpty) {
        request.searchQuery = searchQuery;
      }

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.listPublicGroups(request, options: callOptions);

      return response.groups.map((group) => _mapGroupFromProto(group)).toList();
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to list public groups'}');
    }
  }

  @override
  Future<PublicGroupDetailModel> getPublicGroup(String groupId) async {
    try {
      final request = pb.GetPublicGroupRequest()..groupId = groupId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.getPublicGroup(request, options: callOptions);

      final group = _mapGroupFromProto(response.group);
      final topContributors = response.topContributors.map((c) =>
        PublicGroupContributor(
          userId: c.userId,
          displayName: c.displayName,
          totalContributed: _int64ToAmount(c.totalContributed),
          contributionCount: c.contributionCount,
          profileImage: c.profileImage.isNotEmpty ? c.profileImage : null,
        ),
      ).toList();

      final stats = response.hasStatistics() ? <String, dynamic>{
        'memberCount': response.statistics.memberCount,
        'activeContributions': response.statistics.activeContributions,
        'totalContributions': response.statistics.totalContributions,
        'completedContributions': response.statistics.completedContributions,
        'totalTargetAmount': _int64ToAmount(response.statistics.totalTargetAmount),
        'totalCurrentAmount': _int64ToAmount(response.statistics.totalCurrentAmount),
        'completionRate': response.statistics.completionRate,
      } : null;

      return PublicGroupDetailModel(
        group: group,
        statistics: stats,
        topContributors: topContributors,
        isMember: response.isMember,
      );
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to get public group'}');
    }
  }

  @override
  Future<GroupAccountModel> joinPublicGroup(String groupId) async {
    try {
      final request = pb.JoinPublicGroupRequest()..groupId = groupId;

      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _client.joinPublicGroup(request, options: callOptions);

      return _mapGroupFromProto(response.group);
    } on GrpcError catch (e) {
      throw Exception('gRPC Error (${e.codeName}): ${e.message ?? 'Failed to join public group'}');
    }
  }

  // ============================================================================
  // ENUM MAPPING HELPERS
}
