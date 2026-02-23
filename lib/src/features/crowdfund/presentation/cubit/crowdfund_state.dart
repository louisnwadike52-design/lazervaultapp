import 'package:equatable/equatable.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/entities/notification_channel_entities.dart';

/// Base state for crowdfund feature
abstract class CrowdfundState extends Equatable {
  const CrowdfundState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CrowdfundInitial extends CrowdfundState {
  const CrowdfundInitial();
}

/// Loading state with optional message
class CrowdfundLoading extends CrowdfundState {
  final String? message;

  const CrowdfundLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// Crowdfunds list loaded successfully
class CrowdfundLoaded extends CrowdfundState {
  final List<Crowdfund> crowdfunds;
  final int totalCount;
  final int currentPage;
  final bool isStale;
  final bool hasMore;
  final bool isLoadingMore;

  const CrowdfundLoaded({
    required this.crowdfunds,
    this.totalCount = 0,
    this.currentPage = 1,
    this.isStale = false,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  CrowdfundLoaded copyWith({
    List<Crowdfund>? crowdfunds,
    int? totalCount,
    int? currentPage,
    bool? isStale,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return CrowdfundLoaded(
      crowdfunds: crowdfunds ?? this.crowdfunds,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      isStale: isStale ?? this.isStale,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [crowdfunds, totalCount, currentPage, isStale, hasMore, isLoadingMore];
}

/// Single crowdfund details loaded with donations
class CrowdfundDetailsLoaded extends CrowdfundState {
  final Crowdfund crowdfund;
  final List<CrowdfundDonation> donations;
  final CrowdfundStatistics? statistics;
  final bool isStale;

  const CrowdfundDetailsLoaded({
    required this.crowdfund,
    required this.donations,
    this.statistics,
    this.isStale = false,
  });

  @override
  List<Object?> get props => [crowdfund, donations, statistics, isStale];
}

/// Crowdfund created successfully
class CrowdfundCreated extends CrowdfundState {
  final Crowdfund crowdfund;

  const CrowdfundCreated(this.crowdfund);

  @override
  List<Object?> get props => [crowdfund];
}

/// Crowdfund updated successfully
class CrowdfundUpdated extends CrowdfundState {
  final Crowdfund crowdfund;

  const CrowdfundUpdated(this.crowdfund);

  @override
  List<Object?> get props => [crowdfund];
}

/// Donation processing state with step indicator
class DonationProcessing extends CrowdfundState {
  final String step;
  final int currentStepIndex;
  final int totalSteps;

  const DonationProcessing({
    required this.step,
    this.currentStepIndex = 0,
    this.totalSteps = 4,
  });

  @override
  List<Object?> get props => [step, currentStepIndex, totalSteps];
}

/// Donation completed successfully
class DonationCompleted extends CrowdfundState {
  final CrowdfundDonation donation;
  final CrowdfundReceipt? receipt;

  const DonationCompleted({
    required this.donation,
    this.receipt,
  });

  @override
  List<Object?> get props => [donation, receipt];
}

/// Receipt generated successfully
class ReceiptGenerated extends CrowdfundState {
  final CrowdfundReceipt receipt;

  const ReceiptGenerated(this.receipt);

  @override
  List<Object?> get props => [receipt];
}

/// User's receipts loaded
class UserReceiptsLoaded extends CrowdfundState {
  final List<CrowdfundReceipt> receipts;
  final int totalCount;
  final int currentPage;

  const UserReceiptsLoaded({
    required this.receipts,
    this.totalCount = 0,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [receipts, totalCount, currentPage];
}

/// User's donations loaded
class UserDonationsLoaded extends CrowdfundState {
  final List<CrowdfundDonation> donations;
  final int totalCount;
  final int currentPage;

  const UserDonationsLoaded({
    required this.donations,
    this.totalCount = 0,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [donations, totalCount, currentPage];
}

/// Statistics loaded
class StatisticsLoaded extends CrowdfundState {
  final CrowdfundStatistics statistics;

  const StatisticsLoaded(this.statistics);

  @override
  List<Object?> get props => [statistics];
}

/// Error state
class CrowdfundError extends CrowdfundState {
  final String message;
  final String? errorCode;

  const CrowdfundError({
    required this.message,
    this.errorCode,
  });

  @override
  List<Object?> get props => [message, errorCode];
}

// ============================================================================
// REPORT STATES
// ============================================================================

/// Report is being generated
class CrowdfundReportLoading extends CrowdfundState {
  final String? message;

  const CrowdfundReportLoading({this.message});

  @override
  List<Object?> get props => [message];
}

/// Report generated successfully
class CrowdfundReportGenerated extends CrowdfundState {
  final CrowdfundReport report;
  final Crowdfund crowdfund;
  final String? campaignUrl;

  const CrowdfundReportGenerated({
    required this.report,
    required this.crowdfund,
    this.campaignUrl,
  });

  @override
  List<Object?> get props => [report, crowdfund, campaignUrl];
}

/// Report shared successfully
class CrowdfundReportShared extends CrowdfundState {
  final String platform;
  final String? message;

  const CrowdfundReportShared({
    required this.platform,
    this.message,
  });

  @override
  List<Object?> get props => [platform, message];
}

/// Report share failed
class CrowdfundReportShareError extends CrowdfundState {
  final String message;
  final String platform;

  const CrowdfundReportShareError({
    required this.message,
    required this.platform,
  });

  @override
  List<Object?> get props => [message, platform];
}

// ============================================================================
// CAMPAIGN WALLET STATES
// ============================================================================

/// User's own crowdfunds loaded
class MyCrowdfundsLoaded extends CrowdfundState {
  final List<Crowdfund> crowdfunds;

  const MyCrowdfundsLoaded(this.crowdfunds);

  @override
  List<Object?> get props => [crowdfunds];
}

/// Withdrawal completed
class WithdrawalCompleted extends CrowdfundState {
  final CrowdfundWithdrawalResult result;

  const WithdrawalCompleted(this.result);

  @override
  List<Object?> get props => [result];
}

/// Campaign wallet balance loaded
class CampaignWalletBalanceLoaded extends CrowdfundState {
  final CampaignWalletBalance balance;

  const CampaignWalletBalanceLoaded(this.balance);

  @override
  List<Object?> get props => [balance];
}

// ============================================================================
// NOTIFICATION CHANNEL STATES
// ============================================================================

/// Notification channels loaded
class NotificationChannelsLoaded extends CrowdfundState {
  final List<NotificationChannel> channels;

  const NotificationChannelsLoaded(this.channels);

  @override
  List<Object?> get props => [channels];
}

/// Notification channel connected
class NotificationChannelConnected extends CrowdfundState {
  final NotificationChannel channel;

  const NotificationChannelConnected(this.channel);

  @override
  List<Object?> get props => [channel];
}

/// Notification channel disconnected
class NotificationChannelDisconnected extends CrowdfundState {
  final String channelId;

  const NotificationChannelDisconnected(this.channelId);

  @override
  List<Object?> get props => [channelId];
}

/// Notification channel updated
class NotificationChannelUpdated extends CrowdfundState {
  final NotificationChannel channel;

  const NotificationChannelUpdated(this.channel);

  @override
  List<Object?> get props => [channel];
}

/// Notification channel test result
class NotificationChannelTested extends CrowdfundState {
  final bool success;
  final String channelId;

  const NotificationChannelTested({
    required this.success,
    required this.channelId,
  });

  @override
  List<Object?> get props => [success, channelId];
}

