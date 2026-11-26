import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/create_event_form_cubit.dart';
import '../cubit/ticketing_cubit.dart';
import '../widgets/event_form_kit.dart';
import '../widgets/ticketing_theme.dart';
import 'create_event_steps/confirm_event_step.dart';
import 'create_event_steps/event_details_step.dart';
import 'create_event_steps/event_host_step.dart';
import 'create_event_steps/event_tickets_step.dart';

/// CREATE AN EVENT — a four-step wizard, and nothing else.
///
/// THIS FILE IS THE SHELL. It owns the app bar, the progress header, which
/// step is showing, and the one submission that turns three steps of input
/// into a draft. The steps themselves are widgets under
/// `create_event_steps/`, the form state and all of the validation live in
/// [CreateEventFormCubit], and the field language is the shared
/// `event_form_kit`.
///
/// WHY IT IS ARRANGED THIS WAY. It had grown to 1,100 lines holding all four
/// step bodies, the validation for every one of them, the flyer upload, two
/// date pickers and the navigation, all private to a single State class —
/// well past the 500-line ceiling in the root guide, and nothing in it could
/// be read or reasoned about without the whole widget. The shape it now has
/// is the PiggyVault wizard's (`create_lock_carousel` + `create_lock_steps/`),
/// which is both the house pattern for this and what the operator asked the
/// events flow to look like.
///
/// THE FOUR STEPS: the event, the host and its socials, the tickets, the
/// review. The host step is index 1 because the operator asked for the
/// socials to be the second thing — they were previously buried behind a
/// collapsed expander in the middle of a single long page.
class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The form model is scoped to this screen and closed with it, which is
    // what disposes the controllers it owns.
    return BlocProvider(
      create: (_) => CreateEventFormCubit(),
      child: const _CreateEventBody(),
    );
  }
}

class _CreateEventBody extends StatefulWidget {
  const _CreateEventBody();

  @override
  State<_CreateEventBody> createState() => _CreateEventBodyState();
}

class _CreateEventBodyState extends State<_CreateEventBody> {
  /// FOUR STEPS: three that collect input, then the review.
  ///
  /// DERIVED, NOT WRITTEN TWICE. The form cubit owns how many steps collect
  /// input, because that is what its validation iterates; this is that number
  /// plus the review. Two independent constants for one fact is how the
  /// navigation and the step switch come to disagree — the switch would route
  /// to Confirm while `_next` still thought there was another form to fill.
  static const int _totalSteps = CreateEventFormCubit.dataSteps + 1;

  /// What the bar's second line says. Named rather than numbered because
  /// "Step 2 of 4" tells somebody where they are and not what is being asked.
  ///
  /// One entry per step — the app bar indexes straight into it, so a missing
  /// name is a range error on the step that lost it. Pinned by
  /// `event_taxonomy_contract_test.dart`.
  static const _stepNames = ['Event', 'Host', 'Tickets', 'Confirm'];

  int _step = 0;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  /// Reads the operator's rules for this form: the price band, whether free
  /// events are allowed, and the two browse-axis lists.
  ///
  /// Fails quietly — the server validates the submission regardless, and the
  /// form's own fallbacks are the server's defaults. What a failed read costs
  /// is the price-band hint and the pickers, which say so themselves.
  Future<void> _loadConfig() async {
    final cfg = await context.read<TicketingCubit>().fetchConfig();
    if (!mounted || cfg == null) return;
    context.read<CreateEventFormCubit>().setConfig(cfg);
  }

  /// Advances, or submits on the last data step.
  void _next() {
    final form = context.read<CreateEventFormCubit>();

    // THIS STEP ONLY. The per-field messages for the step on screen are
    // already rendered and the button is disabled while any remain, so
    // reaching here with a problem means a race (a date cleared between
    // build and tap) rather than something the organiser has not been told.
    final here = form.problemsFor(_step);
    if (here.isNotEmpty) {
      // THE PRESS IS WHAT ASKS FOR VALIDATION. Until now the step's messages
      // were painted on arrival, so the organiser met a form that was already
      // telling them off. Revealing here means the red appears at the moment
      // they assert they are finished — and then stays live, clearing field
      // by field as each is corrected.
      form.revealProblems(_step);
      form.setError(here.values.first);
      return;
    }
    form.setError(null);

    // Not the last data step: just advance.
    if (_step < CreateEventFormCubit.dataSteps - 1) {
      setState(() => _step += 1);
      return;
    }

    // RE-CHECKED ACROSS EVERY STEP before submitting. The per-step check only
    // ever looks at the step on screen, and an organiser who walked back to
    // step one and cleared the title would otherwise submit it — the button
    // they pressed was on a step that was perfectly valid.
    final all = form.allProblems();
    if (all.isNotEmpty) {
      form.setError(all.values.first);
      final bad = form.firstInvalidStep();
      // Land them ON the step that is wrong rather than leaving them looking
      // at a message about a field they cannot see — and REVEAL that step's
      // problems, or they arrive at a page with nothing marked and a message
      // about a field that looks fine.
      if (bad >= 0) {
        form.revealProblems(bad);
        setState(() => _step = bad);
      }
      return;
    }

    // THE LAST DATA STEP CREATES THE DRAFT, because the commission quote the
    // Confirm step shows comes from the server and is computed from settings
    // the organiser cannot see.
    context.read<TicketingCubit>().createDraft(
          title: form.title.text.trim(),
          description: form.description.text.trim(),
          venue: form.venue.text.trim(),
          flyerUrl: form.flyerUrl,
          unitPriceMinor: form.priceMinor!,
          capacity: form.capacityValue,
          salesCloseAt: form.salesCloseAt,
          eventAt: form.eventAt!,
          organiserName: form.organiserName.text.trim(),
          organiserSocials: form.socialHandles,
          category: form.category ?? '',
          state: form.stateSlug ?? '',
        );
    setState(() => _step = _totalSteps - 1);
  }

  /// Back from the Confirm step: the last DATA step, not the first.
  void _backToForm() =>
      setState(() => _step = CreateEventFormCubit.dataSteps - 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TicketingTheme.bg,
      appBar: AppBar(
        backgroundColor: TicketingTheme.bg,
        foregroundColor: TicketingTheme.onBar,
        elevation: 0,
        // BACK WALKS THE WIZARD, then leaves it.
        //
        // REQUIRED BY THE SPLIT, not a nicety. The flow was two steps and the
        // only way back was the Confirm step's own button; at four steps, a
        // leading arrow that popped the screen would mean an organiser on the
        // Tickets step could not return to fix a venue without losing
        // everything they had typed.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_step > 0) {
              // The message belonged to the step being left.
              context.read<CreateEventFormCubit>().setError(null);
              setState(() => _step -= 1);
              return;
            }
            Navigator.of(context).maybePop();
          },
        ),
        // THE STEP LIVES IN THE APP BAR, as it does on New Invoice — the same
        // information as a line of body text above the form, without the
        // ~40dp it cost on a step that already scrolls.
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create event',
                style: GoogleFonts.inter(
                    fontSize: 18.sp, fontWeight: FontWeight.w700)),
            Text('Step ${_step + 1} of $_totalSteps · ${_stepNames[_step]}',
                style: GoogleFonts.inter(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w500,
                    color: TicketingTheme.textSecondary)),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // THE PIGGYVAULT PROGRESS HEADER, from the shared kit: a
              // gradient bar over dot indicators, green on the final step.
              EventStepProgress(current: _step, total: _totalSteps),
              SizedBox(height: 16.h),
              Expanded(
                child: switch (_step) {
                  0 => EventDetailsStep(onContinue: _next),
                  1 => EventHostStep(onContinue: _next),
                  2 => EventTicketsStep(onContinue: _next),
                  _ => ConfirmEventStep(onBackToForm: _backToForm),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
