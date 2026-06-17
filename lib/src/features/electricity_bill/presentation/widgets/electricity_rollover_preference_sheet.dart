import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';

/// Captures the recurring auto-recharge cadence for an electricity meter.
///
/// Mirrors the internet rollover sheet so users see a consistent
/// "keep it alive" flow across bill types. The electricity auto-recharge
/// gRPC (CreateAutoRechargeRequest in the legacy `electricity_bill.proto`)
/// only persists `frequency` / `dayOfWeek` / `dayOfMonth`, so hour/minute
/// are UI hints today — kept in the model for the day the backend adds
/// execution_hour/minute parity with the unified utility-payments proto.
class ElectricityRolloverPreference {
  final String frequency; // "daily" | "weekly" | "monthly"
  final int dayOfWeek; // 1-7 (Mon..Sun) — matches backend expectation
  final int dayOfMonth; // 1-28
  final int executionHour; // 0-23 (UI-only until backend adds it)
  final int executionMinute; // 0-59 (UI-only until backend adds it)

  const ElectricityRolloverPreference({
    this.frequency = 'monthly',
    this.dayOfWeek = 1,
    this.dayOfMonth = 1,
    this.executionHour = 9,
    this.executionMinute = 0,
  });
}

class ElectricityRolloverPreferenceSheet extends StatefulWidget {
  const ElectricityRolloverPreferenceSheet({super.key});

  static Future<ElectricityRolloverPreference?> show(BuildContext context) {
    return showModalBottomSheet<ElectricityRolloverPreference>(
      context: context,
      isScrollControlled: true,
      backgroundColor: InvoiceThemeColors.secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const ElectricityRolloverPreferenceSheet(),
      ),
    );
  }

  @override
  State<ElectricityRolloverPreferenceSheet> createState() =>
      _ElectricityRolloverPreferenceSheetState();
}

class _ElectricityRolloverPreferenceSheetState
    extends State<ElectricityRolloverPreferenceSheet> {
  String _frequency = 'monthly';
  int _dayOfWeek = 1;
  int _dayOfMonth = 1;
  int _executionHour = 9;
  int _executionMinute = 0;

  // Backend uses ISO-8601 weekday numbering (Monday = 1 .. Sunday = 7).
  static const _weekdayLabels = [
    'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun',
  ];

  void _submit() {
    Navigator.of(context).pop(
      ElectricityRolloverPreference(
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
                  color: InvoiceThemeColors.tertiaryBackground,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Text(
              'Keep this meter topped up',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textWhite,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Pick how often we\'ll auto-recharge this meter. '
              'We\'ll debit the same source account and deliver a new token.',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray400,
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
                      side: const BorderSide(
                        color: InvoiceThemeColors.borderColor,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Not now',
                      style: GoogleFonts.inter(
                        color: InvoiceThemeColors.textWhite,
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
                      backgroundColor: InvoiceThemeColors.primaryPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: Text(
                      'Enable auto-recharge',
                      style: GoogleFonts.inter(
                        color: InvoiceThemeColors.textWhite,
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
            color: InvoiceThemeColors.textWhite,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            for (final freq in const ['daily', 'weekly', 'monthly'])
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: freq == 'monthly' ? 0 : 8.w),
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
            color: InvoiceThemeColors.textWhite,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (int i = 0; i < 7; i++)
              _chip(
                label: _weekdayLabels[i],
                // Backend: Monday = 1..Sunday = 7.
                selected: _dayOfWeek == (i + 1),
                onTap: () => setState(() => _dayOfWeek = i + 1),
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
            color: InvoiceThemeColors.textWhite,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: InvoiceThemeColors.secondaryBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: InvoiceThemeColors.borderColor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              isExpanded: true,
              value: _dayOfMonth,
              dropdownColor: InvoiceThemeColors.secondaryBackground,
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.textWhite,
                fontSize: 14.sp,
              ),
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
            color: InvoiceThemeColors.textWhite,
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
                    primary: InvoiceThemeColors.primaryPurple,
                    surface: InvoiceThemeColors.secondaryBackground,
                    onSurface: InvoiceThemeColors.textWhite,
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
              color: InvoiceThemeColors.secondaryBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: InvoiceThemeColors.borderColor),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.schedule,
                  color: InvoiceThemeColors.primaryPurple,
                  size: 20,
                ),
                SizedBox(width: 12.w),
                Text(
                  '${_executionHour.toString().padLeft(2, '0')}:${_executionMinute.toString().padLeft(2, '0')}',
                  style: GoogleFonts.inter(
                    color: InvoiceThemeColors.textWhite,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: InvoiceThemeColors.textGray400,
                  size: 14.sp,
                ),
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
          color: selected
              ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15)
              : InvoiceThemeColors.secondaryBackground,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: selected
                ? InvoiceThemeColors.primaryPurple
                : InvoiceThemeColors.borderColor,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textWhite,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
