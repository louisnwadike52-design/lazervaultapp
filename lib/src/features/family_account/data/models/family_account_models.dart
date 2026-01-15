export 'package:lazervault/src/features/family_account/data/models/family_account_proto.dart';
import 'package:lazervault/src/features/family_account/data/models/family_account_proto.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';

// Extension methods to convert Proto DTOs to Domain Entities

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
      status: FamilyAccountStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => FamilyAccountStatus.active,
      ),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      members: members.map((m) => m.toDomain()).toList(),
      memberCount: memberCount,
      activeMemberCount: activeMemberCount,
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
      invitationExpiresAt: DateTime.parse(invitationExpiresAt),
      cardLastFour: cardLastFour,
      hasCard: hasCard,
      joinedAt: joinedAt != null ? DateTime.parse(joinedAt!) : null,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
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
      createdAt: DateTime.parse(createdAt),
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
      expiresAt: DateTime.parse(expiresAt),
      createdAt: DateTime.parse(createdAt),
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
      status: status.name,
      createdAt: createdAt.toIso8601String(),
      updatedAt: updatedAt.toIso8601String(),
      members: members.map((m) => m.toProto()).toList(),
      memberCount: memberCount,
      activeMemberCount: activeMemberCount,
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
