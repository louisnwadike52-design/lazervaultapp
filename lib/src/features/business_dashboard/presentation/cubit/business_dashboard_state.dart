import '../../domain/entities/business_summary_entity.dart';

sealed class BusinessDashboardState {}

class BusinessDashboardInitial extends BusinessDashboardState {}

class BusinessDashboardLoading extends BusinessDashboardState {}

class BusinessDashboardLoaded extends BusinessDashboardState {
  final BusinessSummaryEntity summary;
  final List<RecentBusinessTransaction> recentTransactions;
  final String selectedPeriod;
  final bool isStale;

  BusinessDashboardLoaded({
    required this.summary,
    required this.recentTransactions,
    required this.selectedPeriod,
    this.isStale = false,
  });

  BusinessDashboardLoaded copyWith({
    BusinessSummaryEntity? summary,
    List<RecentBusinessTransaction>? recentTransactions,
    String? selectedPeriod,
    bool? isStale,
  }) {
    return BusinessDashboardLoaded(
      summary: summary ?? this.summary,
      recentTransactions: recentTransactions ?? this.recentTransactions,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      isStale: isStale ?? this.isStale,
    );
  }
}

class BusinessDashboardError extends BusinessDashboardState {
  final String message;
  BusinessDashboardError({required this.message});
}
