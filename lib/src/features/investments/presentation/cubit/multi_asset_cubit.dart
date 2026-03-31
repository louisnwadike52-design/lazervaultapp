import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/multi_asset_data_source.dart';
import '../../data/models/investment_models.dart';

sealed class MultiAssetState {}

class MultiAssetInitial extends MultiAssetState {}

class MultiAssetLoading extends MultiAssetState {}

class AssetCatalogLoaded extends MultiAssetState {
  final List<AssetCatalogItem> assets;
  final String? activeFilter;
  AssetCatalogLoaded({required this.assets, this.activeFilter});
}

class AssetCategoriesLoaded extends MultiAssetState {
  final List<AssetCategory> categories;
  AssetCategoriesLoaded({required this.categories});
}

class FXRateLoaded extends MultiAssetState {
  final FXRate rate;
  FXRateLoaded({required this.rate});
}

class FXQuoteLoaded extends MultiAssetState {
  final FXConversionResult result;
  FXQuoteLoaded({required this.result});
}

class CommissionRatesLoaded extends MultiAssetState {
  final List<CommissionTier> tiers;
  CommissionRatesLoaded({required this.tiers});
}

class IncomeHistoryLoaded extends MultiAssetState {
  final List<IncomeEvent> events;
  final double totalIncome;
  IncomeHistoryLoaded({required this.events, required this.totalIncome});
}

class TreasuryBillsLoaded extends MultiAssetState {
  final List<TreasuryBill> bills;
  TreasuryBillsLoaded({required this.bills});
}

class MutualFundsLoaded extends MultiAssetState {
  final List<MutualFund> funds;
  MutualFundsLoaded({required this.funds});
}

class PurchaseSuccess extends MultiAssetState {
  final String investmentId;
  final String message;
  PurchaseSuccess({required this.investmentId, required this.message});
}

class MultiAssetError extends MultiAssetState {
  final String message;
  MultiAssetError({required this.message});
}

class MultiAssetCubit extends Cubit<MultiAssetState> {
  final IMultiAssetDataSource _dataSource;

  MultiAssetCubit({required IMultiAssetDataSource dataSource})
      : _dataSource = dataSource,
        super(MultiAssetInitial());

  Future<void> loadAssets({
    String? assetType,
    String? region,
    String? riskLevel,
    bool featuredOnly = false,
    String? query,
  }) async {
    emit(MultiAssetLoading());
    try {
      final assets = await _dataSource.listAssets(
        assetType: assetType,
        region: region,
        riskLevel: riskLevel,
        featuredOnly: featuredOnly,
        query: query,
      );
      emit(AssetCatalogLoaded(assets: assets, activeFilter: assetType));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }

  Future<void> loadCategories() async {
    emit(MultiAssetLoading());
    try {
      final categories = await _dataSource.getAssetCategories();
      emit(AssetCategoriesLoaded(categories: categories));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }

  Future<void> loadFXRate(String from, String to) async {
    emit(MultiAssetLoading());
    try {
      final rate = await _dataSource.getFXRate(from, to);
      emit(FXRateLoaded(rate: rate));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }

  Future<void> quoteCurrency({
    required String from,
    required String to,
    required double amount,
    required String direction,
  }) async {
    emit(MultiAssetLoading());
    try {
      final result = await _dataSource.convertCurrency(
        fromCurrency: from,
        toCurrency: to,
        amount: amount,
        direction: direction,
      );
      emit(FXQuoteLoaded(result: result));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }

  Future<void> loadCommissionRates() async {
    emit(MultiAssetLoading());
    try {
      final tiers = await _dataSource.getCommissionRates();
      emit(CommissionRatesLoaded(tiers: tiers));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }

  Future<void> loadIncomeHistory({String? incomeType}) async {
    emit(MultiAssetLoading());
    try {
      final events = await _dataSource.getIncomeHistory(incomeType: incomeType);
      final total = await _dataSource.getTotalIncome();
      emit(IncomeHistoryLoaded(events: events, totalIncome: total));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }

  Future<void> loadTreasuryBills() async {
    emit(MultiAssetLoading());
    try {
      final bills = await _dataSource.getTreasuryBills();
      emit(TreasuryBillsLoaded(bills: bills));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }

  Future<void> loadMutualFunds() async {
    emit(MultiAssetLoading());
    try {
      final funds = await _dataSource.getMutualFunds();
      emit(MutualFundsLoaded(funds: funds));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }

  Future<void> buyTreasuryBill({
    required String assetId,
    required double amount,
    required String currency,
    required String verificationToken,
    String? idempotencyKey,
  }) async {
    emit(MultiAssetLoading());
    try {
      final result = await _dataSource.buyTreasuryBill(
        assetId, amount, currency,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      emit(PurchaseSuccess(
        investmentId: result['investment_id'] ?? '',
        message: 'Treasury bill purchase initiated',
      ));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }

  Future<void> buyMutualFund({
    required String assetId,
    required double amount,
    required String currency,
    required String verificationToken,
    String? idempotencyKey,
  }) async {
    emit(MultiAssetLoading());
    try {
      final result = await _dataSource.buyMutualFund(
        assetId, amount, currency,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      emit(PurchaseSuccess(
        investmentId: result['investment_id'] ?? '',
        message: 'Mutual fund purchase initiated',
      ));
    } catch (e) {
      emit(MultiAssetError(message: e.toString()));
    }
  }
}
