import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../cubit/create_event_form_cubit.dart';
import '../../widgets/event_form_kit.dart';
import 'step_scaffold.dart';

/// STEP THREE — the price, how many, and when sales stop.
///
/// The price band under the field comes from the operator's settings, so an
/// operator who opens free events or narrows the band changes what this step
/// says without a release. It says NOTHING until the config arrives rather
/// than stating a band that may be wrong.
class EventTicketsStep extends StatelessWidget {
  const EventTicketsStep({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final form = context.watch<CreateEventFormCubit>();
    // PAINTED ONLY ONCE THE ORGANISER HAS PRESSED CONTINUE.
    // `problemsFor` answers "is this step complete", which is false
    // the instant the form opens — rendering it directly turned every
    // required field red before a character had been typed.
    final problems = form.visibleProblemsFor(2);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventStepTitle('Tickets',
              subtitle: 'The price, how many, and when sales stop.'),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: EventTextField(
              label: 'Ticket price',
              controller: form.price,
              hint: '0.00',
              icon: Icons.sell_outlined,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              helper: form.priceBandLabel,
              error: problems['price'],
              formatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))
              ],
              onChanged: (_) => form.fieldChanged(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: EventTextField(
              label: 'Capacity',
              controller: form.capacity,
              hint: 'Leave empty for unlimited',
              icon: Icons.groups_outlined,
              optional: true,
              keyboardType: TextInputType.number,
              error: problems['capacity'],
              formatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (_) => form.fieldChanged(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: EventPickerField(
              label: 'Stop selling',
              icon: Icons.event_outlined,
              optional: true,
              value: form.salesCloseAt == null
                  ? null
                  : DateFormat('EEE d MMM y, h:mm a')
                      .format(form.salesCloseAt!),
              placeholder: 'Defaults to the event start',
              error: problems['salesCloseAt'],
              onTap: () =>
                  pickEventDateTime(context, form: form, forSalesClose: true),
            ),
          ),
          StepFooter(step: 2, onContinue: onContinue, label: 'Review'),
        ],
      ),
    );
  }
}
