// Proto message definitions for Family Accounts
// These correspond to the backend proto definitions

// Enums
enum FamilyAccountStatusProto {
  active,
  frozen,
  closed;
}

enum FamilyMemberRoleProto {
  admin,
  member;
}

enum InvitationStatusProto {
  pending,
  accepted,
  declined,
  removed,
  expired;
}

enum FamilyTransactionTypeProto {
  allocation,
  spending,
  refund,
  adjustment,
  removal,
  contribution;
}

// Request/Response Messages

class CreateFamilyAccountRequest {
  final String name;
  final String? description;
  final String initialCurrency;
  final double initialFunding;
  final bool allowMemberContributions;
  final String creatorId;
  final String creatorName;
  final String? creatorEmail;

  CreateFamilyAccountRequest({
    required this.name,
    this.description,
    required this.initialCurrency,
    required this.initialFunding,
    required this.allowMemberContributions,
    required this.creatorId,
    required this.creatorName,
    this.creatorEmail,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (description != null) 'description': description,
      'initial_currency': initialCurrency,
      'initial_funding': initialFunding,
      'allow_member_contributions': allowMemberContributions,
      'creator_id': creatorId,
      'creator_name': creatorName,
      if (creatorEmail != null) 'creator_email': creatorEmail,
    };
  }

  factory CreateFamilyAccountRequest.fromJson(Map<String, dynamic> json) {
    return CreateFamilyAccountRequest(
      name: json['name'] as String,
      description: json['description'] as String?,
      initialCurrency: json['initial_currency'] as String? ?? 'USD',
      initialFunding: (json['initial_funding'] as num?)?.toDouble() ?? 0.0,
      allowMemberContributions: json['allow_member_contributions'] as bool? ?? true,
      creatorId: json['creator_id'] as String? ?? '',
      creatorName: json['creator_name'] as String? ?? '',
      creatorEmail: json['creator_email'] as String?,
    );
  }
}

class CreateFamilyAccountResponse {
  final FamilyAccountProto? familyAccount;
  final String message;

  CreateFamilyAccountResponse({
    this.familyAccount,
    required this.message,
  });

  factory CreateFamilyAccountResponse.fromJson(Map<String, dynamic> json) {
    return CreateFamilyAccountResponse(
      familyAccount: json['family_account'] != null
          ? FamilyAccountProto.fromJson(json['family_account'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String,
    );
  }
}

class AddFamilyMemberRequest {
  final String familyId;
  final String fullName;
  final String invitationMethod;
  final String invitationDestination;
  final double initialAllocation;
  final double dailyLimit;
  final double monthlyLimit;
  final double perTransactionLimit;
  final double allocationPercentageCap;
  final String role;
  final String? personalMessage;

  AddFamilyMemberRequest({
    required this.familyId,
    required this.fullName,
    required this.invitationMethod,
    required this.invitationDestination,
    required this.initialAllocation,
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.perTransactionLimit,
    required this.allocationPercentageCap,
    required this.role,
    this.personalMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'family_id': familyId,
      'full_name': fullName,
      'invitation_method': invitationMethod,
      'invitation_destination': invitationDestination,
      'initial_allocation': initialAllocation,
      'daily_limit': dailyLimit,
      'monthly_limit': monthlyLimit,
      'per_transaction_limit': perTransactionLimit,
      'allocation_percentage_cap': allocationPercentageCap,
      'role': role,
      if (personalMessage != null) 'personal_message': personalMessage,
    };
  }
}

class AddFamilyMemberResponse {
  final FamilyMemberProto? member;
  final String invitationMessage;
  final String? invitationLink;

  AddFamilyMemberResponse({
    this.member,
    required this.invitationMessage,
    this.invitationLink,
  });

  factory AddFamilyMemberResponse.fromJson(Map<String, dynamic> json) {
    return AddFamilyMemberResponse(
      member: json['member'] != null
          ? FamilyMemberProto.fromJson(json['member'] as Map<String, dynamic>)
          : null,
      invitationMessage: json['invitation_message'] as String,
      invitationLink: json['invitation_link'] as String?,
    );
  }
}

class UpdateFamilyMemberRequest {
  final String familyId;
  final String memberId;
  final double? allocatedBalance;
  final double? dailySpendingLimit;
  final double? monthlySpendingLimit;
  final double? perTransactionLimit;
  final double? allocationPercentageCap;
  final String? role;

  UpdateFamilyMemberRequest({
    required this.familyId,
    required this.memberId,
    this.allocatedBalance,
    this.dailySpendingLimit,
    this.monthlySpendingLimit,
    this.perTransactionLimit,
    this.allocationPercentageCap,
    this.role,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'family_id': familyId,
      'member_id': memberId,
    };
    if (allocatedBalance != null) json['allocated_balance'] = allocatedBalance;
    if (dailySpendingLimit != null) json['daily_spending_limit'] = dailySpendingLimit;
    if (monthlySpendingLimit != null) json['monthly_spending_limit'] = monthlySpendingLimit;
    if (perTransactionLimit != null) json['per_transaction_limit'] = perTransactionLimit;
    if (allocationPercentageCap != null) json['allocation_percentage_cap'] = allocationPercentageCap;
    if (role != null) json['role'] = role;
    return json;
  }
}

class UpdateFamilyMemberResponse {
  final FamilyMemberProto? member;
  final String message;

  UpdateFamilyMemberResponse({
    this.member,
    required this.message,
  });

  factory UpdateFamilyMemberResponse.fromJson(Map<String, dynamic> json) {
    return UpdateFamilyMemberResponse(
      member: json['member'] != null
          ? FamilyMemberProto.fromJson(json['member'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String,
    );
  }
}

// Proto Message Models

class FamilyAccountProto {
  final String id;
  final String creatorId;
  final String creatorName;
  final String name;
  final String? description;
  final double totalAllocatedBalance;
  final double totalPoolBalance;
  final bool allowMemberContributions;
  final double totalBalance;
  final String status;
  final String createdAt;
  final String updatedAt;
  final List<FamilyMemberProto> members;
  final int memberCount;
  final int activeMemberCount;
  final String fundDistributionMode;
  final bool setupCompleted;
  final bool spendingVisibilityEnabled;

  FamilyAccountProto({
    required this.id,
    required this.creatorId,
    required this.creatorName,
    required this.name,
    this.description,
    required this.totalAllocatedBalance,
    required this.totalPoolBalance,
    required this.allowMemberContributions,
    required this.totalBalance,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
    required this.memberCount,
    required this.activeMemberCount,
    this.fundDistributionMode = 'custom_allocation',
    this.setupCompleted = false,
    this.spendingVisibilityEnabled = true,
  });

  factory FamilyAccountProto.fromJson(Map<String, dynamic> json) {
    return FamilyAccountProto(
      id: json['id'] as String,
      creatorId: json['creator_id'] as String,
      creatorName: json['creator_name'] as String? ?? '',
      name: json['name'] as String,
      description: json['description'] as String?,
      totalAllocatedBalance: (json['total_allocated_balance'] as num?)?.toDouble() ?? 0.0,
      totalPoolBalance: (json['total_pool_balance'] as num?)?.toDouble() ?? 0.0,
      allowMemberContributions: json['allow_member_contributions'] as bool? ?? true,
      totalBalance: (json['total_balance'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? 'active',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
      members: (json['members'] as List?)
              ?.map((e) => FamilyMemberProto.fromJson(e as Map<String, dynamic>))
              .toList() ?? [],
      memberCount: json['member_count'] as int? ?? 0,
      activeMemberCount: json['active_member_count'] as int? ?? 0,
      fundDistributionMode: json['fund_distribution_mode'] as String? ?? 'custom_allocation',
      setupCompleted: json['setup_completed'] as bool? ?? false,
      spendingVisibilityEnabled: json['spending_visibility_enabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creator_id': creatorId,
      'creator_name': creatorName,
      'name': name,
      if (description != null) 'description': description,
      'total_allocated_balance': totalAllocatedBalance,
      'total_pool_balance': totalPoolBalance,
      'allow_member_contributions': allowMemberContributions,
      'total_balance': totalBalance,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'members': members.map((e) => e.toJson()).toList(),
      'member_count': memberCount,
      'active_member_count': activeMemberCount,
      'fund_distribution_mode': fundDistributionMode,
      'setup_completed': setupCompleted,
      'spending_visibility_enabled': spendingVisibilityEnabled,
    };
  }
}

class FamilyMemberProto {
  final String id;
  final String familyId;
  final String? userId;
  final String fullName;
  final String? email;
  final String? phone;
  final String? username;
  final String? avatarUrl;
  final String role;
  final double allocatedBalance;
  final double dailySpendingLimit;
  final double monthlySpendingLimit;
  final double perTransactionLimit;
  final double allocationPercentageCap;
  final double spentToday;
  final double spentThisMonth;
  final double remainingBalance;
  final String invitationStatus;
  final String invitationToken;
  final String invitationExpiresAt;
  final String? cardLastFour;
  final bool hasCard;
  final String? joinedAt;
  final String createdAt;
  final String updatedAt;

  FamilyMemberProto({
    required this.id,
    required this.familyId,
    this.userId,
    required this.fullName,
    this.email,
    this.phone,
    this.username,
    this.avatarUrl,
    required this.role,
    required this.allocatedBalance,
    required this.dailySpendingLimit,
    required this.monthlySpendingLimit,
    required this.perTransactionLimit,
    required this.allocationPercentageCap,
    required this.spentToday,
    required this.spentThisMonth,
    required this.remainingBalance,
    required this.invitationStatus,
    required this.invitationToken,
    required this.invitationExpiresAt,
    this.cardLastFour,
    required this.hasCard,
    this.joinedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FamilyMemberProto.fromJson(Map<String, dynamic> json) {
    return FamilyMemberProto(
      id: json['id'] as String,
      familyId: json['family_id'] as String,
      userId: json['user_id'] as String?,
      fullName: json['full_name'] as String? ?? '',
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      username: json['username'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String? ?? 'member',
      allocatedBalance: (json['allocated_balance'] as num?)?.toDouble() ?? 0.0,
      dailySpendingLimit: (json['daily_spending_limit'] as num?)?.toDouble() ?? 0.0,
      monthlySpendingLimit: (json['monthly_spending_limit'] as num?)?.toDouble() ?? 0.0,
      perTransactionLimit: (json['per_transaction_limit'] as num?)?.toDouble() ?? 0.0,
      allocationPercentageCap: (json['allocation_percentage_cap'] as num?)?.toDouble() ?? 100.0,
      spentToday: (json['spent_today'] as num?)?.toDouble() ?? 0.0,
      spentThisMonth: (json['spent_this_month'] as num?)?.toDouble() ?? 0.0,
      remainingBalance: (json['remaining_balance'] as num?)?.toDouble() ?? 0.0,
      invitationStatus: json['invitation_status'] as String? ?? 'pending',
      invitationToken: json['invitation_token'] as String? ?? '',
      invitationExpiresAt: json['invitation_expires_at'] as String? ?? '',
      cardLastFour: json['card_last_four'] as String?,
      hasCard: json['has_card'] as bool? ?? false,
      joinedAt: json['joined_at'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'family_id': familyId,
      if (userId != null) 'user_id': userId,
      'full_name': fullName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (username != null) 'username': username,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      'role': role,
      'allocated_balance': allocatedBalance,
      'daily_spending_limit': dailySpendingLimit,
      'monthly_spending_limit': monthlySpendingLimit,
      'per_transaction_limit': perTransactionLimit,
      'allocation_percentage_cap': allocationPercentageCap,
      'spent_today': spentToday,
      'spent_this_month': spentThisMonth,
      'remaining_balance': remainingBalance,
      'invitation_status': invitationStatus,
      'invitation_token': invitationToken,
      'invitation_expires_at': invitationExpiresAt,
      if (cardLastFour != null) 'card_last_four': cardLastFour,
      'has_card': hasCard,
      if (joinedAt != null) 'joined_at': joinedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class FamilyTransactionProto {
  final String id;
  final String familyId;
  final String memberId;
  final String memberName;
  final String? memberAvatar;
  final String? transactionId;
  final double amount;
  final String type;
  final String? description;
  final String? merchantName;
  final String? merchantCategory;
  final Map<String, dynamic>? metadata;
  final String createdAt;

  FamilyTransactionProto({
    required this.id,
    required this.familyId,
    required this.memberId,
    required this.memberName,
    this.memberAvatar,
    this.transactionId,
    required this.amount,
    required this.type,
    this.description,
    this.merchantName,
    this.merchantCategory,
    this.metadata,
    required this.createdAt,
  });

  factory FamilyTransactionProto.fromJson(Map<String, dynamic> json) {
    return FamilyTransactionProto(
      id: json['id'] as String,
      familyId: json['family_id'] as String,
      memberId: json['member_id'] as String,
      memberName: json['member_name'] as String? ?? '',
      memberAvatar: json['member_avatar'] as String?,
      transactionId: json['transaction_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      type: json['type'] as String? ?? 'allocation',
      description: json['description'] as String?,
      merchantName: json['merchant_name'] as String?,
      merchantCategory: json['merchant_category'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      createdAt: json['created_at'] as String? ?? '',
    );
  }
}

class PendingInvitationProto {
  final String invitationToken;
  final String familyId;
  final String familyName;
  final String creatorName;
  final String? creatorAvatar;
  final double initialAllocation;
  final double dailyLimit;
  final double monthlyLimit;
  final double perTransactionLimit;
  final double allocationPercentageCap;
  final String invitedBy;
  final String? invitedEmail;
  final String? invitedPhone;
  final String role;
  final String? personalMessage;
  final String expiresAt;
  final String createdAt;

  PendingInvitationProto({
    required this.invitationToken,
    required this.familyId,
    required this.familyName,
    required this.creatorName,
    this.creatorAvatar,
    required this.initialAllocation,
    required this.dailyLimit,
    required this.monthlyLimit,
    required this.perTransactionLimit,
    required this.allocationPercentageCap,
    required this.invitedBy,
    this.invitedEmail,
    this.invitedPhone,
    required this.role,
    this.personalMessage,
    required this.expiresAt,
    required this.createdAt,
  });

  factory PendingInvitationProto.fromJson(Map<String, dynamic> json) {
    return PendingInvitationProto(
      invitationToken: json['invitation_token'] as String,
      familyId: json['family_id'] as String,
      familyName: json['family_name'] as String,
      creatorName: json['creator_name'] as String? ?? '',
      creatorAvatar: json['creator_avatar'] as String?,
      initialAllocation: (json['initial_allocation'] as num?)?.toDouble() ?? 0.0,
      dailyLimit: (json['daily_limit'] as num?)?.toDouble() ?? 0.0,
      monthlyLimit: (json['monthly_limit'] as num?)?.toDouble() ?? 0.0,
      perTransactionLimit: (json['per_transaction_limit'] as num?)?.toDouble() ?? 0.0,
      allocationPercentageCap: (json['allocation_percentage_cap'] as num?)?.toDouble() ?? 100.0,
      invitedBy: json['invited_by'] as String? ?? '',
      invitedEmail: json['invited_email'] as String?,
      invitedPhone: json['invited_phone'] as String?,
      role: json['role'] as String? ?? 'member',
      personalMessage: json['personal_message'] as String?,
      expiresAt: json['expires_at'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invitation_token': invitationToken,
      'family_id': familyId,
      'family_name': familyName,
      'creator_name': creatorName,
      if (creatorAvatar != null) 'creator_avatar': creatorAvatar,
      'initial_allocation': initialAllocation,
      'daily_limit': dailyLimit,
      'monthly_limit': monthlyLimit,
      'per_transaction_limit': perTransactionLimit,
      'allocation_percentage_cap': allocationPercentageCap,
      'invited_by': invitedBy,
      if (invitedEmail != null) 'invited_email': invitedEmail,
      if (invitedPhone != null) 'invited_phone': invitedPhone,
      'role': role,
      if (personalMessage != null) 'personal_message': personalMessage,
      'expires_at': expiresAt,
      'created_at': createdAt,
    };
  }
}

class SetupFamilyAccountRequestProto {
  final String familyId;
  final String fundDistributionMode;
  final bool spendingVisibilityEnabled;
  final List<MemberAllocationProto> allocations;

  SetupFamilyAccountRequestProto({
    required this.familyId,
    required this.fundDistributionMode,
    required this.spendingVisibilityEnabled,
    this.allocations = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'family_id': familyId,
      'fund_distribution_mode': fundDistributionMode,
      'spending_visibility_enabled': spendingVisibilityEnabled,
      'allocations': allocations.map((a) => a.toJson()).toList(),
    };
  }
}

class MemberAllocationProto {
  final String memberId;
  final double amount;

  MemberAllocationProto({
    required this.memberId,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'amount': amount,
    };
  }
}
