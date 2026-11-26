import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import '../cubit/ticketing_cubit.dart';
import '../cubit/ticketing_state.dart';
import '../widgets/event_axis_field.dart';
import '../widgets/event_form_kit.dart';
import 'package:lazervault/core/shared_widgets/load_more_footer.dart'
    show ScrollEndLoader;
import '../widgets/events_catalogue_chrome.dart';
import '../widgets/load_more_footer.dart';
import '../widgets/ticket_event_card.dart';
import '../widgets/ticketing_theme.dart';

/// EVENTS — the buyer's entry point.
///
/// Shows only what can actually be bought: the server's discover query excludes
/// drafts, sold-out, closed and past events, so a card tapped from here does
/// not meet a refusal at the moment of payment. That filtering is deliberately
/// NOT repeated in the app — two copies of "is this buyable" drift, and the
/// claim inside the purchase transaction is the only authority anyway.
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key, this.organiser = ''});

  /// When set, this is a HOST PAGE: one organiser's whole programme rather
  /// than the open discover list. It changes the title, drops the create-event
  /// FAB (you are looking at someone else's listing) and is carried into every
  /// subsequent load so paging and refresh keep the filter.
  final String organiser;

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final _search = TextEditingController();
  String _query = '';

  /// The chosen browse axes, as SLUGS. Null = not narrowed on that axis.
  String? _category;
  String? _state;

  /// The operator's own lists, from the config.
  ///
  /// NOT HARDCODED and not derivable from the loaded events: a category with
  /// no events yet must still be offerable, or a new one can never get its
  /// first listing. Null until the read lands, which is why the chips render
  /// nothing rather than an empty row.
  tk.GetTicketingConfigResponse? _config;

  bool get _isHostPage => widget.organiser.trim().isNotEmpty;

  /// Every load goes through here so the host filter cannot be dropped by one
  /// call site — the bug this shape exists to prevent is a "load more" that
  /// silently returns the whole catalogue.
  void _load({int page = 1}) {
    context.read<TicketingCubit>().loadEvents(
          search: _query,
          page: page,
          organiser: widget.organiser.trim(),
          category: _category ?? '',
          state: _state ?? '',
        );
  }

  @override
  void initState() {
    super.initState();
    _load();
    _loadConfig();
  }

  /// Reads the browse axes.
  ///
  /// SEPARATE FROM THE LISTING, and failing quietly: the catalogue is usable
  /// with no filters, so a config read that does not land must not stop the
  /// events arriving. The chips simply do not appear.
  Future<void> _loadConfig() async {
    try {
      final cfg = await context.read<TicketingCubit>().fetchConfig();
      if (!mounted || cfg == null) return;
      setState(() => _config = cfg);
    } catch (_) {
      // Deliberately silent — see above.
    }
  }

  /// Opens one axis' picker and reloads.
  ///
  /// RELOADS FROM PAGE ONE. Keeping the page would ask the server for page
  /// three of a query that has just changed, and the footer would then be
  /// counting against a total for a different filter.
  Future<void> _pickAxis({
    required String title,
    required List<({String value, String label})> options,
    required String? current,
    required ValueChanged<String?> onPicked,
  }) async {
    if (options.isEmpty) return;
    final picked = await EventOptionSheet.open(
      context,
      title: title,
      // "Any" is an OPTION, not a separate clear button: clearing a filter is
      // the same gesture as changing it, and a chip with an x beside a chip
      // that opens a sheet is two affordances for one decision.
      options: [(value: '', label: 'Any $title'), ...options],
      current: current ?? '',
    );
    if (!mounted || picked == null) return;
    onPicked(picked.isEmpty ? null : picked);
    _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _runSearch(String q) {
    setState(() => _query = q);
    _load();
  }

  void _openHost(String host) {
    // From a host page, tapping the same host again would push an identical
    // route onto itself.
    if (host.trim().toLowerCase() == widget.organiser.trim().toLowerCase()) {
      return;
    }
    Get.toNamed(AppRoutes.ticketingHostFor(host));
  }

  bool get _hasFilters =>
      _category != null || _state != null || _query.trim().isNotEmpty;

  /// What an empty list actually means right now.
  ///
  /// Builds the sentence from whatever is narrowing the query, so a buyer can
  /// tell "nothing in Comedy in Lagos" from "nothing at all" — and knows
  /// which part to relax.
  String _emptyMessage() {
    final cat =
        axisLabel(axisOptions(_config?.categories ?? const []), _category);
    final st = axisLabel(axisOptions(_config?.states ?? const []), _state);
    final bits = <String>[
      if (_query.trim().isNotEmpty) '“${_query.trim()}”',
      if (cat != null) cat,
      if (st != null) 'in $st',
    ];
    if (bits.isEmpty) {
      return _isHostPage
          ? '${widget.organiser.trim()} has nothing on sale right now.'
          : 'No events are on sale right now.';
    }
    return 'Nothing on sale for ${bits.join(' ')}.';
  }

  void _clearFilters() {
    setState(() {
      _category = null;
      _state = null;
      _query = '';
      _search.clear();
    });
    _load();
  }

  /// "Comedy in Lagos" — the two axes, side by side.
  ///
  /// TWO CHIPS RATHER THAN A SCROLLING STRIP OF EVERY CATEGORY. One of the
  /// lists has thirty-seven entries, so a strip would either truncate it (and
  /// hide whatever is past the edge) or scroll sideways past the search box.
  /// A chip that says what is selected, opening a searchable sheet, scales to
  /// a list the operator keeps adding to — which is the whole premise of the
  /// lists being settings.
  ///
  /// HIDDEN ON A HOST PAGE. That page is one organiser's whole programme and
  /// is already narrow; filtering it by state would mostly produce an empty
  /// list, and the question there is "what else are they putting on", not
  /// "what is near me".
  Widget _filterChips() {
    if (_isHostPage) return const SizedBox.shrink();
    final categories = axisOptions(_config?.categories ?? const []);
    final states = axisOptions(_config?.states ?? const []);
    // Nothing to offer until the config lands. An empty row of chips that do
    // nothing reads worse than no row.
    if (categories.isEmpty && states.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      child: Row(
        children: [
          if (categories.isNotEmpty)
            Expanded(
              child: EventsFilterChip(
                icon: Icons.category_outlined,
                label: axisLabel(categories, _category) ?? 'Any category',
                active: _category != null,
                onTap: () => _pickAxis(
                  title: 'category',
                  options: categories,
                  current: _category,
                  onPicked: (v) => setState(() => _category = v),
                ),
              ),
            ),
          if (categories.isNotEmpty && states.isNotEmpty) SizedBox(width: 10.w),
          if (states.isNotEmpty)
            Expanded(
              child: EventsFilterChip(
                icon: Icons.location_on_outlined,
                label: axisLabel(states, _state) ?? 'Anywhere',
                active: _state != null,
                onTap: () => _pickAxis(
                  title: 'state',
                  options: states,
                  current: _state,
                  onPicked: (v) => setState(() => _state = v),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TicketingTheme.bg,
      appBar: AppBar(
        backgroundColor: TicketingTheme.bg,
        foregroundColor: TicketingTheme.onBar,
        elevation: 0,
        title: Text(_isHostPage ? widget.organiser.trim() : 'Events',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
                fontSize: 18.sp, fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            tooltip: 'My tickets',
            icon: const Icon(Icons.confirmation_num_outlined),
            onPressed: () => Get.toNamed(AppRoutes.ticketingMyTickets),
          ),
          IconButton(
            tooltip: 'My events',
            icon: const Icon(Icons.event_note_outlined),
            onPressed: () => Get.toNamed(AppRoutes.ticketingMyEvents),
          ),
        ],
      ),
      // No create-event CTA on someone else's host page: the action there is
      // to buy, and a "Create event" button under another host's name reads as
      // creating an event FOR them.
      floatingActionButton: _isHostPage
          ? null
          : FloatingActionButton.extended(
              backgroundColor: TicketingTheme.cta,
              // The label and icon inherit the THEME's FAB foreground when this is
              // unset, which on the light theme is a dark colour — on a filled
              // purple CTA. Same inheritance that made the app bars disappear; a
              // filled control has to state both halves of its own contrast.
              foregroundColor: TicketingTheme.onBar,
              onPressed: () => Get.toNamed(AppRoutes.ticketingCreate),
              icon: const Icon(Icons.add),
              label: Text('Create event',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
            ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
            child: TextField(
              controller: _search,
              onSubmitted: _runSearch,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: _isHostPage
                    ? 'Search this host\u2019s events'
                    : 'Search events, venues or hosts',
                hintStyle: GoogleFonts.inter(
                    color: TicketingTheme.textSecondary, fontSize: 14.sp),
                prefixIcon: const Icon(Icons.search,
                    color: TicketingTheme.textSecondary),
                filled: true,
                fillColor: TicketingTheme.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          _filterChips(),
          Expanded(
            child: BlocBuilder<TicketingCubit, TicketingState>(
              builder: (context, state) {
                if (state is TicketingLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TicketingFailure) {
                  return EventsMessage(
                    icon: Icons.error_outline,
                    text: state.message,
                    // A REFUSAL GETS NO RETRY BUTTON. Retrying one fails
                    // identically, so the button would only invite tapping.
                    onRetry: state.isRetryable ? () => _load() : null,
                  );
                }
                if (state is! TicketEventsLoaded) {
                  return const SizedBox.shrink();
                }
                if (state.events.isEmpty) {
                  // THE MESSAGE HAS TO NAME THE FILTER.
                  //
                  // "No events are on sale right now" under an active
                  // Comedy-in-Lagos filter is false about the catalogue and
                  // reads as the product being empty — the one conclusion a
                  // buyer should not draw from a narrow search. So the copy
                  // says what was asked for, and offers to widen it.
                  return EventsMessage(
                    icon: Icons.event_busy_outlined,
                    text: _emptyMessage(),
                    onRetry: _hasFilters ? _clearFilters : null,
                    retryLabel: _hasFilters ? 'Clear filters' : null,
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async => _load(),
                  // SCROLL TO THE BOTTOM AND THE NEXT PAGE ARRIVES.
                  //
                  // The footer below stays pressable and keeps saying how many
                  // remain: a list already at its end generates no further
                  // scroll notification, so a page that FAILED would otherwise
                  // be unreachable.
                  //
                  // The axis filters ride on `state`, and `_load` reads them
                  // back from it — a load-more that dropped them would quietly
                  // append the whole catalogue under a "Comedy in Lagos" chip.
                  child: ScrollEndLoader(
                    hasMore: state.events.length < state.total,
                    loading: context.read<TicketingCubit>().isPaging('events'),
                    onReachEnd: () => _load(page: state.page + 1),
                    child: ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 96.h),
                      // +1 for the footer row.
                      itemCount: state.events.length + 1,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (_, i) {
                        if (i == state.events.length) {
                          return LoadMoreFooter(
                            loaded: state.events.length,
                            total: state.total,
                            onLoadMore: () => _load(page: state.page + 1),
                          );
                        }
                        final tk.TicketEvent e = state.events[i];
                        return TicketEventCard(
                          event: e,
                          // Tapping the host name opens that host's programme.
                          // Suppressed on a host page — see _openHost.
                          onOrganiserTap: _openHost,
                          // AWAITED, then the list reloads. A buyer who takes the
                          // last two tickets and comes back would otherwise be
                          // looking at "2 left" on an event that now has none —
                          // and would tap it, and be told sold out at the till.
                          onTap: () async {
                            await Get.toNamed(
                              AppRoutes.ticketingDetail
                                  .replaceFirst(':eventId', e.id),
                            );
                            if (!context.mounted) return;
                            _load();
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
