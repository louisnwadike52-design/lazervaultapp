import '../models/crypto_model.dart';
import '../../domain/entities/price_point.dart';

abstract class CryptoRemoteDataSource {
  Future<List<CryptoModel>> getCryptos({int page = 1, int perPage = 100});
  Future<CryptoModel> getCryptoById(String id);
  Future<List<CryptoModel>> searchCryptos(String query);
  Future<List<PricePoint>> getCryptoPriceHistory(String id, {String range = '7d'});
  Future<List<CryptoModel>> getTrendingCryptos();
  Future<List<CryptoModel>> getTopCryptos();
}

class CryptoRemoteDataSourceImpl implements CryptoRemoteDataSource {
  // For now, using mock data. In production, this would use http client for CoinGecko API
  
  @override
  Future<List<CryptoModel>> getCryptos({int page = 1, int perPage = 100}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return sample data with more cryptos
    final sampleCryptos = CryptoModel.sampleCryptos();
    final moreCryptos = [
      CryptoModel(
        id: 'cardano',
        symbol: 'ADA',
        name: 'Cardano',
        image: 'https://assets.coingecko.com/coins/images/975/large/cardano.png',
        currentPrice: 0.485,
        marketCap: 17200000000,
        marketCapRank: 8,
        totalVolume: 450000000,
        high24h: 0.498,
        low24h: 0.472,
        priceChange24h: 0.013,
        priceChangePercentage24h: 2.75,
        priceChangePercentage7d: 1.23,
        priceChangePercentage30d: -5.67,
        priceChangePercentage1y: -12.34,
        circulatingSupply: 35000000000,
        totalSupply: 45000000000,
        maxSupply: 45000000000,
        ath: 3.09,
        athChangePercentage: -84.31,
        athDate: DateTime.parse('2021-09-02'),
        atl: 0.01925465,
        atlChangePercentage: 2420.56,
        atlDate: DateTime.parse('2020-03-13'),
        lastUpdated: DateTime.now(),
        priceHistory: _generateSamplePriceHistory(0.485),
      ),
      CryptoModel(
        id: 'solana',
        symbol: 'SOL',
        name: 'Solana',
        image: 'https://assets.coingecko.com/coins/images/4128/large/solana.png',
        currentPrice: 98.75,
        marketCap: 42800000000,
        marketCapRank: 5,
        totalVolume: 2100000000,
        high24h: 102.30,
        low24h: 96.45,
        priceChange24h: 2.30,
        priceChangePercentage24h: 2.38,
        priceChangePercentage7d: 4.56,
        priceChangePercentage30d: 12.34,
        priceChangePercentage1y: 234.56,
        circulatingSupply: 433000000,
        totalSupply: 433000000,
        ath: 259.96,
        athChangePercentage: -62.02,
        athDate: DateTime.parse('2021-11-06'),
        atl: 0.500801,
        atlChangePercentage: 19620.78,
        atlDate: DateTime.parse('2020-05-11'),
        lastUpdated: DateTime.now(),
        priceHistory: _generateSamplePriceHistory(98.75),
      ),
      CryptoModel(
        id: 'dogecoin',
        symbol: 'DOGE',
        name: 'Dogecoin',
        image: 'https://assets.coingecko.com/coins/images/5/large/dogecoin.png',
        currentPrice: 0.087,
        marketCap: 12400000000,
        marketCapRank: 10,
        totalVolume: 680000000,
        high24h: 0.092,
        low24h: 0.084,
        priceChange24h: 0.003,
        priceChangePercentage24h: 3.56,
        priceChangePercentage7d: -2.34,
        priceChangePercentage30d: 8.90,
        priceChangePercentage1y: -15.67,
        circulatingSupply: 142600000000,
        totalSupply: 142600000000,
        ath: 0.731578,
        athChangePercentage: -88.11,
        athDate: DateTime.parse('2021-05-08'),
        atl: 0.00008547,
        atlChangePercentage: 101789.45,
        atlDate: DateTime.parse('2015-05-06'),
        lastUpdated: DateTime.now(),
        priceHistory: _generateSamplePriceHistory(0.087),
      ),
    ];
    
    return [...sampleCryptos, ...moreCryptos];
  }

  @override
  Future<CryptoModel> getCryptoById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final cryptos = await getCryptos();
    final crypto = cryptos.firstWhere(
      (c) => c.id == id,
      orElse: () => cryptos.first,
    );
    
    return crypto;
  }

  @override
  Future<List<CryptoModel>> searchCryptos(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    
    final cryptos = await getCryptos();
    return cryptos.where((crypto) =>
        crypto.name.toLowerCase().contains(query.toLowerCase()) ||
        crypto.symbol.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Future<List<PricePoint>> getCryptoPriceHistory(String id, {String range = '7d'}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final crypto = await getCryptoById(id);
    return crypto.priceHistory;
  }

  @override
  Future<List<CryptoModel>> getTrendingCryptos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final cryptos = await getCryptos();
    // Return cryptos with highest 24h percentage change
    cryptos.sort((a, b) => b.priceChangePercentage24h.compareTo(a.priceChangePercentage24h));
    return cryptos.take(5).toList();
  }

  @override
  Future<List<CryptoModel>> getTopCryptos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final cryptos = await getCryptos();
    // Return top cryptos by market cap
    cryptos.sort((a, b) => b.marketCap.compareTo(a.marketCap));
    return cryptos.take(10).toList();
  }

  static List<PricePoint> _generateSamplePriceHistory(double currentPrice) {
    final now = DateTime.now();
    final List<PricePoint> history = [];
    
    for (int i = 30; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final variation = (i * 0.02 - 0.3) * currentPrice;
      final price = currentPrice + variation;
      
      history.add(PricePoint(
        timestamp: date,
        price: price,
        open: price * 0.99,
        high: price * 1.02,
        low: price * 0.98,
        close: price,
        volume: 1000000 + (i * 50000),
      ));
    }
    
    return history;
  }
} 