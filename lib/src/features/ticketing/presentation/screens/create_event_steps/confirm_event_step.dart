import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';

import '../../cubit/ticketing_cubit.dart';
import '../../cubit/ticketing_state.dart';
import '../../widgets/ticket_money.dart';
import '../../widgets/ticketing_theme.dart';

/// STEP FOUR — review the DRAFT the server made, then publish it.
///
/// A DIFFERENT JOB FROM THE THREE BEFORE IT, which is why it is a separate
/// widget with no reference to the form model. Those steps collect input and
/// validate it locally; this one renders a server RESPONSE — the draft row and
/// the commission quote computed from settings the organiser cannot see — and
/// does nothing but show it and offer two buttons.
///
/// THE TWO-STEP SHAPE EXISTS BECAUSE OF THE COMMISSION. The fee is an admin
/// setting, so the price an organiser types is not the money they receive.
/// Creating the event as a DRAFT first is what lets the server quote the real
/// split, from the same engine that will charge it, and have the organiser
/// confirm THAT rather than discovering it on their first sale.
///
/// It also owns the flow's only navigation side effect — landing on the
/// organiser view once the event is published — which is easier to see here
/// than buried in a form.
class ConfirmEventStep extends StatelessWidget {
  const ConfirmEventStep({super.key, required this.onBackToForm});

  /// Returns to the last DATA step, not to the first. The refusals that land
  /// here are usually about the price (at this price the commission would
  /// take everything), which lives on the Tickets step; the app bar's arrow
  /// walks back further for the rest.
  final VoidCallback onBackToForm;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketingCubit, TicketingState>(
      listener: (context, state) {
        if (state is TicketEventSaved) {
          // Published. Land on the organiser view for the event just made,
          // rather than back on a form the organiser has finished with.
          Get.offNamed(
            AppRoutes.ticketingOrganiser
                .replaceFirst(':eventId', state.event.id),
          );
        }
      },
      builder: (context, state) {
        if (state is TicketingLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is TicketingFailure) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(state.message,
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, color: TicketingTheme.error)),
              SizedBox(height: 16.h),
              // BACK TO THE FORM, not a retry: these refusals are about the
              // input (the price is too low for the commission, the date has
              // passed), so the fix is an edit.
              // BACK TO THE LAST DATA STEP, not to the first. These
              // refusals are usually about the price (the commission would
              // take everything) which lives on Tickets; the leading arrow
              // walks back further for the rest.
              TextButton(
                onPressed: onBackToForm,
                child: const Text('Back to the form'),
              ),
            ],
          );
        }
        if (state is! TicketEventDrafted) return const SizedBox.shrink();

        final e = state.event;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e.title,
                  style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              SizedBox(height: 4.h),
              if (e.hasEventAt())
                Text(
                    DateFormat('EEEE d MMMM y, h:mm a')
                        .format(e.eventAt.toDateTime()),
                    style: GoogleFonts.inter(
                        fontSize: 12.5.sp,
                        color: TicketingTheme.textSecondary)),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: TicketingTheme.card,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: TicketingTheme.border),
                ),
                child: Column(
                  children: [
                    _line('Ticket price',
                        ticketMoney(e.unitPriceMinor.toInt(), e.currency)),
                    SizedBox(height: 8.h),
                    _line('Platform commission',
                        ticketMoney(state.feePerTicketMinor, e.currency),
                        muted: true),
                    SizedBox(height: 10.h),
                    Divider(height: 1, color: TicketingTheme.border),
                    SizedBox(height: 10.h),
                    _line(
                        'You receive, per ticket',
                        ticketMoney(
                            state.organiserNetPerTicketMinor, e.currency),
                        bold: true),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                // SAYS WHEN THE MONEY ARRIVES, because "you receive" without a
                // when reads as "immediately", and it is not: the ledger is
                // only final once no further purchase can arrive.
                'Buyers\' money is held safely by Lazervault. You can withdraw '
                'your earnings once sales close.',
                style: GoogleFonts.inter(
                    fontSize: 11.5.sp, color: TicketingTheme.textSecondary),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52.h,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: TicketingTheme.border),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                        ),
                        onPressed: onBackToForm,
                        child: Text('Back',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: TicketingTheme.textSecondary)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 52.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TicketingTheme.cta,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                          elevation: 0,
                        ),
                        onPressed: () =>
                            context.read<TicketingCubit>().publish(e.id),
                        child: Text('Publish',
                            style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  Widget _line(String label, String value,
      {bool bold = false, bool muted = false}) {
    final colour = muted ? TicketingTheme.textSecondary : Colors.white;
    return Row(
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: bold ? 14.sp : 13.sp, color: colour)),
        const Spacer(),
        Text(value,
            style: GoogleFonts.inter(
                fontSize: bold ? 17.sp : 13.sp,
                fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
                color: bold ? TicketingTheme.success : colour)),
      ],
    );
  }
}
