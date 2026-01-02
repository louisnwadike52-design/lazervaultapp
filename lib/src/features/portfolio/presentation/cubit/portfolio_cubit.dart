import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/portfolio_repository.dart';
import 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioRepository repository;

  PortfolioCubit({required this.repository}) : super(const PortfolioInitial());

  /// Load complete portfolio with all assets
  Future<void> loadPortfolio() async {
    try {
      if (isClosed) return;
      emit(const PortfolioLoading());
      final portfolio = await repository.getCompletePortfolio();
      if (isClosed) return;
      emit(PortfolioLoaded(portfolio: portfolio));
    } catch (e) {
      if (isClosed) return;
      emit(PortfolioError(message: e.toString()));
    }
  }

  /// Refresh portfolio (keeps current data visible while loading)
  Future<void> refreshPortfolio() async {
    try {
      final currentState = state;
      if (currentState is PortfolioLoaded) {
        if (isClosed) return;
        emit(PortfolioRefreshing(currentPortfolio: currentState.portfolio));
      }

      final portfolio = await repository.getCompletePortfolio();
      if (isClosed) return;
      emit(PortfolioLoaded(portfolio: portfolio));
    } catch (e) {
      if (isClosed) return;
      emit(PortfolioError(message: e.toString()));
    }
  }

  /// Load portfolio summary only
  Future<void> loadSummary() async {
    try {
      if (isClosed) return;
      emit(const PortfolioLoading());
      final summary = await repository.getPortfolioSummary();
      if (isClosed) return;
      emit(PortfolioSummaryLoaded(summary: summary));
    } catch (e) {
      if (isClosed) return;
      emit(PortfolioError(message: e.toString()));
    }
  }

  /// Load assets filtered by type
  Future<void> loadAssetsByType(String assetType) async {
    try {
      if (isClosed) return;
      emit(const PortfolioLoading());
      final assets = await repository.getPortfolioByAssetType(assetType);
      if (isClosed) return;
      emit(PortfolioAssetsByTypeLoaded(
        assets: assets,
        assetType: assetType,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(PortfolioError(message: e.toString()));
    }
  }

  /// Load portfolio history for a specific period
  Future<void> loadHistory(String period) async {
    try {
      if (isClosed) return;
      emit(const PortfolioLoading());
      final history = await repository.getPortfolioHistory(period);
      if (isClosed) return;
      emit(PortfolioHistoryLoaded(history: history, period: period));
    } catch (e) {
      if (isClosed) return;
      emit(PortfolioError(message: e.toString()));
    }
  }

  /// Reset to initial state
  void reset() {
    if (isClosed) return;
    emit(const PortfolioInitial());
  }
}
