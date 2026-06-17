import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/investments/presentation/models/invest_asset_hub_config.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';
import 'package:lazervault/src/features/investments/presentation/widgets/invest_hub_panels.dart';

enum InvestActivitySection { portfolio, watchlist, orders, news }

/// Full-screen activity (deep links). Same content as hub segments.
class InvestActivityScreen extends StatefulWidget {
  const InvestActivityScreen({super.key, required this.section});

  final InvestActivitySection section;

  @override
  State<InvestActivityScreen> createState() => _InvestActivityScreenState();
}

class _InvestActivityScreenState extends State<InvestActivityScreen> {
  String? _investCollectionId;

  @override
  void initState() {
    super.initState();
    final raw = Get.arguments;
    if (raw is Map) {
      final id = raw['investCollection'];
      if (id is String && id.isNotEmpty) _investCollectionId = id;
    }
  }

  InvestAssetHubConfig get _hub =>
      InvestAssetHubConfig.forCollectionId(_investCollectionId);

  String get _screenTitle {
    switch (widget.section) {
      case InvestActivitySection.portfolio:
        return '${_hub.appBarScrolledTitle} · Portfolio';
      case InvestActivitySection.watchlist:
        return '${_hub.appBarScrolledTitle} · Watchlist';
      case InvestActivitySection.orders:
        return '${_hub.appBarScrolledTitle} · Orders';
      case InvestActivitySection.news:
        return '${_hub.appBarScrolledTitle} · News';
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _hub.accentColor;

    return Scaffold(
      backgroundColor: InvestTradingUi.background,
      appBar: AppBar(
        backgroundColor: InvestTradingUi.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: InvestTradingUi.textPrimary,
            size: 20.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          _screenTitle,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: InvestTradingUi.textPrimary,
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: InvestTradingUi.scaffoldGradient),
        child: switch (widget.section) {
          InvestActivitySection.portfolio => InvestHubPanels.portfolio(
              investCollectionId: _investCollectionId,
              accent: accent,
            ),
          InvestActivitySection.watchlist => InvestHubPanels.watchlist(
              investCollectionId: _investCollectionId,
              accent: accent,
            ),
          InvestActivitySection.orders => InvestHubPanels.orders(
              investCollectionId: _investCollectionId,
              accent: accent,
            ),
          InvestActivitySection.news => InvestHubPanels.news(accent: accent),
        },
      ),
    );
  }
}
