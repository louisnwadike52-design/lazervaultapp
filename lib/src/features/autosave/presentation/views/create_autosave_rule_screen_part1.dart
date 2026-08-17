part of 'create_autosave_rule_screen.dart';

// ════════════════════════════════════════════════════════════════════
// Reusable building blocks (file-private)
// ════════════════════════════════════════════════════════════════════

class _Header extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String titleHero;
  final Color titleHeroAccent;
  final String subtitle;
  final VoidCallback onBack;
  const _Header({
    required this.currentStep,
    required this.totalSteps,
    required this.titleHero,
    required this.titleHeroAccent,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fillW = (width - 40.w) * ((currentStep + 1) / totalSteps);
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
      decoration: const BoxDecoration(
        color: _bg,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 42.w,
                  height: 42.w,
                  decoration: BoxDecoration(
                    color: _surface,
                    shape: BoxShape.circle,
                    boxShadow: const [_shadowSoft],
                  ),
                  child: Icon(
                    currentStep == 0
                        ? Icons.close_rounded
                        : Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 19.sp,
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  'Step ${currentStep + 1} of $totalSteps',
                  style: GoogleFonts.inter(
                    color: _textMuted,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Linear progress (gradient) + dot indicators below.
          Stack(
            children: [
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                height: 4.h,
                width: fillW.clamp(0, width - 40.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: currentStep == totalSteps - 1
                        ? const [_success, Color(0xFF059669)]
                        : [titleHeroAccent, _accentDeep],
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalSteps,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: i == currentStep ? 22.w : 7.w,
                height: 7.h,
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                decoration: BoxDecoration(
                  color: i <= currentStep
                      ? titleHeroAccent
                      : Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 18.h),
          Text(
            titleHero,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              height: 1.15,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              color: _textMuted,
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepBody extends StatelessWidget {
  final Widget child;
  const _StepBody({required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 28.h),
      child: child,
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String? error;
  final VoidCallback onBack;
  final VoidCallback onNext;
  const _BottomActionBar({
    required this.currentStep,
    required this.totalSteps,
    required this.error,
    required this.onBack,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final isLast = currentStep == totalSteps - 1;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 18.h),
      decoration: const BoxDecoration(
        color: _bg,
        boxShadow: [
          // Cast a shadow UPWARD so the bar reads as floating above
          // the form rather than sitting on the same plane.
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 16,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (error != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: _danger.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: _danger.withValues(alpha: 0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: _danger, size: 18.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      error!,
                      style: GoogleFonts.inter(
                        color: _danger,
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14.h),
          ],
          Row(
            children: [
              Expanded(
                child: _SoftButton(
                  label: currentStep == 0 ? 'Cancel' : 'Back',
                  onTap: onBack,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: _PrimaryButton(
                  label: isLast ? 'Review rule' : 'Continue',
                  icon: isLast
                      ? Icons.check_rounded
                      : Icons.arrow_forward_rounded,
                  onTap: onNext,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_accent, _accentDeep],
        ),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: _accent.withValues(alpha: 0.45),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(icon, color: Colors.white, size: 18.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SoftButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SoftButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _surface,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: const [_shadowSoft],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  final bool optional;
  final String? badge;
  final String? help;
  final String? counter;
  const _LabeledField({
    required this.label,
    required this.child,
    this.optional = false,
    this.badge,
    this.help,
    this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (optional) ...[
              SizedBox(width: 8.w),
              Text(
                'Optional',
                style: GoogleFonts.inter(
                  color: _textMuted,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (badge != null) ...[
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: _success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  badge!,
                  style: GoogleFonts.inter(
                    color: _success,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            const Spacer(),
            if (counter != null)
              Text(
                counter!,
                style: GoogleFonts.inter(
                  color: _textMuted,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        if (help != null) ...[
          SizedBox(height: 4.h),
          Text(
            help!,
            style: GoogleFonts.inter(color: _textMuted, fontSize: 12.sp),
          ),
        ],
        SizedBox(height: 10.h),
        child,
      ],
    );
  }
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final Widget? trailing;
  const _TextInput({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.autofocus = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _surfaceRaised,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [_shadowSoft],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        autofocus: autofocus,
        cursorColor: _accent,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 15.sp,
          ),
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.r),
            borderSide: const BorderSide(color: _accent, width: 1.5),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          suffixIcon: trailing,
          suffixIconConstraints: BoxConstraints(minWidth: 0.w, minHeight: 0.h),
        ),
      ),
    );
  }
}

class _TriggerCard extends StatelessWidget {
  final Color tint;
  final IconData icon;
  final String title;
  final String description;
  final bool selected;
  final VoidCallback onTap;
  const _TriggerCard({
    required this.tint,
    required this.icon,
    required this.title,
    required this.description,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: selected ? tint.withValues(alpha: 0.12) : _surface,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: selected ? tint : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            // Always elevated so it reads as a card; selected tier
            // takes a stronger tinted halo.
            if (!selected) _shadowSoft,
            if (selected)
              BoxShadow(
                color: tint.withValues(alpha: 0.30),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: tint.withValues(alpha: selected ? 0.28 : 0.16),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(icon, color: tint, size: 28.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      color: _textMuted,
                      fontSize: 12.5.sp,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? tint : Colors.transparent,
                border: Border.all(
                  color: selected ? tint : _hairline,
                  width: 2,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: tint.withValues(alpha: 0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: selected
                  ? Icon(Icons.check_rounded, color: Colors.white, size: 14.sp)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _FrequencyTile extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _FrequencyTile({
    required this.label,
    required this.hint,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: selected ? _accent.withValues(alpha: 0.14) : _surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? _accent : Colors.transparent,
            width: 2,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: _accent.withValues(alpha: 0.28),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ]
              : const [_shadowSoft],
        ),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: selected ? 0.25 : 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: _accent, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    hint,
                    style: GoogleFonts.inter(
                      color: _textMuted,
                      fontSize: 10.5.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeekDayPicker extends StatelessWidget {
  final int selectedDay; // 1=Mon … 7=Sun (backend mod-7 keeps both 7 and 0 → Sun)
  final ValueChanged<int> onChanged;
  const _WeekDayPicker({required this.selectedDay, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [_shadowSoft],
      ),
      child: Row(
        children: List.generate(7, (i) {
          final day = i + 1;
          final selected = day == selectedDay;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: GestureDetector(
                onTap: () => onChanged(day),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: selected ? _accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: _accent.withValues(alpha: 0.45),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    labels[i],
                    style: GoogleFonts.inter(
                      color: selected ? Colors.white : _textMuted,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _MonthDayPicker extends StatelessWidget {
  final int selectedDay;
  final ValueChanged<int> onChanged;
  const _MonthDayPicker({required this.selectedDay, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: const [_shadowSoft],
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 7,
        mainAxisSpacing: 6.h,
        crossAxisSpacing: 6.w,
        childAspectRatio: 1,
        children: List.generate(31, (i) {
          final day = i + 1;
          final selected = day == selectedDay;
          return GestureDetector(
            onTap: () => onChanged(day),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              decoration: BoxDecoration(
                color: selected ? _accent : Colors.transparent,
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: _accent.withValues(alpha: 0.45),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                '$day',
                style: GoogleFonts.inter(
                  color: selected ? Colors.white : _textMuted,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
