import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';

/// Normalizes [Get.arguments] for [AppRoutes.stockDetails] (Stock, Map, or legacy).
class StockDetailsRouteArgs {
  const StockDetailsRouteArgs({
    required this.stock,
    this.investCollectionId,
  });

  final Stock stock;
  final String? investCollectionId;

  /// Accepts:
  /// - [Stock]
  /// - `Map` with `stock` ([Stock]) and optional `investCollection` ([String])
  /// - `Map` with `symbol` ([String]) — builds [Stock.navigationStub]
  static StockDetailsRouteArgs parse(dynamic raw) {
    if (raw is Stock) {
      return StockDetailsRouteArgs(stock: raw);
    }
    if (raw is Map) {
      final collection = raw['investCollection'];
      final id = collection is String && collection.isNotEmpty ? collection : null;

      final s = raw['stock'];
      if (s is Stock) {
        return StockDetailsRouteArgs(stock: s, investCollectionId: id);
      }
      final sym = raw['symbol'];
      if (sym is String && sym.isNotEmpty) {
        final currency = raw['currency'] is String ? raw['currency'] as String : 'USD';
        return StockDetailsRouteArgs(
          stock: Stock.navigationStub(sym, currency: currency),
          investCollectionId: id,
        );
      }
    }
    throw ArgumentError(
      'Invalid stock details route arguments: expected Stock or Map with stock/symbol.',
    );
  }
}
