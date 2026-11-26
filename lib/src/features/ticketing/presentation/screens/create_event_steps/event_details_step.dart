import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../cubit/create_event_form_cubit.dart';
import '../../widgets/event_axis_field.dart';
import '../../widgets/event_form_kit.dart';
import '../../widgets/ticketing_theme.dart';
import 'step_scaffold.dart';

/// STEP ONE — what the event is, where, and when.
///
/// The browse axes are asked for HERE, next to the name and the venue,
/// because "what is it" and "where is it" are the same thought. Both lists
/// come from the admin dashboard; see [CreateEventFormCubit.categoryOptions].
class EventDetailsStep extends StatelessWidget {
  const EventDetailsStep({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final form = context.watch<CreateEventFormCubit>();
    // PAINTED ONLY ONCE THE ORGANISER HAS PRESSED CONTINUE.
    // `problemsFor` answers "is this step complete", which is false
    // the instant the form opens — rendering it directly turned every
    // required field red before a character had been typed.
    final problems = form.visibleProblemsFor(0);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventStepTitle('What is the event?',
              subtitle: 'The name, where it is, and when.'),
          SizedBox(height: 18.h),
          const _FlyerPicker(),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: EventTextField(
              label: 'Event name',
              controller: form.title,
              hint: 'e.g. Lagos Night Market',
              icon: Icons.local_activity_outlined,
              error: problems['title'],
              onChanged: (_) => form.fieldChanged(),
            ),
          ),
          EventAxisField(
            label: 'Category',
            icon: Icons.category_outlined,
            placeholder: 'What kind of event is it?',
            options: form.categoryOptions,
            current: form.category,
            error: problems['category'],
            onPicked: form.setCategory,
            onUnavailable: () => form.setError(
                'Still loading the category list. Try again in a moment.'),
          ),
          EventAxisField(
            label: 'State',
            icon: Icons.location_on_outlined,
            placeholder: 'Which state is it in?',
            options: form.stateOptions,
            current: form.stateSlug,
            error: problems['state'],
            onPicked: form.setStateSlug,
            onUnavailable: () => form.setError(
                'Still loading the state list. Try again in a moment.'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: EventTextField(
              label: 'Venue',
              controller: form.venue,
              hint: 'Where exactly?',
              icon: Icons.place_outlined,
              error: problems['venue'],
              onChanged: (_) => form.fieldChanged(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: EventTextField(
              label: 'Description',
              controller: form.description,
              hint: 'What should people know?',
              maxLines: 3,
              optional: true,
              onChanged: (_) => form.fieldChanged(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: EventPickerField(
              label: 'When is it?',
              icon: Icons.event_outlined,
              value: form.eventAt == null
                  ? null
                  : DateFormat('EEE d MMM y, h:mm a').format(form.eventAt!),
              placeholder: 'Choose',
              error: problems['eventAt'],
              onTap: () => pickEventDateTime(context, form: form),
            ),
          ),
          StepFooter(step: 0, onContinue: onContinue),
        ],
      ),
    );
  }
}

/// The flyer row.
///
/// Three states, all of which must stay visible: uploading, picked-and-
/// uploaded, and picked-but-NOT-uploaded. The last one has to be loud —
/// an event published in that state carries no flyer URL at all.
class _FlyerPicker extends StatelessWidget {
  const _FlyerPicker();

  @override
  Widget build(BuildContext context) {
    final form = context.watch<CreateEventFormCubit>();
    final hasImage = form.flyerPreview != null;
    final uploaded = form.flyerUrl.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventFieldLabel('Flyer', optional: true),
        InkWell(
          onTap: form.uploadingFlyer ? null : form.pickFlyer,
          borderRadius: BorderRadius.circular(12.r),
          child: EventFieldCard(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                // Sized to the aspect the card itself uses for a flyer, so
                // the organiser is choosing an image at roughly the size it
                // will be seen at.
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SizedBox(
                    width: 64.w,
                    height: 48.w,
                    child: hasImage
                        ? Image.file(form.flyerPreview!, fit: BoxFit.cover)
                        : Container(
                            color: Colors.white.withValues(alpha: 0.06),
                            child: Icon(Icons.image_outlined,
                                size: 22.sp, color: const Color(0xFF9CA3AF)),
                          ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    form.uploadingFlyer
                        ? 'Uploading…'
                        : uploaded
                            ? 'Flyer ready'
                            : hasImage
                                // LOUD on purpose: the image is on screen and
                                // is NOT attached to anything.
                                ? 'Not uploaded — tap to try again'
                                : 'Add a flyer',
                    style: GoogleFonts.inter(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w500,
                      color: !form.uploadingFlyer && hasImage && !uploaded
                          ? TicketingTheme.warning
                          : Colors.white,
                    ),
                  ),
                ),
                if (form.uploadingFlyer)
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                else if (uploaded)
                  Icon(Icons.check_circle_rounded,
                      size: 20.sp, color: TicketingTheme.success)
                else
                  Icon(Icons.add_photo_alternate_outlined,
                      size: 20.sp, color: const Color(0xFF9CA3AF)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
