import 'package:equatable/equatable.dart';
import '../../domain/entities/social_account_entity.dart';

/// Error type classification for UI handling
enum SocialLinkingErrorType {
  /// Network connectivity issues
  network,

  /// Service unavailable
  serviceUnavailable,

  /// Account already linked (to this or another user)
  accountAlreadyLinked,

  /// OAuth flow cancelled by user
  cancelled,

  /// OAuth flow failed (invalid token, etc.)
  oauthFailed,

  /// Cannot unlink primary account
  cannotUnlinkPrimary,

  /// Session expired
  unauthorized,

  /// General error
  general,
}

/// Base state for social linking
sealed class SocialLinkingState extends Equatable {
  const SocialLinkingState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class SocialLinkingInitial extends SocialLinkingState {}

/// Loading state
class SocialLinkingLoading extends SocialLinkingState {
  final String? operation;

  const SocialLinkingLoading({this.operation});

  @override
  List<Object?> get props => [operation];
}

/// Linked accounts loaded state
class LinkedSocialAccountsLoaded extends SocialLinkingState {
  final List<LinkedSocialAccountEntity> accounts;
  final LinkedSocialAccountEntity? primaryAccount;
  final SocialAccountStats stats;
  final bool isStale;

  const LinkedSocialAccountsLoaded({
    required this.accounts,
    this.primaryAccount,
    required this.stats,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [accounts, primaryAccount, stats, isStale];
}

/// OAuth flow initiated - UI should launch OAuth
class OAuthFlowInitiated extends SocialLinkingState {
  final SocialProvider provider;
  final String? authUrl;

  const OAuthFlowInitiated({
    required this.provider,
    this.authUrl,
  });

  @override
  List<Object?> get props => [provider, authUrl];
}

/// Account linking in progress
class AccountLinkingInProgress extends SocialLinkingState {
  final SocialProvider provider;

  const AccountLinkingInProgress({required this.provider});

  @override
  List<Object?> get props => [provider];
}

/// Account successfully linked
class SocialAccountLinked extends SocialLinkingState {
  final LinkedSocialAccountEntity account;
  final bool isNewAccount;

  const SocialAccountLinked({
    required this.account,
    required this.isNewAccount,
  });

  @override
  List<Object?> get props => [account, isNewAccount];
}

/// Account unlinked
class SocialAccountUnlinked extends SocialLinkingState {
  final String accountId;
  final SocialProvider provider;

  const SocialAccountUnlinked({
    required this.accountId,
    required this.provider,
  });

  @override
  List<Object?> get props => [accountId, provider];
}

/// Primary account set
class PrimarySocialAccountSet extends SocialLinkingState {
  final LinkedSocialAccountEntity account;

  const PrimarySocialAccountSet({required this.account});

  @override
  List<Object?> get props => [account];
}

/// Account reauthorized
class SocialAccountReauthorized extends SocialLinkingState {
  final LinkedSocialAccountEntity account;

  const SocialAccountReauthorized({required this.account});

  @override
  List<Object?> get props => [account];
}

/// Stats loaded (for AI chat integration)
class SocialAccountStatsLoaded extends SocialLinkingState {
  final SocialAccountStats stats;

  const SocialAccountStatsLoaded({required this.stats});

  @override
  List<Object?> get props => [stats];
}

/// Error state with detailed error information
class SocialLinkingError extends SocialLinkingState {
  final String message;
  final String? errorCode;
  final SocialLinkingErrorType errorType;
  final bool isRetryable;
  final String? operation;
  final SocialProvider? provider;

  const SocialLinkingError({
    required this.message,
    this.errorCode,
    this.errorType = SocialLinkingErrorType.general,
    this.isRetryable = false,
    this.operation,
    this.provider,
  });

  @override
  List<Object?> get props => [
        message,
        errorCode,
        errorType,
        isRetryable,
        operation,
        provider,
      ];
}

/// Offline state
class SocialLinkingOffline extends SocialLinkingState {
  final String? lastOperation;

  const SocialLinkingOffline({this.lastOperation});

  @override
  List<Object?> get props => [lastOperation];
}
