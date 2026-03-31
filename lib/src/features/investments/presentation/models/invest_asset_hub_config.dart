import 'package:flutter/material.dart';

/// Presentation + routing context for each invest entry point (Invest screen → hub).
/// Keeps titles, copy, and feature flags in one place so we never show "Stocks" for REITs/ETFs/etc.
class InvestAssetHubConfig {
  const InvestAssetHubConfig({
    required this.collectionId,
    required this.appBarScrolledTitle,
    required this.heroEyebrow,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.heroIcon,
    required this.accentColor,
    required this.popularSectionTitle,
    required this.showMarketOverview,
    required this.showPopularInstruments,
    required this.voiceServiceName,
    required this.microserviceChatServiceName,
    this.curatedSymbols = const [],
    this.curatedSectionTitle,
    this.showFxHeroCta = false,
    this.showTradeQuickActions = true,
  });

  /// Route arg `investCollection`, or `stocks` when opening generic stocks.
  final String collectionId;
  final String appBarScrolledTitle;
  final String heroEyebrow;
  final String heroTitle;
  final String heroSubtitle;
  final IconData heroIcon;
  final Color accentColor;
  final String popularSectionTitle;
  final bool showMarketOverview;
  final bool showPopularInstruments;
  final String voiceServiceName;
  final String microserviceChatServiceName;
  final List<String> curatedSymbols;
  final String? curatedSectionTitle;
  final bool showFxHeroCta;
  final bool showTradeQuickActions;

  static InvestAssetHubConfig resolve(dynamic arguments) {
    String? id;
    if (arguments is Map) {
      final raw = arguments['investCollection'];
      if (raw is String && raw.isNotEmpty) id = raw;
    }
    return forCollectionId(id);
  }

  /// Use when you already have a collection id (e.g. from route args).
  static InvestAssetHubConfig forCollectionId(String? id) {
    if (id == null || id.isEmpty) return _stocksDefault;
    return _byCollectionId[id] ?? _stocksDefault;
  }

  bool get hasCuratedList => curatedSymbols.isNotEmpty;

  /// Hubs backed by the equity/instrument list + trade carousel (not T-bills / funds / FX home).
  bool get showsInstrumentBrowse =>
      showPopularInstruments || hasCuratedList || collectionId == 'stocks';

  static final InvestAssetHubConfig _stocksDefault = InvestAssetHubConfig(
    collectionId: 'stocks',
    appBarScrolledTitle: 'Stocks',
    heroEyebrow: 'Markets',
    heroTitle: 'Stocks',
    heroSubtitle: 'Trade US equities and build your portfolio.',
    heroIcon: Icons.trending_up_rounded,
    accentColor: Color(0xFF10B981),
    popularSectionTitle: 'Popular stocks',
    showMarketOverview: true,
    showPopularInstruments: true,
    voiceServiceName: 'stocks',
    microserviceChatServiceName: 'Stocks',
    curatedSymbols: <String>[],
    curatedSectionTitle: null,
    showTradeQuickActions: true,
  );

  static final Map<String, InvestAssetHubConfig> _byCollectionId = {
    'etf': InvestAssetHubConfig(
      collectionId: 'etf',
      appBarScrolledTitle: 'ETFs',
      heroEyebrow: 'Funds',
      heroTitle: 'Exchange-traded funds',
      heroSubtitle: 'Broad market and thematic exposure in a single trade.',
      heroIcon: Icons.pie_chart_rounded,
      accentColor: Color(0xFF3B82F6),
      popularSectionTitle: 'ETFs to explore',
      showMarketOverview: true,
      showPopularInstruments: true,
      voiceServiceName: 'stocks',
      microserviceChatServiceName: 'Investments',
      curatedSymbols: const ['VOO', 'VTI', 'QQQ', 'IWM'],
      curatedSectionTitle: 'US equity ETFs',
    ),
    'treasury_etf': InvestAssetHubConfig(
      collectionId: 'treasury_etf',
      appBarScrolledTitle: 'Treasury ETFs',
      heroEyebrow: 'Lower risk',
      heroTitle: 'Treasury ETFs',
      heroSubtitle: 'Short-duration government bond funds — yields move with policy rates.',
      heroIcon: Icons.shield_rounded,
      accentColor: Color(0xFF0EA5E9),
      popularSectionTitle: 'Treasury & cash ETFs',
      showMarketOverview: true,
      showPopularInstruments: true,
      voiceServiceName: 'stocks',
      microserviceChatServiceName: 'Investments',
      curatedSymbols: const ['SGOV', 'SHV', 'BIL', 'USFR'],
      curatedSectionTitle: 'Treasury & cash-like ETFs',
    ),
    'bond_etf': InvestAssetHubConfig(
      collectionId: 'bond_etf',
      appBarScrolledTitle: 'Bond ETFs',
      heroEyebrow: 'Fixed income',
      heroTitle: 'Bond ETFs',
      heroSubtitle: 'Credit and duration exposure via funds — not primary T-bill auctions.',
      heroIcon: Icons.stacked_line_chart_rounded,
      accentColor: Color(0xFF607D8B),
      popularSectionTitle: 'Bond ETFs',
      showMarketOverview: true,
      showPopularInstruments: true,
      voiceServiceName: 'stocks',
      microserviceChatServiceName: 'Investments',
      curatedSymbols: const ['BND', 'VCIT', 'VGIT'],
      curatedSectionTitle: 'Bond / fixed-income ETFs',
    ),
    'reit_etf': InvestAssetHubConfig(
      collectionId: 'reit_etf',
      appBarScrolledTitle: 'REITs',
      heroEyebrow: 'Real estate',
      heroTitle: 'REITs',
      heroSubtitle: 'Listed property trusts — income and volatility differ from residential bricks.',
      heroIcon: Icons.home_work_rounded,
      accentColor: Color(0xFF795548),
      popularSectionTitle: 'REIT & property ETFs',
      showMarketOverview: true,
      showPopularInstruments: true,
      voiceServiceName: 'stocks',
      microserviceChatServiceName: 'Investments',
      curatedSymbols: const ['VNQ', 'SCHH', 'XLRE'],
      curatedSectionTitle: 'Real estate (REIT) ETFs',
    ),
    'tbill': InvestAssetHubConfig(
      collectionId: 'tbill',
      appBarScrolledTitle: 'T-Bills',
      heroEyebrow: 'Nigeria',
      heroTitle: 'Treasury bills',
      heroSubtitle: 'Government-backed local bills — maturities and rates are set by the market.',
      heroIcon: Icons.account_balance_rounded,
      accentColor: Color(0xFF059669),
      popularSectionTitle: 'T-Bill programmes',
      showMarketOverview: false,
      showPopularInstruments: false,
      voiceServiceName: 'stocks',
      microserviceChatServiceName: 'Investments',
      curatedSymbols: const [],
      curatedSectionTitle: null,
      showTradeQuickActions: false,
    ),
    'mutual_fund': InvestAssetHubConfig(
      collectionId: 'mutual_fund',
      appBarScrolledTitle: 'Mutual funds',
      heroEyebrow: 'Managed',
      heroTitle: 'Mutual funds',
      heroSubtitle: 'Professionally managed baskets — risk label depends on the fund mandate.',
      heroIcon: Icons.analytics_rounded,
      accentColor: Color(0xFF9C27B0),
      popularSectionTitle: 'Funds',
      showMarketOverview: false,
      showPopularInstruments: false,
      voiceServiceName: 'stocks',
      microserviceChatServiceName: 'Investments',
      curatedSymbols: const [],
      curatedSectionTitle: null,
      showTradeQuickActions: false,
    ),
    'fx': InvestAssetHubConfig(
      collectionId: 'fx',
      appBarScrolledTitle: 'FX',
      heroEyebrow: 'Currencies',
      heroTitle: 'FX & exchange',
      heroSubtitle: 'Convert between wallets and currencies at live rates.',
      heroIcon: Icons.currency_exchange_rounded,
      accentColor: Color(0xFFF59E0B),
      popularSectionTitle: 'Watchlist',
      showMarketOverview: false,
      showPopularInstruments: false,
      voiceServiceName: 'stocks',
      microserviceChatServiceName: 'Investments',
      curatedSymbols: const [],
      curatedSectionTitle: null,
      showFxHeroCta: true,
      showTradeQuickActions: false,
    ),
  };
}
