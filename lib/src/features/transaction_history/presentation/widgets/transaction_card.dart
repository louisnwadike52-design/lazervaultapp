import 'package:flutter/material.dart';
import 'package:lazervault/src/features/crypto_pay/domain/payment_method_breakdown.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/transaction_history/presentation/widgets/transaction_avatar.dart';

/// Revolut-style transaction row — no card borders, clean minimal layout
class TransactionCard extends StatelessWidget {
  final UnifiedTransaction transaction;
  final VoidCallback? onTap;
  final bool showServiceIcon;

  const TransactionCard({
    super.key,
    required this.transaction,
    this.onTap,
    this.showServiceIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            if (showServiceIcon) ...[
              _buildIcon(),
              SizedBox(width: 14.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    transaction.title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // A SUBTITLE THAT REPEATS THE TITLE IS NOT A SUBTITLE.
                  //
                  // Rows read "Transfer to GRACE C. ONWUA…" over "Transfer to
                  // GRACE C. ONWUANAKU" — the same sentence twice, the top one
                  // truncated, so the second line's only contribution was the
                  // ending the first line had cut off. Dropping it gives the
                  // title the full width and the row one statement.
                  // PAID WITH CRYPTO, said on the row itself.
                  //
                  // A customer scrolling for "the one I paid with USDT" has
                  // nothing to scan for otherwise — the row looks identical
                  // to every wallet payment, and the split is two taps away
                  // on the receipt. Rendered INSTEAD of the subtitle when
                  // both would show, because the row has one second line and
                  // which balance paid is the rarer, more useful fact.
                  if (_fundingBadge() != null) ...[
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.currency_bitcoin,
                            size: 12.sp, color: const Color(0xFFA78BFA)),
                        SizedBox(width: 3.w),
                        Flexible(
                          child: Text(
                            _fundingBadge()!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFA78BFA),
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ] else if (_subtitle() != null) ...[
                    SizedBox(height: 3.h),
                    Text(
                      _subtitle()!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8E8E93),
                        fontFamily: 'Inter',
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatAmount(),
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: _amountColor(),
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_statusLabel() != null) ...[
                      Text(
                        _statusLabel()!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: _statusColor(),
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      _formatTime(transaction.createdAt),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF8E8E93),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Status label shown next to the time for any NON-completed transaction so
  /// the user always sees what happened — e.g. a failed external transfer that
  /// reached the provider but was declined. Completed transactions stay clean
  /// (the amount colour already conveys success).
  String? _statusLabel() {
    switch (transaction.status) {
      case UnifiedTransactionStatus.pending:
        return 'Pending';
      case UnifiedTransactionStatus.processing:
        return 'Processing';
      case UnifiedTransactionStatus.failed:
        return 'Failed';
      case UnifiedTransactionStatus.cancelled:
        return 'Cancelled';
      case UnifiedTransactionStatus.refunded:
        return 'Refunded';
      case UnifiedTransactionStatus.expired:
        return 'Expired';
      case UnifiedTransactionStatus.scheduled:
        return 'Scheduled';
      default:
        return null; // completed — clean, just the time
    }
  }

  Color _statusColor() {
    switch (transaction.status) {
      case UnifiedTransactionStatus.failed:
      case UnifiedTransactionStatus.cancelled:
      case UnifiedTransactionStatus.expired:
        return const Color(0xFFEF4444); // red
      case UnifiedTransactionStatus.refunded:
      case UnifiedTransactionStatus.scheduled:
        return const Color(0xFF8B5CF6); // purple/violet (refunded, scheduled)
      default:
        return const Color(0xFFF59E0B); // amber (pending / processing)
    }
  }

  /// The avatar and its direction pip, from the shared widget.
  ///
  /// This used to be two private methods here, which is why the dashboard's
  /// first five rows showed a generic glyph and no direction: the logic was
  /// reachable only from this file. The ring is this page's own ground.
  Widget _buildIcon() => TransactionAvatar(
        transaction: transaction,
        ringColor: const Color(0xFF0A0A0A),
      );

  /// "Paid with USDT", when this payment was funded by a coin.
  ///
  /// Null for every ordinary payment, which is almost all of them — the
  /// breakdown reads itself off the record and refuses to exist without a
  /// declared funding source, so there is no condition to write here.
  String? _fundingBadge() =>
      breakdownBadge(PaymentMethodBreakdown.from(transaction.metadata));

  /// The second line, when it says something the first does not.
  ///
  /// Compared on a normalised form so "Transfer to GRACE C. ONWUANAKU" is
  /// recognised as the same statement as the title even when the title has
  /// been ellipsised, and so trailing punctuation or case cannot smuggle a
  /// duplicate through.
  String? _subtitle() {
    final d = transaction.description?.trim();
    if (d == null || d.isEmpty) return null;
    String norm(String v) =>
        v.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    final title = norm(transaction.title);
    final sub = norm(d);
    if (sub == title) return null;
    // Also drop the case where one is a prefix of the other, which is what an
    // ellipsised title produces.
    if (title.isNotEmpty && sub.startsWith(title)) return null;
    if (sub.isNotEmpty && title.startsWith(sub)) return null;
    return d;
  }

  String _formatAmount() {
    // Crypto-denominated rows (swap/send) pre-format their display \u2014 never
    // "\u20A60.00". A swap's full legs are too wide for this trailing column, so
    // show the received leg; the subtitle carries the full conversion.
    final override = transaction.amountDisplayOverride;
    if (override != null && override.isNotEmpty) {
      final compact = override.contains('\u2192')
          ? override.split('\u2192').last.trim()
          : override;
      return '${transaction.flow.prefix}$compact';
    }
    final symbol = CountryConfigs.symbolForCurrency(transaction.currency);
    // GROUPED. `toStringAsFixed` alone rendered a six-figure transfer as
    // "₦100023.00" — a number a reader has to count digits on to tell
    // ₦100,023 from ₦10,023. Every other money surface in the app groups;
    // this list, the densest one, did not.
    final amt = NumberFormat('#,##0.00').format(transaction.amount);
    if (transaction.flow == TransactionFlow.incoming) {
      return '+$symbol$amt';
    }
    return '$symbol$amt';
  }

  Color _amountColor() {
    if (transaction.flow == TransactionFlow.incoming) {
      return const Color(0xFF34C759);
    }
    return Colors.white;
  }

  String _formatTime(DateTime date) {
    return DateFormat('h:mm a').format(date);
  }
}

/// Sticky date header for grouped transactions
class TransactionGroup extends StatelessWidget {
  final DateTime date;
  final List<UnifiedTransaction> transactions;
  final Widget Function(UnifiedTransaction transaction)? transactionBuilder;

  const TransactionGroup({
    super.key,
    required this.date,
    required this.transactions,
    this.transactionBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 4.h),
          child: Text(
            _formatGroupDate(date),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8E8E93),
              fontFamily: 'Inter',
            ),
          ),
        ),
        ...List.generate(transactions.length, (index) {
          final transaction = transactions[index];
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: transactionBuilder != null
                    ? transactionBuilder!(transaction)
                    : TransactionCard(transaction: transaction),
              ),
              if (index < transactions.length - 1)
                Padding(
                  padding: EdgeInsets.only(left: 74.w, right: 20.w),
                  child: Divider(
                    color: Colors.white.withValues(alpha: 0.08),
                    height: 1,
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }

  String _formatGroupDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == yesterday) {
      return 'Yesterday';
    } else if (now.difference(date).inDays < 7) {
      return DateFormat('EEEE, d MMM').format(date);
    } else {
      return DateFormat('EEEE, d MMM').format(date);
    }
  }
}

/// Shimmer loading placeholder — Revolut-style
class TransactionCardShimmer extends StatelessWidget {
  const TransactionCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      child: Row(
        children: [
          _shimmer(40.w, 40.w, isCircle: true),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmer(120.w, 14.h),
                SizedBox(height: 6.h),
                _shimmer(80.w, 12.h),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _shimmer(70.w, 14.h),
              SizedBox(height: 6.h),
              _shimmer(50.w, 12.h),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shimmer(double width, double height, {bool isCircle = false}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: isCircle ? null : BorderRadius.circular(4.r),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
    );
  }
}
