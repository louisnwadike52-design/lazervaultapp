import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';

/// A compact, non-cluttering row that shows the user's LazerVault FIAT wallet
/// balance for the active currency. Reused across the crypto Sell / Swap / Send
/// surfaces (Buy already renders its own pay-from card). It reads the app-global
/// [AccountCardsSummaryCubit] (provided above the navigator in main.dart) — never
/// via GetIt, which would hand back an empty factory instance.
///
/// [caption] lets each surface label the balance honestly (e.g. "Proceeds land
/// here" for Sell, "Your wallet balance" for Swap/Send where the trade doesn't
/// touch fiat). Hides itself when no matching personal account is found.
class CryptoFiatWalletPill extends StatelessWidget {
  const CryptoFiatWalletPill({super.key, this.caption, this.compact = false});

  final String? caption;

  /// Compact mode renders a small right-alignable chip (wallet icon + balance)
  /// instead of the full-width card — used beside the network badge on the
  /// Send screen so the balance doesn't cost its own row.
  final bool compact;

  static AccountSummaryEntity? _personal(AccountCardsSummaryState state) {
    final accounts = switch (state) {
      AccountCardsSummaryLoaded(:final accountSummaries) => accountSummaries,
      AccountBalanceUpdated(:final accountSummaries) => accountSummaries,
      _ => const <AccountSummaryEntity>[],
    };
    final ccy = CurrencySymbols.currentCurrency.toUpperCase();
    for (final a in accounts) {
      if (a.isPersonalAccount && a.currency.toUpperCase() == ccy) return a;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        final personal = _personal(state);
        if (personal == null) return const SizedBox.shrink();
        final sym = CurrencySymbols.currentSymbol;
        final bal = personal.availableBalance;
        // Name the ACTUAL account ("Personal account"), matching the buy
        // sheet's pay-from card; brand casing is "Lazervault", never PascalCase.
        String label = 'Lazervault Wallet';
        final t = personal.accountType.trim();
        if (t.isNotEmpty) {
          label = '${t[0].toUpperCase()}${t.substring(1).toLowerCase()} account';
        }
        if (compact) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.account_balance_wallet,
                    color: const Color(0xFF9F7AEA), size: 14.sp),
                SizedBox(width: 6.w),
                Text('$sym${_formatMoney(bal)}',
                    style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
              ],
            ),
          );
        }
        return Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            children: [
              Icon(Icons.account_balance_wallet,
                  color: const Color(0xFF9F7AEA), size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label,
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    if (caption != null) ...[
                      SizedBox(height: 2.h),
                      Text(caption!,
                          style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              color: Colors.white.withValues(alpha: 0.5))),
                    ],
                  ],
                ),
              ),
              Text('$sym${_formatMoney(bal)}',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ],
          ),
        );
      },
    );
  }

  static String _formatMoney(double v) {
    final s = v.toStringAsFixed(2);
    final parts = s.split('.');
    final whole = parts[0];
    final buf = StringBuffer();
    for (var i = 0; i < whole.length; i++) {
      if (i > 0 && (whole.length - i) % 3 == 0) buf.write(',');
      buf.write(whole[i]);
    }
    return '$buf.${parts[1]}';
  }
}
