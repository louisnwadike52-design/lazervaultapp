import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/investments/presentation/models/invest_asset_hub_config.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_cubit.dart';
import 'package:lazervault/src/features/stocks/cubit/stock_state.dart';
import 'package:lazervault/src/features/stocks/domain/entities/stock_entity.dart';

import 'create_stock_trade_carousel.dart';

/// Unified entry: optional [Stock] in route args, else symbol lookup then carousel.
class StockTradeFlowScreen extends StatefulWidget {
  const StockTradeFlowScreen({super.key});

  @override
  State<StockTradeFlowScreen> createState() => _StockTradeFlowScreenState();
}

class _StockTradeFlowScreenState extends State<StockTradeFlowScreen> {
  final TextEditingController _symbolController = TextEditingController();

  Stock? _stock;
  late OrderSide _initialSide;
  String? _investCollectionId;
  bool _loadingSymbol = false;

  InvestAssetHubConfig get _hub =>
      InvestAssetHubConfig.forCollectionId(_investCollectionId);

  @override
  void initState() {
    super.initState();
    _parseArgs();
  }

  void _parseArgs() {
    _initialSide = OrderSide.buy;
    final raw = Get.arguments;
    if (raw is! Map) return;

    final s = raw['stock'];
    if (s is Stock) _stock = s;

    _investCollectionId = raw['investCollection'] as String?;

    if (raw['isBuy'] == true) {
      _initialSide = OrderSide.buy;
    } else if (raw['isBuy'] == false) {
      _initialSide = OrderSide.sell;
    }

    final tt = raw['tradeType'] as String?;
    if (tt == 'sell') _initialSide = OrderSide.sell;
    if (tt == 'buy') _initialSide = OrderSide.buy;
  }

  @override
  void dispose() {
    _symbolController.dispose();
    super.dispose();
  }

  void _onLookupSymbol() {
    final symbol = _symbolController.text.trim().toUpperCase();
    if (symbol.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a ticker symbol')),
      );
      return;
    }
    setState(() => _loadingSymbol = true);
    context.read<StockCubit>().loadStockDetails(symbol);
  }

  @override
  Widget build(BuildContext context) {
    final accent = _hub.accentColor;

    return BlocListener<StockCubit, StockState>(
      listenWhen: (prev, next) =>
          _stock == null &&
          (next is StockDetailsLoaded || next is StockDetailsError),
      listener: (context, state) {
        if (state is StockDetailsLoaded) {
          setState(() {
            _stock = state.stock;
            _loadingSymbol = false;
          });
        } else if (state is StockDetailsError) {
          setState(() => _loadingSymbol = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: _stock != null
          ? CreateStockTradeCarousel(
              stock: _stock!,
              initialSide: _initialSide,
              investCollectionId: _investCollectionId,
            )
          : Scaffold(
              backgroundColor: InvestTradingUi.background,
              body: DecoratedBox(
                decoration: BoxDecoration(gradient: InvestTradingUi.scaffoldGradient),
                child: SafeArea(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => Get.back(),
                                  icon: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: InvestTradingUi.textPrimary,
                                    size: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'TRADE',
                              style: InvestTradingUi.eyebrow(accent),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Pick an instrument',
                              style: GoogleFonts.inter(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800,
                                color: InvestTradingUi.textPrimary,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Enter a ticker to load live quotes, then continue to size and confirm your order.',
                              style: InvestTradingUi.labelMuted(),
                            ),
                            SizedBox(height: 28.h),
                            TextField(
                              controller: _symbolController,
                              textCapitalization: TextCapitalization.characters,
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: InvestTradingUi.textPrimary,
                                letterSpacing: 1.2,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[A-Za-z0-9.\-]'),
                                ),
                              ],
                              decoration: InvestTradingUi.tradingInputDecoration(
                                hintText: 'e.g. AAPL',
                                accentColor: accent,
                              ),
                              onSubmitted: (_) => _onLookupSymbol(),
                            ),
                            SizedBox(height: 20.h),
                            FilledButton(
                              onPressed: _loadingSymbol ? null : _onLookupSymbol,
                              style: FilledButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                backgroundColor: accent,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor:
                                    accent.withValues(alpha: 0.4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                              child: Text(
                                'Continue',
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_loadingSymbol)
                        const ColoredBox(
                          color: Color(0x66000000),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
