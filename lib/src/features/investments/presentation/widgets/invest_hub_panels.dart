import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/investments/presentation/navigation/invest_route_args.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_state.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';

/// Shared hub panels (Portfolio / Watchlist / Orders / News) for segmented invest UI.
/// Parent must call the matching [StockCubit] load when this tab becomes visible.

class InvestHubPanels {
  InvestHubPanels._();

  static Widget portfolio({
    required String? investCollectionId,
    required Color accent,
  }) {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is PortfolioLoading) {
          return Center(child: CircularProgressIndicator(color: accent));
        }
        if (state is PortfolioError) {
          return _retryPanel(
            state.message,
            () => context.read<StockCubit>().loadPortfolio(),
          );
        }
        if (state is PortfolioLoaded) {
          final p = state.portfolio;
          if (p.holdings.isEmpty) {
            return _emptyPanel(
              title: 'No positions yet',
              subtitle: 'Browse instruments and buy to build your portfolio.',
              accent: accent,
              ctaLabel: 'Browse assets',
              onCta: () => Get.toNamed(
                AppRoutes.stocks,
                arguments: InvestRouteArgs.hub(investCollectionId),
              ),
            );
          }
          return RefreshIndicator(
            color: accent,
            onRefresh: () => context.read<StockCubit>().loadPortfolio(),
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
              children: [
                _summaryCard(p),
                SizedBox(height: 20.h),
                Text(
                  'Holdings',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: InvestTradingUi.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),
                ...p.holdings.map(
                  (h) => _holdingTile(
                    h,
                    investCollectionId: investCollectionId,
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator(color: accent));
      },
    );
  }

  static Widget watchlist({
    required String? investCollectionId,
    required Color accent,
  }) {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is WatchlistsLoading) {
          return Center(child: CircularProgressIndicator(color: accent));
        }
        if (state is WatchlistsError) {
          return _retryPanel(
            state.message,
            () => context.read<StockCubit>().loadWatchlists(),
          );
        }
        if (state is WatchlistsLoaded) {
          final lists = state.watchlists;
          if (lists.isEmpty) {
            return _emptyPanel(
              title: 'No watchlists',
              subtitle: 'Add symbols from instrument details.',
              accent: accent,
              ctaLabel: 'Browse',
              onCta: () => Get.toNamed(
                AppRoutes.stocks,
                arguments: InvestRouteArgs.hub(investCollectionId),
              ),
            );
          }
          return RefreshIndicator(
            color: accent,
            onRefresh: () => context.read<StockCubit>().loadWatchlists(),
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
              itemCount: lists.length,
              itemBuilder: (context, i) {
                final w = lists[i];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: InvestTradingUi.statementCardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          w.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: InvestTradingUi.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: w.symbols
                              .map(
                                (s) => ActionChip(
                                  label: Text(s),
                                  onPressed: () => Get.toNamed(
                                    AppRoutes.stockDetails,
                                    arguments: {
                                      'stock': Stock.navigationStub(s),
                                      ...InvestRouteArgs.hub(investCollectionId),
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator(color: accent));
      },
    );
  }

  static Widget orders({
    required String? investCollectionId,
    required Color accent,
  }) {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return Center(child: CircularProgressIndicator(color: accent));
        }
        if (state is OrdersLoaded) {
          final orders = state.orders;
          if (orders.isEmpty) {
            return _emptyPanel(
              title: 'No orders',
              subtitle: 'Placed orders appear here.',
              accent: accent,
              ctaLabel: 'Buy',
              onCta: () => Get.toNamed(
                AppRoutes.stockTradeAmount,
                arguments: {
                  'tradeType': 'buy',
                  ...InvestRouteArgs.hub(investCollectionId),
                },
              ),
            );
          }
          return RefreshIndicator(
            color: accent,
            onRefresh: () => context.read<StockCubit>().loadOrders(),
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
              itemCount: orders.length,
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemBuilder: (context, i) {
                final o = orders[i];
                final side = o.side == OrderSide.buy ? 'Buy' : 'Sell';
                return Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: InvestTradingUi.cardDecoration(
                    color: InvestTradingUi.surfaceElevated,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              o.symbol,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: InvestTradingUi.textPrimary,
                              ),
                            ),
                            Text(
                              '$side · ${o.quantity} @ ${o.orderType.name}',
                              style: InvestTradingUi.labelMuted(),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        o.orderStatus.name,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator(color: accent));
      },
    );
  }

  static Widget news({
    required Color accent,
  }) {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is MarketNewsLoading) {
          return Center(child: CircularProgressIndicator(color: accent));
        }
        if (state is MarketNewsError) {
          return _retryPanel(
            state.message,
            () => context.read<StockCubit>().loadMarketNews(),
          );
        }
        if (state is MarketNewsLoaded) {
          final items = state.news;
          if (items.isEmpty) {
            return Center(
              child: Text('No headlines', style: InvestTradingUi.labelMuted()),
            );
          }
          return RefreshIndicator(
            color: accent,
            onRefresh: () => context.read<StockCubit>().loadMarketNews(),
            child: ListView.separated(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 10.h),
              itemBuilder: (context, i) {
                final n = items[i];
                return Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: InvestTradingUi.cardDecoration(
                    color: InvestTradingUi.surfaceElevated,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        n.title,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: InvestTradingUi.textPrimary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(n.source, style: InvestTradingUi.labelMuted()),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator(color: accent));
      },
    );
  }

  static Widget _summaryCard(Portfolio p) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: InvestTradingUi.statementCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total value', style: InvestTradingUi.labelMuted()),
          SizedBox(height: 6.h),
          Text(
            CurrencySymbols.formatAmountWithCurrency(p.totalValue, 'USD'),
            style: GoogleFonts.inter(
              fontSize: 26.sp,
              fontWeight: FontWeight.w800,
              color: InvestTradingUi.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Day ${p.dayChangePercent >= 0 ? '+' : ''}${p.dayChangePercent.toStringAsFixed(2)}%',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: p.dayChangePercent >= 0
                  ? InvestTradingUi.buy
                  : InvestTradingUi.sell,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _holdingTile(
    StockHolding h, {
    required String? investCollectionId,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed(
            AppRoutes.stockDetails,
            arguments: {
              'stock': Stock.navigationStub(h.symbol),
              ...InvestRouteArgs.hub(investCollectionId),
            },
          ),
          borderRadius: BorderRadius.circular(14.r),
          child: Ink(
            padding: EdgeInsets.all(14.w),
            decoration: InvestTradingUi.cardDecoration(
              color: InvestTradingUi.surfaceElevated,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        h.symbol,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: InvestTradingUi.textPrimary,
                        ),
                      ),
                      Text(
                        h.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: InvestTradingUi.labelMuted(),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      CurrencySymbols.formatAmountWithCurrency(
                        h.totalValue,
                        'USD',
                      ),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: InvestTradingUi.textPrimary,
                      ),
                    ),
                    Text('${h.shares} sh', style: InvestTradingUi.labelMuted()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _retryPanel(String message, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: InvestTradingUi.labelMuted(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            FilledButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }

  static Widget _emptyPanel({
    required String title,
    required String subtitle,
    required Color accent,
    required String ctaLabel,
    required VoidCallback onCta,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: InvestTradingUi.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: InvestTradingUi.labelMuted(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            FilledButton(
              onPressed: onCta,
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.white,
              ),
              child: Text(ctaLabel),
            ),
          ],
        ),
      ),
    );
  }
}
