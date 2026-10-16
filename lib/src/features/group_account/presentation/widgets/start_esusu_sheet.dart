import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/group_account/domain/entities/group_entities.dart';

/// What the creator chose on the start sheet.
class StartEsusuChoice {
  const StartEsusuChoice({
    required this.frequency,
    required this.totalCycles,
    required this.endsOn,
  });

  final ContributionFrequency frequency;
  final int totalCycles;

  /// Shown to the creator so they approve the date the circle actually ends.
  /// Sent as-is so the server stores the same date they agreed to rather than
  /// one derived a few seconds later.
  final DateTime endsOn;
}

/// Collects the schedule an esusu will run on, at the moment it starts.
///
/// The schedule used to be chosen in the creation wizard, days before the
/// circle actually started — so a two-day window picked on Monday was nearly
/// spent before anyone could pay into it. Everything that defines "how long
/// does this run" is therefore asked here instead.
///
/// Two steps on purpose: the schedule, then what starting costs you. The
/// second is not a formality — starting freezes the roster, and that is the
/// one thing about an esusu that cannot be undone.
Future<StartEsusuChoice?> showStartEsusuSheet(
  BuildContext context, {
  required Contribution contribution,
  required int activeMembers,
  required List<String> rotationNames,
}) {
  return showModalBottomSheet<StartEsusuChoice>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _StartEsusuSheet(
      contribution: contribution,
      activeMembers: activeMembers,
      rotationNames: rotationNames,
    ),
  );
}

class _StartEsusuSheet extends StatefulWidget {
  const _StartEsusuSheet({
    required this.contribution,
    required this.activeMembers,
    required this.rotationNames,
  });

  final Contribution contribution;
  final int activeMembers;
  final List<String> rotationNames;

  @override
  State<_StartEsusuSheet> createState() => _StartEsusuSheetState();
}

class _StartEsusuSheetState extends State<_StartEsusuSheet> {
  static const _bg = Color(0xFF151515);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _muted = Color(0xFF9CA3AF);
  static const _accent = Color(0xFF4E03D0);

  int _step = 0;
  late ContributionFrequency _frequency;
  late int _cycles;

  @override
  void initState() {
    super.initState();
    // Pre-filled from whatever creation stored, so a circle made on an older
    // build — which did collect a schedule — opens on the values its creator
    // already chose rather than on a guess.
    _frequency = widget.contribution.frequency ?? ContributionFrequency.monthly;
    // The floor is the roster: every member holds one turn, so fewer cycles
    // than members would end the circle before some of them were ever paid.
    // The server enforces the same floor; this keeps the sheet from offering
    // a number it would refuse.
    // Exactly the roster size — the same rule the server applies at open
    // (rotationCycleCount). A stored value from creation is deliberately
    // ignored: members are usually still joining between creating a circle
    // and starting it, which is the window a creation-time number cannot know
    // about.
    _cycles = widget.activeMembers;
    if (_cycles < 1) _cycles = 1;
  }

  /// Walked one period at a time rather than multiplied, so the date shown
  /// here is the same calendar the payments fall due on — the server derives
  /// it the same way.
  DateTime get _endsOn {
    var d = DateTime.now();
    for (var i = 0; i < _cycles; i++) {
      d = _addPeriod(d, _frequency);
    }
    return d;
  }

  /// Mirrors the server's advanceDate (group_account_service.go) one period at
  /// a time. Seconds are carried through: dropping them made the date shown
  /// here differ from the server's own derivation by up to a minute, which is
  /// invisible on screen but turns an equality check into a false mismatch.
  static DateTime _addPeriod(DateTime d, ContributionFrequency f) {
    switch (f) {
      case ContributionFrequency.daily:
        return d.add(const Duration(days: 1));
      case ContributionFrequency.weekly:
        return d.add(const Duration(days: 7));
      case ContributionFrequency.biWeekly:
        return d.add(const Duration(days: 14));
      case ContributionFrequency.monthly:
        return DateTime(d.year, d.month + 1, d.day, d.hour, d.minute, d.second);
      case ContributionFrequency.quarterly:
        return DateTime(d.year, d.month + 3, d.day, d.hour, d.minute, d.second);
      case ContributionFrequency.yearly:
        return DateTime(d.year + 1, d.month, d.day, d.hour, d.minute, d.second);
    }
  }

  static String _freqLabel(ContributionFrequency f) {
    switch (f) {
      case ContributionFrequency.daily:
        return 'Daily';
      case ContributionFrequency.weekly:
        return 'Weekly';
      case ContributionFrequency.biWeekly:
        return 'Every 2 weeks';
      case ContributionFrequency.monthly:
        return 'Monthly';
      case ContributionFrequency.quarterly:
        return 'Quarterly';
      case ContributionFrequency.yearly:
        return 'Yearly';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 16.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text('Start this esusu',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 2.h),
            Text(
                'Step ${_step + 1} of 2 · ${_step == 0 ? 'Schedule' : 'Confirm'}',
                style: GoogleFonts.inter(color: _muted, fontSize: 11.5.sp)),
            SizedBox(height: 10.h),
            Row(
              children: [
                for (var i = 0; i < 2; i++) ...[
                  Expanded(
                    child: Container(
                      height: 3.h,
                      decoration: BoxDecoration(
                        color: i <= _step ? _accent : _border,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  if (i == 0) SizedBox(width: 6.w),
                ],
              ],
            ),
            SizedBox(height: 16.h),
            if (_step == 0) _schedule() else _confirm(),
            SizedBox(height: 16.h),
            Row(
              children: [
                if (_step == 1)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _step = 0),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: _border),
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.r)),
                      ),
                      child: Text('Back',
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 13.sp)),
                    ),
                  ),
                if (_step == 1) SizedBox(width: 10.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_step == 0) {
                        setState(() => _step = 1);
                        return;
                      }
                      Navigator.pop(
                        context,
                        StartEsusuChoice(
                          frequency: _frequency,
                          totalCycles: _cycles,
                          endsOn: _endsOn,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.r)),
                    ),
                    child: Text(_step == 0 ? 'Continue' : 'Start esusu',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _schedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How often does everyone pay?',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            for (final f in ContributionFrequency.values)
              GestureDetector(
                onTap: () => setState(() => _frequency = f),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: _frequency == f ? _accent : _card,
                    borderRadius: BorderRadius.circular(9.r),
                    border:
                        Border.all(color: _frequency == f ? _accent : _border),
                  ),
                  child: Text(_freqLabel(f),
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 12.sp)),
                ),
              ),
          ],
        ),
        SizedBox(height: 16.h),
        // CYCLES ARE NOT A CHOICE — they are the roster size.
        //
        // This used to be a stepper floored at the member count but with no
        // ceiling, so an organiser could set MORE cycles than members. The
        // rotation then wraps: measured on prod, an esusu with 2 members and
        // 3 cycles would pay one member twice and the other once, each having
        // paid the same into every cycle. That is not a rotation.
        //
        // The server computes the same number at open (rotationCycleCount),
        // so a stepper here could only ever disagree with what actually runs.
        // Showing the derived figure keeps the sheet honest.
        Text('Cycles',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w600)),
        SizedBox(height: 2.h),
        Text(
          'One per member, so everyone is paid exactly once.',
          style: GoogleFonts.inter(color: _muted, fontSize: 11.sp, height: 1.4),
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$_cycles',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(width: 8.w),
            Text(
              _cycles == 1
                  ? 'cycle · 1 member'
                  : 'cycles · ${widget.activeMembers} members',
              style:
                  GoogleFonts.inter(color: _muted, fontSize: 12.sp),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(11.r),
            border: Border.all(color: _border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Runs until',
                  style: GoogleFonts.inter(color: _muted, fontSize: 11.sp)),
              SizedBox(height: 3.h),
              Text(DateFormat('EEEE, d MMMM yyyy').format(_endsOn),
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 3.h),
              Text(
                '$_cycles ${_freqLabel(_frequency).toLowerCase()} '
                'cycle${_cycles == 1 ? '' : 's'}, counted from today.',
                style: GoogleFonts.inter(color: _muted, fontSize: 11.sp),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _confirm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF3A2A00),
            borderRadius: BorderRadius.circular(11.r),
            border: Border.all(color: const Color(0xFF7A5B00)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lock_outline,
                  color: const Color(0xFFF59E0B), size: 18.sp),
              SizedBox(width: 9.w),
              Expanded(
                child: Text(
                  'Starting locks the members. '
                  '${widget.activeMembers} people are in this circle and '
                  'nobody can be added after this — everyone pays a share of '
                  'the same pot and holds a turn, so adding someone later '
                  'would change both for the people already paying in.',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontSize: 11.5.sp, height: 1.45),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        _summaryRow('Cycle length', _freqLabel(_frequency)),
        _summaryRow('Cycles', '$_cycles'),
        _summaryRow('Runs until', DateFormat('d MMM yyyy').format(_endsOn)),
        _summaryRow('Members', '${widget.activeMembers}'),
        if (widget.rotationNames.isNotEmpty) ...[
          SizedBox(height: 10.h),
          Text('Payout order',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 5.h),
          Text(
            widget.rotationNames.take(6).join(' → ') +
                (widget.rotationNames.length > 6 ? ' → …' : ''),
            style:
                GoogleFonts.inter(color: _muted, fontSize: 11.sp, height: 1.4),
          ),
        ],
      ],
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.inter(color: _muted, fontSize: 12.sp)),
          Text(value,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.5.sp,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
