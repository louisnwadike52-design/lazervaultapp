import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import '../../data/event_flyer_upload_service.dart';
import '../widgets/event_axis_field.dart';
import '../widgets/organiser_socials_field.dart';
import '../widgets/ticket_money.dart';

/// THE CREATE-AN-EVENT FORM, AS ONE MODEL.
///
/// Mirrors `CreateLockCubit` — the PiggyVault wizard's own form cubit — so the
/// two multi-step creation flows have the same shape: the steps are widgets,
/// the state and the per-step validation live here, and the screen is only a
/// shell.
///
/// WHY THIS EXISTS. The screen had grown to 1,100 lines holding four step
/// bodies, the validation for all of them, the flyer upload, the date pickers
/// and the navigation. Everything was private to one State class, so nothing
/// could be read or tested without the widget, and the four steps could not be
/// looked at separately even though they ask for unrelated things.
///
/// IT OWNS THE CONTROLLERS, which is the one place it departs from
/// CreateLockCubit. PiggyVault's steps keep their own controllers and push
/// values in (`cubit.updateGoalName(value)`), which means the same text exists
/// twice — in the field and in the cubit — and the two can disagree if a push
/// is ever missed. Validation here reads the controller directly, so there is
/// exactly one copy of what the organiser typed. Disposal is therefore this
/// object's job, in [close].
class CreateEventFormCubit extends Cubit<CreateEventFormState> {
  CreateEventFormCubit() : super(const CreateEventFormState());

  // ── WHAT THE ORGANISER TYPED ─────────────────────────────────────────────

  final title = TextEditingController();
  final venue = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  final capacity = TextEditingController();

  /// THE PUBLIC HOST — the brand running the night, not the account holder.
  ///
  /// Optional and left empty when empty. Defaulting it to the signed-in user's
  /// own name would publish personal identity on a page they never chose to
  /// put it on; the server's own comment on this field says the same.
  final organiserName = TextEditingController();

  /// Handles, one controller per platform. Stored as platform → handle and
  /// sent with the blanks dropped, because the event page renders a row per
  /// entry and an empty one is a link to nowhere.
  final Map<String, TextEditingController> socials =
      buildOrganiserSocialControllers();

  // ── WHAT THEY CHOSE ──────────────────────────────────────────────────────

  /// The browse axes, as SLUGS.
  ///
  /// Slugs and not labels because that is what the server stores and filters
  /// on; the label is only ever rendered. An operator may re-word a label at
  /// any time, and an app holding labels would send one the server no longer
  /// recognises.
  String? category;

  /// NAMED `stateSlug`, NOT `state`. A Cubit already has a `state`, and a
  /// field of that name silently shadows it — the analyser reports it as an
  /// invalid override, which is the lucky outcome; in a plain model class it
  /// would simply be two different things called the same word.
  String? stateSlug;

  DateTime? eventAt;
  DateTime? salesCloseAt;

  bool socialsOpen = false;

  /// The flyer, UPLOADED AS SOON AS IT IS PICKED rather than held as bytes
  /// until publish.
  ///
  /// Uploading at publish time would put a network round-trip of unknown
  /// length between "Publish" and the event existing, with the organiser
  /// looking at a spinner and no way to tell a slow upload from a stuck one.
  /// Uploading on pick means the slow part happens while they are still
  /// filling the form, and a failure is recoverable without losing anything
  /// they typed. An orphaned object costs nothing: it is one image in the
  /// uploader's own prefix, attached to no event.
  String flyerUrl = '';
  File? flyerPreview;
  bool uploadingFlyer = false;

  /// The operator's rules for this form. Null until the read returns — see
  /// [priceBandLabel] for what the form shows meanwhile.
  tk.GetTicketingConfigResponse? config;

  /// A message about the FORM as a whole (a failed flyer upload, a picker
  /// opened before the config arrived). Per-field problems are [problemsFor].
  String? error;

  // ── CHANGE NOTIFICATION ──────────────────────────────────────────────────

  /// Emits a new revision so every listening step rebuilds.
  ///
  /// A COUNTER RATHER THAN A SNAPSHOT. The fields above are mutable and read
  /// directly (including the controllers), so an immutable state object would
  /// be a second copy of everything with nothing new in it. What the state has
  /// to carry is only "something changed", and Equatable needs that to differ
  /// or the rebuild is suppressed.
  ///
  /// GUARDED ON isClosed, and that is not defensive padding — it is the
  /// closing hazard the split created. A picker or a date sheet can outlive
  /// this screen: the organiser opens the state list, backs out of the whole
  /// flow, and the sheet's future then completes and calls a setter. `emit`
  /// after `close` throws, so the user's exit would surface as a crash from a
  /// screen they had already left.
  ///
  /// It lives HERE rather than at each call site because there are eleven of
  /// them, several reached from inside an `await`, and one forgotten guard is
  /// the same bug back.
  void _touch() {
    if (isClosed) return;
    emit(state.next());
  }

  /// Called on every keystroke so a validation message clears as soon as the
  /// field is right. An error that only updates when Continue is pressed
  /// trains people to ignore it.
  void fieldChanged() => _touch();

  void setCategory(String slug) {
    category = slug;
    error = null;
    _touch();
  }

  void setStateSlug(String slug) {
    stateSlug = slug;
    error = null;
    _touch();
  }

  void setEventAt(DateTime v) {
    eventAt = v;
    _touch();
  }

  void setSalesCloseAt(DateTime v) {
    salesCloseAt = v;
    _touch();
  }

  void toggleSocials() {
    socialsOpen = !socialsOpen;
    _touch();
  }

  void setError(String? message) {
    error = message;
    _touch();
  }

  void setConfig(tk.GetTicketingConfigResponse cfg) {
    config = cfg;
    _touch();
  }

  // ── THE FLYER ────────────────────────────────────────────────────────────

  /// Picks an image and uploads it immediately. See [flyerUrl].
  Future<void> pickFlyer() async {
    if (uploadingFlyer) return;
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        // Capped at the picker. A flyer is rendered at card width; sending a
        // 12MP original to draw it is bytes nobody benefits from, and the
        // upload service compresses again before its size check anyway.
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 88,
      );
      if (picked == null || isClosed) return;
      flyerPreview = File(picked.path);
      uploadingFlyer = true;
      error = null;
      _touch();

      final result =
          await EventFlyerUploadService().uploadFromFile(flyerPreview!);
      if (isClosed) return;
      flyerUrl = result.publicUrl;
      uploadingFlyer = false;
      _touch();
    } catch (e) {
      if (isClosed) return;
      uploadingFlyer = false;
      // The preview is dropped with the failure: leaving a thumbnail on
      // screen beside an error would read as "it worked", and the event would
      // publish with no flyer.
      flyerPreview = null;
      flyerUrl = '';
      error = e is EventFlyerUploadException
          ? e.message
          : 'That image could not be uploaded. Try another one.';
      _touch();
    }
  }

  // ── DERIVED FROM THE OPERATOR'S SETTINGS ─────────────────────────────────

  bool get freeAllowed => config?.freeEventsEnabled ?? false;
  int? get minPriceMinor => config?.minPriceMinor.toInt();
  int? get maxPriceMinor => config?.maxPriceMinor.toInt();

  /// What the price field says underneath itself.
  ///
  /// Reads from the operator's settings, so an operator who opens free events
  /// or narrows the band changes this line without a release. Says nothing at
  /// all until the config has arrived rather than stating a band that may be
  /// wrong — a wrong number here is worse than no number.
  String? get priceBandLabel {
    final cfg = config;
    if (cfg == null) return null;
    final min = ticketMoney(cfg.minPriceMinor.toInt(), 'NGN');
    final max = ticketMoney(cfg.maxPriceMinor.toInt(), 'NGN');
    return cfg.freeEventsEnabled
        ? 'Enter 0 for a free event, or between $min and $max'
        : 'Between $min and $max';
  }

  /// The browse axes as the pickers render them.
  ///
  /// FROM THE CONFIG, NEVER A LITERAL. The lists are system settings precisely
  /// so a new category does not need a release; a hardcoded copy here would be
  /// the one place that could not follow, and the organiser would be offered a
  /// category the server then refuses.
  ///
  /// The mapping and the label lookup are [axisOptions] / [axisLabel] —
  /// shared with the edit screen and the catalogue's filter chips, because
  /// three copies of "an unknown slug falls back to the slug" is three places
  /// to get it wrong in one.
  List<({String value, String label})> get categoryOptions =>
      axisOptions(config?.categories ?? const []);

  List<({String value, String label})> get stateOptions =>
      axisOptions(config?.states ?? const []);

  // ── THE MONEY FIELDS ─────────────────────────────────────────────────────

  /// The price in MINOR UNITS, or null when the field cannot be read as a
  /// number at all.
  ///
  /// Parsed from a naira field, so this is the single multiplication by 100 on
  /// the create path. `round()` and not `toInt()`: 49.99 * 100 is 4998.9999…
  /// in binary floating point, and truncating it silently takes a kobo off
  /// every ticket.
  ///
  /// ZERO IS A VALUE HERE, NOT A FAILURE. It used to return null for anything
  /// at or below zero, which collapsed "free" and "not a number" into one
  /// answer and made a free event impossible in the app whatever the operator
  /// had set. Whether zero is ALLOWED is a policy question, answered in
  /// [problemsFor] against the config.
  int? get priceMinor {
    final raw = price.text.trim().replaceAll(',', '');
    if (raw.isEmpty) return null;
    final v = double.tryParse(raw);
    if (v == null || v < 0) return null;
    return (v * 100).round();
  }

  int? get capacityValue {
    final raw = capacity.text.trim();
    if (raw.isEmpty) return null; // UNLIMITED — not zero.
    return int.tryParse(raw);
  }

  /// The handles, blanks dropped.
  Map<String, String> get socialHandles => {
        for (final e in socials.entries)
          if (e.value.text.trim().isNotEmpty) e.key: e.value.text.trim(),
      };

  // ── VALIDATION, PER STEP AND PER FIELD ───────────────────────────────────
  //
  // Returns the problems on ONE step, keyed by field, so each message can sit
  // under the input it is about and the step's button can be disabled while
  // any remain.
  //
  // WHY A MAP RATHER THAN THE FIRST PROBLEM. The old whole-form validator
  // returned a single string shown in a banner at the bottom: on an
  // eight-field page that says something is wrong and leaves you to find it,
  // and it reports them one at a time, so fixing the price reveals the date.
  //
  // THE SERVER VALIDATES EVERYTHING AGAIN. Nothing here is a security
  // boundary — it exists so an organiser is not told at the end of a wizard
  // what they could have been told on the step they were standing on.

  /// How many steps COLLECT input. The last step reviews a server response and
  /// has nothing of its own to validate.
  static const int dataSteps = 3;

  /// Steps whose problems the organiser has ASKED to see, by pressing
  /// Continue on them.
  ///
  /// WHY VALIDATION IS NOT SHOWN ON ARRIVAL. [problemsFor] answers "is this
  /// step complete", which is false the instant the form opens — so rendering
  /// it directly painted every required field red before a single character
  /// had been typed. The first thing the organiser saw was four errors
  /// telling them off for not having filled in a form they had just opened.
  ///
  /// Pressing Continue is the moment they assert they are done, and that is
  /// when an unmet requirement becomes news. After that the messages stay
  /// live and clear themselves as each field is corrected, because an error
  /// that only refreshes on the next press trains people to ignore it.
  final Set<int> _revealed = <int>{};

  /// Show [step]'s problems from now on. Called when Continue is pressed on a
  /// step that is not complete.
  void revealProblems(int step) {
    if (_revealed.add(step)) _touch();
  }

  /// Whether [step] has been asked to show its problems yet.
  bool problemsVisible(int step) => _revealed.contains(step);

  /// The problems to PAINT for [step] — empty until the organiser has pressed
  /// Continue on it. Validation itself is unchanged; this is only about when
  /// the organiser is told.
  Map<String, String> visibleProblemsFor(int step) =>
      _revealed.contains(step) ? problemsFor(step) : const {};

  Map<String, String> problemsFor(int step) {
    final out = <String, String>{};
    switch (step) {
      case 0:
        if (title.text.trim().isEmpty) {
          out['title'] = 'Give the event a name.';
        }
        // CATEGORY AND STATE ARE REQUIRED HERE AND OPTIONAL ON THE WIRE, and
        // the asymmetry is deliberate. The server tolerates an empty axis so
        // a half-finished draft can be saved; a listing with neither is
        // invisible to every filter on the landing page, which is not a state
        // an organiser would choose on purpose.
        if ((category ?? '').isEmpty) {
          out['category'] = 'Pick a category so buyers can find it.';
        }
        if ((stateSlug ?? '').isEmpty) {
          out['state'] = 'Pick the state it is in.';
        }
        if (venue.text.trim().isEmpty) {
          out['venue'] = 'Say where it is.';
        }
        if (eventAt == null) {
          out['eventAt'] = 'Choose when the event is.';
        } else if (!eventAt!.isAfter(DateTime.now())) {
          out['eventAt'] = 'The event date has to be in the future.';
        }
      case 1:
        // The host block is entirely optional — see the step's own copy. What
        // is NOT acceptable is handles with no name to attach them to: the
        // listing renders them under the host, so with no host they would
        // appear under nothing.
        if (socialHandles.isNotEmpty && organiserName.text.trim().isEmpty) {
          out['organiserName'] =
              'Add the host name — the handles are shown under it.';
        }
      case 2:
        final p = priceMinor;
        if (p == null) {
          out['price'] = 'Enter a ticket price.';
        } else if (config != null) {
          // THE BAND COMES FROM THE OPERATOR, and is only enforced once it
          // has actually arrived. Enforcing a compiled-in band while the read
          // is in flight would refuse prices the server accepts; the server
          // validates the submission regardless, so the cost of waiting is an
          // extra round trip, not a wrong answer.
          if (p == 0 && !freeAllowed) {
            out['price'] = 'Free events are not available at the moment. '
                'Enter a ticket price.';
          } else if (p > 0) {
            final min = minPriceMinor;
            final max = maxPriceMinor;
            if (min != null && p < min) {
              out['price'] =
                  'The lowest ticket price is ${ticketMoney(min, 'NGN')}.';
            } else if (max != null && p > max) {
              out['price'] =
                  'The highest ticket price is ${ticketMoney(max, 'NGN')}.';
            }
          }
        }
        final cap = capacityValue;
        if (capacity.text.trim().isNotEmpty && (cap == null || cap < 1)) {
          // Said rather than silently treated as unlimited: whoever typed 0
          // meant something, and guessing which is worse than asking.
          out['capacity'] =
              'Capacity must be at least 1 — leave it empty for unlimited.';
        }
        if (salesCloseAt != null &&
            eventAt != null &&
            salesCloseAt!.isAfter(eventAt!)) {
          out['salesCloseAt'] =
              'Sales must close by the time the event starts.';
        }
    }
    return out;
  }

  /// Every problem across every data step.
  ///
  /// Used at the point of submission, because a step the organiser jumped back
  /// from may have been left invalid — the per-step check only ever looks at
  /// the step on screen.
  Map<String, String> allProblems() => {
        for (var i = 0; i < dataSteps; i++) ...problemsFor(i),
      };

  /// The first data step that has a problem, or -1 when none do.
  ///
  /// So the shell can LAND the organiser on the step that is wrong rather than
  /// leaving them looking at a message about a field they cannot see.
  int firstInvalidStep() {
    for (var i = 0; i < dataSteps; i++) {
      if (problemsFor(i).isNotEmpty) return i;
    }
    return -1;
  }

  @override
  Future<void> close() {
    title.dispose();
    venue.dispose();
    description.dispose();
    price.dispose();
    capacity.dispose();
    organiserName.dispose();
    for (final c in socials.values) {
      c.dispose();
    }
    return super.close();
  }
}

/// "Something changed."
///
/// A revision counter, not a snapshot — see [CreateEventFormCubit._touch] for
/// why. Equatable semantics come from the field differing, which is the whole
/// job: a state that compared equal would suppress the rebuild and leave a
/// cleared validation message on screen.
class CreateEventFormState {
  const CreateEventFormState({this.revision = 0});

  final int revision;

  CreateEventFormState next() => CreateEventFormState(revision: revision + 1);

  @override
  bool operator ==(Object other) =>
      other is CreateEventFormState && other.revision == revision;

  @override
  int get hashCode => revision.hashCode;
}
