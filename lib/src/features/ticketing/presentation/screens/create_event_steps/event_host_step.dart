import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/create_event_form_cubit.dart';
import '../../widgets/event_form_kit.dart';
import '../../widgets/organiser_socials_field.dart';
import 'step_scaffold.dart';

/// STEP TWO — the public host, and its handles.
///
/// ITS OWN STEP BECAUSE THE OPERATOR ASKED FOR IT, and the reason holds up:
/// the host block sat in the middle of one long page behind a collapsed
/// expander, between the venue and the description, so the handles a buyer
/// uses to decide whether an event is real were the easiest thing on the form
/// to miss.
///
/// EVERYTHING HERE IS OPTIONAL. An organiser with no separate brand leaves it
/// blank and the listing shows no host — inventing one from the account holder
/// would publish personal identity on a page they never chose to put it on.
class EventHostStep extends StatelessWidget {
  const EventHostStep({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final form = context.watch<CreateEventFormCubit>();
    // PAINTED ONLY ONCE THE ORGANISER HAS PRESSED CONTINUE.
    // `problemsFor` answers "is this step complete", which is false
    // the instant the form opens — rendering it directly turned every
    // required field red before a character had been typed.
    final problems = form.visibleProblemsFor(1);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventStepTitle('Who is putting it on?',
              subtitle: 'The name buyers will see, and where they can check '
                  'you out. All optional — leave it blank and the listing '
                  'shows no host.'),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: EventTextField(
              label: 'Hosted by',
              controller: form.organiserName,
              hint: 'e.g. Lagos Jazz Collective',
              icon: Icons.storefront_outlined,
              optional: true,
              error: problems['organiserName'],
              onChanged: (_) => form.fieldChanged(),
            ),
          ),
          // EXPANDED BY DEFAULT ON ITS OWN STEP. Collapsed made sense when it
          // was one row among eight; on a step that exists to ask for it, a
          // closed expander is a step that looks empty.
          OrganiserSocialsField(
            controllers: form.socials,
            open: form.socialsOpen,
            onToggle: form.toggleSocials,
            onChanged: form.fieldChanged,
          ),
          StepFooter(step: 1, onContinue: onContinue),
        ],
      ),
    );
  }
}
