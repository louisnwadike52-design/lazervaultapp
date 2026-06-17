import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import 'airtime_history_actions_sheet.dart';

/// Scope keys used to filter transactions on both the landing-page card
/// and the history screen's pill filter.
class AirtimeScope {
  static const String all = 'all';
  static const String buy = 'buy';
  static const String intl = 'intl';
  static const String sell = 'sell';

  static bool match(AirtimeTransaction t, String scope) {
    switch (scope) {
      case all:
        return true;
      case intl:
        return t.isInternational;
      case sell:
        return t.isAirtimeToCash;
      case buy:
      default:
        return !t.isInternational && !t.isAirtimeToCash;
    }
  }
}

/// Landing-page "Recent Transactions" strip.
///
/// Renders the three most recent in-scope transactions using the SAME
/// [BillHistoryItem] widget every utility uses — airtime, data bundles,
/// electricity, internet. One source of truth for history rows, no
/// visual drift between utilities. Landing strip shows a relative
/// "2h ago" date; the full history list shows an absolute date.
class RecentTransactionsCard extends StatelessWidget {
  final String scope;
  final Color accent;

  const RecentTransactionsCard({
    super.key,
    this.scope = AirtimeScope.buy,
    this.accent = const Color(0xFF4E03D0),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AirtimeCubit, AirtimeState>(
      buildWhen: (previous, current) {
        return current is AirtimeTransactionHistoryLoaded ||
            current is AirtimeTransactionHistoryLoading ||
            current is AirtimeInitial ||
            (current is AirtimeError &&
                previous is AirtimeTransactionHistoryLoading);
      },
      builder: (context, state) {
        final items = state is AirtimeTransactionHistoryLoaded
            ? state.transactions
                .where((t) => AirtimeScope.match(t, scope))
                .take(3)
                .toList()
            : const <AirtimeTransaction>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            SizedBox(height: 12.h),
            if (state is AirtimeTransactionHistoryLoading ||
                state is AirtimeInitial)
              _loading()
            else if (state is AirtimeError)
              _error(context)
            else if (items.isEmpty)
              _empty()
            else
              Column(
                children: [
                  for (var i = 0; i < items.length; i++) ...[
                    _row(context, items[i]),
                    if (i != items.length - 1) SizedBox(height: 10.h),
                  ],
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _row(BuildContext context, AirtimeTransaction t) {
    return BillHistoryItem(
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: t.networkProvider.color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            t.networkProvider.displayName.isNotEmpty
                ? t.networkProvider.displayName.substring(0, 1)
                : '?',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: t.displayTitle,
      subtitle: t.displayRecipientNumber,
      date: _relativeTime(t.createdAt),
      amount: t.amount,
      currencySymbol: t.currencySymbol,
      status: t.status.name,
      refundSource: _refundSourceFor(t),
      onTap: () => AirtimeHistoryActionsSheet.show(context, t),
    );
  }

  String? _refundSourceFor(AirtimeTransaction t) {
    final meta = t.metadata;
    if (meta == null) return null;
    final v = meta['refund_source'] ?? meta['refundSource'];
    if (v is String && v.isNotEmpty) return v;
    return null;
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Transactions',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed(
            AppRoutes.airtimeHistory,
            arguments: {'scope': scope},
          ),
          child: Text(
            'View All',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: accent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _loading() {
    return Column(
      children: List.generate(3, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i == 2 ? 0 : 10.h),
          child: Container(
            height: 64.h,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
          ),
        );
      }),
    );
  }

  Widget _empty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history,
                size: 44.sp, color: Colors.white.withValues(alpha: 0.3)),
            SizedBox(height: 10.h),
            Text(
              'No transactions yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              _emptySubtitle(),
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _error(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Column(
        children: [
          Text(
            'Failed to load transactions',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 6.h),
          GestureDetector(
            onTap: () {
              final userId =
                  context.read<AuthenticationCubit>().userId ?? '';
              context.read<AirtimeCubit>().loadTransactionHistory(userId);
            },
            child: Text(
              'Tap to retry',
              style: GoogleFonts.inter(
                color: accent,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _emptySubtitle() {
    switch (scope) {
      case AirtimeScope.intl:
        return 'Your international airtime purchases will appear here';
      case AirtimeScope.sell:
        return 'Airtime-to-cash conversions will appear here';
      case AirtimeScope.buy:
      default:
        return 'Your airtime purchases will appear here';
    }
  }
}

/// "1h ago" / "2d ago" / `MMM dd` helper for the landing-strip date line.
/// Matches the equivalent helper on the data-bundle landing so every
/// utility's recent-items strip reads the same.
String _relativeTime(DateTime dt) {
  final diff = DateTime.now().difference(dt);
  if (diff.isNegative || diff.inSeconds < 60) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  if (diff.inDays < 7) return '${diff.inDays}d ago';
  return DateFormat('MMM dd').format(dt);
}
