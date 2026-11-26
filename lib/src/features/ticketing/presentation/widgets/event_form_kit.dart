import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ticketing_theme.dart';

// RE-EXPORTED, so a step that imports the kit still gets the option sheet.
// The sheet moved out because it is a whole searchable modal and the rest of
// this file is field primitives — two responsibilities, one of them 170 lines
// — but splitting it must not turn one import into two at every call site.
export 'event_option_sheet.dart';

/// THE PIGGYVAULT FORM LANGUAGE, EXTRACTED ONCE.
///
/// The create-a-PiggyVault wizard (`create_lock_carousel` and its
/// `create_lock_steps/`) is the house pattern for a multi-step form that asks
/// for money details: a gradient progress bar over dot indicators, a dark
/// ground, and fields drawn as raised gradient cards with a leading icon and
/// no visible border.
///
/// WHY A KIT AND NOT A COPY. Those values are magic numbers — the
/// `#2A2A3E → #1F1F35` field gradient, the 12r radius, the `black@0.2 blur 8
/// offset(0,4)` shadow, the 24sp/700 step title. Ticketing arrived with
/// thirteen of its own hex literals, two of which were simply wrong against
/// the rest of the product, and that is the failure a second copy guarantees:
/// it reads as "unfinished" long before anyone can say why. One kit means a
/// change to the language reaches every screen that speaks it.
///
/// The colours themselves come from [TicketingTheme] (which pulls from
/// PayFlowTheme) wherever one exists; only the shapes the PiggyVault wizard
/// owns are defined here.

/// The field card's gradient — the PiggyVault wizard's own.
const _fieldGradient = LinearGradient(
  colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

/// A step's heading. 24sp/700 white, as the wizard's step screens use.
class EventStepTitle extends StatelessWidget {
  const EventStepTitle(this.text, {super.key, this.subtitle});

  final String text;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 6.h),
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: TicketingTheme.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}

/// A field's label — 14sp/600 white, then the 12.h gap the wizard uses.
class EventFieldLabel extends StatelessWidget {
  const EventFieldLabel(this.text,
      {super.key, this.optional = false, this.locked = false});

  final String text;

  /// Says so IN THE LABEL rather than leaving it to be discovered by pressing
  /// Continue. A form that only reveals what is required at the point of
  /// refusal is the thing per-step validation is meant to replace, not a
  /// thing it makes acceptable.
  final bool optional;

  /// Draws a padlock. Says WHY a field will not take a keystroke, which a
  /// greyed box on its own does not.
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          if (locked) ...[
            SizedBox(width: 6.w),
            Icon(Icons.lock_outline,
                size: 12.sp, color: TicketingTheme.textMuted),
          ],
          if (optional) ...[
            SizedBox(width: 6.w),
            Text(
              '(optional)',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: TicketingTheme.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The raised gradient card every input sits in.
///
/// Exposed on its own so a non-TextField control — a date row, a picker, a
/// toggle — sits in the same box as the text inputs. Mixing bordered and
/// gradient fields on one form is the specific thing that reads as two
/// different apps.
class EventFieldCard extends StatelessWidget {
  const EventFieldCard({
    super.key,
    required this.child,
    this.padding,
    this.invalid = false,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  /// Draws the error outline. The MESSAGE belongs beside the field (see
  /// [EventFieldError]) — a red box with no words tells somebody something is
  /// wrong and not what.
  final bool invalid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        gradient: _fieldGradient,
        borderRadius: BorderRadius.circular(12.r),
        border: invalid
            ? Border.all(color: TicketingTheme.error, width: 1.2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// A validation message for one field.
///
/// PER FIELD, NOT PER FORM. A single banner at the top of a step says what is
/// wrong but not where, and on a form with eight inputs that is a hunt. This
/// renders nothing when [message] is null, so the layout does not jump as
/// errors appear and clear.
class EventFieldError extends StatelessWidget {
  const EventFieldError(this.message, {super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: 6.h, left: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded,
              size: 14.sp, color: TicketingTheme.error),
          SizedBox(width: 5.w),
          Expanded(
            child: Text(
              message!,
              style: GoogleFonts.inter(
                fontSize: 11.5.sp,
                color: TicketingTheme.error,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A labelled text input in the house style.
class EventTextField extends StatelessWidget {
  const EventTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.icon,
    this.optional = false,
    this.maxLines = 1,
    this.keyboardType,
    this.error,
    this.onChanged,
    this.prefix,
    this.formatters,
    this.helper,
    this.enabled = true,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final bool optional;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? error;
  final ValueChanged<String>? onChanged;

  /// For a currency marker. A leading "₦" inside the field is how the
  /// PiggyVault amount step says what unit it wants, which a hint cannot do
  /// once the field has text in it.
  final Widget? prefix;

  final List<TextInputFormatter>? formatters;

  /// A line under the field. HIDDEN WHILE AN ERROR IS SHOWING — two
  /// explanations stacked under one input is one too many, and the error is
  /// the one that needs acting on.
  final String? helper;

  /// False for a value that cannot be changed right now.
  ///
  /// THE EDIT SCREEN NEEDS THIS, and it is not merely cosmetic: once a ticket
  /// has sold, the price and the dates are frozen because a purchase row
  /// carries its own price and changing the event's would leave the recorded
  /// net describing a different event. A padlock beside the label says WHY the
  /// field will not take a keystroke, which a greyed box on its own does not.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventFieldLabel(label, optional: optional, locked: !enabled),
        EventFieldCard(
          invalid: error != null,
          padding: maxLines > 1
              ? EdgeInsets.all(16.w)
              : EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            enabled: enabled,
            keyboardType: keyboardType,
            inputFormatters: formatters,
            onChanged: onChanged,
            style: GoogleFonts.inter(
              fontSize: maxLines > 1 ? 14.sp : 16.sp,
              fontWeight: maxLines > 1 ? FontWeight.w400 : FontWeight.w600,
              color: enabled ? Colors.white : TicketingTheme.textMuted,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              icon: icon == null
                  ? null
                  : Icon(icon, color: const Color(0xFF9CA3AF), size: 20.sp),
              prefix: prefix,
            ),
          ),
        ),
        EventFieldError(error),
        if (helper != null && error == null) ...[
          SizedBox(height: 6.h),
          Text(helper!,
              style: GoogleFonts.inter(
                  fontSize: 11.sp, color: TicketingTheme.textMuted)),
        ],
      ],
    );
  }
}

/// A tappable row that opens something — a picker, a date sheet.
///
/// Same card as a text field so a form does not change texture between "type
/// this" and "choose this".
class EventPickerField extends StatelessWidget {
  const EventPickerField({
    super.key,
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onTap,
    this.icon,
    this.optional = false,
    this.error,
    this.enabled = true,
  });

  final String label;

  /// The chosen value, or null for nothing chosen yet.
  final String? value;
  final String placeholder;
  final VoidCallback onTap;
  final IconData? icon;
  final bool optional;
  final String? error;

  /// False for a value frozen by a sale. See [EventTextField.enabled].
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final chosen = value != null && value!.trim().isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventFieldLabel(label, optional: optional, locked: !enabled),
        InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(12.r),
          child: EventFieldCard(
            invalid: error != null,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: const Color(0xFF9CA3AF), size: 20.sp),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Text(
                    chosen ? value! : placeholder,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: chosen ? 16.sp : 14.sp,
                      fontWeight: chosen ? FontWeight.w600 : FontWeight.w400,
                      color: chosen
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_rounded,
                    color: const Color(0xFF9CA3AF), size: 22.sp),
              ],
            ),
          ),
        ),
        EventFieldError(error),
      ],
    );
  }
}

/// The wizard's progress header: a gradient bar over dot indicators.
///
/// Lifted from `create_lock_carousel._buildProgressIndicators` so the two
/// flows read as one product. The bar turns GREEN on the final step, which is
/// the wizard's own signal that the next press commits.
class EventStepProgress extends StatelessWidget {
  const EventStepProgress({
    super.key,
    required this.current,
    required this.total,
  });

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final onLast = current == total - 1;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, c) => Stack(
              children: [
                Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 4.h,
                  // Measured, not derived from MediaQuery minus a guessed
                  // gutter: the wizard's own version subtracts its padding by
                  // hand and is wrong inside any other layout.
                  width: c.maxWidth * ((current + 1) / total),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: onLast
                          ? [Colors.green, Colors.green.shade700]
                          : const [
                              Color(0xFF6366F1),
                              Color.fromARGB(255, 78, 3, 208),
                            ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              total,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: current == i ? 24.w : 8.w,
                height: 8.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: current == i
                      ? const Color(0xFF6366F1)
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
