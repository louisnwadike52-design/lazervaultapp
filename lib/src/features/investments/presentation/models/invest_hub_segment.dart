import 'package:lazervault/src/features/investments/presentation/models/invest_asset_hub_config.dart';

/// Top-level segments on the per–asset-class invest hub (Revolut-style pills).
enum InvestHubPrimarySegment {
  /// Crypto-style dashboard (portfolio, movers, news, quick actions) for this hub.
  home,
  assets,
  programme,
  exchange,
  portfolio,
  watchlist,
  orders,
  news,
}

const _kHubActivityTail = <InvestHubPrimarySegment>[
  InvestHubPrimarySegment.portfolio,
  InvestHubPrimarySegment.watchlist,
  InvestHubPrimarySegment.orders,
  InvestHubPrimarySegment.news,
];

extension InvestHubPrimarySegmentList on InvestAssetHubConfig {
  List<InvestHubPrimarySegment> get hubPrimarySegments {
    if (collectionId == 'fx') {
      return [InvestHubPrimarySegment.exchange, ..._kHubActivityTail];
    }
    if (!showsInstrumentBrowse) {
      return [InvestHubPrimarySegment.programme, ..._kHubActivityTail];
    }
    return [
      InvestHubPrimarySegment.home,
      InvestHubPrimarySegment.assets,
      ..._kHubActivityTail,
    ];
  }

  String label(InvestHubPrimarySegment s) {
    return switch (s) {
      InvestHubPrimarySegment.home => 'Home',
      InvestHubPrimarySegment.assets => 'All',
      InvestHubPrimarySegment.programme => 'About',
      InvestHubPrimarySegment.exchange => 'FX',
      InvestHubPrimarySegment.portfolio => 'Portfolio',
      InvestHubPrimarySegment.watchlist => 'Watchlist',
      InvestHubPrimarySegment.orders => 'Orders',
      InvestHubPrimarySegment.news => 'News',
    };
  }
}
