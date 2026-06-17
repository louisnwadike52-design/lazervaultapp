import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entities/insurance_product_entity.dart';

/// Multi-select array field. Used for MyCover fields of `type: array`
/// whose dictionary entry carries non-empty `options` — currently just
/// `benefits` (coverage selection for SanlamAllianz Credit Life: death,
/// permanent_disability, temporary_disability, loss_of_job,
/// fire_burglary, critical_illness).
///
/// Wire shape: emits a JSON-encoded array of selected strings, e.g.
///   `["death","loss_of_job"]`
/// The cubit stores this string verbatim in `formData[field.name]` and
/// the backend's `coerceFormDataTypes` array-arm parses it back into a
/// real JSON array before posting to MyCover.
///
/// Distinct from `array_form_field.dart` which renders structured
/// per-item cards (used for `items`, `item_details`, `beneficiaries`,
/// `benefit_details`).
class MultiSelectArrayField extends StatefulWidget {
  final InsuranceProductFormField field;
  final String initialJson;
  final String? errorText;
  final void Function(String json) onChanged;

  const MultiSelectArrayField({
    super.key,
    required this.field,
    required this.initialJson,
    required this.errorText,
    required this.onChanged,
  });

  @override
  State<MultiSelectArrayField> createState() => _MultiSelectArrayFieldState();
}

class _MultiSelectArrayFieldState extends State<MultiSelectArrayField> {
  late Set<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = _decode(widget.initialJson);
  }

  static Set<String> _decode(String raw) {
    if (raw.isEmpty) return <String>{};
    try {
      final parsed = jsonDecode(raw);
      if (parsed is List) {
        return parsed.whereType<String>().toSet();
      }
    } catch (_) {/* fall through */}
    return <String>{};
  }

  void _toggle(String opt) {
    setState(() {
      if (_selected.contains(opt)) {
        _selected.remove(opt);
      } else {
        _selected.add(opt);
      }
    });
    widget.onChanged(jsonEncode(_selected.toList()));
  }

  // Friendly display labels for MyCover's snake_case option codes.
  static const Map<String, String> _displayOverrides = {
    'death': 'Death',
    'permanent_disability': 'Permanent Disability',
    'temporary_disability': 'Temporary Disability',
    'loss_of_job': 'Loss of Job',
    'fire_burglary': 'Fire / Burglary',
    'critical_illness': 'Critical Illness',
  };

  String _display(String raw) {
    final pretty = _displayOverrides[raw];
    if (pretty != null) return pretty;
    return raw
        .split(RegExp(r'[_\s]+'))
        .where((p) => p.isNotEmpty)
        .map((p) => p[0].toUpperCase() + p.substring(1).toLowerCase())
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Flexible(
              child: Text(widget.field.label,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
            if (widget.field.required)
              Text(' *',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, color: const Color(0xFFEF4444))),
          ]),
          if (widget.field.description.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 2.h, bottom: 6.h),
              child: Text(widget.field.description,
                  style: GoogleFonts.inter(
                      fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
            ),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: widget.field.options.map((opt) {
              final isSel = _selected.contains(opt);
              return GestureDetector(
                onTap: () => _toggle(opt),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSel
                        ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                        : const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSel
                          ? const Color(0xFF6366F1)
                          : const Color(0xFF2D2D2D),
                      width: isSel ? 1.5 : 1,
                    ),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      isSel ? Icons.check_circle : Icons.add_circle_outline,
                      color: isSel
                          ? const Color(0xFF6366F1)
                          : const Color(0xFF9CA3AF),
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(_display(opt),
                        style: GoogleFonts.inter(
                            color: isSel
                                ? Colors.white
                                : const Color(0xFFD1D5DB),
                            fontSize: 13.sp,
                            fontWeight: isSel
                                ? FontWeight.w600
                                : FontWeight.w400)),
                  ]),
                ),
              );
            }).toList(),
          ),
          if (widget.errorText != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h, left: 4.w),
              child: Text(widget.errorText!,
                  style: GoogleFonts.inter(
                      fontSize: 11.sp, color: const Color(0xFFEF4444))),
            ),
        ],
      ),
    );
  }
}
