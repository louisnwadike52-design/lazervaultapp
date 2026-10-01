import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Reactive fetch-state for a bill option list (data plans, cable packages,
/// education products, internet plans, …). Lets a picker sheet render the four
/// states — loading / error / empty / loaded — LIVE, so a sheet opened while the
/// list is still loading updates itself instead of showing a spinner forever (or
/// a permanent "none available" when the fetch actually failed).
@immutable
class BillListFetchState<T> {
  final bool loading;
  final String? error;
  final List<T> items;

  const BillListFetchState.idle()
      : loading = false,
        error = null,
        items = const [];
  const BillListFetchState.loading()
      : loading = true,
        error = null,
        items = const [];
  const BillListFetchState.loaded(this.items)
      : loading = false,
        error = null;
  const BillListFetchState.failed(this.error)
      : loading = false,
        items = const [];
}

/// One filter pill for [BillListPickerSheet]: a [label] and a [test] that keeps
/// the items belonging to that filter. The first entry is the default (usually
/// an "All" pass-through).
typedef BillListFilter<T> = ({String label, bool Function(T item) test});

/// A styled, LIVE-updating bottom sheet that picks one option from a fetched
/// list. Reused by every bill-pay QuickBuy flow so the loading / error / empty /
/// list presentation (and its alignment + contrast) is consistent.
///
/// Optionally shows a row of [filters] pills above the list (e.g. data-plan
/// Daily/Weekly/Monthly) that filter the fetched items client-side.
///
/// Pops the picked item (of type [T]) via `Navigator.pop(context, item)`; pops
/// null on close. Drives its body off a [ValueListenable] of
/// [BillListFetchState] so it reflects the fetch as it completes.
class BillListPickerSheet<T> extends StatefulWidget {
  const BillListPickerSheet({
    super.key,
    required this.title,
    required this.icon,
    required this.accent,
    required this.listenable,
    required this.labelOf,
    required this.trailingOf,
    this.subtitleOf,
    this.leadingOf,
    this.emptyLabel = 'Nothing available right now',
    this.onRetry,
    this.filters,
    this.secondaryFilters,
    this.searchHint,
    this.searchMinimum = 8,
  });

  final String title;
  final IconData icon;
  final Color accent;
  final ValueListenable<BillListFetchState<T>> listenable;

  /// Primary line for each row (e.g. the plan/package name).
  final String Function(T item) labelOf;

  /// Right-aligned trailing text for each row (e.g. the ₦ price).
  final String Function(T item) trailingOf;

  /// Optional secondary line under [labelOf] (e.g. validity/duration).
  final String? Function(T item)? subtitleOf;

  /// Optional leading widget for each row (e.g. a [BillerLogo] brand mark for a
  /// disco/provider list). When null, no leading slot is rendered.
  final Widget Function(T item)? leadingOf;

  final String emptyLabel;

  /// Shown as a "Try again" action in the error state. When null, no retry.
  final VoidCallback? onRetry;

  /// Optional filter pills. When null/empty, no pill row is shown.
  final List<BillListFilter<T>>? filters;

  /// A SECOND, independent row of pills, ANDed with [filters].
  ///
  /// Two axes rather than one long row because they answer different questions
  /// and a shopper uses both: "how long does it last" (daily/weekly/monthly) and
  /// "how much data is it" (a size range). Flattening them into one row would
  /// force a choice between the two and make most combinations unreachable.
  ///
  /// Like [filters], the first entry is the "All" pass-through.
  final List<BillListFilter<T>>? secondaryFilters;

  /// Placeholder for the search field. Null keeps the generic wording.
  ///
  /// Search narrows WITHIN the active pills rather than replacing them: a
  /// shopper who has picked "Monthly" and types "5" wants monthly 5GB plans,
  /// not every plan whose name contains a 5.
  final String? searchHint;

  /// Below this many fetched items the search field is not rendered — a field
  /// over a list you can already see is clutter. MTN alone returns 82 plans,
  /// which is why it exists at all.
  final int searchMinimum;

  @override
  State<BillListPickerSheet<T>> createState() => _BillListPickerSheetState<T>();
}

class _BillListPickerSheetState<T> extends State<BillListPickerSheet<T>> {
  static const _bg = Color(0xFF141414);
  static const _muted = Color(0xFF9CA3AF);
  static const _divider = Color(0xFF2D2D2D);
  static const _price = Color(0xFF10B981);

  int _filterIndex = 0;
  int _secondaryIndex = 0;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Case-insensitive substring match over the row's visible text — the label
  /// and the trailing price, because "1700" is how someone looks for a plan
  /// by what it costs. Whitespace-insensitive on the needle only, so "1 gb"
  /// and "1gb" both find "1GB (SME)".
  bool _matchesQuery(T item) {
    if (_query.isEmpty) return true;
    final hay = '${widget.labelOf(item)} ${widget.trailingOf(item)} '
            '${widget.subtitleOf?.call(item) ?? ''}'
        .toLowerCase()
        .replaceAll(' ', '');
    return hay.contains(_query);
  }

  String get title => widget.title;
  IconData get icon => widget.icon;
  Color get accent => widget.accent;
  String get emptyLabel => widget.emptyLabel;
  VoidCallback? get onRetry => widget.onRetry;
  ValueListenable<BillListFetchState<T>> get listenable => widget.listenable;
  String Function(T item) get labelOf => widget.labelOf;
  String Function(T item) get trailingOf => widget.trailingOf;
  String? Function(T item)? get subtitleOf => widget.subtitleOf;
  Widget Function(T item)? get leadingOf => widget.leadingOf;

  /// Names EVERY active filter when a combination matches nothing.
  ///
  /// "No plans in this filter" when two are active sends the user to clear the
  /// wrong one — they drop the duration, see the list stay empty, and conclude
  /// the network has nothing.
  String _noMatchLabel(
    List<BillListFilter<T>>? primary,
    List<BillListFilter<T>>? secondary,
  ) {
    final active = <String>[];
    if (primary != null && _filterIndex > 0 && _filterIndex < primary.length) {
      active.add(primary[_filterIndex].label);
    }
    if (secondary != null &&
        _secondaryIndex > 0 &&
        _secondaryIndex < secondary.length) {
      active.add(secondary[_secondaryIndex].label);
    }
    if (active.isEmpty) return 'No plans in this filter';
    return 'No ${active.join(' + ')} plans. Try another filter.';
  }

  /// One horizontally-scrolling row of pills, at the header's inset.
  Widget _pillRow(List<Widget> pills) => SizedBox(
        height: 38.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: pills,
        ),
      );

  Widget _filterPill(String label, int index, {bool secondary = false}) {
    final selected = index == (secondary ? _secondaryIndex : _filterIndex);
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: () => setState(() {
          if (secondary) {
            _secondaryIndex = index;
          } else {
            _filterIndex = index;
          }
        }),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: selected ? accent : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: selected ? accent : _divider),
          ),
          child: Text(label,
              style: GoogleFonts.inter(
                  color: selected ? Colors.white : _muted,
                  fontSize: 13.sp,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filters = widget.filters;
    final secondaryFilters = widget.secondaryFilters;
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(children: [
        SizedBox(height: 10.h),
        Container(
          width: 40.w,
          height: 4.h,
          decoration: BoxDecoration(
              color: Colors.white24, borderRadius: BorderRadius.circular(2.r)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 12.w, 8.h),
          child: Row(children: [
            Icon(icon, color: accent, size: 18.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close, color: Colors.grey[500], size: 22.sp),
            ),
          ]),
        ),
        // Both pill rows share ONE height and ONE inset.
        //
        // They were 40.h and 36.h with no gap and a 16.w inset under a 20.w
        // title, so the two rows sat at different sizes, touching each other
        // and starting left of everything above them. Same height, same inset
        // as the header, and a real gap between: the rows read as two axes of
        // one control rather than two controls that nearly line up.
        if (filters != null && filters.isNotEmpty)
          _pillRow([
            for (var i = 0; i < filters.length; i++)
              _filterPill(filters[i].label, i),
          ]),
        if (secondaryFilters != null && secondaryFilters.isNotEmpty) ...[
          SizedBox(height: 8.h),
          _pillRow([
            for (var i = 0; i < secondaryFilters.length; i++)
              _filterPill(secondaryFilters[i].label, i, secondary: true),
          ]),
        ],
        ValueListenableBuilder<BillListFetchState<T>>(
          valueListenable: listenable,
          builder: (context, state, _) {
            if (state.items.length < widget.searchMinimum) {
              return SizedBox(height: 4.h);
            }
            return Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 2.h),
              child: TextField(
                key: const Key('bill_list_search'),
                controller: _searchController,
                onChanged: (v) => setState(
                    () => _query = v.trim().toLowerCase().replaceAll(' ', '')),
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.searchHint ??
                      'Search ${state.items.length} options',
                  hintStyle:
                      GoogleFonts.inter(color: _muted, fontSize: 13.5.sp),
                  prefixIcon: Icon(Icons.search, color: _muted, size: 19.sp),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: Icon(Icons.close, color: _muted, size: 18.sp),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                  filled: true,
                  fillColor: const Color(0xFF1F1F1F),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: _divider),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: _divider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: accent),
                  ),
                ),
              ),
            );
          },
        ),
        Expanded(
          child: ValueListenableBuilder<BillListFetchState<T>>(
            valueListenable: listenable,
            builder: (context, state, _) {
              if (state.loading) {
                return Center(child: LazerVaultLoader.small());
              }
              if (state.error != null) {
                return _ErrorState(
                  message: state.error!,
                  accent: accent,
                  onRetry: onRetry,
                );
              }
              // Apply BOTH active pills. They are independent axes, so they
              // narrow together — picking "Weekly" and "1–2GB" means weekly
              // plans that are also 1–2GB, not one or the other.
              var items = state.items;
              if (filters != null &&
                  filters.isNotEmpty &&
                  _filterIndex < filters.length) {
                items = items.where(filters[_filterIndex].test).toList();
              }
              if (secondaryFilters != null &&
                  secondaryFilters.isNotEmpty &&
                  _secondaryIndex < secondaryFilters.length) {
                items = items
                    .where(secondaryFilters[_secondaryIndex].test)
                    .toList();
              }
              // Search narrows WITHIN the pills, it does not replace them.
              items = items.where(_matchesQuery).toList();
              if (items.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                        state.items.isEmpty
                            ? emptyLabel
                            : _query.isNotEmpty
                                ? 'Nothing matches "${_searchController.text.trim()}"'
                                    '${_filterIndex > 0 || _secondaryIndex > 0 ? ' in this filter' : ''}.'
                                : _noMatchLabel(filters, secondaryFilters),
                        textAlign: TextAlign.center,
                        style:
                            GoogleFonts.inter(color: _muted, fontSize: 14.sp)),
                  ),
                );
              }
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: items.length,
                separatorBuilder: (_, __) => Divider(
                    color: _divider, height: 1, indent: 4.w, endIndent: 4.w),
                itemBuilder: (_, i) {
                  final item = items[i];
                  final sub = subtitleOf?.call(item);
                  return InkWell(
                    onTap: () => Navigator.of(context).pop(item),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (leadingOf != null) ...[
                            leadingOf!(item),
                            SizedBox(width: 12.w),
                          ],
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(labelOf(item),
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14.5.sp,
                                        fontWeight: FontWeight.w600)),
                                if (sub != null && sub.isNotEmpty) ...[
                                  SizedBox(height: 3.h),
                                  Text(sub,
                                      style: GoogleFonts.inter(
                                          color: _muted, fontSize: 12.sp)),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(trailingOf(item),
                              style: GoogleFonts.inter(
                                  color: _price,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
      ]),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState(
      {required this.message, required this.accent, this.onRetry});

  final String message;
  final Color accent;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off_rounded,
                color: const Color(0xFFEF4444), size: 34.sp),
            SizedBox(height: 12.h),
            Text(message,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              TextButton(
                onPressed: onRetry,
                child: Text('Try again',
                    style: GoogleFonts.inter(
                        color: accent,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
