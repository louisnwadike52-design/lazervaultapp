import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import '../cubit/ticketing_cubit.dart';
import '../widgets/organiser_socials_field.dart';
import '../cubit/ticketing_state.dart';
import '../widgets/event_axis_field.dart';
import '../widgets/event_form_kit.dart';
import '../widgets/ticketing_theme.dart';

/// EDIT AN EVENT — and show plainly what can no longer be changed.
///
/// THE SERVER FREEZES THE COMMERCIAL TERMS ONCE A TICKET IS SOLD: the price,
/// the capacity, the commission and the dates. The purchase row carries its own
/// unit price, so changing the event's would leave the organiser's recorded net
/// and the money actually in the pool describing different events.
///
/// So this screen does not offer those fields and then surface a refusal — it
/// DISABLES them and says why, which is the difference between a form that
/// works and one that argues with you. The descriptive fields stay editable
/// for ever, because an organiser whose venue moved has to be able to say so.
///
/// Only non-null fields are sent (the repository pairs each with its own
/// update_* flag), so leaving a field alone genuinely leaves it alone rather
/// than blanking it.
class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key, required this.event});
  final tk.TicketEvent event;

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late final TextEditingController _title;
  late final TextEditingController _venue;
  late final TextEditingController _description;
  late final TextEditingController _price;
  late final TextEditingController _capacity;

  /// THE PUBLIC HOST AND ITS HANDLES — editable even once tickets are sold.
  ///
  /// Not frozen with the commercial terms: a misspelt brand name is cosmetic,
  /// and refusing to fix it would leave a typo on a page buyers are looking
  /// at. Nobody paid a price because of how the host was spelled.
  late final TextEditingController _organiserName;
  late final Map<String, TextEditingController> _socials;
  bool _socialsOpen = false;

  DateTime? _eventAt;
  DateTime? _salesCloseAt;
  String? _error;

  /// The browse axes, as SLUGS.
  ///
  /// EDITABLE EVEN WHEN THE EVENT IS FROZEN. [_frozen] refuses the commercial
  /// terms once a ticket has sold, because a purchase row carries its own
  /// price and changing the event's would leave the recorded net describing a
  /// different event. A category carries no money and appears on no purchase
  /// row — and an organiser who filed a comedy night under Music will notice
  /// exactly when tickets start selling, which is precisely when the old
  /// screen offered no way to fix it.
  String? _category;
  String? _stateSlug;

  /// The operator's lists. Null until the read lands; the pickers say so
  /// rather than opening empty.
  tk.GetTicketingConfigResponse? _config;

  /// True once a single ticket has been sold. Everything commercial is read
  /// only from here on — see the class note.
  bool get _frozen => widget.event.ticketsSold > 0;

  @override
  void initState() {
    super.initState();
    final e = widget.event;
    _title = TextEditingController(text: e.title);
    _venue = TextEditingController(text: e.venue);
    _description = TextEditingController(text: e.description);
    _price = TextEditingController(
        text: (e.unitPriceMinor.toInt() / 100).toStringAsFixed(2));
    _capacity =
        TextEditingController(text: e.hasCapacity() ? '${e.capacity}' : '');
    _organiserName = TextEditingController(text: e.organiserName);
    _socials = buildOrganiserSocialControllers(e.organiserSocials);
    // Opened when there is already something in it, so an organiser editing a
    // host that HAS handles can see them without hunting for the disclosure.
    _socialsOpen = e.organiserSocials.isNotEmpty;
    _eventAt = e.hasEventAt() ? e.eventAt.toDateTime() : null;
    _salesCloseAt = e.hasSalesCloseAt() ? e.salesCloseAt.toDateTime() : null;
    // Empty on a row created before these existed, which must read as "not
    // set" rather than as an axis called "".
    _category = e.category.isEmpty ? null : e.category;
    _stateSlug = e.state.isEmpty ? null : e.state;
    _loadConfig();
  }

  /// Reads the browse-axis lists. Fails quietly — the rest of the form works
  /// without them, and the pickers explain themselves.
  Future<void> _loadConfig() async {
    final cfg = await context.read<TicketingCubit>().fetchConfig();
    if (!mounted || cfg == null) return;
    setState(() => _config = cfg);
  }

  @override
  void dispose() {
    _title.dispose();
    _venue.dispose();
    _description.dispose();
    _price.dispose();
    _capacity.dispose();
    _organiserName.dispose();
    for (final c in _socials.values) {
      c.dispose();
    }
    super.dispose();
  }

  int? get _priceMinor {
    final v = double.tryParse(_price.text.trim().replaceAll(',', ''));
    if (v == null || v <= 0) return null;
    // round(), not toInt(): 49.99 * 100 is 4998.9999… in binary floating
    // point, and truncating takes a kobo off every ticket.
    return (v * 100).round();
  }

  void _save() {
    final cubit = context.read<TicketingCubit>();
    final e = widget.event;

    if (_title.text.trim().isEmpty) {
      setState(() => _error = 'The event needs a name.');
      return;
    }

    // ONLY WHAT CHANGED IS SENT. Passing every field would make an untouched
    // form a full rewrite, and on a frozen event that is a refusal for an edit
    // the organiser never made.
    String? ifChanged(String now, String before) =>
        now.trim() == before.trim() ? null : now.trim();

    int? price;
    int? capacity;
    bool clearCapacity = false;
    DateTime? eventAt;
    DateTime? salesCloseAt;

    if (!_frozen) {
      final p = _priceMinor;
      if (p == null) {
        setState(() => _error = 'Enter a ticket price.');
        return;
      }
      if (p != e.unitPriceMinor.toInt()) price = p;

      final raw = _capacity.text.trim();
      if (raw.isEmpty && e.hasCapacity()) {
        clearCapacity = true; // "make it unlimited"
      } else if (raw.isNotEmpty) {
        final c = int.tryParse(raw);
        if (c == null || c < 1) {
          setState(() => _error =
              'Capacity must be at least 1 — leave it empty for unlimited.');
          return;
        }
        if (!e.hasCapacity() || c != e.capacity) capacity = c;
      }

      if (_eventAt != null &&
          (!e.hasEventAt() || _eventAt != e.eventAt.toDateTime())) {
        eventAt = _eventAt;
      }
      if (_salesCloseAt != null &&
          (!e.hasSalesCloseAt() ||
              _salesCloseAt != e.salesCloseAt.toDateTime())) {
        salesCloseAt = _salesCloseAt;
      }
      if (_eventAt != null &&
          _salesCloseAt != null &&
          _salesCloseAt!.isAfter(_eventAt!)) {
        setState(
            () => _error = 'Sales must close by the time the event starts.');
        return;
      }
    }

    setState(() => _error = null);
    cubit.saveEdits(
      eventId: e.id,
      title: ifChanged(_title.text, e.title),
      venue: ifChanged(_venue.text, e.venue),
      description: ifChanged(_description.text, e.description),
      unitPriceMinor: price,
      capacity: capacity,
      clearCapacity: clearCapacity,
      eventAt: eventAt,
      salesCloseAt: salesCloseAt,
      organiserName: ifChanged(_organiserName.text, e.organiserName),
      organiserSocials: _socialsChanged() ? _socialsNow() : null,
      // SENT ONLY WHEN CHANGED, like every other field here: the update is
      // flag-gated server-side, so sending an unchanged value is a needless
      // rewrite and sending nothing leaves it alone. Compared against the
      // event's own slug, with '' standing in for "was never set".
      category:
          (_category ?? '') == widget.event.category ? null : (_category ?? ''),
      state:
          (_stateSlug ?? '') == widget.event.state ? null : (_stateSlug ?? ''),
    );
  }

  Map<String, String> _socialsNow() => {
        for (final entry in _socials.entries)
          if (entry.value.text.trim().isNotEmpty)
            entry.key: entry.value.text.trim(),
      };

  /// Whether the handles differ from what the event carries.
  ///
  /// Compared as maps rather than per field, because the update REPLACES the
  /// stored set: sending it when nothing changed would be a needless rewrite,
  /// and NOT sending it when a handle was deleted would silently keep the
  /// deleted one.
  bool _socialsChanged() {
    final now = _socialsNow();
    final before = widget.event.organiserSocials;
    if (now.length != before.length) return true;
    for (final e in now.entries) {
      if (before[e.key] != e.value) return true;
    }
    return false;
  }

  Future<void> _pickDateTime({required bool forSalesClose}) async {
    final now = DateTime.now();
    final seed =
        forSalesClose ? (_salesCloseAt ?? _eventAt ?? now) : (_eventAt ?? now);
    final date = await showDatePicker(
      context: context,
      initialDate: seed.isBefore(now) ? now : seed,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 2)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(seed),
    );
    if (!mounted) return;
    final picked = DateTime(date.year, date.month, date.day,
        time?.hour ?? seed.hour, time?.minute ?? seed.minute);
    setState(() {
      if (forSalesClose) {
        _salesCloseAt = picked;
      } else {
        _eventAt = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TicketingTheme.bg,
      appBar: AppBar(
        backgroundColor: TicketingTheme.bg,
        foregroundColor: TicketingTheme.onBar,
        elevation: 0,
        title: Text('Edit event',
            style: GoogleFonts.inter(
                fontSize: 18.sp, fontWeight: FontWeight.w700)),
      ),
      body: BlocConsumer<TicketingCubit, TicketingState>(
        listener: (context, state) {
          if (state is TicketEventSaved) {
            Get.back(result: true);
          }
          if (state is TicketingFailure) {
            setState(() => _error = state.message);
          }
        },
        builder: (context, state) {
          if (state is TicketingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_frozen)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: TicketingTheme.warning.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${widget.event.ticketsSold} '
                      '${widget.event.ticketsSold == 1 ? "ticket has" : "tickets have"} '
                      'been sold, so the price, capacity and dates are fixed — '
                      'buyers have already paid against them. You can still '
                      'change the name, venue and description.',
                      style: GoogleFonts.inter(
                          fontSize: 12.5.sp, color: TicketingTheme.warning),
                    ),
                  ),
                _field(_title, 'Event name'),
                _field(_venue, 'Venue'),
                // THE BROWSE AXES, through the shared field so this screen,
                // the create wizard and the catalogue's filter chips cannot
                // disagree about what an unknown slug or an empty list means.
                //
                // Not gated on [_frozen]: see the field declarations.
                EventAxisField(
                  label: 'Category',
                  icon: Icons.category_outlined,
                  placeholder: 'What kind of event is it?',
                  options: axisOptions(_config?.categories ?? const []),
                  current: _category,
                  onPicked: (v) => setState(() {
                    _category = v;
                    _error = null;
                  }),
                  onUnavailable: () => setState(
                      () => _error = 'Still loading the category list. '
                          'Try again in a moment.'),
                ),
                EventAxisField(
                  label: 'State',
                  icon: Icons.location_on_outlined,
                  placeholder: 'Which state is it in?',
                  options: axisOptions(_config?.states ?? const []),
                  current: _stateSlug,
                  onPicked: (v) => setState(() {
                    _stateSlug = v;
                    _error = null;
                  }),
                  onUnavailable: () =>
                      setState(() => _error = 'Still loading the state list. '
                          'Try again in a moment.'),
                ),
                _field(_organiserName, 'Hosted by (optional)'),
                OrganiserSocialsField(
                  controllers: _socials,
                  open: _socialsOpen,
                  onToggle: () => setState(() => _socialsOpen = !_socialsOpen),
                  onChanged: () => setState(() {}),
                ),
                _field(_description, 'Description', maxLines: 3),
                _field(_price, 'Ticket price',
                    enabled: !_frozen,
                    keyboard: TextInputType.number,
                    formatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))
                    ]),
                _field(_capacity, 'Capacity (empty = unlimited)',
                    enabled: !_frozen,
                    keyboard: TextInputType.number,
                    formatters: [FilteringTextInputFormatter.digitsOnly]),
                _dateRow(
                  label: 'When is it?',
                  value: _eventAt,
                  enabled: !_frozen,
                  onTap: () => _pickDateTime(forSalesClose: false),
                ),
                _dateRow(
                  label: 'Stop selling',
                  value: _salesCloseAt,
                  enabled: !_frozen,
                  onTap: () => _pickDateTime(forSalesClose: true),
                ),
                if (_error != null) ...[
                  SizedBox(height: 10.h),
                  Text(_error!,
                      style: GoogleFonts.inter(
                          fontSize: 12.5.sp, color: TicketingTheme.error)),
                ],
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TicketingTheme.cta,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                      elevation: 0,
                    ),
                    onPressed: _save,
                    child: Text('Save changes',
                        style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// One field, THROUGH THE SHARED KIT.
  ///
  /// This was a hand-rolled bordered TextField — the same idea as the create
  /// wizard's fields in a different dialect, so the two forms for one object
  /// did not look like the same product. The kit owns the gradient card, the
  /// padlock and the disabled colour; what stays here is only which controller
  /// goes with which label.
  Widget _field(
    TextEditingController c,
    String label, {
    int maxLines = 1,
    bool enabled = true,
    TextInputType? keyboard,
    List<TextInputFormatter>? formatters,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: EventTextField(
        label: label,
        controller: c,
        // The edit form is pre-filled, so a hint would only ever show after
        // somebody cleared a field — at which point the LABEL is the thing
        // that says what belongs there.
        hint: '',
        maxLines: maxLines,
        enabled: enabled,
        keyboardType: keyboard,
        formatters: formatters,
      ),
    );
  }

  Widget _dateRow({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: EventPickerField(
        label: label,
        icon: Icons.event_outlined,
        enabled: enabled,
        value: value == null
            ? null
            : DateFormat('EEE d MMM y, h:mm a').format(value),
        placeholder: 'Choose',
        onTap: onTap,
      ),
    );
  }
}
