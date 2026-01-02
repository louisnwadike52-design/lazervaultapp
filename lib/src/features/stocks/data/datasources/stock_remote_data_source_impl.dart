import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lazervault/core/services/secure_storage_service.dart';
import '../models/stock_model.dart';
import '../../domain/entities/stock_entity.dart';
import '../../domain/entities/price_point.dart';
import 'stock_remote_data_source.dart';

/// Real implementation of stock data source that calls the stocks microservice API
class StockRemoteDataSourceRealImpl implements IStockRemoteDataSource {
  final String baseUrl;
  final http.Client client;
  final SecureStorageService secureStorage;

  StockRemoteDataSourceRealImpl({
    required this.baseUrl,
    required this.client,
    required this.secureStorage,
  });

  /// Get headers with current access token from secure storage
  Future<Map<String, String>> get _headers async {
    final accessToken = await secureStorage.getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (accessToken != null && accessToken.isNotEmpty)
        'Authorization': 'Bearer $accessToken',
    };
  }

  @override
  Future<List<StockModel>> getStocks({
    String? sector,
    String? searchQuery,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (sector != null) queryParams['sector'] = sector;
      if (searchQuery != null) queryParams['q'] = searchQuery;
      if (limit > 0) queryParams['limit'] = limit.toString();

      final uri = Uri.parse('$baseUrl/stocks').replace(queryParameters: queryParams);
      final headers = await _headers;
      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final stocks = (data['stocks'] as List? ?? [])
            .map((json) => StockModel.fromJson(json))
            .toList();
        return stocks;
      } else {
        throw Exception('Failed to load stocks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching stocks: $e');
      rethrow;
    }
  }

  @override
  Future<StockModel> getStockDetails(String symbol) async {
    try {
      final uri = Uri.parse('$baseUrl/stocks/${symbol.toUpperCase()}');
      final headers = await _headers;
      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        return StockModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw Exception('Stock with symbol $symbol not found');
      } else {
        throw Exception('Failed to load stock details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching stock details: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockPriceModel>> getStockPriceHistory(
    String symbol,
    String timeframe,
  ) async {
    try {
      final uri = Uri.parse('$baseUrl/stocks/${symbol.toUpperCase()}/history')
          .replace(queryParameters: {'timeframe': timeframe});
      final headers = await _headers;
      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final priceHistory = (data['price_history'] as List? ?? [])
            .map((json) => StockPriceModel.fromJson(json))
            .toList();
        return priceHistory;
      } else {
        throw Exception('Failed to load price history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching price history: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockModel>> getTopMovers() async {
    try {
      // Get both gainers and losers
      final gainers = await _getTopGainers();
      final losers = await _getTopLosers();

      // Combine and sort by absolute change
      final allMovers = [...gainers, ...losers];
      allMovers.sort((a, b) => b.changePercent.abs().compareTo(a.changePercent.abs()));

      return allMovers;
    } catch (e) {
      print('Error fetching top movers: $e');
      rethrow;
    }
  }

  Future<List<StockModel>> _getTopGainers() async {
    final uri = Uri.parse('$baseUrl/market/gainers');
    final response = await client.get(uri, headers: await _headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['stocks'] as List? ?? [])
          .map((json) => StockModel.fromJson(json))
          .toList();
    }
    return [];
  }

  Future<List<StockModel>> _getTopLosers() async {
    final uri = Uri.parse('$baseUrl/market/losers');
    final response = await client.get(uri, headers: await _headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['stocks'] as List? ?? [])
          .map((json) => StockModel.fromJson(json))
          .toList();
    }
    return [];
  }

  @override
  Future<List<StockModel>> searchStocks(String query) async {
    try {
      final uri = Uri.parse('$baseUrl/stocks/search')
          .replace(queryParameters: {'q': query, 'limit': '10'});
      final response = await client.get(uri, headers: await _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['stocks'] as List? ?? [])
            .map((json) => StockModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to search stocks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching stocks: $e');
      rethrow;
    }
  }

  @override
  Future<PortfolioModel> getPortfolio() async {
    try {
      final uri = Uri.parse('$baseUrl/portfolio');
      final response = await client.get(uri, headers: await _headers);

      if (response.statusCode == 200) {
        final portfolio = PortfolioModel.fromJson(json.decode(response.body));
        return portfolio;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in');
      } else {
        throw Exception('Failed to load portfolio: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching portfolio: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockHoldingModel>> getHoldings() async {
    try {
      final portfolio = await getPortfolio();
      return portfolio.holdings.cast<StockHoldingModel>();
    } catch (e) {
      print('Error fetching holdings: $e');
      rethrow;
    }
  }

  @override
  Future<StockOrderModel> placeOrder({
    required String symbol,
    required OrderType type,
    required OrderSide side,
    required int quantity,
    double? price,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/orders');
      final body = {
        'symbol': symbol.toUpperCase(),
        'type': type.toString().split('.').last,
        'side': side.toString().split('.').last,
        'quantity': quantity,
        if (price != null) 'price': price,
      };

      final response = await client.post(
        uri,
        headers: await _headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return StockOrderModel.fromJson(data['order']);
        } else {
          throw Exception(data['message'] ?? 'Order failed');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in');
      } else {
        throw Exception('Failed to place order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error placing order: $e');
      rethrow;
    }
  }

  @override
  Future<List<StockOrderModel>> getOrders({
    OrderStatus? status,
    String? symbol,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (status != null) queryParams['status'] = status.toString().split('.').last;
      if (symbol != null) queryParams['symbol'] = symbol.toUpperCase();

      final uri = Uri.parse('$baseUrl/orders').replace(queryParameters: queryParams);
      final response = await client.get(uri, headers: await _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['orders'] as List? ?? [])
            .map((json) => StockOrderModel.fromJson(json))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in');
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching orders: $e');
      rethrow;
    }
  }

  @override
  Future<StockOrderModel> cancelOrder(String orderId) async {
    try {
      final uri = Uri.parse('$baseUrl/orders/$orderId');
      final response = await client.delete(uri, headers: await _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          return StockOrderModel.fromJson(data['order']);
        } else {
          throw Exception(data['message'] ?? 'Cancel order failed');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in');
      } else {
        throw Exception('Failed to cancel order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error canceling order: $e');
      rethrow;
    }
  }

  @override
  Future<List<WatchlistModel>> getWatchlists() async {
    try {
      final uri = Uri.parse('$baseUrl/watchlists');
      final response = await client.get(uri, headers: await _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['watchlists'] as List? ?? [])
            .map((json) => WatchlistModel.fromJson(json))
            .toList();
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in');
      } else {
        throw Exception('Failed to load watchlists: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching watchlists: $e');
      rethrow;
    }
  }

  @override
  Future<WatchlistModel> createWatchlist(String name, List<String> symbols) async {
    try {
      final uri = Uri.parse('$baseUrl/watchlists');
      final body = {
        'name': name,
        'symbols': symbols.map((s) => s.toUpperCase()).toList(),
      };

      final response = await client.post(
        uri,
        headers: await _headers,
        body: json.encode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return WatchlistModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in');
      } else {
        throw Exception('Failed to create watchlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating watchlist: $e');
      rethrow;
    }
  }

  @override
  Future<WatchlistModel> updateWatchlist(String watchlistId, String name, List<String> symbols) async {
    try {
      final uri = Uri.parse('$baseUrl/watchlists/$watchlistId');
      final body = {
        'name': name,
        'symbols': symbols.map((s) => s.toUpperCase()).toList(),
      };

      final response = await client.put(
        uri,
        headers: await _headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return WatchlistModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in');
      } else {
        throw Exception('Failed to update watchlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating watchlist: $e');
      rethrow;
    }
  }

  @override
  Future<WatchlistModel> addToWatchlist(String watchlistId, String symbol) async {
    try {
      final uri = Uri.parse('$baseUrl/watchlists/$watchlistId/symbols');
      final body = {'symbol': symbol.toUpperCase()};

      final response = await client.post(
        uri,
        headers: await _headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return WatchlistModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in');
      } else {
        throw Exception('Failed to add to watchlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding to watchlist: $e');
      rethrow;
    }
  }

  @override
  Future<WatchlistModel> removeFromWatchlist(String watchlistId, String symbol) async {
    try {
      final uri = Uri.parse('$baseUrl/watchlists/$watchlistId/symbols/${symbol.toUpperCase()}');
      final response = await client.delete(uri, headers: await _headers);

      if (response.statusCode == 200) {
        return WatchlistModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in');
      } else {
        throw Exception('Failed to remove from watchlist: ${response.statusCode}');
      }
    } catch (e) {
      print('Error removing from watchlist: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteWatchlist(String watchlistId) async {
    try {
      final uri = Uri.parse('$baseUrl/watchlists/$watchlistId');
      final response = await client.delete(uri, headers: await _headers);

      if (response.statusCode != 200 && response.statusCode != 204) {
        if (response.statusCode == 401) {
          throw Exception('Unauthorized: Please log in');
        } else {
          throw Exception('Failed to delete watchlist: ${response.statusCode}');
        }
      }
    } catch (e) {
      print('Error deleting watchlist: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, double>> getMarketIndices() async {
    try {
      final uri = Uri.parse('$baseUrl/market/indices');
      final response = await client.get(uri, headers: await _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final indices = (data['indices'] as List? ?? []);

        final Map<String, double> result = {};
        for (var index in indices) {
          result[index['name']] = (index['value'] as num).toDouble();
        }
        return result;
      } else {
        throw Exception('Failed to load market indices: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching market indices: $e');
      rethrow;
    }
  }

  // These methods are not yet implemented in the microservice
  // Return mock data or throw not implemented for now

  @override
  Future<List<MarketNewsModel>> getMarketNews({
    NewsCategory? category,
    List<String>? symbols,
    int page = 1,
    int limit = 20,
  }) async {
    // Not yet implemented in microservice - return empty list
    return [];
  }

  @override
  Future<List<SectorPerformanceModel>> getSectorPerformance() async {
    // Not yet implemented in microservice - return empty list
    return [];
  }

  @override
  Future<List<StockAlertModel>> getAlerts() async {
    // Not yet implemented in microservice - return empty list
    return [];
  }

  @override
  Future<StockAlertModel> createAlert({
    required String symbol,
    required AlertType type,
    required double targetValue,
    required AlertCondition condition,
  }) async {
    throw UnimplementedError('Alerts not yet implemented in microservice');
  }

  @override
  Future<StockAlertModel> updateAlert(
    String alertId, {
    AlertType? type,
    double? targetValue,
    AlertCondition? condition,
    bool? isActive,
  }) async {
    throw UnimplementedError('Alerts not yet implemented in microservice');
  }

  @override
  Future<void> deleteAlert(String alertId) async {
    throw UnimplementedError('Alerts not yet implemented in microservice');
  }

  @override
  Future<StockAnalysisModel> getStockAnalysis(String symbol) async {
    throw UnimplementedError('Stock analysis not yet implemented in microservice');
  }

  @override
  Future<TradingSessionModel> getCurrentTradingSession() async {
    throw UnimplementedError('Trading sessions not yet implemented in microservice');
  }

  @override
  Future<TradingSessionModel> startTradingSession(double startingBalance) async {
    throw UnimplementedError('Trading sessions not yet implemented in microservice');
  }

  @override
  Future<TradingSessionModel> endTradingSession(String sessionId) async {
    throw UnimplementedError('Trading sessions not yet implemented in microservice');
  }

  @override
  Future<List<TradingSessionModel>> getTradingSessionHistory() async {
    throw UnimplementedError('Trading sessions not yet implemented in microservice');
  }

  @override
  Future<List<OptionContractModel>> getOptions(
    String underlyingSymbol, {
    DateTime? expirationDate,
    OptionType? type,
  }) async {
    throw UnimplementedError('Options trading not yet implemented in microservice');
  }

  @override
  Future<OptionContractModel> getOptionDetails(String optionSymbol) async {
    throw UnimplementedError('Options trading not yet implemented in microservice');
  }

  @override
  Future<List<StockModel>> getRecommendations() async {
    // Not yet implemented - return top gainers as recommendations
    return _getTopGainers();
  }

  @override
  Future<List<StockModel>> getTrendingStocks() async {
    // Not yet implemented - return top movers as trending
    return getTopMovers();
  }

  @override
  Future<Map<String, dynamic>> getMarketStatus() async {
    // Not yet implemented - return basic status
    return {
      'marketOpen': true,
      'tradingSession': 'regular',
      'sessionStartTime': DateTime.now().subtract(const Duration(hours: 1)),
      'sessionEndTime': DateTime.now().add(const Duration(hours: 3)),
    };
  }

  @override
  Future<List<StockModel>> getEarningsCalendar({DateTime? date}) async {
    // Not yet implemented - return empty list
    return [];
  }

  @override
  Future<List<StockModel>> getDividendCalendar({DateTime? date}) async {
    // Not yet implemented - return empty list
    return [];
  }
}
