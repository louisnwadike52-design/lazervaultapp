import 'package:bloc/bloc.dart';
import '../../data/services/business_overview_service.dart';
import '../../domain/entities/business_overview_entity.dart';

sealed class BusinessDashboardState {
  const BusinessDashboardState();
}

class BusinessDashboardInitial extends BusinessDashboardState {
  const BusinessDashboardInitial();
}

class BusinessDashboardLoading extends BusinessDashboardState {
  const BusinessDashboardLoading();
}

class BusinessDashboardLoaded extends BusinessDashboardState {
  final BusinessOverviewEntity overview;
  const BusinessDashboardLoaded(this.overview);
}

class BusinessDashboardError extends BusinessDashboardState {
  final String message;
  const BusinessDashboardError(this.message);
}

class BusinessDashboardCubit extends Cubit<BusinessDashboardState> {
  final BusinessOverviewService service;

  BusinessDashboardCubit({required this.service})
      : super(const BusinessDashboardInitial());

  Future<void> load({String? periodStart, String? periodEnd}) async {
    emit(const BusinessDashboardLoading());
    try {
      final overview = await service.getOverview(
        periodStart: periodStart,
        periodEnd: periodEnd,
      );
      emit(BusinessDashboardLoaded(overview));
    } catch (e) {
      emit(BusinessDashboardError(e.toString()));
    }
  }
}
