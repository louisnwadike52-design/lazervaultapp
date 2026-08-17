part of 'add_employee_screen.dart';

/// A single step in the add-employee wizard. The set of steps is dynamic —
/// an internal (Lazervault) employee skips the bank step entirely.
class _WizardStep {
  final String label;
  final Widget Function() builder;
  const _WizardStep(this.label, this.builder);
}
