import 'package:equatable/equatable.dart';
import '../../../generated/accounts.pb.dart' as accounts_pb;

/// Which money sources the budgeting/statistics content reflects.
/// - [lazervault]: internal LazerVault wallet only.
/// - [bank]: linked external bank accounts only (Mono).
/// - [both]: LazerVault wallet + linked banks combined.
enum StatisticsSource { lazervault, bank, both }

/// Honesty signal for the external-bank leg of the analytics. The UI uses
/// this to NEVER render fabricated metrics: it shows loading / retry / empty
/// states instead of zeros when bank data could not be fetched from Mono.
enum ExternalDataStatus {
  /// Wallet-only source — external not in scope.
  notApplicable,

  /// External data loaded successfully and has activity.
  ready,

  /// External fetched fine but the selected scope has no synced transactions
  /// in this window (genuine empty, not an error).
  empty,

  /// External could not be synced/fetched from Mono (provider error, sync
  /// failure). Numbers that depend on it must NOT be shown as real.
  unavailable,
}

extension StatisticsSourceX on StatisticsSource {
  /// Human label shown in the filter bottom sheet / header chip.
  String get label {
    switch (this) {
      case StatisticsSource.lazervault:
        return 'Lazervault';
      case StatisticsSource.bank:
        return 'Bank';
      case StatisticsSource.both:
        return 'Lazervault & Bank';
    }
  }

  /// Whether external (bank) transactions are part of this source.
  bool get includesExternal => this != StatisticsSource.lazervault;
}

/// Base class for all statistics states
abstract class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object?> get props => [];
}

/// Initial state when statistics feature is first loaded
class StatisticsInitial extends StatisticsState {}

/// Loading state while fetching data
class StatisticsLoading extends StatisticsState {
  final String? loadingMessage;

  const StatisticsLoading({this.loadingMessage});

  @override
  List<Object?> get props => [loadingMessage];
}

/// Loaded state with all statistics data
class StatisticsLoaded extends StatisticsState {
  final DateTime startDate;
  final DateTime endDate;

  // Financial Analytics (from accounts-service)
  final accounts_pb.GetFinancialAnalyticsResponse? financialAnalytics;
  final accounts_pb.GetCategoryAnalyticsResponse? categoryAnalytics;
  final accounts_pb.GetMonthlyTrendsResponse? monthlyTrends;
  final accounts_pb.GetExpenseTimeSeriesResponse? expenseTimeSeries;
  final accounts_pb.GetTransactionHistoryResponse? failedTransactions;
  final String currentPeriod;
  final bool includeExternalBanks;
  // Selected money source the content reflects (drives the filter chip + sheet).
  final StatisticsSource source;
  // When external banks are in scope: null/empty = ALL linked banks
  // (default), otherwise the one linked-account id the numbers reflect.
  final String? selectedBankAccountId;
  // Honesty signal for the external leg (see ExternalDataStatus).
  final ExternalDataStatus externalStatus;
  // Human-readable reason when externalStatus == unavailable.
  final String? externalError;
  // True while a source/bank/period change is reloading on top of already-
  // loaded data. The screen keeps the header + tabs mounted and swaps ONLY
  // the content region to the shimmer skeleton while this is true, instead of
  // tearing the whole screen down to a StatisticsLoading state.
  final bool isRefreshing;

  const StatisticsLoaded({
    required this.startDate,
    required this.endDate,
    this.financialAnalytics,
    this.categoryAnalytics,
    this.monthlyTrends,
    this.expenseTimeSeries,
    this.failedTransactions,
    this.currentPeriod = 'month',
    this.includeExternalBanks = true,
    this.source = StatisticsSource.both,
    this.selectedBankAccountId,
    this.externalStatus = ExternalDataStatus.notApplicable,
    this.externalError,
    this.isRefreshing = false,
  });

  @override
  List<Object?> get props => [
        startDate,
        endDate,
        financialAnalytics,
        categoryAnalytics,
        monthlyTrends,
        expenseTimeSeries,
        failedTransactions,
        currentPeriod,
        includeExternalBanks,
        source,
        selectedBankAccountId,
        externalStatus,
        externalError,
        isRefreshing,
      ];

  /// Create a copy with updated fields
  StatisticsLoaded copyWith({
    DateTime? startDate,
    DateTime? endDate,
    accounts_pb.GetFinancialAnalyticsResponse? financialAnalytics,
    accounts_pb.GetCategoryAnalyticsResponse? categoryAnalytics,
    accounts_pb.GetMonthlyTrendsResponse? monthlyTrends,
    accounts_pb.GetExpenseTimeSeriesResponse? expenseTimeSeries,
    accounts_pb.GetTransactionHistoryResponse? failedTransactions,
    String? currentPeriod,
    bool? includeExternalBanks,
    StatisticsSource? source,
    String? selectedBankAccountId,
    ExternalDataStatus? externalStatus,
    String? externalError,
    bool? isRefreshing,
  }) {
    return StatisticsLoaded(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      financialAnalytics: financialAnalytics ?? this.financialAnalytics,
      categoryAnalytics: categoryAnalytics ?? this.categoryAnalytics,
      monthlyTrends: monthlyTrends ?? this.monthlyTrends,
      expenseTimeSeries: expenseTimeSeries ?? this.expenseTimeSeries,
      failedTransactions: failedTransactions ?? this.failedTransactions,
      currentPeriod: currentPeriod ?? this.currentPeriod,
      includeExternalBanks: includeExternalBanks ?? this.includeExternalBanks,
      source: source ?? this.source,
      selectedBankAccountId: selectedBankAccountId ?? this.selectedBankAccountId,
      externalStatus: externalStatus ?? this.externalStatus,
      externalError: externalError ?? this.externalError,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

/// Error state with detailed error message
class StatisticsError extends StatisticsState {
  final String message;
  final String? errorCode;
  final StackTrace? stackTrace;

  const StatisticsError({
    required this.message,
    this.errorCode,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, errorCode, stackTrace];
}
