import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/generated/ticketing.pb.dart' as tk;

import 'event_form_kit.dart';

/// THE CATEGORY / STATE PICKER, ONCE.
///
/// The same three things were being written out at every call site: turn the
/// config's `TicketTaxonomyOption`s into picker options, resolve a stored slug
/// back to a label, and open a sheet that refuses to open empty. Three copies
/// appeared within an hour — the create wizard, the edit screen and the
/// catalogue's filter chips — and a fourth was about to.
///
/// The duplication is not only waste. Each copy carried the same two
/// decisions, and either could have been got wrong in one place only:
///
///   * an unknown slug falls back to the SLUG, not to blank. Showing an empty
///     picker over a value that is set reads as the choice having been lost.
///   * an empty list does not open a sheet. Until the config read lands there
///     is nothing to offer, and an empty sheet reads as a broken feature.

/// The config's options, as the picker and the sheet want them.
List<({String value, String label})> axisOptions(
  List<tk.TicketTaxonomyOption> raw,
) =>
    <({String value, String label})>[
      for (final o in raw) (value: o.slug, label: o.label),
    ];

/// The label for a stored slug, or null when nothing is set.
///
/// Falls back to the slug itself when the config has not arrived or no longer
/// lists it — see the header.
String? axisLabel(List<({String value, String label})> options, String? slug) {
  if (slug == null || slug.isEmpty) return null;
  for (final o in options) {
    if (o.value == slug) return o.label;
  }
  return slug;
}

/// One browse axis as a labelled picker field.
///
/// [onPicked] receives the chosen SLUG. A dismissed sheet reports nothing, so
/// backing out never clears a value that was already set.
///
/// [onUnavailable] is called instead of opening when the list is empty, so
/// each screen can say so in its own way — a form has an error line, the
/// catalogue's chips simply do nothing.
class EventAxisField extends StatelessWidget {
  const EventAxisField({
    super.key,
    required this.label,
    required this.icon,
    required this.placeholder,
    required this.options,
    required this.current,
    required this.onPicked,
    this.onUnavailable,
    this.error,
    this.optional = false,
    this.sheetTitle,
  });

  final String label;
  final IconData icon;
  final String placeholder;
  final List<({String value, String label})> options;
  final String? current;
  final ValueChanged<String> onPicked;
  final VoidCallback? onUnavailable;
  final String? error;
  final bool optional;

  /// What the sheet calls itself. Defaults to the lower-cased [label], which
  /// is right for "Category" and "State" and overridable for anything else.
  final String? sheetTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: EventPickerField(
        label: label,
        icon: icon,
        optional: optional,
        error: error,
        value: axisLabel(options, current),
        placeholder: placeholder,
        onTap: () async {
          if (options.isEmpty) {
            onUnavailable?.call();
            return;
          }
          final picked = await EventOptionSheet.open(
            context,
            title: sheetTitle ?? label.toLowerCase(),
            options: options,
            current: current,
          );
          if (picked == null) return;
          onPicked(picked);
        },
      ),
    );
  }
}
