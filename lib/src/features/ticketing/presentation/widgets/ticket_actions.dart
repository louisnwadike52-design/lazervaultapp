import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/src/features/recipients/domain/entities/unified_search_result.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import '../cubit/ticketing_cubit.dart';
import 'ticket_money.dart';
import 'ticketing_theme.dart';

/// THE TWO THINGS A HOLDER CAN DO WITH A TICKET THEY NO LONGER WANT.
///
/// Both are behind admin switches that DEFAULT OFF, and the app is told which
/// are on by `ListMyTickets` rather than discovering it from a refusal — the
/// same reasoning that puts `withdrawable` + `withdrawableReason` on the
/// organiser's earnings instead of a button that fails when pressed.
///
/// THEY ARE DELIBERATELY DIFFERENT GESTURES.
///
///   * A REFUND acts on the ORDER, not the ticket. One purchase of four is one
///     order, and refunding it voids all four — so the confirmation says how
///     many, because "refund this ticket" on a four-ticket order is a sentence
///     that misleads about what is about to happen.
///   * A TRANSFER acts on ONE ticket and MOVES NO MONEY. There is no amount,
///     no PIN and no fee: the order, the pool, the commission and the
///     organiser's net are untouched. What it is, is irreversible from the
///     sender's side — which is the thing the confirmation has to say, since
///     nothing else about it feels like a committing action.
///
/// Neither is offered on a ticket that is already used, on a cancelled event
/// (its buyers are being refunded automatically — a manual request would race
/// the sweep), or on an event that has already happened.
class TicketActions extends StatelessWidget {
  const TicketActions({
    super.key,
    required this.ticket,
    required this.refundsEnabled,
    required this.transfersEnabled,
    required this.refundCutoffHours,
    required this.sameOrderCount,
  });

  final tk.MyTicket ticket;
  final bool refundsEnabled;
  final bool transfersEnabled;

  /// Hours before the event that requests close. 0 = until sales close.
  final int refundCutoffHours;

  /// How many admissions the SAME order issued, counted from the list this
  /// screen already holds. Used only to word the confirmation honestly; the
  /// server refunds the whole order either way.
  final int sameOrderCount;

  bool get _used =>
      ticket.status == tk.TicketAdmissionStatus.TICKET_ADMISSION_STATUS_USED;

  bool get _cancelled =>
      ticket.eventStatus == tk.TicketEventStatus.TICKET_EVENT_STATUS_CANCELLED;

  /// A past event is over whatever its status says. The server refuses both
  /// actions on one; this stops the buttons appearing in the first place.
  bool get _past =>
      ticket.hasEventAt() &&
      ticket.eventAt.toDateTime().isBefore(DateTime.now().toUtc());

  @override
  Widget build(BuildContext context) {
    if (_used || _cancelled || _past) return const SizedBox.shrink();
    final canRefund = refundsEnabled;
    final canTransfer = transfersEnabled;
    if (!canRefund && !canTransfer) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(height: 20.h),
        Divider(color: Colors.black12, height: 1.h),
        SizedBox(height: 16.h),
        if (canTransfer)
          _action(
            context,
            icon: Icons.card_giftcard,
            label: 'Give this ticket to someone',
            onTap: () => _transfer(context),
          ),
        if (canTransfer && canRefund) SizedBox(height: 8.h),
        if (canRefund)
          _action(
            context,
            icon: Icons.undo,
            label: sameOrderCount > 1
                // Says what it really does. "Refund this ticket" on a
                // four-ticket order is a sentence that misleads.
                ? 'Refund this order ($sameOrderCount tickets)'
                : 'Refund this ticket',
            destructive: true,
            onTap: () => _refund(context),
          ),
        if (canRefund && refundCutoffHours > 0) ...[
          SizedBox(height: 8.h),
          Text(
            'Refund requests close ${_hours(refundCutoffHours)} before the event.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 11.sp, color: Colors.black45),
          ),
        ],
      ],
    );
  }

  static String _hours(int h) {
    if (h % 24 == 0) {
      final d = h ~/ 24;
      return d == 1 ? '1 day' : '$d days';
    }
    return h == 1 ? '1 hour' : '$h hours';
  }

  Widget _action(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool destructive = false,
  }) {
    // This page is WHITE (see ticket_qr_sheet), so these do not take the
    // feature's dark palette — a dark-on-dark outline here would be invisible.
    final colour = destructive ? TicketingTheme.error : Colors.black87;
    return SizedBox(
      width: double.infinity,
      height: 46.h,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: colour.withValues(alpha: 0.25)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: colour),
        label: Text(label,
            style: GoogleFonts.inter(
                fontSize: 14.sp, fontWeight: FontWeight.w600, color: colour)),
      ),
    );
  }

  Future<void> _transfer(BuildContext context) async {
    // The cubit is captured BEFORE any await: reading it from `context`
    // afterwards is a BuildContext crossing an async gap.
    final cubit = context.read<TicketingCubit>();

    final UnifiedSearchResult? picked = await UnifiedUserSearchSheet.show(
      context,
      title: 'Give this ticket to',
      subtitle: 'They get the ticket. No money changes hands.',
      // LAZERVAULT USERS ONLY. A ticket is handed to a PERSON — a saved bank
      // account is not somebody who can hold one, and offering it here is the
      // same category error the picker's own enum documents.
      mode: RecipientPickerMode.lazervaultUsers,
    );
    if (picked == null || picked.userId.isEmpty) return;
    if (!context.mounted) return;

    final who = picked.displayName.isNotEmpty
        ? picked.displayName
        : (picked.username.isNotEmpty ? '@${picked.username}' : 'this person');
    final go = await showServerRefusal(
      context,
      title: 'Give your ticket to $who?',
      // Names the consequence. Nothing else about a transfer feels committing
      // — there is no amount and no PIN — so the confirmation carries it.
      message: 'They will hold this ticket and you will not. '
          'This cannot be undone from your side: only they can give it back.',
      actionLabel: 'Give it to $who',
      dismissLabel: 'Keep it',
      tone: ServerRefusalTone.refusal,
    );
    if (!go) return;
    await cubit.transferTicket(
      ticketId: ticket.ticketId,
      toUserId: picked.userId,
    );
  }

  Future<void> _refund(BuildContext context) async {
    final cubit = context.read<TicketingCubit>();
    final paid = ticketMoney(
      ticket.unitPriceMinor.toInt() * (sameOrderCount < 1 ? 1 : sameOrderCount),
      ticket.currency,
    );
    final go = await showServerRefusal(
      context,
      title: sameOrderCount > 1
          ? 'Refund all $sameOrderCount tickets?'
          : 'Refund this ticket?',
      message: sameOrderCount > 1
          ? 'This order bought $sameOrderCount tickets and all of them are '
              'voided together — you cannot refund just one. You paid $paid '
              'for them. The platform may keep its booking fee, so the amount '
              'returned can be less than you paid; the receipt will say '
              'exactly what came back.'
          : 'This ticket is voided and cannot be used. The platform may keep '
              'its booking fee, so the amount returned can be less than you '
              'paid; the receipt will say exactly what came back.',
      actionLabel: 'Request the refund',
      dismissLabel: 'Keep the ticket',
      tone: ServerRefusalTone.refusal,
    );
    if (!go) return;
    await cubit.requestRefund(ticket.purchaseId);
  }
}
