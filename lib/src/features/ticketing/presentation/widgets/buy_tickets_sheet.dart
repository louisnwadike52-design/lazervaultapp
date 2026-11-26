import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/active_account_snapshot.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;
import 'package:uuid/uuid.dart';

import '../../data/ticketing_errors.dart';
import '../../data/ticketing_repository.dart';
import '../cubit/ticketing_cubit.dart';
import '../cubit/ticketing_state.dart';
import 'ticket_money.dart';
import 'ticketing_theme.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// Opens the buy sheet for [detail].
Future<void> showBuyTicketsSheet(
    BuildContext context, TicketEventDetail detail) {
  return showAppBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => BlocProvider.value(
      value: context.read<TicketingCubit>(),
      child: _BuyTicketsSheet(detail: detail),
    ),
  );
}

/// HOW MANY, THEN THE PIN.
///
/// THE IDEMPOTENCY KEY IS MINTED ONCE, WHEN THE SHEET OPENS, and reused for
/// every attempt from it. That is the whole reason it is held in the State and
/// not generated at the call: a key minted per attempt is the same as having
/// none, so a double tap or a transport retry becomes a second charge. The
/// server returns the ORIGINAL order for a repeated key, which is what makes
/// retrying a timeout safe here.
class _BuyTicketsSheet extends StatefulWidget {
  const _BuyTicketsSheet({required this.detail});
  final TicketEventDetail detail;

  @override
  State<_BuyTicketsSheet> createState() => _BuyTicketsSheetState();
}

class _BuyTicketsSheetState extends State<_BuyTicketsSheet>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  /// Minted ONCE per sheet. See the class note.
  final String _idempotencyKey = 'tkt-${const Uuid().v4()}';

  int _qty = 1;
  bool _busy = false;

  tk.TicketEvent get _event => widget.detail.event;

  int get _totalMinor => widget.detail.buyerTotalPerTicketMinor * _qty;

  /// The ceiling the buyer can actually choose.
  ///
  /// Only what the SERVER has told us: the remaining capacity. The per-buyer
  /// limit is an admin setting the app does not read, so it is left to the
  /// server to refuse — and `ticketError` turns that refusal into
  /// "that is more tickets than one person can hold", which is a sentence the
  /// buyer can act on. Guessing the limit here would mean a number that drifts
  /// the moment an operator changes it.
  int get _maxQty {
    if (!_event.hasCapacity()) return 20;
    final left = _event.remaining;
    return left <= 0 ? 0 : (left > 20 ? 20 : left);
  }

  Future<void> _buy() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      // THE ACCOUNT IS RESOLVED WITH THE ASYNC HELPER. The synchronous one
      // answers null whenever the account-cards cubit has not loaded, which is
      // an accident of how the user navigated here — the note on
      // ensureActiveAccountSnapshot records a sheet reported stuck on "no
      // account selected" for exactly that reason.
      final account = await ensureActiveAccountSnapshot();
      if (!mounted) return;
      if (account == null) {
        await showServerRefusal(
          context,
          title: 'No account available',
          message: 'We could not find an account to pay from. Open your '
              'dashboard once and try again.',
          tone: ServerRefusalTone.failure,
        );
        return;
      }

      // THE CURRENCIES HAVE TO MATCH, AND THIS IS CHECKED BEFORE THE PIN.
      //
      // The funding account is whichever one the dashboard has active, and its
      // currency is its own — so a holder whose active wallet is USD buying an
      // NGN ticket was charged nothing and told "something went wrong", AFTER
      // entering their PIN. accounts-service refuses the debit with
      // "currency mismatch: account is X, request is Y", which is correct and
      // unreadable; and by the time it arrives the buyer has been asked to
      // authorise a payment that could never have completed.
      //
      // Refused here, naming both currencies, so the fix — switch the card on
      // the dashboard — is obvious. The server still enforces it: this is the
      // courtesy, not the control.
      final want = _event.currency.trim().toUpperCase();
      final have = account.currency.trim().toUpperCase();
      if (want.isNotEmpty && have.isNotEmpty && want != have) {
        await showServerRefusal(
          context,
          title: 'Wrong wallet for this event',
          message: 'Tickets for this event are priced in $want, and the '
              'account you have selected (${account.display}) holds $have. '
              'Switch to a $want account on your dashboard and come back.',
          tone: ServerRefusalTone.refusal,
        );
        return;
      }

      final repo = serviceLocator<TicketingRepository>();
      tk.BuyTicketsResponse? result;

      await validateTransactionPin(
        context: context,
        transactionId: _idempotencyKey,
        transactionType: 'ticket_purchase',
        // The PIN sheet speaks MAJOR units; the wire stays minor. This is the
        // only conversion on the buy path and it is for display + policy
        // thresholds, not for the charge.
        amount: _totalMinor / 100,
        currency: _event.currency,
        title: 'Buy tickets',
        message: '$_qty × ${_event.title}',
        successMessage: 'Tickets bought',
        onPinValidated: (verificationToken) async {
          // THE TOKEN GOES ON THE WIRE. It used not to, on the reasoning that
          // ticket money moves inside financial-products' own pool transfer
          // rather than out as a payout — but an internal ledger move is still
          // the buyer's money leaving their wallet, and validating the PIN
          // only on the device made it a client-side courtesy: anything
          // holding a session token could have spent it. The server now
          // validates this single-use token against the same idempotency key,
          // so a token minted for one order cannot authorise another, and the
          // PIN itself never leaves the sheet.
          //
          // Throwing from this callback is what keeps a failure INSIDE the PIN
          // sheet, which is where the user is looking.
          result = await repo.buyTickets(
            eventId: _event.id,
            buyerAccountId: account.id,
            quantity: _qty,
            idempotencyKey: _idempotencyKey,
            transactionPinToken: verificationToken,
          );
        },
      );

      if (!mounted) return;
      final purchase = result;
      if (purchase == null) return; // cancelled, wrong PIN, or refused

      // Tell the cubit AFTER the sheet has shown its own outcome, then refresh
      // the event quietly so the sold/remaining counts match what just
      // happened.
      context.read<TicketingCubit>().notePurchase(purchase);
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;
      final refusal = ticketError(e);
      await showServerRefusal(
        context,
        title: 'Not bought',
        message: refusal.message,
        tone: refusal.isRetryable
            ? ServerRefusalTone.failure
            : ServerRefusalTone.refusal,
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final soldOut = _maxQty <= 0;
    return Container(
      decoration: BoxDecoration(
        color: TicketingTheme.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: TicketingTheme.handle,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Text(_event.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          SizedBox(height: 20.h),
          if (!soldOut) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StepButton(
                  icon: Icons.remove,
                  onTap: _qty > 1 ? () => setState(() => _qty--) : null,
                ),
                SizedBox(width: 24.w),
                Text('$_qty',
                    style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                SizedBox(width: 24.w),
                _StepButton(
                  icon: Icons.add,
                  onTap: _qty < _maxQty ? () => setState(() => _qty++) : null,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              _event.hasCapacity()
                  ? '${_event.remaining} left'
                  : 'Up to $_maxQty at a time',
              style: GoogleFonts.inter(
                  fontSize: 12.sp, color: TicketingTheme.textMuted),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: TicketingTheme.border,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Text('Total',
                      style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: TicketingTheme.textSecondary)),
                  const Spacer(),
                  Text(ticketMoney(_totalMinor, _event.currency),
                      style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: TicketingTheme.cta,
                disabledBackgroundColor: TicketingTheme.border,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              onPressed: (soldOut || _busy) ? null : _buy,
              child: _busy
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : Text(soldOut ? 'Sold out' : 'Continue',
                      style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final on = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      // 44px minimum target — the same floor the rating scale uses.
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: TicketingTheme.border,
          shape: BoxShape.circle,
        ),
        child: Icon(icon,
            size: 20.w, color: on ? Colors.white : TicketingTheme.handle),
      ),
    );
  }
}
