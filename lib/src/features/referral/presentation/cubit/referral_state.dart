import 'package:equatable/equatable.dart';
import '../../domain/entities/referral_code_entity.dart';
import '../../domain/entities/referral_stats_entity.dart';
import '../../domain/entities/leaderboard_entry_entity.dart';
import '../../domain/entities/referral_transaction_entity.dart';
import '../../domain/entities/points_balance_entity.dart';
import '../../domain/entities/point_transaction_entity.dart';
import '../../domain/entities/points_config_entity.dart';

/// Base class for all referral states
abstract class ReferralState extends Equatable {
  const ReferralState();

  @override
  List<Object?> get props => [];
}

/// Initial state when referral feature is first loaded
class ReferralInitial extends ReferralState {
  const ReferralInitial();
}

/// Loading state while fetching data
class ReferralLoading extends ReferralState {
  final String? loadingMessage;

  const ReferralLoading({this.loadingMessage});

  @override
  List<Object?> get props => [loadingMessage];
}

/// Loaded state with all referral dashboard data
class ReferralLoaded extends ReferralState {
  final ReferralCodeEntity myCode;
  final ReferralStatsEntity stats;
  final List<LeaderboardEntryEntity> leaderboard;
  final List<ReferralTransactionEntity> recentReferrals;

  const ReferralLoaded({
    required this.myCode,
    required this.stats,
    required this.leaderboard,
    required this.recentReferrals,
  });

  ReferralLoaded copyWith({
    ReferralCodeEntity? myCode,
    ReferralStatsEntity? stats,
    List<LeaderboardEntryEntity>? leaderboard,
    List<ReferralTransactionEntity>? recentReferrals,
  }) {
    return ReferralLoaded(
      myCode: myCode ?? this.myCode,
      stats: stats ?? this.stats,
      leaderboard: leaderboard ?? this.leaderboard,
      recentReferrals: recentReferrals ?? this.recentReferrals,
    );
  }

  @override
  List<Object?> get props => [myCode, stats, leaderboard, recentReferrals];
}

/// Error state
class ReferralError extends ReferralState {
  final String message;

  const ReferralError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Code copied to clipboard (temporary state)
class ReferralCodeCopied extends ReferralState {
  const ReferralCodeCopied();
}

/// Validating referral code (during signup)
class ReferralValidating extends ReferralState {
  const ReferralValidating();
}

/// Referral code validation result
class ReferralValidated extends ReferralState {
  final bool isValid;
  final String message;

  const ReferralValidated({
    required this.isValid,
    required this.message,
  });

  @override
  List<Object?> get props => [isValid, message];
}

/// LazerPoints balance loaded
class PointsBalanceLoaded extends ReferralState {
  final PointsBalanceEntity balance;

  const PointsBalanceLoaded({required this.balance});

  @override
  List<Object?> get props => [balance];
}

/// LazerPoints history loaded
class PointsHistoryLoaded extends ReferralState {
  final List<PointTransactionEntity> transactions;
  final int currentPage;
  final bool hasMore;

  const PointsHistoryLoaded({
    required this.transactions,
    this.currentPage = 1,
    this.hasMore = true,
  });

  PointsHistoryLoaded copyWith({
    List<PointTransactionEntity>? transactions,
    int? currentPage,
    bool? hasMore,
  }) {
    return PointsHistoryLoaded(
      transactions: transactions ?? this.transactions,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [transactions, currentPage, hasMore];
}

/// LazerPoints config loaded (earn rules)
class PointsConfigLoaded extends ReferralState {
  final List<PointsConfigEntity> configs;

  const PointsConfigLoaded({required this.configs});

  @override
  List<Object?> get props => [configs];
}

/// All referrals list loaded (for All Referrals screen)
class AllReferralsLoaded extends ReferralState {
  final List<ReferralTransactionEntity> referrals;
  final String filter;
  final int currentPage;
  final bool hasMore;

  const AllReferralsLoaded({
    required this.referrals,
    this.filter = '',
    this.currentPage = 1,
    this.hasMore = true,
  });

  AllReferralsLoaded copyWith({
    List<ReferralTransactionEntity>? referrals,
    String? filter,
    int? currentPage,
    bool? hasMore,
  }) {
    return AllReferralsLoaded(
      referrals: referrals ?? this.referrals,
      filter: filter ?? this.filter,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [referrals, filter, currentPage, hasMore];
}
