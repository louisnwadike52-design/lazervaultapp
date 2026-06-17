import 'package:equatable/equatable.dart';

/// Supported social providers
enum SocialProvider {
  google,
  facebook,
  apple,
  x,
  linkedin,
  instagram;

  static SocialProvider fromString(String provider) {
    switch (provider.toLowerCase()) {
      case 'google':
        return SocialProvider.google;
      case 'facebook':
        return SocialProvider.facebook;
      case 'apple':
        return SocialProvider.apple;
      case 'x':
      case 'twitter':
        return SocialProvider.x;
      case 'linkedin':
        return SocialProvider.linkedin;
      case 'instagram':
        return SocialProvider.instagram;
      default:
        return SocialProvider.google;
    }
  }

  String get displayName {
    switch (this) {
      case SocialProvider.google:
        return 'Google';
      case SocialProvider.facebook:
        return 'Facebook';
      case SocialProvider.apple:
        return 'Apple';
      case SocialProvider.x:
        return 'X (Twitter)';
      case SocialProvider.linkedin:
        return 'LinkedIn';
      case SocialProvider.instagram:
        return 'Instagram';
    }
  }

  String get iconAsset {
    switch (this) {
      case SocialProvider.google:
        return 'assets/icons/google.png';
      case SocialProvider.facebook:
        return 'assets/icons/facebook.png';
      case SocialProvider.apple:
        return 'assets/icons/apple.png';
      case SocialProvider.x:
        return 'assets/icons/x_twitter.png';
      case SocialProvider.linkedin:
        return 'assets/icons/linkedin.png';
      case SocialProvider.instagram:
        return 'assets/icons/instagram.png';
    }
  }

  /// Get brand color for the provider
  int get brandColorValue {
    switch (this) {
      case SocialProvider.google:
        return 0xFFDB4437;
      case SocialProvider.facebook:
        return 0xFF1877F2;
      case SocialProvider.apple:
        return 0xFF000000;
      case SocialProvider.x:
        return 0xFF000000;
      case SocialProvider.linkedin:
        return 0xFF0A66C2;
      case SocialProvider.instagram:
        return 0xFFE4405F;
    }
  }
}

/// Status of a linked social account
enum SocialAccountStatus {
  active,
  inactive,
  needsReauth,
  unlinked;

  static SocialAccountStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return SocialAccountStatus.active;
      case 'inactive':
        return SocialAccountStatus.inactive;
      case 'needs_reauth':
      case 'needsreauth':
        return SocialAccountStatus.needsReauth;
      case 'unlinked':
        return SocialAccountStatus.unlinked;
      default:
        return SocialAccountStatus.inactive;
    }
  }

  String get displayName {
    switch (this) {
      case SocialAccountStatus.active:
        return 'Connected';
      case SocialAccountStatus.inactive:
        return 'Inactive';
      case SocialAccountStatus.needsReauth:
        return 'Needs Reconnection';
      case SocialAccountStatus.unlinked:
        return 'Disconnected';
    }
  }
}

/// Represents a linked social media account
class LinkedSocialAccountEntity extends Equatable {
  final String id;
  final String userId;
  final SocialProvider provider;
  final String providerUserId;
  final String? providerEmail;
  final String? displayName;
  final String? profilePictureUrl;
  final String? profileUrl;
  final SocialAccountStatus status;
  final bool isPrimary;
  final DateTime linkedAt;
  final DateTime? lastUsedAt;

  const LinkedSocialAccountEntity({
    required this.id,
    required this.userId,
    required this.provider,
    required this.providerUserId,
    this.providerEmail,
    this.displayName,
    this.profilePictureUrl,
    this.profileUrl,
    required this.status,
    required this.isPrimary,
    required this.linkedAt,
    this.lastUsedAt,
  });

  /// Check if the account is active
  bool get isActive => status == SocialAccountStatus.active;

  /// Check if the account needs reauthorization
  bool get needsReauthorization => status == SocialAccountStatus.needsReauth;

  /// Get display name for the account (fallback to email or provider name)
  String get displayTitle {
    if (displayName != null && displayName!.isNotEmpty) {
      return displayName!;
    }
    if (providerEmail != null && providerEmail!.isNotEmpty) {
      return providerEmail!;
    }
    return provider.displayName;
  }

  /// Get subtitle for the account (typically email or provider ID)
  String get displaySubtitle {
    if (providerEmail != null && providerEmail!.isNotEmpty) {
      return providerEmail!;
    }
    return '@${provider.name}';
  }

  factory LinkedSocialAccountEntity.fromJson(Map<String, dynamic> json) {
    return LinkedSocialAccountEntity(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      provider: SocialProvider.fromString(json['provider'] as String),
      providerUserId: json['provider_user_id'] as String,
      providerEmail: json['provider_email'] as String?,
      displayName: json['display_name'] as String?,
      profilePictureUrl: json['profile_picture_url'] as String?,
      profileUrl: json['profile_url'] as String?,
      status: SocialAccountStatus.fromString(json['status'] as String? ?? 'active'),
      isPrimary: json['is_primary'] as bool? ?? false,
      linkedAt: json['linked_at'] != null
          ? DateTime.parse(json['linked_at'] as String)
          : DateTime.now(),
      lastUsedAt: json['last_used_at'] != null
          ? DateTime.parse(json['last_used_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'provider': provider.name,
      'provider_user_id': providerUserId,
      'provider_email': providerEmail,
      'display_name': displayName,
      'profile_picture_url': profilePictureUrl,
      'profile_url': profileUrl,
      'status': status.name,
      'is_primary': isPrimary,
      'linked_at': linkedAt.toIso8601String(),
      'last_used_at': lastUsedAt?.toIso8601String(),
    };
  }

  LinkedSocialAccountEntity copyWith({
    String? id,
    String? userId,
    SocialProvider? provider,
    String? providerUserId,
    String? providerEmail,
    String? displayName,
    String? profilePictureUrl,
    String? profileUrl,
    SocialAccountStatus? status,
    bool? isPrimary,
    DateTime? linkedAt,
    DateTime? lastUsedAt,
  }) {
    return LinkedSocialAccountEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      provider: provider ?? this.provider,
      providerUserId: providerUserId ?? this.providerUserId,
      providerEmail: providerEmail ?? this.providerEmail,
      displayName: displayName ?? this.displayName,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      profileUrl: profileUrl ?? this.profileUrl,
      status: status ?? this.status,
      isPrimary: isPrimary ?? this.isPrimary,
      linkedAt: linkedAt ?? this.linkedAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        provider,
        providerUserId,
        providerEmail,
        displayName,
        profilePictureUrl,
        profileUrl,
        status,
        isPrimary,
        linkedAt,
        lastUsedAt,
      ];
}

/// Statistics for social accounts - used for AI reports
class SocialAccountStats extends Equatable {
  final int totalAccounts;
  final int activeAccounts;
  final int needsReauth;
  final Map<String, int> providerBreakdown;
  final DateTime? lastLinkedAt;
  final String? primaryProvider;

  const SocialAccountStats({
    required this.totalAccounts,
    required this.activeAccounts,
    required this.needsReauth,
    required this.providerBreakdown,
    this.lastLinkedAt,
    this.primaryProvider,
  });

  factory SocialAccountStats.empty() {
    return const SocialAccountStats(
      totalAccounts: 0,
      activeAccounts: 0,
      needsReauth: 0,
      providerBreakdown: {},
      lastLinkedAt: null,
      primaryProvider: null,
    );
  }

  factory SocialAccountStats.fromAccounts(List<LinkedSocialAccountEntity> accounts) {
    final providerBreakdown = <String, int>{};
    int active = 0;
    int reauth = 0;
    DateTime? lastLinked;
    String? primary;

    for (final account in accounts) {
      providerBreakdown[account.provider.name] =
          (providerBreakdown[account.provider.name] ?? 0) + 1;

      if (account.isActive) active++;
      if (account.needsReauthorization) reauth++;
      if (account.isPrimary) primary = account.provider.name;

      if (lastLinked == null || account.linkedAt.isAfter(lastLinked)) {
        lastLinked = account.linkedAt;
      }
    }

    return SocialAccountStats(
      totalAccounts: accounts.length,
      activeAccounts: active,
      needsReauth: reauth,
      providerBreakdown: providerBreakdown,
      lastLinkedAt: lastLinked,
      primaryProvider: primary,
    );
  }

  factory SocialAccountStats.fromJson(Map<String, dynamic> json) {
    return SocialAccountStats(
      totalAccounts: json['total_accounts'] as int? ?? 0,
      activeAccounts: json['active_accounts'] as int? ?? 0,
      needsReauth: json['needs_reauth'] as int? ?? 0,
      providerBreakdown: (json['provider_breakdown'] as Map<String, dynamic>?)
              ?.map((k, v) => MapEntry(k, v as int)) ??
          {},
      lastLinkedAt: json['last_linked_at'] != null
          ? DateTime.parse(json['last_linked_at'] as String)
          : null,
      primaryProvider: json['primary_provider'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_accounts': totalAccounts,
      'active_accounts': activeAccounts,
      'needs_reauth': needsReauth,
      'provider_breakdown': providerBreakdown,
      'last_linked_at': lastLinkedAt?.toIso8601String(),
      'primary_provider': primaryProvider,
    };
  }

  /// Generate a summary for AI chat agents
  String toAISummary() {
    if (totalAccounts == 0) {
      return 'User has no linked social accounts.';
    }

    final buffer = StringBuffer();
    buffer.writeln('Social Account Summary:');
    buffer.writeln('- Total linked accounts: $totalAccounts');
    buffer.writeln('- Active accounts: $activeAccounts');

    if (needsReauth > 0) {
      buffer.writeln('- Accounts needing reconnection: $needsReauth');
    }

    if (providerBreakdown.isNotEmpty) {
      buffer.writeln('- Connected platforms:');
      providerBreakdown.forEach((provider, count) {
        final providerEnum = SocialProvider.fromString(provider);
        buffer.writeln('  - ${providerEnum.displayName}: $count');
      });
    }

    if (primaryProvider != null) {
      final primaryEnum = SocialProvider.fromString(primaryProvider!);
      buffer.writeln('- Primary login: ${primaryEnum.displayName}');
    }

    if (lastLinkedAt != null) {
      buffer.writeln('- Last account linked: ${lastLinkedAt!.toIso8601String().split('T')[0]}');
    }

    return buffer.toString();
  }

  @override
  List<Object?> get props => [
        totalAccounts,
        activeAccounts,
        needsReauth,
        providerBreakdown,
        lastLinkedAt,
        primaryProvider,
      ];
}
