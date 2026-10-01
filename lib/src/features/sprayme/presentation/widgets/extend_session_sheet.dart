import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/services/active_account_snapshot.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_clock.dart';
import 'package:lazervault/src/features/sprayme/domain/repositories/i_sprayme_repository.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

/// Buying a live session more time.
///
/// Opened when the clock runs low, from the countdown chip, or from the
/// warning banner — three ways in, because the one moment a host needs this
/// is the one moment they are least able to go looking for it.
///
/// WHAT THE SHEET SENDS
/// --------------------
/// The chosen block and the account to charge. NOT the price: the server
/// resolves that from the same table these buttons were rendered from, so a
/// stale app or a tampered request cannot name its own amount.
///
/// IDEMPOTENCY IS MINTED ONCE PER SHEET, NOT PER TAP.
/// A host on a Nigerian mobile connection whose request times out will press
/// the button again. Reusing the key makes the second attempt return the first
/// purchase; minting a fresh one per tap would buy two half hours. The key is
/// only rotated after a confirmed SUCCESS, when the next purchase is genuinely
/// a different one.
Future<bool?> showExtendSessionSheet(
  BuildContext context, {
  required String sessionId,
  required SessionClockPolicy policy,
  required Duration? remaining,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => ExtendSessionSheet(
      sessionId: sessionId,
      policy: policy,
      remaining: remaining,
    ),
  );
}

class ExtendSessionSheet extends StatefulWidget {
  final String sessionId;
  final SessionClockPolicy policy;
  final Duration? remaining;

  const ExtendSessionSheet({
    super.key,
    required this.sessionId,
    required this.policy,
    required this.remaining,
  });

  @override
  State<ExtendSessionSheet> createState() => _ExtendSessionSheetState();
}

class _ExtendSessionSheetState extends State<ExtendSessionSheet>
    with TransactionPinMixin<ExtendSessionSheet> {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  static const _accent = Color(0xFF7C3AED);

  ActiveAccountSnapshot? _account;
  int? _selectedMinutes;
  bool _busy = false;
  String? _error;

  /// One key for the life of this sheet — see the class comment.
  String _idempotencyKey = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    _account = activeAccountSnapshot();
    // Pre-select the shorter block. A host deciding under time pressure
    // should be one tap from the cheapest option, not from the dearest.
    final opts = widget.policy.options;
    if (opts.isNotEmpty) {
      _selectedMinutes =
          opts.map((o) => o.minutes).reduce((a, b) => a < b ? a : b);
    }
  }

  SessionExtensionOption? get _selected {
    for (final o in widget.policy.options) {
      if (o.minutes == _selectedMinutes) return o;
    }
    return null;
  }

  bool get _canAfford {
    final a = _account, o = _selected;
    if (a == null || o == null) return false;
    return a.covers(o.priceMajor);
  }

  Future<void> _buy() async {
    final opt = _selected;
    final acct = _account;
    if (opt == null || acct == null || _busy) return;

    if (!acct.isSpendable || acct.isProvisioning) {
      setState(() => _error = acct.isProvisioning
          ? 'That wallet is still being set up — try again shortly.'
          : 'That account is frozen, so it cannot be charged.');
      return;
    }
    if (!_canAfford) {
      setState(() => _error =
          'You need ${acct.currency} ${(opt.priceMajor - acct.balanceMajor).toStringAsFixed(0)} '
          'more in ${acct.display}.');
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });
    HapticFeedback.mediumImpact();

    // The transaction id is the SOURCE ACCOUNT, matching every other sprayme
    // money path: sprayme-service re-validates the minted token against the
    // account it is about to debit, and a token bound to anything else is
    // rejected as a PIN failure the user cannot act on.
    final ok = await validateTransactionPin(
      context: context,
      transactionId: acct.id,
      transactionType: 'spray_session_extend',
      amount: opt.priceMajor,
      currency: acct.currency,
      title: 'Extend session',
      message:
          'Add ${opt.minutes} minutes to this session for ${acct.currency} ${opt.priceMajor.toStringAsFixed(0)}',
      successMessage: 'Session extended',
      onPinValidated: (_) async {
        await serviceLocator<ISprayMeRepository>().extendSession(
          widget.sessionId,
          minutes: opt.minutes,
          sourceAccountId: acct.id,
          idempotencyKey: _idempotencyKey,
        );
      },
    );

    if (!mounted) return;
    if (ok) {
      // Only now is the purchase definitely a different one from the next.
      _idempotencyKey = const Uuid().v4();
      Navigator.of(context).pop(true);
      return;
    }
    setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final remaining = widget.remaining;
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3A),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Icon(Icons.more_time_rounded, color: _accent, size: 22.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text('Keep the session going',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                remaining == null
                    ? 'Add time to this session.'
                    : 'This session ends in ${formatCountdown(remaining)}. '
                        'Everyone stays in the room and nothing is lost.',
                style:
                    TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
              ),
              SizedBox(height: 16.h),

              if (widget.policy.options.isEmpty)
                _noOptions()
              else
                ...widget.policy.options.map(_optionTile),

              SizedBox(height: 14.h),
              _accountRow(),
              if (_error != null) ...[
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline,
                        size: 14.sp, color: const Color(0xFFEF4444)),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(_error!,
                          style: TextStyle(
                              color: const Color(0xFFFCA5A5), fontSize: 12.sp)),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 18.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed:
                      (_busy || _selected == null) ? null : _buy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    disabledBackgroundColor: _accent.withValues(alpha: 0.35),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: _busy
                      ? LazerVaultLoader.small()
                      : Text(
                          _selected == null
                              ? 'Choose how much time'
                              : 'Add ${_selected!.minutes} minutes · '
                                  '${_account?.currency ?? 'NGN'} ${_selected!.priceMajor.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w700),
                        ),
                ),
              ),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'Charged to your personal account. '
                  'A session can run for up to ${widget.policy.maxTotalHours} hours in total.',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: const Color(0xFF6B7280), fontSize: 11.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionTile(SessionExtensionOption o) {
    final picked = o.minutes == _selectedMinutes;
    final currency = _account?.currency ?? 'NGN';
    // Per-minute cost, so a host can see at a glance that the longer block is
    // the better deal rather than having to work it out under time pressure.
    final perMinute = o.minutes > 0 ? o.priceMajor / o.minutes : 0.0;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        onTap: () => setState(() {
          _selectedMinutes = o.minutes;
          _error = null;
        }),
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: picked
                ? _accent.withValues(alpha: 0.12)
                : const Color(0xFF161616),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: picked ? _accent : const Color(0xFF2D2D2D),
              width: picked ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                picked
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: picked ? _accent : const Color(0xFF4B5563),
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(o.label.isNotEmpty ? o.label : '${o.minutes} minutes',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 2.h),
                    Text(
                        '$currency ${perMinute.toStringAsFixed(2)} a minute',
                        style: TextStyle(
                            color: const Color(0xFF6B7280), fontSize: 11.sp)),
                  ],
                ),
              ),
              Text('$currency ${o.priceMajor.toStringAsFixed(0)}',
                  style: TextStyle(
                      color: picked ? Colors.white : const Color(0xFF9CA3AF),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }

  /// Nothing on sale. Says so plainly rather than showing an empty list with
  /// a dead button under it.
  Widget _noOptions() => Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Text(
          'There are no extensions available right now. The session will end '
          'when the time runs out — you can start a new one straight away.',
          style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 12.5.sp),
        ),
      );

  Widget _accountRow() {
    final a = _account;
    final short = a != null && _selected != null && !_canAfford;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: short ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_wallet_outlined,
              color: const Color(0xFF9CA3AF), size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Paying from',
                    style: TextStyle(
                        color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                SizedBox(height: 2.h),
                Text(a?.display ?? 'No account selected',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          if (a != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('${a.currency} ${a.balanceMajor.toStringAsFixed(0)}',
                    style: TextStyle(
                        color:
                            short ? const Color(0xFFEF4444) : Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700)),
                if (short)
                  // The dead end this avoids: being told the balance is short
                  // and given nowhere to fix it, during the two minutes
                  // before the session ends.
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(false);
                      Navigator.of(context)
                          .pushNamed(AppRoutes.depositMethodSelection);
                    },
                    child: Text('Add money',
                        style: TextStyle(
                            color: const Color(0xFF3B82F6),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
