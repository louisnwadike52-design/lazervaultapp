part of 'lock_funds_list_screen.dart';

/// One row in the status-filter strip on the lock-funds list
/// screen. label is the chip text, status is the LockStatus to
/// filter by (null = "All"), count is the number of rows matching
/// the filter in the current loaded page.
class _FilterTab {
  final String label;
  final LockStatus? status;
  final int count;
  const _FilterTab(this.label, this.status, this.count);
}
