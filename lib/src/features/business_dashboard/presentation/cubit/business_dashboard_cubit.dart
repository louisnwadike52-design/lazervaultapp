import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/business_dashboard_repository.dart';
import 'business_dashboard_state.dart';

class BusinessDashboardCubit extends Cubit<BusinessDashboardState> {
  final BusinessDashboardRepository repository;
  String? _accountId;

  BusinessDashboardCubit({required this.repository})
      : super(BusinessDashboardInitial());

  void setAccountId(String accountId) {
    _accountId = accountId;
  }

  Future<void> loadDashboard({String period = 'month'}) async {
    if (_accountId == null) {
      emit(BusinessDashboardError(message: 'No business account selected'));
      return;
    }

    emit(BusinessDashboardLoading());

    try {
      final results = await Future.wait([
        repository.getBusinessSummary(
          accountId: _accountId!,
          period: period,
        ),
        repository.getRecentTransactions(accountId: _accountId!),
      ]);

      emit(BusinessDashboardLoaded(
        summary: results[0] as dynamic,
        recentTransactions: results[1] as dynamic,
        selectedPeriod: period,
      ));
    } catch (e) {
      emit(BusinessDashboardError(message: e.toString()));
    }
  }

  Future<void> changePeriod(String period) async {
    final currentState = state;
    if (currentState is BusinessDashboardLoaded) {
      emit(currentState.copyWith(selectedPeriod: period, isStale: true));
    }
    await loadDashboard(period: period);
  }

  Future<void> refresh() async {
    final currentState = state;
    final period =
        currentState is BusinessDashboardLoaded ? currentState.selectedPeriod : 'month';
    await loadDashboard(period: period);
  }
}
