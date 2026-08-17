part of 'edit_employee_screen.dart';

class _WizardStep {
  final String label;
  final Widget Function() builder;
  const _WizardStep(this.label, this.builder);
}
