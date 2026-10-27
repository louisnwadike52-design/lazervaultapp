import 'package:lazervault/core/cache/session_page_store.dart';

import '../data/models/crypto_model.dart';
import '../domain/entities/crypto_entity.dart';

/// Disk mirror of the Crypto hub's tradable asset list (Phase A of
/// [CryptoCubit.loadCryptos]), per user, so a COLD START paints the hub with
/// last-known prices instead of the full-screen shimmer, while the live
/// list revalidates behind it within seconds.
///
/// Only the asset list is mirrored. Holdings, transactions, alerts and
/// auto-orders are per-section fetches that already render their own
/// section-scoped loaders without blocking the page; and they are the
/// user's money, so the first paint after a launch should never show a
/// balance the server has not just confirmed.
class CryptoAssetsPageStore {
  CryptoAssetsPageStore._();

  static final SessionPageStore<Crypto> store = SessionPageStore<Crypto>(
    'crypto_assets',
    toJson: encode,
    fromJson: CryptoModel.fromJson,
    // Prices older than this are not worth painting even as "last known".
    maxAge: const Duration(hours: 6),
  );

  /// Same keys as [CryptoModel.toJson] so [CryptoModel.fromJson] reads it
  /// back; written from the entity so it works for any [Crypto] instance.
  /// The 7-day chart history is left out — the hub tiles do not draw it.
  static Map<String, dynamic> encode(Crypto c) => {
        'id': c.id,
        'symbol': c.symbol,
        'name': c.name,
        'image': c.image,
        'current_price': c.currentPrice,
        'market_cap': c.marketCap,
        'market_cap_rank': c.marketCapRank,
        'fully_diluted_valuation': c.fullyDilutedValuation,
        'total_volume': c.totalVolume,
        'high_24h': c.high24h,
        'low_24h': c.low24h,
        'price_change_24h': c.priceChange24h,
        'price_change_percentage_24h': c.priceChangePercentage24h,
        'price_change_percentage_7d_in_currency': c.priceChangePercentage7d,
        'price_change_percentage_30d_in_currency': c.priceChangePercentage30d,
        'price_change_percentage_1y_in_currency': c.priceChangePercentage1y,
        'market_cap_change_24h': c.marketCapChange24h,
        'market_cap_change_percentage_24h': c.marketCapChangePercentage24h,
        'circulating_supply': c.circulatingSupply,
        'total_supply': c.totalSupply,
        'max_supply': c.maxSupply,
        'ath': c.ath,
        'ath_change_percentage': c.athChangePercentage,
        'ath_date': c.athDate?.toIso8601String(),
        'atl': c.atl,
        'atl_change_percentage': c.atlChangePercentage,
        'atl_date': c.atlDate?.toIso8601String(),
        'last_updated': c.lastUpdated.toIso8601String(),
        'sparkline_in_7d': c.sparklineIn7d == null
            ? null
            : {
                'price': [c.sparklineIn7d]
              },
        'is_favorite': c.isFavorite,
      };
}
