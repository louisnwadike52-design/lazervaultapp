part of 'unified_user_search_sheet.dart';

/// Pairs a device contact with its optional resolved Lazervault user.
class _ContactRow {
  final DeviceContact contact;
  final LazerVaultUserMatchModel? match;
  const _ContactRow(this.contact, this.match);

  bool get isLazervaultUser => match != null;
}

/// The trailing slot of a result/contact row: the row's own [idle] widget, or
/// a small spinner while that row's pre-navigation work is in flight. Same
/// box either way, so the row does not shift when the spinner swaps in.
Widget _rowTrailing({required bool busy, required Widget idle}) {
  if (!busy) return idle;
  return SizedBox(
    key: const ValueKey('user-search-row-busy'),
    width: 20.w,
    height: 20.w,
    child: const Center(child: LazerVaultLoader.small()),
  );
}
