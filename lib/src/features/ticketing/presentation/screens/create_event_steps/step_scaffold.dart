import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../cubit/create_event_form_cubit.dart';
import '../../widgets/event_form_kit.dart';
import '../../widgets/ticketing_theme.dart';

/// The pieces every data step shares.
///
/// Kept beside the steps rather than in the widget kit because these three
/// know about [CreateEventFormCubit]. The kit is deliberately ignorant of this
/// feature's model so the other ticketing screens can use it.

/// A step's footer: the form-level message, then the primary button.
///
/// THE BUTTON IS DISABLED WHILE THE STEP HAS A PROBLEM, so the refusal is
/// visible before it is pressed rather than after. The per-field messages are
/// already on screen, so a greyed button is never unexplained.
class StepFooter extends StatelessWidget {
  const StepFooter({
    super.key,
    required this.step,
    required this.onContinue,
    this.label = 'Continue',
  });

  final int step;
  final VoidCallback onContinue;
  final String label;

  @override
  Widget build(BuildContext context) {
    final form = context.watch<CreateEventFormCubit>();
    // CONTINUE IS ALWAYS PRESSABLE, and that is the point.
    //
    // It used to be disabled whenever the step was incomplete, which paired
    // with errors shown on arrival: the organiser opened the form, saw four
    // red messages and a dead button. Pressing Continue is now what ASKS for
    // validation — the press reveals the problems and the button stays put
    // until they are fixed. A disabled control explains nothing; a press that
    // answers "here is what is missing" does.
    return Column(
      children: [
        SizedBox(height: 4.h),
        if (form.error != null) ...[
          Text(form.error!,
              style: GoogleFonts.inter(
                  fontSize: 12.5.sp, color: TicketingTheme.error)),
          SizedBox(height: 12.h),
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
            onPressed: onContinue,
            child: Text(label,
                style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}

/// Opens one browse axis' picker.
///
/// REFUSES TO OPEN AN EMPTY SHEET. Until the config read lands there is
/// nothing to offer, and an empty sheet reads as the feature being broken —
/// so it says so instead.
Future<void> pickTaxonomy(
  BuildContext context, {
  required CreateEventFormCubit form,
  required String title,
  required List<({String value, String label})> options,
  required String? current,
  required ValueChanged<String> onPicked,
}) async {
  if (options.isEmpty) {
    form.setError('Still loading the $title list. Try again in a moment.');
    return;
  }
  final picked = await EventOptionSheet.open(
    context,
    title: title,
    options: options,
    current: current,
  );
  if (picked == null) return;
  onPicked(picked);
}

/// The event date, then its time.
///
/// TWO PICKERS, not one: Flutter has no combined control, and a date with a
/// silently assumed time is how an event ends up listed at midnight. The time
/// defaults to 19:00 because that is when most ticketed events start, and the
/// organiser can change it — a default they can see beats a blank they must
/// fill.
Future<void> pickEventDateTime(
  BuildContext context, {
  required CreateEventFormCubit form,
  bool forSalesClose = false,
}) async {
  final now = DateTime.now();
  final date = await showDatePicker(
    context: context,
    initialDate: forSalesClose
        ? (form.eventAt ?? now)
        : now.add(const Duration(days: 7)),
    firstDate: now,
    lastDate: now.add(const Duration(days: 365 * 2)),
  );
  if (date == null || !context.mounted) return;
  final time = await showTimePicker(
    context: context,
    initialTime: const TimeOfDay(hour: 19, minute: 0),
  );
  if (!context.mounted) return;
  final picked = DateTime(
      date.year, date.month, date.day, time?.hour ?? 19, time?.minute ?? 0);
  if (forSalesClose) {
    form.setSalesCloseAt(picked);
  } else {
    form.setEventAt(picked);
  }
}
