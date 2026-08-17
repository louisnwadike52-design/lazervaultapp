part of 'unified_user_search_sheet.dart';

/// Pairs a device contact with its optional resolved Lazervault user.
class _ContactRow {
  final DeviceContact contact;
  final LazerVaultUserMatchModel? match;
  const _ContactRow(this.contact, this.match);

  bool get isLazervaultUser => match != null;
}
