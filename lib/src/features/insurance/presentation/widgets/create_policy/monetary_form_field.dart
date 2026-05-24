import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// A monetary amount input that:
///   • shows the active locale's currency symbol as a non-editable prefix,
///   • formats the displayed integer portion with thousands separators
///     ("1,000,000.50") while the user types,
///   • emits a clean numeric string ("1000000.50") through [onChanged] so
///     the parent cubit/backend never sees commas,
///   • caps to two decimal places (matches the existing manual regex used
///     across the create-policy flow).
///
/// Used for fields like Property Value, Contents Value, Vehicle Value,
/// Premium Amount, Coverage Amount, etc.
class MonetaryFormField extends StatefulWidget {
  /// ISO currency code, e.g. "NGN", "USD". Drives the symbol via
  /// [currencySymbol].
  final String currencyCode;

  /// Symbol to render (e.g. "₦"). Pre-resolved so this widget doesn't
  /// reach into the service locator — keeps it cheap to test.
  final String currencySymbol;

  /// Initial raw numeric value as a decimal string ("1000.00") — what the
  /// backend would store. Passing an empty string starts the field blank.
  final String initialRawValue;

  /// Required label (rendered above the field with an asterisk if [required]).
  final String label;

  /// Optional helper line under the field.
  final String? helperText;

  /// Optional placeholder (defaults to "0.00").
  final String? hintText;

  /// Marks the field with a red asterisk and is otherwise informational —
  /// validation lives in the parent.
  final bool required;

  /// External validator error to surface in the field.
  final String? errorText;

  /// Called with the RAW decimal string (no commas, no symbol). Use this
  /// to push into your cubit / network call.
  final ValueChanged<String> onChanged;

  const MonetaryFormField({
    super.key,
    required this.currencyCode,
    required this.currencySymbol,
    required this.initialRawValue,
    required this.label,
    required this.onChanged,
    this.helperText,
    this.hintText,
    this.required = false,
    this.errorText,
  });

  @override
  State<MonetaryFormField> createState() => _MonetaryFormFieldState();
}

class _MonetaryFormFieldState extends State<MonetaryFormField> {
  late final TextEditingController _controller;
  late final _ThousandsSeparatorTextInputFormatter _formatter;

  @override
  void initState() {
    super.initState();
    _formatter = _ThousandsSeparatorTextInputFormatter();
    _controller = TextEditingController(
      text: _formatter.formatRaw(widget.initialRawValue),
    );
  }

  @override
  void didUpdateWidget(covariant MonetaryFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the parent overwrites the initial value (e.g. clearing the form),
    // reflect it. We compare raw forms so re-formatting during typing
    // doesn't cause a reset loop.
    if (oldWidget.initialRawValue != widget.initialRawValue &&
        widget.initialRawValue != _formatter.stripFormatting(_controller.text)) {
      final newDisplay = _formatter.formatRaw(widget.initialRawValue);
      _controller.value = TextEditingValue(
        text: newDisplay,
        selection: TextSelection.collapsed(offset: newDisplay.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            if (widget.required)
              Text(
                ' *',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFEF4444),
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [_formatter],
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          onChanged: (formatted) {
            // Emit the raw numeric string so the parent cubit / backend
            // never sees commas or the currency symbol.
            widget.onChanged(_formatter.stripFormatting(formatted));
          },
          decoration: InputDecoration(
            hintText: widget.hintText ?? '0.00',
            hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
            // Symbol prefix — keep it visually grouped with the input so
            // the user always knows which currency they're typing in.
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 14.w, right: 8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.currencySymbol,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.currencyCode.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.5),
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 48.w,
              minHeight: 24.h,
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF6366F1)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            errorText: widget.errorText,
            errorStyle: GoogleFonts.inter(
              fontSize: 11.sp,
              color: const Color(0xFFEF4444),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          ),
        ),
        if (widget.helperText != null && widget.helperText!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 6.h, left: 4.w),
            child: Text(
              widget.helperText!,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[500],
              ),
            ),
          ),
      ],
    );
  }
}

/// Formats the integer portion of a numeric input with thousands
/// separators ("1,000,000.50") while preserving up to two decimal places.
///
/// Stripping commas is one call away via [stripFormatting], so callers can
/// recover the raw value for backend submission ("1000000.50").
class _ThousandsSeparatorTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final rawNew = stripFormatting(newValue.text);
    // Allow empty (user cleared the field).
    if (rawNew.isEmpty) {
      return const TextEditingValue(text: '');
    }
    // Reject characters that aren't digits or "." (the keyboard usually
    // won't surface them, but pasted clipboard content can).
    if (!RegExp(r'^\d*\.?\d{0,2}$').hasMatch(rawNew)) {
      return oldValue;
    }

    final formatted = _format(rawNew);

    // Caret handling: count how many digits/dot appear before the caret
    // in the new (unformatted) text, then walk the formatted output to
    // place the caret after the same count of meaningful chars. This
    // keeps the cursor where the user expects when they type in the
    // middle of an existing number.
    final rawCaret = _rawCaretPosition(newValue.text, newValue.selection.start);
    final newCaret = _formattedCaretFor(formatted, rawCaret);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCaret),
      composing: TextRange.empty,
    );
  }

  /// Public so tests / parent widgets can convert between raw and display.
  String formatRaw(String raw) {
    final clean = stripFormatting(raw);
    if (clean.isEmpty) return '';
    if (!RegExp(r'^\d*\.?\d{0,2}$').hasMatch(clean)) return '';
    return _format(clean);
  }

  /// Removes everything except digits and a single decimal point.
  String stripFormatting(String input) {
    final noCommas = input.replaceAll(',', '');
    // Collapse multiple dots to the first one (a paste accident).
    final firstDot = noCommas.indexOf('.');
    if (firstDot == -1) {
      return noCommas.replaceAll(RegExp(r'[^\d]'), '');
    }
    final intPart = noCommas
        .substring(0, firstDot)
        .replaceAll(RegExp(r'[^\d]'), '');
    final decPart =
        noCommas.substring(firstDot + 1).replaceAll(RegExp(r'[^\d]'), '');
    return '$intPart.$decPart';
  }

  String _format(String raw) {
    final dot = raw.indexOf('.');
    final intPart = dot == -1 ? raw : raw.substring(0, dot);
    final decPart = dot == -1 ? null : raw.substring(dot + 1);
    final intFormatted = _addThousandsSeparators(intPart);
    if (decPart == null) return intFormatted;
    return '$intFormatted.$decPart';
  }

  String _addThousandsSeparators(String digits) {
    if (digits.isEmpty) return '';
    final buf = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      final fromRight = digits.length - i;
      buf.write(digits[i]);
      if (fromRight > 1 && fromRight % 3 == 1) buf.write(',');
    }
    return buf.toString();
  }

  /// Number of digit-or-dot characters before [caret] in [text].
  int _rawCaretPosition(String text, int caret) {
    if (caret <= 0) return 0;
    int count = 0;
    for (int i = 0; i < caret && i < text.length; i++) {
      final c = text[i];
      if (c == ',') continue;
      count++;
    }
    return count;
  }

  /// Index in [formatted] just past [rawCount] meaningful characters.
  int _formattedCaretFor(String formatted, int rawCount) {
    int seen = 0;
    for (int i = 0; i < formatted.length; i++) {
      if (formatted[i] == ',') continue;
      if (seen == rawCount) return i;
      seen++;
    }
    return formatted.length;
  }
}
