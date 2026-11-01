import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/widgets/biller_logo.dart';
import '../../domain/entities/betting_entities.dart';
import '../view/betting_theme.dart';

/// Pick a bookmaker from a searchable sheet.
///
/// WHY NOT THE GRID IT REPLACES. Fourteen bookmakers rendered as wrapped
/// chips filled most of the screen before the user reached the fields that
/// actually take input — account id, amount, phone — so funding a bet began
/// with a scroll past a wall of logos. The list also only grows: every
/// bookmaker added pushes the form further down.
///
/// A single row showing the current choice keeps the form one screen, and the
/// sheet gives the list room plus a search box, which is what you want once
/// there are more names than fit a glance.
Future<BettingPlatform?> showBettingPlatformSheet(
  BuildContext context, {
  required List<BettingPlatform> platforms,
  BettingPlatform? selected,
}) {
  return showModalBottomSheet<BettingPlatform>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _BettingPlatformSheet(
      platforms: platforms,
      selected: selected,
    ),
  );
}

class _BettingPlatformSheet extends StatefulWidget {
  const _BettingPlatformSheet({required this.platforms, this.selected});

  final List<BettingPlatform> platforms;
  final BettingPlatform? selected;

  @override
  State<_BettingPlatformSheet> createState() => _BettingPlatformSheetState();
}

class _BettingPlatformSheetState extends State<_BettingPlatformSheet> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<BettingPlatform> get _visible {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return widget.platforms;
    return widget.platforms
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.code.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible;
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      expand: false,
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
          color: BettingTheme.bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: BettingTheme.divider,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Choose a platform',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.platforms.length}',
                    style: GoogleFonts.inter(
                      color: BettingTheme.textSecondary,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            // Search earns its place once the list outgrows a glance, which
            // it already has.
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  color: BettingTheme.card,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: BettingTheme.divider),
                ),
                child: TextField(
                  controller: _search,
                  onChanged: (v) => setState(() => _query = v),
                  style:
                      GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: 'Search bookmakers',
                    hintStyle: GoogleFonts.inter(
                        color: BettingTheme.textSecondary, fontSize: 14.sp),
                    prefixIcon: Icon(Icons.search,
                        color: BettingTheme.textSecondary, size: 19.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 13.h),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: visible.isEmpty
                  ? Center(
                      child: Text(
                        'No bookmaker matches "${_search.text.trim()}"',
                        style: GoogleFonts.inter(
                            color: BettingTheme.textSecondary,
                            fontSize: 13.sp),
                      ),
                    )
                  : ListView.separated(
                      controller: controller,
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                      itemCount: visible.length,
                      separatorBuilder: (_, __) => SizedBox(height: 8.h),
                      itemBuilder: (_, i) {
                        final p = visible[i];
                        final isSelected = widget.selected?.code == p.code;
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pop(p),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 13.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? BettingTheme.primary.withValues(alpha: 0.16)
                                  : BettingTheme.card,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isSelected
                                    ? BettingTheme.primary
                                    : BettingTheme.divider,
                              ),
                            ),
                            child: Row(
                              children: [
                                BillerLogo(
                                  code: p.code,
                                  name: p.name,
                                  logoUrl: p.logoUrl,
                                  size: 28,
                                  borderRadius: 7,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    p.name,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(Icons.check_circle,
                                      color: BettingTheme.primary, size: 19.sp),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
