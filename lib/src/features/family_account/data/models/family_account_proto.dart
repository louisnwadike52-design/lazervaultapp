// Proto message definitions for Family Accounts
// These correspond to the backend proto definitions
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart'
    show FamilyAccountSummary;
part 'family_account_proto_widgets.dart';


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
