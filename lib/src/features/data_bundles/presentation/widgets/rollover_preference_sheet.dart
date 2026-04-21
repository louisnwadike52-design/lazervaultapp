import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Which of the two rollover backends the user picked.
///
/// - `renewOnExpiry` → ActiveSubscription.auto_renew_enabled
///     Backend computes `next_renewal_at = expires_at - 6h` and the
///     AutoRenewalWorker fires it. No user-picked timing.
///
/// - `recurringSchedule` → DataAutoRecharge with frequency + day + hour
///     User controls cadence; DataAutoRechargeTimerWorker fires on schedule.
enum RolloverMode { renewOnExpiry, recurringSchedule }

/// Captures what the user picks in [RolloverPreferenceSheet].
///
/// Nickname lives on the beneficiary (captured separately by the save-
/// beneficiary toggle), so this preference only carries rollover settings.
class RolloverPreference {
  final RolloverMode mode;
  final String frequency; // "daily" | "weekly" | "monthly" (ignored for renewOnExpiry)
  final int dayOfWeek; // 0-6 (Sun..Sat), used when frequency=weekly
  final int dayOfMonth; // 1-31, used when frequency=monthly
  final int executionHour; // 0-23

  const RolloverPreference({
    required this.mode,
    this.frequency = 'monthly',
    this.dayOfWeek = 0,
    this.dayOfMonth = 1,
    this.executionHour = 9,
  });
}

/// Bottom sheet that opens when the user flips "Non-Expiring Data" on the
/// data payment confirmation screen. Captures which rollover mechanism to
/// use (renew-on-expiry vs. recurring-schedule) and the cadence fields
/// when applicable. Returns [RolloverPreference] on confirm, or `null` on
/// dismissal (caller should treat null as "user backed out — don't enable
/// rollover").
class RolloverPreferenceSheet extends StatefulWidget {
  const RolloverPreferenceSheet({super.key});

  static Future<RolloverPreference?> show(BuildContext context) {
    return showModalBottomSheet<RolloverPreference>(
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
        child: const RolloverPreferenceSheet(),
      ),
    );
  }

  @override
  State<RolloverPreferenceSheet> createState() =>
      _RolloverPreferenceSheetState();
}

class _RolloverPreferenceSheetState extends State<RolloverPreferenceSheet> {
  RolloverMode _mode = RolloverMode.renewOnExpiry;
  String _frequency = 'monthly';
  int _dayOfWeek = 0;
  int _dayOfMonth = 1;
  int _executionHour = 9;

  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _primary = Color(0xFF4E03D0);
  static const _green = Color(0xFF10B981);
  static const _textSecondary = Color(0xFF9CA3AF);

  static const _weekdayLabels = [
    'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat',
  ];

  void _submit() {
    Navigator.of(context).pop(
      RolloverPreference(
        mode: _mode,
        frequency: _frequency,
        dayOfWeek: _dayOfWeek,
        dayOfMonth: _dayOfMonth,
        executionHour: _executionHour,
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
            // Drag handle
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
              'Keep this data alive',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Pick how often you want this plan to re-purchase.',
              style: GoogleFonts.inter(
                color: _textSecondary,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 20.h),

            // Mode picker
            Text(
              'Rollover mode',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            _modeCard(
              mode: RolloverMode.renewOnExpiry,
              icon: Icons.autorenew,
              title: 'Renew before expiry',
              subtitle:
                  'Auto-renew ~6 hours before this plan runs out. Simplest — we handle the timing.',
            ),
            SizedBox(height: 10.h),
            _modeCard(
              mode: RolloverMode.recurringSchedule,
              icon: Icons.calendar_month,
              title: 'Recurring schedule',
              subtitle:
                  'Choose daily, weekly or monthly and set the time yourself.',
            ),

            if (_mode == RolloverMode.recurringSchedule) ...[
              SizedBox(height: 20.h),
              _frequencyPicker(),
              SizedBox(height: 16.h),
              if (_frequency == 'weekly') _dayOfWeekPicker(),
              if (_frequency == 'monthly') _dayOfMonthPicker(),
              SizedBox(height: 16.h),
              _hourPicker(),
            ],

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
                      'Enable rollover',
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

  Widget _modeCard({
    required RolloverMode mode,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final selected = _mode == mode;
    final accent = mode == RolloverMode.renewOnExpiry ? _green : _primary;
    return GestureDetector(
      onTap: () => setState(() => _mode = mode),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? accent : _border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? accent : _textSecondary,
              size: 22.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: _textSecondary,
                      fontSize: 12.sp,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: selected ? accent : _textSecondary,
              size: 20.sp,
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
            for (final freq in ['daily', 'weekly', 'monthly'])
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: freq == 'monthly' ? 0 : 8.w),
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
                  DropdownMenuItem(
                    value: d,
                    child: Text('Day $d'),
                  ),
              ],
              onChanged: (v) => setState(() => _dayOfMonth = v ?? 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _hourPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Execution hour',
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
              value: _executionHour,
              dropdownColor: _card,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
              items: [
                for (int h = 0; h < 24; h++)
                  DropdownMenuItem(
                    value: h,
                    child: Text('${h.toString().padLeft(2, '0')}:00'),
                  ),
              ],
              onChanged: (v) => setState(() => _executionHour = v ?? 9),
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
