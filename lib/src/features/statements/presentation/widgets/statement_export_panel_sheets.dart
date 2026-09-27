part of 'statement_export_panel.dart';

/// The modal surfaces of [StatementExportPanel]: the date-range picker and
/// the post-download actions, plus the recent-statement tiles that replay a
/// previous request. Split from the inline widgets purely for file size —
/// they share the same state and palette.
extension _StatementExportPanelSheets on _StatementExportPanelState {
  Future<void> _pickRange() async {
    final now = DateTime.now();
    final earliest = DateTime(2000);
    DateTime? start = _startDate;
    DateTime? end = _endDate;

    final applied = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: _sheetBackground,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => StatefulBuilder(
        builder: (sheetCtx, setSheet) {
          Widget dateField(String label, DateTime? value, VoidCallback onTap) {
            return Expanded(
              child: InkWell(
                onTap: onTap,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: _surface,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: _border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: GoogleFonts.inter(
                              fontSize: 11.sp, color: _mutedText)),
                      SizedBox(height: 4.h),
                      Text(
                        value != null
                            ? DateFormat('MMM dd, yyyy').format(value)
                            : 'Select',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: value != null ? _primaryText : _mutedText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          Widget presetChip(String label, VoidCallback onTap) => InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                  decoration: BoxDecoration(
                    color: _brand.withValues(alpha: _dark ? 0.18 : 0.08),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: _brand.withValues(alpha: 0.35)),
                  ),
                  child: Text(label,
                      style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: _dark ? Colors.white : _brand)),
                ),
              );

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: _border,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text('Select date range',
                      style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: _primaryText)),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: [
                      presetChip('Last 30 days', () {
                        setSheet(() {
                          end = now;
                          start = now.subtract(const Duration(days: 30));
                        });
                      }),
                      presetChip('Last 90 days', () {
                        setSheet(() {
                          end = now;
                          start = now.subtract(const Duration(days: 90));
                        });
                      }),
                      presetChip('This year', () {
                        setSheet(() {
                          end = now;
                          start = DateTime(now.year, 1, 1);
                        });
                      }),
                      presetChip('Last year', () {
                        setSheet(() {
                          start = DateTime(now.year - 1, 1, 1);
                          end = DateTime(now.year - 1, 12, 31);
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      dateField('Start', start, () async {
                        final d =
                            await _pickDay(start, earliest, end ?? now);
                        if (d != null) setSheet(() => start = d);
                      }),
                      SizedBox(width: 12.w),
                      dateField('End', end, () async {
                        final d =
                            await _pickDay(end, start ?? earliest, now);
                        if (d != null) setSheet(() => end = d);
                      }),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _brand,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r)),
                      ),
                      onPressed: () {
                        if (start == null || end == null) {
                          LVSnackbar.showError(
                            title: 'Incomplete',
                            message: 'Pick both a start and end date.',
                          );
                          return;
                        }
                        if (start!.isAfter(end!)) {
                          LVSnackbar.showError(
                            title: 'Invalid range',
                            message: 'Start date must be before the end date.',
                          );
                          return;
                        }
                        Navigator.pop(sheetCtx, true);
                      },
                      child: Text('Apply',
                          style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    if (applied == true && start != null && end != null && mounted) {
      update(() {
        _startDate = start;
        _endDate = end;
      });
    }
  }

  // ── Recents ────────────────────────────────────────────────────────────
  Widget _recentTile(StatementRecentEntry entry) {
    final isCsv = entry.format == StatementFormat.csv;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: _dark ? const Color(0xFF1B1B1B) : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => _replayRecent(entry),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: _brand.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                      _StatementExportPanelState._iconFor(entry.format),
                      color: _brand,
                      size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Statement (${isCsv ? 'CSV' : 'PDF'})',
                          style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: _primaryText)),
                      SizedBox(height: 4.h),
                      Text(
                        '${DateFormat('MMM dd, yyyy').format(entry.startDate)}'
                        ' - '
                        '${DateFormat('MMM dd, yyyy').format(entry.endDate)}',
                        style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: _dark
                                ? const Color(0xFF9CA3AF)
                                : const Color(0xFF6B7280)),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Generated '
                        '${DateFormat('MMM dd, yyyy').format(entry.generatedAt)}',
                        style: GoogleFonts.inter(
                            fontSize: 11.sp, color: _mutedText),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.download_rounded, color: _brand, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Post-download actions ──────────────────────────────────────────────
  void _showActions(String path, StatementFormat format) {
    final isPdf = format == StatementFormat.pdf;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: _sheetBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Text('Statement downloaded',
                  style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: _primaryText)),
              SizedBox(height: 8.h),
              ListTile(
                leading: Icon(Icons.open_in_new, color: _brand),
                title: Text('Open',
                    style: GoogleFonts.inter(color: _primaryText)),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  _openFile(path);
                },
              ),
              if (isPdf)
                ListTile(
                  leading: Icon(Icons.print, color: _brand),
                  title: Text('Print',
                      style: GoogleFonts.inter(color: _primaryText)),
                  onTap: () {
                    Navigator.pop(sheetCtx);
                    _printFile(path);
                  },
                ),
              ListTile(
                leading: Icon(Icons.ios_share, color: _brand),
                title: Text('Share',
                    style: GoogleFonts.inter(color: _primaryText)),
                onTap: () {
                  Navigator.pop(sheetCtx);
                  _shareFile(path);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
