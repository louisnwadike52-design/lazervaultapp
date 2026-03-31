import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/investments/presentation/navigation/invest_route_args.dart';
import 'package:lazervault/src/features/investments/presentation/theme/invest_trading_ui.dart';

/// Confirms portfolio cash operations (add / withdraw / rebalance fees).
/// Stock equity trades use [StockTradeFlowScreen] → carousel → [StockTradeReviewScreen].
class StockTradePaymentScreen extends StatefulWidget {
  const StockTradePaymentScreen({super.key});

  @override
  State<StockTradePaymentScreen> createState() =>
      _StockTradePaymentScreenState();
}

class _StockTradePaymentScreenState extends State<StockTradePaymentScreen> {
  late final Map<String, dynamic> _args;

  @override
  void initState() {
    super.initState();
    _args = Get.arguments is Map<String, dynamic>
        ? Map<String, dynamic>.from(Get.arguments as Map)
        : {};
  }

  String get _type => (_args['type'] as String?) ?? 'payment';
  double get _amount => (_args['amount'] as num?)?.toDouble() ?? 0;
  double get _fee => (_args['fee'] as num?)?.toDouble() ?? 0;
  double get _total => (_args['total'] as num?)?.toDouble() ?? 0;
  String get _paymentMethod =>
      (_args['paymentMethod'] as String?) ?? '—';
  String get _description =>
      (_args['description'] as String?) ?? 'Portfolio operation';

  String get _title {
    switch (_type) {
      case 'add_funds':
        return 'Add funds';
      case 'withdraw_funds':
        return 'Withdraw';
      case 'rebalance_portfolio':
        return 'Rebalance';
      default:
        return 'Confirm';
    }
  }

  @override
  Widget build(BuildContext context) {
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
          _title,
          style: GoogleFonts.inter(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            color: InvestTradingUi.textPrimary,
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(gradient: InvestTradingUi.scaffoldGradient),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: InvestTradingUi.statementCardDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _description,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: InvestTradingUi.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _row('Amount', '\$${_amount.toStringAsFixed(2)}'),
                    _row('Fee', '\$${_fee.toStringAsFixed(2)}'),
                    _row('Total', '\$${_total.toStringAsFixed(2)}',
                        emphasize: true),
                    SizedBox(height: 12.h),
                    _row('Method', _paymentMethod),
                  ],
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Get.back();
                    return;
                  }
                  final hub = InvestRouteArgs.parseHub(_args);
                  Get.offAllNamed(
                    AppRoutes.stockPortfolio,
                    arguments: InvestRouteArgs.hub(hub),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: InvestTradingUi.buy,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'Done',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool emphasize = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: InvestTradingUi.textSecondary,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: emphasize ? 16.sp : 14.sp,
              fontWeight: emphasize ? FontWeight.w800 : FontWeight.w600,
              color: InvestTradingUi.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
