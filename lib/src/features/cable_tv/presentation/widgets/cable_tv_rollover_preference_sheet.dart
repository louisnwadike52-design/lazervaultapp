import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Captures the recurring auto-renewal cadence for a cable TV
/// subscription. Mirrors `InternetRolloverPreferenceSheet`:
///   * Weekly or monthly
///   * Day-of-week (0 Sun … 6 Sat) or day-of-month (1 … 28)
///   * Execution time (defaults to 09:00 local)
///
/// The backend `CableTVAutoRechargeTimerWorker` fires on schedule and
/// re-buys the exact same package stored on the schedule row.
class CableTVRolloverPreference {
  final String frequency; // "weekly" | "monthly"
  final int dayOfWeek; // 0-6 (Sun..Sat), used when frequency=weekly
  final int dayOfMonth; // 1-28, used when frequency=monthly
  final int executionHour; // 0-23
  final int executionMinute; // 0-59

  const CableTVRolloverPreference({
    this.frequency = 'monthly',
    this.dayOfWeek = 0,
    this.dayOfMonth = 1,
    this.executionHour = 9,
    this.executionMinute = 0,
  });
}

class CableTVRolloverPreferenceSheet extends StatefulWidget {
  const CableTVRolloverPreferenceSheet({super.key});

  static Future<CableTVRolloverPreference?> show(BuildContext context) {
    return showModalBottomSheet<CableTVRolloverPreference>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const CableTVRolloverPreferenceSheet(),
      ),
    );
  }

  @override
  State<CableTVRolloverPreferenceSheet> createState() =>
      _CableTVRolloverPreferenceSheetState();
}

class _CableTVRolloverPreferenceSheetState
    extends State<CableTVRolloverPreferenceSheet> {
  String _frequency = 'monthly';
  int _dayOfWeek = 0;
  int _dayOfMonth = 1;
  int _executionHour = 9;
  int _executionMinute = 0;

  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _primary = Color(0xFF3B82F6);
  static const _textSecondary = Color(0xFF9CA3AF);

  static const _weekdayLabels = [
    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat',
  ];

  void _submit() {
    Navigator.of(context).pop(
      CableTVRolloverPreference(
        frequency: _frequency,
        dayOfWeek: _dayOfWeek,
        dayOfMonth: _dayOfMonth,
        executionHour: _executionHour,
        executionMinute: _executionMinute,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Text(
              'Keep this subscription alive',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Pick how often this cable TV package re-purchases. '
              'We\'ll fire it automatically on schedule.',
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.h),
            _frequencyPicker(),
            SizedBox(height: 16.h),
            if (_frequency == 'weekly') _dayOfWeekPicker(),
            if (_frequency == 'monthly') _dayOfMonthPicker(),
            SizedBox(height: 16.h),
            _timePicker(),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: _border, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Not now',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Enable auto-renew',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _frequencyPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequency',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            for (final freq in ['weekly', 'monthly'])
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(right: freq == 'monthly' ? 0 : 8.w),
                  child: _chip(
                    label: freq[0].toUpperCase() + freq.substring(1),
                    selected: _frequency == freq,
                    onTap: () => setState(() => _frequency = freq),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _dayOfWeekPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Day of week',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          children: [
            for (int i = 0; i < 7; i++)
              _chip(
                label: _weekdayLabels[i],
                selected: _dayOfWeek == i,
                onTap: () => setState(() => _dayOfWeek = i),
              ),
          ],
        ),
      ],
    );
  }

  Widget _dayOfMonthPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Day of month',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: _border),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              isExpanded: true,
              value: _dayOfMonth,
              dropdownColor: _card,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
              items: [
                for (int d = 1; d <= 28; d++)
                  DropdownMenuItem(value: d, child: Text('Day $d')),
              ],
              onChanged: (v) => setState(() => _dayOfMonth = v ?? 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _timePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Execution time',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay(
                hour: _executionHour,
                minute: _executionMinute,
              ),
              builder: (c, child) => Theme(
                data: Theme.of(c).copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: _primary,
                    surface: _card,
                    onSurface: Colors.white,
                  ),
                ),
                child: child!,
              ),
            );
            if (picked != null) {
              setState(() {
                _executionHour = picked.hour;
                _executionMinute = picked.minute;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: _border),
            ),
            child: Row(
              children: [
                const Icon(Icons.schedule, color: _primary, size: 20),
                SizedBox(width: 12.w),
                Text(
                  '${_executionHour.toString().padLeft(2, '0')}:${_executionMinute.toString().padLeft(2, '0')}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Icon(Icons.arrow_forward_ios,
                    color: _textSecondary, size: 14.sp),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? _primary.withValues(alpha: 0.15) : _card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected ? _primary : _border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
