import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/business/presentation/receipts/business_receipt.dart';
import '../../../../../core/types/app_routes.dart';
import '../../data/datasources/betting_remote_datasource.dart';
import '../../domain/entities/betting_entities.dart';
import 'betting_theme.dart';

/// Betting funding receipt — confirms the top-up (or its pending status) and
/// routes back to the hub. Funding is usually synchronous, but a `pending`
/// top-up can reconcile via the provider later, so a lightweight manual
/// "Refresh status" (single-shot, no auto-retry loop) is offered while pending.
class BettingReceiptScreen extends StatefulWidget {
  const BettingReceiptScreen({super.key});

  @override
  State<BettingReceiptScreen> createState() => _BettingReceiptScreenState();
}

class _BettingReceiptScreenState extends State<BettingReceiptScreen> {
  static const _bg = BettingTheme.bg;
  static const _card = BettingTheme.card;
  static const _primary = BettingTheme.primary;
  static const _success = BettingTheme.success;
  static const _warning = BettingTheme.warning;
  static const _error = BettingTheme.error;
  static const _textSecondary = BettingTheme.textSecondary;

  BettingFundingResult? _result;
  String _platformName = '';
  String _accountName = '';
  bool _refreshing = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    _result = args?['result'] as BettingFundingResult?;
    _platformName = (args?['platformName'] as String?) ?? '';
    _accountName = (args?['accountName'] as String?) ?? '';
  }

  /// Back / close returns to the Bills Hub landing the service was launched
  /// from — the route is preserved in the stack (not rebuilt), so the
  /// carousel / active account / locale that sit below it are untouched. Falls
  /// back to the root if the Bills Hub isn't in the stack.
  void _exitToBillsHub() {
    Get.until((route) =>
        route.settings.name == AppRoutes.billsHub || route.isFirst);
  }

  /// Single-shot status refresh — re-fetches betting history and swaps in the
  /// row matching this funding's reference/id so a pending top-up that later
  /// reconciled shows its terminal status. Fires only on an explicit tap.
  Future<void> _refreshStatus() async {
    final current = _result;
    if (current == null || _refreshing) return;
    setState(() => _refreshing = true);
    try {
      final history =
          await GetIt.I<BettingRemoteDataSource>().getHistory(limit: 50);
      final ref = current.payment.reference;
      final id = current.payment.id;
      final matches = history.where((r) =>
          (ref.isNotEmpty && r.reference == ref) ||
          (id.isNotEmpty && r.id == id));
      if (!mounted) return;
      if (matches.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No newer status yet. Try again in a moment.'),
            backgroundColor: _warning,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(12.w),
          ),
        );
        return;
      }
      setState(() {
        _result = BettingFundingResult(
          payment: matches.first,
          newBalance: current.newBalance,
          providerReference: current.providerReference,
          message: current.message,
        );
      });
    } catch (_) {
      // Opportunistic — a failed refresh just leaves the current snapshot.
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;
    if (result == null) {
      return const Scaffold(
        backgroundColor: _bg,
        body: Center(
          child: Text('No receipt data', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    final payment = result.payment;
    final pending = payment.isPending;
    final refunded = payment.isRefunded;
    final color = (payment.isFailed || refunded)
        ? _error
        : (pending ? _warning : _success);
    final title = payment.isFailed
        ? 'Funding failed'
        : refunded
            ? 'Funding refunded'
            : (pending ? 'Funding pending' : 'Wallet funded');

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _exitToBillsHub();
      },
      child: Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    Container(
                      width: 88.w,
                      height: 88.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: (!payment.isFailed && !pending)
                            ? BettingTheme.heroGradient
                            : null,
                        color: (!payment.isFailed && !pending)
                            ? null
                            : color.withValues(alpha: 0.15),
                      ),
                      child: Icon(
                        payment.isFailed
                            ? Icons.close
                            : (pending
                                ? Icons.hourglass_bottom
                                : Icons.check),
                        color:
                            (!payment.isFailed && !pending) ? Colors.white : color,
                        size: 44.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      result.message.isNotEmpty
                          ? result.message
                          : (pending
                              ? 'Your funding is being processed'
                              : 'Funds sent to your betting wallet'),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: _textSecondary, fontSize: 13.sp),
                    ),
                    if (pending) ...[
                      SizedBox(height: 12.h),
                      TextButton.icon(
                        onPressed: _refreshing ? null : _refreshStatus,
                        icon: Icon(Icons.refresh, color: _primary, size: 18.sp),
                        label: Text('Refresh status',
                            style: TextStyle(
                                color: _primary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                    SizedBox(height: 28.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: _card,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Column(
                        children: [
                          _row('Platform',
                              _platformName.isNotEmpty ? _platformName : payment.platform),
                          SizedBox(height: 10.h),
                          if (_accountName.isNotEmpty) ...[
                            _row('Account name', _accountName),
                            SizedBox(height: 10.h),
                          ],
                          _row('Account', payment.customerNumber),
                          SizedBox(height: 10.h),
                          _row('Reference', payment.reference),
                          if (result.providerReference.isNotEmpty) ...[
                            SizedBox(height: 10.h),
                            _row('Provider ref', result.providerReference),
                          ],
                          SizedBox(height: 10.h),
                          _row('Status', payment.status),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    BettingGradientCard(
                      padding: EdgeInsets.all(18.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amount funded',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            '₦${payment.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _shareReceipt(
                          context, result, _platformName, _accountName),
                      icon: Icon(Icons.ios_share, color: _primary, size: 18.sp),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: _primary),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      label: Text('Share',
                          style: TextStyle(color: _primary, fontSize: 14.sp)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _exitToBillsHub,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Text('Done',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  /// Build a Revolut-style shareable receipt (same UnifiedTransactionReceipt
  /// used by Send Funds / business receipts) from the betting funding result —
  /// PNG + share sheet, with the Lazervault logo, NGN currency, and the full
  /// betting payload as detail rows.
  void _shareReceipt(BuildContext context, BettingFundingResult result,
      String platformName, String accountName) {
    final payment = result.payment;
    final pending = payment.isPending;
    final refunded = payment.isRefunded;
    final status = payment.isFailed
        ? UnifiedTransactionStatus.failed
        : refunded
            ? UnifiedTransactionStatus.refunded
            : (pending
                ? UnifiedTransactionStatus.processing
                : UnifiedTransactionStatus.completed);
    final platform = platformName.isNotEmpty ? platformName : payment.platform;
    final tx = buildBusinessReceipt(
      type: TransactionServiceType.betting,
      title: payment.isFailed
          ? 'Betting funding failed'
          : refunded
              ? 'Betting funding refunded'
              : (pending ? 'Betting funding pending' : 'Betting wallet funded'),
      amountMajor: payment.amount,
      currency: 'NGN',
      flow: TransactionFlow.outgoing,
      status: status,
      reference: payment.reference,
      counterpartyName: platform,
      description: 'Betting wallet top-up',
      createdAt: DateTime.tryParse(payment.createdAt),
      metadata: {
        'Platform': platform,
        'Betting account': payment.customerNumber,
        if (accountName.isNotEmpty && accountName != payment.customerNumber)
          'Account name': accountName,
        if (result.providerReference.isNotEmpty)
          'Provider ref': result.providerReference,
      },
    );
    showBusinessReceipt(context, tx);
  }

  Widget _row(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 15.sp : 14.sp,
            color: isTotal ? Colors.white : Colors.white.withValues(alpha: 0.6),
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: isTotal ? 16.sp : 14.sp,
              color: Colors.white,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
