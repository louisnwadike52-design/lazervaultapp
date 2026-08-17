part of 'autosave_rule_details_screen.dart';

/// Tiny pair returned by [_humaniseAutosaveError] — split-out so the
/// snackbar can show a strong title + softer detail line.
class _FriendlyError {
  final String title;
  final String body;
  const _FriendlyError(this.title, this.body);
}
