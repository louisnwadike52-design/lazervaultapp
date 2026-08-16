export 'package:lazervault/src/features/family_account/data/models/family_account_proto.dart';
import 'package:lazervault/src/features/family_account/data/models/family_account_proto.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';

// Extension methods to convert Proto DTOs to Domain Entities

FamilyAccountStatus _parseFamilyAccountStatus(String status) {
  switch (status) {
    case 'active':
      return FamilyAccountStatus.active;
    case 'frozen':
      return FamilyAccountStatus.frozen;
    case 'closed':
      return FamilyAccountStatus.closed;
    case 'pending_setup':
      return FamilyAccountStatus.pendingSetup;
    default:
      return FamilyAccountStatus.active;
  }
}

String _serializeFamilyAccountStatus(FamilyAccountStatus status) {
  switch (status) {
    case FamilyAccountStatus.active:
      return 'active';
    case FamilyAccountStatus.frozen:
      return 'frozen';
    case FamilyAccountStatus.closed:
      return 'closed';
    case FamilyAccountStatus.pendingSetup:
      return 'pending_setup';
  }
}

extension FamilyAccountProtoExtension on FamilyAccountProto {
  FamilyAccount toDomain() {
    return FamilyAccount(
      id: id,
      creatorId: creatorId,
      creatorName: creatorName,
      name: name,
      description: description,
      totalAllocatedBalance: totalAllocatedBalance,
      totalPoolBalance: totalPoolBalance,
      allowMemberContributions: allowMemberContributions,
      totalBalance: totalBalance,
      status: _parseFamilyAccountStatus(status),
      createdAt: _parseDate(createdAt),
      updatedAt: _parseDate(updatedAt),
      members: members.map((m) => m.toDomain()).toList(),
      memberCount: memberCount,
      activeMemberCount: activeMemberCount,
      fundDistributionMode: FundDistributionModeExtension.fromString(fundDistributionMode),
      setupCompleted: setupCompleted,
      spendingVisibilityEnabled: spendingVisibilityEnabled,
      fundingPolicy: fundingPolicy,
      accountNumber: accountNumber,
      bankName: bankName,
      virtualAccountStatus: virtualAccountStatus,
      summary: summary,
    );
  }
}

extension FamilyMemberProtoExtension on FamilyMemberProto {
  FamilyMember toDomain() {
    return FamilyMember(
      id: id,
      familyId: familyId,
      userId: userId,
      fullName: fullName,
      email: email,
      phone: phone,
      username: username,
      avatarUrl: avatarUrl,
      role: FamilyMemberRole.values.firstWhere(
        (e) => e.name == role,
        orElse: () => FamilyMemberRole.member,
      ),
      allocatedBalance: allocatedBalance,
      dailySpendingLimit: dailySpendingLimit,
      monthlySpendingLimit: monthlySpendingLimit,
      perTransactionLimit: perTransactionLimit,
      allocationPercentageCap: allocationPercentageCap,
      spentToday: spentToday,
      spentThisMonth: spentThisMonth,
      remainingBalance: remainingBalance,
      invitationStatus: InvitationStatus.values.firstWhere(
        (e) => e.name == invitationStatus,
        orElse: () => InvitationStatus.pending,
      ),
      invitationToken: invitationToken,
      invitationExpiresAt: _parseDate(invitationExpiresAt),
      cardLastFour: cardLastFour,
      hasCard: hasCard,
      joinedAt: _parseNullableDate(joinedAt),
      createdAt: _parseDate(createdAt),
      updatedAt: _parseDate(updatedAt),
    );
  }
}

extension FamilyTransactionProtoExtension on FamilyTransactionProto {
  FamilyTransaction toDomain() {
    return FamilyTransaction(
      id: id,
      familyId: familyId,
      memberId: memberId,
      memberName: memberName,
      memberAvatar: memberAvatar,
      transactionId: transactionId,
      amount: amount,
      type: FamilyTransactionType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => FamilyTransactionType.allocation,
      ),
      description: description,
      merchantName: merchantName,
      merchantCategory: merchantCategory,
      metadata: metadata,
      createdAt: _parseDate(createdAt),
    );
  }
}

extension PendingInvitationProtoExtension on PendingInvitationProto {
  PendingInvitation toDomain() {
    return PendingInvitation(
      invitationToken: invitationToken,
      familyId: familyId,
      familyName: familyName,
      creatorName: creatorName,
      creatorAvatar: creatorAvatar,
      initialAllocation: initialAllocation,
      dailyLimit: dailyLimit,
      monthlyLimit: monthlyLimit,
      perTransactionLimit: perTransactionLimit,
      allocationPercentageCap: allocationPercentageCap,
      invitedBy: invitedBy,
      expiresAt: _parseDate(expiresAt),
      createdAt: _parseDate(createdAt),
    );
  }
}

// Extension to convert Domain Entities to Proto DTOs (for sending to backend)

extension FamilyAccountExtension on FamilyAccount {
  FamilyAccountProto toProto() {
    return FamilyAccountProto(
      id: id,
      creatorId: creatorId,
      creatorName: creatorName,
      name: name,
      description: description,
      totalAllocatedBalance: totalAllocatedBalance,
      totalPoolBalance: totalPoolBalance,
      allowMemberContributions: allowMemberContributions,
      totalBalance: totalBalance,
      status: _serializeFamilyAccountStatus(status),
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt.toIso8601String(),
      members: members.map((m) => m.toProto()).toList(),
      memberCount: memberCount,
      activeMemberCount: activeMemberCount,
      fundDistributionMode: fundDistributionMode.value,
      setupCompleted: setupCompleted,
      spendingVisibilityEnabled: spendingVisibilityEnabled,
    );
  }
}

extension FamilyMemberExtension on FamilyMember {
  FamilyMemberProto toProto() {
    return FamilyMemberProto(
      id: id,
      familyId: familyId,
      userId: userId,
      fullName: fullName,
      email: email,
      phone: phone,
      username: username,
      avatarUrl: avatarUrl,
      role: role.name,
      allocatedBalance: allocatedBalance,
      dailySpendingLimit: dailySpendingLimit,
      monthlySpendingLimit: monthlySpendingLimit,
      perTransactionLimit: perTransactionLimit,
      allocationPercentageCap: allocationPercentageCap,
      spentToday: spentToday,
      spentThisMonth: spentThisMonth,
      remainingBalance: remainingBalance,
      invitationStatus: invitationStatus.name,
      invitationToken: invitationToken,
      invitationExpiresAt: invitationExpiresAt.toIso8601String(),
      cardLastFour: cardLastFour,
      hasCard: hasCard,
      joinedAt: joinedAt?.toIso8601String(),
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt.toIso8601String(),
    );
  }
}

// ─── Invite history mappers ────────────────────────────────────────────

DateTime? _parseNullableDate(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  return DateTime.tryParse(raw);
}

/// Safe parse for NON-nullable DateTime fields. proto3 strings default to ""
/// (never null), so unset timestamps arrive as empty strings — e.g. a freshly
/// invited member has no joinedAt / invitationExpiresAt. DateTime.parse("")
/// throws FormatException, which previously surfaced "Invalid date format" on
/// an otherwise-successful activation. Fall back to epoch instead of throwing.
DateTime _parseDate(String? raw) {
  if (raw == null || raw.isEmpty) {
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
  return DateTime.tryParse(raw) ?? DateTime.fromMillisecondsSinceEpoch(0);
}

InvitationStatus _parseInvitationStatus(String raw) {
  switch (raw) {
    case 'pending':
      return InvitationStatus.pending;
    case 'accepted':
      return InvitationStatus.accepted;
    case 'declined':
      return InvitationStatus.declined;
    case 'removed':
      return InvitationStatus.removed;
    case 'expired':
      return InvitationStatus.expired;
    default:
      // Backend should never send anything else, but if it does we map
      // to expired so the row appears in History (not Pending) — defensive
      // default so users don't see an empty "?" status.
      return InvitationStatus.expired;
  }
}

FamilyMemberRole _parseFamilyMemberRole(String raw) {
  switch (raw) {
    case 'admin':
      return FamilyMemberRole.admin;
    default:
      return FamilyMemberRole.member;
  }
}

extension InvitationHistoryEntryProtoExtension on InvitationHistoryEntryProto {
  InvitationHistoryEntry toDomain() {
    return InvitationHistoryEntry(
      invitationToken: invitationToken,
      familyId: familyId,
      familyName: familyName,
      creatorName: creatorName,
      creatorAvatar: creatorAvatar,
      invitedBy: invitedBy,
      status: _parseInvitationStatus(invitationStatus),
      initialAllocation: initialAllocation,
      dailyLimit: dailyLimit,
      monthlyLimit: monthlyLimit,
      invitationMethod: invitationMethod,
      invitationDestination: invitationDestination,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      expiresAt: _parseNullableDate(expiresAt),
      respondedAt: _parseNullableDate(respondedAt),
    );
  }
}

extension SentInvitationEntryProtoExtension on SentInvitationEntryProto {
  SentInvitationEntry toDomain() {
    return SentInvitationEntry(
      memberId: memberId,
      familyId: familyId,
      familyName: familyName,
      invitationMethod: invitationMethod,
      invitationDestination: invitationDestination,
      status: _parseInvitationStatus(invitationStatus),
      invitedUserId: invitedUserId,
      invitedUserName: invitedUserName,
      invitedUserAvatar: invitedUserAvatar,
      initialAllocation: initialAllocation,
      dailyLimit: dailyLimit,
      monthlyLimit: monthlyLimit,
      role: _parseFamilyMemberRole(role),
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      expiresAt: _parseNullableDate(expiresAt),
      respondedAt: _parseNullableDate(respondedAt),
    );
  }
}
