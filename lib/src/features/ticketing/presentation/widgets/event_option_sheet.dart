import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'event_form_kit.dart';
import 'ticketing_theme.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// A searchable single-choice sheet, for the category and location pickers.
///
/// SEARCHABLE BECAUSE ONE OF THE LISTS HAS THIRTY-SEVEN ENTRIES. Scrolling to
/// Zamfara past thirty-six others is the kind of small friction that gets an
/// organiser to pick whatever is near the top instead, which quietly ruins the
/// data the whole filter depends on.
///
/// Returns the chosen value, or null when dismissed — a dismissal is not a
/// choice and must not clear what was already set.
class EventOptionSheet {
  const EventOptionSheet._();

  static Future<String?> open(
    BuildContext context, {
    required String title,
    required List<({String value, String label})> options,
    String? current,
  }) {
    return showAppBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _OptionSheetBody(
        title: title,
        options: options,
        current: current,
      ),
    );
  }
}

class _OptionSheetBody extends StatefulWidget {
  const _OptionSheetBody({
    required this.title,
    required this.options,
    required this.current,
  });

  final String title;
  final List<({String value, String label})> options;
  final String? current;

  @override
  State<_OptionSheetBody> createState() => _OptionSheetBodyState();
}

class _OptionSheetBodyState extends State<_OptionSheetBody> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _search.addListener(
        () => setState(() => _query = _search.text.trim().toLowerCase()));
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matches = _query.isEmpty
        ? widget.options
        : widget.options
            .where((o) => o.label.toLowerCase().contains(_query))
            .toList();
    return Container(
      // Bounded so a 37-entry list does not push the drag handle off screen,
      // and so the sheet still looks like a sheet on a short list.
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: TicketingTheme.bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        border: Border.all(color: TicketingTheme.border),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 42.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: TicketingTheme.handle,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          EventFieldCard(
            child: TextField(
              controller: _search,
              style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: 'Search',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
                icon: Icon(Icons.search_rounded,
                    color: const Color(0xFF9CA3AF), size: 20.sp),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Flexible(
            child: matches.isEmpty
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 28.h),
                    child: Text(
                      'Nothing matches "${_search.text.trim()}"',
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: TicketingTheme.textSecondary,
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: matches.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (ctx, i) {
                      final o = matches[i];
                      final selected = o.value == widget.current;
                      return InkWell(
                        borderRadius: BorderRadius.circular(12.r),
                        onTap: () => Navigator.of(ctx).pop(o.value),
                        child: EventFieldCard(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 13.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  o.label,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: selected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              if (selected)
                                Icon(Icons.check_circle_rounded,
                                    size: 20.sp, color: TicketingTheme.ticket),
                            ],
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
