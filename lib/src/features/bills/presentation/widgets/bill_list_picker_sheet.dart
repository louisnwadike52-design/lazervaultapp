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

  @override
  State<BillListPickerSheet<T>> createState() => _BillListPickerSheetState<T>();
}

class _BillListPickerSheetState<T> extends State<BillListPickerSheet<T>> {
  static const _bg = Color(0xFF141414);
  static const _muted = Color(0xFF9CA3AF);
  static const _divider = Color(0xFF2D2D2D);
  static const _price = Color(0xFF10B981);

  int _filterIndex = 0;

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

  Widget _filterPill(String label, int index) {
    final selected = index == _filterIndex;
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: GestureDetector(
        onTap: () => setState(() => _filterIndex = index),
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
        if (filters != null && filters.isNotEmpty)
          SizedBox(
            height: 40.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                for (var i = 0; i < filters.length; i++)
                  _filterPill(filters[i].label, i),
              ],
            ),
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
              // Apply the active filter pill (if any) to the fetched items.
              final items = (filters != null &&
                      filters.isNotEmpty &&
                      _filterIndex < filters.length)
                  ? state.items.where(filters[_filterIndex].test).toList()
                  : state.items;
              if (items.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                        state.items.isEmpty
                            ? emptyLabel
                            : 'No plans in this filter',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            color: _muted, fontSize: 14.sp)),
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
  const _ErrorState({required this.message, required this.accent, this.onRetry});

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
