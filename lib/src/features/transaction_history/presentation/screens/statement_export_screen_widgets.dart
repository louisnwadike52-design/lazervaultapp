part of 'statement_export_screen.dart';

/// Preset date ranges offered to the user. Custom drops a date picker.
enum _RangePreset { last30Days, last90Days, thisYear, custom }

extension _RangePresetLabel on _RangePreset {
  String get label {
    switch (this) {
      case _RangePreset.last30Days:
        return 'Last 30 days';
      case _RangePreset.last90Days:
        return 'Last 90 days';
      case _RangePreset.thisYear:
        return 'This year';
      case _RangePreset.custom:
        return 'Custom range';
    }
  }
}
