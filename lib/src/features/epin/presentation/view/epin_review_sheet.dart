import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import '../cubit/epin_state.dart';
import 'epin_theme.dart';

/// Review + confirm step for a recharge-card purchase, presented as a bottom
/// sheet. It shows the dashboard's ACTIVE account as a read-only, locked tile
/// (no picker) — the order is always paid from whatever the user has selected
/// on the dashboard. When the active account can't fund the order (missing /
/// not NGN / insufficient) the sheet blocks with an inline message instead of
/// letting the purchase proceed.
///
/// [account] is the resolved active account (from AccountManager.activeAccountId
/// matched against the account summaries) — the caller resolves it so the sheet
/// stays a simple, synchronous view. Returns the confirmed source account id
/// when the user confirms, or null when the sheet is dismissed.
Future<String?> showEpinReviewSheet(
  BuildContext context, {
  required EPinNetwork network,
  required EPinDenomination denomination,
  required int quantity,
  required double total,
  required AccountSummaryEntity? account,
  String businessName = '',
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _EpinReviewSheet(
      network: network,
      denomination: denomination,
      quantity: quantity,
      total: total,
      account: account,
      businessName: businessName,
    ),
  );
}

class _EpinReviewSheet extends StatelessWidget {
  const _EpinReviewSheet({
    required this.network,
    required this.denomination,
    required this.quantity,
    required this.total,
    required this.account,
    required this.businessName,
  });

  final EPinNetwork network;
  final EPinDenomination denomination;
  final int quantity;
  final double total;
  final AccountSummaryEntity? account;
  final String businessName;

  static const _card = EpinTheme.card;
  static const _divider = EpinTheme.divider;
  static const _primary = EpinTheme.primary;
  static const _error = EpinTheme.error;
  static const _textSecondary = EpinTheme.textSecondary;

  String _titleCase(String s) => s.isEmpty
      ? s
      : s
          .split(RegExp(r'[\s_]+'))
          .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
          .join(' ');

  @override
  Widget build(BuildContext context) {
    final acct = account;
    // Recharge-card PINs are a Nigerian (NGN) product, so the funding account
    // must be an NGN account with enough spendable balance.
    String? blockMessage;
    if (acct == null) {
      blockMessage =
          'No active account selected. Choose an account on the dashboard first.';
    } else if (acct.currency.toUpperCase() != 'NGN') {
      blockMessage =
          'Your active account is ${acct.currency.toUpperCase()}. Switch to an NGN account on the dashboard to buy recharge cards.';
    } else if (acct.availableBalance < total) {
      blockMessage =
          'Insufficient balance. You need ₦${total.toStringAsFixed(0)} but this account has ₦${acct.availableBalance.toStringAsFixed(2)}.';
    }
    final canConfirm = blockMessage == null && acct != null;

    return Container(
      decoration: BoxDecoration(
        color: EpinTheme.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: _divider,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Review order',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Confirm your recharge card order',
                style: TextStyle(fontSize: 13.sp, color: _textSecondary),
              ),
              SizedBox(height: 16.h),
              _detailsCard(),
              SizedBox(height: 12.h),
              _totalHero(),
              SizedBox(height: 12.h),
              _readOnlyTile(
                icon: Icons.account_balance_wallet,
                label: 'Pay from',
                value: acct == null
                    ? 'No active account'
                    : '${_titleCase(acct.accountType)} · ••${acct.accountNumberLast4}',
                sub: acct == null
                    ? null
                    : 'Balance ${acct.currency.toUpperCase()} ${acct.availableBalance.toStringAsFixed(2)}',
                danger: !canConfirm,
              ),
              if (blockMessage != null) ...[
                SizedBox(height: 12.h),
                _blockBanner(blockMessage),
              ],
              SizedBox(height: 18.h),
              SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: canConfirm
                      // Return the SPENDABLE account id — equals the account id
                      // for normal accounts, and the family virtual-pool id for
                      // family accounts (what the payments path debits).
                      ? () => Navigator.of(context).pop(acct.spendingAccountId)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    disabledBackgroundColor: _primary.withValues(alpha: 0.3),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white.withValues(alpha: 0.6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Confirm payment',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          _row('Network', network.name),
          SizedBox(height: 10.h),
          _row('Denomination', '₦${denomination.amount.toStringAsFixed(0)}'),
          SizedBox(height: 10.h),
          _row('Quantity', '$quantity'),
          if (businessName.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _row('Business name', businessName),
          ],
        ],
      ),
    );
  }

  Widget _totalHero() {
    return EpinGradientCard(
      padding: EdgeInsets.all(18.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total to pay',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 14.sp,
            ),
          ),
          Text(
            '₦${total.toStringAsFixed(0)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _readOnlyTile({
    required IconData icon,
    required String label,
    required String value,
    String? sub,
    bool danger = false,
  }) {
    final accent = danger ? _error : _primary;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: danger ? _error.withValues(alpha: 0.4) : _divider),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: accent, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        TextStyle(color: _textSecondary, fontSize: 11.sp)),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                ),
                if (sub != null)
                  Text(sub,
                      style: TextStyle(
                          color: _textSecondary, fontSize: 11.sp)),
              ],
            ),
          ),
          Icon(Icons.lock, size: 14.sp, color: _textSecondary),
        ],
      ),
    );
  }

  Widget _blockBanner(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: _error, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: _error, fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
